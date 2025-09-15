Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7C2ED846
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928847; cv=none; b=uiMhnNromZtiZbZ5Pdmmgr6igkg9jhmtYPbI2ULXEdIIUnbpD0kGBDI6AfBjh+Z9xVc6rtCMhr/Lte1+p6EQSX/KyI0BHndyore9/VinLPkYuoYU90Fv5b53Qvscyu7IurYis8YohoKlSFx3DuJQq+Y+bUL4gx3Drf2OazY4M4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928847; c=relaxed/simple;
	bh=HfmmPz5XhyRhztCV8Jq2Nv7Lh//tgKocTAj8e+5QM0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNVQrrx0hmndJYQpvZdMy3ofJlMMYOhgR7PEfMzajKcWTlfvQsP6nYPnuRdlhYDUkukl1i6G9OATZjVU+p8Zz5s0YYoqKKHZxIRDiBNzc4xyA09W4dg6+EtQpwW2crs82ZzxDbsu8EnEWsWRH/2eN24edia+zeS1yPH1bJOF3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ktkM9yp5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ka/zlAkY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ktkM9yp5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ka/zlAkY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E05614001C9;
	Mon, 15 Sep 2025 05:34:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 05:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757928845; x=1758015245; bh=GB2/yge7UW
	yqZ2H4vTj13WavPy//zUgpCxPdpS7DdlQ=; b=ktkM9yp5TjSBhZfyvWGu1R/Zw3
	IKCcZZpE7u3qTVBVacL7SclRvMJXF7X83PyLFqJuDxsJO4ksWKm3BqJ7Mc82YBqg
	lKZjrzXMm3Ee2B7pxKw1SuSAvwn3eLFC9RW767rEl30xXPDIQHfb275WOMz2YBqM
	mxatBhaCo6YG8VfKxoDLHCV2X3I5AqM67pm1K3+NF8HdNsKV9LsogoR90mtdR4vz
	H+7CUW1hZFoKCtDksKN9S1BHgFHfc7B1ePycdROFbW49J5natGGL4tjqrrsX5oVO
	K7pF3xe1/ohdYWx31fgQmbzDcTeaidRoEaXHnwwkmpimKKUvLS7T4xvJ1Psg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757928845; x=1758015245; bh=GB2/yge7UWyqZ2H4vTj13WavPy//zUgpCxP
	dpS7DdlQ=; b=Ka/zlAkYvZskhJxQulDijiWF7OMI7mYSqXcWcAOrtPIRWtT8RXF
	ov+A4njmMF70JYiOl90wEk6/K04yB/IIL3tRACcbmZQjeg1QoPkOOF7EOUZ4d4/4
	OdyBr7NofuIN28zb0+pqb0nWP/9Q9anQ7PLN00aUmykEkLkaK7IniGuH9I6cDjyZ
	9TGyr3sxjkzkBRaBN6RpjQSydQilhUx3mQuTvq+eQ2knXt5B9vOkZ8f6EaUeiG++
	H3srG6ZUHD2GpN9gkZZlJITzACcxTqtIwOaX+PISFNGdReYjR+PB2UsF3JvyBWY8
	JpIyryRsKDO9MlEeppwocoPUv/HwjiJlrIw==
X-ME-Sender: <xms:jd3HaNucmjraHq6PvCXoW2s4Oh21uDwPekxzHhkYEFCGnpuc60Yu0g>
    <xme:jd3HaDZJMvTKAgQ1k1QJiRAtNBsr-BFb1uvL68nUuxf9jf2lJRMSRd3D20Z5EXUEv
    uB_W1s4BD8B0-1muw>
