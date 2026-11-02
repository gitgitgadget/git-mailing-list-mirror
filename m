Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793633144;
	b=q/ib4Fdt7oLmzIUMciXWi0YmvadAF4txewgvP1N0tX+N1rjBGS4n3HxoDvq2y8KKT9uA
	 w4Rw4GmpTjgUN9HtyFhFZzIF3DlQAO8Sr79vSAZhVCy5R6oj8VKPTS0qBJ1AjOApbjeDg
	 RL6fXIUS5RxToq9RjLh3fjUgVYDfQO2+PKpv80KKWlxI5JX/6Hb5dA9uMmID2UGsycrLy
	 mv7WDmVRe7Jngi/crBC2QZGCCeG+tHd5KjrDs5XmDhCu0bgeGHCl5QB0WO7MMycFOOa0Q
	 y1N22T65yeJb6N0ptvHyi8X9TbFL2T1cS6DRcJSijCFnPrMR4/QHDf44c42Ix6Lg4Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=K1hh7+4Am7snAkFxHJPrhYHBzOoJ3An4hv25RLtlJlA=;
	b=Vu3jGwW/xCAeqO7KwKqdTNLqT7ZVxEr1/ie9hhbtiQJVxGTWpfvur5F7DT2tSso2cXKj
	 Vko0xiJrpmFSty5TmB6WcSRT+ACj//jw+NRRAPaNao4txRTX88yNQSJ1vxYAhMtqGcxjI
	 Mf+v4Q0rtd6u8e6wZc+GrKBv1MZMtK/yZH91FH0Hq593cTA+jOcOl6RXRzkwDzJMsO3za
	 Cv1Sx/TrSZaNNrLPNsLZVEBOI/Bsdh0CRKyPnc3UBVfoyFjB1If8U9W1m6jhF2RewBceV
	 Ni5bnvAwD+KTwnKf8hgwcG666H6GNISojE4WEvzJjNmwh2YirvhqvvdWZgCmqPLfIDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXnUOcWU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED9609A701
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95ED9609A701
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NXnUOcWU
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a2761c69fbso4830527c88.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:25:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793633143; cv=none;
        d=google.com; s=arc-20260327;
        b=IxEopws6BBc0VnBDFNGiSgvkBsZdpRM37W7btQ64VMSmsfRSuHDq1LAnL2ElGUY0o7
         7Y0bUAKCm07YEnABKVL2URDPX9+FHMK82bdzIa0U0lZzhXmJ1u21yhbt5rJiQrbEIeVe
         zWoBSW9CCURGCz1bezKY2cHX/28BAo63ucpuqWNvOhBB8GBhhJswubbtz8DTDzYYIOqF
         HIpcoqmm02LIyjKBgTrxFrcND4P5+9NvdZrtC4N12C4wnh38hD0dnB+krmH7o+ydPe7y
         Rv9fhDVQrUNW42SNczoiBbxmKo9jKOb079cI1LCszmZQO/KqzPlsXtqNFq8gr58T0vzi
         J7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K1hh7+4Am7snAkFxHJPrhYHBzOoJ3An4hv25RLtlJlA=;
        fh=AkwqM3nf6GiSuNMkyvTMJn2XhHysb/LIuV09ali4XeU=;
        b=fRc8xeZQOFue1jHomuqeTnT/e8nhvE2KjujO3gfDgwR6DfvnYrzw3scBLJzUZ8irFk
         e4QsPJFxA6XTpAfDalHb4j4Y3WDrzN8iH8SkzRt0rVLbPc+lK8D76LJ+amNQCy5zgfMc
         CZs/LubtXnay872w9wr3yruKm0rGG4/4/cvyBAFRPwy9eAcR5yi3a3QOXjZRkzAW1zBD
         o/E0DtMqxf6y+tLLV00xMl2XiTv3jrKcWgj/liHIUULHL2ORdApcAoMsBx+0y+QfFp/C
         6MXo0QyesKoH+efPIrkrn3ViOdukoL1ey/Uq3+kCnLtoxHFvNmmoCoNWDBeUDVVuQ+O4
         Eyjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793633143; x=1794237943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1hh7+4Am7snAkFxHJPrhYHBzOoJ3An4hv25RLtlJlA=;
        b=NXnUOcWUA7jrmQ/ZNfmYTAGJxDGyyQm9nbv6Ny3SSZ1Vp5rGBzu9nEmF0Cp04sYFkg
         gqfkqQuxQvm7BBPwTv9A0Vd3lw9pZfaRNNfKsN/q/ZtaFm77FgvlWambA+KmmZosV0tF
         proO1bqgzit64qpOr1gXrmkYPPMLBP4tBuX2NlfI+1eK7GrH3nVSCFYUU4fv7Gg+79UL
         TOi5ot+fnJvOsMW6XQZEXtTwv/hg7Twu31z9kKi2ttOb+dv+Pu3NVyAInWNul0ettiiy
         f2PEylU8E1aFYw46/6dwlQRwPpIAnSOPqcKvu0246tVg4rkJGQbJ6YOHAVWb+60KaFf3
         YusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633143; x=1794237943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1hh7+4Am7snAkFxHJPrhYHBzOoJ3An4hv25RLtlJlA=;
        b=L+MPv3NS13a+PLdZZwvY9dHn26ImeKK7UkjHP04bJYiyxNUqMYi6G4LQO/d7Y89aQy
         t24R/b6LZlcwiKBrXpBfHejYxG06p5QeG3Jbwvm/V1VC8BkFgW7+SPUFx87Df9IdOKWB
         ISdCc0d75us1wrDnb+9xgkfA4TVIm/KPvqHgzsoiX/0ogIbSQ/P1zf3nQERWLOgGehtt
         rxNChXo8MPKdjE09ObgSzBNT/8ljOO3+K+UQgJhChd1hwDXipZFGCIwtjyvdNCjpjDFX
         S3XP4FI4TKIhqTPrCrNflsyVm2hLGdwVMLzGV16ErRHbNuY8kAs76sB73G8PgmhRCCvm
         o8Gw==
