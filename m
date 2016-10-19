Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A1B20986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761107AbcJSU3E (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:29:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:54414 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750800AbcJSU3D (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Oct 2016 16:29:03 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 10037280AD;
        Wed, 19 Oct 2016 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1476908942;
        bh=CpNbaqUnnAzHwBtNtwSxhwLC7pGwlJa7B4jIBTCftCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UttVLJ6fwj4fyxyhKppapKUMOAmBO3lxTRJ+6x8EBiE9DVX+65GMrrRA5Ps6Q7Axi
         4VHUw6V3NFOCmIzu91WcUxIjAjgvhUuORRtEjkSJ/gO9rR/YyxNsYesdsThG8V0WO7
         GiNUUdrvt9ofaA5LecnWrrnbYEgXTTt1WC4E16onz/PkUOfmdPUUIVoSozDesdsTAd
         IkH0crjpqmyAeTloL0scLbgazgtHmzQSoILCx12YVgHZUHz6W64x47tE00cN7UgPFh
         WjdPTTRgX1sLPR6AXCndiPfTH3KxiLh8xgDahZm4CLRY8ySQHgePpJxpkPweSIhJQO
         xyyjg1t9LEuedCEXNenwUq/u4QfKABnWQenNr6/OkO+OxZyLUN2EzxZ+bN74FH+uKP
         Dy37BKfE2h++ymS/4UfUdStLb9bkRw4gY+0U4SDzcmYr8lXccPVIZv/PUIqX5BRINf
         sb00McnSMCTcbvZwVviSNHAmGVVgxxZIkLKBes23yMikCye0xkc
Date:   Wed, 19 Oct 2016 20:28:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #04; Mon, 17)
Message-ID: <20161019202856.7ld3kpsnjwu6dbwl@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <xmqqtwcasj8y.fsf@gitster.mtv.corp.google.com>
 <9F780406-FC77-4B3E-AEEB-7F6215E6702C@gmail.com>
 <xmqq4m49pffk.fsf@gitster.mtv.corp.google.com>
 <20161019074648.nuk2c2mpvmedjrhb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tlq6u6rm2krye4as"
Content-Disposition: inline
In-Reply-To: <20161019074648.nuk2c2mpvmedjrhb@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tlq6u6rm2krye4as
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2016 at 03:46:48AM -0400, Jeff King wrote:
> FWIW, I gave it a fairly thorough read-over (something I'd been meaning
> to do for quite a while, but kept never quite getting around to). I
> think overall it is OK for next. I did find one or two nits, but I think
> they are things we can fix up in-tree if and when they become a problem
> (e.g., I noticed that test-genrandom gets piped to "perl -pe". I'm not
> sure if perl will complain about funny multibyte characters on some
> systems. I suggest we ignore it until somebody demonstrates that it
> actually matters).

I just looked, and that use is fine.  perl -pe is always going to treat
its data as bytes unless you use -C or explicitly enable Unicode
functionality.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--tlq6u6rm2krye4as
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIcBAABCgAGBQJYB9eHAAoJEL9TXYEfUvaL7RgQAJ5b6n2i911RXijFlkXQ1Az7
6SeON2EGR3OOS+xzk6lQB61fxMyyCU9M1F/NgaMjgIqs58GcV/84rg5Cx1TYrWg/
vx+rgC10PsC1Ul5q3f+zOsQozujwNxAzhzBdejkrQxA7BZQGpvT3NaFYygTnv6XY
1eZ/tH+io7BXUQQrGf1zneBQ4CcExeFSfC25dUyMARbcuhMI9axweQo7QMsobq5X
09ee/uH8fyQIS5xAGvURtEcE1Y3DLwrVvWwasa6km3aT/BzRZuuJy+6yuYkN+zPd
hoXQ10odui0Y9kDdCDt5eJ+FJxhXh6YoSOp1Y1h8fO/YKlPfRwuF+9x/r0Z9mICh
noJuthZPaAbLx6+VGe+s26/PrKwRHOwrp58AoIBO4PgIhCY+uid/8N/qK9ui0dTP
TeMRAIwxna/EFVD9rNtL3qm2DjELNC2tTe2/e/1WyZOKirt+TxAi7fmE2l6ak7++
UWc3mMerMS/lx0+IUKt70bfL9PClhK+e/ZRpObypCDcpQJSTKBtxPXLQYONGAuPq
G1qGWR7zeM7LGhNfpuirFpjojm5wNXFaonFeQNZwCNN9kVeJHEsxmZMQjCbOMzTm
uecizWDb+tWiG/mN5T5CfEh64OBDxNx0E2p+shr8gL9vlWpJfu1HONuq5Zqy/qbu
Q7Pzts0nzkiuU7FdFJ7Y
=tPnX
-----END PGP SIGNATURE-----

--tlq6u6rm2krye4as--
