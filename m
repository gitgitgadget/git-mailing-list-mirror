Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C86FC3
	for <git@vger.kernel.org>; Sat, 16 May 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889809; cv=none; b=bsdL9Gk0f/XQ6IJtWo1Sw9q87lnNma9NefLVt1VLI5ILIroRRnCAdKwlmfWa0QeXm+Tdnvo8HEwKsaY/7k27lfPChYZIN7XhFYhZLe1mJLMVYJoAXGLycQshIq1ZH/jwGX52SY8woykaX3W/P04Wc5ar4oOv5m6Po9XT1RRpd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889809; c=relaxed/simple;
	bh=nChv0xGAG/+rZfKUUTlZWgeZi99+Xn99jcGJmJQGQ2Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UTgAV03xzNF2JveoSGG0fSbVet9Ax3jeD8tNCE8TUhRAit0rxD0ChdmvzrFc0z66hP6+9eTf4bropOKE6Zuumlar0Lpvp48QWp+8Ecoxtq6+eMIJsWiM50u+ZLABvl0LOXC3jiX7IE7i7P02F9rP+XkqVPmsv9ct1jK5eY6Vzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xoA4bWBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eixILbbi; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xoA4bWBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eixILbbi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CF8F7A0029;
	Fri, 15 May 2026 20:03:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 15 May 2026 20:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778889806; x=1778976206; bh=fY4dAudNcT
	f6xondZMiJBk1tHN6K6QgXCFcfDGfmhJA=; b=xoA4bWBJqvSTSjMjqeci/uGY7/
	E48P3GCvAZHkAt/+PQz0RJrww2we1KzL5/JQ2x1W3X5TcGsGn0pArW/RftH+OLjv
	mM7sIpzRUZCQslI37KVyqF1q3NCOfbqfgg9vjRKhJaLyt52CW5jyXnkgKhROcD6M
	kZxVYgd92cv47mseN2aFADcVOr1lMce+/SU1BlArt3jGeB4QmJ0p9jHmnLSMR+nC
	a5dFtTwe1ShRpfOc6JVXBL4hgi9JaApOPZ4pfR2TtYydFqPi+J303Qrd3wWElwuZ
	Qjvya4uIFD6ZMGo31vTnp3oF4m/x44PKdaQEmy1fEY9q6iwTz9PtZS2l5wlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778889806; x=1778976206; bh=fY4dAudNcTf6xondZMiJBk1tHN6K6QgXCFc
	fDGfmhJA=; b=eixILbbifTjrKPoY+3eJCp6CoRyAeRCWfAmv/FvXXI3hdyA11fu
	eVcrRJtOice/+prj4r/FGNYxpZxSf/1BO+hewqCI7C/SF/9NhzL62BRFXoFNg8J1
	0ToexJVSw+g4AiqLDV+pzqAgVwlbtdBb6yDVO8WYUpHaSymwVP/tcLYaJvq1by9n
	fiSQz94ZTU8QCb6EwG2XiLEWM/Nirmat8HPxDT0/tZiLcgOKs8WKZLaPU2iCLy82
	wvRGVefX0g7nNyttbPOW1U9G8WaPbQLk0tNs+9LKKdVbqixM94mDr6PKI4lUa2As
	hPtg0y499Fyuh9metH8ClMBYE6YlyEPGwCQ==
X-ME-Sender: <xms:TbQHavQsqt09OzT8EPsGts_mJzBEJ9wb7NHIq8xT2YvOFzG4NmhGuw>
    <xme:TbQHanwc97EsJ6qQI0Vae9CjoUMj6f5lwyKyr1HR8t69bEqHRkKQxx5nVFo01Y8cs
    K3Fnur2MiJb-nQHu2YMLWUgKkkzWoAIYzUj734h2Mnj6KCkblcwpA>
X-ME-Received: <xmr:TbQHap2WCAJVT6cVhe-hBISrajvUT2VHSULBhNwvN9WZmRWIzeES1j9JlflImDZGpQa2YuPuThaR5yZgcsY_U9ahBz58ejqeoEybLLuv-KHl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefufhffjgfkfgggtges
    thdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieehvdffhedvueeiuddt
    gfdvhefgvedvfeefjeekheejieetueekieeitedtgefgnecuffhomhgrihhnpehofhdrth
    houggrhienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehtrggrhhholhesuhhtuhdrfhhipdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TbQHat481Wwe6z_HKxOT_B7-LMxWLSrLsg-4l9T2FgrivaqJXIkdzA>
    <xmx:TbQHakWUYzmbJJZWp9EoQAPlkbZkegZbWLX16Uuj6xqLpcNtMDktvg>
    <xmx:TbQHakBtzrpqi4dwQWWbTjSIwOhaubXJDn0eeVm-lUfKSIDETikxBg>
    <xmx:TbQHar4X977lJmtqHSOflJtZqzBqv-5kW3b7a6I3KcCeN3730n2r1A>
    <xmx:TrQHakXV1kFXaOuWAWqblXit8uEUPUnlFYed_oIwZDUrLQWsgSbnpVT1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 20:03:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] approxidate: make "today" wrap to midnight
References: <20260515205803.26211-1-taahol@utu.fi>
Date: Sat, 16 May 2026 09:03:21 +0900
In-Reply-To: <20260515205803.26211-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Fri, 15 May 2026 23:58:03 +0300")
Message-ID: <87lddkcjau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Although some commands do reject invalid approxidate expressions,
> in other cases those are simply evaluated as the current time.
> Oftentimes that is a perfectly good compromise to handle silly
> requests, but it isn't without rough edges.
>
> Let's consider what "git log --since=today" should yield.
> As it happens that "today" isn't actually a valid approxidate
> format, the command currently tries to list commits with
> *future* timestamps.  Perhaps it would make more sense if
> it returned the commits made since midnight---that is,
> during the current day.

I actually am of two minds about this.  

What should "git log --until=today" do when you run it in the late
afternoon?  Wouldn't you want to see what you did in the morning and
early afternoon?

Because we cannot define "today" as "--since=today means the latest
midnight and later, while --until=today means until the end of today
[*]" without introducing an extra hint to calls to approxidate() to
tell it who is calling for what, it is impossible to give these two
sensible behavior at the same time.

    Side note: but because the existing history is all about the past,
    "until the end of today" is by definition a synonym for "up to
    now", so defining "today" the same as "now" would make "until"
    behave just as sensibly as if we define it as "the end of today".

In practice, using "--until" to *not* truncate at all (which is what
--until=now or --until=end.of.today would essentially mean) has no
practical value, while "--since=beginning.of.today" does have more
utility, allowing you to specify "the last 8 hours and 50 minutes"
without knowing that it is now at 08:50 in the morning.  So I am
still in favor of interpreting "today" as "the latest midnight, the
beginning of today" because that would give us a more useful
behavior than other possible definitions.  We may want to strengthen
the justification behind the chosen definition of why we chose what
we chose over any other time in today with something like what I
said above, mentioning "--until".

Thanks.
