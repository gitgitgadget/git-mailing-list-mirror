Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819920;
	b=2ZgPTdEWYa+PmYbDMeZXyv2KoveIq4CSX8ARzKk0FCkpEXPOEuDwz/X3l9et5uyLjATp
	 pwxHFouBx1yH2paNtxfRJTejhKasq0Vul69YRPgsRXosxGh+OIW0PB+Xm3P5PQTbMCVUs
	 pzWHeuQpFZKj3/SC4GKOX1emb7FoJNv4KxsetW18+1x9xDs+2qSYgYlF4uS3ziM0YjIe2
	 m5TgWzU1r0LvANjT0CWW+tCNbJuU2ER0RkHjb7YD8q02j5Nl3ITxbQAvK+6P6FwtOg9Ap
	 lWuPY3wNmNVMCnfuGNIE+4wODaO8+r1Gg43LpHz7AgWF/kTs1qDd3+Rs1rajvvALtIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819920;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=r/vHTaMM+mNksITVLDWHYl1Mk9j4UK3c9rKdlkguC1c=;
	b=Zp3PfQEMZfCZB8O5mmDmf8so/b3YOWf6mWnjaonDLelTt6/r1SaiPfkqDu4nM4U2u+/H
	 2BgImHQ1v/z63LAedirU6n5TDUeAsbC/V8sIniVSbJS/tluQG+IHMkqlxrl/9dnTYnXYe
	 QHBU9d2qNhPyp80k/cwsP91GII6HcYsFLOX6v0peiupSRsaCLVLyMjsdByf7JdbbH3fqi
	 yr31KhJgDWE6IzIFU3uytrorZaleqkq8dDpE3fmNAPl2mfUAo9cnD0qbB/8BPix2Jh+jF
	 OXmrrfm87OeyYDC73wy+B2U/loN+b+oVJ1r/HyDbF9zRHHew9b7Qq4zR4ftoXnPWw6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="cFfDzm/F";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GJ1qVm5S;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B63606B2D5
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B63606B2D5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cFfDzm/F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GJ1qVm5S
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AAEEEC24E1
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 14:18:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 04 Nov 2026 14:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793819919; x=1793906319; bh=r/vHTaMM+m
	NksITVLDWHYl1Mk9j4UK3c9rKdlkguC1c=; b=cFfDzm/FpLdHD8FguiJSF81T6X
	9ljuhySt6+1h8dNmD8DSy2bNMbEpLe8k1KUFD8j9j6eYW4ZIXYgdYoyJ37KEjpbr
	AFxAngCPp3NKXlppSSjCVf5k0n26aEPuRMCMLnxFTGqhgiGlxUlUPVN0xNxMluCH
	2UfVGtAPavzQZAZtySb3lDw/7zmRqnuuLOxHBuFQMSnmyg21qdNOZI1mV6E9RF2O
	1WdDBvImVdL/CiNPkN0pJ9WeYmDMa4p2tqBjIv9U/jP0Mc5RIAiOsk/ttjDvIog8
	3tJhm85LzAR04XeS6m5cgI9tl4uf8EWbkaernRA3/UH3KBEt7R/Dy9VEdmRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793819919; x=1793906319; bh=r/vHTaMM+mNksITVLDWHYl1Mk9j4UK3c9rK
	dlkguC1c=; b=GJ1qVm5SS334dfhkjDxzCgsAIIF7N20kcOX6ErZNnlxcV290h75
	PNu7hZfCk9FUwtmRyyEefOOiWXNnEaK/gVx98KbQ3+b6Rshnrq0SsI7xBOGaROmo
	XnzDE5bMocvSnsMlifCBj/o03yCgJV4wDcZTWPQ0iA9IUZwxZ9ViT/lfnUzXql18
	vPLy49wW6L/Uet+WPi+iakZGowd5vIVbxCOs2gZDLraqrQ4CTIPgaurmt5TwJ7Je
	sABMI03etN79XawQDl6UM0SqStZWnqSb862OSmPcRqUZI3r0RRm+mV5BkfzXPePQ
	6wBspe6wP8YS6LHKl5CL/uvgE9q/4Evny8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793819919; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RSOUwdMisLhzMhtT1LTpVmsQk6Fk2cqboIQ1dkKv7raDPhD
	YYofauKt5TslgVzgAKLm0TrbahRiPBJaMF3M0mkalrsIs/j7Una4rOXDVY9JgZ95
	pI2vT0dA2MqIdfrVSqJvtSJcrwEHaJndTDxml4yJ+MGXe6apojFR3uofy5B6IZjo
	0msFbotKHPLUZiLoJkdtKrWrvb82GB+qmDhZovX+v3MCfH/WftjicBm8f0OT2fNc
	WphPBQXJbt/5e48fQhXRvuAXpmyTkRyAZE62ebXWnDo60R15uw5hOYiBXU6HKlhk
	PEFhpJLkTUMtByqnV9eiz9TC0vyakifx1JRGVCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Htwbl0qztUuAvN1/2bcLNm8yMyDDUKTEigbD8jxFhKc=:exM4fkgj+CY5Ondi7ZGI1VorThs0J3fYP/n1SBPDRb8=;
