Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AE1EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 20:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjF1UbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjF1UbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 16:31:02 -0400
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D91A2
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 13:31:00 -0700 (PDT)
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4QrtWk6xy9z5tmJ
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 22:30:58 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4QrtWg55pCz5tl9;
        Wed, 28 Jun 2023 22:30:55 +0200 (CEST)
Message-ID: <e745078f-fa24-6c10-4134-078e7e3f214c@kdbg.org>
Date:   Wed, 28 Jun 2023 22:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/9] gitk: add keyboard bind for create and remove branch
Content-Language: en-US
To:     =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <661f098d882e64391ff76647e3764d58c6cbb50a.1687876885.git.gitgitgadget@gmail.com>
 <7c73cc47-302d-8706-dd7f-fd034ef8d945@kdbg.org>
 <36b3ce90d4ecc9eb9fa5174aba0cf9d4@lidestrom.se>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <36b3ce90d4ecc9eb9fa5174aba0cf9d4@lidestrom.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.06.23 um 09:12 schrieb Jens Lideström:
> My intention is to always remove the first branch head that is displayed
> for a single commit in the GUI. This caters to the common use case, with
> only one branch for a single commit. If there are multiple branch heads
> on a commit and the users don't want to remove the first one then they
> need to use the mouse context menu to choose which one to delete.
> 
> I could change the implementation to display a dialog that lets the user
> choose in case of multiple branch heads.

IMO a selection dialog is the second-best solution. The best one is to
make the branch labels selectable somehow via keyboard navigation. I am
not a fan of the here implement behavior, because it is only a
half-solution.

Also, the order of branch labels on a line is not 100% deterministic:
when you create a branch, it goes last, but when you refresh the view,
branch labels are sorted alphabetically (I think). This means you can't
create a branch and delete it right away if there is already a branch on
the commit.

> In that case, should I do that as part of this PR, or as a follow up? I
> would prefer to finish this one first.

My preference would be to not implement this behavior until it is clear
what it should be.

-- Hannes

