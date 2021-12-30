Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C66C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbhL3Uf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 15:35:56 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:57898 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbhL3Ufz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 15:35:55 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6D99D5B21B;
        Thu, 30 Dec 2021 20:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1640896554;
        bh=6Qluf7S6Ck+pN0DhiomXyaoCdmA17tYj+huAgXiVCg4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mH6mWB0gqkCFQrKUpASNIz7isLUSBT70KGu/V8XjR2P+5i/38OIY2YNjT4oa8NVxS
         lAAoDb5Eh/PP9hygz7m2tHeECXqaISpCP3wfaH1UfDnWynZF+bWohV49CZMG4oPSrk
         xLlhVg7kcKNVEgycXK+mxY1nVPOsikUmKBUDZQAFxS2Da3r4R9NZ35Ec7JqYAaaJ+0
         bpkt+cfriW3hBQJmjeO3uxMDF728PsVR5p/DJtlHNQttwXM8bvWpVUEuZM4LWKRJlv
         OOpTmpaiOFkk5mZsR5C5nSiYUMR6hOdd2LzHZ7s3QFq7WTc4k63avEesOid8w84oSg
         GgmKj5z+09ZgB6aRsHjfZF6Q0I5BYuoceNTM5XKJgBcfAF4ZuhkZmPaW/DVM7APP/d
         V1oaBqLn4WdFS2VHjNGe5OBrEYRRECRXo5jaUGe5LeVn5940ehC5YTlsAQTXYL05a2
         f407/iLauVQTsO7iP6XAt55QhfYPVNy+gjDdzXWVZtr3AmfFl0q
Date:   Thu, 30 Dec 2021 20:35:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jean-Louis FLOQUET <jese.jlf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Question] : git 2.33.1 asks every time password
Message-ID: <Yc4YKG+taXOuf6Kx@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jean-Louis FLOQUET <jese.jlf@gmail.com>, git@vger.kernel.org
References: <CAHo1AWxzPsnLuT8JRWovtaRrGvRS8+0NyucU5K8VEnaL1xxW3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EqkWWqk/yALoxga5"
Content-Disposition: inline
In-Reply-To: <CAHo1AWxzPsnLuT8JRWovtaRrGvRS8+0NyucU5K8VEnaL1xxW3Q@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EqkWWqk/yALoxga5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-30 at 15:56:12, Jean-Louis FLOQUET wrote:
> Hi,
>=20
> I use some scripts to do some batch operations (pull / push), using
> rsa key and ssh-agent / ssh-add. I'm under Windows 10 (with all
> updates).
> When launching my script (see below, truncated : more than 100 repo),
> I have to enter rsa passphrase (OK) then all push/pull are done
> without any user interaction (no passphrase, no password, nothing)
> All Git versions up to 2.33.0.2 are working fine, but since 2.33.1,
> git asks every time the password.
> I had to create a 'config' file within '.ssh' directory to support my
> rsa key (too old format ?). Instructions according to
> https://stackoverflow.com/questions/35233777/git-error-unable-to-negotiat=
e-with-xx-xx-xxx-xxx-no-matching-host-key-type-fo

If you're seeing this problem, then the system to which you're
connecting is insecurely configured and using obsolete cryptography.
You should inform the maintainers of that system of that fact and ask
them to fix it.

> I also have seen that some people have to add 'ssh-add -K', but it
> seems to be only for MacOS.
> According to release notes for 2.33.1, Git Credential Manager for
> Windows has been replaced by Git Credential Manager Core, but I don't
> know if it is the "root" problem, and if yes, how to fix my issue.
> I would greatly appreciate any help / solution. Thanks in advance.

You should run "ssh -vvv SERVER", where SERVER is the server to which
you're connecting (e.g., git@github.com or whatever) and see what the
output prints.  That should tell you why it's falling back to a
password-based configuration.

Note that credential managers are only used for HTTP and HTTPS
credentials and not for SSH, which is separate.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--EqkWWqk/yALoxga5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYc4YJwAKCRB8DEliiIei
gR4eAPwMXVKeVjYDZSIeHiwHJRTLDNzXj+Vo/PypXDV6UyimawEApYOB8iTvuTy2
+pejUMYHGm4WLAvBsGY4P1XPBltOMAA=
=OWgq
-----END PGP SIGNATURE-----

--EqkWWqk/yALoxga5--
