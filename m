From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [FYI] very large text files and their problems.
Date: Wed, 22 Feb 2012 19:39:40 +0100
Message-ID: <1329935980.23912.5.camel@pi>
Reply-To: pomac@vapor.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-532IvP1wWiPEST2AAE3X"
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 19:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0HDF-0007yt-7G
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 19:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab2BVSqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 13:46:44 -0500
Received: from mail.vapor.com ([83.220.149.2]:44252 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab2BVSqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 13:46:43 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Feb 2012 13:46:43 EST
Received: from twilight.demius.net (c-387a71d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.122.56])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 049A12B6004;
	Wed, 22 Feb 2012 19:39:43 +0100 (CET)
Received: from [10.0.0.11] (pi.local [10.0.0.11])
	by twilight.demius.net (Postfix) with ESMTP id 575628E01D1;
	Wed, 22 Feb 2012 19:39:41 +0100 (CET)
X-Mailer: Evolution 2.32.3 
X-Virus-Scanned: clamav-milter 0.97.3 at twilight.demius.net
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
	version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on twilight.pomac.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191269>


--=-532IvP1wWiPEST2AAE3X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Seems like i ruined my dovecot config in a recent upgrade - which also
affected my mail... =3D/

Anyway, it's all fixed now.

from: Nguyen Thai Ngoc Duy <pclouds () gmail ! com>
> On Wed, Feb 22, 2012 at 10:49 PM, Ian Kumlien <pomac@vapor.com> wrote:
> > Hi,
> >
> > We just saw a interesting issue, git compressed a ~3.4 gb project to
> ~57 mb.
>=20
> How big are those files? How many of them? How often do they change?

This is the initial check in, one of the files is a 3.3 gb text file.

> > But when we tried to clone it on a big machine we got:
> >
> > fatal: Out of memory, malloc failed (tried to allocate
> > 18446744072724798634 bytes)
> >
> > This is already fixed in the 1.7.10 mainline - but it also seems
> like
>=20
> Does 1.7.9 have this problem?

I've tested with 1.7.9.1, haven't downgraded to test with 1.7.9...

> > git needs to have atleast the same ammount of memory as the largest
> > file free... Couldn't this be worked around?
> >
> > On a (32 bit) machine with 4GB memory - results in:
> > fatal: Out of memory, malloc failed (tried to allocate 3310214313
> bytes)
> >
> > (and i see how this could be a problem, but couldn't it be
> mitigated? or
> > is it bydesign and intended behaviour?)
>=20
> I think that it's delta resolving that hogs all your memory. If your
> files are smaller than 512M, try lower core.bigFileThreshold. The
> topic jc/split-blob, which stores a big file are several smaller
> pieces, might solve your problem. Unfortunately the topic is not
> complete yet.

the problem here is that there is one file that is exactly: 3310214313
bytes, so it should all be one "blob".

split-blob would be really interesting for several reasons though =3D)

> --=20
> Duy
> --
--=20
Ian Kumlien  -- http://demius.net || http://pomac.netswarm.net

--=-532IvP1wWiPEST2AAE3X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk9FNmwACgkQ7F3Euyc51N8JSwCeJjwPt8hyCKmx2zgSHR6PoBQZ
NCoAni2z6Z+PHOr1g89kJlDKcAtPhZiB
=5yKO
-----END PGP SIGNATURE-----

--=-532IvP1wWiPEST2AAE3X--
