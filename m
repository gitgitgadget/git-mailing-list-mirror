Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400938;
	b=GiXmx3c7fKzZ76VgrXyTzmyspZ2ibdlSLEhMLzOkn5o10ZRCGP0FAJ2Xk7BV/m3qRnJa
	 S2E5u3xGTR5NPeBsUKyf+8HZ4gbSBEIOi+i21DjzI/uTnF/dSS6kiiet+xKHSiSUirmQz
	 q1Gvm7GUcm0lOakDUumu3R8GwS9fU0HvRD58m6Rt7fkx5wbKbC9bC7dKbw0ZMjgCa9HPp
	 XBbp6YsumAlusVVHU86FcOGsSlgFy7n0We0QdVbDIi/+vnbDnh5CYSbCDJEd8k/kU5m4O
	 m8Jc0LcHDtPfq1KZXWkEdcuAY+AuA4tlSgOFGIALb0gCOEYKPo4CgGDQLorxvjqbZPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400938;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XVBtIUx+rQuv/UpG1JZ1OidJX7vOQbEZJjAEp8bKFA4=;
	b=I+4kBB4v+e2WYJs/ytZK8LSrW7/QN84MLh2KuGrhiVbpnVD7DmT7ANOcsCvgXEI8RLou
	 jYCOp/BQq8b9YfKeew1VoaRNkQzZLpgH5GoD/8De2d1fp1Vjati4qQCy2WqV9vblhRqtt
	 FCI740+9TP2RXO4TtqYDrcWXR+gRcOPeSgtLbM3IIiI0EYk4uakRiknwc9P+DSanUBABM
	 NmaX81kNOVKraVftjPwFIg/4zEnqsheB0tv/zscp+7oF+xY88TK8STWmxslMe1MawGDq6
	 Je3PPTr68L+uBG5j732Q2KQDuz9Fx6I9DII4NxBQRrdWPajeaIUmaAr+LEY4XqvZ4jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IpVT8GE2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dZ2z1ry5;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB54606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 22:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB54606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IpVT8GE2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dZ2z1ry5
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F1E8140017D
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 18:55:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 18:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793400937; x=1793487337; bh=XVBtIUx+rQ
	uv/UpG1JZ1OidJX7vOQbEZJjAEp8bKFA4=; b=IpVT8GE2VrwpbvOBOXRU1/0ZjI
	EdDKzhqq5f3XCFhOHFeEEjHhbJR5ojmOkI38RYDH6dhbVNsnsIvozZ1Z2nGso4ls
	0M1x11tBNED/A77JoG+ugY2EL3ZXE9BDvdU7lb1vgbuOQ9eM4TqSm0D4GCunGnhI
	iivppJwXUq10tg1phX24H6X92hcTeGsM8KZoQHYWXctjSbQCFrZ/J8gSUL3+Ru00
	Ocs6Vtzr1J8yr45tp3h2dqUTgk+HpMWYMM8KvGpBqRX9YUpsD1s4LdUT13LC4jIg
	vmOXqjduhvsPBFCrcNE9KfSZH7lKRAJJ84sPXH2Q8lgYhqTEXFMcLdjjTI0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793400937; x=1793487337; bh=XVBtIUx+rQuv/UpG1JZ1OidJX7vOQbEZJjA
	Ep8bKFA4=; b=dZ2z1ry5MoOAhSlL8VTPholuxIceyYYag5b1LLM/FGjlv7Cq57a
	YwkkuOmCMDTk2k6yG7jxCS5foJEzMrFeiWNV+It6qHrd5ULWQGzdzZVFSqs4hi7k
	eyX/y/GCiHTq77t5FXs0O9Xvjvq05jX6oUsW3iDjBWfFEj7gzCIKoze6CtJC93If
	NdhB/rSiJAGCo9IzG/O+qKEW76UeWVyQnWu3UmqiPt6celvuRr2C/zNfJ+klMAXy
	KV2TJxGHy/DbFuk0BudUWiGqsk0KwnJOm7XHoLZ80RwvS3ksUBZoZUrS5Wye8Hvp
	mXUl65p2CfgMsw6sgS905SfaEeq/XxDF5cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793400937; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IPDduOtYS23Ra6VLfiVxJpmGb3HdfTQCYIv7sbrzSxrCyx0
	JwcvFzWiFsaJzYL6oD7TTJhWJ8Vj04HD8r+UDuIVCuTsQ2qbYz1dEeBpMQMX/q3X
	d4NirFbqypB0BIxLpp8nfWWVGosTp22QwHMb2xr3Z812ou0Jc0mWd+8U2KINVT84
	TmJX7gnZqN/Pnxxei6GD3V7lXhgNVzAOH69JNqH8c8b/H8oraBHEBFXHokUxl7ef
	CBNoPE6Wpwlqqp/68oT643Rm9/e1l6GFgJvjUw7KezTyKc0D+SGBLCU9Zb6M2JOz
	HzDoCR/lnkMPdbdiQDLW/f8ptg0o0xuNuiYGphw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:uv92Fh8ULw/93xSKXUR1ax6lqNQ7d8awItISxFyN6qo=:IsUll+WWkC1KHgZq2+l4YBpD6z9khLGM90ACcX5rwwY=;
