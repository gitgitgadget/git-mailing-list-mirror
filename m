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
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A841F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 19:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfJGTP3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 15:15:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41313 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 15:15:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so13691973qkg.8
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+yZQo6l0GqWMgVq0gGGAjVnzKiqwVsHC1cu+f5k9r9E=;
        b=V0ZJrWuPV1ROqsv6xLSxl4VqGYGuL2EGZqzLkLs3DT608md8SZk24Pki8Z9hHoF0Gg
         8zaTQturMe7ld0+baq+8nJKCOUdvERcyhz2M4Oqp9Ez85OcPlQW5gmmA8+GXyQS0eiTg
         YhccMJY4zaPz1LZ+VGvNZfMiR3nLYeLCyV+BSqKSx2SZ2AcPIdfL1uwl6NX4uBxizGss
         T4vB31qRpFOBCxDbdODsXREaMBFvjT5E4Kip/6e5xbJn9S3j3IGnZqiHNEtZbZDXC0aH
         JM04vQWzIevLYQYx8drkA4vpTQ+fcf0Ztz7fCSPpLwDsO5SUy72uFddhekirqO80wZk/
         Zdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+yZQo6l0GqWMgVq0gGGAjVnzKiqwVsHC1cu+f5k9r9E=;
        b=J6hW8HKtWqKU5g79Bt/Om28yRQTw1vutYcf3FaZA1/6aFr8lTL9srN0WxT8KYhrAPI
         TUp2HkRPu6nDRMgUbrqfFJnmV+wXEY2YIBlUjeygMA3vGjVxfX6n3/LD5b6KDHc2ar7y
         BGd8nDtodSFlfmwgnXVUS2nxvM+Uc/j6pj12L9UiZV9R5euJ5yYrQhkDf19ev6HdEidw
         yVGfNCD16PrUuryz69/61QfJq1Ro8qfsqf2hn5QAeA9QpSrCIDmQVPoftiDG/ZAAW7E8
         bH5JX7ucaJs0fm0AoLEkssz5+zPzcNahZew5Cto5PsG9RUwCmSTbIbTxVRTadljzfq0G
         66xg==
X-Gm-Message-State: APjAAAVHBDkKeFmuld32JipP6ysMnxehXVmc3yLn9xN5N6684PJh6Zw8
        4C0BwmdylKI0wYy73XbHfoM=
X-Google-Smtp-Source: APXvYqxLyebR0To8YPjiMLsN6Oba9jxC9FRIr84ORYCiN3WcYTwZ4DjnLf+TncVo9FuuAdX5GLARPw==
X-Received: by 2002:a37:8185:: with SMTP id c127mr24264961qkd.420.1570475728029;
        Mon, 07 Oct 2019 12:15:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1010:7abe:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id c126sm8195521qkd.13.2019.10.07.12.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:15:27 -0700 (PDT)
Subject: Re: [PATCH v2 08/11] sparse-checkout: add 'cone' mode
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
 <84511255d1f28e1bdcec3de6096d2d9ac2a9f483.1568904188.git.gitgitgadget@gmail.com>
 <CABPp-BE9HrMyskiMhQ7VxeMvZX_CCurUM_20M6md2UXZG13XEA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <991a2cee-fa1e-547c-c885-a4aaf663d9b6@gmail.com>
Date:   Mon, 7 Oct 2019 15:15:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE9HrMyskiMhQ7VxeMvZX_CCurUM_20M6md2UXZG13XEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2019 12:22 AM, Elijah Newren wrote:
> On Thu, Sep 19, 2019 at 1:45 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The sparse-checkout feature can have quadratic performance as
>> the number of patterns and number of entries in the index grow.
>> If there are 1,000 patterns and 1,000,000 entries, this time can
>> be very significant.
>>
>> Create a new Boolean config option, core.sparseCheckoutCone, to
>> indicate that we expect the sparse-checkout file to contain a
>> more limited set of patterns. This is a separate config setting
>> from core.sparseCheckout to avoid breaking older clients by
>> introcuding a tri-state option.
> 
> s/introcuding/introducing/
> 
>> The config option does nothing right now, but will be expanded
>> upon in a later commit.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/config/core.txt         |  7 ++--
>>  Documentation/git-sparse-checkout.txt | 50 +++++++++++++++++++++++++++
>>  cache.h                               |  4 ++-
>>  config.c                              |  5 +++
>>  environment.c                         |  1 +
>>  t/t1091-sparse-checkout-builtin.sh    | 14 ++++++++
>>  6 files changed, 78 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
>> index 75538d27e7..9b8ab2a6d4 100644
>> --- a/Documentation/config/core.txt
>> +++ b/Documentation/config/core.txt
>> @@ -591,8 +591,11 @@ core.multiPackIndex::
>>         multi-pack-index design document].
>>
>>  core.sparseCheckout::
>> -       Enable "sparse checkout" feature. See section "Sparse checkout" in
>> -       linkgit:git-read-tree[1] for more information.
>> +       Enable "sparse checkout" feature. If "false", then sparse-checkout
>> +       is disabled. If "true", then sparse-checkout is enabled with the full
>> +       .gitignore pattern set. If "cone", then sparse-checkout is enabled with
>> +       a restricted pattern set. See linkgit:git-sparse-checkout[1] for more
>> +       information.
> 
> This isn't consistent with the commit message that suggests it's a new
> option rather than a new possible value for an old option.

