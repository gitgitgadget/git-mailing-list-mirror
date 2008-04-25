From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Fri, 25 Apr 2008 11:11:17 +0200
Message-ID: <20080425091117.GA23726@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de> <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <7vlk35ydf0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 11:48:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpKXd-0005VX-2z
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 11:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759088AbYDYJrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 05:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758692AbYDYJrj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 05:47:39 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2482 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117AbYDYJrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 05:47:36 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id C2883EC055; Fri, 25 Apr 2008 11:47:34 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JpJxd-0004gT-Fi; Fri, 25 Apr 2008 11:11:17 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JpJxd-0002pI-AL; Fri, 25 Apr 2008 11:11:17 +0200
Content-Disposition: inline
In-Reply-To: <7vlk35ydf0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80332>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Junio C Hamano schrieb am Tue 22. Apr, 11:04 (-0700):
> J=F6rg Sommer <joerg@alea.gnuu.de> writes:
>=20
> > What do you think about this version:
> >
> > cleanup_before_quit () {
> > 	rm -rf "$DOTEST" &&
> > 	for ref in $(git for-each-ref --format=3D'%(refname)' ${mark_prefix%/})
> > 	do
> > 		git update-ref -d "$ref" "$ref" || return 1
> > 	done
> > }
>=20
> Yeah, except you would want to dqquote "${mark_prefix%/}" part.

Oh, yes.

> Also this being a "clean-up" phase, I wonder if we want to stop at the
> first error (e.g. should unremovable "$DOTEST" leave marks behind?

I think it should be the other way: unremovable marks should leave the
DOTEST behind. This way a rebase should refuse to start a new session and
stumble accross the old marks and it's possible to run git rebase --abort
after manually removing the marks.

Bye, J=F6rg.
--=20
Damit das M=F6gliche entsteht, mu=DF immer wieder das Unm=F6gliche versucht
werden.                                       (Hermann Hesse)

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIEaA1we0mZwH1VIARAj92AJ9yXJ+jjF8V1Taeie/E2K4bi6LtygCdH7rc
TOAODql6+/ScCnQE1zC4AT4=
=J9U4
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
