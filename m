Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9E1D5153
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166577; cv=none; b=okSm0k/jVin37pqBzjQmh1kZQk86goydO5qW8bBF5zC+qrQ2ZgaHaqYK5lOApPo1PlibYUcdsWXGCvU6eiXSkLwvtZdXz5elYjfrXAu3nJrVa6k4aqDl9mar1oPoIcfsJh4x1Nv/Kp/R+R0ERBfsWqKMM/ERt57sNNUYyDmP2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166577; c=relaxed/simple;
	bh=/4YiDdIhf57EHuVWm5bPxCBNYriEhRAsY6fmVmjTLTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiuQLpUijJfgPJqK0L1D3tg1/B16ImHw3FXm6rUvASrIsbCQvUptSkBJ4GPDVX05JwXfk5I74Dq5GuKakHmt5F0mmWVYWQJPum2tFRNloj2m2oCn+9+OPHyELxyFii3lJk8zpREujrxhlgleG/0pyc0ksGeaNn+DavUzAQ7jykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kLsa0vTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4dw13dP; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kLsa0vTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4dw13dP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62F60254007F;
	Thu, 17 Oct 2024 08:02:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 17 Oct 2024 08:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729166573;
	 x=1729252973; bh=tjl5k7xKLdafaaroJ6a5Uao4Kx7oxxEIjKDTcnftIFU=; b=
	kLsa0vTn7YTFiFWZ5yHqF1a1NOxCgf3ofF7lx1yd0ZtVmTsxW3Og3OSATG+RTiQJ
	V/0ol8Db5nZi1qdZ1DlYm17MaHc1U5jBvmzqwSortKC2Hmae71oHTGzJvn9e699j
	jE83FF8S9PDT2eBaOLsGcjKJ/YxsVpfBv1WCgc7weGJBgGZoMy3FFApg4P3VliVw
	ZoKMnGWQiMiiFiwul8pVoNVFgxOEICgWXsrKoEmlg/GGmTXW1Tbfp2ekiXj4nf3r
	RLbkhPIm6cZ5hb/lPoD8XrexMT8MmlaIEZr7F/zEXG0+xYMUkfIegn7qgw38ItnC
	ATLt1Gd9CCbxH2KlRKeWIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729166573; x=
	1729252973; bh=tjl5k7xKLdafaaroJ6a5Uao4Kx7oxxEIjKDTcnftIFU=; b=F
	4dw13dPXGKvD6iMrauABxUeN2HbFT5rPWv/+fh/VvGZxn/480KaHcS4wmClgKFTP
	N294qjZmCffhRM/U+iumkvrLAAEsXTNbMSzAr22RHK0ZFDgFZZQdBIGRAW62bzYq
	PhRGWsHiTIybMqx6M7Orid421lG9cGVJURRT20nPQUcS29QoKgUEGDqloACH+Lo5
	mv29MS528GpClxCrsTt3eMbB17qME9JtdaiMMqJ1lGX4FYVw1NyqAyM0Bogc5Q7C
	WC905UodsU0C8a8M6v+yapbd1YE3YIz++uXK/bvylzExbOEeMd/KmqSR2UoWQ5Ij
	rJhEkmXzSLEW3vSbYae5Q==
X-ME-Sender: <xms:7PwQZyGbt3rMbD2Vvb2w4lg8RjKxENPnpccUAieCu7N-pqifV0R_0g>
    <xme:7PwQZzXP7h3mt5IEZnQVTduJECVS0Cw5Z7KBxG5tdQ0YPsnk_9Y8CG0V24z6mZHV2
    5ZOdAhIYqi5OEivrA>
