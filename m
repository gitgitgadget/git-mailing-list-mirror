Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71BAB1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbeFABJi (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:09:38 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46329 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeFABJh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:09:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id k86-v6so18680189qkh.13
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DBYqxdffDapDSf5xNP5XZ15VcYQOrmlR9StKuf7i70g=;
        b=o0HIN/8b00PHI/Hbs8zI7EUm0Ujywr0xPMn8VtfkgvoCmR+d+xVSxE9l7lFRzeZidS
         46ZhY+/1cx4OG1n/ZNgVePydMUKhEOC3CBBrFbUqLc4tWK8fWWCnSi8THLtnSZ/qGAo3
         akIG2CTaP/d4/ghoumCvLw7Mw9/MCBRoXdVwsYAzDZRbgCZxlJkZTCVwRd7j07TdrmoI
         TSziFDSTZJfL9s4MimAnnjQkoe7mb1iO5tHGMc3iEIarJcjcfx6dn9EdNf30GNZzF8nL
         ofM71t6bO0ojMhCv1EocZpK5m3yJG5vCBAYr+Hj83pLfA/ItW5FcIEL9fbUFAhKpuJT8
         V2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DBYqxdffDapDSf5xNP5XZ15VcYQOrmlR9StKuf7i70g=;
        b=tMdlBQJriS6c+lw5slzNZ4TFS2wTWj+Z9gBHYsoNqJgYBdi9v/xMeXb6FgraLw3XVu
         RTkxnd1S4HpC6PYNZZYhHDVWT2j9Uf/ysbA26qcPzAtgQh9h64YPIUoaRQKt2xAXiS7P
         MNI7O7p5sQ/5KfKyISd/f2Tyl6IdiS9Mzcdj+tcIpjn2c7K0F2ug0UbvA3fQ6Ps+XA6z
         ehjLY9qQ6Vg+2gKNqUtc7xLQKEkgLnBf6R5JCWAiJu5yC4fvOktYdaAOOzglELJMPGTA
         vz+jOUQ49eYJ5EqwV3xi0je+H9ZivBiTC+6iYgDafHqth5CeF6siE5ijtGaovoSUqj86
         TAEg==
X-Gm-Message-State: APt69E3YDpwaK8INfdH7ZSNYZDX2wVhl3U3ZyKaAsQFgr1sc8UOcneCH
        c9Py11JG4MU/H27+hdAHYGs=
X-Google-Smtp-Source: ADUXVKLoE1NlMOLlJ04RBjMBSRXUUN1NKu0fckuCaZtDe6S3bbHRD9w5ci8UVS86rKht8rrR2EH1HQ==
X-Received: by 2002:ae9:dfc1:: with SMTP id t184-v6mr8515730qkf.274.1527815376522;
        Thu, 31 May 2018 18:09:36 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id c4-v6sm26619545qtj.49.2018.05.31.18.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 18:09:35 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] Fix commit-graph/graft/replace/shallow combo
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>
References: <20180531174024.124488-1-dstolee@microsoft.com>
 <CAGZ79kYCi_=LRuq35Fh0jGYw9kiW9i=6t1YwLuNj7MfezywZDw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2cb85aa9-7c43-78ce-80c6-15d882d9a18b@gmail.com>
