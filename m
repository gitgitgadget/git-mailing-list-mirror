Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F50C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4606620739
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 08:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgCUIrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 04:47:55 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:11856 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbgCUIry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 04:47:54 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 48kvRX4l49z5tlG;
        Sat, 21 Mar 2020 09:47:42 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AEDA02817;
        Sat, 21 Mar 2020 09:47:41 +0100 (CET)
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     George Spelvin <lkml@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <35c25a8e-f526-e5c9-5dc1-ef02315a1e97@kdbg.org>
Date:   Sat, 21 Mar 2020 09:47:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320223015.GA19579@SDF.ORG>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.03.20 um 23:30 schrieb George Spelvin:
> I'm cleaning up a patch series for submission, and came across a fixup in
> patch #4/20 that belongs in #2/20.
> 
> Unfortunately, I can't go back two patches to apply the fix until I get to 
> the end of the current rebase, then go back down to clean it up. :-(

In such cases, I usually

- unstage the changes of the current commit
- stage the fixup
- `git commit --fixup @~2`
- stage what I had unstaged first
- then continue

At the end of the current rebase, a `git rebase -i --autosquash` does
the final cleanup.

-- Hannes