X-ME-Received: <xmr:7PwQZ8IvFD9rh5pAmN51vPf4DnHVqxP4vFik8qOjSiF3aksabYqQaWmLFDDrPiyGWenDI9SJpdKQsHEccTv_NyFhFR2YD0EMsnfqL0rMK_13BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeileelleduudeuffdtheeugeduhfevleethfdtudeg
    veeitefghffhgfetheeihfenucffohhmrghinhepphhusghlihgtqdhinhgsohigrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehushhmrghnrghkihhn
    higvmhhivddtvdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7PwQZ8ENPIYfT7-qSYs-8MPxQ5buqk8xuRIFcH69QQvle88Ya4jW9A>
    <xmx:7PwQZ4UFHWRzl8NboUYXScJxw1N40iZp2Fjc1FfPxjkwKnM6qZCrKg>
    <xmx:7PwQZ_Nz06DZku4mHArDivEQUDjDvsav6PS7YKwYqH2crcKDPgOdZQ>
    <xmx:7PwQZ_1B1oT2eSt_SqpVjogK8A94h-s5YyqkSV5eD6-pvbPY47KYaA>
    <xmx:7fwQZ2wzHTR0sudUG5Pz77YycwRiZWIxngTAShvRMf9tturoLaetM7W6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 08:02:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9413217 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 12:01:31 +0000 (UTC)
Date: Thu, 17 Oct 2024 14:02:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxD84l-tcU0TrX1K@pks.im>
References: <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im>
 <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im>
 <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
 <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
 <CAPSxiM-Yw2H65+EHoDckU2N2hr+UrXRu5Y2JjXc+TEwEUKJT0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM-Yw2H65+EHoDckU2N2hr+UrXRu5Y2JjXc+TEwEUKJT0Q@mail.gmail.com>

On Thu, Oct 17, 2024 at 11:56:33AM +0000, Usman Akinyemi wrote:
> On Mon, Oct 14, 2024 at 6:36 PM <phillip.wood123@gmail.com> wrote:
> >
> > On 14/10/2024 17:26, Usman Akinyemi wrote:
> > > On Mon, Oct 14, 2024 at 4:13 PM Usman Akinyemi
> > >> On Mon, Oct 14, 2024 at 2:55 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > >> I got this from a leftoverbit which the main issue was reported as
> > >> bug. https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> > >> For the test, I should have the test as another patch right ?
> >
> > In general you should add tests in the same commit as the code changes
> > that they test. In this instance I think you want to split this patch
> > into three, one patch for git-daemon, one for imap-send and one for the
> > merge marker config changes. Each patch should have a commit message
> > explaining the changes and whether they change the behavior of the code
> > (for example rejecting non-numbers) and add some tests. Note that I
> > don't think it is possible to test the imap-send changes but the other
> > two should be easy enough. The tests should be added to one of the
> > existing test files that are testing the code being changed.
> Hello,
> I am currently facing some issues while trying to write the test for
> daemon.c, I need some help on it.
> The start_git_daemon function inside lib-git-daemon.sh is made to
> allow --init-timeout, --max-connections and
> timeout as well as other arguments. The start_git_daemon function in
> lib-git-daemon.sh is used at t5570-git-daemon.sh.
> Basically this is my changes
>                 if (skip_prefix(arg, "--timeout=", &v)) {
> -                       timeout = atoi(v);
> +                       if (strtoul_ui(v, 10, &timeout))
> +                               die("invalid timeout '%s', expecting a
> non-negative integer", v);
>                         continue;
>                 }
>                 if (skip_prefix(arg, "--init-timeout=", &v)) {
> -                       init_timeout = atoi(v);
> +                       if (strtoul_ui(v, 10, &init_timeout))
> +                               die("invalid init-timeout '%s',
> expecting a non-negative integer", v);
>                         continue;
>                 }
>                 if (skip_prefix(arg, "--max-connections=", &v)) {
> -                       max_connections = atoi(v);
> +                       if (strtol_i(v, 10, &max_connections))
> +                               die("invalid '--max-connections' '%s',
> expecting an integer", v);
>                         if (max_connections < 0)
> -                               max_connections = 0;            /* unlimited */
> +                               max_connections = 0;  /* unlimited */
>                         continue;
>                 }
> What happened is that the start_git_daemon will already fail and will
> prevent the
> t5570-git-daemon.sh from starting if there is any wrong starting
> condition such as the new
> changes I added. I am finding it hard to come up with an approach to
> test the new change.

I'd just not use `start_git_daemon ()` in the first place. Instead, I'd
invoke git-daemon(1) directly with invalid options and then observe that
it fails to start up with the expected error message.

Patrick
