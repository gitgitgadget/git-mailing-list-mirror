Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3731F453
	for <e@80x24.org>; Tue, 23 Oct 2018 22:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeJXHVk (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 03:21:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728408AbeJXHVk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Oct 2018 03:21:40 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 58FCB61B72;
        Tue, 23 Oct 2018 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540335370;
        bh=GuPnk93v7NyaIuaxDqTx+2M+6y4WkVqZrPMTkW/+jYg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VNn/EE88jQpGM97F7kbRVaGkFpOFUgdhaDVyxDcgFg/ZaX/BnxcbC0TtfS6Fst+4N
         xeXy1IMnPW2y+xIzPVs7wE9DDNEaYBuF3+bPCs20AggfIdWYTTOmCazxVuxOcWcSyc
         aPnHJDjh2/RKKWfRI4bx+p7PVpmX45x5h+leTucaUG1qh6JhTL20sPEdXYbWgZhSH7
         8rDE41nka88wijFk9ykaIaOUQCwIXVtPgh7Q3DsrElLmRjx+7gH2clUSLNMr7r6uDh
         SyTpxL24ugWR1Ynw3ani0mYgb4zJ27QyJmP2A6ZDHqhyRsC+Tb53QdbSuUSphEe2eO
         1LvcB4cb8HXjI2tFw8buQgIwmBUjFVkZFy8eoezBEakJfnPzpyvq9iuBDeMNzvluvG
         HOYu8PCZkKepILoccfI3IEmKPyWi6Q0KqgAU6jBywGX1LpEojMrkUlm/B5165E27i5
         BoMSkJ2b6ccUXozq45U8IErVgSoCV05Y/sr1JTl+T8kVAxc4WhU
Date:   Tue, 23 Oct 2018 22:56:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] gpg-interface.c: use flags to determine key/signer
 info presence
Message-ID: <20181023225605.GB6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org
References: <20181022163821.23523-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20181022163821.23523-1-mgorny@gentoo.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2018 at 06:38:19PM +0200, Micha=C5=82 G=C3=B3rny wrote:
> Replace the logic used to determine whether key and signer information
> is present to use explicit flags in sigcheck_gpg_status[] array.  This
> is more future-proof, since it makes it possible to add additional
> statuses without having to explicitly update the conditions.

This series looks good to me.  I was going to ask after patch 2 whether
you were printing the subkey or primary key fingerprint, and then you
answered my question in patch 3.  Thanks for including both.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvPpwQACgkQv1NdgR9S
9oteDQ//Wag8iE5I/t0WK0eMpMFdcsiDPqHUksJRPuBpqyclF9R12VWUlOxAIEi6
byeQDER8w3Ftv7rtrLgeBrCZkg4dy+2GI/GqLXNE3WUrGEEt6MiFGjTAPmMBiW0O
2gwRuPKt5nJFmhr8Fh/xuEEr8g0BMi4iedhhDNpATd2Qkx75DZrfLPzDIPEsYatP
F+4HRpgQTRJ+mF7kfeTLpYIfHh7BM5xe5IwxfDsam+TQ26ykjXHz73SH8DfCh40I
QeWnt+KPeeqGpPwd8zZmXszL+umWOC/+uTi+o3zFzmOYkGPgWa3zvtV4Ntcw8MyL
5LZiRFMjjbaYf0g6OMxC8KOav+wMisSD+W/MWuWOi0c672IPhQHLcEMHAByYmevr
SNCD8a5fvitv95hVKkLjoprL2PUAgYnUr2tahCQA9oz6mWaqj8U0MRRz+veojXEg
BLF4/3GJzzrF7sYYqLNCtRI2r2sGrbBBXsWssBFKrwcOKgZ3130p1ylYr0IdSeFP
jEOLJi82KSNARwO2wxpNFnUgzytZszMJNSt2tOrChbEbikcONEMAUZRfEWaMd4TZ
en1bDBKfUJrvg7M8UgVkFVf9RI5FDAdzsnVWLcgq5BrkKUC2dvciFrn4v2m5uUMf
63OIRX03JHYWA1qhMWpZlBJOkOPPhgumZ7zgOZsfcBtT2zMLhnY=
=ggu8
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
