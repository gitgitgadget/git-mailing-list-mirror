Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB6BC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B78F60D43
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 22:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhJLWe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 18:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLWe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 18:34:58 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Oct 2021 15:32:55 PDT
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6227C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1634077510; bh=yktHtORAScitrJAGkvgKaQs+WDPH0CqjQ7likXyIOUk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=wNT9CzVjxelIbI8hqEbltvr1Gn9jNV2i/4WATp/j+sIRbwX3n2TRue9/Zn1fhwZsF
         MNDu1pKMx+b1UkOyijtWR8/xlgijBH7yxskv183bMnGXLtsx8EAZLQKYhEEGNvm7JS
         h7Py7MXlXEGTo8aGR5jHV2FM3T1WOn7eL/I+w1ZIqPdGPY3iN8S6L9di4+plGW4tWc
         HdLxF6pbWV9AJ4ZpVGYAEFUEy5Jb7xtihEF+/oSKt4yq7y4SDq6IwsVPWyBxn0hu4J
         K+U8tVDhlvrvNUETnCkrzW7+vBaS8LCkANAN36pUSKZmBb4CTM6jfC3CE9Y/b/0+7e
         WsFQPBScMVyzA==
Received: by pug.qqx.org (Postfix, from userid 1000)
        id D21892D4A4; Tue, 12 Oct 2021 18:25:10 -0400 (EDT)
Date:   Tue, 12 Oct 2021 18:25:10 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Alex Waite <alex@waite.eu>, git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWYLRvUEkoudH5n0@pug.qqx.org>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Alex Waite <alex@waite.eu>, git@vger.kernel.org
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
 <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
 <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
 <YWYE2LZp/EfoBpN/@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ln5gntavmcqVUu7J"
Content-Disposition: inline
In-Reply-To: <YWYE2LZp/EfoBpN/@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ln5gntavmcqVUu7J
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

At 21:57 +0000 12 Oct 2021, "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>I also just checked, and RFC 5280 specifies the rules for RFC 1123
>regarding host names in certificates.  So even if we did accept this, no
>publicly trusted CA could issue a certificate for such a domain, because
>to do so would be misissuance.  So this at best could help people who
>are either using plain HTTP or an internal CA using broken tools,
>neither of which I think argue in favor of supporting this.

Or people using a wildcard certificate.

--Ln5gntavmcqVUu7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAABCgBMFiEE/uA+7ZsNcEQXIOCzxrrvXm21xyUFAmFmC0AuFIAAAAAAFQAQ
cGthLWFkZHJlc3NAZ251cGcub3JnYWFyb25Ac2NocmFiLmNvbQAKCRDGuu9ebbXH
JbNLEAChveE51QCddBogZFqSdDC/WtAatsIBzhjfBWfV3TlISAyQpCGRH+kKSAuX
J73TRWEetHqXWb8M4DuVk/uCxPSXQ1sw2jv4JxUeTvSZ/iImKmereAClJDSlzRAY
ppIgwZBSuP2TEGaQZpVmoqQ3Z+WF6JJSMsOGqoOjABoU07e9003WKiIOBNm0aByz
me4YZk4bFoX2MfllCuKoZaCJFAYR7MV/mjyDXYjkSadA3oiNbCruHBRCGFIWskBi
srY3MqHCgLkORp1zDdGBSbmw1euq5RFDAYgXCDuEAcTkfXIe2AVl2JQA4REzWYuG
2bKlobe1m7JTO0tJPVDrZ7Wvmc6mfXPz5Mv0oHapjCug3SBqq0yRFP1xJn7qyH+8
OEo4eJDZIUTw7GodzFhQJRS5b/xHQI7+2OtatjNVlt0DkfYhekX9iR1oEFatsTnO
hKW0fM9jeP2WhNQfiCA4R2E4WxKdrEaMl3EVV5Ku4z93pws6QYx0L2K+6VIaSTIn
3SVZ3OWoQ5jsxMMXK3YS7IQjANo9tnRGdBFBx6kwrw/JMiWM3mlbQa5Z3+7vCMkS
5K6NhTPRZj3QugbKtvMVS72ATMGXHshic+gfHODiwR3tTqWEPRiAcK2R9Ye9pBfu
GbuEQzB4V9Jjrn2xsbt1/FJTVk4zb/haQiAGGw9L+0/tUJKytw==
=QMt6
-----END PGP SIGNATURE-----

--Ln5gntavmcqVUu7J--
