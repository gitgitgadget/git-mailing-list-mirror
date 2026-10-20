Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792510377;
	b=uqJfKyN7yxCfp0j7vu/QE+MK4Zfp0DgqCi18a7NOiM3WvsV1JCRixEHa3kMqzzKhOjeC
	 QCe/tmI85Gar+WuXPHZ5nk1jVRMF8WwvAT0BTCxZElTG+0PVoybsO3CyokazhAdA7GhnI
	 abXtrYXi7zCEwr69yGcDfooPTt97zOoZqoV0jI8cngpPRlkjIcFZd04EvUgEfT7SkWXjM
	 xlk6le+Q+s5h0Q/FPuMdQYIRJIk6ep7/Tg5TIFuEyp8XO3hKTK4itjkg2BZJwYWf0dnqn
	 QR8gJYHTcZzSv66e2wlBV/NMxSQueGEGjg7vlIX9ZjYXuBQj1Oi/YWMNstYdy9IijOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ywrGRXSwBgAjuJMgCxtW5/Zw0GprMrL+wohyxAYZOI8=;
	b=bactfzdLWNzwOg/3+dOvpaqUBoKRqZSdlA1YvTlwdob7bYei0oKXHi02OARRjxyYG/Er
	 m81Pgs7JHFfkAe11Gjbo+2PGx4OxcKPA5qGp94bgHyk/gqYWqsQ9dza95WWkP477E/6W9
	 x/rfIgZUckInqnFLH4DGaYDjFKuHsVyeKVf8WcATUuR9PayW1PSgki6KwMpI8Bt1zgUOW
	 cl6pQa+70UC2AjV2hejH02IkXwDyZmw0ITjhoMpay3IOJ0Vb9+qRobkImCtX2Ml+Tq1za
	 nXmlRBRHKvpeVz6SszStCa6u5bQ+eDVUPbmdwiR0GztG1UN6K7anjgN+VX7CcJkYOsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MIoBxVzd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E7606A321
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MIoBxVzd
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso4018013a12.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792510375; cv=none;
        d=google.com; s=arc-20260327;
        b=fAfb+Jv4hXXUZ5OCMGiVAXBImmwjv2uewBkV6LNYF+NCTKBj7Z13/fMCjInOu/dZYk
         /dUnwHq+lglYS8cnP53hrueoLk+oWFOC5yHllfCu4+BOe1L9RdxzQCJCd1bm2vr4QCaT
         pgGt5COv3Q95LaHLfUk66qUwQ3qOVAlsXhzBG/tDfW5gYwrj3ejT+/vGg/UOeAa4lNiF
         0IqxzxVNewBfmWpUTP6NWBGIRewBTj3cclEQeIggIRDZodnnT5x9HFPJkEVVSD8NYo9G
         9xOog78ztvoOeRdM2zJaqvd7LGlcurKWvvghkOSj/Rl7jGoJlhnEHUz2fTq9wl16NwBF
         gEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ywrGRXSwBgAjuJMgCxtW5/Zw0GprMrL+wohyxAYZOI8=;
        fh=oHdAwXJC10oXm4TKS8/hV/fdAd7qygVBZjQPrQQQTN8=;
        b=Er37JroqM4JBVtGCk4ovuJOmuv7ISLuPVczt5ei88pSgeCfbALxuaBdueNAdlqAyia
         XakQMcCQRtMRvdjEUseEjZnET+DvJkzDF6s7zVTNm88rQEP7l3IMjEhmGyC+49eZNWo+
         f+CrMptkskxiYKv8Wgv6gcVX3UC7JSB8+6UKVqTVvHb5fD9r+9rwqpoLaJ8rjgLdnlEf
         4BIE/lC9la9q2DWDo7VtGAbdpxxYYlxZ+Id6m8xfvTY9eVnGV5p8yUqVoXcyPILYVKCR
         c651kxB9wWJcwzMaygub52+l12I0kRHRfykB8QLGxhiiRaMhqKjDQXYGJtDp81j6d9xW
         0N3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510375; x=1793115175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ywrGRXSwBgAjuJMgCxtW5/Zw0GprMrL+wohyxAYZOI8=;
        b=MIoBxVzdhxeJ5bd9J14xKsjjHL46pXCos3To2haf8nAn+7kYzr0Cbu7lORShBFNv1A
         cSnpgkN9eTk2yFl4jEZNJCwKGlfHeW3G5WDYy3z7P7reXyE+4tm3cOjBGmgXKpm3LGlK
         mULgrFSQ6MvdKq0z1ZGWNj/GZ7zsQbpvBO7yDZrFkox3pDdspnGVH1e8r5PFt2TsD41m
         jLszfKlLLEwuItuT+o6LOA5IlakxDlN3l98PI2vi9syGup+ssIJGr9Uo9E6615pjY9on
         swQ33TVpyycrVPO1oc9YxJp+rGG85qjZHWPLBA8l02RH4enXePMo7bLIBXDQsQnivZJt
         fMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510375; x=1793115175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ywrGRXSwBgAjuJMgCxtW5/Zw0GprMrL+wohyxAYZOI8=;
        b=Mb2eD30ODlB9YtUA/s3mdktmakMMo5Ti74Dcw/TWi6WcrnePdtRjyAZ62enBbgekRc
         R5+QDQ8nY0ULjOPqVO+L/xCOlNbrZrhEZawI4sMTkGWBTgEtDXroGuxPBenmK7ElbZF0
         V/wUmn0eayBhkeozHLqBItOSHZ5RZz2mYWONf2kU01jQw3P4GhSvDX++Rw3Rn7E0IrZB
         QdYWySlxej4oM6FE0lK3opX43FPJFzOLUhhPw4/QuMrI6XSL9xcD7KJxfrxhCfRhTBQO
         FusgqcrcL7ZjvMlvNDiIYLgdldokyR6ZN21Q0RWF0PTQ01TNj6EUtBAWReXOBSrhsf6B
         kegA==
