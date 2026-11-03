Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708785;
	b=4EIrUxwZreae2+scASkTyCtOWc2lHB7BNUneGJ+AJBlSDSHWyGd4dudZwMA0syzP87d6
	 aSVdgCETvr3uR6BLn5bXXWA2W/YBatTe04Zks6IxBODAMHfKSXsfpYQ2mQYjVz/I6nbPY
	 kPP5ZwwPb58xFsoHGmMxL+eB+8SwMgvbtO/nL3OI8lrVxtNmhfWVnQhK03myfReuBAvtJ
	 fpAhi0mrEiyWZvP8i21pRrnastRP3LseC25XRcYGqF1jA0v7Zs8TJx6fbAyZxVqwJ28X+
	 DONYJoHv6m2WaopmNajErauuT4bPtBKqiyrKxVRDsnS1UH0W3tzv4PPXqHI5hcB4c/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708785;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v+tJIZzupFWq6wkcdj0a8214fnQNKN97jhGqoAV2ZAs=;
	b=ufJulbDe0p3EqxlGymxfYjtd/OwAbBJR+qZyBHJcyTQfP7lVd6DTIcHBm+Lie5rskOmw
	 Mnu6UvPW1kD1BFv6UBjVyGdNnhAaQIVVjDKULn0qdpibNwEGZGAt3kmHuFVR2n3ygp0WK
	 L9sB7k4v5NzXeshV9b0RiMa8wRJr0+ZHq2xO5iBPZ1HK+dopDs10izIuSWEqqmsJW6Acy
	 l1kovsfFqpH7e5FXZESjlMCn3+4p0JsMG1FwvvJuft4SvZsS3vAh3iG2/VddjTSpmjaC0
	 6LGAIMiCGqeVp0cZRXmT2BsaIjn8hPkGUOMsao6aeHpl5b8hdKTUdS/4bJjZo0g/RoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ofl80mDb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="cw/VAJtf";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD8606A327
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BAD8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ofl80mDb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cw/VAJtf
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 856557A0221
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:26:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Nov 2026 07:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793708783; x=1793795183; bh=v+tJIZzupF
	Wq6wkcdj0a8214fnQNKN97jhGqoAV2ZAs=; b=ofl80mDb5NTkAmGnzwl2X0H4Y/
	kdHvmyXxfzRvebNqPv+zXpJ1jkbtf5TJC2NXabHOHg5dZxcO9qlRNgyFa9MLXfhX
	Yet5kSURsooKUBrrQ730xRDlXwUxIaCpgPPBkb+i1lgMcERptuvsr4bM8/MC6Um0
	VjT7vfunzpJE9QLhByFMv7BRAJcHv5+x3SccCgFV9wCmYIyKx28jrCZBtc1qMRtz
	xVWVKSti2iUc7s4tPJ+esnaY5WE1sKDrTk1G2jUZo96tOKBy925K4aoS5Cn1VFQs
	pt3kLmNYVJamiAHKFH7bDSWYYf70UyXUoaY1UV/NCbDZQY9Jw5Pe2KLXBuwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793708783; x=1793795183; bh=v+tJIZzupFWq6wkcdj0a8214fnQNKN97jhG
	qoAV2ZAs=; b=cw/VAJtf9eYDtSUfShmUwhnmqw45uo9ds0r9XGgY69bwyt5GRF8
	dBPUK781CP8kdEfjVecxvhNZytqv0QZtulrBQgA6XhjirA/0qoFz7GRoCS0b7u6u
	RJL4fnPgAUvMJvSFQEbbGZguahCChZt26OOjxnkmheQjYCBopdEt4+EK5qkgt71l
	fI2FAIvDaXGsBmNP6utKhicx3Y35Y+rsjmjuo6PcTkNslslkuCxU/RQqLaD+O/9w
	iV99R4sycLKvh5NOZsIE9R9YrnuvUYo28uqfn+64uDpUyFRsCpbUMI5LL0Hv4ly8
	YwZ4i/rrHL4gWP1FW2yE8HBXFXfV2z1U92w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793708783; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZpzeVZKO4kxWSmovXcypBtvJwGx+9R9pgGSrWAsDyL01cFW
	KKviCTycFa4JJ74JABx7nALk/RSwyxWm5Am12Zqwzozw4L5O18ACLXOsZv7pqs4Y
	SiLiFHu8dEywmqeZi1tiA9OKNhlg9Rj+vC0rhwI1SXxUaloYezVhQAXWeINyUbFk
	XxJrRqqCp0rw6qYYR0Tsv08fQFnWPkmBy+3/thmdvEmOrfmfb9LRT0muX0BfLgFR
	QJo9u8ktROXzdn00NBs0Krjz0yhQnFJ1MVpG9SdP5mq99BbN7v/TAgLbffu9eGb4
	Riuk6sVGfvrFXj85wS1yVTXDFR/Oa3pOcRgwj3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:UzA8DFy4pB1EMvNpAqt7tMjvWNmqe+xS4YkT8FlpA/Y=:Vo7/BuOJNWzspye4ay+AEIlmmjvZi/zmW+0ss2B9hxA=;
