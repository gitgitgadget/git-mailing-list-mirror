Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E441F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIKVEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:04:22 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:33807 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeIKVEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:04:22 -0400
Received: by mail-qk1-f179.google.com with SMTP id d15-v6so17138859qkc.1
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=xilU3mP9V50IKJL690YfQubjFV08xPJ2uh84E+5dvbE=;
        b=X1m8pCzEj2XDt26Xkl7FofenxJzFGXVbooRNmpA+FpTSFkijv4stpdowV9VCcgh10W
         bu6AbX3JJbiVNj0+NlUF9CiUTQiB4EFCExKyAen5L/b/nzdeJe0AQnGcINDp4v/sPUSJ
         rcIaDsSr+ABrZ/b2iYV9BwG50xLq55atELRO0rvHklYzKSx3iOnwNXUnlCAWZgo+Jr1h
         VVpOdgbJ6sOSxORpCU7b9+oIVaYD8uf7iqeiGW0S5SB15lTCPd0xrUaz1HaKqDBEc8ZN
         eoVDak6JAxPi5FmI40jL0l2NZ2NaLoi5B+9pxmN063rGb4YQ5UuPhboBLrVr/zFIk1Mi
         n26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xilU3mP9V50IKJL690YfQubjFV08xPJ2uh84E+5dvbE=;
        b=IjClIWahSTe8dmpAwu6UhZsH2XTWAwk2cKCAsG8dWVaeXqyk6XAKmdpc2zEGYc23ua
         3yOAwM+D7RyTIi/WiTMHqzvmVfZtfCkPXD/291CeRUUee70gHCH+Qe91ChBVU6sM778B
         lOdrLpo1bEKAHSbvZTfcKZ87HPpLpQnzOTKUXudQexorXEl5tD+kTWliw5rZBzrcW/XM
         LhIdiq89JnCzqlqlhJZg95uRIaG4e31dBaV15/QVqNg/Zo17vsrZCCppLeoI3Ex4NbN+
         2lJTA3ATIT8rADdPkL83qaLdAT3uYawoFfy16ZW9kZuEwAu7Y6uAsjnoVXCeLqggrIG3
         VrCA==
X-Gm-Message-State: APzg51CPKoPdI7QMHJQvGnozwM0IKhF+eHN/2oV+9eIFHNA1B/gxm3hp
        1irg/7WFoeOrDapo6p4PSgc7G1KA
X-Google-Smtp-Source: ANB0VdY2TGuzvqJHkycuON4nAiqjQHoaU9tXKsDpxfOJ+PhKz0HC6CkNLD3X8X6wDJDzZe/XAmgzPQ==
X-Received: by 2002:a37:ae86:: with SMTP id x128-v6mr19465525qke.25.1536681862511;
        Tue, 11 Sep 2018 09:04:22 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:ddb1:de2c:d0ab:264d? ([2001:4898:8010:1:9e47:de2c:d0ab:264d])
        by smtp.gmail.com with ESMTPSA id g39-v6sm13193236qtb.90.2018.09.11.09.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:04:21 -0700 (PDT)
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
From:   Derrick Stolee <stolee@gmail.com>
To:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
Message-ID: <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
Date:   Tue, 11 Sep 2018 12:04:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2018 11:38 AM, Derrick Stolee wrote:
> On 9/11/2018 11:25 AM, ryenus wrote:
>> I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
>> only got a Segmentation fault: 11
>>
>>      $ git version; git range-diff origin/master  HEAD@{2} HEAD
>>      git version 2.19.0
>>      Segmentation fault: 11
>>
>> Both origin/master and my local branch each got two new commits of 
>> their own,
>> please correct me if this is not the expected way to use git range-diff.
>>
>> FYI, I've created a sample repo here:
>> https://github.com/ryenus/range-diff-segfault/
>
> Hi Ryenus,
>
> Thanks for the report!
>
> I ran something similar using Git for Windows 2.19.0-rc2. I had to run 
> `git commit --amend --no-edit` on the tip commit to make my local 
> master disagree with origin/master. I then ran the following:
>
> $ git range-diff origin/master HEAD~1 HEAD
> -:  ------- > 1:  5009c62 aaa
>
> With this, the command succeeded for me. There is another way to get a 
> similar result, could you try it?
>
> $ git range-diff origin/master~1..origin/master HEAD~1..HEAD
> 1:  f14d571 = 1:  5009c62 aaa
>
> Otherwise, we can now get started trying to repro this on a Mac. Thanks!

The patch below includes a test that fails on Mac OSX with a segfault.

GitGitGadget PR: https://github.com/gitgitgadget/git/pull/36
Failed Build: 
https://git-for-windows.visualstudio.com/git/_build/results?buildId=18616&view=logs

-->8--

 From 3ee470d09d54b9ad7ab950f17051d625db0c8654 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 11 Sep 2018 11:42:03 -0400
Subject: [PATCH] range-diff: attempt to create test that fails on OSX

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
  t/t3206-range-diff.sh | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af..02744b07a8 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,9 @@ test_expect_success 'changed message' '
         test_cmp expected actual
  '

+test_expect_success 'amend and check' '
+       git commit --amend -m "new message" &&
+       git range-diff changed-message HEAD@{2} HEAD
+'
+
  test_done
--
2.19.0.rc2.windows.1

