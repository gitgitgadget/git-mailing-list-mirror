From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Simplify strbuf uses in fast-import.c using the proper  functions.
Date: Wed, 05 Sep 2007 09:48:15 +0200
Message-ID: <20070905074815.GB31750@artemis.corp>
References: <20070904115317.GA3381@artemis.corp> <11889144743483-git-send-email-madcoder@debian.org> <46DDEE73.5020904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="FkmkrVfFsRoUs1wW";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISpcd-0005y7-AV
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbXIEHsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 03:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755789AbXIEHsR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:48:17 -0400
Received: from pan.madism.org ([88.191.52.104]:60590 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618AbXIEHsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 03:48:16 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D1DF21DAF1;
	Wed,  5 Sep 2007 09:48:15 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 74A45287E45; Wed,  5 Sep 2007 09:48:15 +0200 (CEST)
Mail-Followup-To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46DDEE73.5020904@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57679>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2007 at 11:46:59PM +0000, Ren=C3=A9 Scharfe wrote:
> Pierre Habouzit schrieb:
> >   This is just cleaner way to deal with strbufs, using its API rather t=
han
> > reinventing it in the module (e.g. strbuf_append_string is just the pla=
in
> > strbuf_addstr function, and it was used to perform what strbuf_addch do=
es
> > anyways).
> > ---
> >  archive-tar.c |   65 ++++++++++++++-----------------------------------=
--------
> >  1 files changed, 16 insertions(+), 49 deletions(-)
>=20
> Apart from the wrong subject line I really like this patch. :-D

  oh boy, yes I fixed that in my local patch collection. I'm waiting for
a few hours (days ?) to see if there will be some more comments, I've
integrated every single one done here already (and some I had on IRC
too), and I'll repost a new clean series that I intend to be a real
proposal for inclusion.

  And yes, this patch is a perfect example of the gain we have to share
a common buffer API. The code looks (at least to me) way nicer, and if
you look in the details, we perform as many memory allocations, copies,
and so on as in the previous version.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3l8/vGr7W6HudhwRAo0iAJ9s9wMXb0arayHk+Y9Cq8xWwnk1GgCgkxHd
GpPOV6Y2pOA3lEAHfg2chZY=
=xtWz
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
