Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F7C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 02:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CADD61164
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 02:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhDTCF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 22:05:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37366 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhDTCF6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 22:05:58 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 87C5260422;
        Tue, 20 Apr 2021 02:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618884297;
        bh=qUs0nNoqt51wD3GUi9El2wGWbGY4iP2ji9ZrsnNABOI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Es6XSPP3K9vMH9d3VIYCmtNgB6zv24ywn0ME3AC1hFGvR+yofQWlhth3Pb3f3E+ig
         dXgBVS9uWsTwROjDNpIZwcSOLnzEuoVxmhUWAY4CdA92XIPjQ5SlaOYBWEEmSamAqx
         fCexFg2MGGNY1F1fuqfK6jKIPA2t8OqZErcP9zO2j5oF7TrMLQVZOVkfDYvVW9PNFR
         3j98xh8YpUqvOZQeBz8ZbEyMiZl8s/pZHNnE9kJ9cr1c3GRg+sQKusjEtNF2vaTlUG
         z+tYny9Vz4UKOug/VvEiUfm5Rme32Lbxyv3HwqzgKJ8cwUnX71KeALshsuDTAaT1gl
         Yw2vOcmowyfQWyJzACdT8oe+1oCcCBdxllMyH+ThSG/HtyBk99T7yOFFYIcQz/sFSM
         haj4LRgdLmXSCNywi6ggZ1anM+hYL86kNxToJTfuoWSgXt3RLR2SnT98M26GwQsb7a
         9p09WvsvvWpTffGabXvorr4nG3C8/9QSSzg7wrD6tWyPhjwr1F9
Date:   Tue, 20 Apr 2021 02:04:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Cristian Morales Vega <christian.morales.vega@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git checkout behaviour when only ctime of file changes
Message-ID: <YH42xGwjTX4Axcpp@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Cristian Morales Vega <christian.morales.vega@gmail.com>,
        git@vger.kernel.org
References: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CsgXBQ8XAj4EAXAZ"
Content-Disposition: inline
In-Reply-To: <CAOWQn3Qesh0+CkaD95q78Rq_vN5tjWKDe7HTk0Ynk-NY8XUKzg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CsgXBQ8XAj4EAXAZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-19 at 09:11:12, Cristian Morales Vega wrote:
> I thought you may want to take a look at
> https://issues.jenkins.io/browse/JENKINS-65395.
>=20
> Basically after something updates the ctime of a file, a
> "git checkout" can behave differently depending on whether a
> "git update-index --refresh" has been run before or not.
> _Maybe_ it could make sense for "git checkout" to always behave as if
> "git update-index --refresh" had been run before? No idea really.

I believe the situation you're seeing is that git checkout usually
doesn't rewrite files in the working tree that are already up to date.
This makes checkout much faster in large working trees.

By default, Git does include the ctime in its computation of whether a
file is up to date.  If the ctime changes, then the file is considered
to be stale.  git checkout, without an intervening command, will
overwrite it, since it's dirty and just overwriting it is cheaper than
determining whether it is in fact up to date.

git update-index --refresh does the check about whether the file is in
fact up to date.  This isn't free; if you've modified 1000 files, or if
you've modified large files, there's going to be a cost to this, and it
can be very substantial.  As mentioned, git checkout doesn't want to
perform that cost needlessly, so it overwrites the file unconditionally.

As far as I'm aware, Git doesn't document which files it does and does
not rewrite in the working tree as part of a checkout, except as part of
certain specified options (e.g., the --overlay option).  It is therefore
free to choose any algorithm it chooses, and in this case, we've
optimized for checkout performance, not minimal modifications.

There is a config option, core.trustctime, which can be set to false if
you don't want to consider the ctime as part of whether a file is up to
date.  But Git is behaving correctly and as desired here.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--CsgXBQ8XAj4EAXAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH42wwAKCRB8DEliiIei
gWv0AP0XgRjP3MGouhXcPjUPR1aDBzlecdL6xI1PPiidf04nggD9GY46KBMXuKRS
zD1sc0Xx3WqPZCw8E+obYHXj9XMmPwk=
=62j7
-----END PGP SIGNATURE-----

--CsgXBQ8XAj4EAXAZ--
