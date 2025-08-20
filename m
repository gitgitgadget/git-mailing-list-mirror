Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009627145F;
	Wed, 20 Aug 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725521; cv=none; b=NahwMDPj4QfILKR2x4WQ3rlZGdhP5sAIqcn54icNAdeGexZ/vWb28enfcmmkMzz1fCi8cS0j+6lIehXjGngQ65N8sde2WOJCW+9CcrA2BavuxM2VbZhDXGN5YnSJu90wrmG7l3UCvY/ZUwO67dsY4zGs/Hmx3othTE+VV2ehji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725521; c=relaxed/simple;
	bh=KI3LaQ1fw0o6+rBDig54tr9HE7QIF3H1XxcVNFHc0Tw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX3DT/lRJX28JcAGvkGjJn4dCZ9G96SqqemUNgtC/e82VRNI0ojmKQK20Fl9bbBk6PGLBCpvetCNgMlqBx9jlc5GjFJOYdJq0TEnp7Py8qEPUZy9eMec0xMbbGiFw063QyLqyWcyiocPLeXwpJ9W5EYW8WJZNTx5Wf1bfK9ch3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpJP7hlJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpJP7hlJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445806d44fso2531475ad.1;
        Wed, 20 Aug 2025 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755725519; x=1756330319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KI3LaQ1fw0o6+rBDig54tr9HE7QIF3H1XxcVNFHc0Tw=;
        b=hpJP7hlJ55vGS5bIssWWxUtV2NU8ed88UVuFVw3sM1XIkbe3PugLRyi4p7UzbjuyRM
         emR6IuD+794vfgk3aTnTQ1eFQ/QDoFyvJADoulO4uwxWvmQHKIWfSYp6cHQqDVRJlAkO
         ru79xbCMLH2wJrAU3OZkl6CLITHtckrxuFK7MjbCeJTspnPut512moE3QK2fNpx/ZaKz
         8wbmupJtgiDpQy33t0x/HH5SZ9vVMe9xdrDNRycuDCWV+O/zur/zGjndOCVHBOn9wQWm
         /oOhDmOc03+k8XGF5rFms5VliJXItFpqbGwA96UCeW1cYN3hdbDeKjCa0aWFHUgBo7Yh
         as2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725519; x=1756330319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI3LaQ1fw0o6+rBDig54tr9HE7QIF3H1XxcVNFHc0Tw=;
        b=i7ExXqv8yaYfopT1ag0lGNpJlbD50/NlcIkmSVGP+mwcxxg2lqBfhluixuQlqKu29d
         SuYq9HQg1ZI3VBiJu4j4DjS7onz8vWI5OgblwLJhFSjaL62dnm29vP/cr2/dJauRL1Pr
         CCVbs7kNpURM2WCT6cBnPc2HUq43FwmZZad7CRgX8nTeLS4IBlHH1PTWZqmQxZDGZk/w
         iYTpn5fEYRibfD6WrS8OvQYM5MYabZVdfBTu8/Kwt8U+yPlqvCSZtRedy9+BYoXo2NM1
         xsBr29fJr7GULv4gWM8iD9kz+TILtxhdsW51osOc1ihOjvNoB5hRm7atUbgdW6Y5mTbx
         JmAA==
X-Forwarded-Encrypted: i=1; AJvYcCVxKlGQ399gHlDVjKZIoBstEXzjjSTnE02/skZchSqhaHqv9rnJRONMKiJ/3QXkEwpkH9GnLiE3Rcgv@vger.kernel.org, AJvYcCWhDEEZkRPdis+Hbh91Qlsa0928NfZbazOhqujzcCYJRaPlzF60Qo9+FxfD8rcLOfrpec1cVRQXRkRgOUESO0ui@vger.kernel.org, AJvYcCXc01nzVFU5WDXCzCy1NZBrZJt0k93nocQCBk1aTNLzJjdRZNlcC04gS6q1Qh9bMpz3SGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJtG/h3arV9fi9tCT9Xwg39BU6k992H4B5/McbtFPk+FQbjVz
	YVht2i94eNN+BCPqKuWhdEDs1gA5Dwk3xI+MSVqnTrOSTJ3qXPiNaoie
X-Gm-Gg: ASbGncv7AuOckceL961IYoUVk/PZlI5Rc90QPdM7+vUm3hMljcsufC0DI4IR8Pv+tLt
	ruLeq9kSDyXqT/vyHH3yWi52dUgmYKBlvPFTM8VnQ2jLxZ5ow6MJZvVrBf2Ilji2sKslNuJ2BYd
	1M7dcrt330Sknol6s5ZUsNKepRiR1wKXr8GfGYKlxQsMtencPVEeIkuX5zFtEbaKrz0h3650dId
	tTUratgtCDqooNAgFZsZtOgiedzxag06bqV7GI9ZPvVGJ7DGyZCuM8PMkbzlU3fKn/+vdlI21im
	c19b1raTFq87Ynojc7eNC6QAJOEuUicNzFJuVqDMYwD0SYBsO3ouN1KcsaC0OQBD3Ry1icmtNF0
	vtkVI1gpRsEzKAJ0rfR5/Vw==
X-Google-Smtp-Source: AGHT+IHXnQkA6v146KKoCafbiFWO3366g7ibhUgcVzoSqTmRJ3fVK75TlT5LmFWMHbk3AuodFVDgyg==
X-Received: by 2002:a17:902:e84d:b0:243:597:a2d6 with SMTP id d9443c01a7336-245febec9d1mr3977275ad.1.1755725519058;
        Wed, 20 Aug 2025 14:31:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed361422sm35848205ad.52.2025.08.20.14.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:31:57 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C493D4207D14; Wed, 20 Aug 2025 21:11:30 +0700 (WIB)
Date: Wed, 20 Aug 2025 21:11:30 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Askar Safin <safinaskar@zohomail.com>, git <git@vger.kernel.org>,
	gitster <gitster@pobox.com>, helpdesk <helpdesk@kernel.org>,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	kernel-janitors <kernel-janitors@vger.kernel.org>,
	linux-doc <linux-doc@vger.kernel.org>
Subject: Re: git: list of my complaints about future graft removal
Message-ID: <aKXXkvAOhStlS2_m@archie.me>
References: <198c29e9058.119e3a5c065010.5888624019176274871@zohomail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0n+dSVK2aIu7RrRW"
Content-Disposition: inline
In-Reply-To: <198c29e9058.119e3a5c065010.5888624019176274871@zohomail.com>


--0n+dSVK2aIu7RrRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 05:57:08PM +0400, Askar Safin wrote:
> * As well as I understand, "git clone --depth=3D1" rely on grafts, too.
> I hope "git clone --depth=3D1" will continue to work.

So shallow clones should use git-replace(1) under the hood (both on initial
clone, deepening with --shallow-since and --unshallow), right?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0n+dSVK2aIu7RrRW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCaKXXjAAKCRB7tWyQc2rT
CP5vAQCVKbnTs4dGZkVn+48GVLHMgTTCrhBdAf5SGiuxFxCxqwD/RZwArnIcVMLF
rewkM9vMJB/bzQxt81QyHh4mA+m8gwA=
=mSTU
-----END PGP SIGNATURE-----

--0n+dSVK2aIu7RrRW--
