Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913E191F9B
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486229; cv=none; b=osZ00A7FOXFo7KQ9qW/cU1CstsNlOHbq+rKDH//NsC/OjlEKDLHI+yT7tSEx/b5fK6drS36P3UyjWlybEQSXj6L75t2h8dotL+B8rYGOq+rz8ZgvnjLiSuV98lAMBOfRCwWHnPZQy2mnpkceH+byWvOMz+z/M+T4EdmerbZLY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486229; c=relaxed/simple;
	bh=oop70tZ8/lWznbWl3UlY1N5FPs6HLEyxtGT9D8Z5eYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHFrjPZW7yPwj739kwVg1K2xYy2ZAQ13qBjhHSDeyv3i5ePV3md5J2AQ6u+rVlX0YW9CsGFg41g5UkIZ1qxS64YWqV+nu3Gq0rReAIuPXpYHTwL5GUTxE0k2LZKTh8uM6CQu/WkMD6QIRl1CxoIDi4m1sFpA8pJyWDEJKZFPyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sbxc93lj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sbxc93lj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45067254011C;
	Fri,  6 Dec 2024 06:57:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 06:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733486226; x=
	1733572626; bh=nFbaMpX43R38EGxoOhNZ1abY6N8RY9li3TfOdGPN7hk=; b=s
	bxc93ljyLmrNRtAtpuMvL/IgxYdZ5YwreQj41FgYvhc1ltuVu97OHbrhZ9iBLzoe
	zkJq90vb9PS7IwOO6SQa9zVbzE7s08ErY9wQYc3D58DR5PkQHHCbFP+CAmGopT/W
	EIN+BzWHNDvTy8LJMoGRVJCM7dcYaNraajnVr+qcO9radE6sC6nyQQ0YmJcz3Vkv
	nsGTJsrG8Xw3PSvtVpaaTncSK5FO+jGZ0cylnEJO1xgvTlhbXQlMEmZnR4I2YvGX
	FH3UCbvlIwqrVUuRCqmeE2pUSoT/g2zg1lLd5fgVlYDn37g4aPA4FpVLUOmK8eGy
	RqfaCPl1a70SA+8UhZDqQ==
X-ME-Sender: <xms:keZSZyeFIKT0A8AgVQp5OKTmCZcNslI5TrNLjfK3hFPhE4QltJhzUg>
    <xme:keZSZ8PXY_NmnP-VXECJrbgkme8GI-ZjQufcrfe9Y0kxcZY18FxF_2Wgx2xbVOF2q
    jSFpvY7TGaMvZOrdQ>
X-ME-Received: <xmr:keZSZzhogE6oqZfjZdP2EK8-T43fY1t0944k1cvgr8tyTuXmc-2I-aIPiD1YK9RoriBbl9pKre6B433Jki8ck_-n1LyYqvyc_XTLQtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeivedtgeelfedv
    ffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrghrnhhisehvrghlohhh
    rghirdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:keZSZ_8b0rJP-S2EPi_0wi-NJSWir9GRASRnHRDrTxhYl3M0rukqJA>
    <xmx:keZSZ-vJ9BW2Mgu31iY_EzYz_6g_XR6uYWuKzef0OkeSMdTvtaUd0g>
    <xmx:keZSZ2G3LbZaGTQi5vlw-jWpik89_QlQwePMeDF6feB8raplIi_15g>
    <xmx:keZSZ9PLQUJQzWY70Xy_5YrSUJ1CAIHK2FxugCyjiSg0_qSMRzmvkg>
    <xmx:kuZSZyiCZY4iyhyCOSfUhR7tJX5SwT6XWQAXeA8UAwFg-zHGc9S1CQQ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 06:57:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,  "Aarni Koskela"
 <aarni@valohai.com>,  "Jeff King" <peff@peff.net>
Subject: Re: [PATCH] object-name: fix reversed ordering with magic pathspecs
In-Reply-To: <9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 06 Dec 2024 12:20:45 +0100")
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
	<9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>
Date: Fri, 06 Dec 2024 20:57:04 +0900
Message-ID: <xmqqcyi5vxbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Fri, Dec 6, 2024, at 10:51, Patrick Steinhardt wrote:
>> It was reported
>
> It would be nice with a hyperlink since this email is not part of the
> email thread for the report.
>
> https://lore.kernel.org/git/Z1LJSADiStlFicTL@pks.im/T/#mae906ec74d5657e702165e29b90927f730280c29
>
>> It was reported that magic pathspecs started to return results in
>
> I’m not used to this being called “magic pathspecs” as a user.
> gitglossary(7) talks about (magic) pathspecs as filepaths.

Thanks for catching the mistaken phrasing.  It would have caused
unnecessary confusion later to "git log" readers.

The syntax to say that the following path is from the top-level of
the working tree even when you are running the command from a
subdirectory, e.g.

    cd Documentation
    git log :/t

is described in gitglossary(7):

    A pathspec that begins with a colon `:` has special meaning.  In the
    short form, the leading colon `:` is followed by zero or more "magic
    signature" letters (which optionally is terminated by another colon `:`),
    and the remainder is the pattern to match against the path.
    The "magic signature" consists of ASCII symbols that are neither
    alphanumeric, glob, regex special characters nor colon.
    The optional colon that terminates the "magic signature" can be
    omitted if the pattern begins with a character that does not belong to
    "magic signature" symbol set and is not a colon.

and even though the word "magic" signature is used, there is no
definition given for the entire construct, i.e. the pathspec that
uses a special meaning introduced by the use of "colon followed by
one or more magic signature letters".  We probably should add a
sentence to officially define it, if only to reduce the need for
exchanges like this ;-)

    ... and is not a colon.  Such a pathspec that uses these "magic"
    meaning is called "magic pathspec".

But more importantly, the syntax that triggered this topic in

<CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>

is *NOT* a magic pathspec at all.  It is a revision syntax to name
the first commit that is reachable from the current HEAD with a
commit log message, that matches the given patterh, i.e.

    git show ":/my message"

which is a (rather lousy) short-hand for a more general

    git show "HEAD^{/my message}"

i.e. <startingRev>^{/<pattern>}.  There is no specific name for
this syntax.

I suspect that "filepath" you mentioned may be something some folks
(but not me or any other long timers) would call yet another syntax,
which is :<path>, that names the object sitting at <path> in the
index.  Because ":/myMessage" look so similar to ":myFile", yet
they mean so different things, as I said, ":/myMessage" is a rather
lousy short-hand for the more general "^{/<pattern>}" suffix that
is less ambiguous.

Patrick, let's not use a wrong word.  This is not about pathspec at
all, and is a revision syntax.  As there is no specific jargon for
the syntax, here is what I would write, if I were explaining the
problem being solved:

    Recently it was reported [*1*] that "look for the youngest
    reachable commit with log message that match the given pattern"
    syntax (e.g. :/myMessagePattern, or HEAD^{/myMessagePattern})
    started to show older commit.

    [Footnote]
    *1* <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>

Thanks.
