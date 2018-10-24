Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671101F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeJXLfr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:35:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51954 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbeJXLfr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Oct 2018 07:35:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D0B8D61B72;
        Wed, 24 Oct 2018 01:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540345856;
        bh=NvyeLVSCHjvIfjGN03PZsf3G04AEU5R5vOiHmXI89M0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vVZP1iUGlCn0kRi7gY8/Had40z2R8hQUvoxaztjdKKrDO3/fYxrKErCLXWbgh4qyR
         kn/hmDXALom0AEeEf7EP372Y3jtUPOcle19ydU0NkcIOi91fZNJSDQc/n8VdwPeTc3
         n/KK02KF5RclIOh1h1ijuaJMyyqNbBrw0q3i/lQeJIcwRaQPCn7BVffJQtphFJYrGc
         DiNP9hUv7iCr0wr+ucakZA+xoJt2fQBDgrS3hENiR/YMpZdjwaT+Q1xjkm8DO4LCuq
         +1CXBEfpwJ4GEBAP4Vux2r5VbKJeNfh+gIXEYoBXyaUlYeA41Vosud1tf7BFpOCsPU
         rJbfkW3Wlqtt9CvOuabntHsknJ9jwQiyLtRqnjaUGvNEh81/ppcRyFmC9lQvJ6WYqO
         61pE4B+8rWKJ9hxgbiWXRoBFUpiLAtWtToCI5Ybkb0LOpUNyJkh7rzTo3u1u3QQWE9
         Tw8z9e8j6V8dkrd8LoIw1YdEOiTyMigErAgv/8ETzTzEH5C1nGg
Date:   Wed, 24 Oct 2018 01:50:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ralf Jung <post@ralfj.de>
Cc:     git@vger.kernel.org
Subject: Re: Add config option to make "--keep-index" the default for "git
 stash push"
Message-ID: <20181024015050.GD6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ralf Jung <post@ralfj.de>, git@vger.kernel.org
References: <385edc3f-3749-0620-2275-40785b6fbe49@ralfj.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <385edc3f-3749-0620-2275-40785b6fbe49@ralfj.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2018 at 10:11:50AM +0200, Ralf Jung wrote:
> Hi all,
>=20
> I have been repeatedly bitten by the default behavior of `git stash` to s=
tash
> not just the unstaged but also the staged changes, and then `git stash po=
p`
> making all changes unstaged. This means `git stash && git stash pop`, per
> default, loses information, and when I just spent 10min carefully selecti=
ng
> hunks to be staged that's quite frustrating.
>=20
> I found that for myself, I usually expect `git stash` to only stash the c=
hanges
> that are not yet staged.  So I'd like to configure git such that `--keep-=
index`
> is the default.  That would also fix the information loss I mentioned abo=
ve.
> (By now I am also aware of `git stash pop --index`, but (a) that's not the
> default either and (b) its documentation indicates it might not always wo=
rk very
> well.)  However, going over the `git-config` man page, I have not found a=
ny way
> to change the default behavior.  Is that possible somehow?  And if not, c=
ould
> you consider this a feature request to add such an option?

First, let me say that I'm speaking for myself and not the whole list.
Other people may have other opinions, and some may want to see a patch
before deciding.

Personally, I am hesitant about such an option, since I know people use
stash in scripts and hooks (whether that's a good idea or not), and
ending up with an unclean tree after git stash would be surprising and
could potentially cause data loss.  (I have a co-worker who is doing
exactly this.)

We do have a --no-keep-index option, so there is an out for people who
don't want that behavior, and maybe that's enough to avoid problems.  I
usually deal with this situation by using an alias, which lets me have
more control over the exact behavior I want.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvPz/oACgkQv1NdgR9S
9osciw//X1ijpIrOvjk46t6oG8wjQ402DwmBmfgTWwXwiosq8w69DQd6wnQLqMKe
DM9wG1hx7svzc+RbMiyUEJSTQYZdlVNf51+6Osvai+Gc8S9o0coTG6H19XrCWHLv
fpOHzZKgGjPuTVFC8GGej1LAuoA2pWWwDk5lEFxtQt8zuxYZfKciysuddm6l9KOy
2VIB0OYNAJWQlzWpIg6qGWvG5TnNG7e1T3Mu2hnRYbXd5dxO2N5xlVbJo3SxCOFc
rUpurP/miCbX8RJzBaKZPaEZkaSJHNv2gltPqbp9x5eMXMA6z2scPgmlj8XQp8UZ
3lKc8lUfuUAI/2I/oa6UxjL4lkZNOsmhKa+l5rPpEkgx0VWbfHkFrHvxNg8ir1rz
XR03UeFDWEhP7rFK6DXEC4PCXZJH7aVyR1fzBXNBIcrKsoDsHieyQskpr4jpz0Ob
+gz863y3vS6oC9hWASJB0akPUHjPqLnJiH1pQSIree/PQvyN2RlmYbg6FMS0jcmM
zzvI5vtlQpJ/557d5ordWsoIHbOx829I0x8xLnmH3uF8nFdDVSFeeY9a+xtOpW8/
KVOf9GxSmAzowbbS5xuLeElroXfZlAhNH5dGvsp0TWCynoHzj1fwCXwBLXYH/ZCi
85Po/n2U5i4o1l5wmP8Ex5oR8eFX4f69e+4f9vNClOm03qQO+II=
=irpp
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
