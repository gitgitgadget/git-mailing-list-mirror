Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3715D1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 17:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeILW6D (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 18:58:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56280 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeILW6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 18:58:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so3327654wmc.5
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r4jJ3ZVlUU26bkrw75BYBE0dj2r/mB3YOnEcRlPKf7Q=;
        b=ACHf4FYxzTkkYoSELXBzCjDqwOvjku/0T03CdreEwYIFJeZ2eQEBFXiYGhn7S31COj
         jLdnnWCSwgT7pF9oXET5dLMv170NdLaM1/quWstGUEEyfyrhQzrc+S5q5IRF/S1h8LLu
         gnnPg8sAav/I34XIUFKIw0/ckTd5InNEYqD3jdwUObVRUJJQIonPHbih35nKbP0x3uCL
         YJROxnGgD/3ARcCqipTHXed9dBD2NrrPUerm3jyo05ArhYRaZMXfE9sLIiZh2MmEm4YW
         595ZapJeyBZK8BXY6CrACfTtGyu7ctNTa6BRokt2KAIgKB37A3m0ZWhLKGcAEIFxk26d
         qF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r4jJ3ZVlUU26bkrw75BYBE0dj2r/mB3YOnEcRlPKf7Q=;
        b=QvMePWdEAbYqlhg9ItHN5jaw1bCrBNK4618Nf4mv7WpuXTZA9Zm0t9J5OpFK01+rFJ
         kqg/puT68IrxiH8e0whtX2tiC5d6qw6ghtidDY08wzwLfPoaaF7OX9YffWWGxFGacJwM
         w81hlXMWQSrdRl+ypuHiipVgl1aeoCt4yvsPI0HoYEGyV+hXfKugwlt0W+B4Ethm/4kB
         kv6jL6MkyI/OzCzXvR7p9JE/mQlpl9rVlZRISvKWGix8r4NB7qFVraHhXj5uQqc1HGay
         etW8d0dx9rMrFA3wDF88KUg2BPgIjW7eIm3uimek6ws04hlmievRKV8AuhN8s6r2p+/8
         tH6w==
X-Gm-Message-State: APzg51CrAYxKoOelmw9atBkmESDIpIsg+Z8Tfuxk7VDjwnkRTqlLOU/d
        NaEluh8Ipdxm8jpVhFeso807bVfsfh4=
X-Google-Smtp-Source: ANB0VdaweDC6BqhjgmGcWZYFowaVmmP7GrvCqF1AifK0mDaT9oU7KPs2iRKkh4eKqvp63K5dBgqegA==
X-Received: by 2002:a1c:d98a:: with SMTP id q132-v6mr2360968wmg.78.1536774743933;
        Wed, 12 Sep 2018 10:52:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z4-v6sm961718wrt.89.2018.09.12.10.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 10:52:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/9] string-list: add string_list_{pop, last} functions
References: <20180911234951.14129-1-sbeller@google.com>
        <20180911234951.14129-2-sbeller@google.com>
Date:   Wed, 12 Sep 2018 10:52:22 -0700
In-Reply-To: <20180911234951.14129-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 16:49:43 -0700")
Message-ID: <xmqq7ejqmwmh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Add a few functions to allow a string-list to be used as a stack:
>
>  - string_list_last() lets a caller peek the string_list_item at the
>    end of the string list.  The caller needs to be aware that it is
>    borrowing a pointer, which can become invalid if/when the
>    string_list is resized.
>
>  - string_list_pop() removes the string_list_item at the end of
>    the string list.
>
>  - _pop usually has a friend _push. This role is taken by
>     string_list_append already, as they are not symmetrical
>     in our code base: _append returns the pointer, such that
>     adding a util is easy, but _pop doesn't return such a pointer.

This third-item somehow is indented one place too deeply.

"our pop() does not return a pointer, so we won't introduce push()
that does return a pointer"?  Am I reading the third item right?

pop() and push() usually go together, but they are opposite
operations, they are expected to behave oppositely, and they are
expected to be interfaced differently.  pop() that does not return a
pointer is no better or no worse match to push() that returns a
pointer, no?

Lack of something_push(), when something_pop() exists, would always
be surprising to anybody new to the "something" API, and no amount
of mumbling would justify it, I would think, but this third item
sounds like it is trying to make a lame excuse when there is no need
to.

Wouldn't it be sufficient to say "there is no string_list_push();
string_list_append() can be used in its place" and stop there?

> You can use them in this pattern:
>
>     while (list.nr) {
>         struct string_list_item *item = string_list_last(&list);
>
>         work_on(item);
>         string_list_pop(&list);
>     }

"free_util" as the second argument to this sample call is missing.

>  string-list.c | 14 ++++++++++++++
>  string-list.h | 11 +++++++++++
>  2 files changed, 25 insertions(+)

> diff --git a/string-list.c b/string-list.c
> index 771c4550980..04db2b537c0 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -80,6 +80,20 @@ void string_list_remove(struct string_list *list, const char *string,
>  	}
>  }
>  
> +void string_list_pop(struct string_list *list, int free_util)
> +{
> +	if (list->nr == 0)
> +		BUG("tried to remove an item from empty string list");
> +
> +	if (list->strdup_strings)
> +		free(list->items[list->nr - 1].string);
> +
> +	if (free_util)
> +		free(list->items[list->nr - 1].util);
> +
> +	list->nr--;
> +}
> +
>  int string_list_has_string(const struct string_list *list, const char *string)
>  {
>  	int exact_match;
> diff --git a/string-list.h b/string-list.h
> index ff8f6094a33..ce2528bbe15 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -191,6 +191,17 @@ extern void string_list_remove(struct string_list *list, const char *string,
>   */
>  struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
>  
> +/**
> + * Removes the last item from the list.
> + * The caller must ensure that the list is not empty.
> + */
> +void string_list_pop(struct string_list *list, int free_util);
> +
> +static inline struct string_list_item *string_list_last(struct string_list *list)

We may want to warn users that pop(), append(), etc. shouldn't be
done while using the returned value from this function in an in-code
comment or docstring.

> +{
> +	return &list->items[list->nr - 1];
> +}
> +

Other than that, nicely done.

>  /*
>   * Remove all but the first of consecutive entries with the same
>   * string value.  If free_util is true, call free() on the util
