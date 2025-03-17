Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3651C6FF1
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250252; cv=none; b=MTY/4her/+lnDabnTYJOjQjqwF8GkqVSS0KlkzrEBr9cpBstpV1hBIlJyj52PU8dwEUn5iGs/oe3oNy43572J5rPyLz4+T8nhadzgUMomwJL9p8oK5hzlimjXwAnlwc8nfTPnvnyfgYULeQyauoG4olyKtU1UpOt2+f2/8cV4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250252; c=relaxed/simple;
	bh=VcY9/V+ZOgcnk1ESQUHtSGo2pfS3tZlMQtN61S1X5hQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/j+Sbc86z5A6SG8n82j8KjdEvaYnT4QRufOnZM6pQo5OC6hDgK0qSTi4UW4/nY5UvWSP+IVYID7QYA2yQap85Xmgx0bdNdGUMMAxaSQ0ZJ2hTN7yXFQZrDkSzjnyYs40cD5M6ORYVZws571bsxbl2yagGLflwI1TIGMRT6tcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/fh/kcA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qqD+6/Cq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/fh/kcA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qqD+6/Cq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA19F114015B;
	Mon, 17 Mar 2025 18:24:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 17 Mar 2025 18:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742250248; x=1742336648; bh=M7vtfw/tHv
	9EY6jUt1wCPqzXVYimmpJMDshQADL9sGM=; b=c/fh/kcA5DV516EQ6LGQvGGi7f
	/LIhFbBtgzcwIuaXYAjzSeggjd0wv7l0P46uOj9DHMgrYqyIujshdQRUp4ZcxVdZ
	zAK/WDtBhdPofppH/lUsQtaR44PyDoxBKkbl4Ifg+HWOuygcLmQDQrMGAptSMhN6
	Lx6Bnz8VLCi80AoLBBQuMHGtXmQrykr5fy6Pg3WW3y0pS//wALQusuTRa8XM5+ur
	/M0aITNa4p9PIn5iZPk6N3SywsfyYvIIp93cN24Oz95GWKNs4RqqiX4/T5MU5AzS
	Yp7nsCDAfQfw0EstCL+JJrYm5cjTY8FZrioNCvywLgG+VWIL0CpVtyBA01+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742250248; x=1742336648; bh=M7vtfw/tHv9EY6jUt1wCPqzXVYimmpJMDsh
	QADL9sGM=; b=qqD+6/CqPj38HFkOmNS+nN5uGl/y24K8X5iRhR8VisIeeyYUzzg
	1EnAU8K4Qheu8pu6kKUBCznvIJaNpkAXQPR0we19QfQg2C9PPSkKNilSzJbxH/a0
	jVS3lWbjgtCBexvaRkYAyKFToO3XNxLwXPospwe6J7YRcpFAL5DSBYFlBPOdziL1
	KtlVmLw/oYSXaVSNJaXRVE8uzBeCBZ8GtNumamNbKM7PybTbRMUQPcR8VtciuphL
	JfdkppUj9cUxXov4Jcrsji/pW/xgpRMm2H3qFKlnmHRRmsBC1Yc8fwQU+urLveSp
	YfbJe40YEsZN1boLUFDcFJE5+nBUC8GM90A==
X-ME-Sender: <xms:CKHYZ4w72Av9ttHZPxog4kgrPa2qBt4P-VPnFeDFkJhXnB3QqJ2ArA>
    <xme:CKHYZ8Q-l-VQ5kt8GbZIMKGzXfSmPwq519V9nJLJSR6V8CyNxbLf_zOKtmBjjMBmc
    qcAOR2yYOOuy9kg0A>
X-ME-Received: <xmr:CKHYZ6Up2m9hYZLyzioThHaWGKYB6ieSRSery5Z0d6uVNIM6fClNeFBmOrHvd2fxQcnRkcVg_6B_EAyIBjG9xyFIEfhlrAcN0oviB-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:CKHYZ2hlTWCzKDVO4RNoLRZSs6kZQXVGuYX5MXwzF4qLhUQeYgMbMA>
    <xmx:CKHYZ6BhM3LoD_1FqMp3uHWzPVlzrBLMVtk1AhUlT2ctlYOFcw0p0w>
    <xmx:CKHYZ3Lt_AneiPBlqCW9m88v1DltBc80YHggGzbuJNhzf4ajc3n7xQ>
    <xmx:CKHYZxAXu7GCFV_OiAsof8s3Qs6aFS11d_MBTFVfiXVUtEOpmmcgTQ>
    <xmx:CKHYZ1PPNmbkwyeOeiK_kIWOJjgzX8XV6Udl9qCeySSk9paQyy5SbfJP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 18:24:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Git Bug Report: git add --patch > "e" makes keyboard unresponsive
In-Reply-To: <84c3ccdb-2aaf-9b34-91c5-cf5c27f53dcb@gmx.de> (Johannes
	Schindelin's message of "Sun, 16 Mar 2025 04:34:36 +0100 (CET)")
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
	<84c3ccdb-2aaf-9b34-91c5-cf5c27f53dcb@gmx.de>
Date: Mon, 17 Mar 2025 15:24:07 -0700
Message-ID: <xmqqsenb70u0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I refused to release on a Friday (absent any good reason) which is why
> this version is scheduled to appear this coming Monday.

Not on-topic for any particular bug, but do you want to probably
coordinate on what day of the week a release is made, perhaps?  I've
been trying to stick to the same time-of-the-day we established
earlier for embargoed coordinated releases, which is 1700 UTC - 2600
Asia/Tokyo.  But the choice of the day-of-the-week has been more or
less arbitrary picked by me to happen on Fridays for the past few
releases; it seems 2.47 was done on Monday.

Any preferences?
