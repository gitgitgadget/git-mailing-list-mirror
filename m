Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DEC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F22E20771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 22:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZcW/0KUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHNWJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:09:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41568 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgHNWJE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Aug 2020 18:09:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8A8F60458;
        Fri, 14 Aug 2020 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597442913;
        bh=KR5FjIXlK93UE8NN3yGnG5O9/BLKQABT/Jgza/vrA88=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZcW/0KUw3m1Ef64s1HTxsZmy1h4G6rHlkKlZXPpi6TeoPY2n1iPQ870rQMM+LUkHL
         5xWB38qXLeVmDfvcwXlfsiSAnZagO9csF2przJ0in/GjocyQU337PZI5JGwndSlx7a
         5psqHfMrHFFheQYVGbkExFT8HKZ3EmBBBSpzF8Ra2JReus4TygHJuehdU2+DGceJep
         zbnnMzAa8WcymDUaZWka9CLN5EZRFhiZW7mk/kCorOZTzdvLWqVD9a5Yzx/HIN5P33
         NwJAEiIkAXnhwMOnZoT95O94amI7qHtx+1KNOafS5YQ2cDduqg2jWFEg8gf7WT45o+
         Hk0mnq16N0NvpdKyoKrI/m43UwGAMb+v5fVv1/Hhr5e13z/spa0bfAFNRvV6xc8/qB
         38pGOe83Ksu34Be+/YZMW2NTrqtTgwnCR83Gqsj0Bje2jBY63qnAVSaDNh8PlXEH1d
         qcEtEES6vAVVj6TwY3V6A6syy3g16vFsxhFf6LBGXgrORUDJmbN
Date:   Fri, 14 Aug 2020 22:08:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     jim.cromie@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: git bisect enhancement request
Message-ID: <20200814220828.GP8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        jim.cromie@gmail.com, git@vger.kernel.org
References: <CAJfuBxw2KudBPfpmVqU9VOfnvrKdczU6Us5FWvpj50T88BarHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cmVHo2jXx4bdYlgS"
Content-Disposition: inline
In-Reply-To: <CAJfuBxw2KudBPfpmVqU9VOfnvrKdczU6Us5FWvpj50T88BarHw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cmVHo2jXx4bdYlgS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 21:11:19, jim.cromie@gmail.com wrote:
> please teach git bisect how to use 2 separate worktrees
> for the bisection, toggling between them as bisection progresses,
> so that the end result is 2 compiled kernels,
> one broken, one good.

I'm not sure how such a thing would be implemented.  Git doesn't know
until after it's checked out the tree whether a revision is good or bad,
since usually the user needs to tell it (or use git bisect run).  Even
if Git alternated between the two worktrees in order, that doesn't mean
that one of them will end up being good, since Git may find the last
good revision early on, then continue to bisect and find many bad
revisions until it determines the right one.

Can you tell us more about the algorithm you'd like to see here?
--=20
brian m. carlson: Houston, Texas, US

--cmVHo2jXx4bdYlgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzcLWwAKCRB8DEliiIei
gZ9VAQCpUp8l418jZMhce3uLkDXKtiJJjuSfFyyCrfmWNtfXAQD7BPOB9A16QEIn
Mj6D/Jr3hnM5renBSYy+VzTPefLtfgk=
=iANg
-----END PGP SIGNATURE-----

--cmVHo2jXx4bdYlgS--
