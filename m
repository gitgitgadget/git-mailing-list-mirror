Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D91F95C
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756164849; cv=none; b=T0usrLO2wyAqDrNnaAf9X5gtn+ADuxSz2XqPsrdoH3D+yEWzyaij52OpB+Hz7Ju+M3zzmuteH5yRoRx+OAgF2LlupcvNFDFfVphz7IQEBq5XWlDh56a8sazQ6OSIYsCgowmh0yKXP3iyYAdiBbclxSqreWfgrLPAogdljS1/y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756164849; c=relaxed/simple;
	bh=QT2azxbCoY06G626xillrQvjjK6o6LTg7eFsEx7isw4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QAOtQJfNFYaclB7qcmaAk5AoM70CBYU0BTpUMQU8/aRwbe36rIan6IqhQKmRdji/jQWKSXvbv7RwL1NQ1syk8jeQX4VDDgy7ftp0YeExTvUdYi2P/bU0UqGT+gVI33PONDw1b5JqAsjKw4xfJqwFYZlvk1donNy8artx6qLvp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMFbY6Ml; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMFbY6Ml"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24456ce0b96so49642885ad.0
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756164846; x=1756769646; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QT2azxbCoY06G626xillrQvjjK6o6LTg7eFsEx7isw4=;
        b=JMFbY6Ml64f+u/hfo1sOjiD0gqbXUQNa0z0nKxVM6QxTy/r9jZZ5nn+j2r/CE/1Vs9
         Pmk5PsETS0+PhNRGgiGtngK4lEl6/WWymZYsDx/iB2QAzxEcMrDIKJ5J6PLmMaz045Eq
         8B3ssJ0Fbz/jwJbPS14ZH6VJSoHyZVlwEpODQlhJR57cYII8WnkGpeG2pAOuX8Dlc1Nf
         BVBm+y2n/pHstW0mivvUs4lX6NK2zDdJ1vw04LgQCOjD13KR0kdrDQoIWctjRLP+VqLV
         sZD30pwHPvhlPnOyicbA3yUs8iAxBy5eNcDZDieMb1GsSCf5nuTgPSHNNomq20vIHMbR
         cL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756164846; x=1756769646;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT2azxbCoY06G626xillrQvjjK6o6LTg7eFsEx7isw4=;
        b=CceTFoRzqrQO8qidFbOTjR0RXxxBKtSNp6kQoBFNohjsvcF3rvVuaqCnIxWYleO1ut
         U7n2BMJ8Oj/86CKuk5QXwig69kgG+2eFh9AW2I48ssDh5+RFa/Je2KUpxo3+eOFzXTFZ
         jfbTQg1hz66vs2p3NYtcZPU5qhfp4gzyKYJ0rYJKYXik3SJIITsIt/E42uuYSoqFwAeA
         PR0S97WVSazfkNdnMJaZKTTRjZEA3rHRGQYEkMGtxM8h38UQ9PRiXe/f7oAFdv91B1zT
         XKJVMWh8dwn1q8eNBOIt4Y8Vkl0ARUtsJtE+zqWOaTq5dM/DlsVZD5DTtfjorAYE+0yJ
         ugSQ==
X-Gm-Message-State: AOJu0YxcLorYCBpxeem1Ub4QYAvo7gPCuSUYqav2sHNVII2UQwrNjBFk
	/JsB3BfOdBkYSMZY55HnK+xkGUKnb/XDayuGsG8cwIjp7rriPv1Jgve6
X-Gm-Gg: ASbGncvfJRFXIIA5hC9ddMK8iAxkauUxUxfzzLy0SShts4DQPgBy5nRbMLWqV+u89c6
	qsDaI3LEpDXEVh1i3KRfOzdWKd/grNlGU6R1TwYSKvkyAjQg/pblEwGt1crN4mjKa7ARtTleAY+
	tSfFCT63iRT2zSZlhm9A1VBU8IP6sGtQl2KPYp/Oj+bXzn2iAwFJXz9kjEIX58YAr1n+u7V6BMv
	o5Eos7uUbeZpEK8mYolqX0seBxqK9NyT9L/mK/lkdXMLAl1HqgqGaG7YDCmLy3bemv11ob7bide
	F/592Ekk5OYZLZTK1hCfLpeGuAZkfcyzdC59PjEF1ONG7ejf4vP/DUcVDEWtmkr7/phZDIFm/LC
	CsVd80GaSOYM4sLZWPqaWOEvcy2qx451c
X-Google-Smtp-Source: AGHT+IHU8SuCNk4IwN8DCfhBEZ6J/aJUgAW/FBGe+OT36SHNlZxD+5f2gwO6z6hJJckD8g9tBhAVDw==
X-Received: by 2002:a17:903:1b05:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2483df7916dmr10806975ad.20.1756164845704;
        Mon, 25 Aug 2025 16:34:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b2418sm79054245ad.45.2025.08.25.16.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 16:34:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 80EB84222D17; Tue, 26 Aug 2025 06:34:02 +0700 (WIB)
Date: Tue, 26 Aug 2025 06:34:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>,
	Askar Safin <safinaskar@zohomail.com>
Subject: Shallow clone support in v3.0 and beyond?
Message-ID: <aKzy6naLtdeq7Tgn@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f6a8D1g54dBZv83C"
Content-Disposition: inline


--f6a8D1g54dBZv83C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Askar Safin <safinaskar@zohomail.com> posted on the ML about his complaints
regarding grafts removal in v3.0+ (see [1] for the full thread). He also
briefly mentioned future of shallow clones (aka git clone --depth=3D1).

The question is: If grafts support is removed, then how can shallow clones
be implemented in terms of git-replace(1)? What about its implementation
details? How about unshallowing (git fetch --unshallow)?

Thanks.

[1]: https://lore.kernel.org/git/198c29e9058.119e3a5c065010.588862401917627=
4871@zohomail.com/T/#t

--=20
An old man doll... just what I always wanted! - Clara

--f6a8D1g54dBZv83C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCaKzy5QAKCRB7tWyQc2rT
CGHeAP9aRrMPdQ7lwNYd0AiTxCcFgitsJrTmj/lznJVPBpp1PQEApw5iCdX2+cEf
YdSzGQpB+SEpYjW4pe89nwcUK/gmQgU=
=5ND0
-----END PGP SIGNATURE-----

--f6a8D1g54dBZv83C--
