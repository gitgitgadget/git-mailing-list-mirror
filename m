Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172D01F437
	for <e@80x24.org>; Wed, 25 Jan 2017 02:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdAYC0f (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 21:26:35 -0500
Received: from sunbase.org ([178.79.142.16]:50030 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbdAYC0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 21:26:34 -0500
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1cWDI6-0008RM-Ea; Wed, 25 Jan 2017 02:26:30 +0000
Date:   Wed, 25 Jan 2017 03:26:30 +0100
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/7] Makefile: add a knob to enable the use of
 Asciidoctor
Message-ID: <20170125022628.dyqokkdfxasfxjrl@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
 <20170122024156.284180-8-sandals@crustytoothpaste.net>
 <20170123025712.o52hgkdu26h6lrm2@sunbase.org>
 <20170123040917.lrd6ic6wb6nxulzf@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vbldvyifiqbmcp4k"
Content-Disposition: inline
In-Reply-To: <20170123040917.lrd6ic6wb6nxulzf@genre.crustytoothpaste.net>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170113-39-5ee58c (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vbldvyifiqbmcp4k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-01-23 04:09:17, brian m. carlson wrote:
> On Mon, Jan 23, 2017 at 03:57:13AM +0100, =C3=98yvind A. Holm wrote:
> > On 2017-01-22 02:41:56, brian m. carlson wrote:
> > > While Git has traditionally built its documentation using=20
> > > AsciiDoc, some people wish to use Asciidoctor for speed or other=20
> > > reasons.  Add a Makefile knob, USE_ASCIIDOCTOR, that sets various=20
> > > options in order to produce acceptable output.  For HTML output,=20
> > > XHTML5 was chosen, since the AsciiDoc options also produce XHTML,=20
> > > albeit XHTML 1.1.
> >
> > I applied and tested the patches on the current master, commit=20
> > 787f75f0567a ("Sixth batch for 2.12"), and "make doc" with=20
> > USE_ASCIIDOCTOR fails:
> >
> > [...]
> >
> >   $ asciidoctor --version
> >   Asciidoctor 0.1.4 [http://asciidoctor.org]
>
> I think you need a newer version of Asciidoctor.  I fixed one or two=20
> issues upstream in 1.5.2, I think, that made it work properly.

I've tried on Linux Mint 18 with Asciidoctor 1.5.4 now, and it works=20
there, so the version is probably too old, yes.

> You could try to do the build with the "html5" target instead of=20
> "xhtml5" and see if that works.  If so, we could switch to that=20
> instead if we want to support older Asciidoctor versions.

It went a little better, but after a while it died with

  $ make doc USE_ASCIIDOCTOR=3D1
  [Cut 249 lines]
      GEN technical/api-index.txt
      ASCIIDOC technical/api-index.html
      ASCIIDOC git-init-db.xml
  sed "s|@@MAN_BASE_URL@@|file:///home/sunny/share/doc/git-doc/|" manpage-b=
ase-url.xsl.in > manpage-base-url.xsl
      XMLTO git-init-db.1
  xmlto: /home/sunny/src/git/src-other/devel/git/git/Documentation/git-init=
-db.xml does not validate (status 3)
  xmlto: Fix document syntax or use --skip-validation option
  /home/sunny/src/git/src-other/devel/git/git/Documentation/git-init-db.xml=
:5: element article: validity error : root and DTD name do not match 'artic=
le' and 'manpage'
  Document /home/sunny/src/git/src-other/devel/git/git/Documentation/git-in=
it-db.xml does not validate
  Makefile:343: recipe for target 'git-init-db.1' failed
  make[1]: *** [git-init-db.1] Error 13
  make[1]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git/D=
ocumentation'
  Makefile:2091: recipe for target 'doc' failed
  make: *** [doc] Error 2
  $

and that's fair enough, since the generated html isn't well-formed.=20
Adding --skip-validation to XMLTO_EXTRA gave a slightly different=20
result:

      GEN technical/api-index.txt
      ASCIIDOC technical/api-index.html
      ASCIIDOC git-init-db.xml
  sed "s|@@MAN_BASE_URL@@|file:///home/sunny/share/doc/git-doc/|" manpage-b=
ase-url.xsl.in > manpage-base-url.xsl
      XMLTO git-init-db.1
  Note: namesp. cut : stripped namespace before processing           git-in=
it-db(1)
  Note: namesp. cut : processing stripped document                   git-in=
it-db(1)
  Erro:  no refentry: No refentry elements found in "git-init-db(1)  git-in=
it-db(1)
  Makefile:343: recipe for target 'git-init-db.1' failed
  make[1]: *** [git-init-db.1] Error 1
  make[1]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git/D=
ocumentation'
  Makefile:2091: recipe for target 'doc' failed
  make: *** [doc] Error 2
  $

But frankly, this probably isn't a showstopper. Even though this is the=20
newest stable version of Debian, Asciidoctor 0.1.4 was released=20
2013-09-05, 3y5m ago. USE_ASCIIDOCTOR isn't the default, so people can=20
build the docs with asciidoc, and that works in Debian 8.7.

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 1698e7f6-e257-11e6-bfa0-db5caa6d21d3 |-------------+

--vbldvyifiqbmcp4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliIDNQACgkQ+wy+6JSlBuUtegCeMA7xU8MJbcuJ/itpjdJk0fVe
pH4AnRGJg/JKHBnu6Y+GlPRSDru+NidU
=LBXS
-----END PGP SIGNATURE-----

--vbldvyifiqbmcp4k--
