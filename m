Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1EA1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 06:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfG2Gwd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 02:52:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44243 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfG2Gwc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so43349394qke.11
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrZaes8lOBoNxWe6iNrwc1+bWk5nNB9eNAAoxzhCiHI=;
        b=K5IOueJYDvrEyL/gu/XFgDdfXfhilADhOn+1ubHy9iR9N95P+DyB16xri5hegzwkSI
         hdFm8YzOyfVVuvKUEPe+QwwS9S+W7HQy0VGtEuCySdMz3gIwoSazkTEOWFJUv11jLWDb
         vq4yYY68CrdWhDT1Fk+FUhnGLcm5T/ZHlXEGzz96x56Lh0p+oxtkgHqr64iJIWp52zFp
         yi8M3m+YOP7LprSX9acvXem4xAC+HJbsWaDM1t8EZ37hTovsP9riu4wfgyngSUADhaq3
         8b3aJFphl9y6YyJnxiXNBHgRliiaR0g72CkALjcETJIYY+csK5ohfmOhhZXwNwv6VwKt
         o4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrZaes8lOBoNxWe6iNrwc1+bWk5nNB9eNAAoxzhCiHI=;
        b=WlqAu60btmxGYoFcDKiBO1X+GfL+EgIqwymk+EmayQt8KvDfHBOvtPScniSSX9apKP
         f6PBhGmn7V551kOFZUdVivjnUlt4mdpE75PxC1q5H3l5r4sqrr3J+2E/98hx0k9FnT7x
         +EaHcamMEhILrcJschoKA72V7ivG+qc68hNzOK6+SeOGeZehe+sipzPGVbMjDUIh/KsW
         VmPfZnhg1WcYbana/IgK4PBv4rpDvvaKC0UlNU6Cg5u810FbLmQWz85+N9QIVU+jdC1Y
         q+uCCMu8qZTjRY262gplS1+79hamjp8wRiyFoE1a0y5KQiL6ZBy0wAeE6eE2iv++eXvR
         NoWA==
X-Gm-Message-State: APjAAAUkrPvmOQ4HRW9uAECOqXePXf1/ANbR+6RqnltFRQdtgR0E8N11
        UIvZOawrYIN8asdrQJ4ZPwAuSoCuepm61Wr3cRw=
X-Google-Smtp-Source: APXvYqwVNf1WaAHm/QBHqpJeqTV0dms1BHxU/cpZMj2P8gJd/z4DwxvlgcsQ5enqb5DS0dPJ3Y63uy04CYpv6AJLmwE=
X-Received: by 2002:a37:9d15:: with SMTP id g21mr66934035qke.343.1564383151439;
 Sun, 28 Jul 2019 23:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190712150235.12633-1-vcnaik94@gmail.com> <20190726044806.2216-1-vcnaik94@gmail.com>
 <xmqqsgqsodyu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgqsodyu.fsf@gitster-ct.c.googlers.com>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Sun, 28 Jul 2019 23:52:20 -0700
