From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 17:54:53 +0200
Message-ID: <20071005155453.GB20305@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <1191598424.7117.10.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="+g7M9IMkV8truYOl";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdpW5-0000uP-Fw
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912AbXJEPy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757443AbXJEPy5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:54:57 -0400
Received: from pan.madism.org ([88.191.52.104]:45966 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755316AbXJEPy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 11:54:56 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D9208238E6;
	Fri,  5 Oct 2007 17:54:53 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 879321E170; Fri,  5 Oct 2007 17:54:53 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <1191598424.7117.10.camel@hinata.boston.redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60097>


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2007 at 03:33:44PM +0000, Kristian H=C3=B8gsberg wrote:
> On Fri, 2007-10-05 at 16:25 +0200, Pierre Habouzit wrote:
> > The option parser takes argc, argv, an array of struct option
> > and a usage string.  Each of the struct option elements in the array
> > describes a valid option, its type and a pointer to the location where =
the
> > value is written.  The entry point is parse_options(), which scans thro=
ugh
> > the given argv, and matches each option there against the list of valid
> > options.  During the scan, argv is rewritten to only contain the
> > non-option command line arguments and the number of these is returned.
> >=20
> > Aggregation of single switches is allowed:
> >   -rC0 is the same as -r -C 0 (supposing that -C wants an arg).
> >=20
> > Boolean switches automatically support the option with the same name,
> > prefixed with 'no-' to disable the switch:
> >   --no-color / --color only need to have an entry for "color".
> >=20
> > Long options are supported either with '=3D' or without:
> >   --some-option=3Dfoo is the same as --some-option foo
>=20
> That looks great, works for me.  One comment, though: it looks like
> you're not sure whether to call these things "options" or "switches".
> We should choose one and stick with it.

  I use the word "switch" when it's a short_option, and "option" when
it's a long one. But maybe the distinction doesn't make sense, and it's
a non-native speaker glitch. I don't care that much btw.

> > oh and I don't grok what OPTION_LAST is for, so I left it apart, but
> > it seems unused ?
>
> Oh, kill that.  I used that as the option array terminator before we
> switched to ARRAY_SIZE().

  Okay :)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBl5NvGr7W6HudhwRAjiRAJ0dbCTraDPJ7n/J516ewZWVg3wACQCfeH2o
Tdq4CS8PboJMDjA4Zz9UHaY=
=opZI
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
