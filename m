Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C0C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 23:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39AA061164
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 23:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhFUXg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:36:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54252 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229940AbhFUXg2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Jun 2021 19:36:28 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 59FEF60443;
        Mon, 21 Jun 2021 23:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624318423;
        bh=kNq9U23Ty4sOtyzHN6JbNZ5Uh2bdE+sy+sTxroAAA6Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TXqsnnH+9FGVA7Ecs1WhtbOLAlR4QszmOC2xcRQRQeNy+yb8OyamrzLhhYBtZKDYE
         VXd4Xin9yJk79Ffv0r8nUcoKKmeKCw4QyCUaHyS8verFDN78O978hR5pVUdcQNz9Hu
         H5NgXts79O2zMjs2+wVdpbSj3ncsCevLrHLwZEnPBAsV3UKq+xJcnbPZ0dW/imts8A
         q72kLtu2LFnx8jYFF2P5hgSxrMPANxXwazws9eGYG0QIWQYo5BxdOhpeyHfm+IwAlg
         dMmGOQHy5NWMv3gx/DpG4H3LnJ+SGanJvPwp5E53nK2Ms/dOxCXFOAl8u5Q3JGR6Nw
         CNbCYZC9zbjEG8WfL0GbSYWjZHD3ySjQoLC1YBEKZqGhR/1wz9kdLPCiwvN/Uj6nHz
         vME/a/gAxEP3OA4a2HKjheSjHxjt+4eRknv4GAWrLXzs/V2YJR/sK3BYhLqGA8RcgJ
         JoNqZ86StM+SCoWVwd3j/HkMQ0fUHIXF1t0HGQYwIuQ/lZkwzdD
Date:   Mon, 21 Jun 2021 23:33:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: About the usage of core.gitproxy.
Message-ID: <YNEh06GSuoix+75h@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Hongyi Zhao <hongyi.zhao@gmail.com>, Git List <git@vger.kernel.org>
References: <CAGP6POJErqxTf1=u=N0Fg28Fz+8t3Y8o1peiGP1nqEuttKgN2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J8CMOarkHwgL6giX"
Content-Disposition: inline
In-Reply-To: <CAGP6POJErqxTf1=u=N0Fg28Fz+8t3Y8o1peiGP1nqEuttKgN2w@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J8CMOarkHwgL6giX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-21 at 21:58:29, Hongyi Zhao wrote:
> On Ubuntu 20.04, I noticed the following document for `core.gitProxy':
>=20
> $ man git-config |egrep -A13 -i '^[ ]*core.gitproxy'
>        core.gitProxy
>            A "proxy command" to execute (as command host port) instead
> of establishing direct connection to
>            the remote server when using the Git protocol for fetching.
> If the variable value is in the
>            "COMMAND for DOMAIN" format, the command is applied only on
> hostnames ending with the specified
>            domain string. This variable may be set multiple times and
> is matched in the given order; the
>            first match wins.
>=20
>            Can be overridden by the GIT_PROXY_COMMAND environment
> variable (which always applies
>            universally, without the special "for" handling).
>=20
>            The special string none can be used as the proxy command to
> specify that no proxy be used for a
>            given domain pattern. This is useful for excluding servers
> inside a firewall from proxy use,
>            while defaulting to a common proxy for external domains.

This configuration option is for the plain, unencrypted Git protocol
usually served on port 9418.  Almost nobody uses that these days,
though, since it is unencrypted.  This configuration option doesn't have
any effect on HTTPS or SSH operations.

> For my case, I've a local socks5 proxy running on "127.0.0.1:18888",
> how should I set the above option so that the following command can
> pick up this proxy:
>=20
> $ git clone git@github.com:torvalds/linux.git

In this case, you need SSH to tunnel through a SOCKS proxy.  According
to [0], you can do this with the following data in your ~/.ssh/config:

  Host github.com
    ProxyCommand /usr/bin/nc -X 5 -x 127.0.0.1:7777 %h %p

If you want to do this as a one-off, you can also do this:

  GIT_SSH_COMMAND=3D'ssh -oProxyCommand=3D"/usr/bin/nc -X 5 -x 127.0.0.1:77=
77 %h %p"' \
    git clone git@github.com:torvalds/linux.git

Note that that requires a POSIX shell; I don't think it will work under
CMD or PowerShell.

[0] https://superuser.com/questions/454210/how-can-i-use-ssh-with-a-socks-5=
-proxy
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--J8CMOarkHwgL6giX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNEh0gAKCRB8DEliiIei
gScjAP4yQoGQV+iQe1u4c1Q2aLQAsaap4TCcGmTivp5blGDI+AD+JlQ70ZNFUJ96
VhfrDD2lvhX3bJi+4F3/t4bLOPLgCgA=
=y/a/
-----END PGP SIGNATURE-----

--J8CMOarkHwgL6giX--
