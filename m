Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D4C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 01:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC5D64F69
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 01:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhCMBI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 20:08:29 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39374 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231679AbhCMBIT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Mar 2021 20:08:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E1D1F6048E;
        Sat, 13 Mar 2021 01:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615597698;
        bh=Mly1PsAVf9PeUeRMSYfsGr1r1UBnJV4M9KuPJiMsL2Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NM0FhdGHnrdmg9OUFGhwaYmKTJ8WsnET4QUuCQtl8FZSIjxfFMwF65zr4rOKCdbAS
         Zflr6diNbod33ZRsz8dm/fk5wkF+6omNtjFphpg2rDGXO4M2WDJuJeClL/TY3Hwwok
         f3xBkj33/Ayl6n/WLuSlj8fLGIjWrGs4sXwGSydeNALdcyZgreE0lfLEfsS1Q233KH
         mAZ737qiL6K8+HAf0D0mfA+uyO/ZjqJPDseOb/CNoiGlkZo45OKhqv3b4ICVsH5ONN
         LZd124oOoe3bmSpR+P0MMLE6iymmJ5mRiFzktM2qimIxEHXp9gOrMP3JuiZ90/BeyP
         OPi9NpHM30pszfN4ninEcD8OX8olxltBpJk8oUFZNTnjxpMcCEvgt0ch+sg7pIiepO
         3fK90cDBAyNtRvx7gP1zAsDpA1jUddvJe3gcms46JzaYQJrBsuKpdQaGODCPQsu2CF
         fyGypEEHQn+FzMCY6J+0sRMZKVi70D2Rm6GbkZ0NGYJfUWZSPaM
Date:   Sat, 13 Mar 2021 01:08:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ephrim Khong <dr.khong@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] merge-recursive: create new files with O_EXCL
Message-ID: <YEwQe0qMUtlI5PCl@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ephrim Khong <dr.khong@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <f6cd9386-8a58-ee52-4c7b-60d9bd14a51d@gmail.com>
 <xmqqblbqipeh.fsf@gitster.g>
 <cd7c6682-7409-f72c-8751-02b70a423f83@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ASdgovQf22WGbDdw"
Content-Disposition: inline
In-Reply-To: <cd7c6682-7409-f72c-8751-02b70a423f83@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ASdgovQf22WGbDdw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-11 at 09:54:41, Ephrim Khong wrote:
> On 11.03.2021 00:01, Junio C Hamano wrote:
> >  * understand why your NFS mount is broken and give a better
> >    explanation as to why we need to have a workaround in our code.
>=20
> I'll work on this, but unfortunately have no idea of how to properly
> debug it. Since it is a company server without administrative rights and
> the backend is some IBM storage system, the options are limited and
> processes are slow. What I did find out so far is that it is not a race
> condition with unlink. A simple openat() without O_EXCL already produces
> the wrong file mode.

This reminds me of a NFS bug that we saw in the past[0].  I don't know
if you're using that same type of system in this case, but if so, it
could be part of the problem.

Since buggy NFS implementations seem to be a problem specifically with
open(2) and I need to reroll my series to add some entries to the FAQ,
and I'll document that we require NFS servers to support POSIX open
semantics, including permissions and O_EXCL.

> (I fully understand that this is not a bug on git's side, and I found no
> documentation indicating that O_EXCL would be recommended or have any
> effect in this way. Hopefully, others that run into similar issues would
> benefit from this as well, there are a few reports online of people
> running into "failed to refresh" errors.)

This does tend to frequently affect Git, but it can also affect other
programs as well, and you're probably going to be better off filing a
bug report with IBM about their NFS server than trying to work around it
in every situation.

[0] https://lore.kernel.org/git/CAPx1GvfKxu8gwbp0Gn2dBf9th874skKjD-echeAFr7=
_77o8FYw@mail.gmail.com/T/#mead6be6c92f0ab29cf9fd600781dea7315e87411
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--ASdgovQf22WGbDdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEwQegAKCRB8DEliiIei
gR1mAQCM4V94t9g2+ngn74igjNmJeYn3UAdNuXv04JzCBJg85QEA7rnx6HfWp5eT
WknIDUU2rJuAIOOLe3F4FFjFwJ4mhAo=
=Ltgj
-----END PGP SIGNATURE-----

--ASdgovQf22WGbDdw--
