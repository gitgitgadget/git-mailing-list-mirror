Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F931F454
	for <e@80x24.org>; Mon, 11 Nov 2019 19:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKKSal (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 13:30:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:37233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfKKSak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 13:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573497027;
        bh=b3zSBeX5Z4iR3akfeBk71vzUcYd1rzf4dEMvGaarWMc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T9rtO8Vl8gSl7OBalOXm4FyWp++eoBdy/r9hlBKrmjV1NXXXC+ygTiSYyeJd8VCqh
         5hras+3vjq6JKGx2fX/vB7nU49xmin/Si0jCHbmkEVZo3KCID6/XQmb3Xkm50KlKr0
         MFVfOTdXAN6xEobgTlKKtC84jOQwTaddKFYP+sns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1hduz23a1C-00rWnx; Mon, 11
 Nov 2019 19:30:27 +0100
Date:   Mon, 11 Nov 2019 19:30:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] hex: drop sha1_to_hex_r()
In-Reply-To: <20191111090411.GA12545@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911111929550.46@tvgsbejvaqbjf.bet>
References: <20191111090332.GA2275@sigill.intra.peff.net> <20191111090411.GA12545@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W5xf5YWkbYkRJyfEHlF+krqGy6NFLtxqb2cKt3pSZJ3LIzVqIdB
 w7HepO15TWsv/5m6iDwAT3PMWN7YMrurOi61YFwdy0OuTTxMmVfCPOva/sYVr0bLTioh7XC
 UmKClLfPI5SWdlfDGOQEQhTMDgDuuRQxO7BxEzTewbeeaV5mUFOtLMRBJrOgdAUdxQI2Fo2
 MyVTpLj0yOO3On38WbB6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:geWl4Djcmks=:Y5bBVW1Uc+xBLb51Grpknj
 yR+CoCta9oDWzPhg6/sEd6y0dyjCXfkpDj3+Vq/skU83vZDF9o/hUOpgtd4dya27s3/3tkA1R
 9Ev4L/Lwd3fnG9mMiZ6lO5NF4sTZwoy25HJXxOlFE/PzczZVXrRE5bRu94J6FFUoYVZrD0K2w
 6rshcC5XKbZW2OVMFmqzLmgcfPAE2J0E3Ax3nh6UCxueSbBpJO/63X2enExfkPFyl3ESlhDZF
 IcGIQENCXCVAkgkSVxMQuLZP2gxIG/NB7ZFvx4sBsGxnm89r1JiS7a7N4Gz8u3Muo2dZU6oxf
 oY9HQMDHtpA4GYgQAzQHBTTVzezGwe/xY/1YYNkuXJ4cUMb65JLDTcOGO3Otmh1rFaW/zmKI3
 cq920NAu9INNqCLW0yamNqyPZJ/2rvQwr0rzZ96oqp7a7oZxfHRYo01xUcSGtGusIkxr6G0bC
 ct4O3fPZoeWbztScqW4P5eF5G1piq4XiXDON8+O8NDO8SFQpbcnCQyme51Xy2SnHcMsVU4dMy
 7n8x7JCLctGrG2DlP9bE8y9VOvNIZSFM/Qe0iVHN1Lk9JOe03HQz9B9dVQAkvnCLhKkDutYmP
 OnoT/CmCKAdtZXY2e+1l7Fd26L5RTNa0Hf30NEQJGj9sOhVTBmdLGMbZCxpWtFBJIvUZUJJMO
 r+Yojz77QmARA8oBhnZvGeiracsqU1veNWkYuSkKelLq0Z1kM1f4hjJcDc79PwJOs9ITp5f3C
 VDzOImu63Kbia/didrLYl1snFxJCkcdIEnSzVDaFwEuxh3NZrt8+QcbXtQgIAGKPyvoer5S6X
 M8seJCNY+W00dDp4iJESGXxwzs11ioUzQiqBhhnsMSi6J/xvAx/bTRBwDL7N17gU53R4IEW2I
 rmjkqH9HfM3r7Xdc5x9iz/Gjw8gkqc9ilNZnfpV6+xciQypHxesjSXDtT+Ol4fMApImaJyz6R
 5hb4KR7G1FynSwADMjhNqYHYvRvpe9dQW8g0ns65trcjKYCcg9zI6iBETd5be0ITUbg8/Ib6R
 Y08xXRJ3DV9Fmpdf/tSYHQhXgv88x7aRRBRrqnvCN8UOjni918TDurYfpRvfmOTdu25J9brHh
 ryDxCDXdH4JltCHFVHtaDpYKkFSFpbr0QVPGnsbXCPDD6ErEskOpPD8OAMaZ0OajfE1Ct9Rio
 PhFQXlkTIDexPKLzzplKPrf2JKhpAK18ibr8YWxiUwE+hCYlAfTYbvYK1jKNDSu6efyXrd7Gl
 Eyje05Zb6EdvTIZcbiYeEDd+uGcUK6LnVUlDR8QZHKOvNZtDL1qNpCHhEU0o=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 11 Nov 2019, Jeff King wrote:

