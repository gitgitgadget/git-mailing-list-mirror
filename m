From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 3/4] Makefile: allow building without perl
Date: Sat, 4 Apr 2009 16:51:48 -0700
Message-ID: <20090404T234556Z@curie.orbis-terrarum.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193220.GC5547@coredump.intra.peff.net> <20090404T224109Z@curie.orbis-terrarum.net> <20090404233936.GB26906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 01:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqFg5-0004IK-38
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 01:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbZDDXvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 19:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbZDDXvz
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 19:51:55 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:49423 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754401AbZDDXvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 19:51:54 -0400
Received: (qmail 14054 invoked from network); 4 Apr 2009 23:51:51 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sat, 04 Apr 2009 23:51:51 +0000
Received: (qmail 30620 invoked by uid 10000); 4 Apr 2009 16:51:48 -0700
Content-Disposition: inline
In-Reply-To: <20090404233936.GB26906@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115606>


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2009 at 07:39:36PM -0400, Jeff King wrote:
> > +ifeq ($(wildcard $(PERL_PATH)),)
> I'm not sure what you're trying to accomplish with the wildcard, unless
> it is "PERL_PATH =3D /usr/*/perl" or similar, but that seems a bit crazy
> to me. It should probably behave the same as TCLTK_PATH, though (so if
> there is a good use case, TCLTK_PATH should be enhanced).
No. The ifeq ($(wildcard $(PERL_PATH)),) is entirely correct.
It's one of the few ways to detect the existence of a file from within
Make, without any exec calls. If you give it a non-expandable path,
/usr/bin/perl in this case, it checks only that path, and either returns
it or an empty string. This enables us to check that /usr/bin/perl
exists, and take suitable action if it does not.

It's not suitable for use with the TCLTK_PATH, as that isn't an absolute
path, so the wildcard trick doesn't work.

> I don't think there is a point in setting NO_PERL_MAKEMAKER if NO_PERL
> is set, and I believe the export is pointless, as I described in an
> earlier email.
=46rom further down the Makefile:
ifdef NO_PERL_MAKEMAKER
    export NO_PERL_MAKEMAKER
endif

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknX8pQACgkQPpIsIjIzwixhxQCfTVNIed0BGgg4Br7MntUx/nyS
NdYAoJT//PKdaAe7+zofz8V7Jcbr+fcQ
=r9sR
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
