Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902694;
	b=aJWK8CGWrVnap41bH+uj0G/O+mlqQdZNTWmJhtDFQx8rrCPlWLinQrIMQfnpG9INfwUf
	 Hxl97lUlqvgGr8VUq7/NjDBiZ+Ly4P+rIW+kM4HqBMd8dnJqrdVo2Dcqypvt7viOHKfat
	 OjU/URN9ROuOwql5hc58Sw8XMnYYR5di9BiGf5i7Kmzfd66EJDOX4tk7KuBffRm+vnkpX
	 N3QVcWCFFQrO6W74YLC04+okM0cMugzMFbM13IVCam3NniRF36lJDDuLb6lYrJ+g7fAQ+
	 NNHmOtbbK9T4GRpj/l0bbI/Uu0IjPB3vepNIcqKCiB6NP0OvWCXxdwCMqG1nKO4TBgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902694;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=837fFa3H0qVJpOPxwNIkpy7ce0u5xVtnDSsxH9/Fav8=;
	b=FQXvpmhWvjyU1FmpODA7mtoWspydndd4i0FHAIkS5LPFpiAfJS8VUH5q/XUK2c7Ol4M8
	 sjE60EtaAiJMfaS2wfJhwWG+t9F6+Xaeo1prUEO/4o+XpF2XlxOSQbeR2MGZxpJsVnjhd
	 MO+zj5gItUS09uLhHyWOfrDMhpNPy2lZI6wrT6oSS56blFCUkPMzuTH3gzgLd5poMiEZW
	 WD9O2Ys4K7rZx39BiH++vcgQlQ+dZ75ezbJAdm7PFJQRX6JCi+4fXKfwRSSbwEeSSuV52
	 l7Ao6ha8rKpIep8dozYQQ3MTnJDyYFBy1oJyQrr2i0zqVgS9DVQuhc/NvtJG/FmYWZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Ac5Ur4wZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wkEwrRKJ;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63374606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 04:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63374606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Ac5Ur4wZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wkEwrRKJ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8DEDE1D0008B
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 00:31:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 25 Oct 2026 00:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792902693; x=1792989093; bh=837fFa3H0q
	VJpOPxwNIkpy7ce0u5xVtnDSsxH9/Fav8=; b=Ac5Ur4wZx2yHerOlNEk0P4Al5m
	XAYxZ3s2rgX3c/nywVUJKzWakeTor7Uvluylz/NqoFhzv5vrEks3xxIl9X+U7pq8
	pBUH7xcVyl0OkwXrFD2KvepKITUEVfZ0h+NCf1TdKWfSjNnO15YrXOIxvx0TTZz+
	2691k26kiXD6PDtnVcSZxEK4yhWH76aY+iEIi+X6MnJK1kIYAIWIoJ2Y35Gq8A3t
	jkJSQ/i63XJXBSYU0iBi+zNJROAaM5Ncnj+VDVqYuWXJ7n0UzNXibFiDJAbNQOGi
	vF1QjIE72dqQf+k6hrEC6z8ZRZGYK+4yVm/ExD7lZ60yvgc8pDJjZUeNQzRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792902693; x=1792989093; bh=837fFa3H0qVJpOPxwNIkpy7ce0u5xVtnDSs
	xH9/Fav8=; b=wkEwrRKJ9Zld3MMjAlGlOI+DYmtgl/wtea48WxlFl4q+HRcOV4i
	RGzIq/PfjLjiZWWzev3MZfqf10PhLVIgjGHTDRZxo9r4yDysDSo8kH40Dy7czbPA
	aqH9HXBDCnj7ERg4cu7waZXizd+XSXz6QbgxUb+ACBWpru9VrOKTGmCYto+enfPW
	vZG3EZ/RDKMD8lE1gkdWU0PHYmaE08mBkZzUVgqayyGdoipoR3NdL76Pr6tW+JRL
	746+9/dxJY/gu/7LiCPlKgu/dRimJ/xCCcG0xPBMwtwNbW2TjsVSjxRbZG4ikrnm
	b652RjWR1zTH70vuIuQdlV0m9XGzDJ7ygFw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792902693; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EFVf+rGgga3EqJKYMeaYuINLiEEsxGWn6sa5yxZhSbfDDqN
	Mh+/rXk6EYUJBsNiRztBc72EPMt5Rm0k9gRVvwKsXorxcSN9Kj+D0rYJRFdcQRv3
	JufLUebH0tVVoW9TXiw1GCmf4dK9k4DG88d2phSJJyVG5BoXn0R6e3/z7E3OvDAJ
	jhPSVZAmvJu0jxBIKP+s6PPyONA4484Oiq5eD55gS2J19q6+5Zv1UK8qArvYIyMv
	vsTtgu77/93J0G2hblbkAPeHU6n0wipB2bgwz1NwewmxyE1csEWifDxJkmWZz+mn
	JbAtoi8V/7sB2wG0GAjWmbxmvPYYroVt9uwSI5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SjVCXDjS0mApEcqs2GxvKcEesIQm0adqgrEKJri3NY4=:r0dTOvU4MEe39evCq8rZzZVjMhFSotdwYSNkWD5bZ50=;
