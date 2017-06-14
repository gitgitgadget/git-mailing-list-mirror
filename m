Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7131FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 00:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbdFNAGe (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 20:06:34 -0400
Received: from sunbase.org ([178.79.142.16]:51872 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753311AbdFNAGd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 20:06:33 -0400
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1dKvpQ-00032m-Bq; Wed, 14 Jun 2017 00:06:32 +0000
Date:   Wed, 14 Jun 2017 02:06:32 +0200
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [BUG] b9c8e7f2fb6e breaks git bisect visualize
Message-ID: <20170614000630.44uctc5y7dyyleqy@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Git mailing list <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lcnizau34ajh4cl7"
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170609-18-9a0a4f (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lcnizau34ajh4cl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit b9c8e7f2fb6e ("prefix_ref_iterator: don't trim too much") breaks=20
git bisect visualize, this reproduces the bug:

  $ git bisect start
  $ git bisect bad
  $ git bisect good HEAD^^
  $ git bisect visualize
  fatal: BUG: attempt to trim too many characters
  $

Reverting b9c8e7f2fb6e makes git bisect visualize work again.

Tested on Debian GNU/Linux 8.8 (jessie).

=C3=98yvind

N 60.37604=C2=B0 E 5.33339=C2=B0
OpenPGP fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5
dcacbb24-5094-11e7-b7e4-db5caa6d21d3

--lcnizau34ajh4cl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllAfgYACgkQ+wy+6JSlBuVFgwCeKuXbXarLZQstCoPVQjoAqLcX
MhYAniRZ/Jae0H3yOG3007vZ1e7Z/C3G
=oaX0
-----END PGP SIGNATURE-----

--lcnizau34ajh4cl7--
