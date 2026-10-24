Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860009;
	b=4Of9/dRxpwMiUGlFpUqUXmSLX7S9XvC1iqC4SKKJ6YUzsIfIDDDrqqUSdb6UFrTa0NsS
	 5AcLyUbWxU4lFDdWxeiAnJlXBxcsz+XvhpbbC3rBbBIbd0d1oq3Aqmv5SFUQYmTDLwpdV
	 C9VeI80Z2XjKqPu31L8PW1I7ML6lG/rw+YkUmuepgfQI48ZrMeVjqCUF2Y5ebXxRLBj1v
	 Sd2b4lHj4ANvr+Gmj57qUTsso7Q0andCBWEurDr2Y6kjTbL6puWuLnpA5e+STXsx3RxSA
	 NECohsX9zWPLSr9RhVyIV/ZDLWopOSLhG8xBkrPiybDJjzzWUyQDH8AMRlTXxSMCpGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860009;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=90RaZnS98LDqtvaqKj5pw+uULD6NYy2oLw3WeMUIP9A=;
	b=EQFzqLldFhGEIExJCpGZ8AwzNL22ASf9BVNNpwlL5DBVKiNMFy33gKR2MSBAH0VG+9qz
	 ryLzZC3XDuYOtX0RAamRItEotKUIX1VOiE4T+s761IkdDs/mvLWtIMAVCGoh3JMC+hMCw
	 UydxfFFOla7eguJjkC07LEySmNa92xGzb6Af/MOOtqNR1QvaJr4ZcFKpvpG2RPb14rc23
	 S+A2aCo9uMr/xsnGpdV2BS6bUJgPX5bslRQPL2QDTLcmbf/lRgW8gPtpCfC4w9tp47fMr
	 63EGqmNndXxBVVlFoLvzOmvR6UPw0WYYcrPJCVA/U1ePJje9eeF/es7ln30OaF7pqiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aWY4Au7N;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nAx53r9W;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BB606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 16:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B82BB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aWY4Au7N;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nAx53r9W
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 257291D00167
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 12:40:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 24 Oct 2026 12:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792860007; x=1792946407; bh=90RaZnS98L
	DqtvaqKj5pw+uULD6NYy2oLw3WeMUIP9A=; b=aWY4Au7Nl818cfMgtQJ2B5fj3J
	J91z6O2kph/gH+nRpmQ/gxAyxTHNzCSLN8DcUZp8wcXnsQxQQnnlFDC9I6JS+Xva
	ShcmtIiM/wc1/SXQVo5gQ8Tipt2z3Dn1MWW0KolPlUO2misoFY2sAwkwgwhO+kPd
	f83Gx3wN0s4XHTqWE5KxO6dAXhA/8VglOafWhtgFHOl7MQtFnXkKcb2YdqJpoIJc
	QltxO6ZraKwHhoXfDUsmkFSA6BW+/P0VfB9w91Ljvpxu7rr+x6BAchD5EXGjzFqS
	cVab0vRpb9xTvo6a9CEQckVlhduEoiQdeLnbgskSTDryq0lXic5h/h2XfGkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792860007; x=1792946407; bh=90RaZnS98LDqtvaqKj5pw+uULD6NYy2oLw3
	WeMUIP9A=; b=nAx53r9WYOdOD8GDtu9FUJ1uhsGB9io3qFCeL67V/zBrHNaEaKS
	FesveHJq0Vf8s4/tESC4Rga5wf5Es8QUsZggzZwkYG28b5Alj9pZQSToVFDkqX+5
	wajeeGpFQPRPQdFFigps7GbLb4bxK7ThR0qSyKpy4gDt5A7r8U4IcQj/GDLpwRBR
	19alHdWZ97Rd93NbZbakkzlWqzRIr+F0CfG7Ixdq6mYnLX5T1W3BQ2FKFeEtXx/4
	m+E1E/waFSfVzuaEIuFzf+SW0JJU6g5eelW5ZstqKeYNO0IL1stNlOAI14N1quNm
	HYTPGnBfzIRtKJ3akpuR4BzRkRuplPsiqwQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792860007; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KLNLBO2l66spI8eXKt9iSxFW5Rs8to0y9X5TkHAqRZD1vr3
	YLTzbTK4+fSq/Cv1auQQq8guWJnkMmLBDkdSGH8xQub+vclk7kmawBKJV7Bfuvyd
	kdEgc/nUOZCtTYeUCrj2u4J/EGX7TMTrgXaW2wBZ9l3A+NVsvz6r0AqpVsaHkf8g
	0CxUChVz0O47bkEQhUOOZ/wwRGAWZreNlU/DoyJbtAvVR8sA4IIRE+CNVbnvjSv+
	pz0eHolAoqmKPmQhbeZ1liy9tL2UMQLWsoqru+a8GLh4jrwdmQWaEn9tFgZa5b/K
	OQHsivet2xEOftz6WKER02l1m/1pWU8QvcxRncw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QDfP/hq2P6unGFPLtuJvqNZnx3d9AdKr7MwGr/T0SgQ=:rHwsvqDW9jMqNyLxDplye2DbJpKkpCYBo6SuG49VAa0=;
