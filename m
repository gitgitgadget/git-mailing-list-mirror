Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22D21F404
	for <e@80x24.org>; Tue, 13 Feb 2018 00:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeBMAgg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 19:36:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932877AbeBMAgf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 19:36:35 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 19CA660987;
        Tue, 13 Feb 2018 00:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1518482193;
        bh=1dS6065vaGI42HWhmFUm99953OuxY0w84l5nJGVotOA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yzZdoBPdRT3N/1CgSPq+OHPLshLO7pAZzYfI4sZGSw6XwGNIS2dj+DZSHHGhablc1
         ZJyVcGrsGy0vZaef/v6jCEMDUbDeHLe4gWNu2TZV1kJwid67sCIqtjSiTeZjR7oszJ
         cARK2kg3mYAFyzWLieHRPhdBX8yX6wGatDRIncs0bS7GRSW4Hra/sa6yCwMMm5C5pk
         8lztvB4g9SoaVq00l5nFlPSioqdBhXsfFrpxMgvpPYQOmPfHkrkMEc3yJsXGiotxUW
         M6PCtpgfdzdlNclGyn/+hkLK82D7fbRQhPoYdizNCraHnC/D/UdC/caAKEQ/s7Pm14
         yvtSU3OVoGXFjaXc62jTt7pYuBOYj4nBoFzo38s/jNQtraLQL6QKfiwhujXsFXsRZU
         rU+S0Lp3AZHYqHQHo1UBpHqTiBYTkrbsfh8Cj94TaYem9V45GFBn1GuUTAdudbPFuW
         azsiHGAr/7NwQIlCB/yq7hap8LhfhI6njxkjgEur7X69aGaIRV/
Date:   Tue, 13 Feb 2018 00:36:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonas Thiem <jonas@thiem.email>
Cc:     git@vger.kernel.org
Subject: Re: Question about rebasing - unexpected result, can't figure out why
Message-ID: <20180213003624.GC1022467@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonas Thiem <jonas@thiem.email>, git@vger.kernel.org
References: <44e87a5a-b2be-f3f5-ac98-6831e056152d@thiem.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <44e87a5a-b2be-f3f5-ac98-6831e056152d@thiem.email>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2018 at 09:47:57PM +0100, Jonas Thiem wrote:
> =3D=3D Why did I expect that =3D=3D
>=20
> Of course after the client rebase, C3.txt should be gone (since it's
> gone at the original last commit of the client branch).
>=20
> But since it still exists in the server branch at the final commit,
> after rebasing & reapplying that onto the master, shouldn't it be put
> back in? Also, I would expect C3 -> C4 -> C10 as the complete chain of
> commits of the remaining server branch to be attached at the end, not
> just C4 -> C10...
>=20
> Does git somehow detect C3 would be applied twice? Doesn't the commit
> hash of C3 change after it is rebased? So how exactly would it figure
> that out? I'm really unsure about what is going on.

Yes.  The git rebase documentation says, "Note that any commits in HEAD
which introduce the same textual changes as a commit in HEAD..<upstream>
are omitted (i.e., a patch already accepted upstream with a different
commit message or timestamp will be skipped)."

If you want to be very explicit about replaying these commits, you can
say "git rebase --onto master $(git merge-base master HEAD)", in which
case C3 will be replayed.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqCMwgACgkQv1NdgR9S
9ovkpQ//VqeNbMKRmC7d7kn6kEmFKpfctMkq4aS23lyl9FjqpiknwM4hPelexziz
zHUTayDFxK/8ck9RuTe4prfYSUprHZ+q+s9H1MvUz44zlTPaMLFiCJfbONgCP4B3
O346K2KLZpbeYyepOUPD3N7YiP0b8+ciTMc2K60arvPDLiMJJMDuUYp8479+/DXX
bYoczqle5AXjaaRtpFq9IVjjFd+/+SpiruSwQgnZ2zx82T47ipH4yak8zrvJvCWg
4E6RIAF0grdqy07aJrEXsF6aCRiEaFm5fZZWD/bH85UmY37JuMkA9RxTxitqDoHv
7uKDRcmdIS6q91bOrnH/vl5jOVupv60hn1Ih52q29UkFMH5DSFHosbFaSgJtE7Ku
YT/O1W7D7OoHT5Odr1gt4fQ6SucU2eGihpuV3gLNNu6MmqD57INP+Q6XZJyNsiQW
j2RKPLl7q7yc9foyRxnCtdMyh6jCReF2/IWC7dukXOfbm3cSCJgVsUjB5/MGngOA
m/ezp/DHmnVWOpws0d17UtXytfg1+Nw5z0cEI6Z3rOGfGyVZeJlHjDTRnfrus3Pr
nd7I6u+gZpwaJdY5k5/Sa+fhJ6EEA9UOU3t/Q7HtqKjvC3Kbp0bpvUpgZYli13hk
QCB9MfzOHFPPCOOZRvzdck+EHPh419lkWXu27Us6weRfBEK73Fg=
=FMLG
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
