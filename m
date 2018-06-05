Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C851F517
	for <e@80x24.org>; Tue,  5 Jun 2018 16:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeFEQ6b (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 12:58:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38188 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeFEQ63 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 12:58:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so1510810pgf.5
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LHBDWh9qJSlkwVCFxgySFvIqUcoPoOJ78Wp4AbKayI4=;
        b=beHGyxLxFVTQmIJNcvHy3WxmxLfH+8fJdO4yple76hmaAILW6Dk9cWPlQhCWksZaXb
         FlDqDu0agd6udurgugg6BbKI/FhFh8xbqEzAi6USGlNHc5w6wZVkjYqLWfr0erhnc4oz
         vHhvPdLgNCq8qMwUZZxqZXDXXBylmIfEau6Ds/rLDkryQmLwV/5Su8tjDp/1KUShz6gZ
         YRvs5HNnFlp9U+ZcPp5vFwM6nq9rbH34BXLWYvV5fzXcVUQ1ta2FewX/CBc+/PzlV80k
         QFHrdKWllYungqKNeKFL6AZekf/yAp4zL3e8at1TmDfI1Z2B13qdWjbPGGzgoFgBfZHO
         hZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LHBDWh9qJSlkwVCFxgySFvIqUcoPoOJ78Wp4AbKayI4=;
        b=DcL87d+SgNg4MEZ1P7xwWRMHOVYGPOoxVXJzGtnNYTr4Kj5r1cJ9Xjsa9O8m8nRvHF
         yD4Gw6052wVxSDtZi4QExhisT1O4mLSmoi28QK/kjbzAqM9GpcFDt7zJxqOzTCVxw2qP
         ZBt7aWepTYTL0dfPG76BbMqqX6oGsGTSlW6ZqWLKo+sWCUl8AqlRrKEBL+hNN02Fsjx3
         8V58xvzAsEjvV0REeBP+Od+qmyhjcfO+EMBoToYqPihXyBxbtw4/inWereh7iC08aeX7
         vWBk9QxyGdAarD2fyWc1SbHXEubuujL9q6NakEmMdLxVuet6Z7QFKN0c+TfsEUHOw0pz
         rTEA==
X-Gm-Message-State: APt69E00/pn8obEOmswOQQ9fQaHjL5BkdfzatAWluEnMcl58GMCz0KZ1
        MAEF8BXU1Yht4cpI81Xa1rXvcw==
X-Google-Smtp-Source: ADUXVKJ7m5j/k59WlG/vq7hs/OB12z07e+VZei6u7H6Uy13Wp5wh9M82VqfhzlBW7DSNydl+f3z14g==
X-Received: by 2002:a65:4a10:: with SMTP id s16-v6mr1642409pgq.57.1528217909010;
        Tue, 05 Jun 2018 09:58:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h17-v6sm77214359pfn.80.2018.06.05.09.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 09:58:27 -0700 (PDT)
Date:   Tue, 5 Jun 2018 09:58:26 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/6] Forbid "the_index" in dir.c and unpack-trees.c
Message-ID: <20180605165826.GB158365@google.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
 <20180605154334.22613-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605154334.22613-7-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Nguyễn Thái Ngọc Duy wrote:
> Use of global variables like the_index makes it very hard to follow
> the code flow, especially when it's buried deep in some minor helper
> function.
> 
> We are gradually avoiding global variables, this hopefully will make
> it one step closer. The end game is, the set of "library" source files
> will have just one macro set: "LIB_CODE" (or something). This macro
> will prevent access to most (if not all) global variables in those
> files. We can't do that now, so we just prevent one thing at a time.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Should I keep my trick of defining the_index to
>  the_index_should_not_be_used_here? It may help somewhat when people
>  accidentally use the_index.

We already have a set of index compatibility macros which this could
maybe be a part of.  Though if we want to go this way I think we should
do the reverse of this and instead have GLOBAL_INDEX which must be
defined in order to have access to the global.  That way new files are
already protected by this and it may be easier to reduce the number of
these defines through our codebase than to add them to every single
file.

> 
>  cache.h        | 2 ++
>  dir.c          | 2 ++
>  unpack-trees.c | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index 89a107a7f7..ecc96ccb0e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -330,7 +330,9 @@ struct index_state {
>  	struct ewah_bitmap *fsmonitor_dirty;
>  };
>  
> +#ifndef NO_GLOBAL_INDEX
>  extern struct index_state the_index;
> +#endif
>  
>  /* Name hashing */
>  extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
> diff --git a/dir.c b/dir.c
> index ccf8b4975e..74d848db5a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -8,6 +8,8 @@
>   *		 Junio Hamano, 2005-2006
>   */
>  #define NO_THE_INDEX_COMPATIBILITY_MACROS
> +/* Do not use the_index. You should have access to it via function arg */
> +#define NO_GLOBAL_INDEX
>  #include "cache.h"
>  #include "config.h"
>  #include "dir.h"
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3ace82ca27..9aebe9762b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1,4 +1,6 @@
>  #define NO_THE_INDEX_COMPATIBILITY_MACROS
> +/* Do not use the_index here, you probably want o->src_index */
> +#define NO_GLOBAL_INDEX
>  #include "cache.h"
>  #include "argv-array.h"
>  #include "repository.h"
> -- 
> 2.18.0.rc0.333.g22e6ee6cdf
> 

-- 
Brandon Williams
