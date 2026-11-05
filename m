Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906662;
	b=1rLtE3/+CrCw4xhNEqBbbfcdvUD5Xwk3ffFG6rFGSVw7jQJqQInpS22CR/V71ImdCd4R
	 d/nRi4OdxjuVUsVOo4iuHGkTUvll5i4yiff8n4yz0n5xJyPfxm5AytoKNM47AbZ6jiA35
	 l8jDexZ9DuRV//KItMyqHPpOrSoVu47usLONHo6dgnmKtfSDtsvFDXw7qVH7NubKH6Bc9
	 vGJidqpHpZ1YJGoy47k+gbYqD1MChL5cICQM/iasGCkjMc8mb5bJcK83Wc2rvZistY21V
	 cpl1HNvJzU5lxTgCKGl/r09/yRmd4+OTz6hxKa4aIGjJFtMqHqCQbElcgeIZDf8eygA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906662;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/zE599gNTm6Haqci8yJ4CUJANnJDy0uSyz7dtrZdEQ4=;
	b=gnTGZo0yeKdqqvpAQ44crGmAL8ybvRke4gDtpzajZdpvTsDfEvjmH8y2pmiDhMskgBOL
	 71uaqLgbgLEnMHVcbbnG4oCiip1NE7J9Dg7Y1+mJ3tvZKRMCldFdICW8MDXdoxSilMVgD
	 S0JJ6f1BMIKkwZmrVf0vh8gSiCWQ0/V6bK1u7Ys9TRAWTIOqMTsgogj23Ci8sAzbSAVOr
	 Hi/RPKlEIe3FxDNgFsclspmmxmw7OpHJD+9+6CDZKNoF8PV3Xe+YTCCvw6kEU8de9z+AM
	 u0VgSNwYFwJFgNtv8w5b4IC9I2RQZaNKLoWef6Uji0GiBpKiO5Y868zdMSABsAw2obQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=afeDp6Sh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Y4BS3hXJ;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59443606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59443606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=afeDp6Sh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Y4BS3hXJ
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9906C140009A
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:24:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 14:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793906661; x=1793993061; bh=/zE599gNTm
	6Haqci8yJ4CUJANnJDy0uSyz7dtrZdEQ4=; b=afeDp6Shd4LsMnD0TfM9GiyDUR
	kLtkILF8SGtvEjK93I4w0r9sDVseFnv+eJjbl4D9bHDrdFunIOU0V/zfhpt+pJHw
	0asnBt+Kwt4tFyjtlRh2rXSxmZh5UrJnV/rP0Zmy5Humfq8EEOTiyU8648Q74//f
	OCTle9ERovP0oOvMv1UkndSGK2BSZ4sqvgDt7B6Vu19sB3vDzuGdvJ2cHy5Ap5V0
	aIl7PotENYQF3J+Jne6tQc415mdRta+g3XvS27z1FonDKFILure3COoqKXZhMLiw
	SOFJcDlKgD2ipvdJdgACGhJQMI+6MR4F11VvsqmKZ7iZYozP/NBcY0fWADcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793906661; x=1793993061; bh=/zE599gNTm6Haqci8yJ4CUJANnJDy0uSyz7
	dtrZdEQ4=; b=Y4BS3hXJyCzhCzODqo/Ad7tLhq/Nd3T0fBF+cTrc5VS7CQCYK7b
	JjvQELRgQeTVeWHXQ3KnQQyiTyUuVzO2f14wO1hHvG+aNEzfdAS6W9gRgfCWFU0l
	mhOnv++h8HjFoymF7HTOTBigg6OBEPJBJOJ/iINV18flswY7UiST4cVKgz86yyVK
	J2yVNooFzRCJvV9SdvKN75O/KqcOLGhsuECxIv2h7fYAlMLwlVMUYMJOiq2nk1/m
	EzjqKaIOWS2vSrqoAtFECaVbyNljWB7U/ZdWqXkc91vZi0nj4WO/VpepmDTmR6ry
	WxplgdY1yaV3/y56gCZaDDANdS+sn8B312Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793906661; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QBqIfCgVl/hvJrbgvCc/WNI08R7PCRdUBzThShx8JJbs2GN
	v+zW78PdjK0kzmYr0xmXPbDCKjMrNY2v1fR0XD0u6ZVYutjuq/B/vMTtMI9Mruxd
	V8+HsrcFXcIesX63kYoJ1dXLc7wi2ILaNgtXnxDJ2fcfZgv9rqYHkyAw5sdzU/d0
	brNYpprNat06jnAQnpyDnVcW9VaeudSA/+3hnZL0C6y928QwTSTY0tw9qgirPCic
	InxHYGuKcAju0xbVdiTM8gl7++NbJlrAQaZuVs5iblRQMjErP+TxZ8Q7As+JalPB
	iMpo9EurwK3+BMRx8FmVeO7lmxxN2aqlHz/y49A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Z+AQOSLtZL1prC8edSRSamRTQk7Oi8K10s5YLvFIAAg=:HqYHqSnPgjjNunJYqyLbnh/5XP7JxPS5NXJhD5rabK0=;
