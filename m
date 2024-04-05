Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33F16EBFD
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347461; cv=none; b=i9993CuOeCAQMPgNNPNcMXf4m3imTROdIbJtDzJFhkzaLZ1ElM6T40ZrKqpMhOT9phyAAr/wi8DZo3byJNnTq9Vk1noBN/xQ3wQC93vWomxzEoIF3ZHh8g39wmej+LBNLWK7ptRJZXb+Fg4UAF+u4z7kYsekGCDYCXbVIkaj+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347461; c=relaxed/simple;
	bh=ykXlLzRxZr002sRFJ3DoGySXbidjDkazQn2Ni2Jtx2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnVO4/ZnCnlMrkhPw35YWcuT+KkOPfjEaWLpBrxMVXp8+x4AfCMk+o36fkmuqrX16DYzl/IiFQElAZ62dKwUM6uORX8UF44Mbu4ux+q5irqyCKpZrpzaT/Oo/L24iS4jvJ2bxMhbfMvWJrN5jnAqfbrgWjYvZ3NJ9N3RktXtruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=q3I8lCL/; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="q3I8lCL/"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A0D1F5D4BA;
	Fri,  5 Apr 2024 20:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712347451;
	bh=ykXlLzRxZr002sRFJ3DoGySXbidjDkazQn2Ni2Jtx2M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=q3I8lCL/9hvtfGUM6uMiULkIucLP5PAJTQ8InW7Hnd4ht6KADD1CNuTiuNLDAJ2Ct
	 1MHy9qYVqMgk7tgnvDBJClTcHtUEDAaELW6PMpsjy9yeW8ec4AtvE3wL8CiSXcJWLn
	 HpXYZtdOBA+v31Dno2EKIro5aYJzcwx9mhW1+N/DFjUD23DUZmn+nA8JtegflnoWq3
	 3dnuZy/JHa1nSipvok75KCbQ5+lQm7VIhuIWoCda9Dm1d8vvldg7jA+XaPjVM1w+Gb
	 bEXBDneDFFXxprzrxjOTXQY7i/W/31R64iL8nQRqh1O79pnDr6GZ4Zz3qSJZD2hIdI
	 HTMM4RyN6N0JyK935kzCcyH5BrFduGAO+Yoy1+414SrWklaLJT0rtq9Yj1kpSOUYYL
	 Lkz2QnoLVwsQf/lTIK4o/JkFF3oE0LgMtwD5+SUPObrkKwnfz99gKSEJod5F4AfKSV
	 aK+BQ+Z/DBcpKpLSdxRRzXGrGlXRS0Y3x7b1mnkNcdqrabeB7i0
Date: Fri, 5 Apr 2024 20:04:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Matt Cree <matt.cree@gearset.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: Unexpected git merge exit code when killing merge driver during
 ancestor merge
Message-ID: <ZhBZOY1aEFW4YoD8@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matt Cree <matt.cree@gearset.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
References: <75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nzz962X89Gs8MBkd"
Content-Disposition: inline
In-Reply-To: <75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Nzz962X89Gs8MBkd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-04 at 16:16:05, Matt Cree wrote:
> Hello all. I have observed some strange behaviour when exiting a custom m=
erge driver that I was wondering if there=E2=80=99s any reason for =E2=80=
=94 I think it may be a bug but I=E2=80=99ll leave that to you to decide.
>=20
> I=E2=80=99m configuring that merge driver to exit during a merge at the f=
irst sign of conflicts =E2=80=94 the exact nature of the rules for the deci=
sion to exit early isn=E2=80=99t too important I think though so given it=
=E2=80=99s =E2=80=98work stuff=E2=80=99 I=E2=80=99ll leave some details out.
>=20
> Here is my current understanding of how the ort strategy will deal with t=
his.
>=20
> - Ort runs the merge driver with the parameters for the current file to b=
e merged
> - When the driver returns exit code 0 is returned it is treated as having=
 no conflicts
