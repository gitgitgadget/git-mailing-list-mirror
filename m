Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAA9C3F2D3
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 02:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4551724650
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 02:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NkaISwG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCACB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 21:01:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgCACB2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Feb 2020 21:01:28 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9E51B6048E;
        Sun,  1 Mar 2020 02:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583028087;
        bh=HTeN9tskNZoi+L6ySNB/r4cNoF7G45FDZkB0i442sJw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NkaISwG7WNkIrPz8z83NmAjuc21RdkeXc/CobrNc5p9GTWxTk8bGSXjpYDoYjgDNa
         +hAtnf7Y1VE0DFdTJ1l48i8ES3qTzY/Lm0oAtu8F58yWRB9lC80768eaPyBPRR43R1
         RqPkvy4CPqE4nh+J2Ekv4byoqwzSM6zqyP7PJhXUgWPcaVzwa+JqeK69dvCd70eNej
         Vn24EZ0zQ1Lzfrm6b+8KDaW/sqZLJTblhHbVWJ9Vc/CbCD2kkwKuhwAxluLVA2i9Bh
         4qHvFMaEWyKkphY+Vk+KVaE5UkzQjfl+iYYCsApy2Um/o1EuQQ2Rtfra4i0uE+f+2b
         cRwiwNAK9d7TBcPkrRHR8wcz4phfipWRq3hfLqCfc/VAGh8d7I8VF5h1vDAFC394X9
         9aNcnJI38yTGM5ev1ehzXu6czDzR/HJof1BvCSBeD/FZDZBws6NX7dYhLQX70icWuq
         RyMbdlwikls8WCDdf6EqUvlMNiHhTNxIR8x/6dDL8yG6SEwlmlq
Date:   Sun, 1 Mar 2020 02:01:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Harald van Dijk via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] show_one_mergetag: print non-parent in hex form.
Message-ID: <20200301020119.GE9290@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Harald van Dijk via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Harald van Dijk <harald@gigawatt.nl>
References: <pull.568.git.1582981677312.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <pull.568.git.1582981677312.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-29 at 13:07:57, Harald van Dijk via GitGitGadget wrote:
> From: Harald van Dijk <harald@gigawatt.nl>
>=20
> When a mergetag names a non-parent, which can occur after a shallow
> clone, its hash was previously printed as raw data. Print it in hex form
> instead.

Seems like a good idea.

> +test_expect_success GPG 'log --graph --show-signature for merged tag in =
shallow clone' '
> +	test_when_finished "git reset --hard && git checkout master" &&
> +	git checkout -b plain-shallow master &&
> +	echo aaa >bar &&
> +	git add bar &&
> +	git commit -m bar_commit &&
> +	git checkout --detach master &&
> +	echo bbb >baz &&
> +	git add baz &&
> +	git commit -m baz_commit &&
> +	git tag -s -m signed_tag_msg signed_tag_shallow &&
> +	hash=3D$(git rev-parse HEAD) &&
> +	git checkout plain-shallow &&
> +	git merge --no-ff -m msg signed_tag_shallow &&
> +	git clone --depth 1 --no-local . shallow &&
> +	test_when_finished "rm -rf shallow" &&
> +	git -C shallow log --graph --show-signature -n1 plain-shallow >actual &&
> +	grep "tag signed_tag_shallow names a non-parent $hash" actual

I appreciate you computing this value with git rev-parse.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlsXbgAKCRB8DEliiIei
gZ0PAQCuHopz3NbTm5DCd7Rrl87Y9G/QIqxhXi5Ex/3eeLc+4gD/ZQBOwnY6v5DX
h4FaApla9N5ydtyRxglkCYFSFc9SVwg=
=+KTj
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
