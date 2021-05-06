Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B395FC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC02611EE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhEFGo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 02:44:59 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:20287 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhEFGo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 02:44:58 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4FbPDr0hg2z5tlQ;
        Thu,  6 May 2021 08:43:56 +0200 (CEST)
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
 <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
 <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
Date:   Thu, 6 May 2021 08:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.05.21 um 08:12 schrieb Yuri:
> On 5/5/21 11:07 PM, Johannes Sixt wrote:
>> I would argue that you are doing something wrong if your stashes are
>> particularly valuable. If you regularly revert temporary, but precious
>> work, then you should commit the work and mark it with a branch tip or
>> tag.
>>
> 
> No, it is work in progress. I begin to work on some modification or
> update, discover some issue, and stash the update until this issue is
> resolved,
> 
> It could take days, weeks, months to resolve them.

I know. But, as I said, when you turn away from your current work, which
is precious, then you should make a commit, in particular, when you can
forsee that you might not be able to come back soon.

A 'git stash' is really only intended as a short-term
make-the-worktree-temporarily-clean auxiliary storage. It is not
intended as a long-term storage. For long-term storage, use branches.
"Short term" is measured in seconds (rebase --autostash), minutes,
perhaps hours, but certainly not weeks or months.

At least, that's how I understand (and use) it.

-- Hannes
