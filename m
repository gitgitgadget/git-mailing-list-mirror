From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: size_t vs "unsigned long"
Date: Wed, 03 Oct 2007 22:48:01 +0200
Message-ID: <20071003204801.GC28188@artemis.corp>
References: <7vabr0djqr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="bKyqfOwhbdpXa4YI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 22:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdB8h-0001qB-N3
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbXJCUsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbXJCUsF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:48:05 -0400
Received: from pan.madism.org ([88.191.52.104]:52182 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756481AbXJCUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:48:04 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 06FD623417;
	Wed,  3 Oct 2007 22:48:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8457D35617A; Wed,  3 Oct 2007 22:48:01 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabr0djqr.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59883>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2007 at 08:30:04PM +0000, Junio C Hamano wrote:
> Traditionally, inside git, we have used the length of things
> with "unsigned long" for pretty much anything, except where we
> wanted the length exactly sized we used int32_t, uint64_t and
> friends.
>=20
> A few places pass pointer to unsigned long as the second
> parameter to strbuf_detach(), triggering type mismatch warnings.
> An easy way out is to change strbuf_detach() to take a pointer
> to ulong but I think it is going backwards.  Most places that
> use "unsigned long" can safely be converted (and made more
> correct) to use size_t.

  Well, afaict, on every linux archs I know of, unsigned longs and
size_t are the same. Though, I don't know if that holds for the msys
port, and if that does not holds, then a s/unsigned long/size_t/ would
help them. Else, for consistency sake, I believe the change is a good
one.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBAABvGr7W6HudhwRAts9AJ0Tl4AX1cLbjKOZwImCTxMVWRFwzwCfRILV
h+1dq9WwwYyOboA91JZPbsI=
=g3fr
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
