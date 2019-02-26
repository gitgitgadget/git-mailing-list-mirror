Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4731D20248
	for <e@80x24.org>; Tue, 26 Feb 2019 14:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBZOFP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 09:05:15 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46136 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfBZOFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 09:05:15 -0500
Received: by mail-io1-f66.google.com with SMTP id k21so10500902ior.13
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHI6MC/5YHm3ctjQO/ORfKcYi0myf4DvPOel77FzfmY=;
        b=KlEQdQv9cmrYWd8PlY/VOdlldoerJuiOzDl6XtWQSY+eX4Gt6xZdWo113RV5ffWFWb
         MmiefRHVsh5b9bkfPPwsDsdxHJ1n/gVAHTyKwa5zBuJfEqNrGdSDNQlzcOYyA7kK6iFx
         Ew3aqUq5CZbKbgpYFGYeTqvH20/pEDRbGgiTDkwknEM4SIycOH+T8bu8nTCEmO+Mof9s
         Qo0qHfDh1LbLPer6L5XE/ed0T36XeAwpYkkoj2SzceMc6V9q74MS0yzXKGDhePedro47
         3AVXpD6zpOxwRx/b0ZLq5H1/4763T2T6kgtcQkA+PJJ0hG9w7fFbPsNMxVfAC55+Rz49
         umJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHI6MC/5YHm3ctjQO/ORfKcYi0myf4DvPOel77FzfmY=;
        b=l5pX/nQ5bNl1DoPo+4pbbvy1aW38MxsaExPEoI+k+3wWMKkScyBV5jQS5XM6AnEYZE
         8Q4CenwK1Mgo+TtT4YhdAEoyuvpfBF1EtxxfwuMBIGJtd+86cW3nU/r4GhR7+PFOaInA
         AsxAGWLn/eyHdnzrFlrPlN6ZvjmFW3oVaxBlEvlVvxUwf4zEFXEm9XcgOmtg+bYsq0xq
         h706cZwNdUAtxq7vMSn3RsBZK4uS12ndJDgkqgdbglJJd0TEM4JbkH2FAl1v4OH9tCsh
         LBgos4v8sGYsztLw7Iyuv+yQXzj00ikH823a0k2shUiXxiLN6mlIBimlvHIUQ7BwnEXv
         Xrbg==
X-Gm-Message-State: AHQUAubrowEET4+ksh3UR3fr9Mct16fLHyMe5h9lQkCkK3FTFhUxcPnq
        aWZ1mj3U3lrrR0/Oh/ww0KnPg/KzVG2M+tTcids=
X-Google-Smtp-Source: AHgI3IbB/bfDs/FkzkV+/AtRc1neKKh1t1D43tiF4KrJR6e+DeLnBebkbe1GJuBoFdeS3Qm7IcZqGmWaz+LkG/wvSmE=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr10888371ioc.282.1551189913738;
 Tue, 26 Feb 2019 06:05:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
In-Reply-To: <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Feb 2019 21:04:46 +0700
Message-ID: <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests: replace `test -(d|f)` with test_path_is_(dir|file)
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 8:42 PM Rohit Ashiwal via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>
> t3600-rm.sh: Previously we were using `test -(d|f)`
> to verify the presencee of a directory/file, but we
> already have helper functions, viz, test_path_is_dir
> and test_path_is_file with same functionality. This

It's not just the same (no point replacing then). It's better. When
test_path_is_xxx fails, you get an error message. If "test -xxx"
fails, you get a failed test with no clue what caused it.

