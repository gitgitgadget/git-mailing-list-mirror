Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82EB1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 01:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfBEBzN (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 20:55:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33724 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfBEBzN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Feb 2019 20:55:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c489:9935:372d:73bb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E102260737;
        Tue,  5 Feb 2019 01:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549331711;
        bh=Wr5+k+lcG+nJIyAOyntX0mDoq4KR7Xqub0d32TmhPpc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=f4iKTLj/MxOMEbj85ljVNCJZdWoAU3EbyvC54/BoA2AlQkalCd37F+heokWSWkNVX
         UG/nmLPtHYIWIHXNusMzJFRf7phpuNim6eLjKfyGOgRQiwO0m/qVnav4tmEcLUMyPH
         EHQhLNBgNJppLDMxpA36ZkHkbhFGBiWviecaMoW/JkZ+3EDtP64JcTtBdgaw3yCeEG
         aMjscuikVkN5ijWFBClvgE0DoqlKBt3aR50mAbxlU0c0RrA9EBZ0dq6HnbyY+bZ1RW
         TLEHGVT4rgooydyT+wWc/5ZGG+EzMHcuOt8+BTskqgN0/PdgCjucPOXoI8BCyRZJh9
         TORZF4i1Wn3yClSP3xD2lPcYYc/j4Sf/J58IdJSVVKVqGwJSVwSP2QaxnS9MaOZjD4
         Su3/dUJKab9wlzOfgyI4cHqWOwNWreSpag/OVXxE6BKFf5zmufqkH9pNVhcKEbpoHX
         W0YSnlSBR4HaNih4HIM2LE85X/QYQhQsZwMvdtHnFCzyAVgqI6F
Date:   Tue, 5 Feb 2019 01:55:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Larry Martell <larry.martell@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: hook to get info on commit, and include that in a file that is
 part of the commit
Message-ID: <20190205015506.GB527887@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Larry Martell <larry.martell@gmail.com>, git@vger.kernel.org
References: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 08:36:10PM -0500, Larry Martell wrote:
> Is there any way using a git hook to get info on the commit (id,
> message), put that in a file, and include that file in the commit?
>=20
> If I try that in a pre-commit hook I do not get the info on the
> current commit. I tried it in pre-receive but it does not seem to get
> executed at all.

You cannot include a file in the commit with that commit's ID.

The object ID of a commit is based on the data it contains, which is in
turn based on the data in its top-level tree, which is in turn based on
the data in all of its trees and blobs. If you add or change a file in a
commit (or the message of that commit), you necessarily result in that
commit having a different object ID. This is by design and is valuable
for checking the integrity of the history.

Furthermore, the hooks for a commit are designed for checking and
notification, not for editing the commit, with the exception of the
commit message hooks, which are designed only for editing the commit
message, not the contents.

The pre-receive hook runs on the server side, so if you aren't running
it there, then it won't get called at all.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxY7PoACgkQv1NdgR9S
9otaCg/8DYT/JpYT1bVuu8kUdOArVpInN8aVXzWiTSnPjXk9sM84pOtx91M+EnKM
NxZryQb+Oe51tTVATDjwThtW5DRs6KiSct2w3YY4B2h4dXr6Ae1CQrz//6rv3rwu
GUN3k9bpZPlHhkJyL0NGM5M3UiTdM6JBJAbSakToDg+ssAZX5Vu9Wktq8la/6pij
4NgpLRCoF1+4WaxQNiGoId6JyQTzDkKwUMeqLqPcz1vJS1Yx1NZzEEX2lVEjjTqi
vmmlywB5u6vDOf6kRjUAOcs71Cvmv4ioEj0zUvapGAqMGhuZjyAw6wjN2ZSETdih
UNKMofED1CRoe5LH/zlpBrd++nhNq4phrRaPpn9VozqNR+JwcxtdLoYeF6hxZPWB
EbY93DW3gjWqI9zc2oTiWvjLRv8Ao5GgOQZvsMHdAYXbxMAUgxEmR2kaavbU53/0
ZfZCcBiuQd4cC1pBHT0sq2OWye7orz0jrXynJBzWsa+lohRPSdLIeK2rSe+l1Z+Z
+GTUwMBLe8Jc8QUwWlTbwh8ifVA6OW9dqPre9WFWXXBKuiz2KrXbSIv+5XwnsTKT
sIyhZotlzxsx4n7cS+Vr9ilYJfEdYBK8gWicuq8Pwj0PRj1e4A+ssj+E+nyLexGy
kW0SKodo2gp5KKmQxwoltqbytmA7csXKYoT8SMyS/HBXDHGq1LY=
=R6xD
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
