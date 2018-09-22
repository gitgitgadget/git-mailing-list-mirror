Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B313F1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIVX5D (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:57:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37594 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbeIVX5D (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Sep 2018 19:57:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:68ab:e3d3:c0a3:4717])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E8B4260745;
        Sat, 22 Sep 2018 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1537639357;
        bh=oeFf+FEG5JpTFVCxJ6C4SqCT4zt/qg6O8HgbgeeqmYQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=UokJ757c7rHQB8SfWe6TEXL+Je/df3su28YEewxVexK0C0QfGpGpYHwY5uUBtQZu5
         8OFKG21P1gJFoHKdqvEMoY5GBZ0TvDbRdWAm8tjv6d03cFh/ln2ihm/B0DZU2dTe/A
         jX7IEM56Paa47pVl86PX7+MAWzUf3u3uWerSw5AVqJTUM60dnChs735G+Facg2o+pp
         hjhokGL/sccReXA1wox74aXb7mqQmJo4BlVpYAJcff5w5aHEQa3/+k06E4hTXWC6pq
         ws9hWevi4UnklEZVKmmncVgAw1gD3RM/fGdrjchFuY36XZ3ombLWA+1tTsmHM3XZrX
         u8gtPyYsafl0HRoxUahb+a1NmzYVZZ2kHaKmuoomx7zd7yC3vKY1PbSnJn3EJcTM5f
         CLN4UwzNrq8j4h0gdqRQU+s2fSf53kZiBsGMYvyZ33JTckCjhRUC6IjxOZ+AJMlJgr
         BJV5pJYq41ug+SwEYNuKws7C0aSId2xMn3ZZp2hVI9UB6cxZARX
Date:   Sat, 22 Sep 2018 18:02:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180922180231.GD432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YfqBrEkRVu0wMIYz"
Content-Disposition: inline
In-Reply-To: <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YfqBrEkRVu0wMIYz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 02:47:43PM -0400, Taylor Blau wrote:
> +expect_haves () {
> +	printf "%s .have\n" $(git rev-parse $@) >expect
> +}
> +
> +extract_haves () {
> +	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'

It looks like you're trying to match a NUL here in the sed expression,
but from my reading of it, POSIX doesn't permit BREs to match NUL.

Perhaps someone can come up with a better solution, but I'd write this
as the following:

  depacketize - | perl -ne 'next unless /\.have/; s/\0.*$//g; print'
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YfqBrEkRVu0wMIYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlumg7YACgkQv1NdgR9S
9osAsBAApHPgis/hIgnI3x0m/8TZ971hnymBfRj4U5kmBqmqoXGSeSxhjZxwtVMe
98lNjx+3tyaiNCYIpeoFhTHxL05yPdyRDny4/AWA36mwH9wporvKmLrtk6V3+zwE
xKImDYCyh/9WzUUZRP/iltm5Rka+KbulpP45XdrzVD63BCZFu4Yxx3mlFbtkRLKb
Bm8is3jJtO8A0aUpZZR9IdzN2wU9s0Nq1eGyCQd/Px2mj22RIg0fzcqkS5pZ1RNK
hObUGT8f1IBE1x0yjs0vFuWs1tqyZGiucl3ARmb8Irfv22wk2p0ygd5+ZQs+Wcp6
bgDlfagrVnJCWsXubQYFlojtdnRxiSoRRjrnXv7khRIHrrutIXMKEmzbaC/dV0Q2
8ovvXwXfpbd9JqRNd4dQu8F/DfKcbsls2PDAdS9hyo+X2qSFxA/+8zOaJWpYWLSt
iE9YUqNuEX8of2z1OD+FUcKdTOua9fGb89BSwrzBVLrBmBCWcS0vCzoocLJub73U
lvcgM7+otOHImh48gXrHNheUxmmS4qKZSZTL8EseOgOYcGPkUv/HTHWHQOw9UMiI
FRmOpvFEZzttIFlWcTWL83RAl0ikWqBTCCryuT9auIhSHecYLt6jJC+rG15vILn6
w66VouzT6VBP38pN+UatmVbhSZneExUme1YD79vGShEPbvU+/Zg=
=gng+
-----END PGP SIGNATURE-----

--YfqBrEkRVu0wMIYz--