> - When the driver returns exit code 1-128 is returned it is treated as ha=
ving conflicts
> - When the driver returns exit code 129+ is returned it is treated as som=
e kind of error scenario
>=20
>=20
> Then subsequently
> - If all files returned exit code 0 during the merge git will return exit=
 code 0 i.e. no conflicts
> - If any file returned exit code 1-128 during the merge git will return e=
xit code 1 i.e. conflicts
> - At any time if the driver returns 129+, git will stop merging and retur=
n exit code 2 i.e. error?
>=20
> However, when setting up a criss-cross merge scenario and =E2=80=98short =
circuiting=E2=80=99 the merge during an ancestor merge, I get exit code 134
>=20
> Here=E2=80=99s a couple of quick scripts that help recreate the situation=
 https://gist.github.com/mattcree/c6d8cc95f41e30b5d7467e9d2b01cd3d

Thanks for the repro steps.  I'm on Debian, which uses dash as /bin/sh,
and I also use a different default branch (dev), so I was able to
reproduce with the following patch applied:

----
diff --git a/init-repo.sh b/init-repo.sh
old mode 100644
new mode 100755
index e0f42a4..25d7f25
--- a/init-repo.sh
+++ b/init-repo.sh
@@ -1,5 +1,5 @@
 rm -rf merge-driver-test
 mkdir merge-driver-test
 cd merge-driver-test
-git init .
+git init -b master .
 git commit --allow-empty -m "Initial"
\ No newline at end of file
diff --git a/run-merge.sh b/run-merge.sh
old mode 100644
new mode 100755
diff --git a/run-recursive-merge.sh b/run-recursive-merge.sh
old mode 100644
new mode 100755
index 6920720..c63d652
--- a/run-recursive-merge.sh
+++ b/run-recursive-merge.sh
@@ -1,3 +1,5 @@
+#!/bin/sh
+
 cd merge-driver-test
=20
 current_time=3D$(date "+%Y%m%d-%H%M%S");
@@ -12,7 +14,7 @@ featureA=3D"$current_time-feature-a";
 featureB=3D"$current_time-feature-b";
 featureC=3D"$current_time-feature-c";
=20
-function writeFiles() {
+writeFiles() {
 cat > $xmlFileName << EOM
 <?xml version=3D"1.0" encoding=3D"UTF-8"?>
 <CustomLabels xmlns=3D"http://soap.sforce.com/2006/04/metadata">
----

I take it from the "Abort trap" message below, you're on macOS, but I
don't think that's relevant to reproduction.

> The logs also show=20
>=20
> ```
> Assertion failed: (opt->priv =3D=3D NULL), function merge_switch_to_resul=
t, file merge-ort.c, line 4661. ./run-recursive-merge.sh: line 162: 78797 A=
bort trap: 6 git merge $featureC --no-ff --no-commit
> ```

This is definitely a bug because we triggered an assertion.  The
assertion asserts that that case will never happen, so if it does, we've
made a mistake in our code.

This also explains the 134 exit status, because on most Unix systems,
`SIGABRT` is signal 6, and when a program exits with a signal, the shell
returns an exit status of 128 plus the signal number.  Because a failed
assertion calls `abort`, which raises `SIGABRT`, that would lead to an
exit status in the shell of 134.

I've CC'd Elijah Newren, who's the author of merge-ort and who wrote the
code.  I'm not familiar at all with merge-ort, so I can't speak to what
might be going wrong here.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Nzz962X89Gs8MBkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZhBZOAAKCRB8DEliiIei
gQZCAP90JlRAFBqUs3MIIbcxlUlVAphR/+4AzaNAqY0+iPGOIQD/TLY0UtIyzDIe
maMlix/dVX68gMpqAiVWTei+zhTUrww=
=twBH
-----END PGP SIGNATURE-----

--Nzz962X89Gs8MBkd--
