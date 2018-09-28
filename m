Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C4C1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 14:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeI1UvX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 16:51:23 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:43045 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeI1UvX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 16:51:23 -0400
Received: by mail-qt1-f181.google.com with SMTP id q41-v6so2000033qtq.10
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ew+JWFfdvpWUy64XmeDqB3yT662s+4ZTNJag++YvAkU=;
        b=UyuERUB+EOClh6o5zzaXu9cXqIfeWhYgCH7D7UTd5VnTJV4pHc/ZqRUJdQPm0whvFr
         pA3c3bEInA38AFoF+V7LOKRwrYiRdt4iOvVKibDofOsTV5hPBo2+xov9yFHVfmqDlVNS
         CziKY27fRj8WmWabg7afGWwfbPLTx/mbu9FG7axnXuMA75MD7/ShxalcEo4OPmTPzsVO
         SUtyqoNdoCQQu8ff2YcAAi/H0s61x9N20hdLxm/wpCZanBa6lMCzojy2hpWz3Y1cCpGx
         sHn8USkQ6YLqvaKDYTqnI8bIYraeasadjR8RED2PKna6mBy4/fYOs/wN2ciXafSkjc44
         6faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ew+JWFfdvpWUy64XmeDqB3yT662s+4ZTNJag++YvAkU=;
        b=jNazGgeuMo1+W/qv3B8ZabEfVTZH2B/Q25oHIdb6mlPUxStwY+uzfFPVCsotDCTvvO
         gdBWCKVVWb49KTu1ROrCiRZrNpVmVMdtmdXz8FImeqogFE3ChswsorFQ6+cWCTkOtnbS
         3j6y/QfO2RO19A7H80djsGl6Wmlel2v/4beCrf9OBVCAh1Hte2DFjRrw3Pe/UAyftsdo
         Y/w6dLlfOtD3IYBY958qh1xTr8elQJEfRnRwtPB04dnSUGP0CkJP1wqLEkec5oI65T+J
         qel2SD98BkTM1QEU2HvmiXpJLZ3hqMdoed01IUwwfxWcWX01nGDfG4P/AyceJg2hOq8E
         Niuw==
X-Gm-Message-State: ABuFfogILnfdQhKE3DDFcZis/8oyzbMG2WBpS5eAQEjYaKTNhlQvTl0m
        RrDyAIS7+rrY1x2D5gGpJ5M=
X-Google-Smtp-Source: ACcGV60heKg2/QHbRWfR5laAd5Yj3b4OE50Zhqf7KfZjHykY6gmQNsCis2R7qQe8zV9L7ULXtPu9Sw==
X-Received: by 2002:a05:6214:46:: with SMTP id c6mr3753783qvr.128.1538144839890;
        Fri, 28 Sep 2018 07:27:19 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d8-v6sm2750067qtn.28.2018.09.28.07.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 07:27:18 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] fsmonitor: update GIT_TEST_FSMONITOR support
From:   Ben Peart <peartben@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
 <20180918232916.57736-4-benpeart@microsoft.com>
 <20180928100143.GA23446@localhost>
 <653f4fbd-ed32-4cf8-b1bb-9cfef4f8deaa@gmail.com>
Message-ID: <efe7ae90-d0c2-9223-cdab-8b6c64f818bd@gmail.com>
Date:   Fri, 28 Sep 2018 10:27:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <653f4fbd-ed32-4cf8-b1bb-9cfef4f8deaa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/28/2018 10:21 AM, Ben Peart wrote:
> 
> 
> On 9/28/2018 6:01 AM, SZEDER Gábor wrote:
>> On Tue, Sep 18, 2018 at 11:29:35PM +0000, Ben Peart wrote:
>>> diff --git a/t/README b/t/README
>>> index 56a417439c..47165f7eab 100644
>>> --- a/t/README
>>> +++ b/t/README
>>> @@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the 
>>> uncommon pack-objects code
>>>   path where deltas larger than this limit require extra memory
>>>   allocation for bookkeeping.
>>> +GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
>>> +code path for utilizing a file system monitor to speed up detecting
>>> +new or changed files.
>>
>> Here you tell us to set GIT_TEST_FSMONITOR to an absolute path, and we
>> are good to go.
>>
>>> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
>>> index 756beb0d8e..d77012ea6d 100755
>>> --- a/t/t7519-status-fsmonitor.sh
>>> +++ b/t/t7519-status-fsmonitor.sh
>>> @@ -8,7 +8,7 @@ test_description='git status with file system watcher'
>>>   # To run the entire git test suite using fsmonitor:
>>>   #
>>>   # copy t/t7519/fsmonitor-all to a location in your path and then set
>>> -# GIT_FSMONITOR_TEST=fsmonitor-all and run your tests.
>>> +# GIT_TEST_FSMONITOR=fsmonitor-all and run your tests.
>>
>> But this old comment is different, suggesting copying that script to
>> our $PATH.
>>
>> I prefer your instructions above, because it's only a single step,
>> and, more importantly, it won't pollute my $PATH.  I think this
>> comment should be updated to make the advices in both places
>> consistent.  Or perhaps even removed, now that all GIT_TEST variables
>> are documented in the same place?
>>
> 
> I prefer the suggestion to simply remove this text from the test script 
> now that there is documentation for it in the t/README file.

Junio, can you squash in the following patch or would you prefer I 
reroll the entire series?

Thanks,

Ben

 From 393007340dc1baf3539ab727e0a8128e7c408a27 Mon Sep 17 00:00:00 2001
From: Ben Peart <peartben@gmail.com>
Date: Fri, 28 Sep 2018 10:23:18 -0400
Subject: fixup! fsmonitor: remove outdated instructions from test

Remove the outdated instructions on how to run the test suite utilizing
fsmonitor now that it is properly documented in t/README.

Signed-off-by: Ben Peart <peartben@gmail.com>
---

Notes:
     Base Ref: git-test-cleanup-v3
     Web-Diff: https://github.com/benpeart/git/commit/393007340d
     Checkout: git fetch https://github.com/benpeart/git 
git-test-cleanup-v1 && git checkout 393007340d

  t/t7519-status-fsmonitor.sh | 7 -------
  1 file changed, 7 deletions(-)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 8308d6d5b1..3f0dd98010 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -4,13 +4,6 @@ test_description='git status with file system watcher'

  . ./test-lib.sh

-#
-# To run the entire git test suite using fsmonitor:
-#
-# copy t/t7519/fsmonitor-all to a location in your path and then set
-# GIT_TEST_FSMONITOR=fsmonitor-all and run your tests.
-#
-
  # Note, after "git reset --hard HEAD" no extensions exist other than 
'TREE'
  # "git update-index --fsmonitor" can be used to get the extension written
  # before testing the results.

base-commit: 043246d9369fb851c5c2b922466f77fc7ef0327b
-- 
2.18.0.windows.1

