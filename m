Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [46.4.70.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562E139D
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.70.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736623973; cv=none; b=UpdyqmzbrBKpbeSWlbl89+/1Lqo4p7PvCO2Iq+h9AYvXMAPXNxU7Ib1rlUaCb2htr88uwZsWi3YetCsclQMGrS8kzvA3Kx7liKGtuPECXT6GvO99bGfeI3eB1EiOK5SfhiWEsW8IF93Z2ZA7BPhm68IsjrWzlnN7OLtfyg9UNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736623973; c=relaxed/simple;
	bh=CoyVTJJ1rbxtA4B9iBCNQMehCA3EnT7df4i5EPFSVc4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ncx78+7rDkzDBYbzz+qrBXciTbiRuUeTer4vk47wx6XJ7QsElZJCjXVqVdc0zcMOj11OMVq6quO76Rl5ctuC5hnz3KbEOJb6k4Fpi9vOpIebWYW0oWYFEEwjPEmVWfN4ahvmBDHOsk/RkgpyOto6T7X6q1OhKI/unOFOUYNUx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=eworm.de; arc=none smtp.client-ip=46.4.70.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eworm.de
Received: from leda.eworm.net (p5085a997.dip0.t-ipconnect.de [80.133.169.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 2AB4C173CE9;
	Sat, 11 Jan 2025 20:26:29 +0100 (CET)
Authentication-Results: mx.mylinuxtime.de;
	auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
Date: Sat, 11 Jan 2025 20:26:28 +0100
From: Christian Hesse <list@eworm.de>
To: Git Mailing List <git@vger.kernel.org>
Cc: Christian Hesse <mail@eworm.de>
Subject: fatal: Not a valid object name HEAD
Message-ID: <20250111202628.0e5894e4@leda.eworm.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l9wEo9gESWu6NluEYNLrqYV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Rspamd-Server: mx
X-Rspamd-Queue-Id: 2AB4C173CE9
X-Spamd-Bar: /
X-Stat-Signature: osk3td4rwhu7daauqs9gwi7pzw1yjyif
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.00 / 15.00]

--Sig_/l9wEo9gESWu6NluEYNLrqYV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello everybody,

starting with Git 2.48.0 I see some trouble with some mirrored bare
repositories. Try this:

box ~ % git clone --mirror https://github.com/codership/galera.git
Cloning into bare repository 'galera.git'...
remote: Enumerating objects: 49768, done.
remote: Counting objects: 100% (2251/2251), done.
remote: Compressing objects: 100% (553/553), done.
remote: Total 49768 (delta 1986), reused 1716 (delta 1698), pack-reused 475=
17 (from 3)
Receiving objects: 100% (49768/49768), 25.20 MiB | 4.92 MiB/s, done.
Resolving deltas: 100% (37386/37386), done.
box ~ % cd galera.git=20
box ~/galera.git (git)-[4.x] % git describe=20
release_26.4.5-345-gd811a577
box ~/galera.git (git)-[4.x] % git remote add mariadb https://github.com/Ma=
riaDB/galera.git
box ~/galera.git (git)-[4.x] % git fetch --all
Fetching origin
Fetching mariadb
remote: Enumerating objects: 638, done.
remote: Counting objects: 100% (517/517), done.
remote: Compressing objects: 100% (125/125), done.
remote: Total 638 (delta 415), reused 454 (delta 392), pack-reused 121 (fro=
m 3)
Receiving objects: 100% (638/638), 386.30 KiB | 5.08 MiB/s, done.
Resolving deltas: 100% (440/440), completed with 105 local objects.
=46rom https://github.com/MariaDB/galera
 * [new branch]        0.6 -> mariadb/0.6
[ snipped some more branches and tags ]
box ~/galera.git (git)-[mariadb-4.x] % git describe                        =
                       =20
fatal: Not a valid object name HEAD

Guess that's not expected... Why does that happen?

Possibly fallout caused by https://github.com/git/git/commit/5f212684abb66c=
9604e745a2296af8c4bb99961c
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/l9wEo9gESWu6NluEYNLrqYV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmeCxeQACgkQiUUh18yA
9HYOLAf9HqW1OA8EtyIBsNXsHjzwuPD9yh+oKU7RRaQSpXfp1qEmi4o84o4m894Z
yjFiyeh30yZACEwjUi6cVJ8/6iUDsN1/ivZet05OhqQ3ICGgUG9R5fwikhW0sNU1
g+nUjp1re4vlYEFy1zLxa1cyVvnBz0nb1vFNTIsOo3zB/p/1QV36+7ps6DgsBP+t
7Jbf1LLu9nXx/CrA2fFbNAAlelKcdYvgoWUVvBWp/GOZzeWSFHGUWNRkN9WAe2Qp
rUvQ1n2YZ55H/X3476AQOzZN5puSTeIEkpQucdvnvA/8ws/hOr21eoBwfpnfCOMr
3vESlPj8KfkcZR+20AKQCr9MCltBSw==
=oPvR
-----END PGP SIGNATURE-----

--Sig_/l9wEo9gESWu6NluEYNLrqYV--
