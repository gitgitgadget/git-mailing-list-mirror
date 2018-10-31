Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8521F453
	for <e@80x24.org>; Wed, 31 Oct 2018 06:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeJaPEa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 11:04:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40192 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbeJaPEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 11:04:30 -0400
Received: by mail-vs1-f67.google.com with SMTP id s9so8927460vsk.7
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N00UmogXuxMrgVFeDJlS+Fe9WLzKfbAMlpQ6W7jkFTo=;
        b=YU6VnVSst0mLKUkZWPB2J14lF+Re2OfU4GblI0ej0947MGlOKUEWpy/RIH1ckarm4J
         dsvPejhbAgbmRgtq4N8Pfe4KpU44NW7z8+GVM9/DQkaPexkK2c/dw9IRvnOSuEfhwXVi
         JKB0gD+owj4VmHE179tAz8ga/QAgmKx/x+mfCwfpqUNCS1ZxC9TH0INwFU1bGxZ/fZ8A
         dNHhXG2xdkwXi9HIltY4zRvIXD9pM/jJJKoYgqpJVp1gLtDdFZQGsroiOukp6ltG0Wdw
         wUSZC8VT9C6L33Oblx5KeiZh2MkrGbEjFCIPln09a3W6EWpAqmFnWY3LCsEnhZKletkb
         uYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N00UmogXuxMrgVFeDJlS+Fe9WLzKfbAMlpQ6W7jkFTo=;
        b=NuTC3XDgTYv69PX2aT0vfnYY68u994gB3K3bqxiOCukn4lF+G35NHyr1J/5/NijmQm
         ipQpPhl6TjAmmfn+dAdY3PvYYCu3JpxJQdsQDqgI7+BUwcL1wDdFY2GeWzySYA6FGnrm
         SshBe8id+vvwHMTjHao4L3iZuuYJ3yZkjT71Y2JP1YFah1NXlQ62v6TxwJdD2y37oAcw
         HKl1bBpyEClPP6BDAJyFDcVuZRF2QhmSZTwnCzRGFzGP7ahHmPVhqJXAWXQ+VgyqHQgJ
         W2d337IUhKiSIY9qVQHwg9adz0g/90eUM9+52vwU0sy3UxsiirCx0moS44N+WIIJ6iWR
         WqQg==
X-Gm-Message-State: AGRZ1gIzzjBh8jfDq4w4OZwMFxrmhOITDshLWpVj2d+npxHQPiMtQIYi
        JM0QgMcbnvn/fG0jnY130QkmZN7IzFiLFyzdgv8=
X-Google-Smtp-Source: AJdET5daBkQAdQTOytWWUtwAtt02e/JOcCVkz/IgeqEETOe4GneDwVoXCvZyiTrY4YQrrsVP3AY4EXKM3+Ba2dX1A8Y=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr758901vsm.116.1540966068609;
 Tue, 30 Oct 2018 23:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.60.git.gitgitgadget@gmail.com> <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
In-Reply-To: <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Oct 2018 23:07:37 -0700
Message-ID: <CABPp-BHbOWXsnUSdcptyQ_Cn_PnqH4On+Q3zWNZQV4QHgYhqpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] commit-reach: implement get_reachable_subset
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 7:16 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -688,3 +688,73 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>         object_array_clear(&from_objs);
>         return result;
>  }
> +
> +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
> +                                        struct commit **to, int nr_to,
> +                                        int reachable_flag)
> +{
> +       struct commit **item;
> +       struct commit *current;
> +       struct commit_list *found_commits = NULL;
> +       struct commit **to_last = to + nr_to;
> +       struct commit **from_last = from + nr_from;
> +       uint32_t min_generation = GENERATION_NUMBER_INFINITY;
> +       int num_to_find = 0;
> +
> +       struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
> +
> +       for (item = to; item < to_last; item++) {
> +               struct commit *c = *item;
> +
> +               parse_commit(c);
> +               if (c->generation < min_generation)
> +                       min_generation = c->generation;

So, when we don't have a commit-graph, is c->generation just going to
be 0, making min_generation also be 0? (meaning we get no possible
speed benefit from the commit-graph, since we just don't have that
information available)?

> +
> +               if (!(c->object.flags & PARENT1)) {
> +                       c->object.flags |= PARENT1;
> +                       num_to_find++;
> +               }
> +       }
> +
> +       for (item = from; item < from_last; item++) {
> +               struct commit *c = *item;
> +               if (!(c->object.flags & PARENT2)) {
> +                       c->object.flags |= PARENT2;
> +                       parse_commit(c);
> +
> +                       prio_queue_put(&queue, *item);
> +               }
> +       }
> +
> +       while (num_to_find && (current = prio_queue_get(&queue)) != NULL) {
> +               struct commit_list *parents;
> +
> +               if (current->object.flags & PARENT1) {
> +                       current->object.flags &= ~PARENT1;
> +                       current->object.flags |= reachable_flag;
> +                       commit_list_insert(current, &found_commits);
> +                       num_to_find--;
> +               }
> +
> +               for (parents = current->parents; parents; parents = parents->next) {
> +                       struct commit *p = parents->item;
> +
> +                       parse_commit(p);
> +
> +                       if (p->generation < min_generation)
> +                               continue;
> +
> +                       if (p->object.flags & PARENT2)
> +                               continue;
> +
> +                       p->object.flags |= PARENT2;
> +                       prio_queue_put(&queue, p);
> +               }
> +       }
> +
> +       clear_commit_marks_many(nr_to, to, PARENT1);
> +       clear_commit_marks_many(nr_from, from, PARENT2);
> +
> +       return found_commits;
> +}
> +
> diff --git a/commit-reach.h b/commit-reach.h
> index 7d313e297..43bd50a70 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -74,4 +74,14 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>                        int commit_date_cutoff);
>
> +
> +/*
> + * Return a list of commits containing the commits in the 'to' array
> + * that are reachable from at least one commit in the 'from' array.
> + * Also add the given 'flag' to each of the commits in the returned list.
> + */
> +struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
> +                                        struct commit **to, int nr_to,
> +                                        int reachable_flag);
> +
>  #endif
> --
> gitgitgadget
>
