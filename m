Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132404A28
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754272601; cv=none; b=qo5BNpuRfI5NI1Xxmmd4gCQLlG+PTA0BXlUYY0/r0aeaRuIFX22JbPXtJmSPMx0e/PDLgBs7R2nkhfuo6XHuy1lVUDu7n+2UJJnLjeDySzXmYQ3toK0aYCNbSk4B2qHUZp/5NCU3hJ5DZt8NF5+ti9FZl+EL/zPSJQ6jP5wlhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754272601; c=relaxed/simple;
	bh=0pIyeFG5bsV5/oJruc9bQWb3gazqaxOyeK8PaAPG3Ag=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tsdr6Xj+TgqBUDB5jA/YOkuXERP2hi63eJN+MIXVrVvFz7h/rNCSIV02w9xbK0YnNRMaRCIgujuK7mE8w1vh1KflzA8D8Fgmjz5QIpThcc1HrUMt3Fhc2YkxAA8ctSB7cUC00gWX2rMkp0FERVuwyYvi+g6z+fk7Pkdf2klJ58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8iSckSE; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8iSckSE"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-240763b322fso34293115ad.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 18:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754272599; x=1754877399; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP34jxcGIxsC3hxjcYxMtSIkbB2xohzj7K1tIeV5bW0=;
        b=N8iSckSEnO1aYXo7bC+RvoKMMGZPXquzn57FFTcIN5DZjPjruCXh31mTLIwlF1v6Vr
         4MGThWkoueqZqSqY9ojWSTZHKGGsTE9QJEBc+9Vwrt6KrrBYsb6LNynM+G2sGV+AirFz
         Qpcwcs/ItpNYy0xmFqF20ABD49HAl3Sx5OXQezu6S3Zut++OpHb90SWSiwpF3QJv1nwN
         cps1lDHo3Kdk3Ywx6nEiQPHzXbnDpUNHckNX5Z4e/7Zv0dmuJL/vgNZC2DbYoe+NwG6F
         6K3qu/pG5c6K996IUSjFVFvOUSsCe2HOPtzp02UliXRZzBrwISD92YF5K1OZpAWru02J
         VZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754272599; x=1754877399;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP34jxcGIxsC3hxjcYxMtSIkbB2xohzj7K1tIeV5bW0=;
        b=xDDgHwXLAv+qxN6tpFphjtQhENhayN0tGF2/OSYBVXSnNJYQoUqXHfDquViix5YDku
         YRT+C/8hSvEvGqW0ZR3GO3Wjhjn0KPWsy6V/GtYOeXKg5N+3kN/kOd0gQY8Fb0Xe5KlZ
         tlJvCryhVifeinNGPRW0vX8Lw60hed1vzb/Sp46pGVXMtf3d+kj7owMCx3y6yZTFdm6N
         pavs1Ib6PKolWgijDMrQJT/dEpx6f85M9Yjsfb3ckoYqkxr2ceCPDj3dIIxNynMeLxp7
         FVf1DvqQVdev+SC4rgiZu5xCrqgkNQNRJYUfTlptBwdqBkDtRmQYlI0odhi8fAViLaMx
         PR+Q==
X-Gm-Message-State: AOJu0Yzi5/Od+FuA5d7W52C9frBFjyTY69mL4klGHJigDjY5QVIIOXmX
	pEml3PgqtBD4ReqgPVnnTePeiGk1CJoZmaNxuXLC0f+qwEw2MKr0XVDq
X-Gm-Gg: ASbGncubsF0RnBlMt8NnRNwNk6fgk/Nl8nmBBFifbP0+3A27+QxaKHFHibW49KRLy2o
	SarH/1+1oiy/5YUCPsi3SEwLXHqvCUIn5FMq3iLdG9gtsonATV6aFOuStAZZSTaYfsGvjn646wa
	VGMpBgbYT9ObPik/tMnxQQZQwIeh5WlmdKlKriQhziBRv2N1rIxRdHC6To+Q2WK0FbGeLuQtV7Y
	BihrlbfekpwpGVInKrZQnpaYf/dadhQdLeVrebj91nGmxF29DdLACHjMkG7Yki84GhVPTjMMlMY
	txtfxdn1pFNJWUfwqF8gIcEOl0hojcK6FN67Q0ruzhMTQrXbVIPBXU936+lNYq6iqAflTZZqCfQ
	sD25iTc3TdD+zqoaI/5a0jG5UbfAlZ0wtdNjRGW+0Q430KZrrUi2gujcCmg==
X-Google-Smtp-Source: AGHT+IHB6gH721jw554WBtGoqEUE2psAvNBgNfBscoI37EVdMQIKT8mH9gAD9RqkrtUBwf7u0s5IXw==
X-Received: by 2002:a17:902:cf0b:b0:240:7c39:9e4f with SMTP id d9443c01a7336-24247009a7amr91777395ad.42.1754272599101;
        Sun, 03 Aug 2025 18:56:39 -0700 (PDT)
Received: from smtpclient.apple (n058152109003.netvigator.com. [58.152.109.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf1bsm96833765ad.159.2025.08.03.18.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2025 18:56:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] diff: ensure consistent diff behavior with -I<regex>
 across output formats
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqfre7ex8x.fsf@gitster.g>
Date: Mon, 4 Aug 2025 09:56:22 +0800
Cc: git@vger.kernel.org,
 hi@arnes.space,
 michal@isc.org,
 peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1F1EBB7-1824-4776-B8B0-B557114546DB@gmail.com>
References: <xmqqcy9io73j.fsf@gitster.g>
 <20250803145155.57894-1-yldhome2d2@gmail.com> <xmqqfre7ex8x.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> `git diff -I<regex>` option is inconsistently applied across various
>> output formats. In some cases, files would appear in the =
`--name-only`
>> output but not in the accompanying `--stat` or `-p` outputs, despite
>> the user explicitly requesting to ignore certain changes using
>> `-I<regex>`. Not only for `-I<regex>`, but this inconsistency also
>> exists for other output formats that have `.diff_from_content` set
>> (e.g. `-w`, `--ignore-space-at-eol` and `--ignore-space-change`).
>=20
> Perhaps the above (and code, like the name of the helper functions
> and possibly the name of the new file) should be updated to place
> much stress on -I<regex>, as "ignore-regex" is not any more special
> than other things that flips .diff_from_content bit in this new
> iteration of the patch.

I will replace =E2=80=98-I<regex>=E2=80=99 to =E2=80=98options that set =
.diff_from_content=E2=80=99.

>=20
> I do not quite get why ignore_match() has to know so much about how
> the real code in diff.c that implements -I<regex> works, compared to
> the illustration of "here is how to do it" Peff posted, though.  It
> somehow feels too much duplicated code.

I did copy some code from diffcore-pickaxe.c. I will use Peff's code in =
the
next patch and try to refactor diff_flush() to make the code simpler. =
Though
the reason I match the regular expression in ignore_match() is that I =
want to
return early as soon as an unmatched change is found. And indeed, it's =
not
worth writing the duplicated code for this unknown performance benefit.

Thanks,
Lidong

