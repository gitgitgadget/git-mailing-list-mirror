Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974C13AD29
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137073; cv=none; b=YaybsM23ep+t1Q/m6z6f65bLJrR5/jymgUycT0qYNgDMFT9pCNVXHl7/rYzIskaWUKeQT13Q/gKe1vAbaEr/vwV3tqMeB8OSBRE2eRDykIRLKPRjRpbs1bkrjrlQYlfkWxS+Rxy8NTksIn5QwCNF2VQSnogG1TmfoCzx3o0EpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137073; c=relaxed/simple;
	bh=Pm33O2Q2PO6/o8SIVpRaIJkXfOnRLViN8n1K8aBWcMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ivwyJcEZyj+CGhusATWN+P5ihhwpHrzhjF4tUSZg/9PQ7og04dBA0EflogemdykNSekVTT7rCarT5AJ7EvJmTv3jaf4WEve7itcqtOv+cHaXuX59Vo3iUPrbJbYN9g4Hmcf09DTacjLBEpU/HWo6HdU2XEGjP5v/ZUDy622uthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHVAMJID; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHVAMJID"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so384556a91.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729137070; x=1729741870; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUyUAqblHJRgb4Ds5xzmYy6uButrEvWsOs4DcDPItRM=;
        b=lHVAMJIDOIo+bGJSOx5cZMBW8w8C9PvSuv7lOqoRyKkFyE921W9hJKuv+89VisUW+4
         DF+2oOW7ndwTTcEb0/OFYWgkq5Ut+lDccBa/xT02pk8gjAaB3Lps6IS6Q9FKCfeUrQg0
         zCwBPcn4FaNHAikkKAcm2H6ybwY4nl6CZV8ytQYjTUQJ/eTu986M5bgIrp873Qa/8hG2
         iETmRUQvXXN282ip6FYZTLgOmJf8GWbbr3z1o475FbIF9dMn48soH6ug+btc2pHPKlX7
         k274B5X0v6zdTSthTw3BBxOUaHS5gvCUWwWxievHc3yNSluTVwFDvRMtii/d1XuvI9fU
         vtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729137070; x=1729741870;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUyUAqblHJRgb4Ds5xzmYy6uButrEvWsOs4DcDPItRM=;
        b=CAvXqMEQe2UHZw6O66yudExkJs7OlIK+bn6Yr7k780q2mmlrMYDuAYwU6x/7iqYjU2
         BEaFAEpJCWBm/rq8oBFkt9xhx95fXwGW7esc3avcYt5eIrCqhn7qEuIv29KvbhonjPpD
         GaQjr7wiJlN75hmEB0w1z19F9AJd5OIizERIuLZxE4Sjl688friS+4CozvGMQLQTIm7M
         JP/eJgcJcVW064t9gkRbxcAckWnTIAkXOY/a7bzKJNhIeOuuCMM7Me9JOcSGp0HgEk+5
         6mxDx5xAm9qVLo+XvpMxEUjvgBKFFmZfDdLsP/ZfIjRE7oyN91TIim4fnNYbUiiDUh9W
         1JPA==
X-Gm-Message-State: AOJu0YyrJ0s1RONgplQJxWmsOE/83bU9KtppCPjekak0l6whkCDtjSnK
	2vf8H2/UpDjYhjyxB5hjZnW5m2OMwAFIdnxpaVu0MAfMX99e8Pkp
X-Google-Smtp-Source: AGHT+IHp5x4Rfhaf1xOL/Q8GXdJsnluJCvhRcx0uhK95YVEy6Zk2u/yOCY+c5Ql/B1sdtX+lQA0ijg==
X-Received: by 2002:a17:90a:bf09:b0:2e0:d1fa:fdd7 with SMTP id 98e67ed59e1d1-2e2f0d8dd21mr23573108a91.27.1729137069664;
        Wed, 16 Oct 2024 20:51:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e0924a40sm692233a91.41.2024.10.16.20.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 20:51:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B6ED241A3B24; Thu, 17 Oct 2024 10:51:05 +0700 (WIB)
