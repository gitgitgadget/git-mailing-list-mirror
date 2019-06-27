Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A531F461
	for <e@80x24.org>; Thu, 27 Jun 2019 01:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfF0BTR (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 21:19:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56246 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbfF0BTQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jun 2019 21:19:16 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF09460428;
        Thu, 27 Jun 2019 01:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561598355;
        bh=71n+z2ZjdrZfdU5cpx7M1x5Vagb47mNJ4qYK023ov7I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qiBOgqkhmZbtJCybWrKF8OvBSPwM5KoZW5nOq3dinhA5hhMaAPku2aZpCPLX4GUpl
         LDcbAa2862Xj7U5UJzT5Bs8cCChE95QvlTuyGU6BE26m3FNwXlbi8v/IEI8pXCbyc2
         s570wmqM49BLN8qLhWUNf2Rk7fOxrucj30tGRkgGp/U7oDeQd0CQx4p38Vp8t/LWbB
         MWZ8to3IRykL2WS2IO9GmM4mRaVVzGK8hArXTgCo8bm05hAmsthY3D90mo9607F3B8
         8UedSkwLNu2u/tIPNVhrGLMqjIENa0feoX/XuW1c1f3Q4mFiM8GnpEm/LABNKuvsde
         2sweSMH7MMblWZFsP8LCScA/FQSTKz+6PGIGji+58/FS2KW4rRsJ0cWmcxs3yZBmEM
         frrc08CrDHiJdeBbQZGZrcTBBXIyiY7Efzxg9jahzgKN1+L/EogrDteSEAOyxkpHc7
         Bg9FUqxSMxRQBVwKAoiiWbh/3qeGjzJzWgJVdXK2dCIXsSoKqQb
Date:   Thu, 27 Jun 2019 01:19:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Multiple urls for remotes?
Message-ID: <20190627011909.GA9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike Hommey <mh@glandium.org>, git@vger.kernel.org
References: <20190626235247.nhw45da52rz46mad@glandium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20190626235247.nhw45da52rz46mad@glandium.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-26 at 23:52:47, Mike Hommey wrote:
> Hi,
>=20
> I was surprised to figure out that urls/pushurls set up for remotes can
> be set multiple times, and that those urls end up being used
> sequentially.

Yes, this is actually a feature. It's useful when you want to push to
multiple remotes at once. For instance, I want to push my Git changes to
both my server and to GitHub, and I can do so simply with "git push def
HEAD".

> Sadly, this has the side effect that one cannot override the config from
> the command line, as the url is then added as an extra url, which is
> tried after the already configured one.
>=20
> e.g.
>     git -c remote.origin.url=3D/tmp/foo push origin
>=20
> will keep pushing to wherever the .git/config's remote.origin.url points
> to.
>
> With all the configuration items that work this way, it's actually kind
> of sad that it's not possible to force the value from the command line to
> override anything that is set in the configuration.

This is true for all config options that operate on multiple items, and
it's a known limitation. Some configuration options allow specifying an
empty value to reset the list, but this isn't one of them.

This also tends to bite people when they have set things like refspecs
for origin in their ~/.gitconfig, but then decide they don't want that
behavior on a repo basis.

There was some discussion of this issue in a subthread of my multiple
hooks series recently. In order to have a standard way to reset this,
we'd either need to have each configuration option learn how to reset
itself or we'd need to buffer configuration options until all of the
values are parsed and ignore things before the reset marker. We'd also
need a standard reset marker that can be used consistently. Nobody has
yet picked this up, but of course patches are welcome.

> It's worth noting that the documentation for -c says:
>=20
>     Pass a configuration parameter to the command. The value given will
>     override values from configuration files.
>=20
> ... which implies -c remote.origin.url=3D/tmp/foo should, in fact, replace
> any other value already set.

I agree this is a bug. It should probably say something like, "The
values given will act as though they were parsed after the repository
configuration," although we'd need to make it less confusing than that.

> The only thing that seems to be talking about this is the documentation
> for git-remote, which has --add for set-url. There doesn't seem to be any
> documentation about what conditions are required for the non-primary URL
> to be used.

For pushes, it's either always used or it's used if preceding URLs have
not failed, I can't remember which. Only the first URL is used for
fetches. I agree that better documentation here would be desirable as
well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0UGY0ACgkQv1NdgR9S
9os6xw/8Cnfl5ywNDPH+l75RJKpbzpkT4tATBsQ6DQvYrQy0VpObMgqDbp6fEBfu
S0l/zSNujbEm/EkXnaoRwJeXTx32rl+OdLZwqA0mtzIL10u1DIp9xuimHHtznzGX
eP/n67kBoMIBC37/n84l91Z3/AnJ+aqLa+UCZ7yPZekcO48RLLVi9CC83SHRrXCS
oPNCwkYSz6gMXQkE3qaW6NM7BlIK53Tl7H5syLuXFNv0hu8e77EJ+Y1JLB7J193b
NG0CTBcwHmDM6S0OwWLynhmkPumvEcYuL0/lYa5ACoznSw27qeiGDHWe5rDvSATm
gkmti5pdkCdTQ/N5hWa7Vh+p4qlOm8LLDxiUBUrnDN5vXbIeDpG6DfQsTNcK94on
AhAvdWFOPHSfGil1RoB3p07AJ+G0chJUvNM0ztdrebaEecKK2/1EFSuAo8JoDsUX
tNftXRAM2ySefOO85iAO+KWVaHKJsfjFeLyCowCPAhddCgW8uepuwsJ2/3etyIU6
abV1jmyi/BZF/Aj9uoLzrb+VopHgBx93XobSRbBb7Eb2JmFkwee5GM6lFi3LRYop
JnTbZWQ2KetIouZmHnPXM5RVaKn7TflZgzTGejq5bIfhSiaREclYvmYjHR5dppLg
d7HCzTsnDD8br45ZoZWK5jNo2mStZzc63w/Tg+B7YgIJbUQSM4M=
=kvS0
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
