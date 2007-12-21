From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-describe: Add a --match option to limit considered tags.
Date: Fri, 21 Dec 2007 22:22:13 +0100
Message-ID: <20071221212212.GB10318@artemis.madism.org>
References: <1198253900-31502-1-git-send-email-madcoder@debian.org> <7v7ij87x5u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="9zSXsLTf0vkW971A";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:23:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5pKZ-0005aa-Ba
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 22:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbXLUVWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 16:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755012AbXLUVWP
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 16:22:15 -0500
Received: from pan.madism.org ([88.191.52.104]:43929 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbXLUVWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 16:22:14 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DEB1DF0FD;
	Fri, 21 Dec 2007 22:22:13 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3485B5545; Fri, 21 Dec 2007 22:22:13 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v7ij87x5u.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69095>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2007 at 05:52:29PM +0000, Junio C Hamano wrote:
> Does it work with "describe --contains" as well?

  I think so, the idea here is that I give prio "0" to tags that don't
match, which unless you pass --all (which basically conflicts with
--match <foo> anyways) means that those are not added to the list of
tags that are considered. So I don't see why it would fail with
--contains.

  That's a patch we "need" at work because we have a repository with
different products that share a _lot_ of code (and we're not confident
with submodules yet to switch) and we use git-describe to embed the
exact version of the code that was shipped to a client. Though it sucks
when the last tag shows another product name :)

  I'd also like to use it in some scripts of mine for debian packaging
where I have quite a lot of private tags and only want to describe tags
that match 'debian-sid*'

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHbC6EvGr7W6HudhwRAro0AJkBrOSO3hIJEaVeLviO4xpgU+pTRQCfac5J
Hrb+yIuHK3ICq8XU823SCjc=
=fRpZ
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