Date: Thu, 17 Oct 2024 10:51:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxCJqe4-rsRo1yHg@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N2V9m5+EoySDaDxH"
Content-Disposition: inline


--N2V9m5+EoySDaDxH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Since clar unit testing framework was imported by commit 9b7caa2809cb (t:
import the clar unit testing framework, 2024-09-04), Git FTBFS on uclibc
systems built by Buildroot:

```
    CC t/unit-tests/unit-test.o
t/unit-tests/clar/clar.c: In function 'clar__assert_equal':
t/unit-tests/clar/clar.c:767:23: error: unknown type name 'wchar_t'
  767 |                 const wchar_t *wcs1 =3D va_arg(args, const wchar_t =
*);
      |                       ^~~~~~~
In file included from t/unit-tests/clar/clar.c:13:
t/unit-tests/clar/clar.c:767:58: error: unknown type name 'wchar_t'
  767 |                 const wchar_t *wcs1 =3D va_arg(args, const wchar_t =
*);
      |                                                          ^~~~~~~
t/unit-tests/clar/clar.c:768:23: error: unknown type name 'wchar_t'
  768 |                 const wchar_t *wcs2 =3D va_arg(args, const wchar_t =
*);
      |                       ^~~~~~~
t/unit-tests/clar/clar.c:768:58: error: unknown type name 'wchar_t'
  768 |                 const wchar_t *wcs2 =3D va_arg(args, const wchar_t =
*);
      |                                                          ^~~~~~~
t/unit-tests/clar/clar.c:769:65: warning: implicit declaration of function =
'wcscmp' [-Wimplicit-function-declaration]
  769 |                 is_equal =3D (!wcs1 || !wcs2) ? (wcs1 =3D=3D wcs2) =
: !wcscmp(wcs1, wcs2);
      |                                                                 ^~~=
~~~
t/unit-tests/clar/clar.c:784:23: error: unknown type name 'wchar_t'
  784 |                 const wchar_t *wcs1 =3D va_arg(args, const wchar_t =
*);
      |                       ^~~~~~~
t/unit-tests/clar/clar.c:784:58: error: unknown type name 'wchar_t'
  784 |                 const wchar_t *wcs1 =3D va_arg(args, const wchar_t =
*);
      |                                                          ^~~~~~~
t/unit-tests/clar/clar.c:785:23: error: unknown type name 'wchar_t'
  785 |                 const wchar_t *wcs2 =3D va_arg(args, const wchar_t =
*);
      |                       ^~~~~~~
t/unit-tests/clar/clar.c:785:58: error: unknown type name 'wchar_t'
  785 |                 const wchar_t *wcs2 =3D va_arg(args, const wchar_t =
*);
      |                                                          ^~~~~~~
t/unit-tests/clar/clar.c:787:65: warning: implicit declaration of function =
'wcsncmp' [-Wimplicit-function-declaration]
  787 |                 is_equal =3D (!wcs1 || !wcs2) ? (wcs1 =3D=3D wcs2) =
: !wcsncmp(wcs1, wcs2, len);
      |                                                                 ^~~=
~~~~
make[1]: *** [Makefile:2795: t/unit-tests/clar/clar.o] Error 1
```

See [1] for the full build log.

Thanks.

[1]: https://autobuild.buildroot.org/results/8cc9795dc18277926dd386eb1cb9f8=
c9b65b0042/build-end.log

--=20
An old man doll... just what I always wanted! - Clara

--N2V9m5+EoySDaDxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZxCJogAKCRB7tWyQc2rT
CNeJAP9vZ/zYLaQQJdKR2o+qz0ZDVxcCMaz3Z0/VHgOWJ8/FvQD9EMkC3pEsYbdi
eTmcXte4lBlosPRLLIn+I4Gft9Cm8gQ=
=ReFq
-----END PGP SIGNATURE-----

--N2V9m5+EoySDaDxH--
