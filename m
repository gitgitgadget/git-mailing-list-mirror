From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Multiple push remotes via aliases
Date: Sun, 10 May 2015 19:10:45 +0000
Message-ID: <20150510191045.GD225482@vauxhall.crustytoothpaste.net>
References: <20150510181703.GC225482@vauxhall.crustytoothpaste.net>
 <xmqq4mnkgtj0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 21:11:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrWcv-0003XK-VV
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 21:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbbEJTKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 15:10:51 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:35191 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751238AbbEJTKv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2015 15:10:51 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7d3a:6691:d1f:cd1e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 04EAA2808D;
	Sun, 10 May 2015 19:10:49 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq4mnkgtj0.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: 1.228 (*) RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268737>


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2015 at 11:46:27AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I recently discovered that it was possible to specify multiple push URLs
> > for a remote.  This is useful for me because some of my projects live
> > both on GitHub and on my own server, and some live only one place or the
> > other.
> >
> > One feature that I'm looking for, however, is the ability to specify
> > those URLs by reference to another remote.
>=20
> Two issues that immediately comes to my mind are
>=20
>  (1) how you deal with a misconfiguration that makes a loop;

I was certain you were going to ask this.  My plan is to only allow one
level of reference as a first pass and check for the current remote
name.  If there's a desire to extend it to multiple levels, we can
implement loop checking then.  A list of already-seen entries could be
used in that case.

>  (2) how would you disambiguate a local directory and a nickname.

I was going to do something like this:

[remote "def"]
	reference =3D upstream
	reference =3D gh

The same rules for "def" would apply that are currently used, and
"upstream" and "gh" would clearly be references, not remote URLs.

I had planned to essentially make "git push def" work like "git push
upstream; git push gh", forbidding fetch and push entries at the
same time as reference entries.  Future work could use referenceURL to
refer only to the URL and allow fetch and push to be used.

I'm also going to update the documentation to reflect that multiple push
URLs can be specified, as it seems that's a well-kept secret.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVT60uAAoJEL9TXYEfUvaLaZsP/jRlBPCJEb2I3vmjABrT2+wZ
cJta4KuVOohWc3KdtkeNMFOTXxy+xcVTXcN3X+AgYwE15pmkw+qgRl9aCl01pHnM
SH/+ZYTuCp+5lWeLykDTIehna+iQ78rgvtLGj5pM1Peg+XIxFb/Oc57QHCG1PdyC
n1wVJBGUsf+R6OGNQ2/TRR2+nPg0bfxFLzVUmSWUr8L4qA2S2WOnAosLcVqWcAPh
us3t2i86Lex3VlvK6smfUvzqX+IwmsIg8p8RZa0AjMRYUlG6o2HNC8mmC66czV6i
Wggg0Oo1UWIyP7H1A1usNpkvrJyHCzTM6ws5iQozrTdoKJh0tY/wKH9Bvmj19hea
+8SGxCaMp1T7twsezocLM94ERy4KM5yL+vyheCpHBqyle9Bpb8QdfnKsYUwYrwls
jtMxBREFJhKbGV7KkVei1qJz+l+1RcAixlUfvLuMwZvazOdXWvYxriI6fBoo5o5c
SDy/wvUHKu9hlCrqk7TsHdcYLsby1zeEVwpM6BIyy11U09MNjnADT9BIwbPaHtqf
CAC34y/6ChFEhpeXv8qyMYt1Gb7mYh8tbWots+T7xPE0VjWgaeE2VOpmBFZHIdHD
QM6RiQI13u3FE4QcIyACuT/55X5bJSRXcIFmNZqiDgXcD4IiSEw7r5EmClCy8b2X
eABySUN+TZFK+PizzVN+
=1BZM
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
