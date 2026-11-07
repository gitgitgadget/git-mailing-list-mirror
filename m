Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018348;
	b=w3dWNkJRbczm4tzZa6U7yL1PNraj5TzfVgLXhe/Ch4a1XH2kZR+0pFLc3ckYLQljisAt
	 yeuIRo2xBGjTrSuYm5gUg6KloqQMMt89uQ04f2n5YkvwpDPREe2mPm8GNvcj7NWyBGUrZ
	 yhYwYujtUmu7xAQ5gGiH9pjA3c/SBxqr0/384CR2f7qUQeJv2RSKJUkQRGrwrAdXRpT/o
	 wEgN3e4J9B5V2A/G5zlXbnFZINhrsI8IfkfQaOItXHt1iWXvd4+semvvZ5xN6LoKyLTuS
	 hnTA0xGwgdflU63MjYxV/eZh2lUooogOG5CCr2hzp1EOPJst2r9nc8V6CysIqbJ6CpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018348;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0J7YSHFpyskjAugM0RSbLfbmC0aiGs7scqZ2z48e1nk=;
	b=0ZX33yMxQMbShdcQ83espbe+LxKUxLQHf5kPS1s+9KwFIs6OLLCvsXNK2R0UAfp5iOeq
	 i4cYnv2TXCg7z9dy82mAZ5FRQgzi2xfFKdOyrjZfx6QVNMgDpB6FOu1fSyTcdBxz1sOQz
	 WqX5r7bSmRe7hSE0D+K/6rwfrLs4Pw0/2lJswQ4jmWNDVyBTqKwhFQWARDJ4bPgBEZicD
	 R81+n/oG3ZDwNFwjAjlxqHiGOk14sroyzhqdk4gfYXxpIkzckUncGeka8pU5hxY/VOjaj
	 iR8gsBHL1MUo9qfVbF1YLUP+nyFw6Ty3rU7dTaSWmQJnOcMzr99+QIcAv0/+d3vq8mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZrqfozIq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="EEWcU/AE";
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AF606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 02:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C59AF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZrqfozIq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EEWcU/AE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FD86EC01DB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:25:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 06 Nov 2026 21:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794018347; x=1794104747; bh=0J7YSHFpys
	kjAugM0RSbLfbmC0aiGs7scqZ2z48e1nk=; b=ZrqfozIqgagjfUptKDxjE89nFH
	SbdcdxjQmzJPwCFeHuu2OnIYXXHt7gSzifAxVv1BDCwWk2nVCCuYEBv4rdyIW77K
	FIN0oVj2NGRt6u1+hoPAn2MPx6BkRYKm9uxcj28lUZsefPrPGrEvnbBVDOfDIkQH
	QZBtEg+estD9J299a2UtOBuJ9Jo9EsEogU9Z9bu0Ax97KE5M0f7kUqFCa59oUPNG
	lqlKxVx70h8Ibp9UoaLVeQ9NexjLv6d/HXPk/YFHUYE0ovGBpZ/aM5b3wxiFHf2o
	aNeugJeLWtAgA6KDhSSucFMkMlWjn2Mubm7ILEDxx5/j0FJQuC1xeWpgqPig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794018347; x=1794104747; bh=0J7YSHFpyskjAugM0RSbLfbmC0aiGs7scqZ
	2z48e1nk=; b=EEWcU/AEZWDKYFY4zk34BzTTxzhtmQT1d6EUu3WBfIWaW5HPaRt
	6PlB8P4nGeDylaYibtSMcC386jeB8/orfoXdDDLYVEsP9aK5OghKpjEvLKzE2jNV
	/yqmmqTT7Vhe5bd8LSK3BwCmOigHrcHvt48eILjawEt1ruRGzT+Ldb7VIIYDEAT9
	uVztbpVRLjW6boAIevV2VxPm0Kn2fmjkD9tQbx99VEGH6JiWtgLPGyDW90ZEBFbg
	gDSrXeRy9bEtlhj45BXsl2ztcwPDtJDywH5aL86R1x5rMB5ZGWNgGYPfmLNGD+Ss
	7LzQDl8jfq0bIK3W+NAkcn+0HsB4JzNHkPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794018347; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DxHhOcba2uSMxQwKQrJM/PnJv29NKyC+d7utntEW6KijmKl
	O8tRI7FrVdafY2Pm8cklNCrJRRK8oDPkt7JI1K7ouim5EE36KUJ+EmKmPBChcgd4
	403VRy6x1LKp/Q8SHupN5UdCmgI8b1vo6b8gnh+3sQXhMVzgxIYf3bRVrXbmxwmz
	6fJZeOIAFIOEB7S7jsKwUAMTQaFsPHgjoMKHxlKdTxei65y11aS2o19rxwkXNkfs
	THgwhnXKwy/KV87M8y3m9+n08lprZG+AjfGBfSrODRRe1zEwTQ09X3WgFdKvi+Iq
	1zQjQfV0NJJ6UwK+Umz8qxdzPSVAp385nM2I71Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:I5TdrW4/VnKr+zbZJ1/Wx0icmgsEMZUHq5gVCz+Pjd0=:7H4rI4W1KPYlA89cYXehktEdbNwIptMc4noYbz3SpPo=;
