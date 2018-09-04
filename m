Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F891F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIECkM (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:40:12 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40469 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIECkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:40:12 -0400
Received: by mail-ed1-f46.google.com with SMTP id j62-v6so4496110edd.7
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsLWMXhb24AyAPSraLevx1yIS37l3eVeXkrSvZW5xTI=;
        b=nnQ6twTLgzv05tCg4uzFLMbLLhgbu+dcJbrnUf6BW6BTTwPVKilqQepZ8FHn6UUgB7
         jv44ht90yTIBAbLRQS+MUyfPESWXjmxe3e5kymtY9e8z+xec8lGtLsChzOgjAbinzRdU
         7dNmlJDP9DVf+aSz7N6/ILCQtRCbIKvfzxsFWfdp8ip+BtqdxBwTBlPxxAchK+TTmqGN
         6dr+CMXmHVdYfSJiJCoj50UhgYUJMes8pvjiY4JrSqTdlr+8EwE7cJvJ74S5CguLJAIj
         th/c2Iu2FkYJ+GWey0mEn9CQwANZ7lET/dOe6lvERd1U7v2om2JFeVi3S7+LVXLBEKmu
         Arhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsLWMXhb24AyAPSraLevx1yIS37l3eVeXkrSvZW5xTI=;
        b=oAem2iJwCYj27rKWfXZQzJO93SLi0useu8EI7DvX3y0hkvnoeaZa+Yq0Fvi8cZfjXY
         pelF5r+KUGtDKHTGh/YQ2HeN/Mg1U9lCVjRRf0h8NNVqlOxszlfResHvRgs4nhydxHom
         bL0r9pq61aykKQeJNK7S96JLlVs+FJcHsdcIDL9iES1ZdLMwT9giz7Gauh0x0bCxsQyS
         EddEHFJbYSBB+EN0kZ8Ey3+J0gcOZ3x5lDXflgHr3LqgerSInGWu+HMdhtsswkVBLqPT
         +lU4XlSVxOjWkzQBKH+TKtcGi99a5d2bd913PkwGocBBtRyut3iSaPqxC10xoU+sb0Up
         wXeA==
X-Gm-Message-State: APzg51CKbfWYP02Z4shxFYZXJXEVcbB3SWZ42q8WYS4F6zf35LlNTzN4
        1oNOY6yrWWlslwuXMff65pGwYM+JLgYJ6SyB2zNWWQ==
X-Google-Smtp-Source: ANB0VdajScT0g9yrFCKq/jjVZcTymOmyJsfjGUmMtEyrLJLzxff/Ginr4NM/zyk7zW0rhwyyE5ahpQbXEgMMS+1Sf4U=
X-Received: by 2002:a50:f5ae:: with SMTP id u43-v6mr38761655edm.75.1536099183753;
 Tue, 04 Sep 2018 15:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.29.git.gitgitgadget@gmail.com> <82885700379efe6d6a83629cac4d943b99b393bf.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <82885700379efe6d6a83629cac4d943b99b393bf.1535734192.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 15:12:53 -0700
Message-ID: <CAGZ79kbUYDAKi-K2uHpkffPjMxGYtH=QUMhvfq4HTc5+a7-eBA@mail.gmail.com>
Subject: Re: [PATCH 1/8] trace2: create new combined trace facility
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Create GIT_TR2 trace-key to replace GIT_TRACE, GIT_TR2_PERFORMANCE to
> replace GIT_TRACE_PERFORMANCE, and a new trace-key GIT_TR2_EVENT to
> generate JSON data for telemetry purposes.  Other structured formats
> can easily be added later using this new existing model.

So the idea is to use the GIT_TR2 instead of GIT_TRACE and we
get the same output as well as a new form of structured logging here?
(Then GIT_TRACE could be retired, and we'd use the new API to add
more events, which are also more structured as the API allows for more
than just a string printed?)

> Define a higher-level event API that selectively writes to all of the
> new GIT_TR2_* targets (depending on event type) without needing to call
> different trace_printf*() or trace_performance_*() routines.
>
> The API defines both fixed-field and printf-style functions.
>
> The trace2 performance tracing includes thread-specific function
> nesting and timings.

So this only adds the new API, and we need to merge the TRACE
into the TRACE2 later?

> +++ b/trace2.c
> @@ -0,0 +1,1592 @@
[...]
> +
> +/*****************************************************************
> + * TODO remove this section header
> + *****************************************************************/

Yes, please.

> +/*
> + * Compute a "unique" session id (SID) for the current process.  All events
> + * from this process will have this label.  If we were started by another
> + * git instance, use our parent's SID as a prefix and count the number of
> + * nested git processes.  (This lets us track parent/child relationships
> + * even if there is an intermediate shell process.)

How does this work with threading. From this description we can have
two threads starting new child processes and they have the same ID
(<our id>-2)

> +
> +/*****************************************************************
> + * TODO remove this section header
> + *****************************************************************/

This looks like a reoccurring pattern. Did you have a tool
that needs these? Does the tool want to enforce some level of
documentation on each function?

> +
> +/*
> + * Each thread (including the main thread) has a stack of nested regions.
> + * This is used to indent messages and provide nested perf times.  The
> + * limit here is for simplicity.  Note that the region stack is per-thread
> + * and not per-trace_key.

What are the (nested) regions used for? I would imagine recursive
operations, e.g. unpacking trees? Where am I supposed to read
up on those?

> + */
> +#define TR2_MAX_REGION_NESTING (100)
> +#define TR2_INDENT (2)
> +#define TR2_INDENT_LENGTH(ctx) (((ctx)->nr_open_regions - 1) * TR2_INDENT)

In the structured part of the logging the indentation would not be
needed and we'd rather want to store the nesting level as an int,
this is solely for printing locally I'd assume.

> +#define TR2_MAX_THREAD_NAME (24)

This is the max length for a thread name including all the prefixes?


> +static void tr2tls_unset_self(void)
> +{
> +       struct tr2tls_thread_ctx * ctx;
> +
> +       ctx = tr2tls_get_self();
> +
> +       pthread_setspecific(tr2tls_key, NULL);

Would we also need to free tr2tls_key ?


> +/*****************************************************************
> + * TODO remove this section header
> + *****************************************************************/
> +
> +static void tr2io_write_line(struct trace_key *key, struct strbuf *buf_line)
> +{
> +       strbuf_complete_line(buf_line); /* ensure final NL on buffer */
> +
> +       // TODO we don't really want short-writes to try again when
> +       // TODO we are in append mode...

A different kind of TODO in a // comment?
