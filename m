From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git Scaling: What factors most affect Git performance for a
 large repo?
Date: Fri, 20 Feb 2015 17:16:14 +0000
Message-ID: <20150220171614.GA5730@vauxhall.crustytoothpaste.net>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
 <20150220000320.GD5021@vauxhall.crustytoothpaste.net>
 <CAH8BJxEWDb0SDHPS_ZnPzz0QEbryw2GCv2RtJm2u_6rPH566hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: git@vger.kernel.org
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOrBi-0006sD-JG
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 18:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbbBTRQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 12:16:22 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49149 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754625AbbBTRQV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 12:16:21 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c808:e39c:abee:cc11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C9F872808F;
	Fri, 20 Feb 2015 17:16:19 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Stephen Morton <stephen.c.morton@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAH8BJxEWDb0SDHPS_ZnPzz0QEbryw2GCv2RtJm2u_6rPH566hg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264174>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 11:06:44AM -0500, Stephen Morton wrote:
>2. I'd not heard about bitmap indexes before this thread but it sounds
>like they should help me. In limited searching I can't find much
>useful documentation about them. It is also not clear to me if I have
>to explicitly run "git repack --write-bitmap-indexes" or if git will
>automatically detect when they're needed; first experiments seem to
>indicate that I need to explicitly generate them. I assume that once
>the index is there, git will just use it automatically.

Pack bitmaps are a way of speeding up clones and fetches by precomputing=20
reachability information.  Practically, this means that the initial=20
"Counting objects" phase is instantaneous for clones and much faster for=20
fetches.

The way I've done it in the past is to set repack.writeBitmaps =3D true in=
=20
/etc/gitconfig on the server.  (I highly recommend enabling reflogs in=20
the same place.)  Then you'll need to ensure that git gc runs=20
periodically so that bitmaps are generated.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU52veAAoJEL9TXYEfUvaLTJQP/RxkHJVCR82D8GDCKfXTn9FH
5N+B5Nc/KppN2585lJhwH9TidIJLA63vUL/MR1jMPtxTGNiXBiFFIfUzOm6S3RRD
lvXRCPHkyIKS5Gq7UxDC04Wr4aCw028lqb+TTERF57LnPlU9p0tGE2PxD3M8qfWo
QkCaAHPcs25MOkbTJ+XrxtJBrg1C73zp0x66Vm27NMhTDfbcY5vE3/8oEeBdcuCo
4pvnyQuT6ErIkkNWE6Fc8yg10yRpRX9XLyin+KyLK96E6Ofjpyr3oh85bGSn4uZf
/rDb+5LjDm+JOyWZKogn2gk3PJuWjnILp3OjCe1ugzhbdHsjVJokUD5SUf4a44fr
x8Bp4Gw2vki6oR7A1Y/GIzwhDDHPHgjt2Fw9hb6SKn560NHHZ1/SmOf9sDYLLcN5
cSd6x41Wd4hUd0Uu17tDdsH/WGQIvYvM6qPycUAyMHnylv3RKX0TThelq2imniKp
aOeYDjENy/kIiVK/7140xb5oxaocYCcTZymqkbiI2POpp3LeXgkBLTaPmVVe9Nwp
cJvLfVsm/br4cP8KyZM3VnT3nzR3KuuNtGggvfSqW/cPLjC2z+/ea2ODRONJvf0w
MV/JUQdMy0c/c2TPHUOvitpWJ3/9CmxSirrbDRyjl3qvjxqP9hSVn0Jch2+nmnzi
f1IeXgtQd/1U0vV7qZEF
=/6CB
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
