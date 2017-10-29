Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7311202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 16:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbdJ2Qwv (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 12:52:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751036AbdJ2Qwu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 12:52:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E14A96044A;
        Sun, 29 Oct 2017 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509295969;
        bh=eBH2f321xpmqZGPaO2+/M2o8uGUAniH6c7jf2iHujCE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=a1w6EuiNXtcnS/cy26zC056K/PF/kxYQCYZm5UeGUmTrjxyd1EP75UyyZxIVZpne8
         WB9HBAjUg/2IEliFG9L5+VSs9HpP564p6MuiV2Ptzfaxrt1r+WU+gK8e4rHAzgup3k
         Drzv37bRgDU40/jMvhNbOfVJ+++njeyEMV23MVX9ZNgVTxyiwVHWLSfOzLUJP8EfvX
         LIo32OTLuiER5KJGqzHJK9jbWoIabvSTZkhMs7H0/YhDdlk+LC8fbpGUIYJo9Z74uT
         2XWkCExkmt+PtUupFdi/GFQyRXTlizfxbAtGRNT+xi2Qcma3FByJJgMQbHLXqs7LCD
         mNakDJbB7Qoyhfqu1YnUD9+S6HNzeFKoHUomKJGeTS7PbGeNwRoxBkvKqit1TNRIuS
         CrD39+HNrSJpwB8oImDW7hdxjDrb5xPlXAnuTfoHCBOLTppbjPRNpD+z7arG1NQlzq
         zHMl9dbvcz3HL+kXcOu+2vP/Xwkn8iRDPs/ImyoSOwl03YJRI2H
Date:   Sun, 29 Oct 2017 16:52:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christopher Jefferson <caj21@st-andrews.ac.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rm VERY slow for directories with many files.
Message-ID: <20171029165244.si4a5furgf6trqe3@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Christopher Jefferson <caj21@st-andrews.ac.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BEEA4A16-5433-4E6C-A7D7-956C85F27DF3@st-andrews.ac.uk>
 <20171028223103.wevq5zf4rjl7ietd@genre.crustytoothpaste.net>
 <xmqqbmkqbwt0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ww5frcmxwlp3hyt2"
Content-Disposition: inline
In-Reply-To: <xmqqbmkqbwt0.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ww5frcmxwlp3hyt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2017 at 09:51:55AM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > First, make sure your working directory is clean with no changes.  Then,
> > remove the directory (by hand) or move it somewhere else.  Then, run
> > "git add -u".
> >
> > That should allow you to commit the removal of those files quickly.
>=20
> If get_tree_entry() shows up a lot in the profile, it would indicate
> that a lot of cycles are spent in check_local_mod().  Bypassing it
> with "-f" may be the first thing to try ;-)

That is indeed faster.  I tested my solution by creating a directory
with 20,000 files in a temporary repo.  git rm -r took 17.96s, and git
rm -rf took .12s.  (This is on an SSD.)

That's also a nicer and more intuitive solution than mine.

> I wonder how fast "git diff-index --cached -r HEAD --", with the
> same pathspec used for the problematic "git rm", runs in this same
> 50,000 path project.

I'll let the original poster answer this one as well, but it was very
fast in my test repo.  I'm not very familiar with the code path in
question, but it definitely looks like we're avoiding the quadratic
behavior in this case.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ww5frcmxwlp3hyt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln2B1wACgkQv1NdgR9S
9os5LA//bzFCGWa1cqsiBibkKTUpqV5+UY1VuayYmaN+Z4Ae4h2LPkS10rdg9C7B
UUrrfBaXahYDU+mBX4uBWMYNBsUSXcfVMoIuGN4HaFKGEs9YUODJKaujSnPRGZkH
C0uPmePusnfNfO/KzdsezowH0iPB2H8KGERa2DxYt6mfEpTdkhln96poNbRYz348
uG4agSmLgkX1tfgevbUyRh6iUmFGKly7U2UZt6wLAZp+KXWnezaMd17VB+QYDNRv
Q9zocty+DjowLKWghX9KDX9K1pXAuXBLS85ECdx5mx4bJ//Ntr4ncU1rlVmD9NUA
1vf95hd1w8k5K4ap6CQN2QuEm3cf8qyFk7H0EHcr00Uaf5O/hwSUyRlSu8gM6D9M
2oUUvHEVwsAZW1rinyHhVua5L+IRneB57BNiIqCX6lWGSEioglZCAytujjatSkKI
Ln5um3hX5EiIpXwtbMA2cU2M0INsCsZjyj58Q3k+/EZWFs1hpBty8asn5qtUbDSo
+lopBa5tzhJdTiKHjYB43UGRkQX3PuM/rVo4Pf2W8C8eYgIuA5Gracss1t3DZ2Gv
qQ/Orv+ix7rS/Tgg6hbmI1O6UP62aP4FbNLwkyjMqYDCqMrPeA22G7nHjFq0BdKn
+3TFkaGBRjuT36MYAwiaRii89MmdoCpanoT1F3r1ZmWBHFaQpL4=
=RJip
-----END PGP SIGNATURE-----

--ww5frcmxwlp3hyt2--
