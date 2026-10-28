Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220506;
	b=F/QRiYd9WT9VYnRNh5RXfUBsqD71lxbhnEF7XNeLaXPu3XtvW60SVo0QYLeSJ7caVCSi
	 kXnR1mfQioW4pkdEBYjGt5tR5xIHrXifM3fVquIpp04PlAqdSnxyZDc+GYO9ZXWhkLxED
	 W7Dfh/1GhKJWn9Z04eVcfKd4DCs8zQjz173mK6tk4J77F6q73KqBCgL3yZVZDkR3cGbhp
	 65tb+9S4aITBn3Ym5Otv3MKHy4+EtURHbS1hQh+9CRoj5qfk29QdWrVbO5F1YwTYOJxHj
	 Y/HfqPpIsBAUuLY9I+A/6/adIUlIVxeNdixyKllHZh06aH1NOR/I5cBo3g0VZ7HjIcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=h8JpF2GR5VJVuV7s8WRXEopXq5zXs4iOZFEamMutetY=;
	b=X+LCm/pCa5iHpMUtvkG8xenli6a0dHBqxKgDOOcEbLSxNIUBs2HmpDgwhgjZ+XyxMG08
	 QoBFIGYAW1au+Czr3uceoPh/S8QyixvKWajNfPff4z47k961a4ARekWY2/XlLf8Je/Sbb
	 12d1EvGBHGVowownkyuvsx0GqAF/gwLrSa4PMapltBdDpsLLAgL1sjLFK2emKKXu+sH8w
	 mb7K5AjwxP62f4wJvXUJTRwhjgvGMc8vCNEcYeQSYA1mP6EvZkgsENMB3OpL4j3mzxivG
	 cl15taDQyoWWd6mtV8/5/rKvC90AKxyw2SI8nP3ywTENw1eBddsUqG2Ilcz8AI5zeTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXDcFGC3;
	arc=none smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AF606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 110AF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OXDcFGC3
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675617e81f9so1489842d50.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793220505; x=1793825305; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8JpF2GR5VJVuV7s8WRXEopXq5zXs4iOZFEamMutetY=;
        b=OXDcFGC3iaFTShxYkTagBPnJ6NoF+BqegeRGBmRKOAqqNbeqTYBGLHSExbxfjzdSvJ
         zDjrqW7XZoa4bxPd1rgqxpkBehuGLWZ1meSJ+S2+au7e6Y0fLTY12Hg1++Xc7yPJSZUQ
         i0EI4iUAJygQl4SUQ3c1Znvs9CfuhqoGSixByFmssWMVNvwiQVvYUUt2g8PrteX292mB
         xVSz88nAqQhcrCD15Sql9yu9t9K9XV0RxvyyEC6+15VZ9M3FkTteUN9hCXc67fwg/1SS
         UXVhuf9en46L/SmmVBSoz/liz3kitvvMrZ6EkiX3ttpR2xlp+5TYIlPIC4jGRjarBysn
         8Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220505; x=1793825305;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8JpF2GR5VJVuV7s8WRXEopXq5zXs4iOZFEamMutetY=;
        b=EAH5/N0S3TZjRPkhtHKVuWegEK74UjUObM1Al6/YHHJgL21GJhs395BBTQIAjfcszj
         T+B6x2URzdtl/xltlrRCocG4N1nFmGBZkedVhPWoZlfUIOtNStgkiUTRO8OkBav4FwsU
         ukUVUFKfi9s7uvrUD/T/cBMmo7ZRhNg6XNrzMtlazkGavxg3p2gEQNVQX42DHV28w0QW
         B4pIu6iUoqQiGl1sMI1DPph+sJT/8bZqon6pkQ+abD8/xpadNupp3DBHsbi8Be65sj9K
         Prytjkb2UssoQt0hX06H9SUzuS235iVoE8MfuhZC6EybbUgAcAmuG6nz/jzirbULMSBl
         INiw==
X-Gm-Message-State: AFq9FYK3G/b6KfH6Wky/kqLeUSGKC65GuqOlOalcek3MI6QuTulf8JUT
	hHI2tmcLFla91v8Iwpg1qmMkJUCLCzGbHFNS38gNXVqnBhLwy4Pvym82pOYfug==
