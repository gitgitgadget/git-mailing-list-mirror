Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3028C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 15:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiAFPHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 10:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbiAFPHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 10:07:14 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB758C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 07:07:13 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 202so2871268qkg.13
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=47wWfkh4+Qx5l/FQFbRs6wD7JAiazP7brfpU7rQ28zc=;
        b=L0r3VFg9mtOmzx2vveBrZVQidEVF3Ly2rvHAzwZxa+FcCNs2/pSov0ySyuwfd3dka2
         s293xfw50WBinTbTLfTSVlTu6AdW4CLlwzpnUJhJ5Ice0ysXIA1Umr70El0PHLfkkCg/
         2zSooyLFsTh6QVbGa1XGuYjIlnT/Oz4doxvfvLTCCWXc3o8SZy3oRu4acTUwDnajavj9
         NCgZCEbvRur1qRmMZ0UlB4vyz9E+iXbpp+a2s776BYEeKROSuIgg35O+81dINQ6dVapP
         mJgYPlZ5VBrTkNUg97ztYabkTwi/IPf85OnkDHaaUF+hXAeR7w5a5euK65WNdRcKjKwW
         +IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=47wWfkh4+Qx5l/FQFbRs6wD7JAiazP7brfpU7rQ28zc=;
        b=EtACmHkCYbl+LwaRTwmE1sYkgV0quP8xAEcuU0yQ5uhp0oTu3bBt8mwV+UwTO5BfEL
         3l5vRKN0Q+pEoIe1n3AmepTSLu98hMltTckJ1l+6Teo4Td+AoUiLwd2LUm8aKCCLPxoY
         aKfc4RdqyUvtdr5QlMrW+2s76Hz3m7S/IRYN+o/ACOi+qQ7yE+5cP7BS0M5SEqOJGgNQ
         NEJT7Bq2NmyU2vkHZ9s6tOKprA/iLlhLzFsQEgDmBRUtWxsG9vOaPmTmG2caqjyhaxQS
         q8aMfdkYZgCxxe7NjOXIvbSXQM2Ob1WEWCfbqOjcN715rclnciQPnekcxo2TDTxWtiLT
         Dwig==
X-Gm-Message-State: AOAM532UHdYR8xYF8AtJdVkYlOWY8PoEJT5ZheWtkiQ/rVaMwTQM8YwJ
        xyjy+ziQD/WWIZT1Q8cXFJZSWMa+yqPB
X-Google-Smtp-Source: ABdhPJxkxdF9yxnegFogDV8U0GRNtWUdC6OIxqlUCwSTLRIKnUGnSvKS23NuG3XVP0MPToriYH4ebw==
X-Received: by 2002:ae9:f710:: with SMTP id s16mr39963232qkg.528.1641481632851;
        Thu, 06 Jan 2022 07:07:12 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id g19sm1666895qtg.82.2022.01.06.07.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 07:07:12 -0800 (PST)
Message-ID: <ff3faad1-f5e9-c4db-712d-11f8110d1945@github.com>
Date:   Thu, 6 Jan 2022 10:07:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 5/9] checkout-index: add --ignore-skip-worktree-bits
 option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <ec9a751e8dcde99cfaa5c0a855f063de9284057e.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BGCCzgNJEaZ9fgHCkW52ws-ef+00GBhy+LZ5Tx+XkhqDw@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BGCCzgNJEaZ9fgHCkW52ws-ef+00GBhy+LZ5Tx+XkhqDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Update `checkout-index --all` to no longer refresh files that have the