X-ME-Sender: <xms:DoXratWdIPI0pOV3qIXsBdOXGxPdmfwCYUTV-7lPkPft2GqkxBOhfg>
    <xme:DoXralCJ3k1Ms7nHVcwo2Hv-GPdAQmz9KdNE1uwcUp_QIQHIrn6bXT107yFh9Tt4f
    BGGkKBFGc5jFYWDqI030wIcEIMXFMKdPaPzU_RsRS3jRNBMOnQ0QnQ>
X-ME-Received: <xmr:DoXramxfXEHDMHKlZxN9-VpX54xzytq6gVNcjCqtUk5dNAzOJPdxpb07eDDlbDOSTvkKe7mqgls6PaVImiToMqi5TN0PaVZu-_w6>
X-ME-Proxy-Cause: dmFkZTGI+8MMQISbwp+dMWbx908svbMzhQ8Nx8T6oOqTJoK+eQywqffx894U43pt/lEg9S
    /Q7+oSZBLqy1ygmDeTXHq+t2a7ZUl+w/fxVH1ahrtG/xX6EFylGBVrKNRo6k4A8Kj8NSQB
    cWLnKrjbuCz+OekeoJ0wyE/OSpAtxhJGp7rMLGSZAjc1Mpusv3EKjApzqq50bAJMmo8rLT
    W7AIyil4S2xSsdQQaOkDbiGarYsb4paPUnRUMBDTPvVnPbk4KfVAZxn1FHLP598DZLUK0D
    QHZx+hip3vRcDgaav+wBvmYZbLr0lZ9oZ5U7H29Fm+k4C7mBtK+84gYx+D/7sA4nRILPOW
    0O+nuHGtJ6qiwNdGw6xQrLa64EYodmLLkmgNki1brWbNUQOCwMy9BR+TVJNTioNANesKft
    mxuwAtC3LhH6SVpCtC2zSr4mPojrWgU4Al9xeGTTYhAeBkl0zhhRZ4eX9iKoiQEqiJ62W0
    QOmmLtqILlF33Fs1qXRjXPqNNr8pWLXwaT0M+GA4YvLK1fVNx9DK4WNvqY96zB3+U0Bltd
    p1vxcZeXcsHB1IJvYVqLWKS7WMymICGjPJ8xmFhAl0ECgnVqV+Z7mzzDU9ocdpIgCs8X0A
    O1tsZH42+EYl/kfPjJaiJmQG9Yj4RQpCCPPniZ8/GU9ykiXMLT1B8BRDIlVg
X-ME-Proxy: <xmx:DoXraqAsaloCHHbiHukBd9ZnKoGgq7cQtfKv5g_55WMpwJFxieb2tg>
    <xmx:DoXrarY7LjFUG1C09bjG95r5qTd5qYTXwUGACO18ZsfN2qe3XgEYgQ>
    <xmx:DoXraqhxrmQRCflvLomqjxDUc4QLUQmnsw39gzyhbV31P2Bp3XWOdg>
    <xmx:DoXral5eFn12Opj1nGZ3yZjDNwN4-D1FkpG1Jz0T0EtyeGzQvmE3cQ>
    <xmx:D4XralLfKINukNqaf0I1svPHkCwAuIvWFjoxWw4yflgCGLx1n0dlqskQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 14:18:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] commit-graph: drop redundant flags in write context
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-4-d013d9401a59@pks.im>
	(Patrick Steinhardt's message of "Wed, 04 Nov 2026 16:57:26 +0100")
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
	<20261104-pks-commit-graph-write-refactorings-v1-4-d013d9401a59@pks.im>
Date: Wed, 04 Nov 2026 11:18:37 -0800
Message-ID: <xmqqa4no1k36.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> In the preceding commit we have moved the flags that control how we
> write a commit graph into its options structure. As a consequence we
> have those flags implicitly available in the write context, too, as it
> already contains a pointer to the options struct. This makes a couple of
> individual flags that we track in the write context redundant as they
> are a simple alias of the flags.
>
> Drop these redundant flags.
> ...
>  	struct write_commit_graph_context ctx = {
>  		.r = r,
> -		.append = opts->flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
> -		.report_progress = opts->flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
> -		.split = opts->flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,

OK, so these are the most important lines in this patch; everything
else is there as a fallout of this change, and as a result, the
remaining code has become much easier to follow.

Nicely done.
