Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4230AC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349441AbhLDTqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhLDTqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 14:46:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8042C061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 11:43:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so25216350edb.8
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 11:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6ewTzy2vE7N+9+S/mLhiwjQ8mhEG/+wSPNicL1kxbg=;
        b=ckNWvPvLoJoAmYHT+0+ugRy5WVyw4E7LEf8a+TqadeQK92PKpOoYI6rNJFGorniGDc
         80HUkgTerJAGJf20uHfyBRtGKqkSUWGwKdXUbC6kTlpphhUDii4+fyE1AxKi9jIQv105
         js0mTMviuBoHEulaDvAtxixq3BXieO5DjOGAmHP8itQ8Fjy5M/rpyVLuG8XmeV93cYls
         Q9R8AYUMivSedk3lQ2x+MK110mZvVw2Q0WJSuuGOEZN2uQlLjIQee2eiDsSDkyr4JVy1
         WYQGxFEAtzzU9ginCghaxmdfeQot0oRkPX/Mk0sXMt2wZNnu1ldJ+WNK92StJEi15G2Y
         +QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6ewTzy2vE7N+9+S/mLhiwjQ8mhEG/+wSPNicL1kxbg=;
        b=2EQTd4e9Oyj2bml51h3uVIbv6GR/327zIcsHfJYOAFTDfeoK1CW0c1KbOQbb2Z5OmJ
         ONEjXKOaSJ/rMzVZTYnJyxXhI3+MjCpFHnPnqz83ydsYJaQ/lu8FFcRX/VtWwP7bO2yf
         JC7zsIzPB+2gIunhsDP5se/bk+mmnz9WPaJ24BHBfGnR0qWf+Kv8f+i16dPfV8WxsjjG
         t7eg6BXUVZ01g5t21ppIY4JjfUcqfn7Knrh0d1uFFVKZ/WvzmwbDQ29Xd4NtpdAB64pW
         fF0mTX6JK4jWHAjEl0jRpDbxA5ARV3n3KB4hg59+ppIInZN89nXsitQUIyFNx4g8rszt
         oRow==
X-Gm-Message-State: AOAM5326JtSq9q5PvcN9WpEtPlLHE0pd21+PykQSD92/yVFoFTU51ihj
        XyXWeB3fYM/vFEInIer1uV4YWQSQfG7XkZPZ0sx56emh
X-Google-Smtp-Source: ABdhPJyR7Zs9bus5AmUsb1CMjJZpELFEP+0I2bVEK6Ox5/oaUZ2GVP50OG0rYgng6iNj1eXa9WBpY/TDtFeoG5mx32M=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr34420728ejc.74.1638646996280;
 Sat, 04 Dec 2021 11:43:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com> <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Dec 2021 11:43:05 -0800
Message-ID: <CABPp-BFLxHb7XQuJ+cPxm6N-TAJGZ-jeTbfGAemr91q7JJutbw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Sparse Index: diff and blame builtins
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 3, 2021 at 1:16 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series is based on vd/sparse-reset. It integrates the sparse index with
> git diff and git blame and includes:
>
>  1. tests added to t1092 and p2000 to establish the baseline functionality
>     of the commands
>  2. repository settings to enable the sparse index
>
> The p2000 tests demonstrate a ~44% execution time reduction for 'git diff'
> and a ~86% execution time reduction for 'git diff --staged' using a sparse
> index. For 'git blame', the reduction time was ~60% for a file two levels
> deep and ~30% for a file three levels deep.
>
> Test                                         before  after
> ----------------------------------------------------------------
> 2000.30: git diff (full-v3)                  0.33    0.34 +3.0%
> 2000.31: git diff (full-v4)                  0.33    0.35 +6.1%
> 2000.32: git diff (sparse-v3)                0.53    0.31 -41.5%
> 2000.33: git diff (sparse-v4)                0.54    0.29 -46.3%
> 2000.34: git diff --cached (full-v3)         0.07    0.07 +0.0%
> 2000.35: git diff --cached (full-v4)         0.07    0.08 +14.3%
> 2000.36: git diff --cached (sparse-v3)       0.28    0.04 -85.7%
> 2000.37: git diff --cached (sparse-v4)       0.23    0.03 -87.0%
> 2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
> 2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
> 2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
> 2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
> 2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
> 2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
> 2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
> 2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%
>
>
>
> Changes since V1
> ================
>
>  * Fix failing diff partially-staged test in
>    t1092-sparse-checkout-compatibility.sh, which was breaking in seen.
>
>
> Changes since V2
> ================
>
>  * Update diff commit description to include patches that make the checkout
>    and status commands work with the sparse index for readers to reference.
>  * Add new test case to verify diff behaves as expected when run against
>    files outside the sparse checkout cone.
>  * Indent error message in blame commit
>  * Check error message in blame with pathspec outside sparse definition test
>    matches expectations.
>  * Loop blame tests (instead of running the same command multiple time
>    against different files).
>
>
> Changes since V3
> ================
>
>  * Update diff p2000 tests to use --cached instead of --staged. Execute new
>    run and update results in commit description and cover letter.
>  * Update comment on blame with pathspec outside sparse definition test in
>    t1092-sparse-checkout-compatibility.sh to clarify that it tests the
>    current state and could be improved in the future.
>  * Ensure sparse index is only activated when diff is running against files
>    in a Git repo.
>  * BUG if prepare_repo_settings() is called outside a repository.
>  * Ensure sparse index is not activated for calls to blame, checkout, or
>    pack-object with -h.
>  * Ensure commit-graph is only loaded if a git directory exists.
>
>
> Changes since V4
> ================
>
>  * Remove startup_info->have_repository check from checkout, pack-objects,
>    and blame. Update git.c to no longer bypass setup when -h is passed
>    instead.
>  * Move commit-graph, test-read-cache, and repo-settings changes into their
>    own patches with details in commit description of why the changes are
>    being made.
>  * Update t1092-sparse-checkout-compatibility.sh tests to use --cached
>    instead of --staged.
>  * Use 10-character hash abbreviations for commits referenced in diff commit
>    message.
>  * Clarify that being unable to blame files outside the working directory is
>    not supported in either sparse or non-sparse checkouts both in comment on
>    blame with pathspec outside sparse definition test in
>    t1092-sparse-checkout-compatibility.sh and blame commit message.

This round addresses all my concerns from previous rounds.  There's a
trivial typo in the subject of the new patch 1, but feel free to add
my

Reviewed-by: Elijah Newren <newren@gmail.com>

when you resubmit with that fix.  Nice work!
