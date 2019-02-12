Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113D31F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfBLA3l (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:29:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34180 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbfBLA3k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 19:29:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AECAE6042D;
        Tue, 12 Feb 2019 00:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549931379;
        bh=O/cvsw79Xymcrdpvj++Z7brWqlC0d0CpfmT6KOMwq2Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=h28rxFwrJz9Yeo1/EGfllfWgutSdFIyGMJ0bbYeBpQRyBD4U+79C424yAQUahCBOG
         K7HJXDZBP4v+cbx3h6DizxPmXa+mC7Cxz18q/beHZJmRXbuNU8T9W8aGvnvwT/lSr/
         ShWdwPGydUiyRRhwGLQ+TjveuWzJ7xZpzyCEfw2WlnqmdLRbQNVFxFLFHPG/v978f7
         gu8fvw6JAhRSU/TS9t7QtgYpXcN/Mlo51p8HhN/wEKfPptGmvcE1qEKNuxvmQeEXTP
         26AG8YHFLo0LUs5rG071M+JXS/z0XmAF+CfiIbkQ0dSYZ4JTWdI9X80X5fccYS7JIL
         d8/9Xqyt5G6NeSRd/mC5exE46Lv+CyGVHmd1vTB9knvgN4FfcRCWdMUDpkwBHsKllv
         wdu8swQY1bM5AqkyXzg/8/X+WSWPARWOYTFZu6LiJz5DC239klujeHtHOx6fvLBPm5
         CuiNHDiJzKzvwfVBibS4TZ/kdVsc+N1WMXUp2wx16pHY1dgqhbt
Date:   Tue, 12 Feb 2019 00:29:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ismael Luceno <ismael@iodev.co.uk>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Handle Ctrl+BS & Ctrl+Del in the commit msg
Message-ID: <20190212002932.GC684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ismael Luceno <ismael@iodev.co.uk>, git@vger.kernel.org,
        Pat Thoyts <patthoyts@users.sourceforge.net>
References: <20190211214203.32444-1-ismael@iodev.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20190211214203.32444-1-ismael@iodev.co.uk>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 10:42:03PM +0100, Ismael Luceno wrote:
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> ---
>  git-gui.sh | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b878d41..e00d9a345294 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3788,6 +3788,8 @@ bind $ui_comm <$M1B-Key-KP_Subtract> {show_less_con=
text;break}
>  bind $ui_comm <$M1B-Key-equal> {show_more_context;break}
>  bind $ui_comm <$M1B-Key-plus> {show_more_context;break}
>  bind $ui_comm <$M1B-Key-KP_Add> {show_more_context;break}
> +bind $ui_comm <Control-Key-BackSpace> {%W delete {insert -1 chars wordst=
art} insert;break}
> +bind $ui_comm <Control-Key-Delete> {%W delete insert {insert wordend};br=
eak}

I don't use git-gui and I don't understand TCL, but I was interested to
learn more about these key bindings in case other programs use them and
they might be useful in my day-to-day life.

However, your commit message doesn't include a body, so it isn't clear
to me what this change does and why these are useful keys for git-gui to
understand. Are they common among many programs? What do they do? Why
did we pick these keys instead of others?

Perhaps you could send a v2 with a more comprehensive commit message
that provides some of these answers.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxiE2wACgkQv1NdgR9S
9osd4A//ZMYeQf91ArRTQPfREmJr9YEIZm8lfGVQpa35jUZc3anFbj3vlYwscoIf
IwjYy8Uxgok7CnrX7cfdvR6VAvC2nUCqlMwkgnK49Qk0T+5wTWwdt+KZ9og5x7ec
cwpWXIpLV7gRX9BMyDb1r39UYwU9g6FDCtQZq0acwQs3tRmXz11vmD7g68P4iRaz
HFqb1l96yk0jR1E9bR2Lfh9SqIyrvcns40u4b9arDfSYeZflckbQv2ns11jY2WS2
GfIIqMfptI1J/PjDVpRSwlpp8b0jv2BqqxchlzxZYuMtgltmIZYiUfs6UO9lUDNn
90pJKSgny7pjftqXVm1kHc/WJg9QWsnashfzEQEY2DbLYURcvpJT9Oy7/kDarDcx
uLRFC6bONV39zj4p3yYN5KywpxgmwOTasqlualmXH5o9brR8x+l5j7uWrXHIn5QY
1ZodosbsRUA2DDtkmY/xXJLR8rPq5sw8/F9TfvoJExgLSqYuqp6dXMSumU75CBfa
IvNlBfn4oixQyK7d49LdMbF5L6L5CMdmujn/3Mo747KfOJqtFZjpU5PHzeVWDlvV
7TlxTFgB5eZlgLv6UXxCDZAJoDTGsmfNaIfK2wm/KKFP0Hz6FDlcG+rah/Hu611A
erVVZYeVl6EQLZgzmtDbAgSL28CMRh3JN4EuJvP3yYNNv77GUu4=
=EiMz
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
