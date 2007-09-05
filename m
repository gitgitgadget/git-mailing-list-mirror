From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Simplify strbuf uses in fast-import.c using the proper  functions.
Date: Wed, 05 Sep 2007 10:57:20 +0200
Message-ID: <20070905085720.GD31750@artemis.corp>
References: <20070904115317.GA3381@artemis.corp> <11889144743483-git-send-email-madcoder@debian.org> <46DDEE73.5020904@lsrfire.ath.cx> <20070905074815.GB31750@artemis.corp> <7vodghk057.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="cHMo6Wbp1wrKhbfi";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:57:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqhT-0007Kg-Fw
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbXIEI5X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756077AbXIEI5X
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:57:23 -0400
Received: from pan.madism.org ([88.191.52.104]:53038 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633AbXIEI5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:57:22 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 30BC21DAF1;
	Wed,  5 Sep 2007 10:57:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D3E293244EE; Wed,  5 Sep 2007 10:57:20 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
In-Reply-To: <7vodghk057.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57693>


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 08:05:24AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   oh boy, yes I fixed that in my local patch collection. I'm waiting for
> > a few hours (days ?) to see if there will be some more comments, I've
> > integrated every single one done here already (and some I had on IRC
> > too), and I'll repost a new clean series that I intend to be a real
> > proposal for inclusion.
>=20
> Ah, I actually did the single trivial fix-up (ALLOC_GROW) and
> have been looking at it, but I'll discard it.  Thanks.

  Yeah I integrated that as well already. I think I'll post the patches
at the end of the Day (French Timezone so in 5 or 6 hours at least) to
be sure nobody has any good remarks to do first. If you want I can share
my branch somewhere if you want to look at it, just ask.

> >   And yes, this patch is a perfect example of the gain we have to share
> > a common buffer API. The code looks (at least to me) way nicer, and if
> > you look in the details, we perform as many memory allocations, copies,
> > and so on as in the previous version.
>=20
> Wait.  What is your point in saying this?  Is that a good thing
> to do "as many"?  "API is cleaned-up and it is much easier to
> read but we do not do more than before" is certainly a *BIG*
> plus, so perhaps that is what you meant, but when I first read
> it I thought you were saying "we are not optimizing it at all"
> in a negative sense.

  Sorry if I chose wrong words to say that, it is clearly a big plus ! I
wrote it having in mind that very often abstractions and high level APIs
often degrade performance. It does not, and that's a huge win. The point
is that "despite the somehow higher level API we don't loose an inch of
performance".

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG3m9wvGr7W6HudhwRAolHAKCgCnHFVtlkJCGlh4np7XnhQfA3UwCgi+KN
iyBftFj/JKlIv/k7GauAWtI=
=1Mv/
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
