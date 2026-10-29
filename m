Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300048;
	b=ON70lJGihwE2liN9wmwUrsbDALYYAVl+pzH4sB7JvxtG5q085owHh6xf83NcZ2OpFgtf
	 UwUlZ0DoEFdF1WFqs31gE9UwypIkwgfTJj4JsAYi6dOhLhALAWomTmc/YURWvLrvWnoIY
	 2JMTqZO3zAqLt7VQSqluVkVgp87CsgvoSO4cja+DWgsKGQf1EoNyE4Bekik+sxSpUz1eu
	 ycAQHJMtTKrnoJQI3FS2sVpwCwM5C//v9i1YVj12EFXjznedUrJXNPEAJfsrgHOva+RID
	 HATN2WA7cUZ8ddY8osU47WsB0Z43e2UIK2j2/wP2mFSMwvp2c2jeRY0D+nkzgOlQspA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300048;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1HuOVIhsgB8pGrBQgFZhxX+TirS11NvMeKG9IdYMpZA=;
	b=1ii4BPQNydA0hNyTp17GPxR8bFOUUbik8YYksU9If4l4n6SROmHzC98RWOdpepym1Sn0
	 WS2YXjz05fcpIyY0HrJFTS+nTD995Jm3ggC0YHlxbQy6nxWwFttL1EjXTNK3i258ryQJN
	 cIxbcCXJ9bDVTGC6Tj/wE0kwj4o14LvDBi5DeREV2chJ+eiQtCeTdz/HpzgSlJEX70zFk
	 fCUpxgTiNRHE4LQcvVJ9KfRnH/yjzWqIFaML3+X7V740GalTnm+PsYHsL+VAgk/JP0NX4
	 Y0+RPDPB2H/qnTncxxn87xffS1lknoJS8rHyVdSLZErmysC9mTq6i+x5fFl72eHH9zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=LTfwONL4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wNtho3DJ;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46B606A31D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F46B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=LTfwONL4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wNtho3DJ
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B2597A0103
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:54:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 29 Oct 2026 14:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793300047; x=1793386447; bh=1HuOVIhsgB
	8pGrBQgFZhxX+TirS11NvMeKG9IdYMpZA=; b=LTfwONL4fhEgp7ypAIIbGmPhBU
	LnyBoBg0zF8xMJp7ljT9JDWVP4zDoYLG7/Sy2rWaucBxor3iPszoV/hDQ9jhWlFn
	kt9FUEdi9u0WRc4Nzg9cs1fB64T/G7CwXxaQxvbLdKy3+SiQObhKx2HaIdBl8ZFF
	v6Duy3EfBrWTRkAx3UNOMXzmSF8LYlJ1Slmk/skuYx7Wtwd0uKmHjMmPCDUHgAmn
	5ACYb3QR6oFgFjFp4GP5NATXOvFKHh6G1CCMJ8oBiYL0S3PUyNfQm6tHHz4EjO05
	H/+XTmfCjCgEZWx4UDaxtpSiV1x6VSvkw/HI4PC5ynl4T84X6GCrwRppZ3ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793300047; x=1793386447; bh=1HuOVIhsgB8pGrBQgFZhxX+TirS11NvMeKG
	9IdYMpZA=; b=wNtho3DJm6YVNq7OJAPJCJ4UWXStI7XZxqfHrJnqmNixdMK1sDr
	N/H/XGjJpc5GILPn/dsmcLR8EnnfVr6w+3JWk9HqAw/JNYURpUFcy9pT6f1msn27
	Qy2yPltFu3MkTyq1b9NjNhwNoQX7O/zUDkyfQuyFeG3UDPz2E/Px5CkSHxF1Yov3
	aiF9RGXu32fLhop6jAlPBu2UHSuvNeW9LNY3JY5ewJV3Aczbs31Dn3HfH3zNghZi
	eF07g6045dlS81dqnvMjMA64iyaJRj5EktjzsRjU+1eC6P6Svge7ybs/NrsP7irr
	xrleWZ8c0lFnRzVy0TaFm2EfwOWTOrxykLg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793300047; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:pcrz/JAx0IPknIiipPRwRq1Xjr7bsgnFZVeYJXgJpiy8LEw
	DKp3RLNfiJ1oDdwWCTDqebG8gp8D9BERo31krP/ge7O4zhSo9pLIytQzWbsUv+9+
	fS8uCyH42t7LjmfoUu+wmt9p4O8r2jgimDI6ff2lwwbTcRPgTr8Gy6zEZPWksPcp
	2WeBB0UijZJBqIuD7QcQ6Q5iphRoephzB2ZDU2qvEtzpbOe7Vv9FgKOlSEcu1SBn
	PGXaCe4AJ5S8WmxlYKbuhWBZD2APptMSupOeUUlqnQewFbCUkmA8TWP/sb/5RKks
	6JjutWb6qiexXVyR1N7IT20mi1EsWiq4xtEBLqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:J09mTqTaSXz7Ua9SKFg+dDrijCzs0Xoeeafwy/WGj30=:k5dfbVng8u7cQmkgUSk7X8H8s29HaMr1cy8Q5BY300M=;
