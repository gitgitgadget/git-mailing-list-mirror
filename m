From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] blame: CRLF in the working tree and LF in the repo
Date: Tue, 28 Apr 2015 01:17:03 +0000
Message-ID: <20150428011702.GA5015@vauxhall.crustytoothpaste.net>
References: <553CD3DA.9090700@web.de>
 <xmqqzj5uxhls.fsf@gitster.dls.corp.google.com>
 <xmqqa8xtxy32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>, kasal@ucw.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 03:17:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymu9E-0000v8-Gn
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 03:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbbD1BRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 21:17:10 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50113 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751840AbbD1BRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2015 21:17:09 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:d8d7:1ec4:dcc9:52a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D98732808D;
	Tue, 28 Apr 2015 01:17:06 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>, kasal@ucw.cz
Content-Disposition: inline
In-Reply-To: <xmqqa8xtxy32.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.0.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267888>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2015 at 10:47:29AM -0700, Junio C Hamano wrote:
> The original says this:
>=20
>     blame: correctly handle files regardless of autocrlf
>    =20
>     If a file contained CRLF line endings in a repository with
>     core.autocrlf=3Dinput, then blame always marked lines as "Not
>     Committed Yet", even if they were unmodified.  Don't attempt to
>     convert the line endings when creating the fake commit so that blame
>     works correctly regardless of the autocrlf setting.
>    =20
>     Reported-by: Ephrim Khong <dr.khong@gmail.com>
>     Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> But if autocrlf=3Dinput, then the end-user expectation is to keep the
> in-repository data with LF line endings.  If your tip-of-the-tree
> commit incorrectly has CRLF line endings, and if you were going to
> commit what is in the working tree on top, you would be correcting
> that mistake by turning the in-repository data into a text file with
> LF line endings, so "Not Committed Yet" _is_ the correct behaviour.
>=20
> So I think that the reverting that change is the right thing to do.
> It really was a change to break the behaviour to match a mistaken
> expectation, I would have to say.

I don't have a strong opinion on whether or not this should be reverted,
since I don't use Windows and therefore don't use CRLF or the respective
options anywhere, nor am I very familiar with how they are supposed to
function.  Junio has articulated a good rationale for why it's broken,
and I'm willing to go along with that.

I will say that perhaps it's worthwhile to write some documentation to
explain how the CRLF translation works, as it seems that there's a lot
of misunderstanding about it.  I am, for the aforementioned reasons, not
a good choice to write it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVPt+OAAoJEL9TXYEfUvaLrq4P/2ecXpAf66VlIBhqqjtG1S/f
pBQu4kaF6coprhgnIUskHeIJa3Kj8XXrdxAysm1d+no9kOqAqij1qys7o5ZBZKxd
XH0JUcsRQySD7szUFwgw7srFbJaXm1PZTsth3Fxy9zarmewu7aSS1Nd8amdUxdLv
hMyca1znRJwK2P6rfzSrGuixNU6ACt/XWjosdn8TWytn0z9MwnKVEj/AtfWMuzmy
/1fkGtjKQu30eB405ihOOpSwTCK0vk2IAmOzJapBZ1x2lkzVV0Tu3gLP3Lzv+G0X
3TorVc5LxbEce9gKxHyvn4D+K5xO7v6MtDe9k+DOYBpSlaFx1UNTT816RwXJGZ7L
i7DkxX16DfTKl5HoWYua6GqFwjwDU4Lk/81KCy5bvpx5I78rPiEKSW4FFtmEHKAo
VeXDzcXzxYcEgMDQ170PVAt/tWFKvz8fJPah+Wr1to5WXZpiaSdy6USTn5sNa1hh
92bC3rqpRs6mSnej50u/qdg0gdl6AeK7An3vq5rFgmWOcMi7mdj+jOqzBolPKkLs
cngz/Pp2GntaGD5eVZ7QElLSlIsfO3NTmdLHBG2cfHk8+O4qldqFNs45/dmvtDum
8LNPkMDvt3PrmfA4SDWld6In7ecwXK7zpfiCAYjk6sF9JcksGoKWUe92px5H7yFJ
9+LTFoBs4JxvxAFH2I7i
=/sk5
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
