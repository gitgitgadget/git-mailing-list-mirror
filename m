Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7161F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 18:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbeGKS2u (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 14:28:50 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44884 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbeGKS2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 14:28:50 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so14947560vke.11
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrGJzuYfy6aeeuTH2WGMsfSaRvzNNJfrLznE1QoQ4X0=;
        b=CiHOVjFxbV34gwn8WBHaVEBM0k0vdgAyV31CumlNPmSL7UCXAnFU922QV2FI1dDHIi
         YrI3HpXDVmIHR742hvVKRR313iU5DdELf2lKPt/MKkDgiquwR2z2RqLEMVoxUQUq0V/U
         c9pGbb8UjCThH0ZiZWShslB2LhvLpjCuhHMgTIosUghff1aP5QWoOT7MIUcqGbhfihTM
         uCbRSUC+t7HRESXzyloiOWzE5FRuRpfYBA2w7CW1sOLI1zLW3DVofJtz4N6DL8VgROY5
         Tk5AunhEPNq1R6yOlf/z5SgYl8wwSkXey8iO/lDgU7YJyHkew52F8Cq++5rDd/YHuZt1
         miAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrGJzuYfy6aeeuTH2WGMsfSaRvzNNJfrLznE1QoQ4X0=;
        b=ncYDfGYTxD3HF+WB5qFD2zvZ28COk/+KeAe90SKMabG6AHlpbOK0sd3ZiV+ilYURFV
         PWwTxcntHBizuxOj2MaXJpJPS+tEokGgp1HhTy9zszpUJO+fDOdZYtNKxRmXzri5Lv34
         /XLGZ9uxjvOeUIRbsi6E5HBKZMPVy5YabPqbYLWslP//tHcSRHeXD/sMAsKwP5Xp1bux
         IqSY+UpuC7qazSoaZX9N6vpX6iXTHjB6cWg4n2+EkuoW8SMkAJlMnfjX6scbhoeTPFfi
         sOwwdOag9cOJJz2YtsON81pp8Y8OS76xfkOIIGGM4kdXbUCpsFbqlhBWuqfZYUpi/Nmt
         QDhg==
X-Gm-Message-State: APt69E0Teo7OY1nnSFqtNkUXtGiYpqPUY3NRLI1nhcinIiSmIqh25HpD
        gTX55jI/2yfRHFhXsb9SWjJXDwEeHHyD7eqXzV4=
X-Google-Smtp-Source: AAOMgpfNJy2oglRb8TgwchCHyWaIIa3RrUTz78CNRmB+0DaHWFIBzoNaNete3LAxMJH7OPSOsJJ/uHeatPjNymjXr2U=
X-Received: by 2002:a1f:41d4:: with SMTP id o203-v6mr17326964vka.149.1531333397718;
 Wed, 11 Jul 2018 11:23:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:23:17
 -0700 (PDT)
In-Reply-To: <20180711092126.GA17315@flurp.local>
References: <20180711051834.28181-1-newren@gmail.com> <20180711051834.28181-2-newren@gmail.com>
 <20180711092126.GA17315@flurp.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Jul 2018 11:23:17 -0700
Message-ID: <CABPp-BHHkL0Uns9QoeG8LHJgZmfRJu=qAesdpTWJcNmmqhJF9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] t1015: demonstrate directory/file conflict recovery failures
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, Jul 11, 2018 at 2:21 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jul 10, 2018 at 10:18:33PM -0700, Elijah Newren wrote:
>> Several "recovery" commands outright fail or do not fully recover
>> when directory-file conflicts are present.  This includes:
>>   * git read-tree --reset HEAD
>>   * git am --skip
>>   * git am --abort
>>   * git merge --abort
>>   * git reset --hard
>>
>> Add testcases documenting these shortcomings.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
>> @@ -0,0 +1,123 @@
>> +test_expect_success 'setup modify/delete + directory/file conflict' '
>> +     test_create_repo df_plus_modify_delete &&
>> +     (
>> +             cd df_plus_modify_delete &&
>> +
>> +             printf "a\nb\nc\nd\ne\nf\ng\nh\n" >letters &&
>
> test_write_lines a b c d e f g h >letters &&

Copying and modifying an existing testcase, while forgetting to check
for anachronisms, strikes again.  As always, thanks for reviewing and
catching this; I'll fix it up.

>> +             git add letters &&
>> +             git commit -m initial &&
>> +
>> +             git checkout -b modify &&
>> +             # Throw in letters.txt for sorting order fun
>> +             # ("letters.txt" sorts between "letters" and "letters/file")
>> +             echo i >>letters &&
>> +             echo "version 2" >letters.txt &&
>> +             git add letters letters.txt &&
>> +             git commit -m modified &&
>> +
>> +             git checkout -b delete HEAD^ &&
>> +             git rm letters &&
>> +             mkdir letters &&
>> +             >letters/file &&
>> +             echo "version 1" >letters.txt &&
>> +             git add letters letters.txt &&
>> +             git commit -m deleted
>> +     )
>> +'
>> +
>> +test_expect_failure 'read-tree --reset cleans unmerged entries' '
>> +     test_when_finished "git -C df_plus_modify_delete clean -f" &&
>> +     test_when_finished "git -C df_plus_modify_delete reset --hard" &&
>> +     (
>> +             cd df_plus_modify_delete &&
>> +             ...
>> +     )
>> +'
>
> I wonder how much value these distinct repositories add over not using
> them:

