From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Mon, 20 Oct 2014 22:28:09 +0000
Message-ID: <20141020222809.GB223410@vauxhall.crustytoothpaste.net>
References: <20141020115943.GA27144@gmail.com>
 <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:28:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgLR7-000195-NY
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbaJTW2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 18:28:17 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49426 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557AbaJTW2R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 18:28:17 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6746A2808F;
	Mon, 20 Oct 2014 22:28:13 +0000 (UTC)
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>, infra-steering@kernel.org,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2014 at 08:25:59AM -0700, Linus Torvalds wrote:
> Junio, Brian,
>=20
>   it seems that the stability of the "git tar" output is broken.

It doesn't appear that the stability of git archive --format=3Dtar is
documented anywhere.  Given that, it doesn't seem reasonable to expect
that any tar implementation produces bit-for-bit compatible output
between versions.  After all, look at all the contortions that Debian
has had to go through to keep pristine-tar working.

> Junio, quite frankly, I don't think that that fix was a good idea. I'd
> suggest having a *separate* umask for the pax headers, so that we do
> not  break this long-lasting stability of "git archive" output in ways
> that are unfixable and not compatible. kernel.org has relied (for a
> *long* time) on being able to just upload the signature of the
> resulting tar-file, because both sides can generate the same tar-fiel
> bit-for-bit.

It sounds like kernel.org has a bug, then.  Perhaps that's the
appropriate place to fix the issue.

The issue I fixed is that leaving world-writable files around on disk is
a great way for people to cause mischief (for example, by filling up
other users' quotas), and some tar implementations and all Linux pax
implementations extract the pax headers into the working directory, and
that's often /tmp.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJURYx5AAoJEL9TXYEfUvaL0LMQAM86PFISKXMFEIasoSj10OCZ
G/aENaeXQZ8A1hzpH7uKvPwlsKwIhsL2Y+OkUh7AVDe/fqvl5dpMTJjj2Hey3Nc6
wdsO1/nQ+ysMrRrxW2YCj5eVax5MxF/T9tctvIbv+3MB6mK65SosD0mNoQhn7qjJ
JJHMjmdVeZ5Vgx5DNJ6743j3hCYLXoAlgKdo6b13ven7tPUOiLkl4Ox2SFjM0Fee
5XjsPHtDQM8USq4XqhuDfpgFr+WIe1egwfi8h6gTB6x+vM0CgvGejssW3h6FFlfq
kYsXDvcR2Pnvk2+Q4F0f7w2mevMKL/Mvd6yf97pMotAH/v7xTAzCqchbCN/TvoKs
BS/7x+H8G2CBPfAiS7ai8JtpenYZYr6cjr+cdWlZdPdf92shF+i//UcQoVXD2s7e
u+fiukJuWG7sKlKB/tSgcwi1NK1X2HpH7fop1ruvKgzVvfvzQtA8kfKQ6FDLvkE3
4osKNSIVXDvs/6hVNhN+bHiLC/do1xyWZSuTue4qELIn4plaAGjeUbZHQyLIgg3o
FlVV49uLD7K4088zicsubsJBD5ZT3bMM47U56CFjArLw+ndy2LAQdkDtrk56hGUL
0onHe5RhedOPqcVyEkmykzmD/lMeKkE8Nj3JHQ+y54aNF0xbrp3hgm8zN6ohhu5T
GROOUiEDw2Muvh/ebUjP
=+9dG
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
