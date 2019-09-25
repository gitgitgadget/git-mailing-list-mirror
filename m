Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E07C61F463
	for <e@80x24.org>; Wed, 25 Sep 2019 15:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbfIYPjT (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 11:39:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:49007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbfIYPjT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 11:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569425950;
        bh=zMpn5R7u9QhPh3FjOlbLQ72XEw+619/8v4ZokgOR1kE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R790QqRBFbU49vN7iXmbVj5Qvo1NEwb3Ib5BQeAccRCXebbBB++XVrerW4n2QHQMA
         jPwGPI4nGeTrxA1QPhsy0HanZAfiWhRROMMpD8jhhStkBbesh3M1WhGMYXU9i9cfQq
         gUGQhdi5+rAlZwIzZXOduC38KB4enRSe8j8xoAr8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1hbbhm0Q8m-00barU; Wed, 25
 Sep 2019 17:39:10 +0200
Date:   Wed, 25 Sep 2019 17:38:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kunal Tyagi via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kunal Tyagi <tyagi.kunal@live.com>
Subject: Re: [PATCH 1/1] git-add--interactive.perl: Add progress counter in
 the prompt
In-Reply-To: <8edf23f816dc0546fb3b5812573d7a759184206b.1569223612.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909251736190.15067@tvgsbejvaqbjf.bet>
References: <pull.349.git.gitgitgadget@gmail.com> <8edf23f816dc0546fb3b5812573d7a759184206b.1569223612.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OGZgsqPyB9sG16A7aQ8FHkY5qucdZNBagBuu6mrTbqwvEXH2lSz
 SPA3C/WU6IwWyu7zbUHvmNl6iGtRTmsiz+dS9eRjUflSCwPw5DgwOdi34z8NT2QwRT/9vVA
 Fswms3nB2MzJV2EwAEzOZqkfJhEwAePv/zNASlaaBTEX3vnQlM6Y/gE852MOL+sZZSbQhao
 qyb+hLV3v+d88WmrExLfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XSVQ3xpzB40=:eIBGA9r+usblv9WmwDT1ro
 jAIeTbUHzSw2VmWwQf3LDfJcQ2eHr+18Hyx8rPs9+wcBLR0OWoK+MgBpV7/HRS7X+QPpGrArC
 cGZog0sqfenXRMuV+tib1E+HGVzCgl6kju8o9KTNm+rwfOll6i2QBgK4rs8HHBLvTVVGh505Z
 Q0aVYpYeER+4xehSXtoA72nHjcfKA9VICLVSGU5yKCGzmF/stlsyF2DUAvdRf56DP16E+nhBM
 OSBRDkRaWhTNcU4TJjJmsN/fBqgYi+tfUQMKT1K3t+wWniY7MsGUeF9sOJ5JXn5u+sU1wyzlQ
 Hossg+owFgaBIyjqKvaREuQ4lXNel4RdT2A0TXL54LCg2qbm37frHOZYOMVCbY39+YVJJ4+Ds
 uSyt4glnWHSshwjsyVomrzA9Tn0DqR/Cj6mzCItEv4wgA/vHUvkgbxO1dJrbCwbKPKAwepeLS
 joAiPYEm8lghc1GJOCfKgunUnMK7eKSwepm+v3jZyProWemOpHSo6tsgjjEFOl4MUBXkp00n4
 b3w3am6C6+PM4ZvzLxdyd7Cxcqf9sR9iprDfb0eaTj0ZiV+Vs3VIvcpzccKcxkk52Kd9UKb6q
 DL7dIeu1+/E6F89iMdwd0ODd2ZcRvSL/xr3X3s8Dfj3gRPdo2wpSjNrN24nrsMFZMrjtoszEw
 K1ToX1jMAcdffVpu6bCxKqygc+ZPRTjTlL2SIm0twpzVGGPWYk2B/7qrTJjPKzpYil3EDaOQE
 pHuPUSezxuQhXJJmOdBGQbVKdRJa2qYDeq5HPTZRLlihgom8eeJSjgOk9qBOf5DVjwfJeD5To
 y9KaFR6sdiGyPCDy6CWKCeojKI8F1IJgQG1wOWiP6yt5Cdb22YS4FTVVuVYVnrdmAS+TIj70k
 89UGgYLBLfuuBe+ToQvcOSaVbW5RgaIl6OZlkjEKRTe0E7Cpdf7YZA7Jz134XLp/8KJTGECQw
 nHvz6QOjDDxvBnfCTd5TaLEwcGX9sgNwOGvYG78X+e66IW/qctJcvR1DSAVRkl4VKsSpeGCaX
 a6LUFOgMJWx9I9690uWs8MGXJbreWIyfxAIh4qv+fqUE5+ZbcNDv/p1bZ23ZWz+wAtOPCSQgq
 rdb0xTtnByf4XXEQZtvxNViAhrG87i2WnDwIRnMXKY40fwlA5v4YgyOYF72YL2TN2jRUZ04Tr
 rsffR5/qjGvPXPs6Pg2sT8xsvz+r+lK0V658Sdiyvdr/isD0JPuOwvNwmZ2h1bHq0a9VUzIl2
 lWSNPPZig9UaIW/4m2zHgZYY0TlGWsmjZwY8mHCqv23cg5RoPW9keXOqQUsc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 23 Sep 2019, Kunal Tyagi via GitGitGadget wrote:

> From: Kunal Tyagi <tyagi.kunal@live.com>
>
> Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>

Could you move most (if not all) of the explanation from the cover
letter (read: the PR description) into the commit message?

The patch looks good, I just have one suggestion:

> ---
>  git-add--interactive.perl  | 2 +-
>  t/t3701-add-interactive.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index c20ae9e210..3951c25a28 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1541,7 +1541,7 @@ sub patch_update_file {
>  		for (@{$hunk[$ix]{DISPLAY}}) {
>  			print;
>  		}
> -		print colored $prompt_color,
> +		print colored $prompt_color,"(", $ix+1, "/$num) ",

It would probably make sense to use `.` rather than `,`, the dot is the
concatenation operator in Perl.

Thanks,
Johannes

>  			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}=
), $other);
>
>  		my $line =3D prompt_single_character;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 69991a3168..3a2d9fb607 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -314,7 +314,7 @@ test_expect_success C_LOCALE_OUTPUT 'add first line =
works' '
>  	git commit -am "clear local changes" &&
>  	git apply patch &&
>  	printf "%s\n" s y y | git add -p file 2>error |
> -		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
> +		sed -n -e "s/^(.*) Stage this hunk[^@]*\(@@ .*\)/\1/" \
>  		       -e "/^[-+@ \\\\]"/p  >output &&
>  	test_must_be_empty error &&
>  	git diff --cached >diff &&
> --
> gitgitgadget
>
