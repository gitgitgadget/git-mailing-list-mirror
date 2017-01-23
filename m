Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E354C2092F
	for <e@80x24.org>; Mon, 23 Jan 2017 02:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750725AbdAWC5Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 21:57:16 -0500
Received: from sunbase.org ([178.79.142.16]:43872 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbdAWC5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 21:57:16 -0500
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1cVUoj-0006d2-U3; Mon, 23 Jan 2017 02:57:13 +0000
Date:   Mon, 23 Jan 2017 03:57:13 +0100
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/7] Makefile: add a knob to enable the use of
 Asciidoctor
Message-ID: <20170123025712.o52hgkdu26h6lrm2@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
 <20170122024156.284180-8-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mk7s4fcraaf53ol"
Content-Disposition: inline
In-Reply-To: <20170122024156.284180-8-sandals@crustytoothpaste.net>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170113-14-7f1397 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5mk7s4fcraaf53ol
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2017-01-22 02:41:56, brian m. carlson wrote:
> While Git has traditionally built its documentation using AsciiDoc, some
> people wish to use Asciidoctor for speed or other reasons.  Add a
> Makefile knob, USE_ASCIIDOCTOR, that sets various options in order to
> produce acceptable output.  For HTML output, XHTML5 was chosen, since
> the AsciiDoc options also produce XHTML, albeit XHTML 1.1.

I applied and tested the patches on the current master, commit=20
787f75f0567a ("Sixth batch for 2.12"), and "make doc" with=20
USE_ASCIIDOCTOR fails:

  $ git clean -fxd && make doc USE_ASCIIDOCTOR=3D1
  Removing Documentation/cmd-list.made
  Removing Documentation/cmds-ancillaryinterrogators.txt
  Removing Documentation/cmds-ancillarymanipulators.txt
  Removing Documentation/cmds-foreignscminterface.txt
  Removing Documentation/cmds-mainporcelain.txt
  Removing Documentation/cmds-plumbinginterrogators.txt
  Removing Documentation/cmds-plumbingmanipulators.txt
  Removing Documentation/cmds-purehelpers.txt
  Removing Documentation/cmds-synchelpers.txt
  Removing Documentation/cmds-synchingrepositories.txt
  Removing Documentation/doc.dep
  Removing Documentation/mergetools-diff.txt
  Removing Documentation/mergetools-list.made
  Removing Documentation/mergetools-merge.txt
  Removing GIT-VERSION-FILE
  GIT_VERSION =3D 2.11.0.460.g218feb5a0e89
  make -C Documentation all
  make[1]: Entering directory '/home/sunny/src/git/src-other/devel/git/git/=
Documentation'
      GEN mergetools-list.made
      GEN cmd-list.made
      GEN doc.dep
  make[2]: Entering directory '/home/sunny/src/git/src-other/devel/git/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git'
  make[2]: Entering directory '/home/sunny/src/git/src-other/devel/git/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git'
      ASCIIDOC git-init-db.html
  Couldn't find a view in @views for document
    Use --trace for backtrace
  Makefile:330: recipe for target 'git-init-db.html' failed
  make[1]: *** [git-init-db.html] Error 1
  make[1]: Leaving directory '/home/sunny/src/git/src-other/devel/git/git/D=
ocumentation'
  Makefile:2091: recipe for target 'doc' failed
  make: *** [doc] Error 2
  2017-01-23 03:50:05 sunny@sunbase:~/src/git/src-other/devel/git/git (tp-b=
mc-asciidoctor)

  $ lsb_release -d
  Description:    Debian GNU/Linux 8.7 (jessie)

  $ asciidoctor --version
  Asciidoctor 0.1.4 [http://asciidoctor.org]

I installed Asciidoctor with a standard "apt-get install asciidoctor",=20
do I need to install more packages?

The build is broken by patch #7 ("Makefile: add a knob to enable the use=20
of Asciidoctor"), the other commits seems to work, though I haven't=20
tested them all individually yet. Standard "make doc" works.

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.37604=C2=B0 E 5.33339=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 60bceb4e-e116-11e6-8fac-db5caa6d21d3 |-------------+

--5mk7s4fcraaf53ol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAliFcQgACgkQ+wy+6JSlBuXK/QCghHGaWKAIPM5juCRJVf2U02kb
6S8AmN9SwdPSAqo0xzz63jy7hd3/hUw=
=KSxo
-----END PGP SIGNATURE-----

--5mk7s4fcraaf53ol--
