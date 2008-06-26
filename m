From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/2] Introduce leaky().
Date: Thu, 26 Jun 2008 23:33:04 +0200
Message-ID: <20080626213304.GA22111@artemis.madism.org>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org> <1214338474-16822-2-git-send-email-madcoder@debian.org> <7vbq1oqbjg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="fdj2RfSjLxBAspz7";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 23:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBz6Y-0000Vm-CJ
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 23:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYFZVdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 17:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbYFZVdN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 17:33:13 -0400
Received: from pan.madism.org ([88.191.52.104]:57664 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbYFZVdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 17:33:13 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E40DD38341;
	Thu, 26 Jun 2008 23:33:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B0A6C18DB3; Thu, 26 Jun 2008 23:33:04 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbq1oqbjg.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86489>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2008 at 06:46:43PM +0000, Junio C Hamano wrote:
> The user would also need to worry about not freeing the original
> allocation pointer when something is realloc(3)ed, which means either
> finding the last realloc(3) of the object (that is logically the same, but
> just being extended) and mark the pointer as leaky() after that realloc,
> or unregister the original pointer from leaks before calling realloc and
> register what comes back.  It will easily get messy.

  Hmm indeed, maybe it isn't such a good idea then.

> By the way, the series queued in your repository still has "s/pring/print=
/"
> typo in 4/7 and "argv not NULL terminated" comment in 6/7.

  I'll fix that and pushed again, without the leaky() series dependency
(I've put in a comment that I'm aware that it's a leak), and with the
two fixes you mention done.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhkCw4ACgkQvGr7W6HudhzSWACglL2MmNsgkqiqPistTTwXrt2x
qd4AoJU7pY9rhuizsmH6Tj3CRI5s3Jw9
=wa3L
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
