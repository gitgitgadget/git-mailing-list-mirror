From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Fix in-place editing in crlf_to_git and ident_to_git.
Date: Fri, 05 Oct 2007 10:40:54 +0200
Message-ID: <20071005084054.GH19879@artemis.corp>
References: <87wsu2sad0.fsf@gollum.intra.norang.ca> <20071005082026.GE19879@artemis.corp> <Pine.LNX.4.64.0710050930030.4174@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="+ts6NCQ4mrNQIV8p";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:41:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idik5-0005fi-Aw
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbXJEIk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbXJEIk5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:40:57 -0400
Received: from pan.madism.org ([88.191.52.104]:59250 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbXJEIk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:40:56 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2800222CEF;
	Fri,  5 Oct 2007 10:40:55 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C82821E165; Fri,  5 Oct 2007 10:40:54 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710050930030.4174@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60053>


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2007 at 08:30:45AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 5 Oct 2007, Pierre Habouzit wrote:
>=20
> > When crlf_to_git or ident_to_git are called "in place", the buffer=20
> > already is big enough and should not be resized (as it could make the=
=20
> > buffer address change, hence invalidate the `src' pointers !).
>=20
> I wonder why we resize at all if the buffer is big enough to begin with.

  strbuf_grow takes care of that itself but indeed you make me see that
my patch is wrong. if buf->len > len then len - buf->len is err a bit
big.

  I'll roll better ones.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBfiWvGr7W6HudhwRAg+dAJ9pKpsjoXiTi/tL/KncgDU3P4nzXACfdl0c
vttJ14pnDEvh8MpjV1HaeD4=
=kImr
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--
