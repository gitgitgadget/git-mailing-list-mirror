Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E0EC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 991A5206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XdkrZLJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFHW64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:58:56 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39126 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgFHW64 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jun 2020 18:58:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DC07060436;
        Mon,  8 Jun 2020 22:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591657105;
        bh=FE6IDBhAmZ964RzyqlucveIuNqz+Q1CYMt6pxEP3DFE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XdkrZLJMTdrICwTmUHtbiSumlGMNxnuvfD29ZRMUjzsTweXetileD9RbR9JlUa8iE
         koqBy5/0B3X30JL2zKXeb3YkQBBFcIF+h4wVwyHtpAyRxKqHG5m2HgVUKHAkCeuL+i
         bg/amde/oW7LCXlKtGAS7S7cy5ARMpgY4+KFtIpL6LQKOLHmueK/YQKlJjd8b3LAsr
         /fM9qJ4gHlxG71DuTLL3/VJxQlZTnowo+RFzSDgqlb36RLLl7TZPI7OeywyI7Dir2F
         C/z4BVr5aKUSS4GTpDHWIxNdcXO54VgP9wJleqyoAT13fvc83vPTD2C367SAJE3Y/K
         Zcr8G7wyTFLPzFfWmqdi+VCgVmjnwIqYl9k9jDbMj59KH8oBbn0qPFSXTwdbarmE7Y
         hOTnGrOwwxe9o8HMkhRFwEo7q2r9lMxkj3b3r50XzES8jswe8+5S68bkwZ8W7ZNfzi
         x7v4m/d05zL3RBn3ub5qIG/jMLeWK/BOWLLeejabqyL3lHgIsQL
Date:   Mon, 8 Jun 2020 22:58:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tibor Billes <tbilles@gmx.com>, git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix incomplete conversion with multiple
 mark files
Message-ID: <20200608225820.GM6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Tibor Billes <tbilles@gmx.com>,
        git@vger.kernel.org
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
 <20200606002241.1578150-1-sandals@crustytoothpaste.net>
 <alpine.DEB.2.21.2006081739520.9949@serpens>
 <xmqqtuzlld1d.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lRF4gxo9Z9M++D0O"
Content-Disposition: inline
In-Reply-To: <xmqqtuzlld1d.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lRF4gxo9Z9M++D0O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-08 at 16:47:58, Junio C Hamano wrote:
> Brian, I notice that the singleton global "marks_set_count", even
> though the number could be counted per instance of the mark_set
> structure, is still singleton.  I didn't bother thinking about it
> when I wrote my "perhaps along this line" patch, but now I read it
> again, I think it is OK to leave it (and other stats counters) as
> is, primarily because we don't have a need (yet) to show stats per
> mark_set.  Did you leave it as a global for the same reason?  Just
> sanity-checking.

Yes, I did; sorry for not mentioning that in the commit message.  I
think it's fine to count the total number of marks processed as a
statistic, and that would be independent of how we processed them.  It's
an interesting metric, but not so interesting that folks will have a
need to see a detailed breakdown, I think.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--lRF4gxo9Z9M++D0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXt7CjAAKCRB8DEliiIei
gU3VAQDVBqiWMlkqO6oweonBId5anIqyFDwlxqlzhcHPXNXYywD+Jk8CmusRzpGK
iT2lPKFMb603eS8jKmgfF16HDEUpuwM=
=8upx
-----END PGP SIGNATURE-----

--lRF4gxo9Z9M++D0O--