Thanks for the catch. I forgot to update the docs. Fixed for v3.

>>  core.abbrev::
>>         Set the length object names are abbreviated to.  If
>> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
>> index da95b28b1c..757326618d 100644
>> --- a/Documentation/git-sparse-checkout.txt
>> +++ b/Documentation/git-sparse-checkout.txt
>> @@ -87,6 +87,56 @@ using negative patterns. For example, to remove the file `unwanted`:
>>  ----------------
>>
>>
>> +## CONE PATTERN SET
>> +
>> +The full pattern set allows for arbitrary pattern matches and complicated
>> +inclusion/exclusion rules. These can result in O(N*M) pattern matches when
>> +updating the index, where N is the number of patterns and M is the number
>> +of paths in the index. To combat this performance issue, a more restricted
>> +pattern set is allowed when `core.spareCheckoutCone` is enabled.
>> +
>> +The accepted patterns in the cone pattern set are:
>> +
>> +1. *Recursive:* All paths inside a directory are included.
>> +
>> +2. *Parent:* All files immediately inside a directory are included.
>> +
>> +In addition to the above two patterns, we also expect that all files in the
>> +root directory are included. If a recursive pattern is added, then all
>> +leading directories are added as parent patterns.
>> +
>> +By default, when running `git sparse-checkout init`, the root directory is
>> +added as a parent pattern. At this point, the sparse-checkout file contains
>> +the following patterns:
>> +
>> +```
>> +/*
>> +!/*/
>> +```
>> +
>> +This says "include everything in root, but nothing two levels below root."
>> +If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
>> +`A/B` are added as parent patterns. The resulting sparse-checkout file is
>> +now
>> +
>> +```
>> +/*
>> +!/*/
>> +/A/
>> +!/A/*/
>> +/A/B/
>> +!/A/B/*/
>> +/A/B/C/
>> +```
>> +
>> +Here, order matters, so the negative patterns are overridden by the positive
>> +patterns that appear lower in the file.
>> +
>> +If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
>> +expecting patterns of these types. Git will warn if the patterns do not match.
>> +If the patterns do match the expected format, then Git will use faster hash-
>> +based algorithms to compute inclusion in the sparse-checkout.
>> +
>>  SEE ALSO
>>  --------
>>
>> diff --git a/cache.h b/cache.h
>> index cf5d70c196..8e8ea67efa 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -911,12 +911,14 @@ extern char *git_replace_ref_base;
>>
>>  extern int fsync_object_files;
>>  extern int core_preload_index;
>> -extern int core_apply_sparse_checkout;
>>  extern int precomposed_unicode;
>>  extern int protect_hfs;
>>  extern int protect_ntfs;
>>  extern const char *core_fsmonitor;
>>
>> +int core_apply_sparse_checkout;
>> +int core_sparse_checkout_cone;
>> +
>>  /*
>>   * Include broken refs in all ref iterations, which will
>>   * generally choke dangerous operations rather than letting
>> diff --git a/config.c b/config.c
>> index 296a6d9cc4..f65c74f5b7 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1329,6 +1329,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>>                 return 0;
>>         }
>>
>> +       if (!strcmp(var, "core.sparsecheckoutcone")) {
>> +               core_sparse_checkout_cone = git_config_bool(var, value);
>> +               return 0;
>> +       }
>> +
>>         if (!strcmp(var, "core.precomposeunicode")) {
>>                 precomposed_unicode = git_config_bool(var, value);
>>                 return 0;
>> diff --git a/environment.c b/environment.c
>> index 89af47cb85..670d92bcc0 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -69,6 +69,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>>  char *notes_ref_name;
>>  int grafts_replace_parents = 1;
>>  int core_apply_sparse_checkout;
>> +int core_sparse_checkout_cone;
>>  int merge_log_config = -1;
>>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>>  unsigned long pack_size_limit_cfg;
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index 22fa032d6d..9b089c98c4 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -140,6 +140,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
>>         test_cmp expect dir
>>  '
>>
>> +test_expect_success 'cone mode: match patterns' '
>> +       git -C repo config --worktree core.sparseCheckoutCone true &&
>> +       rm -rf repo/a repo/folder1 repo/folder2 &&
>> +       git -C repo read-tree -mu HEAD &&
>> +       git -C repo reset --hard &&
>> +       ls repo >dir  &&
>> +       cat >expect <<-EOF &&
>> +               a
>> +               folder1
>> +               folder2
>> +       EOF
>> +       test_cmp expect dir
>> +'
>> +
>>  test_expect_success 'sparse-checkout disable' '
>>         git -C repo sparse-checkout disable &&
>>         test_path_is_missing repo/.git/info/sparse-checkout &&
>> --
>> gitgitgadget
> 
> What if core.sparseCheckoutCone is true but core.sparseCheckout is
> false?  Is that an error case we warn the user about, or do we make
> sense of it somehow?

`core.sparseCheckoutCone` means "when you are doing sparse-checkout things,
try to use the fast logic assuming you have the cone patterns." It does not
enable the sparse-checkout on its own. It only changes run-time performance.

This is important for compatibility with other clients that will only look
at `core.sparseCheckout`.

Thanks,
-Stolee

