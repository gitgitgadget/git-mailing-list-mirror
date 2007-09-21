From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 7/7] Avoid duplicating memory, and use xmemdupz instead of xstrdup.
Date: Fri, 21 Sep 2007 09:03:29 +0200
Message-ID: <20070921070329.GB5689@artemis.corp>
References: <1190241736-30449-8-git-send-email-madcoder@debian.org> <20070920220506.GC17514@artemis.corp> <1190241736-30449-1-git-send-email-madcoder@debian.org> <1190241736-30449-2-git-send-email-madcoder@debian.org> <1190241736-30449-3-git-send-email-madcoder@debian.org> <1190241736-30449-4-git-send-email-madcoder@debian.org> <1190241736-30449-5-git-send-email-madcoder@debian.org> <1190241736-30449-6-git-send-email-madcoder@debian.org> <1190241736-30449-7-git-send-email-madcoder@debian.org> <1190241736-30449-8-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="IrhDeMKUP4DT/M7F";
	protocol="application/pgp-signature"; micalg=SHA1
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 09:03:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYcY4-0003Gw-05
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 09:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbXIUHDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 03:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbXIUHDb
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 03:03:31 -0400
Received: from pan.madism.org ([88.191.52.104]:44007 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbXIUHDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 03:03:30 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CFD6B20FBE;
	Fri, 21 Sep 2007 09:03:29 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 820492E4614; Fri, 21 Sep 2007 09:03:29 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070920220506.GC17514@artemis.corp> <1190241736-30449-8-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58831>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On jeu, sep 20, 2007 at 10:05:06 +0000, Pierre Habouzit wrote:
> On mer, sep 19, 2007 at 10:42:16 +0000, Pierre Habouzit wrote:
>=20
>   As someone pointed to me off-list the above should be:
>   +		if (rf_one) {
>   +			(*write_ref)[targets] =3D xmemdupz(rf_one + 1, buf.len - (rf_one + =
1 - buf.buf));
>   +		} else {
>=20
>   Or better:
>   +		if (rf_one) {
>   +			rf_one++; /* skip \t */
>   +			(*write_ref)[targets] =3D xmemdupz(rf_one, buf.buf + buf.len - rf_o=
ne);
>   +		} else {
>=20
>   Which is definitely more readable.

  damn it was not the error that was reported to me, there is another
one, I'll roll a new patch, sorry :/


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG82zBvGr7W6HudhwRAgFEAJ0QyJ4ID/GoXHGNJXUsugx8uBy0lgCgpocY
+fBkOhN80oPtwTsjn6UJ6oQ=
=1YHe
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
