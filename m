Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6EEC48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8936861356
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 01:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhFPB1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 21:27:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230376AbhFPB1Y (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Jun 2021 21:27:24 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D211760749;
        Wed, 16 Jun 2021 01:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623806718;
        bh=9pA/QC2PE/yQ5YvkOkIPq+A2MICxNKo8nz4MKgcz5N8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kwpim0RoXBGu6o77gsEFcdja99P9uN28oraZvzEf/FjUT4snZ7xfPeE1JOgEp1y2v
         4ev5gC2omnSMk0xFndtuU8oEOjpwK9ERSEvsZhpH8axFW6LIWe5sKjXHpoijP2cJIO
         YdWsoQ6f+LazudEZ0vjHkGKfO3sr/n7v10z7YTtz/mAMagIdaE1k2RQsl7hM5GvJgT
         f0tSzmGsHlB6LKofg0dk8awkZ3IOhZawQa1Nz9FvWEvBlhhCKMEKhiwOgLLmDHPTQP
         Y9Bc/yKYy7Espn+tvU9KH8yDLcBg8neceWY+obHs+VRuLEeSHeNQlIUF47VkT94Q7Y
         sGoTLiqrpAJ0FQ7R+hL34W3jnF3GnHJt8SdvUXxtCPtn8TFrckdw2Zb3ANsHbErO6x
         4OKWME1UPuV58ZYESslmEUoHL8LHnBsl2vKi60YdVTGN101/A5jdETLdH5zuExP3m7
         +bsiI3oxu47Qcb4VfTLe+Xv9UN43rT4CnWognX8Vdmp5Zc+6l3G
Date:   Wed, 16 Jun 2021 01:25:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Rose Kunkel <rose@rosekunkel.me>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
Message-ID: <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
 <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net>
 <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
 <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sb/IqILZIpqwueM0"
Content-Disposition: inline
In-Reply-To: <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Sb/IqILZIpqwueM0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-16 at 01:03:40, Rose Kunkel wrote:
> Potentially relevant: `git config --global --list` shows
> ```
> status.showstash=3Dtrue
> status.submodulesummary=3Dtrue
> submodule.recurse=3Dtrue

Thanks for this additional information.  This line is the critical
piece.  Now I get this:

  $ git reset --hard
  fatal: not a git repository: ../../.git/modules/repos/agda
  fatal: could not reset submodule index

Predictably, "git -c submodules.recurse=3Dtrue reset --hard" also results
in the same thing.

The --recurse-submodules option for git reset says this (emphasis mine):

  When the working tree is updated, using --recurse-submodules will also
  recursively reset the working tree of all *active* submodules
  according to the commit recorded in the superproject, also setting the
  submodules' HEAD to be detached at that commit.

On my system, .git/config has this:

  [submodule]
          active =3D .

So these submodules are active, but they probably should not be, since
we haven't checked anything out (or, for that matter, cloned any data)
and it wouldn't make sense to try to operate on them automatically with
submodules.recurse or --recurse-submodules.

My gut tells me that we should probably mark submodules with update=3Dnone
set on a clone as inactive.  Of course, this is a tricky area that I'm
not super familiar with, so opinions or thoughts are welcome.

If folks think this is a good way forward, I'll look into writing a
patch, probably tomorrow evening since it's starting to get late here.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Sb/IqILZIpqwueM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMlS+gAKCRB8DEliiIei
gXEkAP9ScTi73dELt5FCPD9BBnNsMyNtFRkGuBfXMa62P/JKHgEAvjio2qwoLd7Q
tWatHbuXXP3cEpTVVBXBtDjqo4KX1gc=
=AEKU
-----END PGP SIGNATURE-----

--Sb/IqILZIpqwueM0--