X-ME-Sender: <xms:79Lpap6oyVeibqpitRy8ybSlcVCr4i1pd8E9TxTIkLBRGRpfbsmQ8A>
    <xme:79LpatylLx9uH5ff4-QRf6RpOjZeuEzS15nCLNlpH_-Hi-BnQhGIOYosLgmeeNat6
    -k3TtEdywxekvXOGHblfopV9NzElfQbUXDUgPLtIfrYF2in0KkF2w>
X-ME-Received: <xmr:79LpaozZL2hzZ5-QhtmWYsSAIPHa969oSZ9gYlMNIkOEybDGmpvb0A>
X-ME-Proxy-Cause: dmFkZTFJC5pA4CWxHqAUjdZsihAE7z1lAdxOzh5f4UfbB3XTdSKHyMP/B+OUZwKoyuJvFr
    coRrGDu0ttXijmWkuMMWar37aGOOFtvH4Hr5ymP+11I7w/GxaeRBeTCyKKZfqXgH9KDKdm
    xu85KbLXVY1G1HaEb4FMy/0gKOY7ZXE7iLg9JOVC0ciZx1xePP638GkctAoHwWe/HBqnUG
    kh8f5ytm7HJgtkT6DMXfkewOkQ7M9Pcca8/E1pZL1oDQat5kEQhn6EkSzkdC97cViQ/Mg9
    48OILXwSK6y10CJEhaSOceU6ABoss/9b7IzXXu2lgDyUNz130SPTOmqf0A99+g2birl6W9
    Ym8LyxwFyTcjiRl/oYAGSiUvUMXJ6/dhs0y7BI9/t2Fex+Inr1Ab/gvEPZzAX4Pk5iACoq
    W6YOdc0eIvamQdUPuteq3o6GKWigG7ZlyeI1lMYdSxF0oLrt5OxvM73MfawKJBa3QPHh0Z
    BikBSzBwb3r26OYhuuOycs2BVBAtmmBBG+WLx1y74HHJiz8arjyfY0aKG1av2Yx3nGDPPX
    byEqN+TC+ckxHkgyz6rK5D+a5Dh3RbSnk1PYhg+R+7H5Vh060IyDA7LZnjDZUKLIbLfBSd
    /fvYyZR+MKxxPYe6cHKbiisM7FuyMMfADwC1h1JBqX8V+xWQNwh98SjcLnFQ
X-ME-Proxy: <xmx:79LpatyShNQz87CxIEHeA6aZKNCnjpDFH-ADq1D22FiAupIt9d20Mg>
    <xmx:79LpaqbsSfg2lzTis17GYxtTuB8YzcssQ_35AooLIjfzpB3GpjjuMg>
    <xmx:79LpamVAG0Pv8uZP4Y7mU8wdj4ltEvLWUrrMf0nqR_O1RgHRpugKNw>
    <xmx:79LpaghxylcuRU9sDdkKZiHd7_Ag61fsE95E7VjFcqc3nQX2qxD54Q>
    <xmx:79LpaqRgQaDo1ojlwBGwr5wzEQ-Zz8yJRrATwHyxKvCb9iQ9T0nZcCLk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 07:26:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a266ddfb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 12:26:21 +0000 (UTC)
Date: Tue, 3 Nov 2026 13:26:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
Message-ID: <aunS6dE0B-JAJnBk@pks.im>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
 <aum-34I8KZvTfDRT@pks.im>
 <CAL71e4McZzVJqFHnmpoQkC6+hUkhz9_HtEy7dqC5rDyXdV6oaQ@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4McZzVJqFHnmpoQkC6+hUkhz9_HtEy7dqC5rDyXdV6oaQ@mail.gmail.com>

On Tue, Nov 03, 2026 at 01:05:29PM +0100, Kristofer Karlsson wrote:
> On Tue, Nov 03, 2026 at 12:00 PM Patrick Steinhardt <ps@pks.im> wrote:
> > So this here isn't fully correct as it does not account for all cases.
> > We'd have to read the object storage format extension to figure out
> > where the primary object directory lives.
> 
> Good point.  I can rework the patch to make it easier to integrate
> with your ps/odb-object-storage-extension topic, by having the files
> source remember its default object directory in
> files->default_object_dir where it decides it, and comparing against
> that instead of hardcoding <commondir>/objects in the check.  Then
> your topic only has to change how the default is decided, and the
> check follows.  Something like this, if you want:

Note that this topic is already merged to "next", so in theory you could
rebase your patch on top of it now.

> > This makes me wonder whether the better fix would be to stop modifying
> > the primary object directory and instead we simply append the quarantine
> > directory to alternates.
> [...]
> 
> That does sound like the cleaner fix.  Since you are already deep into
> this area, I would be happy to drop the fix and wait for that instead.
> I expect very few users to be affected in practice: mostly git hosts
> with many hidden refs, which is the case bcec6780b2 was about.
> 
> In that case I could send just the tests, with the hidden refs case
> marked as test_expect_failure, so that it is covered once a long-term
> fix lands.  Or, if you would rather have a short-term fix in the
> meantime, I can send a v3 with the change above.

I certainly do care about this case and would like to see this fixed :)
I'd like to get Justin's opinion on that proposal first though, as he's
worked on transactions quite extensively over the last couple months.

Patrick
