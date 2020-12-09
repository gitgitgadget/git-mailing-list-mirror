Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A75C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 02:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF4A23A5A
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 02:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgLICZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 21:25:11 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56566 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgLICZK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Dec 2020 21:25:10 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3677060751;
        Wed,  9 Dec 2020 02:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607480639;
        bh=hNqgYPfyrgJmWzWNk6hC80crS30dwwGUUhEsdMyQfLE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cSdSEd38dTfx5Xcp6l/lrSUDPKGXxEzHSELJXfK5wL3KaCuZZ1hQCqtwvoVYLOT8a
         9ZN5/7bxS06P0veiuBbU+x7EahgXVIZMjuLG8XTtOLorQS6hCBIuoYCn+3UkoqaWU0
         YOMpk5BHg9ZeakgcLOmM4x5XXr9ODRMabYDoMT0jJRtTFtYVqAopd31ONWqi+53o2Z
         OhBxIuvwXDGITEEDGrQbT0k6RrM0dnSWXzkrveoVaC2Fxj59KZccc3C2r5SCOZMY+P
         b3/0OFXu3sfF1lGZ32Sa9DpcpMsDLx74ngn4mlV9+ILvsfBhYsd97fL/i6ijyM2qfX
         EhjDHk38qvyii5gj/CpJ2P9CSgzduqgKYluv8hZ2E098XTuvZVF/uorKQGOjaG59Ti
         PV7nbQ/WWK0+edtmz9ez8AASoGY8TdlQO0pDnsnyBOIlTUbZL3NL6C7NJb7769kPTL
         S8uMRR7nFIMZ9ah0wfssGk4AlSr+uhT3U3DWTFNJM4qrj6XwuCw
Date:   Wed, 9 Dec 2020 02:23:54 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
Message-ID: <X9A1On3v35nEjL7i@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+YDBSF/AB6pAbS11"
Content-Disposition: inline
In-Reply-To: <20201209002619.25468-1-felipe.contreras@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+YDBSF/AB6pAbS11
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-09 at 00:26:19, Felipe Contreras wrote:
> It's not efficient that everyone must set specific configurations in all
> their ~/.vimrc files; we can have a project-wide .vimrc that everyone
> can use.
>=20
> By default it's ignored, you need the following in your ~/.vimrc
>=20
>   set exrc
>   set secure

I would strongly recommend against advising users to use this
configuration.  Vim has been known to have repeated security problems
with what options are allowed in restricted environments, and even with
the secure option, it's still easy to do something like this:

  func Foo()
    !echo >/tmp/foo
  endfunction

  nmap i :call Foo()<CR>

When the user hits "i" to enter insert mode, they'll execute the
attacker's arbitrary code.

> We could add the vim modelines at the bottom of every file, like other
> projects do, but this seems more sensible.

We have an .editorconfig file[0], which is a cross-editor file that can be
used to specify these settings.  It is supported by many editors out of
the box, although Vim requires a plugin.  Since we don't want to support
configuration for every editor under the sun, it makes sense to use a
single file for multiple editors and let people configure their editor
accordingly.

Since Vim would require configuration either way and .editorconfig files
don't have any known security issues, the .editorconfig file seems like
a better option.

[0] https://editorconfig.org/
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--+YDBSF/AB6pAbS11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX9A1OQAKCRB8DEliiIei
gdYBAQCtg80/5Hl6dKeth1Ylw7nn8KKuyItNimQYPB2EgDSOVQD8DmQtU/eTnLZt
0VkXlCN3aA4vvx/Xez0uwuosRYlEMAg=
=icGz
-----END PGP SIGNATURE-----

--+YDBSF/AB6pAbS11--
