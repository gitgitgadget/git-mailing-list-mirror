Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C441F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJGTMl (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 15:12:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44052 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfJGTMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 15:12:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id u22so13695730qkk.11
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j7HqUTtbTY66j15iLp8MBDOpTNizLHqVJ0JYZNApmKg=;
        b=ZnlpDSQm93yJzd+pMVESp9WeuqZowIh99MJstyibvsT3IYxturvvcbFV+3oglUUofS
         sHxw7A92fZPld+VinL3mV7FlktVMGZUrYLamMo2UegSwNwoDlR/KPtCbBmmOhnq1RjU3
         6BKB/8MxYlq6qgQX6GK1VTmecUUNqwH1RxyvtlrL+C37NzAnk8IOhR9xZ0QzKlmy8JIC
         zR7eUR+J6C1c0LAMk4BJtjGccI6jCuoXv3QMI7VbMZJIU75cO5BKyg1L91X53bXSOa1P
         dQwATc7q+H3kyWg8Z+NDh6DdV122XOGQKY0t2T0PYUiSY8K4iiLnp2NRrlKBwHbq7DPT
         nH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j7HqUTtbTY66j15iLp8MBDOpTNizLHqVJ0JYZNApmKg=;
        b=ebl3F4WtyBAVh8/CE9bi8OHRFUPQ2eF1AUXG7y5fEUyEgxODAx4xProOSHB5yHj3Ia
         Dmw8QU4sW6Elot9KFbG912XbvQCTvq8kVO2vyZXKzpnyj4I/42gPzE96KH3ueyU2nFKX
         w43sPHXydRTHJbaAYH11SVPddl43r+FC0H8/udG3NNFFCVEj978V1k8UvYr+R+rYBphY
         XYuxH/KtNvriyFZrF1K2no+NQfgvKWpym/VaOc+QrHHra0hu6+A+sJDZNJZOQhIH9UJ+
         BxPUB19JMVyKwYCpX8otepD+8e0h5u+RNtFnWI/xfWJnvuuM0aBAsAQWGlajNAcALDHx
         FgDg==
X-Gm-Message-State: APjAAAVLNa6KbuR+B3CFqnK1fLQYcNIrcEmBbl8SAV4e+2Ngqe3VjPtk
        KxpsrRcsw2eSM62KpDAwcymz0kGIFg4=
X-Google-Smtp-Source: APXvYqx3riSgEQxEb/lKdQxza86BSq4CBM5FGU3BEQWm7foXRYTAGTlt/LGZSrSm+qKxDDZiGf58bg==
X-Received: by 2002:a37:f61e:: with SMTP id y30mr14146655qkj.208.1570475559868;
        Mon, 07 Oct 2019 12:12:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1010:7abe:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id l23sm13380151qta.53.2019.10.07.12.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:12:39 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] sparse-checkout: create 'disable' subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
 <b62b76013f98e57089c9b0c03209e28757977dd7.1568904188.git.gitgitgadget@gmail.com>
 <CABPp-BHYCCD+Vx5fq35jH82eHc1-P53Lz_aGNpHJNcx9kg2K-A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b1444dab-24e5-6e4d-bea8-37abc433b546@gmail.com>
