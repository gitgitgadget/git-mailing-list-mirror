Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50EE19ABC6
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516521; cv=none; b=kXTUdY5ix8WbYp5eYzZwmZOJ/HwfCJP4v49V6M0DwRofncFv+cox7yJBO+EXpoocTqkecVDuB8kVTQ4/yaCmEU+6dsFfwn8ZVeNY6BU/ha122QN6L90trvJ0lcyw8buRS+N8oHnn+O63JGWYaaDDBgDwu80QkTP5e6qLQIIUWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516521; c=relaxed/simple;
	bh=VpAVWD49bjaxnbnGxJEOQuiygNsarsSPJQDIxmcgxiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BsQJX9Xm9Wy61X5rcT6vIZ1zRCAczuyDkXciwMc0nL1H9JMU23mq+Cp39ZZjg5D4w0vn3943HiEoZYhJXEC2AUuYr09tSZ6oMGKpIhcuSf8IPml9CqBpaM0sF/pqlBTLsV3z3194IxN4II0xYnjXVkyc/pxhqNEdJgPFaGlFL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKZ1W8sH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKZ1W8sH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b662090so50384655ad.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734516519; x=1735121319; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpAVWD49bjaxnbnGxJEOQuiygNsarsSPJQDIxmcgxiQ=;
        b=KKZ1W8sHn5wc+KWOm/sNWHgMcWOkPhdEr4t54D3xqfL3+Et8yDWDL2MMyXqDg21c8d
         EP4V2cN4Bmf+icePv5CZUzAQiIynhORSBgAANDCgTCr1J6OAmkbZurbXl7hZsYyd7g6B
         pnxbgh7eMfXBzRlwS9hocpJWajG115/TDcEoqUCmHf//Aj8J+BgL5xEoRFORyVeImfwH
         4gNAK/LSLVsYtOMABMVfxFdzcp8zt0J7aJpC20xXEYFmCzqHPrpEAc0AvzT0qUX7rfc4
         4zHJS2brZtmS/cr/JihcOUINsTo2lVcbH5Tg6HF4aiUfZU6omhSa6zqZqr5CpjEsenaB
         gG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516519; x=1735121319;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpAVWD49bjaxnbnGxJEOQuiygNsarsSPJQDIxmcgxiQ=;
        b=GOYwKo/waeHXa0L2J/NE3oWe6+0yrmk4xdoQzkMy8Ucy9DdEaPoZXz4//Lf0t2pDdY
         4ecsXqFON7iVo1+8Xkq1XLr73EckeS0gEFzsc4GZd79F7lYslW99JCN7lR67NpB6F7yw
         EAcl47mFpcQ+3wvqCavmgOa1ox/JvfksYnfWtuO2Q651zGF48eis+lV/CTp5sWjmptGV
         n1VFfye7iWf6jV+v4wAtsnil+8/uaqMUM8vx+qVUSpUiWG56fRUt6JAk047uTeqEnzHG
         Vc6M1lfr06Qss2jt7PGeNa/e7UfqjY3N4rNMLhraFSzyktZs/hkPE9GFdqAuulF3pYSt
         5Rdg==
X-Gm-Message-State: AOJu0Yy8XvY/xpQuuHObcGFN8GcuQ/waF2Sp1/LYQ7fgqr1v1rnnYsjU
	QtCliEpHoJMyEXoShH8X7qeLhFQ1RZXzeQ5otef/HWoQzvGROf/YQXNXdg==
X-Gm-Gg: ASbGnctdWvPFJ1uDrgp59RRyUQ1InqSR5hVu8zI98R25fXzyM6zhrHz3h8wZ7u9EYbW
	wRZ79lNrTomO+iAXBm+edmZo0hIX730CtXtdjdyz7NvdkCQHVAvNBpEx+p4C9lxbvIEznXTDw86
	Co5jHihMAbppkXW0C9fNw2EhjBXKBAyURVkByIPJzieQ78qVvR+ZyJtv2ZKkoTCCO0wsSmyIK7P
	8Ye45VeBuolxyoXuKdIj8WwWkAgPoI8DnmKUm7ec/Ea5Mu3r8yyONuX
X-Google-Smtp-Source: AGHT+IFTtv5K6nn8C1ecuMlrfKQFe/wlwuvdxZrHH66bUnCdSsbiS+jbz5wW8xX5EGOaqLTjbS8mZA==
X-Received: by 2002:a17:903:1105:b0:215:ac55:fd72 with SMTP id d9443c01a7336-218d724d2fbmr35645705ad.37.1734516518760;
        Wed, 18 Dec 2024 02:08:38 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db7c82sm73178055ad.13.2024.12.18.02.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 02:08:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id BA3F64285C0A; Wed, 18 Dec 2024 17:08:34 +0700 (WIB)
Date: Wed, 18 Dec 2024 17:08:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: OK to submit l10n PR with signed commits?
Message-ID: <Z2KfIl87JOWdcGR3@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BdZZBvboQxPEwQd8"
Content-Disposition: inline


--BdZZBvboQxPEwQd8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

So I'm interested in GPG-sign my commits (that is, ``git commit -S``) for l=
10n
pull request (which I should submit in this cycle). Is it OK to do that?
Drawbacks?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BdZZBvboQxPEwQd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZ2KfEAAKCRB7tWyQc2rT
CAbsAQC+NKmdlmbGRZe5MAZXfLS2iKcqVyLeRNtM+9GTGcl6rAEAm42mXDM/fJ7J
nmGMHLdDzggkVrObWB0tBnRLCMXnEQE=
=d5JI
-----END PGP SIGNATURE-----

--BdZZBvboQxPEwQd8--