X-ME-Sender: <xms:TpbjasH-wIDgDZg6V1trrWd1QO2Xl2_HE96cjAqxHxIsdUjpr_GCGg>
    <xme:TpbjapAfa2aIaACbiywoiTfrAvv9rf9sQCbv1carD63PPLS_w8lzWm_2ygoYEfggZ
    U5cIdGFqiRHljLyvBRe3udNYCZvc22nf11ebZWMI4-XLqfiajEWbA>
X-ME-Received: <xmr:Tpbjav8qexv4P4HYPTyw95LAMKt5hM7zqNcXEukg6Kn-NvJEdWaPh3UQ0FQKtSgVmVuMuS6YYt-uwY5wGzOVq9vd6tXzB7P12_U_>
X-ME-Proxy-Cause: dmFkZTEU1q4E+QJDZftn2XfQD/fPiOPfFSECzmVSJhzE0eS8d2EsgmEFEHuHyYoehdheTM
    cLf7kB8eoAyjVJwTP9fanSXj6kebzLX5ymCaWpeYD5BvWrmeeQK0eEQuQpikLmUfynTY6J
    ViUJJv9MGtN7s26qMtSM9iSj4pDNfL4U/xcU3vkKa3UtVh1LJwbYfnbDtz29v5yVe7oJmC
    mKFh+CxM6xNGOwoPyHuGJaMNDw5VPts0EO78f4QZge9aV+RCjDWYIWzmSTaAVzPHTy0F/Y
    ZRSuY4ehbQsYKxI1SNoU+1/2r9DPGtqy6wrrO3cZE09ndiMncXPDYjfNF+hYa4B5DnZit8
    Y8Yvy0bgkQ9LkXzLNS4Z+FVWT1f+pmXNLWIPx/jgfnHvCD5g0a9rpMljonwWqnCvE8TZY/
    sWk3Q/XWlQB/umurqYuQn+4P3yEhT0sTxLx+nOyP3nMZSA1rnHsfAY9lWYhtIoAQt3Rqsx
    7cp3T9oE8LyUkwoiainCBAcdqQQVGMCEiFXYUEoCEhmm2zmMJpsbKDfypjc50LoMKB7bbp
    93k2UAiOVmZUHctVAWTR+QCdTG6RCcTVLW8IV31L4yz+NcQR7ZJT4bQYycmb7T6eUkrdcg
    9E4Mdi/VHBbUZK/BcCsctpvkr6zlIXYEuglaMzkhVGaztBfcNMvZJFmNJAcw
X-ME-Proxy: <xmx:TpbjalDYEwUlvrKvQPjdniPoSeJOMP-i1CrX-WveKEia4Df2VwmZDg>
    <xmx:TpbjakTJAC4b46Bl_Wpov2K4Z3jgoClpUl5ypFpSAUb63HHzQF1jDA>
    <xmx:TpbjasvoCF1VM2puGgUDUebwGqTlw299rz_AAbutCWMdyDaDaveN0w>
    <xmx:Tpbjag33HVE51vU5XaNFIxL05nh5lITumQsUDKv6jPB6cjMaVr4r1g>
    <xmx:T5bjamoqZYSiYm0AVt_f0dXD49CEp7xdZiUm1q3aR6kETAMSnSjqwVa5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 14:54:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Fien Dora <fiendora5@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [Outreachy PATCH v3] t1402: test --no-allow-onelevel option
 precedence
In-Reply-To: <20261029121715.3845-1-fiendora5@gmail.com> (Fien Dora's message
	of "Thu, 29 Oct 2026 13:17:15 +0100")
References: <20261027145451.8617-1-fiendora5@gmail.com>
	<20261029121715.3845-1-fiendora5@gmail.com>
Date: Thu, 29 Oct 2026 11:54:05 -0700
Message-ID: <xmqqqzh81goi.fsf@gitster.g>
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

Fien Dora <fiendora5@gmail.com> writes:

> Unlike most Git commands that use the parse_options() API,
> check-ref-format relies on a handcrafted loop to parse command-line
> options. Although the --no- prefix is commonly used to negate options
> in Git, the precedence of --allow-onelevel and --no-allow-onelevel
> is not explicitly covered by the existing tests.
>
> Add regression tests for both orders of --allow-onelevel and
> --no-allow-onelevel to verify that the last option takes precedence.
> The tests confirm that --no-allow-onelevel overrides a preceding
> --allow-onelevel, and that --allow-onelevel similarly overrides a
> preceding --no-allow-onelevel.
>
> To improve Git's command-line argument parsing, I plan to
> explore converting check-ref-format's handcrafted parser to
> parse_options() API in a separate patch series. These tests
> establish the current option-precedence behavior that the
> conversion would need to preserve.
>
> Signed-off-by: Fien Dora <fiendora5@gmail.com>
> ---

Well explained.

> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index 9dd64662b2..6036df0210 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -74,6 +74,8 @@ invalid_ref 'heads/foo*/bar*' --refspec-pattern
>  ref='foo'
>  invalid_ref "$ref"
>  valid_ref "$ref" --allow-onelevel
> +invalid_ref "$ref" '--allow-onelevel --no-allow-onelevel'
> +valid_ref "$ref" '--no-allow-onelevel --allow-onelevel'
>  invalid_ref "$ref" --refspec-pattern
>  valid_ref "$ref" '--refspec-pattern --allow-onelevel'
>  invalid_ref "$ref" --normalize

Will queue.  Thanks.
