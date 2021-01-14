Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74630C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F9E2395C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 06:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbhANGjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 01:39:52 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33309 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbhANGjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 01:39:51 -0500
Received: by mail-ed1-f47.google.com with SMTP id g21so4580687edy.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 22:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ecqyI3FX3Tl3R3Dc07VdKpdScZtD0ZbLoyX179Za98=;
        b=Uxz1pdzRne13iaYi4bwX7rnuJa8rInUHYcZO1dIAr6SoMF5NvR0d/56LH6WtCnq3T4
         rosk7VQjz1rkDkaDYSFkoITmka8mkGRIS7W6U/cPmletjqR00jRQ9Qft8SwlMmZ8vQ3p
         NM0gfDEPwqhG0UxXFb5nEWjvC72hiImKyuV1NiullyYw7JMv8Dozv07du+UUODewNhhY
         tV/EnS02oVjbaK+zIxBLuoh3udxaGYYkKuoDTinUnPHCdezF1tTKdDe8TvRu24GYfyxf
         t9KMtgEr1O811WTqI/tcBw7ZP3jTEZXbyr5t5PW3gwCvJLtIbQGKrOd4FNWXEhniWqCA
         XNXg==
X-Gm-Message-State: AOAM533l8YH+32iJlS8Ro5rwPOit8+VIg46Aa4FnpnaECZyLHl5kCK79
        /gZ104gffWzEAB7lNkr/8Oajr0nTQz2Neki+I4k=
X-Google-Smtp-Source: ABdhPJz6xdEgTzWbAIYq3IKe5F41vlfYULK18SIPV2pCRtEF05Sluj873GfiHsylcuJteqyVaT4ynFqYMxED2Bd3Z+k=
X-Received: by 2002:a50:9310:: with SMTP id m16mr4637121eda.94.1610606349130;
 Wed, 13 Jan 2021 22:39:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
 <pull.832.v2.git.1610116600.gitgitgadget@gmail.com> <a09a5098aa66ea0ed89fe0fcde3f016b4a65814d.1610116600.git.gitgitgadget@gmail.com>
In-Reply-To: <a09a5098aa66ea0ed89fe0fcde3f016b4a65814d.1610116600.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 14 Jan 2021 01:38:58 -0500
Message-ID: <CAPig+cT+1XZbg3Nv15Hfsmc0qLTku0iMvp0dOjuebv_55D1OSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] builtin:ls-files.c:add git ls-file --dedup option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 9:36 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> builtin:ls-files.c:add git ls-file --dedup option

This subject concisely explains the purpose of the patch. That's good.
A more typical way to write it would be:

    ls-files: add --dedup option

> This commit standardizes the code format.

Fixing problems pointed out by reviewers is good. Normally, however,
when you submit a new version of your patch or patch series, you
should apply these fixes directly to the patch(es) which introduced
the problems in the first place rather than adding one or more
additional patches to fix problems introduced in earlier patches. To
do this, you typically would use `git rebase -i` or `git commit
--amend` to squash the fixes into the problematic patches. Thus, when
you re-submit the patches, they will appear to be "perfect".

For this particular two-patch series, patch [2/2] is doing two things:
(1) fixing style problems from patch [1/2], and (2) adding
documentation and tests which logically belong with the feature added
by patch [1/2]. Taking the above advice into account, a better
presentation when you re-submit this series would be to squash these
two patches into a single patch.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> @@ -81,6 +82,9 @@ OPTIONS
> +--dedup::
> +       Suppress duplicates entries when conflicts happen or
> +       specify -d -m at the same time.

For consistency with typesetting elsewhere in this file, use backticks
around the command-line options. It also often is a good idea to spell
the options using long form since it is typically easier to search for
the long form of an option in documentation. So, perhaps the above can
be written like this:

    Suppress duplicate entries when `--deleted` and `--modified` are
    combined.

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> -       const struct cache_entry *last_stage=NULL;
> +       const struct cache_entry *last_stage = NULL;
> -                       if(show_cached && delete_dup){
> +                       if (show_cached && delete_dup) {
> -                                       last_stage=ce;
> +                                       last_stage = ce;
> -                       if(delete_dup){
> +                       if (delete_dup) {
> -                       if(delete_dup && show_deleted && show_modified && err)
> +                       if (delete_dup && show_deleted && show_modified && err)
> -                       else{
> -                               if (show_deleted && err)/* you can't find it,so it's actually removed at all! */
> +                       else {
> +                               if (show_deleted && err)

As mentioned above, these style fixes should be squashed into the
first patch, rather than being done in a separate patch, so that
reviewers see a nicely polished patch rather than a patch which
requires later fixing up.

> diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
> @@ -0,0 +1,63 @@
> +test_expect_success 'master branch setup and write expect1 expect2 and commit' '

We usually give this test a simple title such as "setup" so that we
don't have to worry about the title becoming outdated as people make
changes to the test itself.

> +       touch a.txt &&
> +       touch b.txt &&
> +       touch delete.txt &&

On this project, we use `touch` when the timestamp of the empty files
is important to the test. If the timestamp is not important, then we
just use `>`, like this:

    >a.txt &&
    >b.txt &&
    >delete.txt &&

> +       cat <<-EOF >expect1 &&
> +       M a.txt
> +       H b.txt
> +       H delete.txt
> +       H expect1
> +       H expect2
> +       EOF
> +       cat <<-EOF >expect2 &&
> +       C a.txt
> +       R delete.txt
> +       EOF

When no variables are being interpolated in the here-doc content, we
use -\EOF to let readers know that the here-doc body is literal. So:

    cat >expect1 <<-\EOF &&
    ...
    EOF

> +       git add a.txt b.txt delete.txt expect1 expect2 &&
> +       git commit -m master:1
> +'
> +
> +test_expect_success 'main commit again' '
> +       echo a>a.txt &&
> +       echo b>b.txt &&
> +       echo delete>delete.txt &&
> +       git add a.txt b.txt delete.txt &&
> +       git commit -m master:2
> +'
> +
> +test_expect_success 'dev commit' '
> +       git checkout HEAD~ &&
> +       git switch -c dev &&
> +       echo change>a.txt &&
> +       git add a.txt &&
> +       git commit -m dev:1
> +'

These two tests following the "setup" test also seem to be doing setup
tasks rather than testing the new --dedup functionality. If this is
the case, then it probably would make sense to combine all three tests
into a single "setup" test.

> +test_expect_success 'dev merge master' '
> +       test_must_fail git merge master &&
> +       git ls-files -t --dedup >actual1 &&
> +       test_cmp expect1 actual1 &&
> +       rm delete.txt &&
> +       git ls-files -d -m -t --dedup >actual2 &&
> +       test_cmp expect2 actual2
> +'

Do you foresee that people will add more tests to this file which will
use the files and branches set up by the "setup" test(s)? If not, if
those branches and files are only ever going to be used by this one
test, then it probably would be better to combine all the above code
into a single test.
