Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D31C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiLBBDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiLBBDC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:03:02 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FD4C4CC0
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669942975; bh=TGuAZDdzHTKqr3OKBPPa+TY7s+tinUBI2YecH+1IXRQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kw18+kpgwAg0f510Z+ZezYhn+AESrOW5jX4yMfQdUt1XhXpe3WUvo3jfrsxBk5xys
         MUB/t3WBmDGdN5tNugshfnzbRQCHsaoQOQld2tNo8iOTjIFzJBueDCR/C9dkTQNBKz
         LR0hCB6sMyGDJVFUmFrzrsnVRJrzcaOq8e1cgZ9VE+pnDxQmvHH128X5LImsbX+n7j
         rS+GbpOob3LGF8rrfkMpqHfoROByHlRjOIzML09I7fMBVQIyjWizXL6keBgRCxQTRZ
         HDaUhlhnI939POmAiqY0uKB3otNZ/tqWR+Np7hcCD2gEkeqU4f3tNh9+Vkg5WnOdFE
         Qn8HbTfhLXLiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5fb-1pUIt81vRN-00YMmQ; Fri, 02
 Dec 2022 02:02:55 +0100
Message-ID: <02ead668-5b5d-877c-1e40-3656fd85945f@web.de>
Date:   Fri, 2 Dec 2022 02:02:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/8] auto-crlf tests: check "git checkout" exit code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-2.8-345a667d5bb-20221202T000227Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v2-2.8-345a667d5bb-20221202T000227Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TEwjmxoj5Gf34ovolsPI4ZHN4eRxoJWApqhJu14/9BNjRmt5M/D
 rdeWYRfHbqjKmnSHr6tB627WkODSUn9Jxucv8CysISXbzr7AEAqL019DPqOuDqDQ/3LYnR9
 RyaW3m53ZebSxW31/uwBoALzf2fpS9h4gyoB2BV3lP2Q/3Nll0EY2xGKHVp02v4hEEEewZ3
 qqeDhuXQqgucYNfVftydQ==
UI-OutboundReport: notjunk:1;M01:P0:5mokQdi3Dd4=;cjSvuE5P2lTl5ZuohRRHNqrYFOg
 JUFw9F4vsjdQLIl8fQKXFezrGJhSNjcR3qmave+htecBD1jOivqTp87r4os2dEYDA1uH0lUuv
 Yp04S3uX6RNJqcEanAdklrPXsWKx0My759kQITed3+BX5Lq8iYfp3y09AiPWE2jfTM1Sc3ctK
 woAd19vCS5f0/bf/qn6L0+JGmS1Xv1ynmcAu9m9DGHTGFC1MvANAs+r+QiPLGsMS4VWtY8MXY
 v+KYUVHvjkJ/rIJ6bg8SZMR2l8+PW3VxHNU93Axf0HoLJEIgnaLiSIqQfUZ4MPLuRJirM700S
 WKqvPEbSWc3ErLYYmkXW2K+VIS3iQX+Udw/RmTnX3fJHfgNpmyhCADCfBhHRTfaTW5jHwoS2/
 gPOjlfDNZ+bnZ/6CT4triJ/TTb+YsW7QMaUi9PNOvrny9TR7JTMcr6xF1qiVWzN+w1DQYe5fd
 /otPLsgFXRt/WV04CkmvD5U9XO9ovbd36ab/QCzKYfczWxeEiVhI80fiFza/6mqpXTnlqxgzv
 YbfTy+WXT1bUn+P2lp1KJxzqjY6iQsTjb6q9ALsB9BMGXYf1EuRRzVk2m4/iIXhlyECqS+zZ5
 ImZCrfQH1L5Ok6YyrkNxWGOpfE5Pa43IrXHZGvmvU5M1cCAqNPvHUjMLH7PBcnlch1oLPMtPn
 Ai7lgWDyWepEeD1PO8pE/k3EacrL9F7vRTwPqtMTncRCpP30omDAnD+EOrYYTCXIQOAiJrh2b
 vUbzw1eVMY1fjpgn6+oi3Ja715GjnphNOAWSZAG258MVp/wAelEt+CY+JfjUy6Vr49LPk9szZ
 +6r1OIHqc6qXenFr7BBFPA9/D3vxLa/1Wcd3BI/vfN7Icpd5nRViN0Qj7qHPi4kChemChYq+g
 ZweYlLZrMq+eopQtrnMeH4kiMN7WHDIlUZVXs5nQZzb0YiUxQiaTh6ESRuPtceoyL4TyYV7kT
 idvzQdiihFHjTpcTVvODBKUKgc0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.2022 um 01:06 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Don't hide the exit code from the "git checkout" we run to checkout
> our attributes file.
>
> This fixes cases where we'd have e.g. missed memory leaks under
> SANITIZE=3Dleak, this code doesn't leak (the relevant "git checkout"
> leak has been fixed), but in a past version of git we'd continue past
> this failure under SANITIZE=3Dleak when these invocations had errored
> out, even under "--immediate".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t0027-auto-crlf.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index a94ac1eae37..574344a99db 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -294,11 +294,17 @@ checkout_files () {
>  	pfx=3Deol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
>  	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
>  	do
> -		rm crlf_false_attr__$f.txt &&
> -		if test -z "$ceol"; then
> -			git checkout -- crlf_false_attr__$f.txt
> +		if test -z "$ceol"
> +		then
> +			test_expect_success "setup $f checkout" '
> +				rm crlf_false_attr__$f.txt &&
> +				git checkout -- crlf_false_attr__$f.txt
> +			'
>  		else
> -			git -c core.eol=3D$ceol checkout -- crlf_false_attr__$f.txt
> +			test_expect_success "setup $f checkout with core.eol=3D$ceol" '
> +				rm crlf_false_attr__$f.txt &&
> +				git -c core.eol=3D$ceol checkout -- crlf_false_attr__$f.txt
> +			'

That adds five test_expect_success calls.  Wouldn't one suffice, for the
whole for loop, and a "|| return 1"?

One line above the context there's a "git config" call that should also
be covered, right?

Side note: The checkout commands only differ in their -c parameter.
They could be unified like this, which might simplify handling their
return code:

	git ${ceol:+-c core.eol=3D$ceol} checkout -- crlf_false_attr__$f.txt

>  		fi
>  	done
>