>> `skip-worktree` bit set. The newly-added `--ignore-skip-worktree-bits`
>> option, when used with `--all`, maintains the old behavior and checks out
>> all files regardless of `skip-worktree`.
>>
>> The ability to toggle whether files should be checked-out based on
>> `skip-worktree` already exists in `git checkout` and `git restore` (both of
>> which have an `--ignore-skip-worktree-bits` option).
> 
> I learned something new.
> 
> And ick, what a name.  Why not --ignore-sparsity or something?  Oh well...
> 
>> Adding the option to
>> `checkout-index` (and changing the corresponding default behavior to respect
>> the `skip-worktree` bit) is especially helpful for sparse-checkout: it
>> prevents inadvertent creation of *all* files outside the sparse definition
>> on disk and eliminates the need to expand a sparse index by default when
>> using the `--all` option.
>>
>> Internal usage of `checkout-index` in `git stash` and `git filter-branch` do
>> not make explicit use of files with `skip-worktree` enabled, so
>> `--ignore-skip-worktree-bits` is not added to them.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  Documentation/git-checkout-index.txt     | 11 +++++++++--
>>  builtin/checkout-index.c                 | 12 ++++++++++--
>>  t/t1092-sparse-checkout-compatibility.sh | 10 +++++-----
>>  3 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
>> index 4d33e7be0f5..2815f3d4b19 100644
>> --- a/Documentation/git-checkout-index.txt
>> +++ b/Documentation/git-checkout-index.txt
>> @@ -12,6 +12,7 @@ SYNOPSIS
>>  'git checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
>>                    [--stage=<number>|all]
>>                    [--temp]
>> +                  [--ignore-skip-worktree-bits]
>>                    [-z] [--stdin]
>>                    [--] [<file>...]
>>
>> @@ -37,8 +38,9 @@ OPTIONS
>>
>>  -a::
>>  --all::
>> -       checks out all files in the index.  Cannot be used
>> -       together with explicit filenames.
>> +       checks out all files in the index except for those with the
>> +       skip-worktree bit set (see `--ignore-skip-worktree-bits`).
>> +       Cannot be used together with explicit filenames.
>>
>>  -n::
>>  --no-create::
>> @@ -59,6 +61,11 @@ OPTIONS
>>         write the content to temporary files.  The temporary name
>>         associations will be written to stdout.
>>
>> +--ignore-skip-worktree-bits::
>> +       Check out all files, including those with the skip-worktree bit
>> +       set. Note: may only be used with `--all`; skip-worktree is
>> +       ignored when explicit filenames are specified.
> 
> Why this restriction?  What if the user ran
>    git checkout-index -- '*.c'
> That's not an explicit filename, but a glob.
> 

`checkout-index` doesn't accept globs/pathspecs, so every provided argument
must correspond exactly to an entry in the index. 

I originally restricted '--ignore-skip-worktree-bits' to only work with
'--all' because I wanted changes to the current behavior of `checkout-index`
in a sparse checkout to be as minimal as possible. However, if this is more
"unexpected inconsistency" than "I'm glad checkout-index with filenames
still works the way it did before", I'm happy to change it. 

