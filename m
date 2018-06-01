Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1596F1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeFAT2G (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:28:06 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:43759 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752572AbeFAT2F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:28:05 -0400
Received: by mail-yb0-f177.google.com with SMTP id w3-v6so6520809ybq.10
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pA2NqTdBE01l36jXDQuDDj+bsZ2R1fyUZS2u6jogE3I=;
        b=SrO9DwBtXfkaEipZr24+xyofEy9cvBn0MuQHGTUuBq+uGsgsjPewlykyad2zJh9xj7
         iqAE3r5jmal40NVS6K70xJlOB3l6oV+TbjXLD863cCOc8pEZEa1HRm5yqZrbxGqx+vWY
         2jqEuu211iPsVuib1N+g+ubtUqg8JZuYlHYJS8aMZ1rXou3WBJSVvjTYIly9XPf0wg1o
         NBPordk0g2rCmX4kdVRyx093QsR1HjdizBDra7qw9kFaY+Ap14YsQbF6Is4c0yX0LK/O
         yAGONVfBAp7Z2VpmaQGMyPNQJ8Dj6xS7BPmv7BTGVPOxxc0SmrBoS03qZMxj+qZLXk9L
         yXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pA2NqTdBE01l36jXDQuDDj+bsZ2R1fyUZS2u6jogE3I=;
        b=mP12qtayVgBNy16SM/PFni7+sJJqwKpd5eUyCHIBujFbpc2xtI4rvM7A4sSmhySgqG
         lMG+xs1i+hbEVp95f3BvHYpqWpUAlk/ujY38cA0MAI7tZdhn6EAha0urelvekURzgSlR
         CQ5HgSo08LnnPMMk123KKOVeWpGQokmK8nrj9c+tms+O9jNJfdz4C231DHcOG7uKO8Jo
         SWjnw9o8JYTvP1VzGWKc2labopi9Cm93Emyj9sW8PQZHPCmZ2tyP7CuABlvzn9Hkofbf
         gtV8hzrXhoFo4X2IYDAC7b+ziiOsgU4EBDfYswWkfpxPD/QuIgqj8wzuGkcJFCpBGtdm
         2F/A==
X-Gm-Message-State: ALKqPwdiR1voeqRStDTwycAWmDFeYBs+i1bHiqxkaeCPJW+7WsThC0Nn
        RsylnIKhmk7uUo1K5Mt67Z03v0lovfH3K389nwuiUKJj
X-Google-Smtp-Source: ADUXVKK+nImNnCpcGjH1652lEXUcgH3CWw+4wDYdGexLAw1ZCtJhKr/fXs9EZKotJ9AUxdEZ1O1r8tkBmod+zoRa+DM=
X-Received: by 2002:a25:fc04:: with SMTP id v4-v6mr6598160ybd.167.1527881284777;
 Fri, 01 Jun 2018 12:28:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 12:28:04 -0700 (PDT)
In-Reply-To: <20180523144637.153551-6-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180523144637.153551-1-jamill@microsoft.com>
 <20180523144637.153551-6-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 1 Jun 2018 12:28:04 -0700
Message-ID: <CAGZ79kZ-1jwnhzZrCeoZTZrNSwmnO=6asWQgWXRj7tjfYVr=-A@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] mem-pool: fill out functionality
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "peartben@gmail.com" <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -108,3 +108,43 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
>         memset(r, 0, len);
>         return r;
>  }
> +
> +int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
> +{
> +       struct mp_block *p;
> +
> +       /* Check if memory is allocated in a block */
> +       for (p = mem_pool->mp_block; p; p = p->next_block)
> +               if ((mem >= ((void *)p->space)) &&
> +                   (mem < ((void *)p->end)))
> +                       return 1;
> +
> +       return 0;
> +}
> +
> +void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
> +{
> +       /* Append the blocks from src to dst */
> +       if (dst->mp_block && src->mp_block) {
> +               /*
> +                * src and dst have blocks, append
> +                * blocks from src to dst.
> +                */
> +               dst->mp_block_tail->next_block = src->mp_block;
> +               dst->mp_block_tail = src->mp_block_tail;
> +       } else if (src->mp_block) {
> +               /*
> +                * src has blocks, dst is empty
> +                * use pointers from src to set up dst.
> +                */
> +               dst->mp_block = src->mp_block;
> +               dst->mp_block_tail = src->mp_block_tail;
> +       } else {
> +               // src is empty, nothing to do.

comment style.
