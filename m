From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-sh-setup: fix parseopt `eval`.
Date: Thu, 08 Nov 2007 09:15:56 +0100
Message-ID: <20071108081556.GB6528@artemis.corp>
References: <7vr6j15i3a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="1UWUbFP1cBYEclgG";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2Yf-00081Q-CY
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbXKHIP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXKHIP6
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:15:58 -0500
Received: from pan.madism.org ([88.191.52.104]:47700 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXKHIP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:15:58 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 49E2D28BD8;
	Thu,  8 Nov 2007 09:15:57 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 367C2317123; Thu,  8 Nov 2007 09:15:56 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6j15i3a.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63958>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 07:09:29AM +0000, Junio C Hamano wrote:
> The 'automagic parseopt' support corrupted non option parameters
> that had IFS characters in them.  The worst case can be seen
> when it has a non option parameter like this:

hu sorry about that, I should have put "" around the ``. I knew it also
but it slipped my mind too.  I believe this works as well:

eval "$(echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- =
"$@" || echo exit $?)"

I like it better because you will then exit with an exit 129 wich is
what we want (and what I documented would work too :P)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMsW8vGr7W6HudhwRAl1pAKCXxhIOBiTCyjjEgVqVh87I8fA9tgCcDEtR
Do9xmO9YKfGmZ6zdOVNChiA=
=wJSQ
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
