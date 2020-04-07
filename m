Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C1C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED2B20730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="l4GJooe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgDGPw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:52:57 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:34221 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgDGPw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:52:57 -0400
X-Greylist: delayed 726 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2020 11:52:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586274775;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-ID:Subject:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=0Vm5jvdMMayd/AwXXhj00PE8ghMFHjy0GR5Lfh87NN4=;
        b=l4GJooe1P6ckza86t8onD0IM13cp0a0RIkOJk+fPoeoOHMIfotcZzApdq9CuETfm8s
        SuZnuEkIaxdAcV5Mrxy+Gm/oWJucLWKNOTYOWrHto6R0wrCCGKtmQd8CAHAfqVOxd6p0
        dW9RN92pbVApcPlHyF/AYs7PAoPqJ3RwVMqlpPlDgwVhO9t8tcBVOIbN3TKYZO48XjUb
        6riG7udOrvlSSXUZd/oa7H3GU7KTBccPKJZxU9zzx/M+yXJ7KnfHS+WJnsY9Tx3InOvK
        FZybhoAWhFXM14j8IKQKuAyWFI+8kCQGiHv9hPvblKZC+0fXKPJIZfedW51SAIJYbYRh
        f5Kg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS32kg"
X-RZG-CLASS-ID: mo00
Received: from aepfle.de
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id 204e5fw37Fenh96
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 7 Apr 2020 17:40:49 +0200 (CEST)
Date:   Tue, 7 Apr 2020 17:40:46 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: get_maintainer.pl sends bogus addresses to git send-email
Message-ID: <20200407154046.GA15368@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For me sending patches via git send-email fails because email address
conversion is failing. Something appends a ')' to x86/lkml@kernel.org.
I suspect the double '))' in MAINTAINERS is confusing the command.
I tried to send the trivial patch from v5.0 and v5.6 tag.

Is this a failure in ./scripts/get_maintainer.pl,
or is this something git does internally?
I'm sure others use such command on a daily basis, so likely something on
my end became broken at some point in the past.

Olaf

linux.git $ git send-email --reroll-count 1 --confirm=3Dalways --annotate -=
-to-cmd ./scripts/get_maintainer.pl  HEAD^

(mbox) Adding cc: Olaf Hering <olaf@aepfle.de> from line 'From: Olaf Hering=
 <olaf@aepfle.de>'
(body) Adding cc: Olaf Hering <olaf@aepfle.de> from line 'Signed-off-by: Ol=
af Hering <olaf@aepfle.de>'
(to-cmd) Adding to: "K. Y. Srinivasan" <kys@microsoft.com> from: './scripts=
/get_maintainer.pl'
(to-cmd) Adding to: Haiyang Zhang <haiyangz@microsoft.com> from: './scripts=
/get_maintainer.pl'
(to-cmd) Adding to: Stephen Hemminger <sthemmin@microsoft.com> from: './scr=
ipts/get_maintainer.pl'
(to-cmd) Adding to: Sasha Levin <sashal@kernel.org> from: './scripts/get_ma=
intainer.pl'
(to-cmd) Adding to: Thomas Gleixner <tglx@linutronix.de> from: './scripts/g=
et_maintainer.pl'
(to-cmd) Adding to: Ingo Molnar <mingo@redhat.com> from: './scripts/get_mai=
ntainer.pl'
(to-cmd) Adding to: Borislav Petkov <bp@alien8.de> from: './scripts/get_mai=
ntainer.pl'
(to-cmd) Adding to: "H. Peter Anvin" <hpa@zytor.com> from: './scripts/get_m=
aintainer.pl'
(to-cmd) Adding to: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND=
 64-BIT)) from: './scripts/get_maintainer.pl'
(to-cmd) Adding to: devel@linuxdriverproject.org (open list:Hyper-V CORE AN=
D DRIVERS) from: './scripts/get_maintainer.pl'
(to-cmd) Adding to: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTUR=
E (32-BIT AND 64-BIT)) from: './scripts/get_maintainer.pl'

=46rom: Olaf Hering <olaf@aepfle.de>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org) (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),
        devel@linuxdriverproject.org (open list:Hyper-V CORE AND DRIVERS),
        linux-kernel@vger.kernel.org) (open list:X86 ARCHITECTURE (32-BIT A=
ND 64-BIT)
Cc: Olaf Hering <olaf@aepfle.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
5.1.3 Invalid character in domain: <x86@kernel.org)>


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl6MnvkACgkQ86SN7mm1
DoBZWw//b1Rcjobavt7s5p1SIXjRUQLivHHKjVm7BgoPN30dtaltqRpZH/ngWUpz
et96oqNdh5ATkSmWvbg0V53H1zc6BNfovcDnQU7hfEYs4VP6jil1tiQg3nKgc63P
TXOnmuKQjOjzz1tSA40JEdB1CerNTVjAgpdHeNndv0fsxORjUownNPrTWNI+RWov
wLn4ZWCTIp9181fYuHsX+8qKpqPYUK7oM7BcAPBq/IlQU5g8+YAckwRCU2cCbm4y
DzUgYyUOyOpgxNfKKb2htcUwpwz77xFBmksiRsO1vY2i4QbU18josDdvqUeJZDJ1
dwVOOYtbDbKq2yYoJu/vPv/RVamlKy42vh4m03l6KOuh/ZxZxtcN4uGqPKFFyxzy
2zMx9RFautx+IcBE2ZJGPKeOycs1H9FdJSnUayFMBBuykaBj6/vnPUwR/jmNPkeP
rYn1A9ZHvbuTWyox1ed1QMrS/sVsbRTNGvWUoYVz/kH/Z3qPQWYtZ5vkRjk2AvHY
63baYKf7qAtTkS+95FCdrTc54kjNfFBetdn8vtw2AvspD3o+LHUklF/sVrVPhgPm
pXUoaW0q1u5yuof0xPOvNeeac0EYyPQgeoG52R9tZHBNCWf4TgJZj3hzVv6IldQk
5CV1nn9TSzjYEtkuVwM0eZdsVuhh9EfbmoLmWY8x/NjcCcIRQaU=
=r0nd
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
