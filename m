Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01871F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 10:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfAQKGb (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 05:06:31 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36267 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKGb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 05:06:31 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so401935itj.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 02:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JFp22C1hb3kWk0vVPotdVp46t70EwVfhO+kQU5gZ1Q=;
        b=ty9N1/dvM6vrNT3LCbz6uMKLiY06t149Xtwof9Pey0AL6bN4N3l+/jpeqAo5jn/oOn
         frJU3IMHhSuRpmPjAWUbfsWRzYKxPzA82+6mYkUu7BeY37ld7JD2zuyjREVI7x5KdFVC
         DiikU0f85Y0ohqbZD//ZVcWwRL7QFEjZrjSE8DcJNKIcqUOJ5PwJsjb7wmiVLAqkSE65
         mOUJxDVLgdAmsdvu2Liemb+VHCJYQGPQ4RWMxt3WGtG7sz2Ny288uLA/LLQnMZ44rKDc
         YEMlbKrcqxIUS5+vL5R2gxuSjeId+MjVf8+E5FCvq4UGsewrB4CfrUt4zmKu7uuHamWR
         UAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JFp22C1hb3kWk0vVPotdVp46t70EwVfhO+kQU5gZ1Q=;
        b=mRA6EI+3WcLiZxOXhR9qEoUcjL0MTMcxQXmAZh44jdecGDnQ1LgPjA6oat4wKEmDvm
         P+l2LU9S5RCRscbhelMgrhxdalVG5CzIKqtCMp10WTrRBaCyziLIAv6kf3EN7h3cNTNC
         Kz8pMjieD3yLM/xkPq/15c9jj6A6wvTS1qHcuv5ua8OsehVTyrSCZ9P5hgvMDOYEcm4D
         4UOLu7NG8nYNxxudWIvwkxeHix7vvd2ZOntYmzYhBrdGzr9yBU6mwK3TM3MXbbOOjFyZ
         3ZoCND7G1BC9MJKlADxV5LsidQaQVYNOrxrqlbfH9TmdoLKPTPQzfi4CTevCvdFLiBcK
         be0A==
X-Gm-Message-State: AJcUukcLsPNPhQBaFEWwKiKuy8PrwQxdqB/hmdO9Qs2rNI2lR8uE86dr
        dwybAk0KpeCPTBi95SRciF4bBPrr4nrdFiMPD+2qyA==
X-Google-Smtp-Source: ALg8bN4VMMW2xNOE15FJd3aAPPJl2rlDZZ0n+J4tO38kl0jovN5AUeuZ6gHA90Y4G/yRP7gZ2q45QpYQOhh8++Noqw4=
X-Received: by 2002:a02:183:: with SMTP id 3mr7780750jak.130.1547719590460;
 Thu, 17 Jan 2019 02:06:30 -0800 (PST)
MIME-Version: 1.0
References: <419519f9-1b48-93bb-eead-eacf6b383f70@ramsayjones.plus.com>
In-Reply-To: <419519f9-1b48-93bb-eead-eacf6b383f70@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 17 Jan 2019 17:06:03 +0700
Message-ID: <CACsJy8BWfdCwFwhfKku-AqP5sGpB7CN4O-Qu0b1cm3iTbW8Z_Q@mail.gmail.com>
Subject: Re: [PATCH] repository.c: fix sparse warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 8:21 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Duy,
>
> If you need to re-roll your 'nd/the-index-final' branch, could you
> please squash this into the relevant patch (commit 4478671442,
> "cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch", 2019-01-12).
>
> [the warning is caused by the lack of the extern declaration of the
> 'the_index' symbol.]

Is it a false alarm? The variable is actually defined in this file now
which should also function as a declaration, yes?

>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>  repository.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/repository.c b/repository.c
> index 0c6814627e..3ecbb1b6e3 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "repository.h"
>  #include "object-store.h"
> --
> 2.20.0



-- 
Duy
