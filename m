From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Split out merge_recursive() to merge-recursive.c
Date: Tue, 12 Aug 2008 23:40:49 +0200
Message-ID: <20080812214049.GF18960@genesis.frugalware.org>
References: <7v7ianuo8q.fsf@gitster.siamese.dyndns.org> <1218559514-16890-1-git-send-email-vmiklos@frugalware.org> <20080812175629.GA28014@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rPF8rPXpDlNr1aSW"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 23:41:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT1cr-0007wd-2F
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 23:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbYHLVky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 17:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbYHLVky
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 17:40:54 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36969 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbYHLVkx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 17:40:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4E7A41B251D;
	Tue, 12 Aug 2008 23:40:52 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 14D804465E;
	Tue, 12 Aug 2008 22:48:18 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 604AC1190002; Tue, 12 Aug 2008 23:40:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812175629.GA28014@leksak.fem-net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92144>


--rPF8rPXpDlNr1aSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2008 at 07:56:29PM +0200, Stephan Beyer <s-beyer@gmx.net> w=
rote:
> > +extern int merge_recursive_verbosity;
>=20
> Why this?
>=20
> So we have:
>  1. "merge.verbosity" config value
>  2. GIT_MERGE_VERBOSITY environment
>  3. merge_recursive_verbosity variable
>=20
> I wonder if 3 is really necessary.

Yes, IMHO it is. The idea is that a

git_config(merge_recursive_config, NULL);
merge_recursive_setup(0);

will take merge.verbosity and GIT_MERGE_VERBOSITY into account, finally
you can always read merge_recursive_verbosity, and you don't have to
deal with the details (if it is set based on GIT_MERGE_VERBOSITY or
based on merge.verbosity).

--rPF8rPXpDlNr1aSW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiiA2EACgkQe81tAgORUJZDawCfayhaFpIYJceGo18RSn4BxFug
RMkAnRkByt0a7xCYTp89Xt4sA84LE3oa
=CBmS
-----END PGP SIGNATURE-----

--rPF8rPXpDlNr1aSW--
