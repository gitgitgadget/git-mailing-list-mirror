From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add a simple option parser.
Date: Thu, 04 Oct 2007 17:15:32 +0200
Message-ID: <20071004151532.GB5083@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071003231145.GF28188@artemis.corp> <1191509878.29379.2.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Y7xTucakfITjPcLV";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:16:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSQV-0005VO-S5
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbXJDPPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 11:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbXJDPPj
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:15:39 -0400
Received: from pan.madism.org ([88.191.52.104]:39004 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbXJDPPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:15:38 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 915372360F;
	Thu,  4 Oct 2007 17:15:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C7BB41E40F; Thu,  4 Oct 2007 17:15:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <1191509878.29379.2.camel@hinata.boston.redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59962>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2007 at 02:57:58PM +0000, Kristian H=C3=B8gsberg wrote:
>=20
> On Thu, 2007-10-04 at 01:11 +0200, Pierre Habouzit wrote:
> > On Wed, Oct 03, 2007 at 09:45:01PM +0000, Kristian H=C3=B8gsberg wrote:
> > > The option parser takes argc, argv, an array of struct option
> > > and a usage string.  Each of the struct option elements in the array
> > > describes a valid option, its type and a pointer to the location wher=
e the
> > > value is written.  The entry point is parse_options(), which scans th=
rough
> > > the given argv, and matches each option there against the list of val=
id
> > > options.  During the scan, argv is rewritten to only contain the
> > > non-option command line arguments and the number of these is returned.
> >=20
> >   if we are going in that direction (and I believe it's a good one), we
> > should be sure that the model fits with other commands as well. And as I
> > said on IRC, I believe the most "horrible" (as in complex) option parser
> > in git is the one from git-grep.
> >=20
> >   A migration of git-grep on that API should be tried first. If this
> > works well enough, I believe that the rest of the git commands will be
> > migrated easily enough. (with maybe small addition to parse-option.[hc]
> > but the hardcore things should have been met with git-grep already I
> > think).
>=20
> I'm not sure - we can go with the current proposal and add new options
> types and probably the callback option type I suggested as we go.  I
> don't want to block builtin-commit on figuring out what the perfect
> option parser should look like and what I sent out earlier work for
> commit.  I think the way you handled the strbuf rewrites worked pretty
> well; extending and rewriting the API as you put it to use in more and
> more places.  We can do the same thing with parse_options().

  Of course we can do that, or junio said that some people talked about
popt some time ago. I understand that you don't want to block the
git-commit work, but doing things right from the beginning is often a
big win on the long term.

  I don't know popt, and I don't know if it has sufficient expressivity.
For sure I don't like getopt_long APIs at all, so if popt is as
cumbersome, rolling our own based on the current parse_options you
propose is probably a good choice.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBQOUvGr7W6HudhwRAl/BAJ9j8uAQqx8Pv5Zb4jTBn+bUy94EPgCfbVLK
SiUgZtVGSkizW6ykvOuNYeg=
=+cUs
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
