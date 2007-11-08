From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH MISC 1/1] Make gcc warning about empty if body go away.
Date: Thu, 08 Nov 2007 09:12:44 +0100
Message-ID: <20071108081244.GA6528@artemis.corp>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org> <1194430832-6224-2-git-send-email-madcoder@debian.org> <7vode57awg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/04w6evG8XlLl3ft";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:13:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2Vb-0007IL-DH
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbXKHIMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbXKHIMs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:12:48 -0500
Received: from pan.madism.org ([88.191.52.104]:49295 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXKHIMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:12:48 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id CC02628BD8;
	Thu,  8 Nov 2007 09:12:45 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B622C31A840; Thu,  8 Nov 2007 09:12:44 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vode57awg.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63956>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2007 at 02:01:51AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > diff --git a/builtin-diff.c b/builtin-diff.c
> > index f77352b..80392a8 100644
> > --- a/builtin-diff.c
> > +++ b/builtin-diff.c
> > @@ -204,7 +204,7 @@ static void refresh_index_quietly(void)
> >  		if (write_cache(fd, active_cache, active_nr) ||
> >  		    close(fd) ||
> >  		    commit_locked_index(lock_file))
> > -			; /*
> > +			(void)0; /*
> >  			   * silently ignore it -- we haven't mucked
> >  			   * with the real index.
> >  			   */
>=20
> Wouldn't this be much easier to read, by the way?
>=20
> The point is that if we touched the active_cache, we try to
> write it out and make it the index file for later users to use
> by calling "commit", but we do not really care about the failure
> from this sequence because it is done purely as an optimization.
>=20
> The original code called three functions primarily for their
> side effects, which is admittedly a bad style.

  Well all I care is that the warning goes away, it prevents me to build
in -Werror and it's bad :)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMsT8vGr7W6HudhwRAsYFAJoC7blj+6MBPO09v4aBbmzzDi4hHQCaA6ex
Ds15bEhPpONKxVUDBGezukg=
=fuSp
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
