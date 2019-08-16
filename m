Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5A51F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfHPWjO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:39:14 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40016 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfHPWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:39:14 -0400
Received: by mail-ua1-f68.google.com with SMTP id s25so956306uap.7
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcNI5shtvN2wJOU93Mywc7wlGb2iuWtSUqO8voYa2pY=;
        b=gN5Ak65e9z7fjo9uVUZ6UFzCB3w8OECtmaljtqwOu5TLGgA9FcW2MBPYIqs6+lKMnx
         4FnoM2DYbwWOHjjR4oLaFOW1d5IeiLbNDk7WRb5OMmXe0BOX9ioYCSa7IQnUzYQ9UDZ2
         qdnfrFIZEBKeg7tFWkOfxxTe8UIJPQ0v0nNddh49MuqnnNzb2eNBcScoMmjvkqz8ccXc
         FTZ8DyKeUy+THHNNvGiLPaPD9Qq4w3LrJVGa7w5zoQhH4XaSpJQucMkc+EyLorluJ0Fi
         oN//9b7Gjsksac2P/WZosUARE+KF8zrxvjd/CLmPGjqnSZBE7e2ZlDnqeN5A1UxQAw6B
         RtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcNI5shtvN2wJOU93Mywc7wlGb2iuWtSUqO8voYa2pY=;
        b=szEhKz2/VxdF3xZRz7wGhzVGnC0jnGf0azLlK8/FbsISIVunXN+O98mGUWiCIEdKz3
         nSxHEZeEqBY2tX4S5Z82q6v40PRnrU7RHWUkgUsTHy0ZlCtg63dg//L4gtOuBsp+Q4ip
         qrbBNNGbG9WjiPWMlc93hf3Zzc3vWivNeI8G9h8cc0t7li2D+WhwY26Dj23twdY5X3cJ
         iZtcB4cxpDHWKRZp/MoyAcr0NO/3xO+WTgROexM8NFZgvfqGUXpCrBh1BjNgJyBmCF/V
         J3OVjom4NLOWQuIz8KUKl1Gl/JjLMDGAM84AFn1nqPxo+GCNNXgvgGA8mtdtOFHsm/Qz
         h/hg==
X-Gm-Message-State: APjAAAUEJ6lmwvJYM3yoQKVOFByaoEXHrnt1yYYbPCcxjD25NKustmnT
        /n7RvNKuxbHYeLWbdjslhNeRKM5wkOEZbwZe6aQ=
X-Google-Smtp-Source: APXvYqzgAG1foExF4VSUCfqorNhZDgm6mrkjug0Q1kSheYGKkQADpWS/EOlBjpYp2ke5WmkU486QIEgVGz91JDKiuLk=
X-Received: by 2002:ab0:20d8:: with SMTP id z24mr7543017ual.1.1565995152764;
 Fri, 16 Aug 2019 15:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190726155258.28561-1-newren@gmail.com> <20190815214053.16594-1-newren@gmail.com>
 <20190815214053.16594-5-newren@gmail.com> <xmqqpnl4ztfl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnl4ztfl.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:39:00 -0700
Message-ID: <CABPp-BHuJB6RZ0htNa8Vmah++MiQFTvcGSDpdhtQ1cZBFwZSNQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/24] merge-recursive: provide a better label for
 diff3 common ancestor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 2:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > @@ -3507,6 +3507,11 @@ int merge_recursive(struct merge_options *opt,
> >       struct commit *merged_common_ancestors;
> >       struct tree *mrtree;
> >       int clean;
> > +     int num_merge_bases;
> > +     struct strbuf merge_base_abbrev = STRBUF_INIT;
> > +
> > +     if (!opt->call_depth)
> > +             assert(opt->ancestor == NULL);
>
> Hmph.  Do we have anything to say on this field when call_depth is
> not zero?  Is it OK for opt->ancestor to be sometimes NULL and non
> NULL some other times?

I was specifically trying to add a check for external callers of
merge_recursive() to make sure they called it correctly.  Since
merge_recursive() sets opt->ancestor before calling itself
recursively, I had to hide the assertion behind an if-check, namely on
call_depth.

We could add an assertion that opt->ancestor != NULL when
opt->call_depth > 0, but it seemed odd to document pre-conditions for
how merge_recursive() calls itself.  Anyway, this code block actually
becomes a bit cleaner later in the series when I create  separate
merge_recursive() and merge_recursive_internal() functions, as the
assertion can just go into merge_recursive() and not be protected by
the opt->call_depth check.

> > @@ -3528,6 +3533,7 @@ int merge_recursive(struct merge_options *opt,
> >                       output_commit_title(opt, iter->item);
> >       }
> >
> > +     num_merge_bases = commit_list_count(ca);
>
> Criss-cross merge with very large number of merge bases is rare, so
> it is OK to count them all, even though we only care about "is it
> zero, is it one, or is it two or more?"
>
> I suspect this does not have to count, though, if we really wanted
> to avoid counting.
>
> >       merged_common_ancestors = pop_commit(&ca);
> >       if (merged_common_ancestors == NULL) {
> >               /* if there is no common ancestor, use an empty tree */
>
> Here is the case where we can already decide the ancestor name for
> the later merge_trees() should be "empty tree".
>
> And if merged_common_ancestors is not NULL, ca may have run out (in
> which case, we only have a single merge base), or ca still has
> another merge base (in which case, we have two or more).  So, if you
> add
>                 ancestor_name = "empty tree";
>         } else if (ca) {
>                 ancestor_name = "merged common ancestors";
>         } else {
>                 ancestor_name = abbrev_name(merged_common_ancestors);
>         }
>
> to that if() statement above, that should be sufficient, no?
>
> opt is used for inner merge in the for() loop, so you would probably
> need another "char *" variable without contaminating opt->ancestor_name
> at this point, and then assign the value in the temporary to the
> opt->ancestor field where the original always assigned "merged
> common ancestors".

Sure, I can make these changes.

> > @@ -3568,10 +3574,23 @@ int merge_recursive(struct merge_options *opt,
> >       if (!opt->call_depth)
> >               repo_read_index(opt->repo);
> >
> > -     opt->ancestor = "merged common ancestors";
> > +     switch (num_merge_bases) {
> > +     case 0:
> > +             opt->ancestor = "<empty tree>";
>
> Also, I do not see a reason why you want angle bra-ket pair around
> "empty tree".  You are already using "merged common ancestors"
> literal phrase without any special marker syntax.

Oh good point; will drop.
