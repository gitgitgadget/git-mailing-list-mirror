Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12461FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 11:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756295AbdD1Lpe (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 07:45:34 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33886 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755232AbdD1Lpc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 07:45:32 -0400
Received: by mail-io0-f178.google.com with SMTP id a103so58965099ioj.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fQi/R+7AH9XRWKgkvJpxYraUBmQAMRhJdNOikLCmQEU=;
        b=cGtCr0Z/uKXlfksW6wkMTukC9I9T9XxofDMqqTwQrA9m8SotswrXzy4scbLVn4+cvq
         ekirpr+E6/5oiNX7gpOSM5OLIWNGIMxYxHoyJYfMlwk+/YFnup7LBCRzrUU4gI2j4j8H
         PmcSizowS6KlYtFvSh9JA2xgQtCGQzS06ba1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fQi/R+7AH9XRWKgkvJpxYraUBmQAMRhJdNOikLCmQEU=;
        b=QdzssaIsLLfAzvssSnYAr7B3YlQOLmXab9o3aPYnWBR5Cu64miEwLfGfHMkGD5fUn1
         vzOB0biTB+TVx1WD1/sn0rgmL/B+NMi6WBylnAsWk1tdhdVko8LbRkLcSbMY95Ip4W0h
         eOazcZrBpK5j1+fD3L9NC7CML3E0AP8h3HPqMFPFB03XRhHStBlF0V89v7t3PNXOd0XT
         7XW4JsCluCJWAW/qwszAu78u1/2oPSuKq9QkUV+xlgs9ggUIWf5l3NhA5ju9hPSk8n1P
         alJ9uyjulwUvXU0CfxP/V4dIYroTY/UUrpLo+0XLLda5mM7jkFB+5h/xT/0htPGeaQaB
         T+HA==
X-Gm-Message-State: AN3rC/68ZT1vLsdnpZcYZJ/rfjS6xFjk4KAZ9tC0GBTgtAf7247nvFpW
        v5dDxDvyfl+IfbyOFywKxF7T3FOY3g==
X-Received: by 10.107.168.230 with SMTP id e99mr10754859ioj.23.1493379929046;
 Fri, 28 Apr 2017 04:45:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.46.16 with HTTP; Fri, 28 Apr 2017 04:44:48 -0700 (PDT)
In-Reply-To: <bf7db655-d90f-e711-afc8-6565b71373d2@ramsayjones.plus.com>
References: <bf7db655-d90f-e711-afc8-6565b71373d2@ramsayjones.plus.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 28 Apr 2017 12:44:48 +0100
Message-ID: <CA+kUOanMdez0Gu1z=bULMm0vMnFx8p12nt-e7v5LvyAiLu_45Q@mail.gmail.com>
Subject: Re: git v2.13.0-rc0 test failures on cygwin
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Devin Lehmacher <lehmacdj@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 April 2017 at 15:44, Ramsay Jones wrote:
> [Adam, if you are no longer the git package maintainer for cygwin, then
> please ignore this email and sorry for the noise!]

I am still the Cygwin Git package maintainer; I've been quiet of late
because of personal health issues, but I'm now picking things back up
again.

> Test Summary Report
> -------------------
> t0301-credential-cache.sh                        (Wstat: 256 Tests: 29 Failed: 6)
>   Failed tests:  12, 24-28
>   Non-zero exit status: 1

Confirmed I'm seeing this on v2.13.0-rc1, and this passed in v2.12.2.
`git bisect` tells me this failure was introduced by commit
v2.12.0-267-g612c49e94, added by Devin Lehmacher (added to the CC
list).

> t8010-cat-file-filters.sh                        (Wstat: 256 Tests: 8 Failed: 1)
>   Failed test:  8
>   Non-zero exit status: 1
> Files=780, Tests=14700, 10398 wallclock secs ( 1.27 usr  0.78 sys + 1265.08 cusr 4076.38 csys = 5343.50 CPU)
> Result: FAIL
> make[1]: *** [Makefile:45: prove] Error 1
> make[1]: Leaving directory '/home/ramsay/git/t'
> make: *** [Makefile:2313: test] Error 2

I also see this failure; `git bisect` tells me it was introduced by
v2.10.0-rc1-4-g321459439, added by Johannes Schindelin.

> I'm not sure how to proceed from here. (I don't know if it is even possible
> to 'downgrade' my cygwin installation in order to confirm that the current
> git-cat-file would work with the 2.7.0-1 version of the cygwin dll).

I believe (although I've never done it myself) you can get old
versions of Cygwin packages via the Cygwin Time Machine at
http://www.crouchingtigerhiddenfruitbat.org/Cygwin/timemachine.html.

I'm sufficiently over-committed at the moment that I'm unlikely to be
able to spend time investigating these problems myself, but I'm happy
to test patches &c on my local installation if that would be valuable.

Adam