> patch will replace `test -(d|f)` calls in t3600-rm.sh.
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  t/t3600-rm.sh | 96 +++++++++++++++++++++++++--------------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index 04e5d42bd3..dcaa2ab4d6 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -137,8 +137,8 @@ test_expect_success 'Re-add foo and baz' '
>  test_expect_success 'Modify foo -- rm should refuse' '
>         echo >>foo &&
>         test_must_fail git rm foo baz &&
> -       test -f foo &&
> -       test -f baz &&
> +       test_path_is_file foo &&
> +       test_path_is_file baz &&
>         git ls-files --error-unmatch foo baz
>  '
>
> @@ -159,8 +159,8 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
>
>  test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
>         test_must_fail git rm foo baz &&
> -       test -f foo &&
> -       test -f baz &&
> +       test_path_is_file foo &&
> +       test_path_is_file baz &&
>         git ls-files --error-unmatch foo baz
>  '
>
> @@ -194,21 +194,21 @@ test_expect_success 'Recursive test setup' '
>
>  test_expect_success 'Recursive without -r fails' '
>         test_must_fail git rm frotz &&
> -       test -d frotz &&
> -       test -f frotz/nitfol
> +       test_path_is_dir frotz &&
> +       test_path_is_file frotz/nitfol
>  '
>
>  test_expect_success 'Recursive with -r but dirty' '
>         echo qfwfq >>frotz/nitfol &&
>         test_must_fail git rm -r frotz &&
> -       test -d frotz &&
> -       test -f frotz/nitfol
> +       test_path_is_dir frotz &&
> +       test_path_is_file frotz/nitfol
>  '
>
>  test_expect_success 'Recursive with -r -f' '
>         git rm -f -r frotz &&
> -       ! test -f frotz/nitfol &&
> -       ! test -d frotz
> +       ! test_path_is_file frotz/nitfol &&
> +       ! test_path_is_dir frotz
>  '
>
>  test_expect_success 'Remove nonexistent file returns nonzero exit status' '
> @@ -254,7 +254,7 @@ test_expect_success 'rm removes subdirectories recursively' '
>         echo content >dir/subdir/subsubdir/file &&
>         git add dir/subdir/subsubdir/file &&
>         git rm -f dir/subdir/subsubdir/file &&
> -       ! test -d dir
> +       ! test_path_is_dir dir
>  '
>
>  cat >expect <<EOF
> @@ -343,8 +343,8 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
>         git submodule update &&
>         git -C submod checkout HEAD^ &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.modified actual &&
>         git rm -f submod &&
> @@ -359,8 +359,8 @@ test_expect_success 'rm --cached leaves work tree of populated submodules and .g
>         git reset --hard &&
>         git submodule update &&
>         git rm --cached submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno >actual &&
>         test_cmp expect.cached actual &&
>         git config -f .gitmodules submodule.sub.url &&
> @@ -371,7 +371,7 @@ test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
>         git reset --hard &&
>         git submodule update &&
>         git rm -n submod &&
> -       test -f submod/.git &&
> +       test_path_is_file submod/.git &&
>         git diff-index --exit-code HEAD
>  '
>
> @@ -381,8 +381,8 @@ test_expect_success 'rm does not complain when no .gitmodules file is found' '
>         git rm .gitmodules &&
>         git rm submod >actual 2>actual.err &&
>         test_must_be_empty actual.err &&
> -       ! test -d submod &&
> -       ! test -f submod/.git &&
> +       ! test_path_is_dir submod &&
> +       ! test_path_is_file submod/.git &&
>         git status -s -uno >actual &&
>         test_cmp expect.both_deleted actual
>  '
> @@ -393,14 +393,14 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
>         git config -f .gitmodules foo.bar true &&
>         test_must_fail git rm submod >actual 2>actual.err &&
>         test -s actual.err &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git diff-files --quiet -- submod &&
>         git add .gitmodules &&
>         git rm submod >actual 2>actual.err &&
>         test_must_be_empty actual.err &&
> -       ! test -d submod &&
> -       ! test -f submod/.git &&
> +       ! test_path_is_dir submod &&
> +       ! test_path_is_file submod/.git &&
>         git status -s -uno >actual &&
>         test_cmp expect actual
>  '
> @@ -413,8 +413,8 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
>         echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
>         git rm submod >actual 2>actual.err &&
>         test_i18ncmp expect.err actual.err &&
> -       ! test -d submod &&
> -       ! test -f submod/.git &&
> +       ! test_path_is_dir submod &&
> +       ! test_path_is_file submod/.git &&
>         git status -s -uno >actual &&
>         test_cmp expect actual
>  '
> @@ -424,8 +424,8 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
>         git submodule update &&
>         echo X >submod/empty &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.modified_inside actual &&
>         git rm -f submod &&
> @@ -439,8 +439,8 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
>         git submodule update &&
>         echo X >submod/untracked &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.modified_untracked actual &&
>         git rm -f submod &&
> @@ -493,8 +493,8 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
>         git -C submod checkout HEAD^ &&
>         test_must_fail git merge conflict2 &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.conflict actual &&
>         git rm -f submod &&
> @@ -512,8 +512,8 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
>         echo X >submod/empty &&
>         test_must_fail git merge conflict2 &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.conflict actual &&
>         git rm -f submod &&
> @@ -531,8 +531,8 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
>         echo X >submod/untracked &&
>         test_must_fail git merge conflict2 &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.conflict actual &&
>         git rm -f submod &&
> @@ -552,13 +552,13 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
>         ) &&
>         test_must_fail git merge conflict2 &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -d submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_dir submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.conflict actual &&
>         test_must_fail git rm -f submod &&
> -       test -d submod &&
> -       test -d submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_dir submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.conflict actual &&
>         git merge --abort &&
> @@ -586,8 +586,8 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
>                 rm -r ../.git/modules/sub
>         ) &&
>         git rm submod 2>output.err &&
> -       ! test -d submod &&
> -       ! test -d submod/.git &&
> +       ! test_path_is_dir submod &&
> +       ! test_path_is_dir submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test -s actual &&
>         test_i18ngrep Migrating output.err
> @@ -624,8 +624,8 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
>         git submodule update --recursive &&
>         git -C submod/subsubmod checkout HEAD^ &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.modified_inside actual &&
>         git rm -f submod &&
> @@ -639,8 +639,8 @@ test_expect_success 'rm of a populated nested submodule with nested modification
>         git submodule update --recursive &&
>         echo X >submod/subsubmod/empty &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.modified_inside actual &&
>         git rm -f submod &&
> @@ -654,8 +654,8 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
>         git submodule update --recursive &&
>         echo X >submod/subsubmod/untracked &&
>         test_must_fail git rm submod &&
> -       test -d submod &&
> -       test -f submod/.git &&
> +       test_path_is_dir submod &&
> +       test_path_is_file submod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test_cmp expect.modified_untracked actual &&
>         git rm -f submod &&
> @@ -673,8 +673,8 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
>                 GIT_WORK_TREE=. git config --unset core.worktree
>         ) &&
>         git rm submod 2>output.err &&
> -       ! test -d submod &&
> -       ! test -d submod/subsubmod/.git &&
> +       ! test_path_is_dir submod &&
> +       ! test_path_is_dir submod/subsubmod/.git &&
>         git status -s -uno --ignore-submodules=none >actual &&
>         test -s actual &&
>         test_i18ngrep Migrating output.err
> --
> gitgitgadget



-- 
Duy
