Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8A01FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 01:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbdFNBPU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 21:15:20 -0400
Received: from sunbase.org ([178.79.142.16]:52082 "EHLO sunbase.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752456AbdFNBPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 21:15:18 -0400
Received: from sunny by sunbase.org with local (Exim 4.84_2)
        (envelope-from <sunny@sunbase.org>)
        id 1dKwtv-0007dQ-HM; Wed, 14 Jun 2017 01:15:15 +0000
Date:   Wed, 14 Jun 2017 03:15:15 +0200
From:   =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
To:     Git mailing list <git@vger.kernel.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: t1308-config-set.sh fails on current master
Message-ID: <20170614011514.sh4euddp44hjbu4u@sunbase.org>
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a4fk6kit5nfli7oh"
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: NeoMutt/20170609-18-9a0a4f (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a4fk6kit5nfli7oh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

t1308-config-set.sh fails on current master (v2.13.1-449-g02a2850ad58e).=20
The error is introduced by commit e2d90fd1c33a ("config.mak.uname: set=20
FREAD_READS_DIRECTORIES for Linux and FreeBSD"). Reverting the commit=20
results in a conflict, but the test works on the commit before,=20
02912f477586.

Tested on

  Debian GNU/Linux 8.8 (jessie)
  Linux Mint 18 Sarah

Test output:

  $ ./t1308-config-set.sh
  ok 1 - setup default config
  ok 2 - get value for a simple key
  ok 3 - get value for a key with value as an empty string
  ok 4 - get value for a key with value as NULL
  ok 5 - upper case key
  ok 6 - mixed case key
  ok 7 - key and value with mixed case
  ok 8 - key with case sensitive subsection
  ok 9 - key with case insensitive section header
  ok 10 - key with case insensitive section header & variable
  ok 11 - find value with misspelled key
  ok 12 - find value with the highest priority
  ok 13 - find integer value for a key
  ok 14 - find string value for a key
  ok 15 - check line error when NULL string is queried
  ok 16 - find integer if value is non parse-able
  ok 17 - find bool value for the entered key
  ok 18 - find multiple values
  ok 19 - find value from a configset
  ok 20 - find value with highest priority from a configset
  ok 21 - find value_list for a key from a configset
  ok 22 - proper error on non-existent files
  not ok 23 - proper error on directory "files"
  #
  #               echo "Error (-1) reading configuration file a-directory."=
 >expect &&
  #               mkdir a-directory &&
  #               test_expect_code 2 test-config configset_get_value foo.ba=
r a-directory 2>output &&
  #               grep "^warning:" output &&
  #               grep "^Error" output >actual &&
  #               test_cmp expect actual
  #
  ok 24 - proper error on non-accessible files
  ok 25 - proper error on error in default config files
  ok 26 - proper error on error in custom config files
  ok 27 - check line errors for malformed values
  ok 28 - error on modifying repo config without repo
  ok 29 - iteration shows correct origins
  # failed 1 among 29 test(s)
  1..29
  $

=C3=98yvind

N 60.376=C2=B0 E 5.3334=C2=B0
OpenPGP fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5
2daabdde-509d-11e7-a17a-db5caa6d21d3

--a4fk6kit5nfli7oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAllAjiIACgkQ+wy+6JSlBuXRpACXRmxacvMl/x/9mJiz00v2XqZp
3wCfbYzQlJetCpyWm5NZ6pa09bU3lzw=
=X3hh
-----END PGP SIGNATURE-----

--a4fk6kit5nfli7oh--
