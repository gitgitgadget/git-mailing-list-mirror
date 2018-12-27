Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20DD211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 18:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeL0SgP (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 13:36:15 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39566 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeL0SgP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 13:36:15 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so24682125itl.4
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZT0eY6FI0FByBEiZ0vFaDWEyDeOjN6lOx/dWAKW76Ug=;
        b=fXZIqISWw7lOjw4E4pXW6Tj7XbOJxbYqczr1qI2OPuz+yvWCSDZo+lvcpO+NDFtcjh
         KlWAADv+Ee5xoOsK/SxXYtokfygvdIyAyGlb1Bcw6NWn1/PA1HBDjWIfMh0UlOproo+n
         LA96Is3BDWMnwEfnQr9zqh3FcX2zkpkmE24mCjZdDW+e8DytXG0JSoXQA/JkovmhoAVH
         Dw859NmpuVFbPxz4EXqQVESKsCLkUI/XeMTMmSXOMSI2p2ZxI6G/RElcriLv1WCtJjJY
         4KSuSWwaSveDrMH3gNDzGxmN4LpYIuBy10OgJR3QqlEfBrYdD6mxBTq97Mol8vggj/hs
         jALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZT0eY6FI0FByBEiZ0vFaDWEyDeOjN6lOx/dWAKW76Ug=;
        b=N95L+8n26hbzRFJD8klEsU3K7DfwwqmQLFpQ7IUo5bmRXgtTHnKkbD23qriebk4eAm
         kZKLPsF7SiwER5N0mENQ8NjGZfuP3l38SkI34O/QkqXj0Xb/aLDgKAoamoUZBjjp6LwX
         rDw/19oxpPfHuk0D0gK+JTofwdV9iBgKi7ZvXr1SxmIZKRJO9IH0inSf3jiVV7oCEqI3
         uqtd2MMApMHPB/Giy9ajjWJw1uJHgJJ/Npw5dZLJ382QslYie7tiRznbMWpGkzbXsuMY
         g3PDGUxTP7JOeJn5ZATiqfz5hmWRdUhko2Q3rbpiV5HOkoQWhWofMpBmkzrIsbufA4Sl
         Cmdg==
X-Gm-Message-State: AA+aEWYZE/8sCM7nus9v3r4RjOv1Bj6QLP6SJjEZrZ/pQGeDSlwuqCrA
        xBpSgU5uIsYSJHHBxlPw3eUCh8C5D6vy5mMG6OQ=
X-Google-Smtp-Source: ALg8bN6beoDdX5e6G1WEY2EBnFl39rdSsq+jrb4bewf3OfMWxflSGeLO4NFg9g4s48+j79dCO5OK9TfmYfS1NGNoMVs=
X-Received: by 2002:a24:4606:: with SMTP id j6mr13455008itb.10.1545935774934;
 Thu, 27 Dec 2018 10:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20181227065855.68632-1-masayasuzuki@google.com>
In-Reply-To: <20181227065855.68632-1-masayasuzuki@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Dec 2018 19:35:48 +0100
Message-ID: <CACsJy8CM=H1njP3ZzuReS0u_YRPTS6pGhFWWMBHoaKVNBYiXXA@mail.gmail.com>
Subject: Re: [PATCH] Specify -Wformat along with -Wformat-security
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 27, 2018 at 7:18 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
>
> Without -Wformat, -Wformat-security won't work.
>
> > cc1: error: -Wformat-security ignored without -Wformat [-Werror=format-security]

Compiler name and version?

>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  config.mak.dev | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index bbeeff44f..aae9db67d 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -7,6 +7,7 @@ CFLAGS += -pedantic
>  CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
>  endif
>  CFLAGS += -Wdeclaration-after-statement
> +CFLAGS += -Wformat
>  CFLAGS += -Wformat-security
>  CFLAGS += -Wno-format-zero-length
>  CFLAGS += -Wold-style-definition
> --
> 2.20.1.415.g653613c723-goog
>


-- 
Duy