In my opinion, that'd be much worse.  Personally, I think we should
move in the opposite direction and try to migrate more of the
testsuite elsewhere towards clearly independent tests.  A huge pet
peeve of mine is that trying to debug a test often requires working
through dozens and dozens of unrelated tests and their setup just to
understand which part of the repository state is related to the test
at hand and which parts can be ignored.  It's happened enough times
that I just intentionally try to make it clear which tests of mine are
independent by making sure they have their own separate repo (and I
used to do a git reset --hard && git clean -fdqx && rm -rf .git && git
init at the beginning of tests).  If folks have a better suggestion
for how to ensure test independence than using test_create_repo, I'm
all ears, but I'm strongly against just adding more files into the
repo than what previous tests did and continuing running from there.
I feel that's especially important for future readers when dealing
with weird edge and corner cases for merges, but I'd really like to
see that clean separation spread throughout the test suite.

> --- >8 ---
> #!/bin/sh
>
> test_description='Test various callers of read_index_unmerged'
> . ./test-lib.sh
>
> test_expect_success 'setup modify/delete + directory/file conflict' '
>         test_write_lines a b c d e f g h >letters &&
>         git add letters &&
>         git commit -m initial &&
>
>         git checkout -b modify &&
>         # Throw in letters.txt for sorting order fun
>         # ("letters.txt" sorts between "letters" and "letters/file")
>         echo i >>letters &&
>         echo "version 2" >letters.txt &&
>         git add letters letters.txt &&
>         git commit -m modified &&
>
>         git checkout -b delete HEAD^ &&
>         git rm letters &&
>         mkdir letters &&
>         >letters/file &&
>         echo "version 1" >letters.txt &&
>         git add letters letters.txt &&
>         git commit -m deleted
> '
>
> test_expect_failure 'read-tree --reset cleans unmerged entries' '
>         test_when_finished "git clean -f" &&
>         test_when_finished "git reset --hard" &&
>
>         git checkout delete^0 &&
>         test_must_fail git merge modify &&
>
>         git read-tree --reset HEAD &&
>         git ls-files -u >conflicts &&
>         test_must_be_empty conflicts
> '
>
> test_expect_failure 'One reset --hard cleans unmerged entries' '
>         test_when_finished "git clean -f" &&
>         test_when_finished "git reset --hard" &&
>
>         git checkout delete^0 &&
>         test_must_fail git merge modify &&
>
>         git reset --hard &&
>         test_path_is_missing .git/MERGE_HEAD &&
>         git ls-files -u >conflicts &&
>         test_must_be_empty conflicts
> '
>
> test_expect_success 'setup directory/file conflict + simple edit/edit' '
>         test_seq 1 10 >numbers &&
>         git add numbers &&
>         git commit -m initial &&
>
>         git checkout -b d-edit &&
>         mkdir foo &&
>         echo content >foo/bar &&
>         git add foo &&
>         echo 11 >>numbers &&
>         git add numbers &&
>         git commit -m "directory and edit" &&
>
>         git checkout -b f-edit d-edit^1 &&
>         echo content >foo &&
>         git add foo &&
>         echo eleven >>numbers &&
>         git add numbers &&
>         git commit -m "file and edit"
> '
>
> test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
>         test_when_finished "git clean -f" &&
>         test_when_finished "git reset --hard" &&
>
>         git checkout f-edit^0 &&
>         test_must_fail git merge d-edit^0 &&
>
>         git merge --abort &&
>         test_path_is_missing .git/MERGE_HEAD &&
>         git ls-files -u >conflicts &&
>         test_must_be_empty conflicts
> '
>
> test_expect_failure 'git am --skip succeeds despite D/F conflict' '
>         test_when_finished "git clean -f" &&
>         test_when_finished "git reset --hard" &&
>
>         git checkout f-edit^0 &&
>         git format-patch -1 d-edit &&
>         test_must_fail git am -3 0001*.patch &&
>
>         git am --skip &&
>         test_path_is_missing .git/rebase-apply &&
>         git ls-files -u >conflicts &&
>         test_must_be_empty conflicts
> '
>
> test_done
> --- >8 ---
