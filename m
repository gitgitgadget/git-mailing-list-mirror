Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206061;
	b=Z8crqjUGX+iM/wZ11S+oKaQVkp6yW6rTmiUZSAcZvuK33vuYDleN9EcIulYZTrerSQYb
	 1hsm1eCCw0KDlWiD4hwiypG4xrz6zHitTdIibcIal3cff9T+1K4n6MKndPZqOtwmoBTOM
	 n6HSmmxscZfA+WyeaTdv5Ga0PPjH0I8jV4PWiLf8XhIzLY5KVhaDBBwqMk+l5Iw6dEYGQ
	 Q/B98nqdJqtqoZY4iz/a7bNwOWUil4QU+vU1jiPBnjef440y0UcbZ49PWdr8K+Es1bavK
	 HAFWJX8FBZgzwWIMqq2WaAIR/5vBjoxU71J6t4IwhMwCm+9aMAqd4RaDRK/DJrimQCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206061;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=n/S2cQV0QtH5aazFonwkS0BrrwiC87RB/um+Kpv+YKY=;
	b=LW1dvxfcx42IolBd8hjAi1pSNnscNKt8x2FgmPUht1Mt3T6vb0apm9WWyf9PTTyULTWU
	 2m5o2pu2NQ1gy50wsV6I2xvndHPlRaZAZAXO+PglVJGjz226sxWSDCq6Qm01n6kyGeyac
	 gdE0xg6QcSfAHoW0RL8D0n2SQ0A90AnlSOZquwmsf+Pwue3WTJ4uM2HkzWwAN7DtDZQIY
	 c7RPX/JldjclvDvYtJi9kBadI6ZH3cM0w7X84zHhtFkp3kFrjVIKm3DTOWXCeWZRJ1Xbi
	 VeAHKHByD29LrBOtuXjMVeseDgC0Qz0AKZMtqmdnazgXSYE4zI1xIpjqsu9NbbsWc3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fnIsiesU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NIZgPcJ5;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D3606A325
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708D3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fnIsiesU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NIZgPcJ5
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C85847A009F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:47:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 12:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793206060; x=1793292460; bh=n/S2cQV0Qt
	H5aazFonwkS0BrrwiC87RB/um+Kpv+YKY=; b=fnIsiesUpg9pkrd5jraWPxm7Dj
	q7pgiqBls3mndJP6npo0jv5ZEOv56vPZ7WEi0LFr8JkctlVFxFeExn3v7cwwptol
	0crOwO6N9AqCkAjyVSv/DSNLg8JfnYiNrvd6yl5PCUgbCCoGQfKad8buQqz6U6oL
	d872aoeD7RMjEHdItJtl69KzT9gkLYWCpksRtSpfjbht0yaoLoAWxJnLPukJUsRD
	T24wlavVAEKMAXn2gjAcJxdkM9NvMmzliBgSQVaKULpCmw5HG9aYNGOHw3NvMQvs
	P6ODmVpwPK5N8u3BrkIOk6rgrF4TH5aV0HI9Vlw+hxhw7oJH03r0VBiY99mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793206060; x=1793292460; bh=n/S2cQV0QtH5aazFonwkS0BrrwiC87RB/um
	+Kpv+YKY=; b=NIZgPcJ5/WozLkrL//c3s/9eUH53AetXAnzLzh+voYMmT9aDMrC
	ss8+emkx3kcG41MZjTILYLIPiDTsNmKUBqYnTEABu9mqeLZWs22jwDWKsFbc5c04
	IGIxsLdK0lUDJRNd+6Xu5f4LnXyKRrwdF4TnLDG6ZIEYe7VQj0zKFyiqLsduGkV+
	4uoHbcvwmLjdmT+viZHXDap2/UcvtXdm8WgUtG4B1npgxw37oSvXwVZKCu/9gGAE
	4tqi8Ky4Lv+C4HTrEVvd3qQIr+IuaBnRwYW8+G5NnVXQG32hKG/O+aaiU1Gw1+ND
	6STiaJpdoL8Pv4OkAFQizshkSjx6eIPaSkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793206060; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kuP0ajU/0BcZZ1LMwb8VbhHHb7XlDaQlfUFniKGlF8F7iTo
	xFClN654VFqip9Y7qRqrIAUKRCjhiqAtwaTGDaUXZo+EiktDeY43EZzu9YwQlSm6
	dfJYse6oGJVp9PegYQ5RbKX8IQI92kgdce6W/tdIzrzC0zRtAss7gJiT3uI3777T
	1+FCTfY9zZnuGtAv4ZBmTNZHsluBe0Gf3xaHb1P3dEDS2B8SWtN5k0SalQBSFPOc
	5rQhvNfAIEGnRY/FrMwesg8W4R4A3DtLXYBHQQByPmZyaohZfLlbZ8j14mcVOQdg
	prnZ3njd14JeQRlv4TpVKVmKICrkKtkqvd+Bcdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vtQ3do7Gnv5iLPYoQ/iZ/vtIkWTR+HnhhH9UGNKWvgw=:PCDmQ8H/0xBhDowxxRT6t88oL17rsqQtRo2btMoLsoM=;
