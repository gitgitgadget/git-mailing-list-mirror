Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3AF7E575
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824167; cv=pass; b=tKDFCHZ6/uq2TmC/ETfRuhFnrbDGKQ2UkZunipJDTz6y8EnCX64i26A3+DgFffXBw43ATGmJ71y/JBjtOGvjpUiGBOTk64xozlGnSq12z9PRly3xnc9AVNaTb29tUCuXikTRpdrzFl1pybwAN0VEbJC8hzL7x2J+07tFRqicGV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824167; c=relaxed/simple;
	bh=PfLD6cNJzwqvC6CZ7Fsj1y6qLx+P9aUUuJrF/qB1yZA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=J7z8PNeTyw/OVaB9N5jChqAUuCXy7GQe/oJgkz99jY8bSot+ihw4hUs+2tH5DV9MBreY9n203wSzaMHsDhraofw1+XDKjcTjRgofobotaTn3+cAHxPElGyd+K12ni9ILkhFJW2Bo6EHm/+5DOfOlcSE14LSui1i2myBOaZ0Gzhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de; spf=none smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=jfMiNOMw; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=yG0RySt+; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=aepfle.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="jfMiNOMw";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="yG0RySt+"
ARC-Seal: i=1; a=rsa-sha256; t=1726824155; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IK1AozTJUIMA8SGHwUczbfae5nFZVxqNOg5mikX7MOMWV4JValfka9ee8c10DmXII+
    RUh2e1tAJe2B28cqOieEEyHuWqyV8muNsBp3dEZEo9cySQIJU0ZIizFNwAVfvfaJGrAr
    vVnit+nuBKjPOZHtTSA++7lQL/MeIH01P4/NtAJBdh0Ze991TkepEJ/OXykRGG0mKQEb
    afz/KRL3Uiq8HZqlA7X4FJR4JCX9zFsuMsmbRb//VUAl6fvxRwGOiLu0aaWIKf0fCrEJ
    hHUGvvERwLf73gXgSEneaWeKL8s2pLQ9Ie3hzzkR7jRsUG54nZEJz9llW1/oicsvdURO
    4wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1726824155;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=PfLD6cNJzwqvC6CZ7Fsj1y6qLx+P9aUUuJrF/qB1yZA=;
    b=Ab5yMyVbS+R8lqstvUsYIIM7nKxN6+VKINAbKqw7wEFLoN0ZIP95BgT5HN4FrDdjC/
    Xggyn/GjQdvj/KHSx2RFUDmLTyss2FJXBiFNQIwlTyS4jaTGdd+jJVJgdzOASx4bH+gE
    RMZDIM2y91jhlbylyDM2xPuK+AfIapGHGYAx75dhD7BFJLKP8NKgCOKd/WTUWiE/Y+v4
    YXpUMbdqMByADb5lcZw279ig4awJl5hW2RdVdvxw9XhPX1PSNtnei+d80LehRmKcGt6l
    0DRgX64898XFS/tw6vvDVyxAw0Rj3+BM6Kj/4Qdy5wx9g7FD7cb46N2Vhc0A1DIUuIVq
    ZRMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1726824155;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=PfLD6cNJzwqvC6CZ7Fsj1y6qLx+P9aUUuJrF/qB1yZA=;
    b=jfMiNOMw7/FxKCYVh/I5xGBiaVQD+7mk7kpe1ev0rzPlvSNjfvpJUlp9DsVrp4P6s2
    vbfNshreDJXejPC+dgChY5gSjRr+eejLaKc0BTkubxuh2mQZjdhA+lwygZvRfltHces0
    YilnXzqx8Z8iiGVQpPRib7RiMPbZyoH3M5gzecG8DwlvBG+Bnda/Ut6FEUTF2dig0/gQ
    jCYLTdxibfzww7F+vNR1vMRypqR6Hc9swDWN40n5KTWOCtfHjDYeR24kE3IJD/KKY/OO
    lMGNL4UdkLqHT8CfNst5lF3sJy9YiLAsp6Cup/yds+WYcOzxrEewQdWLj64OeOVp39fx
    xzKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1726824155;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Subject:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=PfLD6cNJzwqvC6CZ7Fsj1y6qLx+P9aUUuJrF/qB1yZA=;
    b=yG0RySt++QQYSOy/Kh+XOzVGkJqqPmNoiReiOXaqKcUsFFGeDEt/5Hyn2p9XAHinmq
    VpKcODzlXpWuZsa52ABg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5VEKIax/sLA5PjG+a3nR0I7kGsLPFkbaL4YR5vA=="
Received: from sender
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id D2e8f208K9MZ213
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <git@vger.kernel.org>;
    Fri, 20 Sep 2024 11:22:35 +0200 (CEST)
Date: Fri, 20 Sep 2024 11:22:28 +0200
From: Olaf Hering <olaf@aepfle.de>
To: git@vger.kernel.org
Subject: BUG: diffcore-rename.c:1674: tracking failed somehow; failed to
 find associated dst for broken pair
Message-ID: <20240920112228.3d1130f5.olaf@aepfle.de>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DsQfsgWHWyv/x0LcOoIVZKv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/DsQfsgWHWyv/x0LcOoIVZKv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The following issue left my terminal in a weird state.
Is this a bug in the repository, or a bug in git 2.43/46?

set -ex
pushd /dev/shm
test -d x.git || git clone https://github.com/intel/linux-sgx.git x.git
cd $_
git checkout -b $PPID.$$ a53adeaab7a8176fabb415bfcdf6d29fe4060678
d=3Dexternal/ippcp_internal/inc
git log -p -b -B -w --stat --follow "$d" |& tail
cd $d
git log -p -b -B -w --stat --follow . |& tail


Thanks,
Olaf

--Sig_/DsQfsgWHWyv/x0LcOoIVZKv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmbtPtQACgkQ86SN7mm1
DoBQEw/+Ndo/avJqh3zEYE5Fdpb0sRSn5UHDldBh4EekrnLTThPnKh2l/y9MBNUe
ROH4ETn27Omf6qD8msDgFWY/RUXBTY4sXx4lZLiwh9U0EQwZ+jV0cf9qnJNulxKM
/6tq+zUY2/VaXMcQ0yLHUsfq1/YCFiz8/Vvbx/ihftec/aS+6gk2v3FJrJjxX8go
SV9H6Fptclwo8HDhLeeThInu2MKVJnIM1t6WtQDLvCbdO4NpcmgiKXWeS/C6rywh
u04POqDP2ZMOpgjV+kmI04f0j/Ckr5XgZGQoquYUbyjDv9eyMt1hVLeFKL5HzVAp
On34zWwBp8AQ8rrltWjWdNJV3/vZepnIKUM5xEIlXmiYWX8Lx35rgwTwSkpOPdKE
7RxW/cZ1a7j01RK/joWpWEOVEemfl13eJ0eH1gX0HzVqE9Fa7tGuA3Ur/ng/OBDw
fHz9eWicynxGAA3OaBhMkPI6Ozyw65REo8kL+5LjK5PEqFweekQvjA0WthvYG52p
FnMf3WDrNES0Ku2pX7PPL/3wXHLlpIFusIf8zDXGU8pJ+GlCoKoPtOdWtUnkci77
5ZJ0FOkxzLb5pbpIOe1rM9GlmM2kiIZAvHVSgBDA21qheERoB3T5mYqvObcCG8tc
zWwLAo0Kb5/hIOY5t0uCoBKH5nQJZdO+y7W/lqIVQOs9Duf+aZE=
=fFzJ
-----END PGP SIGNATURE-----

--Sig_/DsQfsgWHWyv/x0LcOoIVZKv--
