Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED301F403
	for <e@80x24.org>; Sun, 17 Jun 2018 15:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933906AbeFQPlf (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 11:41:35 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57691 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933588AbeFQPle (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 11:41:34 -0400
Received: from [192.168.2.240] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id UZo4f2WbVoI6LUZo4fSzFd; Sun, 17 Jun 2018 16:41:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529250093;
        bh=ius8yaVJnaK9A+SsxTDzmG0fv7UNCXPo4XqLMfvooik=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O8aBcBBr9DzZn9izxNV40wthhQCvw2KbqNEHNefx2TbitBqxp6+gDS7IQHe5aMmZo
         LDmUmlWTSOdzjWycxAvGoOByQLsmAA2Qa6LRNPxkrgEp0ZxqrN8AN0PJx1L41FbNXJ
         1gGb/kKsZsIOK5KHGSxSzxcxtlftrV78Q3cVaJiM=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=fv2YEWdnNQ5nw5PIKGUA:9
 a=3mBa6t2-JSs_OtDg:21 a=BbQFCknIr62CMReJ:21 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 0/7] Document/fix/warn about rebase
 incompatibilities and inconsistences
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <fa4118c9-5ff9-0fa7-7df4-98a3c483f95d@talktalk.net>
Date:   Sun, 17 Jun 2018 16:41:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL7ZoIyf/tlsa5tRAJ5RTXZAj9fOlU4e2d2XHLE96+9P5rXfKOX4wUrKkBgk4M9rPPKR3sMYlkNwmiukwJHQk3GJeriDp1WbTzfQSk8Ozii8agBTW/oB
 DaiyLk5jT0XyQ0gOvH5ZXYEeebxHHXCDW2J7sbVQ12gF3KCYbI5SXFlx8+TAg/2h3SF8ZidtA9Wpe49M0Ic9qS2SyTCrE9grif3gVCcArjlV3XoijTBdbK0Y
 dJxgoxnsV0ALi70nd0R2s85CURUcZO/IiE3s20MZlXbrZN0+4PW7KrWyzDXb4SC1BJIA5noNO4t+FVraRN5Yzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 17/06/18 06:58, Elijah Newren wrote:
> git-rebase has lots of options that are mutually incompatible.  Even among
> aspects of its behavior that is common to all rebase types, it has a number
> of inconsistencies.  This series tries to document, fix, and/or warn users
> about many of these.
> 
> I have a much higher than average expectation that folks will object
> to some of these patches.  I've tried to divide them up so that any parts
> we decide to drop or redo can be more easily excised.
> 
> No branch-diff; because it's a significant re-work; instead I'll comment
> briefly on the individual patches...

I found this series well structured and easy to follow. I've commented 
on a couple of the patches, the others seemed fine to me. It's great to 
see these inconsistencies being documented and some being eliminated.

Best Wishes

Phillip

> 
> Elijah Newren (7):
>    git-rebase.txt: document incompatible options
> 
> Both Dscho (on a related patch series) and Phillip suggested changing the
> documentation to avoid implementational details.  I instead made a separate
> section with sets of incompatible options...but it still mentions the
> different backends while doing so.  Does that seem alright?
> 
>    git-rebase.sh: update help messages a bit
> 
> Minor tweaks to `git rebase -h` output.
> 
>    t3422: new testcases for checking when incompatible options passed
> 
> The one unmodified patch from the first round.
> 
>    git-rebase: error out when incompatible options passed
> 
> Almost the same as the first round, except:
>    * Documentation pulled into a separate patch (patch 1)
>    * $() instead of ``
> 
>    git-rebase.txt: document behavioral inconsistencies between modes
> 
> Add another section to the documentation for aspects that ideally
> should be common between all modes but are handled differently.
> 
>    git-rebase.txt: address confusion between --no-ff vs --force-rebase
> 
> This came up on the list not that long ago; fix the documentation.
> 
>    git-rebase: make --allow-empty-message the default
> 
> Address the easiest of the inconsistencies, assuming the am-based backend
> has the correct default and the merge-based and interactive-based backends
> are the ones that need to change.
> 
>   Documentation/git-rebase.txt           | 154 ++++++++++++++++++++-----
>   git-rebase.sh                          |  25 +++-
>   t/t3404-rebase-interactive.sh          |   7 +-
>   t/t3405-rebase-malformed.sh            |  11 +-
>   t/t3422-rebase-incompatible-options.sh |  69 +++++++++++
>   5 files changed, 224 insertions(+), 42 deletions(-)
>   create mode 100755 t/t3422-rebase-incompatible-options.sh
> 

