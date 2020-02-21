Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E7C11D25
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9159120722
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 02:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="s2hDxPuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgBUC0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:26:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37678 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbgBUC0F (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Feb 2020 21:26:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 76B5B60799;
        Fri, 21 Feb 2020 02:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582251963;
        bh=SpLHEe1uzKykrJZi8bRu9dmjvxbH51gSI07EjebVHVE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s2hDxPuOnK6u37GNSADbi7+bFIW0q65y+doXKVEm93hrMSf3PmIg1O1bnBfRAbyhK
         fZSG6OJUdEGwCu4UyY/vgo6iOGydKEn2dZ1E/09vjtvISG5JT+lbkHQME4a4As3R9V
         aYw+4t+QFN/SZMJCyGpZOGVWN1eMZ8Wiib1lc9fasNvVc1yJzWkikiZMmOLlLdC8v4
         DtBPkbGvZmfR0tSThzQddpdkQVsV6PDtnUg2s/268edbRc3kePr+uaPabQ4kxcqPnd
         rchEHti7UEeIsjeRw57z2pJwF01aIdfSfdV4KylF+ij9ytoZzuUi+6ENlYufm0EPcj
         8o0MsIhkS2paGvrwVjnPDMdJ03z5M0NIfh1er9jwZWGm2y+IckaTNfCMOsB0aEEuA+
         JVPiuVkxkN00wAw+ANn6QtllFAhKQcx28tTUHYlmQZTSNR2YBz9ZqQu7eM++g5LJU7
         TSnffAifhEE/ctiucUYUpTdUaON0Bi9t60TRK5vpTGwgXGBHeLN
Date:   Fri, 21 Feb 2020 02:25:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git does not wait on hook exes (^C)
Message-ID: <20200221022558.GD6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
 <20200221000141.GA6462@camp.crustytoothpaste.net>
 <CA+dzEBkP==U7iS=6vS4=g7LYwh_cKzqbPApDraiYv7tiwPOVHA@mail.gmail.com>
 <20200221011138.GB6462@camp.crustytoothpaste.net>
 <CA+dzEBk5D9x=sQnKDwAPHXOS_8gnA37X9sn+ccpfViEauiC5ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <CA+dzEBk5D9x=sQnKDwAPHXOS_8gnA37X9sn+ccpfViEauiC5ww@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-21 at 01:20:51, Anthony Sottile wrote:
> My hook in question is a python process: https://pre-commit.com
>=20
> It doesn't really do all that much on SIGINT but prints "(^C)
> Interrupted" and offers a crash log when receiving ^C -- this races
> with the git process terminating and causes terminal spew (sometimes
> with pretty bad consequences with input breaking until `reset`
> depending on which thing wins the tty reset race).

Thanks, this is helpful context.  I don't know that Git waiting for the
process is going to fix the broken terminal state, although it will
likely fix the jumbled output.

I'm not planning on writing a patch, but I think an interesting patch to
see might be if we called wait(2) in a loop in a SIGINT handler but
didn't reinstall the signal handler, which means that a second Ctrl-C
would kill Git.  I believe that's what certain other programs do, and
that might address many of the problems in both scenarios.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5PP7UACgkQv1NdgR9S
9otFYw/+N7AU0PuXCsWPqzvvydrqEoasJC8G4DzcuHC2Tuomsz/ClYIaPclPNvuE
+5fSec43wfQEgSsIeT5XOPRKTJkvBzajRNoWswkaIrFTExtah9Yj3dQyT9C1ulDq
vUiP7TUrMbu5xAEZ6xHmE2Owxn83jPrHRUJxcNZAVmXOBl2GETOa6bkdVD1rsMLx
zpKb+I4zVtEsuKtrsxj8ZDEiPIx1oQ4tIXYAy2m5zv1//WKV2X6kwsZ+cP4AiN5x
IuIo4XGuCKg+2NJYwUoDJOGw4eOZTZcekhkKWt3ZKncypTSxAW0HLJRTMXMLsEmo
DhDYp2vN8oVk4BPyrD0DcSJJBPvmYvE+sf1bkfK2uyhVUzwRibh4nfteoMGppFVC
ZqMGPIbmuMpPUZPxT8hu98rHANPNDcQtKHdXvmrwThxkPopTOm1m7ysu8wfFDr8Q
ki/q/HrxoVk5xp8sUmu1/DNY4/n3MjJuvX8wb9fsqeIB7f2tm488YyVeh1PBzQA5
QRWOpgitr8Np83KSR1SqRNAIUB82CAHUJlAE+OjNwKl0C/fTCEnmmqg5JvqVm7/v
tt5iXffW2vDFVkhD/KRdEayim2h+fjIYxE+cjJdklQNWDn6wBn9Hb2W1fz0pQctw
totNn1aQbVoBvyE071U2TFgTcLWZHd3fTIPOS0xxkMxiiBFMxgc=
=8U3m
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
