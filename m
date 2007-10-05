From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 05 Oct 2007 16:45:40 +0200
Message-ID: <20071005144540.GM19879@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp> <20071005143014.GA18176@glandium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Ucgz5Oc/kKURWzXs";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 16:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdoR6-0002Yn-Rk
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 16:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbXJEOpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 10:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756672AbXJEOpn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 10:45:43 -0400
Received: from pan.madism.org ([88.191.52.104]:48406 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756307AbXJEOpm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 10:45:42 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A0A37237F4;
	Fri,  5 Oct 2007 16:45:40 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 512899580; Fri,  5 Oct 2007 16:45:40 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071005143014.GA18176@glandium.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60089>


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2007 at 02:30:14PM +0000, Mike Hommey wrote:
> On Fri, Oct 05, 2007 at 04:25:07PM +0200, Pierre Habouzit <madcoder@debia=
n.org> wrote:
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
>=20
> I like options aggregation, but I'm not sure aggregating option arguments
> is a good idea... I can't even think of an application that does it.

  You mean like `grep -A1` or `diff -u3` or `ls -w10` ?

getopt does that by default as well, so you may not have aware of it,
but it's how things work in your system already.

  btw `ls -rw10` works, though `ls -w10r` drops the 'r' silently. FWIW I
don't, in that case, the alternate patch I propose complains about "10r"
not being a valid integer, and that's because unlike getopt, the patch
krh proposed knows what an integer is ;)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHBk4UvGr7W6HudhwRAgLFAKCWFOuQ0MjUbPMRfRxmsM48ljefEACfZPLb
X8oIuspTOMOkBqRk6zGagXY=
=nkg8
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--
