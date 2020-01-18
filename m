Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBA0C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD8524680
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="V8b74QXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgARTmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 14:42:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbgARTmL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Jan 2020 14:42:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 290C060482;
        Sat, 18 Jan 2020 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579376530;
        bh=WXHedgivq6Ly9KKdsFZ5p42eEtZla9z8ME/D3Mhw/WA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=V8b74QXF4IdvxGM3eGVCKi0zOddyHrsLfCtEqDX2TMVgJjQM9+ZBqhomC5Ngz6Txh
         iyMmY9yfchMdDNVcJrRajVDsMAYgAigwrlV3bfExE3uZQbm8xPSCVMQPcrLyVmLtQZ
         leEEcaapuTgkFbFkGZTxPaFQAA6KeWHjTZ/URGEE48S6yVEBouikhWDSQXCqblWsHL
         kLkZm9FEktJ9Af76kZF2kzI+cNYNvDraiYcexY6QNr+33moHvUH7jaE4uJvdd8N20G
         NP0MBhyHl8PWZyKYAtWjplCRXGEYCDFHvQhFBK/qlVst2puzQvGUmwMk4QDjUuWojc
         9QGr47zEhIGQ7nX9q1ggtfaYzy5ElSfyfhvezXx7zW4dAqKLWQmpZ8lYoDILnSy+UL
         4vVIstZVgXoQgdJ0Cvn7VXjDaJlsCx4L2YbJzpFZeudvWrxSiv6uqlNRpPo6oDi0Eq
         G1KTI/7NzWjLhcqD0EafdNfR7rDuInnQdAbztgMdnVOI3y32bkO
Date:   Sat, 18 Jan 2020 19:42:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Christoph Groth <christoph@grothesque.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Stat cache in .git/index hinders syncing of repositories
Message-ID: <20200118194204.GC6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christoph Groth <christoph@grothesque.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <87v9p9skjz.fsf@drac>
 <xmqq7e1od41x.fsf@gitster-ct.c.googlers.com>
 <87pnfgshxu.fsf@drac>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oSWi0jal9INzEBQ4"
Content-Disposition: inline
In-Reply-To: <87pnfgshxu.fsf@drac>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oSWi0jal9INzEBQ4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-18 at 19:06:21, Christoph Groth wrote:
> But if the above is not feasible for some reason, would it be possible
> to provide a switch for disabling stat caching optimization?

Git is going to perform really terribly on repositories of any size if
you disable stat caching, so we're not very likely to implement such a
feature.  Even if we did implement it, you probably wouldn't want to use
it.

However, there are the core.checkStat and core.trustctime options which
can control which information is used in the stat caching.  You can
restrict it to the whole second part of mtime and the file size if you
want.  See git-config(1) for more details.

Note that this assumes that (a) your sync tool can honor mtimes and (b)
that your sync tool syncs to another system of the same type.  You may
still run into problems if you share files between Linux and Windows
because symbolic links are different sizes there.  (This also bites
WSL.)  Since rsync can do the former, I think it's a reasonable
expectation that other tools can as well.

One final word of caution: you probably want to activate your sync tool
only manually and only when the repository is idle.  Tools like Dropbox
that automatically sync files one by one have been known to corrupt
repositories because the way they sync data leaves the repository in an
inconsistent state and doesn't honor standard POSIX file system
semantics which Git relies on for integrity.

Hopefully with that information you can find a configuration and tool
that work for you.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oSWi0jal9INzEBQ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4jX4sACgkQv1NdgR9S
9os4JQ//XGPZ7SIcHUDfpXgPcdl6F5sfV930XcP8FmOLUL3u888vpdmSS+iB2RoK
c4BY+c4raRQNx7uIzrCIv1dGAqKEY1t/2sq01a+Xfbf6AgENe4tTcRfEf9LI4tP8
kZXNbA4QGN3OCtAfclNdxyNTxxwAigZb9ak+CMdv8F9+ND114Im+xiLUeWP4hl/Y
rBIF+3oKAsv0soSdzlsez1Ah0bIx5IbRQBJWqQvN2xL67LReSNRdzP9Y+5GNiur7
Fd3tPF3UTx++bI1xSKogpHgRza868Oew90MF7k9AMMEmSPgq7BoqG0e3tEv4EHnZ
clOaQs/pXPpKM3cEazMdpT/io5wBo+YMHIkB7MbaQhkM970mh0K3v9nxtdKM5MS7
ij9V901Q65srFpZfgXUDP6bZIncxGqmUtXG8IuIuk04sTPf1qVk12Us6x0PxNP8a
oBCbK+zdDEWd+EI5GvRBOXrY6oumQCr42R57Y1LHCwuAx2BbMmDYM1dW8G8Q3XyD
VftuDBE00zUpzMGTpgkIPtgPHHdi0jeYKdAzmdcrCZuARiAfjQ7AZnYBr9eEsdaw
MQGZh9o4fPNQJbQV4qJysJZv3mn1zahdDoV6sYXWJD6o+GYt1AOQLSRSqvwLv3wS
SRYIg2M7d949QL6GoaN+C2LU8WEkR2jlKy73/MXjZZ9193+yh/k=
=g+tS
-----END PGP SIGNATURE-----

--oSWi0jal9INzEBQ4--
