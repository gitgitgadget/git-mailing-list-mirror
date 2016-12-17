Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0971FF40
	for <e@80x24.org>; Sat, 17 Dec 2016 02:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934983AbcLQCZN (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 21:25:13 -0500
Received: from mail-wj0-f177.google.com ([209.85.210.177]:33878 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934965AbcLQCZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 21:25:11 -0500
Received: by mail-wj0-f177.google.com with SMTP id tg4so106676985wjb.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 18:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanburgh.me; s=google;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=ZNtByHul1SXKazWYEeSZF/G+avd04rgqnav/SDdppAM=;
        b=Fo3HyyrbokqrRT8TP+ooB2bPrUmMcR/zaXHWBY+NfA57vPSqhPjdo9Vu7WpoIhpP2x
         wkCMR9GLbQVx+mWpBiTSHDjoxGHL+gyI7Oskpb8tGUpqaH3kWA8pq2+yCV7NcFfhZ6Z5
         adLlqdG0rz4TnH7iTuiE45N9uhHm7sLFAk7Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=ZNtByHul1SXKazWYEeSZF/G+avd04rgqnav/SDdppAM=;
        b=LXrBvyspQd6udU8KrNmmBTYtQqXUl1RIX0Q8/Z3f9+eSk5hBMyH+O8kPwSt0MjbIsF
         LGxoKLwIvqO0u9OCsTxz4xnBQ4ZCnBHFz44uHtsgjAMFywrNwg87VS1uO1NV6C4JyvQc
         RxMNZhmhaPnNGiGkjBlBQeRRqVtBcSeBtlAv1U3nU/MlU6rJtJkOi78/2SJqpD93bO3R
         pw21gMA76mT8t7PNLy/gl+UPR9MyBDFQH5YJaSYpuK3yKU1MHAeMzTRVnlDpt5dbGPMs
         CBMvgThI5xe2a9vLg+ZYbG/e7LFrg7pWjOlfr8JsX3e0V4e8Jy6B0X51lArDYvA1bDtV
         FwTg==
X-Gm-Message-State: AIkVDXLkEhN31MtZpcP1Vsjx1RBXHw28DWH5mdykvBbSW9mgbdmSL6hfnHUyqgpGqEYq8Q==
X-Received: by 10.194.177.231 with SMTP id ct7mr5105292wjc.221.1481941509708;
        Fri, 16 Dec 2016 18:25:09 -0800 (PST)
Received: from [10.146.153.89] (92.40.248.113.threembb.co.uk. [92.40.248.113])
        by smtp.gmail.com with ESMTPSA id f10sm9315609wjl.28.2016.12.16.18.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Dec 2016 18:25:09 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAE5ih7-+tahL4=OrW6F6UPKKRg1KFkw32e=pnTx6j2WTZ-BhOw@mail.gmail.com>
References: <01020159037a8995-2d1da9d4-4a27-4b98-818b-432fc0ad8a52-000000@eu-west-1.amazonses.com> <CAE5ih7-+tahL4=OrW6F6UPKKRg1KFkw32e=pnTx6j2WTZ-BhOw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] git-p4: Fix multi-path changelist empty commits
From:   George Vanburgh <george@vanburgh.me>
Date:   Sat, 17 Dec 2016 03:25:03 +0100
To:     Luke Diamand <luke@diamand.org>
CC:     Git Users <git@vger.kernel.org>
Message-ID: <2BE8EE6F-F718-475A-A2BA-483F39F5B9A0@vanburgh.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17 December 2016 01:47:55 CET, Luke Diamand <luke@diamand.org> wrote:
>On 15 December 2016 at 17:14, George Vanburgh <george@vanburgh.me>
>wrote:
>> From: George Vanburgh <gvanburgh@bloomberg.net>
>>
>> When importing from multiple perforce paths - we may attempt to
>import a changelist that contains files from two (or more) of these
>depot paths. Currently, this results in multiple git commits - one
>containing the changes, and the other(s) as empty commits. This
>behavior was introduced in commit 1f90a64 ("git-p4: reduce number of
>server queries for fetches", 2015-12-19).
>
>That's definitely a bug, thanks for spotting that! Even more so for
>adding a test case.

Not a problem - thanks to you guys for maintaining such an awesome tool!

>
>>
>> Reproduction Steps:
>>
>> 1. Have a git repo cloned from a perforce repo using multiple depot
>paths (e.g. //depot/foo and //depot/bar).
>> 2. Submit a single change to the perforce repo that makes changes in
>both //depot/foo and //depot/bar.
>> 3. Run "git p4 sync" to sync the change from #2.
>>
>> Change is synced as multiple commits, one for each depot path that
>was affected.
>>
>> Using a set, instead of a list inside p4ChangesForPaths() ensures
>that each changelist is unique to the returned list, and therefore only
>a single commit is generated for each changelist.
>
>The change looks good to me apart from one missing "&&" in the test
>case (see below).

Oops - I'll correct that and resubmit :)

>Possibly need to rewrap the comment line (I think there's a 72
>character limit) ?

Sure - I'll fix that in the resubmission

>
>Luke
>
>
>>
>> Reported-by: James Farwell <jfarwell@vmware.com>
>> Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
>> ---
>>  git-p4.py               |  4 ++--
>>  t/t9800-git-p4-basic.sh | 22 +++++++++++++++++++++-
>>  2 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index fd5ca52..6307bc8 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -822,7 +822,7 @@ def p4ChangesForPaths(depotPaths, changeRange,
>requestedBlockSize):
>>                  die("cannot use --changes-block-size with
>non-numeric revisions")
>>              block_size = None
>>
>> -    changes = []
>> +    changes = set()
>>
>>      # Retrieve changes a block at a time, to prevent running
>>      # into a MaxResults/MaxScanRows error from the server.
>> @@ -841,7 +841,7 @@ def p4ChangesForPaths(depotPaths, changeRange,
>requestedBlockSize):
>>
>>          # Insert changes in chronological order
>>          for line in reversed(p4_read_pipe_lines(cmd)):
>> -            changes.append(int(line.split(" ")[1]))
>> +            changes.add(int(line.split(" ")[1]))
>>
>>          if not block_size:
>>              break
>> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
>> index 0730f18..4d72e0b 100755
>> --- a/t/t9800-git-p4-basic.sh
>> +++ b/t/t9800-git-p4-basic.sh
>> @@ -131,6 +131,26 @@ test_expect_success 'clone two dirs, @all,
>conflicting files' '
>>         )
>>  '
>>
>> +test_expect_success 'clone two dirs, each edited by submit, single
>git commit' '
>> +       (
>> +               cd "$cli" &&
>> +               echo sub1/f4 >sub1/f4 &&
>> +               p4 add sub1/f4 &&
>> +               echo sub2/f4 >sub2/f4 &&
>> +               p4 add sub2/f4 &&
>> +               p4 submit -d "sub1/f4 and sub2/f4"
>> +       ) &&
>> +       git p4 clone --dest="$git" //depot/sub1@all //depot/sub2@all
>&&
>> +       test_when_finished cleanup_git &&
>> +       (
>> +               cd "$git"
>
>Missing &&
>
>> +               git ls-files >lines &&
>> +               test_line_count = 4 lines &&
>> +               git log --oneline p4/master >lines &&
>> +               test_line_count = 5 lines
>> +       )
>> +'
>> +
>>  revision_ranges="2000/01/01,#head \
>>                  1,2080/01/01 \
>>                  2000/01/01,2080/01/01 \
>> @@ -147,7 +167,7 @@ test_expect_success 'clone using non-numeric
>revision ranges' '
>>                 (
>>                         cd "$git" &&
>>                         git ls-files >lines &&
>> -                       test_line_count = 6 lines
>> +                       test_line_count = 8 lines
>>                 )
>>         done
>>  '
>>
>> --
>> https://github.com/git/git/pull/311

