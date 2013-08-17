From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] submodule: don't print status output with ignore=all
Date: Sat, 17 Aug 2013 16:27:25 +0000
Message-ID: <20130817162725.GE64402@vauxhall.crustytoothpaste.net>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net>
 <20130803182420.GG2893@elie.Belkin>
 <20130811160316.GE164436@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Cc: git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 18:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAjLl-0001Sn-Qe
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 18:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab3HQQ1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 12:27:32 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45912 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753858Ab3HQQ1b (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Aug 2013 12:27:31 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 34E2428073;
	Sat, 17 Aug 2013 16:27:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130811160316.GE164436@vauxhall.crustytoothpaste.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232462>


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2013 at 04:03:17PM +0000, brian m. carlson wrote:
> On Sat, Aug 03, 2013 at 11:24:20AM -0700, Jonathan Nieder wrote:
> > If I just renamed a submodule, will 'module_name "$path"' do the right
> > thing with the old path?
>=20
> module_name uses whatever's in .gitmodules.  I'm not sure what you mean
> by "renamed a submodule", since "git mv foo bar" fails with:
>=20
>   vauxhall ok % git mv .vim/bundle/ctrlp .vim/bundle/ctrlq
>   fatal: source directory is empty, source=3D.vim/bundle/ctrlp, destinati=
on=3D.vim/bundle/ctrlq

Okay, I've tested this against next and it seems that the code handles
it properly (at least I think it does).  I left the following code

  # Always show modules deleted or type-changed (blob<->module)
  test $status =3D D -o $status =3D T && echo "$sm_path" && continue

before the ignore code, so I adjusted the new ignore code so that it
prints both the new and the old path.  I don't know that it's possible
to print neither in that case, since we no longer can look up the old
path in .gitmodules.  I'll be sending my reroll shortly.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSD6RtAAoJEL9TXYEfUvaLoIAP/3heMpHj9Zb0wzp1KK/LHlkP
XpgVyK3T9H0JXoCrstVdNLhL8zzkjVMmXwFraRFLvZUa6jsN0d0ZMxJjCynnVC2F
jLm24crerAz4Svju9LZ8o2423k5Vj6J2syjCrqbKWpwCRhqp4/JTlWYfnKpMgQ/h
3cJ7KYJGGGi3WDlLGU6AbuykCxs/BC0T6Yl7Y8Lpo7diX+yrLcbZbcMBhK3kObxW
GTv0ci7+6Wdhzn7QOlmqvhX+tD23AB+dKpgg93bIztdl0NPzYfUUSxc9B3+ThZhU
JMYOf1qHSK0Y5RZrGyxN+X+NvDRDBVUJvZbvlZLsPzPiIVOX9TYc+1dxRjWEab3r
zO9fJWiRlkU4tqrkg6li74GZocfHaI8HW2rn0IQFUQJ7wQdfBEH+zu+rgh8b0piQ
l8r3vxetgZNFnU0fw0pB/ti1ZKRX43lgd6x1wvg1Rr23URLPUigyiNHefxzsJOIs
YdAhT7h52AX4e+xsNIyHVcOvxY/UBVKQQ6Q0zeTV7S2nbtorwALOixHk5DtBWTkM
YMvkT+Ppj5TLPZJOWrmcbbShmsNZDbRNFEAaqyN59pVqoDsuoAt2M8H3dZFck4gY
b64g6WNaGesNuNKS8TicM3DI4fOXFHgJwKOoX/Iy2e6Xqzu6EwXidsFr3JkG2ezs
v3x4LcLWga5qab1/L0ET
=QB8O
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
