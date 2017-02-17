Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0578201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934949AbdBQVpW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:45:22 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59624 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934415AbdBQVpV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 16:45:21 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D272A280AD;
        Fri, 17 Feb 2017 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487367918;
        bh=l9ocq2Vhu3vowIatBI3BPwfb4MqkQiylAJu5ywm/yVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ou+rl+6WdOQ4LWu/Jh+4yidYVIIVoGqRk1O5fgBfWRS6jNI1whrQ7JqC7qA+M/CVL
         8ZA/rGpgQeHxR5kE0B6AH2o05lUVEnBiS5MgzBixWIpczwOqKN0LRPbNn1SFUlB6IX
         48pCu/tSDSV0llDV2wOmrBeX/g2S5e9yPY87CBIl8bz2HIT91gagn4rWig+W78ucM0
         hnwXueEDCreeOgpcZZM6ftJsG5T2kLvEpeVI7P5QkBDrYPU4sf4WfBgBb6GIKS0JnC
         vV44CpbAae4sj2Rrea1mK37JIpxl2FU+S99NJk5gyPepDDh9tDvGvSDqMjUN80dFDJ
         z2TT34imfyaFUJ1ggePpsZuguRZbfRYjHuAKSmMu5oS3dGECIFaiLJI866E7FGIoBE
         OTFa9VZWC7wYJx3MQx5sWp+rD17+q1mQ/2Lh4O7pv24CywToPmv59QQNTmKXe08OlS
         vXnLAJDBebc1mJPGnc+egvJufeqhCa9eArww/TNz2kZV8jaEJd3
Date:   Fri, 17 Feb 2017 21:45:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/19] object_id part 6
Message-ID: <20170217214513.giua5ksuiqqs2laj@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
 <3644df30-71e2-584b-ebed-ae117a5ded3f@alum.mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="husj5qsxbjia2lm3"
Content-Disposition: inline
In-Reply-To: <3644df30-71e2-584b-ebed-ae117a5ded3f@alum.mit.edu>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--husj5qsxbjia2lm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 10:55:03AM +0100, Michael Haggerty wrote:
> On 02/14/2017 03:31 AM, brian m. carlson wrote:
> > This is another series in the continuing conversion to struct object_id.
> >=20
> > This series converts more of the builtin directory and some of the refs
> > code to use struct object_id. Additionally, it implements an
> > nth_packed_object_oid function which provides a struct object_id version
> > of the nth_packed_object function, and a parse_oid_hex function that
> > makes parsing easier.
> >=20
> > The patch to use parse_oid_hex in the refs code has been split out into
> > its own patch, just because I'm wary of that code and potentially
> > breaking things, and I want it to be easy to revert in case things go
> > wrong.  I have no reason to believe it is anything other than fully
> > functional, however.
> >=20
> > Changes from v1:
> > * Implement parse_oid_hex and use it.
> > * Make nth_packed_object_oid take a variable into which to store the
> >   object ID.  This avoids concerns about unsafe casts.
> > * Rebase on master.
>=20
> Thanks as always for working on this!
>=20
> I skimmed over the patches (looking more carefully at the refs-related
> ones) and left a few minor comments but didn't find anything serious.

I'll send out a new series shortly with those changes.

> I'm curious; what fraction of the overall convert-to-object_id campaign
> do you estimate is done so far? Are you getting close to the promised
> land yet?

So I think that the current scope left is best estimated by the
following command:

  git grep -P 'unsigned char\s+(\*|.*20)' | grep -v '^Documentation'

So there are approximately 1200 call sites left, which is quite a bit of
work.  I estimate between the work I've done and other people's
refactoring work (such as the refs backend refactor), we're about 40%
done.

I'm hoping to send out more smaller series in the future, since running
make test on a huge series takes a long time.

Part of the problem is that some places are almost completely
convertible, except for one or two components that rely on something
like sha1_array.  I have patches somewhere that convert that to
oid_array, but I'm not sure how well they'll be received at this point.
I think converting a lot of shallow-related code requires that
conversion, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--husj5qsxbjia2lm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlinbugACgkQv1NdgR9S
9ouFJBAAyJEZqtr5JDmRtPWhCcT7n/SpT1G/kLP+RgjuRBbcuWr1dZm+o8qekWEA
HxBNpBNkW9QIZHbS8egMUPfCAAJIvrODZTckAGJhe8kjldk4sNWaTP1lm7onPvoD
I4M+0kELRyW4C6w7AnjWBpNzChDSeJTAQ9UUos01v+GvgxvezH6eRKsTUz5juVSZ
x05qkYqNbO4KbR1xc/LjxYuVnsIIp7agq7hSZSZtBMlhvWwNsWjzD2CZHVjah/2E
/PAkR4OyGP+IyI/0S1mZhQVZFlpwnoB37aqF6vnnJ+W+ynXDmT0VKZwRrt38eneF
Iz3hxFlV+II8QICwqjduxk0kCsVcclmI1cQyplT5NSQwWmFNW1U6FCHyIehCHV8B
FqZPyen1BEaZ+6QLR/cWX12hnUMNWU5vC8YwLQiVcNyGYYMTMziONWHqbQzVJZYl
kZVOfAmBzjsN3vMhGgaKNK98VQ5UqruB0CZyn0nv8ccEvPlDtlg4GY6O9/SorHCn
s3gu69XWYE7eFOvsCGGG3utPt5/AUlt4e93FNgg7ARxz1wCSDjoSbY559m0kMwTR
6W1kp2jVvxWGI+9/StUrZXsK1TkZXl1uXKCS2EvAbZlA6C96ELQ2hUvsRuA8TP6d
uoRocvnmnQ5NYdYXGyh3wqj4qsIOnn1mwzDJeVzMlJCNzLmMk1E=
=Vzmc
-----END PGP SIGNATURE-----

--husj5qsxbjia2lm3--
