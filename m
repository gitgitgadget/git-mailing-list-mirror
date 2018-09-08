Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD961F404
	for <e@80x24.org>; Sat,  8 Sep 2018 18:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeIHX00 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 19:26:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:23543 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbeIHX00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 19:26:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42734w0V4Pz5tlT;
        Sat,  8 Sep 2018 20:39:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BDDE32088;
        Sat,  8 Sep 2018 20:39:43 +0200 (CEST)
Subject: Re: [PATCH] Revert "Merge branch 'sb/submodule-core-worktree'" (was
 Re: Old submodules broken in 2.19rc1 and 2.19rc2)
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, allan.jensen@qt.io,
        git <git@vger.kernel.org>
References: <2659750.rG6xLiZASK@twilight>
 <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
 <20180907223515.GD103699@aiede.svl.corp.google.com>
 <CAGZ79kZvuGEPOSTUqT+y6nxs6W5qaP-BbHT_WQQE7+n=RVNsrw@mail.gmail.com>
 <20180908000946.GA225427@aiede.svl.corp.google.com>
 <xmqqmussvj72.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <deeaa4d5-3982-b47a-d2da-501d52fa38e1@kdbg.org>
Date:   Sat, 8 Sep 2018 20:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqmussvj72.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.09.2018 um 04:04 schrieb Junio C Hamano:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> It is late in the release cycle, so revert the whole 3-patch series.
>> We can try again later for 2.20.
>>
>> Reported-by: Allan Sandfeld Jensen <allan.jensen@qt.io>
>> Helped-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> Stefan Beller wrote:
>>> Jonathan Nieder wrote:
>>
>>>> I think we
>>>> should revert e98317508c0 in "master" (for 2.19) and keep making use
>>>> of that 'second try' in "next" (for 2.20).
>>>
>>> Actually I'd rather revert the whole topic leading up to
>>> 7e25437d35a (Merge branch 'sb/submodule-core-worktree', 2018-07-18)
>>> as the last patch in there doesn't work well without e98317508c0 IIRC.
>>>
>>> And having only the first patch would bring an inconsistent state as
>>> then different commands behave differently w.r.t. setting core.worktree.
>>
>> Like this (generated using "git revert -m1)?
> 
> OK.  Thanks for taking care of it.

Please don't forget to remove the corresponding release notes entry.

diff --git a/Documentation/RelNotes/2.19.0.txt b/Documentation/RelNotes/2.19.0.txt
index bcbfbc2041..834454ffb9 100644
--- a/Documentation/RelNotes/2.19.0.txt
+++ b/Documentation/RelNotes/2.19.0.txt
@@ -296,12 +296,6 @@ Fixes since v2.18
    to the submodule was changed in the range of commits in the
    superproject, sometimes showing "(null)".  This has been corrected.
 
- * "git submodule" did not correctly adjust core.worktree setting that
-   indicates whether/where a submodule repository has its associated
-   working tree across various state transitions, which has been
-   corrected.
-   (merge 984cd77ddb sb/submodule-core-worktree later to maint).
-
  * Bugfix for "rebase -i" corner case regression.
    (merge a9279c6785 pw/rebase-i-keep-reword-after-conflict later to maint).
 
