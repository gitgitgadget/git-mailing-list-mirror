Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C560F207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdEET1O (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:27:14 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35463 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdEET1O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:27:14 -0400
Received: by mail-io0-f173.google.com with SMTP id f102so20063638ioi.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bEfkoFPsxdzt2Ed9kBh/IXje0/8XPxJXaxh3sAd39WA=;
        b=hGM708Rd7lw/RNbCvq1jYmouzLyFbwjZkgJ2fiGsTSiBG18SXFeWDssg4WnFg2i3Td
         slxRS2ZbkiXj0WbF6kx7gdfLGzWp1wRXA7TI0wmQMNrMBNIoIWPUSLUdcOznZC2qWP4L
         xDYRxzhuGrc1VuS3e5uCpKVq8N+ns/jWj+PxkLICNz6p+2VDRBMq/W/1FqTQxddv17zR
         1xijMnxbP3BdTQBPK8YeG1j6uID7Si19yaGdvambKnrbYvceXtQ3qB4h66Gb7Fv7RdxC
         lptChnPCFHhHMHtVY3H/12J2lzsh1vpbq/MoHMvRUCSaP36W6WvSge8JLkg0j7FqvxSz
         SX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bEfkoFPsxdzt2Ed9kBh/IXje0/8XPxJXaxh3sAd39WA=;
        b=cikyyUQR16W2NjI7NJ4CEyqFcsVQQA0jcYhtS6bvBfOSJ0KZk+nLISWIRv8JR0T9dU
         emgueCuOIVSHCNT9eKv8wC/JDXqBFN5o03o1itF3V7cVJPEEV3ok+uLyqHSZ6Ky0BT9L
         R5o6XCp0tNDOmuiGjFJCVq+h7H4iSZgQy7wcrLnuLrCUthF3pP/osu67ZiSob1EiH9Ji
         rVGyu4g5BM88CcbCM3Xd6zDBKqPHxKvz/kf5tPRDti7uIamvmVjmd1cnAdUTcg/sP0Ww
         cNPRG3kckyGN8xmP1WNOmXKakm76RJFrdu1vUWaXSoNpQkd8zOOu1gbBAnXLErQlsnLb
         TJyA==
X-Gm-Message-State: AN3rC/49LolUWIjLGZXofPTIJS80HoI94IpmDvaSB06EU5gxK9ujC0nl
        HXM5e4WBRjmfp8RZKvWvdeoRWtWk3g==
X-Received: by 10.107.178.129 with SMTP id b123mr45190841iof.50.1494012432762;
 Fri, 05 May 2017 12:27:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 12:26:51 -0700 (PDT)
In-Reply-To: <20170505154053.58128-2-larsxschneider@gmail.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com> <20170505154053.58128-2-larsxschneider@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 5 May 2017 21:26:51 +0200
Message-ID: <CACBZZX7p3cNi6YUef4tRCck2vE5URoNuo1W1TyFK0H2fC_XfDA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] travis-ci: setup "prove cache" in "script" step
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 5:40 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> The command that made the "prove cache" persistent across builds was
> executed in the "before_install" step. Consequently, every job that
> wanted to make use of the cache had to run this step.
>
> The "prove cache" is only used in the "script" step for the
> "make test" command. Therefore, we should configure the "prove cache"
> in this step.
>
> This change is useful for a subsequent patch that adds a job which does
> not need the "before_install" step but wants to run the "script" step to
> execute the tests.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  .travis.yml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 48cb00a581..aa03f8eb82 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -135,12 +135,14 @@ before_install:
>      p4 -V | grep Rev.;
>      echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
>      git-lfs version;
> -    mkdir -p $HOME/travis-cache;
> -    ln -s $HOME/travis-cache/.prove t/.prove;
>
>  before_script: make --jobs=2
>
> -script: make --quiet test
> +script:
> +  - >
> +    mkdir -p $HOME/travis-cache;
> +    ln -s $HOME/travis-cache/.prove t/.prove;
> +    make --quiet test;
>
>  after_failure:
>    - >

This reminded me to submit a patch to prove itself to allow for
customizing the location of the .prove file:
https://github.com/Perl-Toolchain-Gang/Test-Harness/pull/66

Hopefully in the not too distant future we can then do away with this
minor hack. Doesn't matter much to us, but just inflexible that such
symlink hacks are needed.