X-ME-Sender: <xms:5dfsai8it5tEggU_954aAViSxOFSBoIGBMlxVEQABJkMdtBytBBw_Q>
    <xme:5dfsaqK_1cxOBkrtwvazlU48Ftg4_-K6FGIoI8q_RgZp4RTpa4mOxJOVWqdNvFmr1
    XNfzJerPsK8piFoaauhBokDsGdzktdZCSPYPvVgwBRl7K3P5sEybqo>
X-ME-Received: <xmr:5dfsalYsBJvBwLFBigY0DfoReNZXVpU0_KqXRdYn2OKzCszEHTRq7ItEr9nj5Q0HpUfFw50JrP55SBzx2nGchPxBCDPHzX9RvhLL>
X-ME-Proxy-Cause: dmFkZTEyv3JGaZymFCuPzeIE1aDU0gKDs0jGQIYR5X3OX5WzHG4Jr53NTnE9Dq8Hkr41Xu
    Qnpwk1aOwnEe1A4lLFzvYfDlA9S4Ub8/ml4g2zlU/hcY94cgJbaE8GHk79lXJd1D7AFEIR
    B6bfh4ZuTe8TOy2RZgGbSVXqnGX78/5+hbNBnzPyys9+s++NTtZxCuMYlQdEDUwF71Jwwm
    tABzE5359nN0VVHice5BTMYcI4pDGvCeVlqZuI4GLn8rZCyfgkXKiWb84CfyQtfoWGZ3Kh
    /XMSQ6dUWgli3r0qKTuBCZAXmUIWNR1BGb3UTwgSHif25DCvMchf5mTucRj3uoMG5uESoY
    brP386RY50uLg0GvrRCMz1XFng+1KL9+wytMyiCQJFQkEMU/y8NfiSYz3Kh03IyQvEYJSU
    5cDltNkInSMwN3//RRGTfApd1/UoHlEbyQ8R/aQaAv5oGw8KgzOETgNKL/HhZkzuVJUs7Z
    Nf3bWLAp3D6HJmjEZYzJKTh2KZ2nY5pR75XPBb/YwoCSZvhp/+JKgNlknwNW8A8CW6LAua
    sJwpuGfmb2GPJo4KUiWv4ycbceS2VhAhrcTHzQqKBQGxsz3daXrEGu2K6z1lj1Z4PtmHzH
    ZXemUa/TkBUdD7+oCuiE9SvfMrQgs/8kvkAWdrAR7XKS6DCy2lAfHuSKz+MA
X-ME-Proxy: <xmx:5dfsakKorhwwIz2BN-1yYWrc3AiwjAgIgeNMh153-mTEVrnLl0RVjA>
    <xmx:5dfsarBrwuRdzMIlMqRwVI2n0JvFHnJpYOMv0Lv4jh5NiAfIokqtVQ>
    <xmx:5dfsahp7WQRRUwmCJSilM7pIbpnLbXgU6LOPrfK5sj363NncA_nCdw>
    <xmx:5dfsaujPfbSfFV4IAa4uzxojJsMqk5Wujs_8M--zeDEiG4CVbIorLw>
    <xmx:5dfsan0o0pzC5ks30DQJRiADPZeto4MYkpoU1jgsYGC8XL-b0g8nav3y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:24:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #02)
In-Reply-To: <auzF3FvY8ahutXw7@localhost.localdomain> (Tyler Cipriani's
	message of "Thu, 5 Nov 2026 11:07:24 -0700")
References: <xmqqmrroxdzs.fsf@gitster.g>
	<auzF3FvY8ahutXw7@localhost.localdomain>
Date: Thu, 05 Nov 2026 11:24:19 -0800
Message-ID: <xmqqpkwjt730.fsf@gitster.g>
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

Tyler Cipriani <tyler@tylercipriani.com> writes:

> One note nit here: --force-if-includes rejecting fast-forward is not a
> regression. It's been a bug since the flag was introduced in 3b990aa645
> (push: parse and set flag for "--force-if-includes", 2020-10-03).
>
> That is, this has always been rejected:
>
>     git init --bare r.git && git clone r.git wt && cd wt
>     git commit --allow-empty -m A
>     git push origin main
>     git commit --allow-empty -m B
>     git reflog expire --expire=all main
>     git push --force-with-lease --force-if-includes origin main

Thanks, will update the description.