X-ME-Sender: <xms:aCDlamXFcQdlR4uSTuJLmyM4FC3cin6do0J_F4EX0yRdb-1yqce_OQ>
    <xme:aCDlahrFToATSCi97MAqjSaSZk5WV1-bMkMLt-MKIY_s7sEII6czTrxAGptiEvAXE
    nX5-cadqSoH2X7C5cIycCXUWSjDatPfByB2hlIfjh320os-pEGZqdI>
X-ME-Received: <xmr:aCDlagkGJDo_KA_7v5dR8mfgLdoUqWoaYlYz3kO8uYUPXdz6xu6UQnMqIW37T-mCGrPllPJVGuak_3kEJ3_rUq7AkVnCGlitj1xr>
X-ME-Proxy-Cause: dmFkZTEADJqVogqXxASPzNMgJRNNCx3PIVcP0l1M9uHaP8m+tmtBjhlMlJV6or0yfhlUuC
    +L5YiX78MwJRKMmThEHSiBOvPtPKduOger+qLkx+ZotAH+QZzJn8SaAfvpxTJ2JCPmDQSk
    QxR7nHBqe1IWBwHfy/YmM6j/s5UDfFu7co6GPlsCu7+IrlPGwlhVc6cohLEMPhaqOWal/z
    m0a/jd2+6+Epk/rQMDEqnEIxWa2kktm5sBE8S0awmkUpxEn2VKKutJLXu5ENZvkUXS8Jpy
    jXvjRiTGyHMAnEamaRdIAQJv+RudBFUKz1eH7MKwMrDxqjqFuDztL0bn4qvuvj8H1QL+JY
    /Ozj4c3c/yEJq16NDvpaqzrOI0QvjDgxe11yA3sGToAQMMyTJMUyy9JmnT4mvxVLGjjfxy
    thLBGJw2WTB1Cf8RZZ8rLF0qnYABzidIUM4q0MR4gL7sO2dk3Sx0OVs6rqnH+Zp4ElmQ+Y
    fDoeopGRjt3MtZ0Kz8+6wAOk5/ZprdAuUIN/goETDlSTGeQiXfrdg8R9fv/Vrspczw/2xK
    e5QfocQ2xLQClF99xb/pAI3Xi9VKx/Vw/jl7QnmR4VDJc+Gp20PHQRET2IBxyr1CN0BrCl
    v83BA6CRb1UuM4j/aCukNM8cGzjS0oNNeqETQp9TQevjzXKqMgvf81AZWVdQ
X-ME-Proxy: <xmx:aCDlap3F9_H4n6ds9dA0ZkAA68PHGl0zIYTB2HgPRuBKIkHWTcxkGQ>
    <xmx:aCDlalTABB3b_9PFsFXWHQPPY_X8ptBe16bX5MufxVjDPViJhg0uhw>
    <xmx:aCDlaqxZ-aX_Fb6MjlHqBIIMwROv2ZSgDYNF-OX_CenpblC7ocF4ZQ>
    <xmx:aCDlatAGDwf2v53zge4dsxVEpI9jaxqEl3C3Ok2_J_Y71eNnsubfdQ>
    <xmx:aSDlak-_L_6vBCIKbCfjytqAVu4YprACvvzVINBniUnKWdSWHLrwZZfk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 18:55:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  kristofferhaugsbakk@fastmail.com,
  ben.knoble@gmail.com,  haraldnordgren@gmail.com
Subject: Re: [PATCH 0/2] worktree: treat a branch being rebased or bisected
 as checked out
In-Reply-To: <20261030142137.54750-1-me@jaspermayone.com> (Jasper Mayone's
	message of "Fri, 30 Oct 2026 10:21:35 -0400")
References: <20261024165311.57387-1-me@jaspermayone.com>
	<20261030142137.54750-1-me@jaspermayone.com>
Date: Fri, 30 Oct 2026 15:55:35 -0700
Message-ID: <xmqqmrruu7bs.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> This replaces my "git worktree list --branch" patch [1].

Then please label it as v3 as the old one is v2, or it breaks
automation.

> In that
> thread Kristoffer pointed out that "git for-each-ref --merged <commit>
> --format='%(worktreepath)' refs/heads/" already finds the worktrees of
> merged branches, so a new option is not needed. What is missing is
> that %(worktreepath) ignores a branch while a worktree is rebasing or
> bisecting it, although "git worktree add" and "git branch -d" already
> treat that branch as checked out. Phillip agreed that this is a bug.
>
> Ben then asked what happens if such a worktree is passed to "git
> worktree remove". Today it is removed, and the rebase or bisect state
> is lost with it, if the files happen to be clean. Phillip called that
> a bug too, and more likely to be hit once %(worktreepath) reports
> these worktrees, so it is fixed first.

All of these address great points.  Thanks for working on it.


