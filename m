Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F0C4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKFJOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 04:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiKFJOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 04:14:51 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495E2C5
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 01:14:50 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 79E845A1AC;
        Sun,  6 Nov 2022 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1667726089;
        bh=OYfQ6xpSikHTGIo0YHbRxU8NX/1Tc5GDsrz8V3lMRSE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CCgizi44nSe23Wj7Li/8rTQhEIlm8mIgxj9b7vpFNDr/N3tPoL9t/8bGQsErdXdsD
         e4WrB2H8i7JhXo6q6Ba/Wru0nnF3ZEGAjUwWp8bXBKXlkN64cesMJF/qErlZnsJ6C8
         wUWY94fnvhFWMgymPufm49AuR9Ji2N4he0afROGkwhnVDLmBTvcmclZzgWTgyJu+o4
         U4q5fkTw4ynDlPS86S91x2V2I23ReOE/laL9sEH63YH+ymEn4FSnCwVwr9CR7wI+fB
         lFvogrgxcrQcLhTuE5XyG1GsCyrzU5Dp5LtLb8qkHOSpcDKUgbbffWx3lxvEe2iAaq
         DosA/dd1iRkujLgEzHGgy6N5D/r3g2q8+9umt4GL1rNYc1i1rIHXdv/WyrjMBsmB3m
         vHAkaWLBiNAfPsZQ4UYJ/k15rVdBTZWeVyET+Uksonoy3j5xaMbao3w1yMaVLGhqKS
         8wdaLBJ5osx3bagUMhFwMsR8YR1yqN3aCDJIPw3tPXmrXrIJUVE
Date:   Sun, 6 Nov 2022 09:14:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Wu Zhenyu <wuzhenyu@ustc.edu>
Cc:     git@vger.kernel.org
Subject: Re: Can git send-email support neomutt?
Message-ID: <Y2d7B4mUPegaNPU6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Wu Zhenyu <wuzhenyu@ustc.edu>, git@vger.kernel.org
References: <20221105154600.hbrqs74inmvpebie@desktop>
 <Y2anAijZxu9QEX4M@tapette.crustytoothpaste.net>
 <20221106085820.m53mwajd5yfsyri4@desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lHgcsGLiQWMAjRcv"
Content-Disposition: inline
In-Reply-To: <20221106085820.m53mwajd5yfsyri4@desktop>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lHgcsGLiQWMAjRcv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-11-06 at 08:58:20, Wu Zhenyu wrote:
> Thanks for your quick reply.

Hi, please keep the list in CC.  It's helpful that everyone can benefit
=66rom seeing the replies, and it's possible someone else might have a
thought on a good way forward.

> > You can also use `git format-patch --stdout | neomutt -f -` and that may
> > provide you the same functionality you were hoping for with
> > `sendemail.sendmailCmd`.
>=20
> It cannot use `git send-email -1` I like.
>=20
> > Mutt and Neomutt are MUAs, which stands for mail user agent.  That is,
> > they're mail clients that people use to read, compose, and send email.
>=20
> People can use MUA to send email, the only problem is `-i`. I consider th=
e following method

Sure, I agree that we can do so.  In fact, as soon as I'm done composing
this email, I'll be using mutt to send that.

> ```
> [sendemail]
> 	suppresscc =3D author
> 	sendmailCmd =3D git-neomutt
> ```
>=20
> `~/.local/bin/neomutt`
>=20
> ```
> #!/usr/bin/env bash
> neomutt "${@//-i/}"
> ```
>=20
> And it can work:
>=20
> ```
> =E2=9D=AF git send-email -1
> /tmp/5441yKUviQ/0001-TEST.patch
> The following files are 8bit, but do not declare a Content-Transfer-Encod=
ing.
>     /tmp/5441yKUviQ/0001-TEST.patch
> Which 8bit encoding should I declare [UTF-8]?
> To whom should the emails be sent (if anyone)? my-another@email
> Message-ID to be used as In-Reply-To for the first email (if any)?
> Logging in...
> Warning: Fcc to an IMAP mailbox is not supported in batch mode
> Skipping Fcc to imaps://imaphz.qiye.163.com/Sent
> OK. Log says:
> Sendmail: git-neomutt -i my-another@email
> From: Wu Zhenyu <wuzhenyu@ustc.edu>
> To: my-another@email
> Subject: [PATCH] TEST
> Date: Sun,  6 Nov 2022 16:39:49 +0800
> Message-Id: <20221106083949.210946-1-wuzhenyu@ustc.edu>
> X-Mailer: git-send-email 2.38.1
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Result: OK
> ```

There's nothing here preventing you from invoking an arbitrary program.
That program just has to implement a sendmail-compatible interface,
which neomutt doesn't.  If you want to wrap neomutt in a
sendmail-compatible interface like you've done, then this can work just
fine.

> I want to know can we remove `-i` to allow more MUA/MTA? If user want to =
add something, why not let them
>=20
> ```
> [sendemail]
> 	sendmailCmd =3D msmtp -i
> ```

This breaks a lot of the existing tooling which expects that this is a
sendmail-compatible interface.  In addition, we might add an additional
value in the future, like -B8BITMIME (which we really should be adding
if we're sending 8bit data).  The documentation specifically says it
should be sendmail-like.

> I think it should be easy to realize.

I think this is going to cause a bunch of compatibility problems.  git
send-email is specifically designed to cause email to be sent (i.e., via
SMTP).  If you want to use another tool to do the sending, that's fine,
but then you typically want to use git format-patch to provide those to
the other program.

> And I'll consider share this tip to neomutt.
>=20
> Thanks!

--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--lHgcsGLiQWMAjRcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY2d7BwAKCRB8DEliiIei
geEQAP4sXFvq3XMbpCtgOWDap6rrlcglP8DOXs3TTP512RLCTQEA8WEE8wNN2Krv
Gv4dlUc2TLQpBW3kQkt05iflIxBGvgA=
=fkGd
-----END PGP SIGNATURE-----

--lHgcsGLiQWMAjRcv--
