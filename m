From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 17:26:06 +0000
Message-ID: <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 19:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIikg-0007M2-0f
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 19:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758949Ab3IHR0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 13:26:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60136 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757564Ab3IHR0R (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 13:26:17 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8CCEB28072;
	Sun,  8 Sep 2013 17:26:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234255>


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 07, 2013 at 11:37:13PM -0500, Felipe Contreras wrote:
> On Sat, Sep 7, 2013 at 11:18 PM, Jeff King <peff@peff.net> wrote:
> > By "svn-like", I mean the people whose workflow is:
> >
> >   $ hack hack hack
> >   $ git commit
> >   $ git push ;# oops, somebody else pushed in the meantime
> >   $ git pull
> >   $ git push

It's possible that some teams at work may be using this workflow.  It's
more likely that there would be a rebase if the push failed, but some
teams might do a merge.  I don't know because we don't dictate workflow
to individual teams for the reasons I get into below.  Regardless,
merges are our typical workflow, so forcing rebase mode all the time
wouldn't be appropriate for us.

> >   $ hack hack hack
> >   $ svn commit ;# oops, somebody else committed in the meantime
> >   $ svn update
> >   $ svn commit
> >
> > Those people would now have to learn enough to choose between merge and
> > rebase when running the "git pull".
>=20
> But that's only if they don't care about the shape of history. In my
> experience the people that cling more to centralized VCS do not like
> merges, so they rebase everything to make it a straight line. That is
> much more "svn-like".
>=20
> So chances are they are already doing 'git pull --rebase' (or
> similar), so their workflow wouldn't be affected.

We end up squashing each project branch into one commit (usually using
git reset --soft), so we don't care about the shape of history.  Over
the course of a project branch, in fact, there may be many merges from
the main release branches (including other projects), so history is
going to be very messy otherwise.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSLLMtAAoJEL9TXYEfUvaLjnAP/jsovQWIYpV67FaWmU8d1MYl
mbH8QLBDrm9ikmTmFdAQn71HP8/J7BpdOQiSc0dASpzVQcBEZEORKa12r3rGngav
HdMMotIbirhQtkeXLQw4+P4TpqxNe5hmGlVo59svm0MYQmRDKg7euJ4lAAkwsgIn
AZschZNUe7ivNrp+6hQRvWNMIp52rEfhW5gML9Y8FxblISa2RMM22TJXtxFl0cQ7
zaazrUtOV7Z01sCFo0MWPJVZ8+ns26LWrZL9G5AVs+jy60u5bS82mvdMRIy1Yirp
S2wuTFArDmsqxJtyOdcpuRkYf47Zz7qHad3O2XGqbUnhEyZqMNCGN2EN+7pjUWws
et9JIBItndi0UdZe1rFatmtLFYNrTfUhDwuJQHhPAbo3GNPDj8G+ZVlLNmwTZKOQ
NpkGeAguUFzuUocKeLkFVS1k9huu55S2RCqgy5fcEZJYW4RLn/snUqQWftVs8i3i
wL9DDtIrxPQvL+lFP6vnpBNd5fprK5LJwOWCbfr2ZzJWM2UyUIaX+y7XGuAxfFu4
ldBANb9fOHlO+YOWjq3ed4H4GZFIpdaLTiCdr3NIgqaAMRMmcP+StyK9ncpWkLN3
hyYQ395Fzdn3dOtc91kQg7bnkbMRsZ1D/QkG+PQ6dl38J/qU3k+Z/YrfGfRlmz4c
WAxZNC+KMHfcc5K/8iOc
=tDAm
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
