Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61839C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B086102A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhHQV30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:29:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:57969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234899AbhHQV3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 17:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629235722;
        bh=ibC8nwiyysc9Xhyl7IWfPGN43jmL1uq70brQ7GSmKHU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AkyT8kSm5UaDEM7V1uHUtHW8B6yS2BT6UJs27yNlWDIsS3gPqDbp7BUmYoBGduOC/
         sjQv4r8ZExBnGaKIqLFiVYKB8gGO4y6YYZn7U+bW6cCPNWIu7P2vYRyDdKuTPnwUDM
         vSRPl86wilUx51dSaOw2SVq7umTTTsTg+VTX/5bY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1mpRSD3h3o-00ZNz2; Tue, 17
 Aug 2021 23:28:41 +0200
Date:   Tue, 17 Aug 2021 23:28:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] make: add install-strip target
In-Reply-To: <20210817110728.55842-1-bagasdotme@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet>
References: <20210817110728.55842-1-bagasdotme@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ofY2gT0i4pyijnwj9Ie4REqUqK7FDyYmNefLTcJ12sRR/m9MZGz
 w6gV1c1Vv34asPh69sFuiUW8ASElAzcRsnQTkF+thhyQ55qzsQgU8A/F9kr3RspIjUYDcjB
 2M3A0f6BZID9XGQWDlyYtVknMx1T3DeXV1Kzow8if+swK1jTY/uPkt7dpPvZZwZZYV/cJHW
 f4sYEPCvgM8ctR6/Dlslg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+jbrdgFaX5g=:JEShboDsQwMa7Pu3B1LYEd
 G/zbOLfqVXP1MKdNA8Qw/3vXVxcFm4MF/s4HaJ2NoC4c5SEeiRCNBUVtv0fwQtSh916DwfaYt
 +7rT88MsRLmWgaxLchk/8JtiQgn8aMRoPNp5AFErIUYyTye9KOCwGEPpuVvOGfUlym/TKrscq
 rTFsNui154XUOceG/BhZqHK98Ys/1P/fklO9vI4a5i9AzjsmXO/MXq4F6l7J/PkmNl+d9IGqu
 2PrkZT+3Ef7pVVmwyCEglHKTUTontcI7a2e6zep6IFjrf6Yb2L5VGm9RKPhs1nrwJtVqtb63P
 jDnNLWxJWtSa4OaZ7JOoWQrIV6MGW05TVfzhwO7etgfa2vdff7ViS9CTaoRJTeALiHdDZw4HY
 zd55z7sHaqJFfnCcB9jq7dfq9vclXZnVgvD0ozQbNo/1VMQaUqCvSVMRTNeWt/b/xAvNwZfeT
 kJesoyWNVyumYdeAj0GViiUXVPep1tfpfW7P3DjT883guZ3+u57WOgx+rs36XNl2yhOshzuMJ
 Whzt/qUIaCoXueVsEX+jNYJcWXUFPpPn3XKV+st0Bi+WVY5daA5WpfV6AGx77lbfgaV0V6j05
 4xAQYyMWXTrl2TPK7xMeDjniBGZK7e5/3RUiFlsvNbv2eHkAG5dYvTsvObyhx6MzhLoXUd6fl
 ePnZRTo+XeapPsP4DzfOTDYrp2d7LOA7BroVfpVMF332uOTLvTpuvyi5dXTH3fgMvNGBxZgDy
 fD81RhjhgTQbB7NJTCkEfVRtRmD3gLju+vOUj1ih2LCr8h//XzeONSbJZ1yhcyCmQkICSumV9
 itthfeaXHqj8RzlPcWutdGbyvJ9ZeFvH2hlfoc4rq4Iz7/SaVqkVPi+q+f8uyDAhwr6gFkQVQ
 TacjR8K0fPrg+8OSgdWkNfT3W5ZWcBsh0/7TFrbAUcLk4WBytlq5AzCK10fIcGhzT2/Xi/W3w
 JSb2mUfkNkSdSl8ks81CGxxu5WSKEz9Bo70gVtVahGBR9CM4dyRbxXX2lQ+v8i/trYdOXInfo
 Mn23zFH78KSp1HffQP88AC6N6248iDpwiZtsGTiqfIr9ntwiKI1yH0t6yNQSgzQqlrCbIJTsz
 clAeHR2goR+wDph45fV+KQK0WVPYWB9hLyOBjlJ1l9BC+7SRRZDovMrJg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Tue, 17 Aug 2021, Bagas Sanjaya wrote:

> diff --git a/Makefile b/Makefile
> index 9573190f1d..8c4633ba8e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3093,6 +3093,9 @@ endif
>  	done && \
>  	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
>
> +install-strip: all strip

Would those `all` and `strip` targets interfere with one another if `make
-j2` was called? If not, wouldn't it be sufficient to let `install-strip`
depend on `strip` alone?

Ciao,
Dscho

> +	$(MAKE) install
> +
>  .PHONY: install-gitweb install-doc install-man install-man-perl install=
-html install-info install-pdf
>  .PHONY: quick-install-doc quick-install-man quick-install-html
>  install-gitweb:
> @@ -3265,7 +3268,7 @@ ifdef MSVC
>  	$(RM) compat/vcbuild/MSVC-DEFS-GEN
>  endif
>
> -.PHONY: all install profile-clean cocciclean clean strip
> +.PHONY: all install install-strip profile-clean cocciclean clean strip
>  .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern=
_shell
>  .PHONY: FORCE cscope
>
>
> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
> --
> 2.25.1
>
>