Date:   Mon, 7 Oct 2019 15:12:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHYCCD+Vx5fq35jH82eHc1-P53Lz_aGNpHJNcx9kg2K-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2019 12:10 AM, Elijah Newren wrote:
> On Thu, Sep 19, 2019 at 1:46 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The instructions for disabling a sparse-checkout to a full
>> working directory are complicated and non-intuitive. Add a
>> subcommand, 'git sparse-checkout disable', to perform those
>> steps for the user.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/git-sparse-checkout.txt | 26 ++++++++-----------
>>  builtin/sparse-checkout.c             | 37 ++++++++++++++++++++++++---
>>  t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++++
>>  3 files changed, 59 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
>> index 87813e5797..da95b28b1c 100644
>> --- a/Documentation/git-sparse-checkout.txt
>> +++ b/Documentation/git-sparse-checkout.txt
>> @@ -39,6 +39,10 @@ COMMANDS
>>         a list of arguments following the 'set' subcommand. Update the
>>         working directory to match the new patterns.
>>
>> +'disable'::
>> +       Remove the sparse-checkout file, set `core.sparseCheckout` to
>> +       `false`, and restore the working directory to include all files.
> 
> Good, so 'init' (and maybe 'set'?) will set core.sparseCheckout, and
> disable will unset it, so the user doesn't have to worry about it...
> 
>> +
>>  SPARSE CHECKOUT
>>  ----------------
>>
>> @@ -61,6 +65,13 @@ Then it compares the new skip-worktree value with the previous one. If
>>  skip-worktree turns from set to unset, it will add the corresponding
>>  file back. If it turns from unset to set, that file will be removed.
>>
>> +To repopulate the working directory with all files, use the
>> +`git sparse-checkout disable` command.
> 
> Good.
> 
>> +Sparse checkout support in 'git checkout' and similar commands is
>> +disabled by default. You need to set `core.sparseCheckout` to `true`
>> +in order to have sparse checkout support.
> 
> Aren't we having the user use 'git sparse-checkout init' to do that?
> Why guide them to the core.sparseCheckout option?  And why mention it
> without extensions.worktreeConfig?

I'll add a paragraph above the "To repopulate..." to describe using 'init'
and 'set' instead of relying on the old phrasing.