X-Gm-Message-State: AFq9FYJX1EzyedUykmLgL2hxQq9+GDRDaHTuozvLyfC/LzyeO0PryYGl
	chH3VxMm+ydYCNlGcB31nQeoYwVpPkff1sEd86ZBm7vTV/seV/Uxkea9GAQRILkHdS+BgYXXoeT
	stNDODtTU1OaNnogHhCLx3Y2jg+1oZoM=
X-Gm-Gg: AYBFou2fChNPY08wC8QKCh71K+QuY0rYc9tVyt7ln37QHj5sg3ocPcJrKM9dBgXwHnw
	idr/sgzUXw0Exhay6aRQjVAnNSy3g2K7yVBlmeRV/nljuIVoKXejgvu52iD2G+XXFHJyxBBCXla
	JC77OPs3nPJpd1dlkCA3w/DV2iZp5FXo/ITFfTZcTiu08ojnN9h28Wnjwb0gLTLbnndZlU63Yb5
	vvZkpxy07xree5su7rpvVGygMBB8rCKUU9hRqQMSHQj4SDRo25gC1T/lw7nNduSAmmZOSQLM6Uv
	11eMNqO+RX1RF14+LiYYZwycQK13clQwadTpvRk+kqzHmEhFOzLASPRnY9py0iJKsaGvkkbXwDQ
	vgBLtRMFevaA6joMaIv9V+VVVaXRSHbNTWQh0CJN7e0yCuKPVtCzaYaiIudvt3Hr5C9ifyiivF6
	qC1ijPEb/bTkLKb1ghuVZxUP+hyKQ5KHlV8kt9Ut79qpC6SAy08jQtnq4hZyBuFfi0Bhr7IwWjm
	C0P+53o5y698GNyeCfuY+BC
X-Received: by 2002:a05:7022:170c:b0:145:287:ce91 with SMTP id
 a92af1059eb24-1ac59dd30ebmr16441986c88.14.1793633141924; Mon, 02 Nov 2026
 07:25:41 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260923080928.1534413-1-christian.couder@gmail.com>
 <20261012074413.337183-1-christian.couder@gmail.com> <20261012074413.337183-4-christian.couder@gmail.com>
 <6782fa63-1e46-4ae9-b129-a157986c2556@gmail.com>
In-Reply-To: <6782fa63-1e46-4ae9-b129-a157986c2556@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Nov 2026 16:25:30 +0100
X-Gm-Features: AclHuK98K6dcL8HP39vu0mgMvInXWHEgtap8ZBAOcY3OEb5zLynemtWjcg1DReY
Message-ID: <CAP8UFD1P1=HhuiKEDjBKdjauKUbeBYG6gT2_WZfq0qh93MN-LQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] parse-options: add early_scan_options()
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:27=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 10/12/26 13:14, Christian Couder wrote:

> > @@ -763,6 +765,8 @@ static void parse_options_check(const struct option=
 *opts)
> >               case OPTION_SUBCOMMAND:
> >                       if (!opts->value || !opts->subcommand_fn)
> >                               optbug(opts, "OPTION_SUBCOMMAND needs a v=
alue and a subcommand function");
> > +                     if (opts->flags & PARSE_OPT_EARLY)
> > +                             optbug(opts, "OPTION_SUBCOMMAND does not =
support PARSE_OPT_EARLY");
> >                       if (!subcommand_value)
> >                               subcommand_value =3D opts->value;
> >                       else if (subcommand_value !=3D opts->value)
>
> Would it make sense to also have these validations within
> early_scan_options() just in case it is called before
> parse_options_start() is invoked?

Yeah, I think it's cheap and simple enough to just call
parse_options_check() from early_scan_options(), so I have added that
call in the v4 I just sent.


> > +/*
> > + * Called by early_scan_options() for each argument matching a
> > + * `struct option` with PARSE_OPT_EARLY set.
> > + *
> > + * - `option` is the matching option,
>
> Would it be helpful to also convey here that the caller is not expected
> to retain the pointer as the memory pointing to it would be freed once
> the scan completes?

Yeah, it looks like this in v4:

 * - `option` is the matching option, (may point into a temporary
 *   copy of the options, so must not be used after the scan,)

Thanks.
