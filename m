Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283192047F
	for <e@80x24.org>; Tue, 19 Sep 2017 20:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdISUam (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 16:30:42 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:52622 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdISUal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 16:30:41 -0400
Received: by mail-qk0-f177.google.com with SMTP id o77so839945qke.9
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FTjXYwW1BSqX7Ib63blxOjUiJdmbXAa4209QaO8si1c=;
        b=MCbRJZ3yS2pF04iWArIeeZAoeUv+8YMuanN8LGzkfOgSIvZ7UPdpLwaKcZzLgTEj1t
         lSGO2JoxcPbZTc4oPn6bKmTzbvKtvpnevBcGcJkEmKJNYCKoXe3gn7+l7QlwmdXNUENR
         ZVOh5ymc4YZOchvOfUSTjJkb+3BFI2CE3zl4gjpiII8V4hThZf/HiYnoCjBJgrz65faA
         LYnOSvJml3tvxfan+qPOLk/+Agcm5peuQcRA0QM8lhw4dwTkHJHFksuazCgy3mpXSjUq
         mnsVKFcZyuDmiHtB9AtPRoMUIygPpGyoxCUuNXEToeEAYUiiaWHxfQ9Oij8S/TQEgXgR
         AfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FTjXYwW1BSqX7Ib63blxOjUiJdmbXAa4209QaO8si1c=;
        b=ErqkTqVevMLIA+jGQygAibHVponRMQZhsfFtic4z24+sJkBryQFy24Xh3/1yKmeJ3y
         AudXWEnWugFDQUFHt39L7cyahamQs2mWChXO6uwMvTSOn7H/NbUxnq9hC+ueNt3NhC0W
         Jtpb4aEzWkhDRJY81kDuaCvyQECfEO/A+RLIi1TQAUIGnPyO9d3/BXjKPG6gXuMigJB9
         f9ripncbjnx5eOtVAHBTddGNrcctU2vlntwgCvwM5HZPD9DHH6KMmMfA7G58ppFSP7IG
         nmSkW/6I/WMmdEhxSFo32VaUM9/UYxqBMaZ1cY1/w5A0zboYkeRCGcxRgVfrehp7RHZl
         3SEg==
X-Gm-Message-State: AHPjjUjkUGZOJ0nokk4UZKWgb6HURs/qnAkaIOwCfz8ku4cUJDlNPmqw
        SW0d/Xtmo8Rc2qlvGyoU+Eg=
X-Google-Smtp-Source: AOwi7QC1U1hQJFcro0oBydnPDt5NtZTv1YFDj85MH3W56dB6k8b5hrOTHKV+Wk9ppj7kek5/Gybh5g==
X-Received: by 10.55.39.22 with SMTP id n22mr4025950qkn.293.1505853039933;
        Tue, 19 Sep 2017 13:30:39 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id i41sm151584qta.23.2017.09.19.13.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Sep 2017 13:30:37 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
To:     David Turner <David.Turner@twosigma.com>,
        'Ben Peart' <benpeart@microsoft.com>
Cc:     "'avarab@gmail.com'" <avarab@gmail.com>,
        "'christian.couder@gmail.com'" <christian.couder@gmail.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>,
        "'gitster@pobox.com'" <gitster@pobox.com>,
        "'johannes.schindelin@gmx.de'" <johannes.schindelin@gmx.de>,
        "'pclouds@gmail.com'" <pclouds@gmail.com>,
        "'peff@peff.net'" <peff@peff.net>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-11-benpeart@microsoft.com>
 <dc1506689d3d4639b56f0489e4219054@exmbdft7.ad.twosigma.com>
 <2f3593f790f5423e853f3bcb0a601ef9@exmbdft7.ad.twosigma.com>
Message-ID: <84981984-02c1-f322-a617-57dfe1d87ad2@gmail.com>
Date:   Tue, 19 Sep 2017 16:30:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <2f3593f790f5423e853f3bcb0a601ef9@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/2017 3:32 PM, David Turner wrote:
> I think my comment here might have gotten lost, and I don't want it to because it's something I'm really worried about:
> 

You have to update the test completely to ensure it passes.  If you run 
the test with the '-v' option you will see the cause of the failure:

t7519-status-fsmonitor.sh: line 27: dir3/untracked: No such file or 
directory

To fix this, you will also need to update the 'setup' test to create the 
directory for the new untracked file to get created into.  Then you will 
need to drop at least one file in it so that the directory is preserved 
through the 'git reset --hard'  Then you have to update the several 'cat 
 >expect' blocks to expect the new file.

In addition, the ability to avoid scanning for untracked files relies on 
the untracked cache.  If you don't have another file that git is aware 
of in that directory then there won't be a cache entry and git will do 
the required scan and detect the new untracked file (by design).

Here is a patch to the test that updates it to meet all these 
requirements.  I hope this helps.


diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index c6df85af5e..29ae4e284f 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -24,12 +24,14 @@ dirty_repo () {
  	: >untracked &&
  	: >dir1/untracked &&
  	: >dir2/untracked &&
+	: >dir3/untracked &&
  	echo 1 >modified &&
  	echo 2 >dir1/modified &&
  	echo 3 >dir2/modified &&
  	echo 4 >new &&
  	echo 5 >dir1/new &&
  	echo 6 >dir2/new
+	echo 7 >dir3/new
  }

  write_integration_script () {
@@ -47,12 +49,14 @@ write_integration_script () {
  	printf "untracked\0"
  	printf "dir1/untracked\0"
  	printf "dir2/untracked\0"
+	printf "dir3/untracked\0"
  	printf "modified\0"
  	printf "dir1/modified\0"
  	printf "dir2/modified\0"
  	printf "new\0"
  	printf "dir1/new\0"
  	printf "dir2/new\0"
+	printf "dir3/new\0"
  	EOF
  }

@@ -71,6 +75,8 @@ test_expect_success 'setup' '
  	mkdir dir2 &&
  	: >dir2/tracked &&
  	: >dir2/modified &&
+	mkdir dir3 &&
+	: >dir3/tracked &&
  	git -c core.fsmonitor= add . &&
  	git -c core.fsmonitor= commit -m initial &&
  	git config core.fsmonitor .git/hooks/fsmonitor-test &&
@@ -107,6 +113,7 @@ h dir1/modified
  H dir1/tracked
  h dir2/modified
  H dir2/tracked
+H dir3/tracked
  h modified
  H tracked
  EOF
@@ -126,6 +133,7 @@ H dir1/modified
  H dir1/tracked
  H dir2/modified
  H dir2/tracked
+H dir3/tracked
  H modified
  H tracked
  EOF
@@ -144,6 +152,7 @@ H dir1/modified
  H dir1/tracked
  H dir2/modified
  H dir2/tracked
+H dir3/tracked
  H modified
  H tracked
  EOF
@@ -164,6 +173,8 @@ H dir1/tracked
  H dir2/modified
  h dir2/new
  H dir2/tracked
+h dir3/new
+H dir3/tracked
  H modified
  h new
  H tracked
@@ -174,6 +185,7 @@ test_expect_success 'newly added files are marked 
valid' '
  	git add new &&
  	git add dir1/new &&
  	git add dir2/new &&
+	git add dir3/new &&
  	git ls-files -f >actual &&
  	test_cmp expect actual
  '
@@ -185,6 +197,8 @@ h dir1/tracked
  H dir2/modified
  h dir2/new
  h dir2/tracked
+h dir3/new
+h dir3/tracked
  H modified
  h new
  h tracked
@@ -203,6 +217,7 @@ H dir1/modified
  h dir1/tracked
  h dir2/modified
  h dir2/tracked
+h dir3/tracked
  h modified
  h tracked
  EOF
@@ -269,6 +284,7 @@ do
  			git add new &&
  			git add dir1/new &&
  			git add dir2/new &&
+			git add dir3/new &&
  			git status >actual &&
  			git -c core.fsmonitor= status >expect &&
  			test_i18ncmp expect actual



>> -----Original Message-----
>> From: David Turner
>> Sent: Friday, September 15, 2017 6:00 PM
>> To: 'Ben Peart' <benpeart@microsoft.com>
>> Cc: avarab@gmail.com; christian.couder@gmail.com; git@vger.kernel.org;
>> gitster@pobox.com; johannes.schindelin@gmx.de; pclouds@gmail.com;
>> peff@peff.net
>> Subject: RE: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
>> extension
>>
>>> -----Original Message-----
>>> +dirty_repo () {
>>> +	: >untracked &&
>>> +	: >dir1/untracked &&
>>> +	: >dir2/untracked &&
>>> +	echo 1 >modified &&
>>> +	echo 2 >dir1/modified &&
>>> +	echo 3 >dir2/modified &&
>>> +	echo 4 >new &&
>>> +	echo 5 >dir1/new &&
>>> +	echo 6 >dir2/new
>>
>> If I add an untracked file named dir3/untracked to dirty_repo  (and
>> write_integration_script), then "status doesn't detect unreported
>> modifications", below, fails.  Did I do something wrong, or does this turn up a
>> bug?
> 
> 
