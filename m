Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394671F597
	for <e@80x24.org>; Thu, 19 Jul 2018 15:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbeGSPyJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 11:54:09 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44143 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeGSPyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 11:54:08 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so3179035ywm.11
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8dqxKShrC1liTP7mzKRiDAY4VvQcHSP0nnvh1wZo8A=;
        b=0FHjmbvgze8+JDoy+mF9hdNb3zC6PZRazCGgV5IXA/Sn0JJpqBWlAgRa5rvCXT2POx
         6iO5GG7ehuxtX8fTFPsjfXrxmrM+rBogYVgSYx8y8bw7/bwytNbLZRRfDMyAU984NG3r
         ISSMwhSHnv1kMyHkKxQNid+21os9P67ujbH0pHDct0sZuR3bW5b9yI4Y0WjKtijwn7m2
         b3IFZU801cARy5q9bwv1c/pEvCLZDNBGemQTgmmBrAzxACjWHiQcHyb8t/XWpxLJbPTH
         +R/vcmMY+TOL7GwecKGK3P6gUd/HieXRVQnBraurTYykGltGXGw6jfnTwr1ufKEJtby5
         vAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8dqxKShrC1liTP7mzKRiDAY4VvQcHSP0nnvh1wZo8A=;
        b=KQFP2xEiIbWvTMnTmBlrM7j6tA2OEs/WUNYhmspElNI2T/UOYwJu07kQy3J3WRUXXK
         eXKwqhaMfs9PCGInoNguSqpKJNzDgUkm1890YmZOIY52FfD8xykt4cOdsVSaqs52Aljp
         SaMtArs+DwfKosrzp/5Mor4aj1BeoT/URmo4feePP2kiENGNhIpaOhvHv9LcU/9F9THk
         v+f3CMsyNvqbKBjJydq+fJ4Ar8BgKfKYBTgt6jIWjujmUsmgCk0+clTQOnnJx2fn9mgP
         hbGmrpxFLAo8gff7TL3SvqulVdRQy8Pjv/moFCMVbaE7W2aGI9rprYQVmoKdtcwwtSd9
         ftvQ==
X-Gm-Message-State: AOUpUlHcGJExIHtfXFCp+cfYP2yC+XnPItBcbCKNqc9D88bjpDKMnFS9
        qjNS9wTQoco8E2kt18HnL6fa4g==
X-Google-Smtp-Source: AAOMgpfxu9mbHOOLCyBd+1CviSqywoOW4isOqT8wUYd5DtSs37DCYmuKn12NLWZZGHcU6O5dY7Antg==
X-Received: by 2002:a81:f208:: with SMTP id i8-v6mr5290611ywm.72.1532013031295;
        Thu, 19 Jul 2018 08:10:31 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id e22-v6sm3174912ywe.37.2018.07.19.08.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:10:29 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 19 Jul 2018 10:10:28 -0500
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t/t5534: do not unset GIT_COMMITTER_EMAIL for other tests
Message-ID: <20180719151028.GA35774@syl.attlocal.net>
References: <xmqqbmb4lbhh.fsf@gitster-ct.c.googlers.com>
 <20180719121409.6143-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719121409.6143-1-henning.schild@siemens.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 02:14:09PM +0200, Henning Schild wrote:
> Unsetting the varibale for good can have unwanted effects for new

s/varibale/variable

> tests added in the future It also meant we needed to hardcode the

s/future/&.

> value for "user.signingkey".
> Move the unset into a subshell, get rid of the hardcoded
> "committer@example.com", and switch the GPG variant to using test_config
> just like GPGSM.

OK, sounds good.

> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  t/t5534-push-signed.sh | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 0cb88aa6f..f6d674156 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -194,10 +194,12 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
>
>  	EOF
>
> -	unset GIT_COMMITTER_EMAIL &&
> -	git config user.email hasnokey@nowhere.com &&
> -	test_must_fail git push --signed dst noop ff +noff &&
> -	git config user.signingkey committer@example.com &&
> +	test_config user.email hasnokey@nowhere.com &&
> +	(
> +		unset GIT_COMMITTER_EMAIL &&
> +		test_must_fail git push --signed dst noop ff +noff
> +	) &&
> +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
>  	git push --signed dst noop ff +noff &&

I think replacing the 'git config' invocations with their 'test_config'
equivalents in its own patch would be easier to grok, but I don't think
that splitting the change out is worth a re-roll on its own.

>  	(
> @@ -241,11 +243,14 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
>  	E_O_F
>
>  	EOF
> -	unset GIT_COMMITTER_EMAIL &&
> +

Nit; remove this newline.

>  	test_config user.email hasnokey@nowhere.com &&
>  	test_config user.signingkey "" &&
> -	test_must_fail git push --signed dst noop ff +noff &&
> -	test_config user.signingkey committer@example.com &&
> +	(
> +		unset GIT_COMMITTER_EMAIL &&
> +		test_must_fail git push --signed dst noop ff +noff
> +	) &&
> +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
>  	git push --signed dst noop ff +noff &&

Looks good.

>  	(
> --
> 2.16.4

Thanks,
Taylor