>> +
>>  ## FULL PATTERN SET
>>
>>  By default, the sparse-checkout file uses the same syntax as `.gitignore`
>> @@ -75,21 +86,6 @@ using negative patterns. For example, to remove the file `unwanted`:
>>  !unwanted
>>  ----------------
>>
>> -Another tricky thing is fully repopulating the working directory when you
>> -no longer want sparse checkout. You cannot just disable "sparse
>> -checkout" because skip-worktree bits are still in the index and your working
>> -directory is still sparsely populated. You should re-populate the working
>> -directory with the `$GIT_DIR/info/sparse-checkout` file content as
>> -follows:
>> -
>> -----------------
>> -/*
>> -----------------
> 
> Yaay, glad to see this removed.
> 
>> -Then you can disable sparse checkout. Sparse checkout support in 'git
>> -read-tree' and similar commands is disabled by default. You need to
>> -set `core.sparseCheckout` to `true` in order to have sparse checkout
>> -support.
>>
>>  SEE ALSO
>>  --------
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index f726fcd6b8..f858f0b1b5 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -8,7 +8,7 @@
>>  #include "strbuf.h"
>>
>>  static char const * const builtin_sparse_checkout_usage[] = {
>> -       N_("git sparse-checkout [init|list|set] <options>"),
>> +       N_("git sparse-checkout [init|list|set|disable] <options>"),
>>         NULL
>>  };
>>
>> @@ -74,7 +74,7 @@ static int update_working_directory(void)
>>         return result;
>>  }
>>
>> -static int sc_enable_config(void)
>> +static int sc_set_config(int mode)
> 
> Nice to see this change from the RFC round; do we want to use an enum
> instead of an int, or is the int good enough?  (No strong opinion
> here, just asking.)

I'll use an enum in v3.

>>  {
>>         struct argv_array argv = ARGV_ARRAY_INIT;
>>
>> @@ -83,7 +83,12 @@ static int sc_enable_config(void)
>>                 return 1;
>>         }
>>
>> -       argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
>> +       argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
>> +
>> +       if (mode)
>> +               argv_array_pushl(&argv, "true", NULL);
>> +       else
>> +               argv_array_pushl(&argv, "false", NULL);
>>
>>         if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>>                 error(_("failed to enable core.sparseCheckout"));
>> @@ -101,7 +106,7 @@ static int sparse_checkout_init(int argc, const char **argv)
>>         int res;
>>         struct object_id oid;
>>
>> -       if (sc_enable_config())
>> +       if (sc_set_config(1))
>>                 return 1;
>>
>>         memset(&pl, 0, sizeof(pl));
>> @@ -188,6 +193,28 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>>         return write_patterns_and_update(&pl);
>>  }
>>
>> +static int sparse_checkout_disable(int argc, const char **argv)
>> +{
>> +       char *sparse_filename;
>> +       FILE *fp;
>> +
>> +       if (sc_set_config(1))
>> +               die(_("failed to change config"));
>> +
>> +       sparse_filename = get_sparse_checkout_filename();
>> +       fp = fopen(sparse_filename, "w");
>> +       fprintf(fp, "/*\n");
>> +       fclose(fp);
>> +
>> +       if (update_working_directory())
>> +               die(_("error while refreshing working directory"));
>> +
>> +       unlink(sparse_filename);
>> +       free(sparse_filename);
>> +
>> +       return sc_set_config(0);
>> +}
> 
> So we update the .git/info/sparse-checkout file first (or the
> worktree-specific equivalent), then call update_working_directory()
> which can fail -- in particular if the user calls it when they have
> any conflicted files.  But then the sparse-checkout file has already
> been emptied, so it did make some changes, just not all the changes
> the user would expect, leaving them in an intermediate state with an
> error message that doesn't explain how to recover.  Would it be worth
> checking for this case, and telling the user to fix up conflicts then
> re-run the disable command?  Would it make more sense to just replace
> the 'read-tree -mu HEAD' with something that doesn't error out in such
> a case?  Or is this just a shortcoming of an experimental feature that
> we'll get to later?  (I'm okay with the last of those, since we also
> still need to address defaults of several other commands when sparse
> checkouts are active[1].)

I think there are multiple edge cases that make the sparse-checkout
feature worthy of the "experimental" descriptor. To be explicit about
a case where update_working_directory() would fail when the sparse-checkout
file only contains "/*", the only case I can think of is when a user has
written a file outside the current sparse set but HEAD thinks that path
should be a folder (or vice-versa).

We will definitely want to make the feature more robust to these corner
cases, but that will take time. For now, let's get a framework that is
functional for 99% of cases.

And this must be said: none of these changes are permanently damaging.
If a user gets in a strange state due to these corner cases, they are
no worse off than they would be trying to follow the existing directions.

And in v3, I'll add some new commits that help these kinds of cases
during the 'set' operation by not writing to the sparse-checkout file
until the working directory update has succeeded.

> [1] https://public-inbox.org/git/CABPp-BGuFhDwWZBRaD3nA8ui46wor-4=Ha1G1oApsfF8KNpfGQ@mail.gmail.com/
> 
>> +
>>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>>  {
>>         static struct option builtin_sparse_checkout_options[] = {
>> @@ -212,6 +239,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>>                         return sparse_checkout_init(argc, argv);
>>                 if (!strcmp(argv[0], "set"))
>>                         return sparse_checkout_set(argc, argv, prefix);
>> +               if (!strcmp(argv[0], "disable"))
>> +                       return sparse_checkout_disable(argc, argv);
>>         }
>>
>>         usage_with_options(builtin_sparse_checkout_usage,
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index 02ba9ec314..22fa032d6d 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -140,5 +140,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
>>         test_cmp expect dir
>>  '
>>
>> +test_expect_success 'sparse-checkout disable' '
>> +       git -C repo sparse-checkout disable &&
>> +       test_path_is_missing repo/.git/info/sparse-checkout &&
>> +       git -C repo config --list >config &&
>> +       test_i18ngrep "core.sparsecheckout=false" config &&
>> +       ls repo >dir &&
>> +       cat >expect <<-EOF &&
>> +               a
>> +               deep
>> +               folder1
>> +               folder2
>> +       EOF
>> +       test_cmp expect dir
>> +'
>> +
>>  test_done
> 
> The rest of the patch looks good.
> 

