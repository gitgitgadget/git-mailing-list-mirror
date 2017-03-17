Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EFB120951
	for <e@80x24.org>; Fri, 17 Mar 2017 16:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdCQQtB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 12:49:01 -0400
Received: from mail.fairlystable.org ([216.151.3.163]:42722 "EHLO
        mail.fairlystable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdCQQs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 12:48:59 -0400
Received: from [174.25.131.71] (helo=localhost)
        by mail.fairlystable.org with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <jrayhawk@fairlystable.org>)
        id 1cov3c-0000cz-Ca; Fri, 17 Mar 2017 09:48:52 -0700
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha256"; boundary="===============5288623328790535978=="
MIME-Version: 1.0
Content-Disposition: inline
To:     Junio C Hamano <gitster@pobox.com>,
        "Michael Haggerty" <mhagger@alum.mit.edu>
From:   Joe Rayhawk <jrayhawk@freedesktop.org>
In-Reply-To: <xmqqo9wz9b68.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
 <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
 <xmqqo9wz9b68.fsf@gitster.mtv.corp.google.com>
Message-ID: <148976932628.2144.11216577266857568258@richardiv.omgwallhack.org>
User-Agent: alot/0.3.6
Subject: Re: Shared repositories no longer securable against privilege escalation
Date:   Fri, 17 Mar 2017 09:48:46 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--===============5288623328790535978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Quoting Junio C Hamano (2017-03-17 08:26:39)
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> I _think_ the real bug is that somehow a user got a wrong impression
> that directly underneath $GIT_DIR/ is somehow different from its
> subdirectory and it is OK to make the directory unwritable.  I do
> not think we never intended to give such a promise, but there may be
> a documentation bug that gives the wrong impression, which we may
> have to fix.

Actually, yeah, that's a useful outcome I can steelman out of this
email: given that git init --shared has always introduced trivially
exploitable security escalations, it should probably either be changed
to use sane permissions or have its documentation changed to mention
that, at least on base POSIX, using --shared to share a repository
between multiple UIDs literally eliminates the purpose of having
multiple UIDs.

--===============5288623328790535978==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0W3/Ls5On90y4dmX35w74P7tvu8FAljME2oACgkQ35w74P7t
vu/zIw//ZDtdLDtu9YLIGxQJKUGboOpuZeBfwowwLPzouYMip2jVvO4EUrE54Yvj
DBMGGf5stoCsB4pexZZbsi9z49jpgIgvAdOaLA2budTb/eiCuNCeJWqcqr6xHoHI
HwOIPFDKijrXs5MJaX3AC8v7nCjkB1Wz5sJnGUsxzmwgEitg1GPI40HSCSbxjNzW
RbwpGMEUc14Dd63tSniQJml+vAYA78UKfrmB650vrms1Lf6D47t15xPTv/nRalLa
3IGwmW+6738XXZ/rw8Awj4TjoL8jQ4k/ZCOMWHW4SPakuoGx233/YCHsNlOyrFWX
r3g7DtXo6uX2OKp3Q3pnvgTFdXreYCEDBtQXmBKLAyVYqlGO37hqkVliMQZPc3Qz
z9rOgStEQdM2xm79jouOfgcAayoZMrHGuUD7MfF++G/Nt+VAyj+M9XT5N1qk4MNc
jPt5IU65TecbLghISkZz5e0TIdaGYmJmqyyRrEixPC8sMpzf9B+9kgYe+hgnNwU2
l/Wef0fGxXkbhItw30X9RcU5+7LG/gZEhEmzOo7fS1M4yp1MBSnDNLv/Yvi5eFPD
u9t3GWDL+OVvoZgGIGcdeHQxftYxqOAMtGVF1hoE4PZ5id0QfQJJaDLSlD66Vsm6
3fbggDYsT26C1u/5lfgxQYvjCME5nLlY1Uenw8omnJZCRzTJqHM=
=+P0d
-----END PGP SIGNATURE-----

--===============5288623328790535978==--