X-ME-Sender: <xms:K4zuahqjwJMDvVOpGU3-2tqjY5WqaOdMiQmK-UEaX-Wc-Pt-tWjltw>
    <xme:K4zuanUP-NqwA-0mND8YQoef5xwbYIzu4MGZmj1PmL9OC7rVgpEOsklyPZmOmbXaq
    O36xxvRqnEJaEJGz0RzcG6f0pu1Bkw-cUTRUUcmqDUeM0vxhfHM-rs>
X-ME-Received: <xmr:K4zuaoANIRgdQgHiFp4lzmnIyx6gx5h-q11WxYgWDnyONiElJgNCsHs-h0IUymqcQYzVM-sMv44VAlEGqjqmbak1CBrtHn3zVOwb>
X-ME-Proxy-Cause: dmFkZTG2cLoAeT863WZT9nNxTjCS1dkF2mzAhvnhh7iqCxEzF/P4D37NJphKMMAp7bLapz
    dYL0IF6E6lw6SOM2dW9FONSmDed1AMPAFiMX3hWU7y2V0yujU2rh9YP3cVcu09ag/WwCtY
    X6HBWBALnmIJBDiMoKdiDqj5mZuAtU+xnKm8Vg8y1tbjOsmxw6TA68RFJQUjTpeK70N7GB
    S3JTAAZlUX5Xak0ivMYAjC+XcCzX351aRI5RQTi7yE+648K/RMHld5iMf8ACoK0miLuDK/
    gjNceEsb94fdiRn/MGFmWDT6SvG46a0Ari8BGHiTJoelEyx+hV+C0IlW23SexExvcXVrKl
    P9FWtDRuqXq8QNVUEvxFYY1cen2Z0vDpC18A598Aq1nbjjT8MKubtnaSqoOjtEj3n6NM47
    GfCT3UV0C+TzKvQiRIbI0NC3k17iIf7Dja/W1fYK7VkPzzOR5Sw82NxpnhwOaV9xFKbUGu
    L1IpVYJtwZ+yUh6S84XRsit5ebfbAfzXC6Lc3Illp9Ktaze1mAN0uETsCZYAZ9cv3Rt51u
    17fd/RclaZra3QkiivTELoQm/T+idCfDm/CwnrzPOXh8sKZpOEMV5ejFuhTEhhKZKQL99j
    sE12RhNRR7Kk8ZRY1ND4rcCB92/jzLtPRfX+zomtWT1HWnVjQuQyKaeMqobQ
X-ME-Proxy: <xmx:K4zuaj0vIU7JIDLF7dyI15EgMUfO2b_dBcvtjJZubNvVpnVrKT9WbA>
    <xmx:K4zuai26Q-3h0o12gu787amQduNkZZE5L0DqfY8m4Ijpz_CiHnUvhw>
    <xmx:K4zuagDSxhU7oFd5KDU9I4x0yhwazqWCAkftCDrM8S1nzD1WtKouqQ>
    <xmx:K4zuap7gW4x1f8znUw7ynQvM2rL2Jjy9zl61ypuYn4CVddmFuzghLA>
    <xmx:K4zuapP43SVnxKR3dfGPx34IpeHUdS2uMVrhcoUCGKw5gsY5RSbNBpLF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 21:25:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,  Usman
 Akinyemi <usmanakinyemi202@gmail.com>,  Srujith A Poojary
 <poojarysrujith@gmail.com>
Subject: Re: [PATCH v3] [Outreachy PATCH] t2030: modernize test path checks
In-Reply-To: <pull.2256.v3.git.1792299943380.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Sun, 18 Oct 2026 05:05:43
	+0000")
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
	<pull.2256.v3.git.1792299943380.gitgitgadget@gmail.com>
Date: Fri, 06 Nov 2026 18:25:45 -0800
Message-ID: <xmqq33tdbcnq.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
> index 9af24b1204..f6f5dd7cb8 100755
> --- a/t/t2030-unresolve-info.sh
> +++ b/t/t2030-unresolve-info.sh
> @@ -170,7 +170,7 @@ test_expect_success 'rerere and rerere forget' '
>  	git rerere &&
>  	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
>  	rerere_id=${rerere_id%/postimage} &&
> -	test -f .git/rr-cache/$rerere_id/postimage &&
> +	test_path_is_file .git/rr-cache/$rerere_id/postimage &&

OK.
> -	! test -f .git/rr-cache/$rerere_id/postimage &&
> +	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&

OK.

> -	test -f .git/rr-cache/$rerere_id/postimage &&
> +	test_path_is_file .git/rr-cache/$rerere_id/postimage &&

OK.

> -	! test -f .git/rr-cache/$rerere_id/postimage &&
> +	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&

OK.