> There are no callers left; everybody uses oid_to_hex_r() or
> hash_to_hex_algop_r(). This used to actually be the underlying
> implementation for oid_to_hex_r(), but that's no longer the case since
> 47edb64997 (hex: introduce functions to print arbitrary hashes,
> 2018-11-14).
>
> Let's get rid of it to de-clutter and to make sure nobody uses it.
> Likewise we can drop the coccinelle rules that mention it, since the
> compiler will make it quite clear that the code does not work.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  cache.h                            |  1 -
>  contrib/coccinelle/object_id.cocci | 17 -----------------
>  hex.c                              |  5 -----
>  3 files changed, 23 deletions(-)

I really like that diffstat.

Thanks,
Dscho

>
> diff --git a/cache.h b/cache.h
> index 04cabaac11..6a4eb221b3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1462,7 +1462,6 @@ int hex_to_bytes(unsigned char *binary, const char=
 *hex, size_t len);
>   *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
>   */
>  char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, cons=
t struct git_hash_algo *);
> -char *sha1_to_hex_r(char *out, const unsigned char *sha1);
>  char *oid_to_hex_r(char *out, const struct object_id *oid);
>  char *hash_to_hex_algop(const unsigned char *hash, const struct git_has=
h_algo *);	/* static buffer result! */
>  char *sha1_to_hex(const unsigned char *sha1);						/* same static buffe=
r */
> diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/obj=
ect_id.cocci
> index 3e536a9834..6c0d21d8e2 100644
> --- a/contrib/coccinelle/object_id.cocci
> +++ b/contrib/coccinelle/object_id.cocci
> @@ -25,23 +25,6 @@ struct object_id *OIDPTR;
>  + oid_to_hex(OIDPTR)
>    ...>}
>
> -@@
> -expression E;
> -struct object_id OID;
> -@@
> -- sha1_to_hex_r(E, OID.hash)
> -+ oid_to_hex_r(E, &OID)
> -
> -@@
> -identifier f !=3D oid_to_hex_r;
> -expression E;
> -struct object_id *OIDPTR;
> -@@
> -   f(...) {<...
> -- sha1_to_hex_r(E, OIDPTR->hash)
> -+ oid_to_hex_r(E, OIDPTR)
> -  ...>}
> -
>  @@
>  struct object_id OID;
>  @@
> diff --git a/hex.c b/hex.c
> index 7850a8879d..8c3f06a192 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -90,11 +90,6 @@ char *hash_to_hex_algop_r(char *buffer, const unsigne=
d char *hash,
>  	return buffer;
>  }
>
> -char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
> -{
> -	return hash_to_hex_algop_r(buffer, sha1, &hash_algos[GIT_HASH_SHA1]);
> -}
> -
>  char *oid_to_hex_r(char *buffer, const struct object_id *oid)
>  {
>  	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
> --
> 2.24.0.739.gb5632e4929
>
>
