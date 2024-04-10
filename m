Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005069473
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712720122; cv=none; b=K47DF5TCcQWbRKtaqzP8CEAWVzzagISklPc9dgtsILCrG7AESZEWToA2K6vR/eXC/CU11wvXmkieYc8ri1s+oRsl26lhnzaRHzy7nTNsmb2YiFcKskE7aTINnnBXuAFzo+1Iw9poSLNAn5tTrdLXmV+d/mKPiv7lXHLsuxYtGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712720122; c=relaxed/simple;
	bh=xxk4+GPtjoiEQOZ1HzUNPd0aBpX3zuQ6Y7lz2tkHXRY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTEwC6BdCgkLf3z3PregF6+1CiVuhRD7Wxr6caPAPh/QzbzqmX2/YX3j98HTpx9whoxv5QvXNv7I0t4/j0FULTmF2rdpOZZujTvxkylRuzGvrJ5Jm6EqWNKBsVpcd1U9KsYvbQxjs89qUZjTD6n9oYJjCIT2ek2F+TC9j5fWbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqWXRFCx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqWXRFCx"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso1407225a91.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712720120; x=1713324920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnLwHFCbh8jjvY6twzYyKMURSB9qQ3F9OUy0cWHgf6Y=;
        b=fqWXRFCx5Ai8RTxuwiSshWUB7vgzLh2yiQ/kSTDe9aBUX++ATl6kpTAqgga+42EOmL
         ar1rs8zqZpFZzQOTIZ4RQx5fWeDfFRrdJt0jXqyztf6n8g+OTUI6+ybtGm7AeHhJhjoG
         iqOyQ15almFNJL5am+vGULvogK4NIi8p0+2rUknvN7pk/FSFanVN0tHTJsZaKRBfmWf/
         SF6f10OckIQCVBpteqTCpHT8Ira4CCA+D7mW210R0DfIgpRiWhef/WnRmkKM/a2p2wyx
         J3tsljcdw0Bx/ngrO/LGjUPWTValDCu3GGwMhgVjJ2RhJJuDzHK1dmM63h67f8T6yviD
         RsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712720120; x=1713324920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnLwHFCbh8jjvY6twzYyKMURSB9qQ3F9OUy0cWHgf6Y=;
        b=FGi81MyT97xbdf/5dO+AYECDe/r3tMCbl4roumlYxmuaAPzizK4YzF0yhTjm3ejMle
         Hvs8E6k8wJbR7qtqmbtb1/DFMPu5ypcJ98ip84nYKP64tXUvovWaUN5pI8dhNzI/tHe9
         2vPuYF46BubcLx74pVT3vj1YOyw+fnqX2QIRKqhdPQMxp2uMSdTO4Mar0EaGrNpArdLj
         XKbD5vlKF2nOZQlbp1k/li0ReJhXXwZ+fxb5Ths+WDpi7yRXO1gNQB7LpDwGT6vKZgE8
         2Twoj64JDn8HcaPPBK4vvQKLOsd9s7Q4dzwVGPtQIjYE0vfwbnzHFGzFRJ+o3m+/zC6D
         WK4A==
X-Gm-Message-State: AOJu0Yx9ON05wfKkn3bxayWoq5aPaI5AYj+JwCPwXmG/wwP1PlHiGEZR
	jGl9+BRbTZYUI3vLOpSexHoCuDA5pfDu80bkaiW/7/vdjR0SndYuR6MlWXj4
X-Google-Smtp-Source: AGHT+IFiq1FqnOuMUskavseOQ8IAU0b/xy0MKsqm9ktT+PeKetWsZGwmNv1oQwQ+334i33DdnEU5Kw==
X-Received: by 2002:a17:90b:512:b0:2a5:3f30:f5f6 with SMTP id r18-20020a17090b051200b002a53f30f5f6mr2125406pjz.20.1712720119982;
        Tue, 09 Apr 2024 20:35:19 -0700 (PDT)
Received: from localhost ([14.191.223.174])
        by smtp.gmail.com with ESMTPSA id er23-20020a17090af6d700b002a5dbfca370sm83200pjb.48.2024.04.09.20.35.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 20:35:19 -0700 (PDT)
Date: Wed, 10 Apr 2024 10:35:16 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v2] t9604: Fix test for musl libc and new Debian
Message-ID: <ZhYI9IjyTQHv0vsN@danh.dev>
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
 <20240410032812.30476-1-congdanhqx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Y65HPMMYd49+4w6"
Content-Disposition: inline
In-Reply-To: <20240410032812.30476-1-congdanhqx@gmail.com>


--3Y65HPMMYd49+4w6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-10 10:28:12+0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <co=
ngdanhqx@gmail.com> wrote:
> -test_expect_success PERL 'check timestamps with author-specific timezone=
s' '
> +test_expect_success PERL,POSIX_TIMEZONE 'check timestamps with author-sp=
ecific timezones' '
> =20
>  	cat >cvs-authors <<-EOF &&
>  	user1=3DUser One <user1@domain.org>
> -	user2=3DUser Two <user2@domain.org> CST6CDT
> -	user3=3DUser Three <user3@domain.org> EST5EDT
> -	user4=3DUser Four <user4@domain.org> MST7MDT
> +	user2=3DUser Two <user2@domain.org> CST6CDT,M4.1.0,M10.5.0
> +	user3=3DUser Three <user3@domain.org> EST5EDT,M4.1.0,M10.5.0
> +	user4=3DUser Four <user4@domain.org> MST7MDT,M4.1.0,M10.5.0

Not sure if it's a good idea to change those CST6CDT, EST5EDT MST7MDT
to some non-sense likes: XST6XDT, YST5YDT, ZST7ZDT, though.
Since those characters are for decoration purpose

>  	EOF
>  	git cvsimport -p"-x" -A cvs-authors -C module-2 module &&
>  	(
> --=20
> 2.44.0.rc0.258.g7320e9588666f
>=20

--=20
Danh

--3Y65HPMMYd49+4w6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQpKtdjjNYPYlBV4GKki1K/DqNHWgUCZhYI9AAKCRCki1K/DqNH
WkrPAQCK8ap39CWQXufd0/XoCjQHwMXDpjX4DaDvimUga4AF3wD/a5YYlApvUJoH
6hSWLj4lgavaNy1RG8fnIJwN2jqiAAo=
=cDiD
-----END PGP SIGNATURE-----

--3Y65HPMMYd49+4w6--
