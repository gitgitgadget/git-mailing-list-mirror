Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695A41F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJ3CKo (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:10:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43804 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJ3CKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:10:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so10139240qtq.10
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QUnUoZi3DvNFvunMEmQ8lWMfMXvHr/z9OcEjzH8Jsps=;
        b=KBKIHXfCv5Uccac85nT9P5WuFysPZ/pnIMqs6dqGEFXenSSe5z/KBTAkjuBkz3wMm+
         BaCkTKkKz/Sycl3FB+QkMiUvb4QQnY1gX5YBYEHjZT02IXKJs+wa8y0+vCs9yKTVAlOj
         s9mDAW9p4rL3zbfxfA+2IOy3BDu+WL6ylS9FHUZjWJVolYs9xM8xfdbUtzEBxBt6nbBu
         QC3kO4zml4soLCtMQr+nNK+bB5RKuKYagnjM5/LC5qhtIQ0HHqfech0Pqw7CT8tPUwON
         bHbYZAArjrNVoMaR1RnMk8md55d4UMZyrIQsepULNNR9uTGO5ctO+2JlIfSh1sMHj8VW
         v/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QUnUoZi3DvNFvunMEmQ8lWMfMXvHr/z9OcEjzH8Jsps=;
        b=aEOmyn6VlzFmIjAbl7dFRDvu2yLaDkV86mxSvx4tl7Vb6x+P9yR/AObMqWRGk3YThV
         QIv0vORsgZLn5VdfAckDn5AyI9PIjboGSlThDkMnXJiweMOXKB1GIdisfEjDO3BKQbRy
         lbpbZTNiS9TvsaRJXT73uZ/duqY8GJmOOrloLuMZmZfb18L51brCyIUE6o1fqty8Qhdp
         uKERBgMCyVxw78BYYfmtg01V7RXqM9oKWRS1IBu/t9PN6VWgWylebrMMlR2XgNbrqGs4
         zpnfLv921T/kiCgDrqs8r5QW39TKQtAt2rHfHL1K71OcqnepyGNCcDKK3TrxoFcB1iSY
         P32A==
X-Gm-Message-State: AGRZ1gK+qk6GOH6qkA9L0vzEWS83rUlhnDBHPShFP5yaqF/5REpwL/4J
        pUaprcFm/c4fw0FAodv6mm8=
X-Google-Smtp-Source: AJdET5d5x7hWDh2eFwhckgLawWPOYQ6WIleAoox3xbSi3HhVlcUTbkaaQFB+xTiw6BwF0P8aCyWcQw==
X-Received: by 2002:aed:25f7:: with SMTP id y52-v6mr13453241qtc.217.1540833671846;
        Mon, 29 Oct 2018 10:21:11 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f33-v6sm13260772qtb.64.2018.10.29.10.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:21:11 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] preload-index.c: remove #ifdef NO_PTHREADS
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-7-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0ee246db-d781-9a42-8b8c-3e98c132b0ae@gmail.com>
Date:   Mon, 29 Oct 2018 13:21:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181027173008.18852-7-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/27/2018 1:30 PM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   preload-index.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/preload-index.c b/preload-index.c
> index 9e7152ab14..0e24886aca 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -7,17 +7,7 @@
>   #include "fsmonitor.h"
>   #include "config.h"
>   #include "progress.h"
> -
> -#ifdef NO_PTHREADS
> -static void preload_index(struct index_state *index,
> -			  const struct pathspec *pathspec,
> -			  unsigned int refresh_flags)
> -{
> -	; /* nothing */
> -}
> -#else
> -
> -#include <pthread.h>
> +#include "thread-utils.h"
>   
>   /*
>    * Mostly randomly chosen maximum thread counts: we
> @@ -108,7 +98,7 @@ static void preload_index(struct index_state *index,
>   	struct thread_data data[MAX_PARALLEL];
>   	struct progress_data pd;
>   
> -	if (!core_preload_index)
> +	if (!HAVE_THREADS || !core_preload_index)
>   		return;
>   
>   	threads = index->cache_nr / THREAD_COST;
> @@ -151,7 +141,6 @@ static void preload_index(struct index_state *index,
>   
>   	trace_performance_leave("preload index");
>   }
> -#endif
>   
>   int read_index_preload(struct index_state *index,
>   		       const struct pathspec *pathspec,
> 


In the theory that code speaks louder than comments, here is the patch I 
used when testing out the idea of getting rid of NO_PTHREADS:


  git diff head~1 preload-index.c
diff --git a/preload-index.c b/preload-index.c
index 9e7152ab14..266bc9d8d7 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -7,17 +7,7 @@
  #include "fsmonitor.h"
  #include "config.h"
  #include "progress.h"
-
-#ifdef NO_PTHREADS
-static void preload_index(struct index_state *index,
-                         const struct pathspec *pathspec,
-                         unsigned int refresh_flags)
-{
-       ; /* nothing */
-}
-#else
-
-#include <pthread.h>
+#include "thread-utils.h"

  /*
   * Mostly randomly chosen maximum thread counts: we
@@ -104,7 +94,7 @@ static void preload_index(struct index_state *index,
                           const struct pathspec *pathspec,
                           unsigned int refresh_flags)
  {
-       int threads, i, work, offset;
+       int cpus, threads, i, work, offset;
         struct thread_data data[MAX_PARALLEL];
         struct progress_data pd;

@@ -114,6 +104,9 @@ static void preload_index(struct index_state *index,
         threads = index->cache_nr / THREAD_COST;
         if ((index->cache_nr > 1) && (threads < 2) && 
git_env_bool("GIT_TEST_PRELOAD_INDEX", 0))
                 threads = 2;
+       cpus = online_cpus();
+       if (threads > cpus)
+               threads = cpus;
         if (threads < 2)
                 return;
         trace_performance_enter();
@@ -151,7 +144,6 @@ static void preload_index(struct index_state *index,

         trace_performance_leave("preload index");
  }
-#endif

  int read_index_preload(struct index_state *index,
                        const struct pathspec *pathspec,
