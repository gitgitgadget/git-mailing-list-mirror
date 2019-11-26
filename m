Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0495DC432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08912064B
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 22:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JXfammIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKZWQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:16:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:50057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZWQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 17:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574806566;
        bh=9QDUi4tU+xbYnJC2R1Jlk9PD4/YoVX1rszy4o93NywY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JXfammIxXMAMt9HlLlHTUzsquAOGC+mBUyzRLv1KoZ36+kEPdUwbr7QDNs7LwK315
         fbNUx7sNQGEG4LIOfK+e5VSodLffsQ4Uf5zTLuWH2Mnhp81deZ2L9YYF05TZEL2yef
         7U9OTMIRmrfb2j1AL6pgA3qQw/RJH/TI9/Q6hkDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1iREwv2b7j-00RG6h; Tue, 26
 Nov 2019 23:16:06 +0100
Date:   Tue, 26 Nov 2019 23:15:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1410: use test_line_count
In-Reply-To: <5b872979-b29d-b120-870d-1cac807363ed@web.de>
Message-ID: <nycvar.QRO.7.76.6.1911262315330.31080@tvgsbejvaqbjf.bet>
References: <5b872979-b29d-b120-870d-1cac807363ed@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1211720713-1574806566=:31080"
X-Provags-ID: V03:K1:7k+EUAz5Rs0BNiqZiC5KOCTJiqkpVgLSF5SlliOpYCBhkbc2ueX
 BiBIsBhGqu7VmySLMsmAmLjFx0k07s8R2FiJGhBuyaAtvuB14U80xFSN6qyipiGWWxhe9WN
 88dXUngNxQj5mVmvt3yA4nPTBbfdkHzKzadWT/hTHWssOiz6WJvV5HLRjDxZydX/L5uDL9z
 9ncfkV3/g2EFHOsyqvWoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8r8klv5wmo4=:yiVAL9YQXnzlP1Qaqv7e7w
 bq0jDZID9XbMgTFVzxqjJJPSgZcIj2rHflk2kj8kTk9ITfmhEp1zfQ9EXlYyAUbtbPgRq2/eY
 9D9+of1G1SQppou3LVzOMKD1ZmkU89MfjOROIBk6lIqxLLQ8JTVJziUagXEUMX+M9oJG+Q3XK
 cyKxfAb5etzKYazpQHR2XDX+M2s3w44ajM24aDOdqEmOgdOifDs6nhStb81oMxTkYuttMM7uL
 SI0Ukp16kEMT8aMML0x2xo8lcx+nUz+hCIxZu4fXbMX3rXIkNpqH0nVF/H2tZE3H63DgywWaY
 HhIjXL0ZS7NxLl6aqmuD8TUo4dmIPayw8MzKFJ1owal3F1zvVzHLRxFFm2QRIz+4LxSRngQY+
 WeX/WYY7j0IiYJBqZBTacRtl59NKwBSWMjeDjLpUK5xGsml3MLjDFzBkqHahTntMXNSnC1lQ8
 eywXDubx6qH8xPa8kwG8W14r/5WVSDVNZflBc3wqSrKz60wrdEDa6o2ioqJt6rmejbnda8RTs
 SYJr46QWXavhoNLFR9FHROWU03tTQt+M1J7aqbrmx0fYi1XgRO8bb1cUj08luhYHDr+AOpd2m
 GRNcyxqMmgBLdncrUoXhGpnSlw66qXDrbZ4slFXeq9Q0i8QelpQlUbyCAXpDlF+WdAAGZPWrc
 /6BWRjz0lX59QPZHpdWovIxhSuGd+9vPeerq/c03nn3o6GHyGDkUlc2URZszjOzF2NK9QvDim
 /oDvHI522jrp8jTKVwPfBjYSiGzTha4gShX6UbLwWXdIGuDustz/7d/2VORDJQuqgMW/SZ2vH
 a4tQTmZ1kw/1Fp2cLx3PPtVkvWWXWk+Q81fcE4qp2ZCzw8vhId9FS/C4ZZPjhJuw/6C2/KrpK
 /uIJrjCsbO/+o0y82QCpMU5Mf/kQhG/WZp5mEodPacY5MB7MCUZ6AFLf8Zv5EkRbvU1roUc8l
 HbXHvbssE+KsfVlgktd+Iw8Iu1vI9dAMycrtHjgFeQsUgccXHkP/sAl5FcEjC+JH2pHXe70ee
 b4E0fDI99CKWkzY2yMbjedSwUSIi9/dY54Jzgd5nHBUwFo1QpK6cowlJGej8Xo9TVcVHze6zO
 fPHTKR7mzUGWj8/brK0H3z0dVge3LjjQIvnpZ2LY++uKfMshFUPABgYH8lScsiTvmAtDLq07u
 d43dLW9GuXL1k8Ukjf27rgEe1dflFuAUpVdzD55+jsy1qbiWgAx3Vtoi5F2X/L7/LCTT7Ng9V
 6EBiAhibjLrVmAJpEbkMhjYLsrKKti7Duvb7iKzwNJ8F/dKDumSIjSE41Mt4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1211720713-1574806566=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Tue, 26 Nov 2019, Ren=C3=A9 Scharfe wrote:

> Use test_line_count to check if the number of lines matches
> expectations, for improved consistency and nicer debug output.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

ACK!

Thanks,
Dscho

> ---
>  t/t1410-reflog.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 82950c0282..76d9b744a6 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -195,7 +195,7 @@ test_expect_success 'delete' '
>
>  	git reflog delete master@{1} &&
>  	git reflog show master > output &&
> -	test $(($master_entry_count - 1)) =3D $(wc -l < output) &&
> +	test_line_count =3D $(($master_entry_count - 1)) output &&
>  	test $HEAD_entry_count =3D $(git reflog | wc -l) &&
>  	! grep ox < output &&
>
> @@ -209,7 +209,7 @@ test_expect_success 'delete' '
>
>  	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
>  	git reflog show master > output &&
> -	test $(($master_entry_count - 1)) =3D $(wc -l < output) &&
> +	test_line_count =3D $(($master_entry_count - 1)) output &&
>  	! grep dragon < output
>
>  '
> --
> 2.24.0
>

--8323328-1211720713-1574806566=:31080--