Message-ID: <CAK_rgsFDpW3JhMAc=VBm=WD3drFnV0g=QN15+uZYdsnBTnX_Cg@mail.gmail.com>
Subject: Re: [PATCH v2] reset: unstage empty deleted ita files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 11:20 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Varun Naik <vcnaik94@gmail.com> writes:
>
> > It is possible to delete a committed file from the index and then add it
> > as intent-to-add. After `git reset HEAD`, the file should be identical
> > in the index and HEAD. This patch provides the desired behavior even
> > when the file is empty in the index.
>
> The first and the second sentence describes what you want to achieve
> concisely and sensibly.  There is a vast leap between them and the
> last sentence.  What's missing is:
>
>  - What goes wrong without this one-liner fix and how does the
>    command make a wrong decision to leave the path 'empty' (in the
>    new test) different from that of the tree of the HEAD?
>
>  - How does the change help the machinery to make a right decision
>    instead?
>
> I had to briefly wonder if this change interacts with "reset -N" in
> any way.  In that mode, we want to make sure that diff sees the
> entries that are missing from the index that exist in the tree of
> the HEAD, so that update_index_from_diff() can add them back to the
> index as I-T-A entries.
>
> Making I-T-A entries invisible in the index for the purpose of
> running that diff would mean that they appear as removed, but it is
> OK because we'll add them back as I-T-A entries anyway, so it all
> evens out, I think.
>
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 26ef9a7bd0..47a088f4b7 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -163,6 +163,7 @@ static int read_from_tree(const struct pathspec *pathspec,
> >       opt.format_callback_data = &intent_to_add;
> >       opt.flags.override_submodule_config = 1;
> >       opt.repo = the_repository;
> > +     opt.ita_invisible_in_index = 1;
> >
> >       if (do_diff_cache(tree_oid, &opt))
> >               return 1;
> > diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> > index 97be0d968d..9f3854e8f0 100755
> > --- a/t/t7102-reset.sh
> > +++ b/t/t7102-reset.sh
> > @@ -566,4 +566,15 @@ test_expect_success 'reset --mixed sets up work tree' '
> >       test_must_be_empty actual
> >  '
> >
> > +test_expect_success 'reset --mixed adds deleted intent-to-add file back to index' '
> > +     echo "nonempty" >nonempty &&
> > +     >empty &&
> > +     git add nonempty empty &&
> > +     git commit -m "create files to be deleted" &&
> > +     git rm --cached nonempty empty &&
> > +     git add -N nonempty empty &&
> > +     git reset HEAD nonempty empty &&
> > +     git diff --staged --exit-code
>
> We are not testing if the "diff --staged" synonym (that is not even
> in "git diff --help") behaves identically to "diff --cached" here
> (if we wanted to do such a test, we should do so somewhere in t4xxx
> series, not here), so let's spell it in the canonical form, like so:
>
>         git diff --cached --exit-code HEAD
>
> At this point, we have three paths (empty, nonempty and secondfile)
> in the tree of the HEAD, and we just resetted the entries for the
> first two paths in the index to match.  The 'secondfile' added, in
> previous tests, is still there unchanged, and is not shown in the
> diff output.  The 'new-file', added as I-T-A in previous tests, is
> also still there unchanged, and is not shown in the diff output.
>

To guard against changes to the test cases in the future, would it be
better if I write something like the following instead?
    git diff --cached --exit-code HEAD nonempty empty

> How does the internal do_diff_cache() behave differently before and
> after this patch on 'empty' and 'nonempty'?  How does the difference
> affect the final outcome of "git reset" operation?
>
>  - without ita-is-invisible bit set, we end up comparing the mode
>    and blob object name; for 'nonempty', HEAD records a blob object
>    name for the non-empty content, but the index has an empty blob
>    object name (with I-T-A bit set, but that does not participate in
>    the diff operation at the level of diff-lib.c::do_oneway_diff())
>    and are deemed "modified".  Even though we should say "deleted",
>    the end result turns out to be the same---we restore from the
>    tree of the HEAD.
>
>  - however, for 'empty', we mistakenly end up saying "both are empty
>    blobs, so no difference; nothing to be done", leaving the i-t-a
>    entry in the index.
>
>  - with ita-is-invisible bit set, both 'nonempty' and 'empty' are
>    immediately marked as "deleted" in do_oneway_diff().  This causes
>    both paths to be resurrected from the tree of the HEAD the same
>    way.
>
> With the above kind of analysis, a reader can fill in the leap in
> the explanation between the second and the third sentence in the
> proposed log message.  But we shouldn't force readers to make that
> effort to understand how the patch was meant to improve things.
>

Thank you for the detailed explanation, this really helped me
understand the internals of do_diff_cache(). While adjusting my commit
message, I realized that my change actually breaks `git reset HEAD`
for ita files (i.e. after `git add -N nonempty` and `git reset HEAD
nonempty`, the file is still marked as intent-to-add). So, instead of
setting the flag ita_invisible_in_index to 1 before calling
do_diff_cache(), we want to handle a specific edge case deep inside
the diff machinery. It looks like I fixed another bug in the process,
so I will write a test case for that and then send out v3.

> Thanks.
>
> > +'
> > +
> >  test_done