X-Forwarded-Encrypted: i=1; AKwUvBy/gLE+Ml2+LazdMkBItng/4FyceUcCwBVImWZxRsHhKZ6wDYZZM8XiT4TgDP+0bgsVNH8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUHDI9voiQ+39NZsX9Lp6851wMBxTCoUBmsKLeVnw+bctvcC4b
	iXgrwrvfdGIWmabeYCtqvfKkiRM36eHpQOHR+OM2a02WV/xBSCPKY15TUU/5LP9sBpwu1vaCxL5
	xm8uud33aL1XlOF7uJBmJ/OdNEGcYuwU=
X-Gm-Gg: AYBFou0BB7zxnahezWlVrdY3DjT6t4KM78WVIIKvA0YIcXQn3HQyaxRhckB45Zo7vom
	/KjbgSOpILobhNFGmBQhPUC8Vd/Z7QKHbRwHFPnCQ66S2XBxPM4N8sg3GTbM2R6x5VaXrSbKmnn
	62EpT5vCwaLn/Qbm5plBKp1cmsUlkliyeUQ5LFrO0+qOZgJNxzl8cjpl+OCxfCf9mm9HFx4/MkK
	uSTl63brWM1pdQ3FsnVXUYMOJLiXh3BCswZ2q74DKXbiqrmcgUtzpzfxCtox4uKBKKVrkQB1hxi
	aWd+J1roR4zf/qHQuE2fotuT66burDV5NWhKFqEjEh94zbdO2zaDAak=
X-Received: by 2002:a05:6402:324b:b0:6b1:c7d9:b622 with SMTP id
 4fb4d7f45d1cf-6b3a81a74b1mr5916429a12.26.1792510375447; Tue, 20 Oct 2026
 08:32:55 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020053932.1274210-1-m@lfurio.us> <atcQb_V69vvKnxoF@pks.im>
 <CAHwyqnVf++okhdjUuVewkK5ZhqbKSoE3TixhpNORdWrMGUA=mw@mail.gmail.com> <atd8mopIi44pMBAC@pks.im>
In-Reply-To: <atd8mopIi44pMBAC@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 20 Oct 2026 17:32:18 +0200
X-Gm-Features: AclHuK9KSHhvfwb4lMOUJ0ZI_m_ws9bpbB_ZOaQ2Y92MKWfVMozPK2O8hbuuNL4
Message-ID: <CAHwyqnWhX0mxz2b5JQfXbtC9ysd2rVVPrnosRV_qdpk9p7J-ow@mail.gmail.com>
Subject: Re: [PATCH] init: show absolute path of (re)initialized repository
To: Patrick Steinhardt <ps@pks.im>
Cc: Matt Hunter <m@lfurio.us>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 4:37=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 20, 2026 at 02:37:05PM +0200, Harald Nordgren wrote:
> > > I'm a bit on the fence about whether we want to have a regression tes=
t
> > > or not. It feels like a very specific thing in the user-facing output=
,
> > > so it's a bit dubious whether it's really worth it. But on the other
> > > hand, folks like you seem to care enough to make the test worthwhile,=
 so
> > > maybe we should have one?
> >
> > It seems self-evident that we need a regression test here. Because
> > it's specifically the thing that would have prevented it, and the only
> > thing that will prevent a new regression later on :)
>
> I wouldn't necessarily say self-evident as the result isn't wrong. It's
> still correct, even though it has changed compared to the previous
> status quo.

I guess it's semantics. The regression test locks down the behavior,
so it won't be accidentally changed later on.


Harald
