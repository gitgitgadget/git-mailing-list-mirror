Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C5A1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 14:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeGLOUT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 10:20:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45080 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeGLOUT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 10:20:19 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so24146005qti.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bYvGAS+7wi+Qw/KOw+WESrMP3ioacCxuoQqihaI76ak=;
        b=TJBxVOSZtCIwIrert0N+qcRt9bHNB2Z5VsW2sWBECTY9Bkpbm6bY78zJm4X9PUgXpw
         /Hn68JKpCDD3QCGYzXCmpGHI9dr2KxE1H+O02wbVOMBfY5nUH3j6DJCm4VnVM8TO6LMZ
         XdHhW01b4NIpjanGUwLm+5kNLx6urn8YrtCgzfe3kQygHxcCW8CXszkoMY5Mi7nlzfac
         qFwrBZJk2FdjTznvvMVnFd9VSlDLh4HmZNgEAlffo7fkqk26lRyumTt6j9FOXtbyyZtb
         BQn9pYjELq2R7gFLDFeDtlvA9eaHRNxycNX9gpee4qXMGWh96mFX8idlIQuYj27cHAVw
         mMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bYvGAS+7wi+Qw/KOw+WESrMP3ioacCxuoQqihaI76ak=;
        b=G3l+hqb4P2gCTdWPuf/oBGt624sMeRTJCcX1n39ImK9mIBFB/WsHSqU9vnkvM79oDW
         RSikEU8yp7qnA4ok6gOOZBF9uLlo5p/05qXYtY8fxAuicsCmmyBrAIiLhnlF3RsfYsOR
         cjiqwkk4OoPjJUmVnUYZbQBoLCZ9N98m+HMi0PJXIV/gUnRpwMLz8kQgdFFKw7wVN1Kb
         7KA5ELvhOp07AuN9ykCo6w9d5qaSAAIwyJjgCbLqdKdpz7IeAS++zHOZeXTS01xTinvR
         oECBLj8178+P9VJCBdK5pedGWX79BaV76gbnAruURx+rFZ7jzQpU/PzFxbvwJv5RoKQf
         6fTw==
X-Gm-Message-State: AOUpUlEKrWByUEQ8TlUOnZyOIpYVaEpbDtRDdmiaez5GQi/o1IPB5gjR
        LEQZgI2S1knshA6m3+fLI4E=
X-Google-Smtp-Source: AAOMgpdM1vdTrO/y3U2hPKy26nOOalBUmwmcBDm3wnMedKAWH1vhQpNeXKfHLzZFosXviM9loVEAcg==
X-Received: by 2002:ac8:855:: with SMTP id x21-v6mr2010749qth.42.1531404633781;
        Thu, 12 Jul 2018 07:10:33 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d4d2:4c73:ca82:12f0? ([2001:4898:8010:0:be08:4c73:ca82:12f0])
        by smtp.gmail.com with ESMTPSA id r13-v6sm16822059qti.70.2018.07.12.07.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 07:10:33 -0700 (PDT)
Subject: Re: [PATCH v3 07/24] multi-pack-index: expand test data
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-8-dstolee@microsoft.com>
 <CAPig+cTO=UPuCRUAAWfBwaNhRD+=dgSwpgEB2fQJuWyFEd7Aew@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e82dd51-2e30-291f-8753-c1d711459c1d@gmail.com>
Date:   Thu, 12 Jul 2018 10:10:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTO=UPuCRUAAWfBwaNhRD+=dgSwpgEB2fQJuWyFEd7Aew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/6/2018 12:36 AM, Eric Sunshine wrote:
> On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
>
>> +       for i in $(test_seq 6 10)
>> +       do
>> +               iii=$(printf '%03i' $i)
>> +               test-tool genrandom "bar" 200 >wide_delta_$iii &&
>> +               test-tool genrandom "baz $iii" 50 >>wide_delta_$iii &&
>> +               test-tool genrandom "foo"$i 100 >deep_delta_$iii &&
>> +               test-tool genrandom "foo"$(expr $i + 1) 100 >>deep_delta_$iii &&
>> +               test-tool genrandom "foo"$(expr $i + 2) 100 >>deep_delta_$iii &&
>> +               echo $iii >file_$iii &&
>> +               test-tool genrandom "$iii" 8192 >>file_$iii &&
>> +               git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
>> +               i=$(expr $i + 1) || return 1
>> +       done &&
>> +       { echo 101 && test-tool genrandom 100 8192; } >file_101 &&
>> +       git update-index --add file_101 &&
>> +       tree=$(git write-tree) &&
>> +       commit=$(git commit-tree $tree -p HEAD</dev/null) && {
>> +       echo $tree &&
>> +       git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)        .*/\\1/"
>> +       } >obj-list2 &&
>> +       git update-ref HEAD $commit
>> +'
> There seems to be a fair bit of duplication in these tests which
> create objects. Is it possible to factor out some of this code into a
> shell function?

