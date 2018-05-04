Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9B2200B9
	for <e@80x24.org>; Fri,  4 May 2018 01:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeEDB3y (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 21:29:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39220 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751269AbeEDB3y (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 May 2018 21:29:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 98A4960400;
        Fri,  4 May 2018 01:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525397390;
        bh=cwFRltMid1LD6zHQOr73O3zrS6+zX2W5I1gm5dB+Eh4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nJxHtun6akLWDDrChnawJaNYQ+3NmNIfm5PrFSn0CVmObJ6eGZHEbWXpKpoFHRITN
         yLpsS57ZbIB1emxxTXZfnnAoCbTTyhU0DGgGAqAIlez1YhPzySq+nVKg4bHLdUGbGV
         eKuBf/O9BlHZLGft9aCMqu/H/jMnYufDzSGT+AIf513BDnTX8gDDBSp5OXc13B/sVH
         IKRSc23otWMCHr/7iafy88+T6nOFwQkuXewM8foWTQ1y2lkZsjhTGEUjTE7WulJamO
         jprvYNViJV8/C31enUTHN1cf56loKJHu9C90XbGm6jXS+UgZjJkIKk4yL6Sa0sFLbn
         oaFL5bIbS/Kgxv6VumBC4JvIfyg70qxxtQBsIvU1eKKtyicjMWD2L3EUrdpV8hlv/a
         fpiQ1koQpoTJi8z9I9uKWrUYpWe0FB22pI4Fii0/6b7geLAwkTvz5TDnANGbDtW4FH
         jb1TXG1d38VQnDhxdlR4KlAfD/ZOsbb3d0RCS8ti/Zi77GbVkiR
Date:   Fri, 4 May 2018 01:29:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 39/41] Update shell scripts to compute empty tree object
 ID
Message-ID: <20180504012943.GO13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-40-sandals@crustytoothpaste.net>
 <20180501104257.GG15820@duynguyen.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/YnR2r17TIEndSCI"
Content-Disposition: inline
In-Reply-To: <20180501104257.GG15820@duynguyen.home>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/YnR2r17TIEndSCI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 12:42:57PM +0200, Duy Nguyen wrote:
> On Mon, Apr 23, 2018 at 11:39:49PM +0000, brian m. carlson wrote:
> > Several of our shell scripts hard-code the object ID of the empty tree.
> > To avoid any problems when changing hashes, compute this value on
> > startup of the script.  For performance, store the value in a variable
> > and reuse it throughout the life of the script.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  git-filter-branch.sh               | 4 +++-
> >  git-rebase--interactive.sh         | 4 +++-
> >  templates/hooks--pre-commit.sample | 2 +-
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 64f21547c1..ccceaf19a7 100755
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -11,6 +11,8 @@
> >  # The following functions will also be available in the commit filter:
> > =20
> >  functions=3D$(cat << \EOF
> > +EMPTY_TREE=3D$(git hash-object -t tree /dev/null)
>=20
> All scripts (except those example hooks) must source
> git-sh-setup. Should we define this in there instead?

I think at this point, I'm okay with special-casing these two uses, but
I would generally say that if we gain any more we should move it there.

There's a trade-off between the benefits of reuse here and the fact that
we're forking a process, which incurs a cost, especially on Windows.

I'm open to hearing other opinions, of course.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/YnR2r17TIEndSCI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrrt4cACgkQv1NdgR9S
9otgFg/+OJ2b4mL77hg7JglZLDmz9jWTuGGZTxvzp0dkRwvYQVytH6PDnA/OCSEW
TlD1qvwaf5JNenCFXcj5Mimmr2LXZSck8+4Pq7GYbUfkUbfqHilODcjyUiJLkNFA
cLszr0+mYfHTAPEhKEgodVBD/13WPt6ONdZp10XylT0k9apQeG7doxdv7U5ia+jA
scBJD9Rj9S0QKImfOzapBILejepv95KmDVPTslJSBuK1bC6+m6bRKrGSvZUTcjuu
7oA5XQnZP6NudddF1NTg077kDfM4wE1rN7+Lewr5aiWOwChXpPuqM+QVGrrkpT00
93Ps63e8ex/m3xH9f/vhfDU+sFCLeLwqqJX2egGWLpdB4clD2cFzbujOHxJCocAd
irEnGPFRpTxde57As87dp3mN6DvHExHoviKlpMyok8hq0raJ46/tjuWDg+nyZd7y
2j/rMZEuTI2vcRW37hcpbDT2KQzp/86goJCXi80JOvpDm1AToGX8k/FkZaRtU1jm
mH1ieQsURKQ96hGJec23gtxGrodCjmt3f8uB8VJZ4UyhDXbsTm3qQQvLM4VdG6VP
M3AhNqOLxqTpzAZsgQMtgsVwJ+gwOM1FAgF381OTidh/RnZN+F/RoAQPmEggCFY0
SYi3YDoppT+1Xpv9mTrGf+cqeE3waNVcCHzIi5ebTX+hlqyR5b0=
=sQpu
-----END PGP SIGNATURE-----

--/YnR2r17TIEndSCI--
