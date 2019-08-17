Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1611F45A
	for <e@80x24.org>; Sat, 17 Aug 2019 01:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfHQBwC (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 21:52:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57664 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbfHQBwC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Aug 2019 21:52:02 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9941560734;
        Sat, 17 Aug 2019 01:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566006720;
        bh=Ro4g+xcB3esrwjR/IylQWzR5O9BjEUyK2GcMZvSRyuQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0Gue3XUCJmkYFZ9XQR4RavOuoAmx+Ar0UKdS1stB4z0mcPl2lGxeAgJJT6pApIO8Y
         KFJ6iXhyaMsadh2RXNXPzOrADFAB0qfaFCnK2+h9vuWOQe2WQShuLGlWBocK9+mJQ4
         FdZLe9vSuBXdtVlbRhIU4SF1WH+kc775SCLpSMRQZbQsLb8huh0vzoTUG+mLhXJxCz
         LTe3D/sPNrZeDM3p/zMNf13pVQOlPxdYcyflGmgG0Q9W4nD4SVL/FRCElhDA0jCOxC
         /iBBcwPx+37joWr40Ovu8vTomY7R/JI5+b+Q9H/tURQEbjcJZZdQjwIf21dnjgXj+j
         bpfaowNJUzLYGUei+nejRjBz+erY7OhnbU5oWsE3TVqx/REnGWwqHAmifY3Cn70U2c
         UP7wjSgRSF8y4PCXOU8HNt4RmYhfIw5Dt0duDuyAX6axh46m3h/xOSqzH+yfSDRBxs
         V/l2wtHMOO4awIQtXaPchiHhWG5Ej+ag7cDo3zmXPBLegdieXCB
Date:   Sat, 17 Aug 2019 01:51:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFE] Teach hash-object to be able to choose signature types
Message-ID: <20190817015123.GD365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <009c01d55481$13d3ce20$3b7b6a60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <009c01d55481$13d3ce20$3b7b6a60$@nexbridge.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-16 at 22:22:17, Randall S. Becker wrote:
> Hi All,
>=20
> I do not know whether this would be a good enhancement or micro project f=
or
> someone (maybe me) to take on, but I'm wondering whether it might be a go=
od
> idea to provide an option to hash-object to select the signature being
> computed. The use case begins when someone computes an object signature a=
nd
> stores a pre-converted SHA1 value. Then the repository is changed over to
> SHA256. When hash-object is next called, perhaps in a different clone or
> some other "next" scenario, the new signature will be SHA256, if I
> understand this correctly, and from the perspective of the someone in the
> use case, the signature mismatches.
>=20
> What I am proposing is an option like --signature-type=3DSHA1|SHA256 or
> similar as an option to hash-object to allow the non-default signature to=
 be
> selected explicitly. This is not entirely trivial looking through the code
> and presumably would require either teaching hash_object_file_literally or
> having a separate method to do the alternate calculation.

I'm actually working on this right now, and you're right, it isn't
trivial. I'm definitely not opposed if someone else is interested in
picking it up or writing it; I don't believe my outstanding patches
(which will likely show up on the list this weekend now that 2.23 is
out) would affect it in any way.

I'll try to push up the work that I'm doing into my "transition-interop"
branch; it contains the work for literal hashing and a more significant
refactor, which folks are free to ignore.

The problem is somewhat ameliorated by the fact that for most projects,
there will be a mapping between SHA-1 and SHA-256, so it'll be possible
to look up between the two, but it can still be confusing if the "wrong"
one appears in commit messages, say.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1XXZsACgkQv1NdgR9S
9ovU2xAAlpPfUKQJdGltgBzMPNLndKDG1mIzbjKF8beH8XHwcr3Y8SiLsxozIHOE
XI3IHwg/SrHGmXII+VIdSYCtMHYvXjRMZ76w4BnLNKo0sjJZHBi6x/Tv5qaz4tKC
yv+67uq7Dpj+RGxo/R8qPqUcJ/lbdXrKzK6vq/4BQGn8iD5JJvsQtDjzaWmidijQ
I5Mbx4kai6VN2OIhJAGfV/ujylF3ieX+ePHGp+aXMZ4XczE4wNBrYXdBHinQ8m2J
R7RLOvsGVfdHJcSKuLdL1Z3aFgVSwyUhcVL9rmEnE00APdQtuNYfUE9YlKg1LVk9
OSOeAwwq/TLFqWTjtkmzPvi1manroSqvudfiPfXFtkBjwu9WSppXbQTVhL0fIxis
W2AIseV2OnZ359TwE2KLeXD8HMJzK0oKKfbXxDX5R63n23+yGpbluCfvAVbswVWj
PzFfqKboRLZvUOxuqQpgx7hGphCGRzFwVlkKUMcxeS4cejY3a2K+fjG2Ow+Q39xP
YGf2TmJYCex57PNpNiiJXLGtlv6y4a6CShgJq+l36dOTqIVJr1P5/iClVDCoXb2V
M75mY6T5PKhBu0rU17Q1zoHW9PwtuDKpZ4rTUL2ZWXYiJf0xQxyUs3x0rlXak5UL
2a8SIgaFOYyA/wdybLp5kyngg2w5YYQPfxPKu0U594TQOFGA6cY=
=Q4fj
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
