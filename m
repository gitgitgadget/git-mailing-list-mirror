Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C0C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B80221734
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAWQEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:04:11 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:37797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWQEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 11:04:10 -0500
Received: from [192.168.100.176] ([80.150.130.51]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAxLT-1ijQXo1Zdp-00BOsQ for <git@vger.kernel.org>; Thu, 23 Jan 2020 17:04:09
 +0100
From:   ch <cr@onlinehome.de>
Subject: [REGRESSION] gitk can't be run from non-worktree folders
To:     git@vger.kernel.org
Message-ID: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
Date:   Thu, 23 Jan 2020 17:04:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SxQnYRH3nCCUhrVn+fh7zBs+As/OXus+I30/uNDrkkfd+Lvdc6e
 fyZSClvq6KJFqn7KbGw3J8CYTSDg7VJGieMWtfwlFmD1STp2buaLmRno/Zh59UgZ8MbE6aR
 Py1laqu9e+ihYvyFUbclCqsqqlgrrhaDbwfhmvpjERwNaq8XG2WyYwq+E9tjrw4thzkyVAR
 GRwX94PnXzsvWRfwpjm4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C6i0M3YATnE=:/8MTN1IZDgOmbG3opZDkU8
 faY6cCiducqpQyJ5TvFial/jEBA0LhTamiXxVNfBzx+wSB7IIRxG9GjGvVM4C30S/J0t0kwUY
 DqgmzY34T5KJ5tg1WYWtDaJyrLys+rtau0aadtwBmOo5QRkUNjcSFLg3WI3+9bO9ezemRnzn9
 uOuJ8qrhEubqqMh9GUiaYjZy3w0V8hEK9OVFIzjcOete9nTetGAfWOWspdr25VauDP+6+qxpy
 J+ayGYgbn9GUyK3oTu291OYx6NbLMnLXsRwZwdA1C51buG97J4nQd3VNvKfxWunIePbMgndZ0
 7en7Qqp5pyk+ULJiebM/uCTRQP7z6UUBgJ/WrsQscp90zfVkL3gANVPKyC6dvGwLZJmRKvHRl
 mmNUBzwW5iha2jNtBbWFhpX8+PeVkMS49pQu+74Gle5xHt+5ecUwBEF86FqcgwgK5GGm9BeO6
 UL0kg4MYa7UF4fndyAwyhaS2zBlz4Lpoet24TfwqZgLJ1bKfkm4Wh7rYoWnWniGx/m1r9olth
 sP+Xm/qSXs8zhdXbc+fQwBdeDplPS8ndXaAVZL3EhlzQAEQUY1aQ7rx9Y+2l0R7npu3XbqJYW
 z5rvXMr96W4d6KD5ulJmBD1BsBgDlxfZ5yJ0MQYKRfbnFuYwdev+JMa+zvtBz7giGeN0bI4/W
 Gguq20g/u8BktS8w+PFQIpGEQUBxT0F3P7VYOhsnxhUd5FmGIO8GoOiWSfPmtkIOdkSO6CRla
 cehZf6R26RJA2g4QuGnQ2qiDVw7JvkjAtHl7gxRf+RymxqT79wtCbCwLFBfm8uq9s2qlQ5ENa
 i2azV0QX5InwY6SOXcPehtpvreC9pTYz1+MoPTtzDMywKE/091Tz0pWUXq8U14OZo2hAU/F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

I recently updated my Git installation from 2.24.1.windows.2 to
2.25.0.windows.1 and from the looks of it the included version of gitk does not
support being run from non-worktree folders of a repository anymore (like the
.git folder for example).

Here's a small reproduction recipe:

   $ git init repro
   $ cd repro
   $ git commit -m test --allow-empty
   $ cd .git
   $ gitk --all &

gitk terminates with the message:

   fatal: this operation must be run in a work tree
       while executing
   "exec git rev-parse --show-toplevel"
       invoked from within
   "set worktree [exec git rev-parse --show-toplevel]"
       (file "C:/Program Files/Git/mingw64/bin/gitk" line 12634)

-ch
