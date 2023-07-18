Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A7EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 21:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGRV7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 17:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGRV7d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 17:59:33 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F26198D
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 14:59:32 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B1D345B01D;
        Tue, 18 Jul 2023 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1689717571;
        bh=64RzAE9JbOxvBbv4U0kYV/71km3R7xFAIjrxqSO7NSI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ks9xRoMVxRcWyIFhvuIOEsKf4d7X/QUbMCYRiPjMJsVrADpbi5U0Y7ihDAznD/8AO
         LbeA2oHSkiBW03RtUCPaxNVlfdOGrAPqNHQkUuQe2zK5IgORks6oUjc93FmOL/m0hw
         WSM+z+NnuWX8lOGU/NldxuZ0EwYnVbD/oAm5BRqW3Zd07SY6FvEeDZZaVlf4NcQr6O
         MNodQaVqqIxyUoprODy+Z2rDOrfbfc8zHFeWlyZ8149E7cyznMyHjGlVMOpvi3PjtT
         L2xE/UUVyXga39/MFCaosr2VpJjQzMYtXcdsVQQC2FHPkv11BH3S1MDKDCn2vKeuQn
         zRxJeIFx1QglyUajvaKVA1tiFv8iVig+Q8xkMZSYfijr6u/H8c4AKdWq8aB4pKtTZK
         2BG5IcGKr0EAaDdyhEPT5VUzJlpuHiAbdMWuwWR8kWu2JK8SD6GMHRn1bPsQjHtAIG
         WAMdtnhBkmEq+UG0eTCBqtWuh5HZqI/UygM+ocSdzH2eDTcsR8o
Date:   Tue, 18 Jul 2023 21:59:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     nick <nick@nicholasjohnson.ch>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Git Privacy
Message-ID: <ZLcLQZfZK+QnG5cx@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        nick <nick@nicholasjohnson.ch>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g>
 <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g>
 <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
 <CU3Z2NYP6BGG.1PQ6S5AF60XX6@anonymous>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6FxY9iBmy9jWoirj"
Content-Disposition: inline
In-Reply-To: <CU3Z2NYP6BGG.1PQ6S5AF60XX6@anonymous>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6FxY9iBmy9jWoirj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-16 at 23:07:06, nick wrote:
> nick wrote:
> > The time zones reveal private information about developers and they
> > don't even serve a use case, as far as I'm aware. A backwards-compatible
> > way to solve this leak would be to convert timestamps to UTC by default
> > and have a Git config option to revert back to the current behavior.
>=20
> Come to think of it, even if timezones were converted to UTC by default,
> time of day would still leak information about a user's likely timezone.

This is true.  My .signature indicates where I'm located (which isn't a
secret), but I have `TZ=3DUTC` set in my shell config.  You'll notice that
my timestamp is +0000 in all my commits.  I keep a reasonably regular
daytime schedule, so it's easy to tell what my hours are.

> So based on that and keeping in mind Git's desire for strong
> backwards-compatibility, I'm amending my proposal to just a standalone
> Git option which would allow for forging timestamp and timezone
> information, with timestamp information being forgeable to varying
> degrees of granularity.

One thing I've wanted Git to do (which I'm not sure is backwards
compatible) is to set the timezone to -0000 (instead of +0000) to
indicate that the user has intentionally refused to set the timezone,
much like the equivalent syntax in RFC 5322.  I think that's a fine
choice for lots of reasons, but it prevents people from accidentally
concluding that I live in Reykjav=C3=ADk and expecting a response from me
when I'm actually in bed.

I'd support a command-line and config option that did that, in addition
to an option that adjusted the timezone.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--6FxY9iBmy9jWoirj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZLcLQQAKCRB8DEliiIei
gb6OAQCNPiqx21lTmvRl+kJLPFk4rNm6BiPsERb8SSItHAWkswD/fT4EgEdnnyeb
4/rUMT2vGQ5i4QtpCp8Q1XRfWeVAlAk=
=zN5d
-----END PGP SIGNATURE-----

--6FxY9iBmy9jWoirj--