In addition to the other small changes, this refactor in particular was 
a big change (but a good one). I'm sending my current progress in this 
direction, as I expect this can be improved.

To make the commit_and_list_objects method more generic to all 
situations, I had to add an extra commit, which will cause some of the 
numbers to change in the later 'midx_read_expect' calls.

Thanks,

-Stolee

-->8--

 From cb38bb284fd05cf2230725b6cb9ead5795c913f2 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Thu, 31 May 2018 15:05:00 -0400
Subject: [PATCH] t5319: expand test data

As we build the multi-pack-index file format, we want to test the format
on real repositories. Add tests that create repository data including
multiple packfiles with both version 1 and version 2 formats.

The current 'git multi-pack-index write' command will always write the
same file with no "real" data. This will be expanded in future commits,
along with the test expectations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
  t/t5319-multi-pack-index.sh | 83 +++++++++++++++++++++++++++++++++++++
  1 file changed, 83 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2ecc369529..a50be41bc0 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -13,9 +13,92 @@ midx_read_expect () {
  }

  test_expect_success 'write midx with no packs' '
+       test_when_finished rm -f pack/multi-pack-index &&
         git multi-pack-index --object-dir=. write &&
         test_path_is_file pack/multi-pack-index &&
         midx_read_expect
  '

+generate_objects () {
+       i=$1
+       iii=$(printf '%03i' $i)
+       {
+               test-tool genrandom "bar" 200 &&
+               test-tool genrandom "baz $iii" 50
+       } >wide_delta_$iii &&
+       {
+               test-tool genrandom "foo"$i 100 &&
+               test-tool genrandom "foo"$(( $i + 1 )) 100 &&
+               test-tool genrandom "foo"$(( $i + 2 )) 100
+       } >>deep_delta_$iii &&
+       echo $iii >file_$iii &&
+       test-tool genrandom "$iii" 8192 >>file_$iii &&
+       git update-index --add file_$iii deep_delta_$iii wide_delta_$iii
+}
+
+commit_and_list_objects () {
+       {
+               echo 101 &&
+               test-tool genrandom 100 8192;
+       } >file_101 &&
+       git update-index --add file_101 &&
+       tree=$(git write-tree) &&
+       commit=$(git commit-tree $tree -p HEAD</dev/null) &&
+       {
+               echo $tree &&
+               git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)        
.*/\\1/"
+       } >obj-list &&
+       git reset --hard $commit
+}
+
+test_expect_success 'create objects' '
+       test_commit initial &&
+       for i in $(test_seq 1 5)
+       do
+               generate_objects $i
+       done &&
+       commit_and_list_objects
+'
+
+test_expect_success 'write midx with one v1 pack' '
+       pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
+       test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx 
pack/multi-pack-index &&
+       git multi-pack-index --object-dir=. write &&
+       midx_read_expect
+'
+
+test_expect_success 'write midx with one v2 pack' '
+       git pack-objects --index-version=2,0x40 pack/test <obj-list &&
+       git multi-pack-index --object-dir=. write &&
+       midx_read_expect
+'
+
+test_expect_success 'add more objects' '
+       for i in $(test_seq 6 10)
+       do
+               generate_objects $i
+       done &&
+       commit_and_list_objects
+'
+
+test_expect_success 'write midx with two packs' '
+       git pack-objects --index-version=1 pack/test-2 <obj-list &&
+       git multi-pack-index --object-dir=. write &&
+       midx_read_expect
+'
+
+test_expect_success 'add more packs' '
+       for j in $(test_seq 1 10)
+       do
+               generate_objects $j &&
+               commit_and_list_objects &&
+               git pack-objects --index-version=2 test-pack <obj-list
+       done
+'
+
+test_expect_success 'write midx with twelve packs' '
+       git multi-pack-index --object-dir=. write &&
+       midx_read_expect
+'
+
  test_done
--
2.18.0.118.gd4f65b8d14