X-ME-Sender: <xms:JYbdany-K71Sf0NZPHIZtuZtyGHswVczyQiYLtSPctcXm0-fjhJQ1w>
    <xme:JYbdamRDQl6GFGxKq6nqxUhgeu_-OQ90UE9MQS5B82ui6zztn_3rOaC-kT6jEDaXY
    PvUHKonZXRSvjG7bS6yFfpgWYGMxasBcK7tk63Xy3DqUVbfCXISkz4>
X-ME-Received: <xmr:JYbdamWX3PBO-JvLEGSHnefikAn5NsXKxFhZM6soEM61x28qLhAL9V6LY6xdZ8tYfeT5EVmvhTsV1zsGBvfSQjqDcP200lGQ26gM>
X-ME-Proxy-Cause: dmFkZTGifRguV/GpqetlFiI/dceRCQzSm+dkG2TcxZNpulyLrGePmxT5fJ8XxWC1yRzZbu
    vif3LueFnXvEQmV3ab+0Ujw3ki6kC7iNyHei4Z1Ys4rfPPAih+6MgmszoiByj9nZE3AJqX
    DPTfxY9aBmXCJHaAhii02Cx97BH1wKPUlfV2ZkKS5ePZrvmeGyNON3i7/bBfvngtafihud
    CnqwI/sUHRBbdy9A9L02tXKURkr0d0cKQo4dgqzYu+ser/7/7QTfrULK8zeZVdhzuGNw4Y
    bqDQG+psXBE8RisEs9DVIVnqQ4uM/oitloS++CKmVdnH7MhcYwhjWU+Uw+BaPWbh7a0wsF
    ukv0a6vsboviF0VPh2zkcSanARXTI0vpyh1Jeg8T/QacxgW4Z9kWhBtgspHx2aSl4PPm6u
    36oS+M5pzA+SDdEWuK38q2RksgprpKhmT2PC3MCmyhZ4v04hSW8rdt+bR7KDEbL/IcM4mm
    OZ6Dutyj16OavuTk6E5TIkSxMMUPT61tO4eeNDZ60tiiLVvJUSqrq8NqlBOhpyQb3Cpbdx
    sOZ+TuRilGkEnnIRTb+M4adcCnv0epTYfotsJlzNNeXcj53YxyeTcl0NwhJuV9SHuNiNrX
    jWf5EoVEvZPRj7Eqz1wVD/Q9/iessLdCKH5XbfxyTO6bArFff9MIwU+cXmgw
X-ME-Proxy: <xmx:JYbdagZCLb7iaXazweRQLA7Ig3LkRtaID7_lb7Dyv_Q_b6ikRA0j7A>
    <xmx:JYbdak22X2GcYvRJGj-Y-zy9bcXTAT-vXvMzHomi5s254vkHUWnHvA>
    <xmx:JYbdaqgaHJdJyGAKH08KoU2NfdvwYX6kRpwzWQFj-Ic4j4Yvc39XcQ>
    <xmx:JYbdagZdtWFQ_J_nA5XqgrueXjW9xr_tG0ocdrEvLh0izuk_hnTz4Q>
    <xmx:JYbdaiQDtOC_b2YySCQBE9UOs0SbVrzG2zr7qjEgPCKtveH4xWmy9tJs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 00:31:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v1 1/1] t1450: use mv -f when overwriting a read only file
In-Reply-To: <20261024183056.6342-1-tboegi@web.de> (tboegi@web.de's message of
	"Sat, 24 Oct 2026 20:30:56 +0200")
References: <atmvASAoaCIpc_ca@pks.im> <20261024183056.6342-1-tboegi@web.de>
Date: Sat, 24 Oct 2026 21:31:31 -0700
Message-ID: <xmqq5wyqz9i4.fsf@gitster.g>
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

tboegi@web.de writes:

> So it was not the shell being old - but /bin/mv

And the flag you want to use is not -v but -f?

>
> t/t1450-fsck.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 16cc5d5dcb..335dcbf0af 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -548,7 +548,7 @@ test_expect_success 'rev-list --verify-objects with truncated loose blob' '
>  		# Truncate the loose blob such that its header can still be
>  		# parsed, but reading the object data fails mid-stream.
>  		test_copy_bytes 64 <"$obj" >obj.tmp &&
> -		mv obj.tmp "$obj" &&
> +		mv -v obj.tmp "$obj" &&
>  
>  		test_must_fail git rev-list --verify-objects "$blob" 2>err &&
>  		test_grep "hash mismatch" err