X-ME-Received: <xmr:jd3HaMbN4O1c-9BPiW8QQbsuXM9ZnIWWZvDq43y1S1usjcvLhHHz-75uxZExGXAAyrOSKXs6iXbQjco4-oMSxlwIukKBxELrD-5UNMyYIwC4KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghp
    thhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorh
    hgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:jd3HaMkPXtBfLExcnshySzswyDWTl3dhHOCvCsnGXcvH6N2_5kW1Iw>
    <xmx:jd3HaH1MP_aDDHr0UvXhwvTHIx36ux_EFopeMw4k7bnUdqp0bhyVdA>
    <xmx:jd3HaM0vqyP69kuGPNcOAznIGBk4sWPLXbUPrtfsGjiVz6vdb9r-6g>
    <xmx:jd3HaJpohQZJGEL0cn5VUlqsVRk991eEz1bGrQ6wEgBB1YUIgQoIxw>
    <xmx:jd3HaJMfYX6zpyayoCKOqHPgTnDTgVblqHPDmXTFbGcFGquTLwm8tLx6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:34:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12cdc6bd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 09:34:03 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:33:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
Message-ID: <aMfdh8NxUj1v89Uu@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <CABPp-BHeXtJPq7BE1UZ+zH0C-9VzQcSYRo+t0P-KWth68Zd94Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHeXtJPq7BE1UZ+zH0C-9VzQcSYRo+t0P-KWth68Zd94Q@mail.gmail.com>

On Sat, Sep 06, 2025 at 11:46:48PM -0700, Elijah Newren wrote:
> So, this brings up a question.  Should we have git-rebase &
> git-cherry-pick & git-replay & git-history, or should we consolidate?
> I had envisioned having git-replay consolidate both cherry-pick and
> rebase functionality into one (then got pulled away by combination of
> work reassgniment & multiple life crises hitting at once taking my
> focus away for quite some time).  But now we're going in the other
> direction.  And further along that other direction is another extreme
> -- just having these be top-level commands, e.g. "git reorder", "git
> split", etc.

Yeah, we should consolidate from my point of view. With the current
status quo I'd say that:

  - git-replay(1) becomes the home for all plumbing-level functionality
    used by scripts and on the server-side.

  - git-history(1) becomes the home for history editing functionality
    that is user-facing. Potentially, we could also move (or rather
    alias) git-rebase(1) into git-history(1) to complete that vision at
    one point in time.

The main reason why I propose to introduce a top-level command with
different subcommands is that it helps users discover related
functionality. If we had "git reorder", "git split" et cetera as
separate subcommands it would be way harder for a user to find out "what
commands do I have to modify history?"

In the worst case, users can still create an alias for git-split(1).

> In a separate conversation we had (and I hope I'm paraphrasing
> correctly; if not please correct me), you mentioned you wanted
> git-history to be the home of history rewriting, and viewed git-replay
> as just a server side thing (whereas I created git-replay specifically
> as a user-focusing thing and then Christian changed it into a
> server-side thing since that part was complete and enough for his
> purposes).  But if git history is the home of history editing, how far
> does that go?  Do we have a "git history reset"?  "git history
> commit"?  "git history fast-export/fast-import"  "git history
> filter-repo"?  Or is it just the home for certain kinds of history
> rewriting operations?  If so, which ones?

My take in once sentence: git-history(1) modifies a preexisting sequence
of commits. With that definition we rule out:

  - "git history commit" because this creates a new commit on top.

  - "git history fast-export" because this doesn't edit the commit
    sequence.

  - "git history fast-import" because this imports nonexistent commits.

  - "git history reset" (which I assume is an alias of git-reset(1))
    because this command doesn't only care about commits, but it also
    modifies the working tree depending on the mode.

Something like "git history filter-repo" would probably be in the
picture though, as it matches the above definition.

I was also wondering whether "git history" is too broad with that
definition in mind. At one point in time I though about "git histedit"
instead, which may be a bit of a better fit?

> That all said, I'm a big fan of the idea of incorporating more of jj
> capabilities, and you clearly marked the command as experimental
> (thanks!), which leave us room to adjust later if we don't like this
> path.  So I don't want to serve as a roadblock, I just think it's a
> useful conversation to have...

Definitely, thanks a lot for your thoughts!

Patrick