X-Gm-Gg: AYBFou0SY9cbIWJ24tAGezZp98U7CXjhCruc0rRv3UNdz5s3wYnJLAN96UXUvW0KNmo
	f2BjKD+X9lICf/KbaBTN9Tf4avAyD5xFhY+tjE+Bln5syAqVcEoYbO0g+wZCOnaS/cZY7zFbtdE
	xahrBP5RkzjMOepOjFRtvNjiq9+8flbSO61+/bIIHsG7ycNT8217DvS9LqvAYL5Vdw3WAT7S6aJ
	xM09/F2m+feL+q7uCu84MAyPmEeAoq/ma19+1UPnvoIoxge5qWvsFqMhB/U2nDYXrAIpZmUX6SV
	Uo9BunEOXdqg+YeHJJS6k/VskwBSWixiB/PlgKw0363RHduaJ4/z5EvJGljApsE/CSvr793cYlW
	ZOlpmffylOPYVhgvQf+89xCDpT1eNH2+w+mMq9uB0eVsuI/OTtO4urwhJsuFRhOGaQX3ZtlODAD
	qmHeQbCKCTf1nNXuqgzkMmtp+DEvEDQDqlhyXE6UhPXwdWwxxLTyCSw5mSvlcwjpZPGKMTdI8gE
	FWjEyogj17JGWubfiBBggCciVM/MA8YPTx14FAub25+JvcUqAveu2B8fwEU/aNMx44xv75IVYyg
	Mc8tblMa/pt7UtnlbtXS8iPiC5zN3EPZEbdX2hg1Lk+byKdnQTuC2ua0MLqTMMkE8OAgkinZXRR
	zNuV1HFpCP8qBniTpAirtIqg73BqT8ieFE7XXRBny10zfB40oBDcfPZ/IaNew3yHmRbXSk/nW9/
	pdhg==
X-Received: by 2002:a05:690e:1406:b0:679:bcd4:a9a6 with SMTP id 956f58d0204a3-67a7bf2c65fmr3198510d50.109.1793220504782;
        Wed, 28 Oct 2026 13:48:24 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d46:600:6079:8281:6136:1024])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a146c98sm2314463d50.16.2026.10.28.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:48:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] add -i: hide init/clear_add_i_state() functions
Date: Wed, 28 Oct 2026 16:48:13 -0400
Message-Id: <2E0FBA76-AB3A-4B5C-A08A-9B3272C65307@gmail.com>
References: <xmqqh5i58uo0.fsf@gitster.g>
Cc: git@vger.kernel.org
In-Reply-To: <xmqqh5i58uo0.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 28 oct. 2026 =C3=A0 16:22, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFThe "add -i" machinery is encapsulated in run_add_i() function,
> which uses init_add_i_state() to initialize the machinery, does its
> thing, and clear_add_i_state() to tear it down.  External callers
> have no need to call anything other than run_add_i().
>=20
> Make init/clear_add_i_state() file-scope static functions, and
> "struct add_i_state" type as well.

Yep, narrower interfaces are easier for programmers to consume, thanks.=20

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> add-interactive.c | 11 ++++++++---
> add-interactive.h |  9 ---------
> 2 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/add-interactive.c b/add-interactive.c
> index 3cf8a1dbf8..9a00daf9f9 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -19,14 +19,19 @@
> #include "prompt.h"
> #include "tree.h"
>=20
> -void init_add_i_state(struct add_i_state *s, struct repository *r,
> -              struct interactive_options *opts)
> +struct add_i_state {
> +    struct repository *r;
> +    struct interactive_config cfg;
> +};
> +
> +static void init_add_i_state(struct add_i_state *s, struct repository *r,=

> +                 struct interactive_options *opts)
> {
>    s->r =3D r;
>    interactive_config_init(&s->cfg, r, opts);
> }
>=20
> -void clear_add_i_state(struct add_i_state *s)
> +static void clear_add_i_state(struct add_i_state *s)
> {
>    interactive_config_clear(&s->cfg);
>    memset(s, 0, sizeof(*s));
> diff --git a/add-interactive.h b/add-interactive.h
> index eefa2edc7c..47f67ede82 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -6,15 +6,6 @@
> struct pathspec;
> struct repository;
>=20
> -struct add_i_state {
> -    struct repository *r;
> -    struct interactive_config cfg;
> -};
> -
> -void init_add_i_state(struct add_i_state *s, struct repository *r,
> -              struct interactive_options *opts);
> -void clear_add_i_state(struct add_i_state *s);
> -
> int run_add_i(struct repository *r, const struct pathspec *ps,
>          struct interactive_options *opts);
>=20
> --
> 2.56.0-433-ga9209adf11

And this matches the log message.

I did not check for callers, but I assume you did your due-diligence there ;=
)=20=