X-ME-Sender: <xms:LCfiaohlR-jmCTH5C9rKiRrmFeXvD8t6X2EgSFal-Pk5ey4OxtbPXA>
    <xme:LCfiakRzfMkGLY4pY3wS7zraBvkSAjA1c0lzPX73fD2Q0yZYTY8eumPtx_bxdMFzg
    nXTMnKQe21sbfMO7ldSgCoDAZplwRAjQllXtP3KO77fnCYG6NudFzna>
X-ME-Received: <xmr:LCfiapivBr1SpZT8un0LgA4JNIvNoZId_nIe4-NK518dZfTm0y9uGaI9DezrP0A8oLdkjXVeHGZbe9dCG3eVVwZ7W1upkfZm3t-z>
X-ME-Proxy-Cause: dmFkZTFcm+4hAj0xlutj3aQ9U1j6ixbCeHlxmYDGJ5L4DniBoPKhIBEIQ+8VXeZulRuDtP
    fXg6R1Ui8bCYhrk63LzmrBU8up/p7a5/TQeMw+zwyN1dImvUef3P1aYR5qRJqURjvtJdHK
    wTEBa7nyxYg1tm+6pY7D2xe7XAgts8C9vNXewZiI/dDIza6yEo7BXgrMFo35C6zn9qenJO
    zTMLIkGN9GpHAXuOq/UgmT9Y+KjyoZg8j88fcal+AVJ319AxddkFYLCJCEkh19Rq034lkQ
    /O5vdPH33sqotaI+DSKToUvd7zqdVpRGMFtI+28yHLYpjArru2rXiSdBzBGv1KLGXa+2M4
    1kdAr0odwKXBfKM/uUSlOkDhP/HHDC+kINRtpAsldY5wSdz+mjWpholWZSH7h5yHNp2k9F
    fbAeiMzuYK+pKI1OS1apIVbEj33JpS0666LBTJlIFHVXvkKbyowcKINK2QK4DYcj+/pWU6
    oYpaPlTuJLUbV4i3FWI/dtKP8E+ebamUDq+Xx0oWdGMqlIMuhT1/3RHTAlTH8r7juXEj3O
    Z9RiMLjXldcuvkEfjBHNF6ux/4UaGwMtAs6plhgGcRI4PzsLITEyWn6Lhc37J9ClFZOCfl
    vRDzZQInApB2RPVh5Vuo6a6JukfjODCkyRuUIH85dXQtYce+GSaj5vbFUyBA
X-ME-Proxy: <xmx:LCfiak7PHJiIUUw2xUTQDbLh6RjGyahr6rj7jglku4P6v0IDRUXJxA>
    <xmx:LCfiamDZ_XDLNelkF9lJPo-Im3OYz7tMAHjZmge5On228udYYaKQGA>
    <xmx:LCfiarbXtD-QSr3G-fKi-gjlQxoY10r_n6HrcIFQv3JFaAyjSg8Q3Q>
    <xmx:LCfiahYdxKx7cq_elh1bdUwvddgfjdHhJquLx93_yqKCYqxIk-V78g>
    <xmx:LCfias4kRGHCUBZgjkaiuI-uK4UhaoGaSbxSMtG_WeyaU0Ul7o56SKdZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:47:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t/t1467: use test_must_fail in place of NOT operator
In-Reply-To: <20261028-refs-rename-test-fail-v2-1-505ca9558503@gmail.com>
	(Hardik Kumar's message of "Wed, 28 Oct 2026 15:53:45 +0530")
References: <20261028-refs-rename-test-fail-v2-1-505ca9558503@gmail.com>
Date: Wed, 28 Oct 2026 09:47:38 -0700
Message-ID: <xmqq8q3hbwlx.fsf@gitster.g>
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

Hardik Kumar <hardikxk@gmail.com> writes:

> Replace the "not" (!) operator with `test_must_fail` for refs-rename
> test.
>
> The use of `test_must_fail` is preferred over not (!) operator because
> it ensures that the command fails gracefully. If the command crashes
> (e.g. a segfault) or is killed by a signal, the failure is handled
> correctly by `test_must_fail` which will fail the test whereas the `!`
> operator would silently accept the crash as an expected failure.
>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
> Changes in v2:
> - Refactor commit message
> - Link to v1: https://lore.kernel.org/r/20261028-refs-rename-test-fail-v1-1-b7458ca62149@gmail.com
> ---
>  t/t1467-refs-rename.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Will queue.  Thanks.

> diff --git a/t/t1467-refs-rename.sh b/t/t1467-refs-rename.sh
> index 2b28be75c8..b7d290d05b 100755
> --- a/t/t1467-refs-rename.sh
> +++ b/t/t1467-refs-rename.sh
> @@ -88,7 +88,7 @@ test_expect_success 'rename with symbolic ref fails' '
>  		A=$(git rev-parse A) &&
>  		git refs create refs/heads/target $A &&
>  		git symbolic-ref refs/heads/symref refs/heads/target &&
> -		! git refs rename refs/heads/symref refs/heads/renamed 2>err &&
> +		test_must_fail git refs rename refs/heads/symref refs/heads/renamed 2>err &&
>  		test_grep "is a symbolic ref, .* not supported" err
>  	)
>  '
>
> ---
> base-commit: 37b3475fb530c14109211faca33716a173db61ed
> change-id: 20261028-refs-rename-test-fail-ec7a8fa74e54
