From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: merging .gitignore
Date: Tue, 02 Oct 2007 22:47:48 +0200
Message-ID: <20071002204748.GA19710@artemis.corp>
References: <20071001130314.GA5932@lapse.madduck.net> <Pine.LNX.4.64.0710011457120.28395@racer.site> <20071001130314.GA5932@lapse.madduck.net> <200710011448.17701.andyparkins@gmail.com> <20071002195148.GA14171@lapse.madduck.net> <20071002201318.GD16776@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ew6BAiZeqk4r7MaW";
	protocol="application/pgp-signature"; micalg=SHA1
To: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 22:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icoew-00088g-HN
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbXJBUry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbXJBUry
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:47:54 -0400
Received: from pan.madism.org ([88.191.52.104]:33416 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbXJBUrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:47:53 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D5DDC21906;
	Tue,  2 Oct 2007 22:47:48 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 2289C2CB4D2; Tue,  2 Oct 2007 22:47:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20071002201318.GD16776@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59730>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mar, oct 02, 2007 at 08:13:18 +0000, Pierre Habouzit wrote:
>   Ancestor: (aa*, aaa, bbb)
>   Left child: (aa*, bbb)   <-- remove aaa because aa* covers it
>   Right child: (aaa, aabcd, bbb, cc*) <-- remove aa* and be explicit
>=20
>   The proper result is probably: (aaa, aabcd, bbb, cc*) but is in fact a
> case of conflict, because the "left" child could have used the fact that
> aa* was present and hide say a aaXXX that the right child did not had,
> and the merge would be wrong.

  Okay this example blows, I believe this one is better:

       (a*)
      /    \
  (ab*)    (ac*)
      \    /
       ????

  gitignore are subsets of the set of words.  if S is the ancestor set,
S1 and S2 the left and right sets. let =CE=941 and =CE=942 be S1 \ S and S2=
 \ S
respectively.  I think there is a conflict if
  =CE=941 n =CE=942 !=3D 0 and (=CE=941 is not a subset of =CE=942) and (=
=CE=942 is not a subset of =CE=941)

  If the condition holds, then I believe that the "merged" .gitignore
would be: (S1 u S2) \ (=CE=941 u =CE=942)

  Though, don't take my word for it, I've only sketched this on a small
piece of paper, and have no rigorous proof.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAq50vGr7W6HudhwRAsEQAJ0ci1/qadJoktQkDt1PpsthBC0uzwCfU0RD
d+x1EFdGN+K9YO8OdjN1vXo=
=zo/a
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
