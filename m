Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23D21FD09
	for <e@80x24.org>; Sun, 28 May 2017 17:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750823AbdE1Rde (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 13:33:34 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37384 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdE1Rdd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 13:33:33 -0400
Received: by mail-it0-f42.google.com with SMTP id g126so17487447ith.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1tkf9SWFnfrmaz6dgoqkBkbG6dJgChGjDRriaRDFnMc=;
        b=LrLVUTCLSAf8N7YZAYeoIPCw+i5AtpF8giA0pc0ohDemzXq7l5IXBl7v5oiZwdUjlm
         srCNs23sXRTWiNttzEyqhC+oCismSUTdvqdQDRw2NtoqqBSJ29Lq86XFBGPoVWKgLugZ
         bspvqd5yP2Pj+IFws3PXS0Kn/VZLV22HlSCb3z+Vxkl7nbfn+Cj9D0aKKwaXJYee1Tv/
         ybbQpBWTQeWi8p2cH9vhjXJiBxA8IKXxYkMfZm4i+Ues0j/kgUWj6tJiRmUwPunRvMqO
         G9G6+mHleChJcdNjc8UnCdyio1s0DGtC9EaaWpHmBuphK8reToROVMvwbFZ5WZN9PXbG
         C5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1tkf9SWFnfrmaz6dgoqkBkbG6dJgChGjDRriaRDFnMc=;
        b=crKdRrGWBLNvTVpj3ptomBTGoYZ37ggWE/xMX9Wyw3/SFrULZ0xW3sFNwOXw9t4giZ
         nCGMtmYUBuauZnhBkGBy1LN75N9fjLYZmJWGsD/iEnTM0VEv8CrV+HIMdxqJgTSxNGMj
         lUquLs6AKh4pwPDwcxWj9x00W93xeBLJI/FlOFGZT4FHEHvEzJHtQTwzcWARVLjkIg1e
         yFp+5xZPIAaIj/UBiMmAc4557d9v4nId4m0LqpNiSw0ZhrqI9wdlMrAxLIGaC99zBAqp
         dQIEyH0e8DY/KYYaxzlhVhHEO8sx1cxf8ydvhrLrgY7OWy9/pXXqoFt7/zsm70fvSnwZ
         8NFw==
X-Gm-Message-State: AODbwcAPAI3HhbrRLNQi1cNKvKoarii5Cf6+dMiZNEgmT9Vxqz9/SxnT
        S1zDtKGsKD2auMTb/uiHJQohoe/AQg==
X-Received: by 10.36.29.150 with SMTP id 144mr4868275itj.71.1495992812403;
 Sun, 28 May 2017 10:33:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 10:33:11 -0700 (PDT)
In-Reply-To: <1495991536-71204-1-git-send-email-sahildua2305@gmail.com>
References: <1495991536-71204-1-git-send-email-sahildua2305@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 19:33:11 +0200
Message-ID: <CACBZZX7J4xjw0ThSrQ-kG+KGiePZ-8vXET4cHEBOUFL8ydwE9A@mail.gmail.com>
Subject: Re: [PATCH] branch test: fix invalid config key access
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 7:12 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
> Fixes the test by changing "branch.s/s/dummy" to "branch.s/s.dummy" which is
> the right way of accessing config key "branch.s/s.dummy". Purpose of
> this test is to confirm that this key doesn't exist after the branch
> "s/s" has been renamed to "s".
>
> Earlier it was trying to access invalid config key and hence was getting
> an error. However, this wasn't caught because we were expecting the
> command to fail for other reason as mentioned above.

Looks obviously correct to me. Added by Johannes in commit dc81c58cd6
("git-branch: rename config vars branch.<branch>.*, too", 2006-12-16),
CC-ing him in case he has anything to say about it, but just looks
like a typo back in 2006.

> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> ---
>  t/t3200-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index fe62e7c..10f8f02 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -338,7 +338,7 @@ test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
>
>  test_expect_success 'config information was renamed, too' '
>         test $(git config branch.s.dummy) = Hello &&
> -       test_must_fail git config branch.s/s/dummy
> +       test_must_fail git config branch.s/s.dummy
>  '
>
>  test_expect_success 'deleting a symref' '
> --
> 2.7.4 (Apple Git-66)
>
