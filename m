From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: query regarding git merge
Date: Sun, 13 Dec 2015 18:18:00 +0000
Message-ID: <20151213181800.GK990758@vauxhall.crustytoothpaste.net>
References: <loom.20151213T185500-631@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Cc: git@vger.kernel.org
To: rohit gupta <roborohitgupta75@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 19:18:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8BDn-0002tt-Si
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 19:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbbLMSSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 13:18:07 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44846 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752075AbbLMSSG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2015 13:18:06 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 166D0282CA;
	Sun, 13 Dec 2015 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450030684;
	bh=bLsp4aeFPOc5Vw/orXOLefr+Hw8jspfmAQFvoiAd7aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Boq1YI/hpFLjVSprcvfL07kJTflVM8hnUbEVYXqeqEPqnVnEf8yHLDSZ4qVGBEe0V
	 DltoATr3kbOGS7yGcsDRy9cj6l69UZCPd7SKf4kBCr7J+VhkCgGLFgcmXF91IowZVT
	 k0Hj8sXbvEgLAq4e0oykG9hIZa7o0Vn96Q3Gs6F/i6ClmOScxH9c4G41QkPX3QFGFA
	 xfRb6PCR43uF9/Mv0mAIMaX6jrP5hnhAbmJRObbD30B5FIPyv0xV5wvEiDm7vYT2Ks
	 WA3EHhIaNmtVlBSpymyXhLVpMGvXIfM53qj8abmVzUCu4XqyhshvKuP9R0MnuRf6hZ
	 vHrxCUo7ZFjRfS3apcIiPX2aV26uWkeE/63X+3VG9mIH41u2otExn9l39az3+RXp1g
	 JZP+TPBt0KSxP/MHG3fQB1P/48Nm8AoYH8YA7cwvG/WxE2xU2HzdxuyBYX5RREAyas
	 B+58ow685rtaRnc47PGx7joKHYyzrgJ+GzgEU7nGOqWy6Lf71id
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rohit gupta <roborohitgupta75@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20151213T185500-631@post.gmane.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282339>


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 13, 2015 at 05:55:59PM +0000, rohit gupta wrote:
> Hi,
> I am confused with git merge working.
>=20
> Suppose I have these 3 files in master branch-
> a.txt
> b.txt
> d.txt
>=20
> I create a branch, add c.txt to it and commit. So its final contents
> are-
> a.txt
> b.txt
> c.txt
> d.txt
>=20
> Then, I checkout master branch, delete a.txt, add e.txt and commit. So
> final contents are-
> b.txt
> d.txt
> e.txt
>=20
> Now when I merge branch in master,
> its result is-
> b.txt
> c.txt
> d.txt
> e.txt
>=20
> Now suppose in branch, a.txt was needed for its working. And in master
> branch's latest commit a.txt was removed because maybe it wasn't needed
> or it was introducing bugs.
> Now, git merge removes that a.txt
> So now branch functionality wouldn't work.
> Isn't that wrong??

Instead of thinking of Git as merging two sets of files, think of it as
merging two sets of changes.  Git computes a merge base based on one or
more ancestors of both branches.  During a merge, Git takes the
differences on each side and combines them.  Logically, if a change is
made on one side but not the other, it will be preserved in the merge.

So in your case, you deleted a.txt on one side and did not modify it on
the other.  Git applied that change to the result of the merge.  Git has
no way of knowing that a.txt is still required in the result.

This is a very common question that comes up in a variety of different
forms.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWbbZXAAoJEL9TXYEfUvaLZfIQAKWwT+e5+NuB4k89jbcsMH8/
rVLMJp4EE4tQUTcv4CLsgXCDT562Ba90jL58PB3Jdj3MuuySewUuKekFy2SAKPL6
NOekYuANsfWgo/C7q6jgKW+5DnXPdiA3jn+qXJCiMsMuUtwn71jCl9IqsUO1s3YR
kvA6uYHQTXiYSJ4d/aaV7Gpf89iWBTDc55IlANyd1euUJ9empKDWjjDheKmeHd0c
J4oBagK2IAADjk/XwMsCo4FBpkRBc1rRg3HpvMxN05hLznXBZkZTG0ZvKkKHUchF
D4vst7q4YZGKKEpf2HKDJCjCHypr3xPPettFEgQwURH5A6f4N8VuJYg/YGPIt5Cl
Te3ER6zCrJ8xQPpU+cHTOgSCcsqs8dNie2yr0h3QivtTR8on8Iy4hfpUGRr7Ej8z
IfKN7pVP+Kg5q5hyDoOWjymZ/coPpM+lCSMoAcxfLqjBsadxTq94M3MMt2yn6pNZ
Jw0GFpihC5ZRBBSiE33WAVRhv8eOHxEAcBjru1qH4guzRM6LvdjH6JhwejuFPf7v
R/oSt+teORaV5MknmdLQC6x6ZTD2CRTOElPxfnxMg8Q8FaB8j1I7g76AK4+iyszw
VaUN3L+Qz0bT5OR+JpokWDEfOcd/xNpg6VsCXl67Q82BfWIZtowwwp85d11da6cD
ON9Z/a/HKh3lsNNI7uEK
=7onL
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--