>> +
>>  --stdin::
>>         Instead of taking list of paths from the command line,
>>         read list of paths from the standard input.  Paths are
>> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
>> index e21620d964e..2053a80103a 100644
>> --- a/builtin/checkout-index.c
>> +++ b/builtin/checkout-index.c
>> @@ -7,6 +7,7 @@
>>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>>  #include "builtin.h"
>>  #include "config.h"
>> +#include "dir.h"
>>  #include "lockfile.h"
>>  #include "quote.h"
>>  #include "cache-tree.h"
>> @@ -116,7 +117,7 @@ static int checkout_file(const char *name, const char *prefix)
>>         return -1;
>>  }
>>
>> -static int checkout_all(const char *prefix, int prefix_length)
>> +static int checkout_all(const char *prefix, int prefix_length, int ignore_skip_worktree)
>>  {
>>         int i, errs = 0;
>>         struct cache_entry *last_ce = NULL;
>> @@ -125,6 +126,8 @@ static int checkout_all(const char *prefix, int prefix_length)
>>         ensure_full_index(&the_index);
>>         for (i = 0; i < active_nr ; i++) {
>>                 struct cache_entry *ce = active_cache[i];
>> +               if (!ignore_skip_worktree && ce_skip_worktree(ce))
>> +                       continue;
> 
> So here I see you let it fall through to the code below that will
> write the file to the working tree...but it doesn't clear the
> SKIP_WORKTREE bit in the index when it does so, which I think is a
> bug.
> 

I disagree, mainly because updating a flag seems inconsistent with how
`checkout-index` otherwise works. Specifically, `checkout-index` creates or
replaces a file on disk (not even necessarily in the git working directory)
based on the file's state in the index, but doesn't modify the index in the
process. The only exception is '-u', which is effectively a shortcut for
running `git update-index --refresh` [1]. 

If a user wants to to checkout a file *and* update `skip-worktree`, I think
explicitly using `update-index` would be a more appropriate way to do that
(similar to the example [2] in the `checkout-index` documentation):

        $ git checkout-index outside-cone/file
        $ git update-index --no-skip-worktree outside-cone/file

[1] https://lore.kernel.org/git/7vis1kvqac.fsf@assigned-by-dhcp.cox.net/
[2] https://git-scm.com/docs/git-checkout-index#Documentation/git-checkout-index.txt-Toupdateandrefreshonlythefilesalreadycheckedout

>>                 if (ce_stage(ce) != checkout_stage
>>                     && (CHECKOUT_ALL != checkout_stage || !ce_stage(ce)))
>>                         continue;
>> @@ -176,6 +179,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>>         int i;
>>         struct lock_file lock_file = LOCK_INIT;
>>         int all = 0;
>> +       int ignore_skip_worktree = 0;
>>         int read_from_stdin = 0;
>>         int prefix_length;
>>         int force = 0, quiet = 0, not_new = 0;
>> @@ -185,6 +189,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>>         struct option builtin_checkout_index_options[] = {
>>                 OPT_BOOL('a', "all", &all,
>>                         N_("check out all files in the index")),
>> +               OPT_BOOL(0, "ignore-skip-worktree-bits", &ignore_skip_worktree,
>> +                       N_("do not skip files with skip-worktree set")),
>>                 OPT__FORCE(&force, N_("force overwrite of existing files"), 0),
>>                 OPT__QUIET(&quiet,
>>                         N_("no warning for existing files and files not in index")),
>> @@ -247,6 +253,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>>
>>                 if (all)
>>                         die("git checkout-index: don't mix '--all' and explicit filenames");
>> +               if (ignore_skip_worktree)
>> +                       die("git checkout-index: don't mix '--ignore-skip-worktree-bits' and explicit filenames");
>>                 if (read_from_stdin)
>>                         die("git checkout-index: don't mix '--stdin' and explicit filenames");
>>                 p = prefix_path(prefix, prefix_length, arg);
>> @@ -280,7 +288,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>>         }
>>
>>         if (all)
>> -               err |= checkout_all(prefix, prefix_length);
>> +               err |= checkout_all(prefix, prefix_length, ignore_skip_worktree);
>>
>>         if (pc_workers > 1)
>>                 err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index db7ad41109b..fad61d96107 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -799,14 +799,14 @@ test_expect_success 'checkout-index with folders' '
>>         test_all_match test_must_fail git checkout-index -f -- folder1/
>>  '
>>
>> -# NEEDSWORK: even in sparse checkouts, checkout-index --all will create all
>> -# files (even those outside the sparse definition) on disk. However, these files
>> -# don't appear in the percentage of tracked files in git status.
>> -test_expect_failure 'checkout-index --all' '
>> +test_expect_success 'checkout-index --all' '
>>         init_repos &&
>>
>>         test_all_match git checkout-index --all &&
>> -       test_sparse_match test_path_is_missing folder1
>> +       test_sparse_match test_path_is_missing folder1 &&
>> +
>> +       test_all_match git checkout-index --ignore-skip-worktree-bits --all &&
>> +       test_all_match test_path_exists folder1
> 
> I added an 'exit 1' here, ran the test and then checked:
> 
> $ cd trash\ directory.t1092-sparse-checkout-compatibility/sparse-checkout/
> $ git ls-files -t | grep folder1/
> S folder1/0/0/0
> S folder1/0/1
> S folder1/a
> 
> So there's some more work to do on this patch.

Unless I'm misreading your comment, this is exactly the behavior I would
expect in this test: all files (even those with `skip-worktree` set, per
'--ignore-skip-worktree-bits') are created on-disk, with `skip-worktree`
unmodified.
