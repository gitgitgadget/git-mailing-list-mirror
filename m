Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CB51F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeDCSFj (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:05:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34958 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeDCSFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:05:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id 61-v6so7959456plb.2
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpLSsEJN6VFcEtetkfKPYU8AhIzakNlIzJjeAA7MQcI=;
        b=RkUUqpEuW+M2l7G4hOg1joAzRZjaPC9WUXK5kl7+eWLEyRqvIC0hnVOXa97zkg40tY
         11m5hqIL7KZyr2+HIAqEJOqnir3DW1uDT/cl6VzrWVgo5TJdYKrKYXz9ELmC9FaZQiU1
         /zfiiiBBO38Jf68ZAjbuCrxtrVfqtzM5xWxS/sxJKzOODNj/v+iwWCIlrIiSb4RUJ+DA
         n8fUJfjo/1G3zd+1dbTWTW9ddiXoTp6DRXVUv1OwDtSDHNjM8n5tzek8JESDmVJwb76q
         GOrdeloBRAd1STN6NJxvnp4+fMSNiB5pCCddXsXikJYzXcHo9VSQzCfNfZyGos3y+CgX
         bvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpLSsEJN6VFcEtetkfKPYU8AhIzakNlIzJjeAA7MQcI=;
        b=f2tG92yV3Q7c5ZKl7hl6fsHoA+81EdWpD/J3eJdEw72IunMEf3fNEeakshwqM5WIiJ
         W0AB/BfDr+AtqGMEB5oMAMNyTtHhAbAB/x0LQI7qe109dac+A2mSQYiU3YsiCDrgk81W
         Ylo9L5PZTO6Bu23FDepYgpR21QSas6+i7+Rgm+WXgNDHBHHsKJQorx9/LeGorsUy3oQs
         xw7XAIJbp6O7wlHJpjy48TgVYmkj8ICibX256/ygEOcT/DlCyvYAwxdv8ywUSUiLbpeU
         du/N67jlKCdthZIZPkAZZCzv8ofCMXpi2FAiicnNC7LcfYtSz9CsMfcOs69+1LKtLWVz
         D6fA==
X-Gm-Message-State: AElRT7G2Tq+1eCHIYrnV8SsylhYRrwn0Rik6WHKip97FR9SqxbSAu7ki
        q4DyKae54ZF08W62Ig70F1Jc/w==
X-Google-Smtp-Source: AIpwx48Fwfur0JfalYHPc4RzqedLvgTXHiJF9K5qH9591N4VKr1rqtpqBN380mjl6acK4dLVUReHKg==
X-Received: by 2002:a17:902:7804:: with SMTP id p4-v6mr15372572pll.17.1522778738378;
        Tue, 03 Apr 2018 11:05:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id s7sm5457319pgr.90.2018.04.03.11.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 11:05:37 -0700 (PDT)
Date:   Tue, 3 Apr 2018 11:05:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
Message-ID: <20180403180536.GB100220@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-3-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403165143.80661-3-dstolee@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/03, Derrick Stolee wrote:
> The generation number of a commit is defined recursively as follows:
> 
> * If a commit A has no parents, then the generation number of A is one.
> * If a commit A has parents, then the generation number of A is one
>   more than the maximum generation number among the parents of A.
> 
> Add a uint32_t generation field to struct commit so we can pass this

Is there any reason to believe this would be too small of a value in the
future?  Or is a 32 bit unsigned good enough?

> information to revision walks. We use two special values to signal
> the generation number is invalid:
> 
> GENERATION_NUMBER_UNDEF 0xFFFFFFFF
> GENERATION_NUMBER_NONE 0
> 
> The first (_UNDEF) means the generation number has not been loaded or
> computed. The second (_NONE) means the generation number was loaded
> from a commit graph file that was stored before generation numbers
> were computed.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  alloc.c        | 1 +
>  commit-graph.c | 2 ++
>  commit.h       | 3 +++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/alloc.c b/alloc.c
> index cf4f8b61e1..1a62e85ac3 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -94,6 +94,7 @@ void *alloc_commit_node(void)
>  	c->object.type = OBJ_COMMIT;
>  	c->index = alloc_commit_index();
>  	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
> +	c->generation = GENERATION_NUMBER_UNDEF;
>  	return c;
>  }
>  
> diff --git a/commit-graph.c b/commit-graph.c
> index 1fc63d541b..d24b947525 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -264,6 +264,8 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>  	date_low = get_be32(commit_data + g->hash_len + 12);
>  	item->date = (timestamp_t)((date_high << 32) | date_low);
>  
> +	item->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> +
>  	pptr = &item->parents;
>  
>  	edge_value = get_be32(commit_data + g->hash_len);
> diff --git a/commit.h b/commit.h
> index e57ae4b583..3cadd386f3 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -10,6 +10,8 @@
>  #include "pretty.h"
>  
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> +#define GENERATION_NUMBER_UNDEF 0xFFFFFFFF
> +#define GENERATION_NUMBER_NONE 0
>  
>  struct commit_list {
>  	struct commit *item;
> @@ -24,6 +26,7 @@ struct commit {
>  	struct commit_list *parents;
>  	struct tree *tree;
>  	uint32_t graph_pos;
> +	uint32_t generation;
>  };
>  
>  extern int save_commit_buffer;
> -- 
> 2.17.0.rc0
> 

-- 
Brandon Williams
