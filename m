Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF11C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 03:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059A061406
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 03:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhDUDdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 23:33:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38252 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhDUDdP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Apr 2021 23:33:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 931D26041F;
        Wed, 21 Apr 2021 03:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618975932;
        bh=aTqNF8oF3xqTQWktbPnyiy9eXnloj42TTZ11o19wAw0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=J6tG5ke1nulf3ALn1Aq98qpMreoz+H7hMbiyGeXtcEWG9HB+8iIinKL9v3yAQmaKk
         tZJBUwNnsbknufjtuX/OyFOnu3ArXZDm+YMIP834K4sIQHc+lQFS6rczhUtqHQ4Q7y
         Lr+9tWiuUu41usi3RdWr6xZfCUgFbaympepCnXavAbwGhsSo6nPRtAY/lyUgU8AQIz
         u790MzZ3eoxhqSzQwT2oKZQd3RWtRvTYRUPC4RODoWyVci/+qrzeSa8rKza2UDEQoa
         /VzP4DOkCCBQURIfqqQAiob+RLtel0FIqs8DQOISM9kBpYjorrp7AZXPt9fU/PwncT
         /D+vhCCdxupjwDH9z205OaJZ7KCiGeagF5fJRfPSuxyUHgngIZingLgX2qa+PnQxxn
         +Rt7IiABTv2Z5l3s8OInOIUnckkq2WJM7lx9nj6LLzZkg3E2SZnRNkUTs4GprerX9e
         I7+1Xl1O25oFdd9pTmb7iO/FPqe6YfTumFd5ijT/Zc3tYWdkUTA
Date:   Wed, 21 Apr 2021 03:32:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: strip CR from base64/quoted-printable email
Message-ID: <YH+ct4haFn4q5qNB@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <20210421013404.17383-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XZYsod8iRgvh62CF"
Content-Disposition: inline
In-Reply-To: <20210421013404.17383-1-congdanhqx@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XZYsod8iRgvh62CF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-21 at 01:34:04, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> When an SMTP server receives an 8-bit email message, possibly with only
> LF as line ending, some of those servers decide to change said LF to
> CRLF.
>=20
> Some other SMTP servers, when receives an 8-bit email message, decide to
> encoding such message in base64 and/or quoted-printable instead.

This really isn't an SMTP server.  It's mailing list software, namely
mailman, and I would argue it's a bug, even though we may want to work
around it.  For example, re-encoding the message breaks DKIM signatures,
which means that mailman is likely to cause mail to be needlessly
rejected.

8BITMIME is now so common with SMTP that I'd argue that we should just
write off servers that don't support it (especially in the context of
SMTPUTF8 existing), but this isn't the case of an SMTP server being
stuck in the last century.  Can we say more accurately that this is
mailing list software (or just call it out by name)?

> If an email is transfered through those 2 email servers in order, the
> final recipients will receive an email contains a patch mungled with
> CRLF encoded inside another encoding. Thus, such CR couldn't be dropped
> by mailsplit. Such accidents have been observed in the wild [1].
>=20
> Let's guess if such CR was added automatically and strip them in
> mailinfo.
>
> [1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-=
group.fi
>=20
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>=20
>  I'm not sure if guessing the heuristic to strip CR is a good approach.
>  I think it's better to pass --keep-cr down from git-am.
>  Let's say --keep-cr=3D<yes|no|auto>

I think we may want a separate option here.  When I send a 7bit or 8bit
body, I expect text canonicalization on the line endings.  However, when
I send a base64 or quoted-printable body, I don't expect my data to be
modified at all, and absent a compelling reason, doing so is incorrect.
In most cases, using base64 or quoted-printable is going to mean that
the sender knew that the body shouldn't be modified, not that mailman
modified it, so we should make line munging in this case opt-in.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--XZYsod8iRgvh62CF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYH+ctwAKCRB8DEliiIei
gaDSAP42ZyewX25CPBtEvYK/KPNbITXFcY/bGBqI2e9ybsEKtQD+OZJpGwj6YHjg
y+rjCxedhttL2PZ8O1OpdDC5qg1AqAE=
=iFbj
-----END PGP SIGNATURE-----

--XZYsod8iRgvh62CF--