X-ME-Sender: <xms:Z9_cakAwZ9L9CvlFalDnQXRqsgs9qbpuMpmS-NzMqxxjqaQHoJRXSQ>
    <xme:Z9_caowPF0Xum1DOM69LrVgFU-S_O1hVPClXIOX8s7gevUsxMwtFvwMk3khZxjg_P
    GAueUrPmYES1tJiswlKwefVi21zustX2nUDAKqGffrbYrU7ouqQKbw>
X-ME-Received: <xmr:Z9_cap1CHctP2Iwm0rKtFHvNqbdDe0gRdGN_l7i38UCvMuBWC2I6-BKi2wmFDOQIzroWZMngmUpeckF-0LHKXxg4MeaC2hgd-1oS>
X-ME-Proxy-Cause: dmFkZTFmgAOy4Q6c3A3DJwagzejubf5i9dLy4Asv21Oo5Ha5HQIFwM+zXwl52qNIGcixk4
    WO3vB6KOlEt9iqrb1Q+x06bxs8EOmV3jHFABAjBIQYdLic9Edok/ne+SGfgcKiR1WDwvp4
    VtgcRaAaAyNhlEwU3hVz+cgW7YdRlYy9LqHMFIHSvmsdz5LcdvW0TbPM9xsELKOnVFDFkU
    9kMRot4CHOAIJ5ZWPKT0bBsckPl6WuW87pYt1yH0+hVcgxX7RNmge8AkWtaruREtkCFqO2
    +FHffRCFBIQ/g8cqD76U/I15vgmoHe75H5RSC8zYsjZiG4wXM9sQMV8xLlHHIM0r8Nm9T6
    U2+1kBzyYR6MHfB+qsDR1/+lpsRLtbrCDr53l0NCfRbjgBXC7sLxm4kqq3OujiKEfkVgZ8
    uUE5ROz/KQLc8tUK+GHdF5mhXZBbeaZh3SurSK4beveXvaObIpnWU6Z30F6z7IAbCcLCpc
    w9DmKiAz56gWnAccYZVwdL5/dl2XOQRdRDKGV84+CIavPd8q9lInRlZeu9KVz/UyBtBqfp
    HPhwjeBO2Y/sW0CVPt/CvBUT/U2Q7OwMAOrBURuQcw/TWaNexe2Ms/g9js4bOCniwxBkUw
    KsmrUA3pKLrSjD0ttoxKMoOHc809YSW2+ML+5aQSR7aePrerBg4uycoFN2Xw
X-ME-Proxy: <xmx:Z9_cagzZueIZz0GaOhcNt-ugQIUfoiKG7IM1rs7gc65gYFXD5DCZ7Q>
    <xmx:Z9_caoEG50hEXvQL163OgWvwDts3thIxjG99TXaT8OprIbQNvY6-kQ>
    <xmx:Z9_carYKb8kpeaYtj26Z8rHnjzCH2YlUEMKMo91hqNVfmUqUPspxPw>
    <xmx:Z9_caiBvia8cYrNvZtt4ZOyHrlUmQ0q4jYAMHDIaVaexwv5NC-4kdA>
    <xmx:Z9_caoj2VwIh-lqH3Pw1Bpf59I_UnKN-2wGThW16GXGz-ZC0mVcNv1dD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 12:40:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
In-Reply-To: <bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com> (Phillip Wood's
	message of "Sat, 24 Oct 2026 14:51:13 +0100")
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
	<bfc2b43a-6198-47b0-8868-d92551548f22@gmail.com>
Date: Sat, 24 Oct 2026 09:40:05 -0700
Message-ID: <xmqq5wyr128q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm rather skeptical of this in its current form. Not all commands that 
> modify the working tree update the reflog and some commands such as "git 
> cherry-pick A B C" create multiple reflog entires that are 
> indistinguishable from multiple invocations of a single command.

I like the direction to make the default 'git reflog' output on a
single branch easier to understand without needing any extra
filtering in this series.

'git rebase' doing its work on a detached HEAD was likely the
first, and we may want to convert more multi-step commands to do
so, including the multiple 'git cherry-pick' you mention.  'git am'
way predates the rebase that works on a detached HEAD ('git am'
introduced in Oct 2005 predates the concept of detached HEAD that
was introduced in Git 1.5.0 released in Feb 2007), and it does its
work without detaching HEAD.  Its users grew to expect it to work
that way, but I am not sure how problematic a regression it would
be if we taught it to work more like 'git rebase'.  For example,
because I am used to 'git am' working on the current branch, I
often do

    $ git checkout --detach master
    $ git am -s ...mailbox...
    $ git checkout -b pw/topic-by-phillip

to compensate for the lack of it, in order to keep the events
recorded in the reflog of the pw/topic-by-phillip branch to "one
iteration per entry".  This helps me compare iterations more easily,
e.g.,

    $ git checkout pw/topic-by-phillip
    $ git diff @{1}
    $ git range-diff @{1}...

But the workflow to actively detach by the end user would work just
fine if 'git am' learns to detach first when started on a concrete
branch, to work more like 'git rebase'.

By the way, I too was annoyed that 'git reflog' defaults to the log
of HEAD a long time ago, but the irritation soon waned once I made
it a habit to always provide @{now} or @{0} to the command, as that
notation refers to the current branch.

Thanks.