Date:   Thu, 31 May 2018 21:09:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYCi_=LRuq35Fh0jGYw9kiW9i=6t1YwLuNj7MfezywZDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/31/2018 2:33 PM, Stefan Beller wrote:
> On Thu, May 31, 2018 at 10:40 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
>> The commit-graph file stores a condensed version of the commit history.
>> This helps speed up several operations involving commit walks. This
>> feature does not work well if those commits "change" using features like
>> commit grafts, replace objects, or shallow clones.
>>
>> Since the commit-graph feature is optional, hidden behind the
>> 'core.commitGraph' config option, and requires manual maintenance (until
>> ds/commit-graph-fsck' is merged), these issues only arise for expert
>> users who decided to opt-in.
>>
>> This RFC is a first attempt at rectify the issues that come up when
>> these features interact. I have not succeeded entirely, as I will
>> discuss below.
>>
>> The first two "DO NOT MERGE" commits are not intended to be part of the
>> main product, but are ways to help the full test suite run while
>> computing and consuming commit-graph files. This is acheived by calling
>> write_commit_graph_reachable() from `git fetch` and `git commit`. I
>> believe this is the only dependence on ds/commit-graph-fsck. The other
>> commits should only depend on ds/commit-graph-lockfile-fix.
> I applied these patches on top of ds/commit-graph-fsck
> (it would have been nice if you mentioned that it applies there)
> Running the test suite with all patches applied results in:
>
> ./t0410-partial-clone.sh                    (Wstat: 256 Tests: 15 Failed: 2)
>    Failed tests:  5, 8
> ./t5307-pack-missing-commit.sh              (Wstat: 256 Tests: 5 Failed: 2)
>    Failed tests:  3-4
> ./t5500-fetch-pack.sh                       (Wstat: 256 Tests: 353 Failed: 1)
>    Failed test:  348
> ./t6011-rev-list-with-bad-commit.sh         (Wstat: 256 Tests: 6 Failed: 1)
>    Failed test:  4
> ./t6024-recursive-merge.sh                  (Wstat: 256 Tests: 6 Failed: 1)
>    Failed test:  4
>
> which you identified as 4x noise and t5500 as not understood.
>
> $ GIT_TRACE=1 ./t5500-fetch-pack.sh -d -i -v -x
> [...]
> expecting success:
> git -C shallow12 fetch --shallow-exclude one origin &&
> git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
> test_write_lines three two >expected &&
> test_cmp expected actual
>
> ++ git -C shallow12 fetch --shallow-exclude one origin
> trace: built-in: git fetch --shallow-exclude one origin
> trace: run_command: unset GIT_PREFIX; 'git-upload-pack
> '\''/u/git/t/trash directory.t5500-fetch-pack/shallow-exclude/.'\'''
> trace: run_command: git --shallow-file  pack-objects --revs --thin
> --stdout --shallow --progress --delta-base-offset --include-tag
> trace: built-in: git pack-objects --revs --thin --stdout --shallow
> --progress --delta-base-offset --include-tag
> remote: Counting objects: 4, done.
> remote: Compressing objects: 100% (3/3), done.
> remote: Total 4 (delta 0), reused 0 (delta 0)
> trace: run_command: git --shallow-file  unpack-objects --pack_header=2,4
> trace: built-in: git unpack-objects --pack_header=2,4
> Unpacking objects: 100% (4/4), done.
> trace: run_command: git rev-list --objects --stdin --not --all --quiet
> trace: built-in: git rev-list --objects --stdin --not --all --quiet
> trace: run_command: unset GIT_PREFIX; 'git-upload-pack
> '\''/u/git/t/trash directory.t5500-fetch-pack/shallow-exclude/.'\'''
> trace: run_command: git pack-objects --revs --thin --stdout --progress
> --delta-base-offset
> trace: built-in: git pack-objects --revs --thin --stdout --progress
> --delta-base-offset
> remote: Total 0 (delta 0), reused 0 (delta 0)
> trace: run_command: git unpack-objects --pack_header=2,0
> trace: built-in: git unpack-objects --pack_header=2,0
> trace: run_command: git rev-list --objects --stdin --not --all --quiet
> trace: built-in: git rev-list --objects --stdin --not --all --quiet
>  From file:///u/git/t/trash directory.t5500-fetch-pack/shallow-exclude/.
>   * [new tag]         one        -> one
>   * [new tag]         two        -> two
> run_processes_parallel: preparing to run up to 1 tasks
> run_processes_parallel: done
> trace: run_command: git gc --auto
> trace: built-in: git gc --auto
> ++ git -C shallow12 log --pretty=tformat:%s origin/master
> trace: built-in: git log '--pretty=tformat:%s' origin/master
> ++ test_write_lines three two
> ++ printf '%s\n' three two
> ++ test_cmp expected actual
> ++ diff -u expected actual
> --- expected 2018-05-31 18:14:25.944540810 +0000
> +++ actual 2018-05-31 18:14:25.944540810 +0000
> @@ -1,2 +1,3 @@
>   three
>   two
> +one
> error: last command exited with $?=1
> not ok 348 - fetch exclude tag one
> #
> # git -C shallow12 fetch --shallow-exclude one origin &&
> # git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
> # test_write_lines three two >expected &&
> # test_cmp expected actual
> #
>
>
>> After these changes, there is one test case that still fails, and I
>> cannot understand why:
>>
>> t5500-fetch-pack.sh                     Failed test:  348
>>
>> This test fails when performing a `git fetch --shallow-exclude`. When I
>> halt the test using `t5500-fetch-pack.sh -d -i` and navigate to the
>> directory to replay the fetch it performs as expected.
> What is "as expected" ?
>
> When I insert a test_pause before that first line, such that:
>
> test_expect_success 'fetch exclude tag one' '
>      test_pause &&
>      git -C shallow12 fetch --shallow-exclude one origin &&
>      git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
>      test_write_lines three two >expected &&
>      test_cmp expected actual
> '
>
> and then run
>
>    rm "shallow-exclude/.git/objects/info/commit-graph
>
> the test works after exiting the test_pause.
>
> Note how the shallow-exclude is the *remote* of the fetch.
> So I think you also want to introduce the destruction
> of commit graphs in upload-pack.c which is the remote counter part to fetch.

Thanks for the details above. I agree that the solution is probably to 
disable the commit-graph during certain upload-pack parameters. 
Something is interfering there. I don't think the "destroy" pattern is 
right here.

> Why do you think these other tests are noice?

Take t5307-pack-missing-commit.sh for a typical example: a repo is 
constructed, a pack is made, and then that pack is manipulated to 
"remove" a commit. That missing commit is "detected" by running 
rev-list. Except if we are running the commit-graph on every 'git 
commit' call, the rev-list now succeeds since we are not looking at the 
packfile for the commit details any more!

This is what I mean by the tests being "noise". Adding the "DO NOT 
MERGE" commits only interrupted the test mechanism for unrelated behavior.

Thanks,

-Stolee

