Received: from sender-of-o54.zoho.eu (sender-of-o54.zoho.eu [136.143.169.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB61487F1
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677544; cv=pass; b=fdficYesoyKoNKLVIdASiy2COgO5Ik/VrFhxSg2+36yYlf6OdfEaPlB3CPh7fmaVEMiVLz5CFhoe23lRCHHNRkc9r1txAsGzokiVMEItPZRXS5bfo7Sq5Ti0XAqTU1zs5KTaciJrqqutP4TrM5aBaZ+QyI420Eaj5EOHhGea50Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677544; c=relaxed/simple;
	bh=V9QlIvP2ruygG8q3ArHcR8l176NulW6YoVKaH7DhdXA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CZ7WhTb1tpq0UvE4mYvjQSvxq4ZVVFxHKIN11GmE7qv77l+NzDSfAQIdO1kd2Z0MhRnpGaNLiDp4Tu4CrgM+ZaQ5w1E3MUQ3azmgAOPhx790GASoHK58Go2pWbNXpucj+7YyiFSi4p+JysOCFYa1sEKqdZBtQMPahWGG7SkfdIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b=Q2vRNkSa; arc=pass smtp.client-ip=136.143.169.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orca.pet header.i=marcos@orca.pet header.b="Q2vRNkSa"
ARC-Seal: i=1; a=rsa-sha256; t=1726677536; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=houhrx4eAu48faeGwAwOcPE+mvYB/cRpZOsU33KXyjXnckO0HsD3UYVF4odmCAZ0Umy2nasoMICGSpZxwHBBzEJKm+YjGpWq8yeTgr7GengkJwtRNFEu60GT0AP1CeLdyAvgFlVX95M/FZ17/Y/ZoG0KUHlJGnG5QgBA/yFWlu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1726677536; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+8mOJN35o8+6+pickT6MhTFaP2/YKNwZRSnNrghEcrA=; 
	b=DurXMYhoqbStQ1MZszIU7NV/tOPOSlweP+f5ctIwqOHCDUEBX2n9OPGZVZpPhb0Rm4YM5I0JKBP/NiUzGka26OZZmSnD7eUf8Z7KtKDDt5iLn42kK3vby0gEFo4ROnk8QiTotckFzaKG48n2DYbkVqjNUbI9yG7P74l1txw90yE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=orca.pet;
	spf=pass  smtp.mailfrom=marcos@orca.pet;
	dmarc=pass header.from=<marcos@orca.pet>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726677536;
	s=zmail; d=orca.pet; i=marcos@orca.pet;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+8mOJN35o8+6+pickT6MhTFaP2/YKNwZRSnNrghEcrA=;
	b=Q2vRNkSa1uyFWYGEN6Lw1GHBVg71SqlaylR7In0NHO2T6WUXgrcZCrFS5Gk4D0EI
	MhzW5TTT4iE5v/NKXMl0PGEe/oqxHxBAsuwPEoIInXyUdvYfkCoLPQ9XHoWzPV9Mnj2
	iyIo9BVXbEE/jAYjIXwbww29QmkD6msqqFQwGcZs=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1726677531436963.6251807301677; Wed, 18 Sep 2024 18:38:51 +0200 (CEST)
Date: Wed, 18 Sep 2024 18:38:51 +0200
From: Marcos Del Sol Vives <marcos@orca.pet>
To: "rsbecker" <rsbecker@nexbridge.com>
Cc: "'git'" <git@vger.kernel.org>
Message-ID: <19206003b1a.120df84912389761.6123103044544344593@orca.pet>
In-Reply-To: <03ed01db09e8$080cf090$1826d1b0$@nexbridge.com>
References: <19205ebb4b9.c2a2da5a2387912.3559118454287459572@orca.pet> <03ed01db09e8$080cf090$1826d1b0$@nexbridge.com>
Subject: RE: Permission issue in Git in DrvFs-mounted network drives
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail




 ---- El Wed, 18 Sep 2024 18:30:05 +0200,    escribi=C3=B3 ----=20
 > On September 18, 2024 12:16 PM, Marcos Del Sol Vives wrote:
 > >Under WSL1 (Windows Subsystem for Linux), when using a network share
 > >mounted via DrvFs, Git fails to add any files to a new or an existing r=
epository.
 > >
 > >The reason is that Git tries to open a temporary file as with RW permis=
sions but
 > >mode 0444, which causes WSL1 (or Samba, unsure who's here to blame) to =
create
 > >first an file empty with the read-only DOS attribute set that prevents =
any writes,
 > >and then actually trying to opening it in write mode, which of course f=
ails.
 > >
 > >Seems to be a pretty common issue that nobody has yet reported official=
ly, judging
 > >by the amount of posts on Stackoverflow, impacting not only WSL but als=
o CIFS
 > >under Linux (hence why sending to this mailing list and not the Windows=
-specific
 > >one):
 > >
 > > - https://superuser.com/questions/681196/debugging-git-repo-permission=
s-on-
 > >samba-share
 > > - https://superuser.com/questions/1450094/git-on-wsl-commands-fail-des=
pite-
 > >permissions-seeming-fine
 > > - https://superuser.com/questions/1491499/use-git-on-a-shared-drive-wi=
thin-
 > >wsl
 > >
 > >As a workaround, opening the file with permissions 0600 and then using =
a fchmod
 > >with the final desired mode works, which is a very small change that sh=
ould cause
 > >no issues under neither real Linux nor WSL:
 > >
 > >--- git-2.39.5.orig/wrapper.c
 > >+++ git-2.39.5/wrapper.c
 > >@@ -484,9 +484,11 @@ int git_mkstemps_mode(char *pattern, int
 > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0v /=3D num_letters;
 > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
 > >
 > >-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D open(pattern, O=
_CREAT | O_EXCL | O_RDWR, mode);
 > >-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fd >=3D 0)
 > >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D open(pattern, O=
_CREAT | O_EXCL | O_RDWR, 0600);
 > >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fd >=3D 0) {
 > >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0fchmod(fd, mode);
 > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return fd;
 > >+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
 >=20
 > I am not certain this is either necessary or important to platforms othe=
r than Windows.
 > The /tmp directory is often, and properly set with the sticky bit +t. Th=
is ensures that only
 > The creating user has access to the temp file regardless of create owner=
ship or security.
 > I would prefer that this be put into a compat layer rather than made gen=
eral change.
=20
The temporary file is created in .git/objects/XX/tmp_obj_YYYY, not in /tmp.
As shown in the first StackExchange link, this also impacts Linux machines.

 > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
 > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Fatal error (EPERM,=
 ENOSPC etc).
 > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It doesn't make sen=
se to loop.
 > >
 > >The WSL team at Microsoft has been already informed as well:
 > >https://github.com/microsoft/WSL/issues/12051
 >=20
 >=20
