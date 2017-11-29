Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704A520C13
	for <e@80x24.org>; Wed, 29 Nov 2017 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbdK2IJO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 29 Nov 2017 03:09:14 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:34753 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdK2IJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 03:09:13 -0500
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 8D18B5D365
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 09:09:12 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 6D4615CE9D
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 09:09:12 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Wed, 29 Nov 2017 09:09:12 +0100
Message-Id: <5A1E6B27020000A10002916B@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Wed, 29 Nov 2017 09:09:11 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: bug deleting "unmerged" branch (2.12.3)
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de>
 <alpine.DEB.2.21.1.1711281542400.6482@virtualbox>
In-Reply-To: <alpine.DEB.2.21.1.1711281542400.6482@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org





> Hi Ulrich,
> 
> On Tue, 28 Nov 2017, Ulrich Windl wrote:
> 
>> During a rebase that turned out to be heavier than expected 8-( I
>> decided to keep the old branch by creating a temporary branch name to
>> the commit of the branch to rebase (which was still the old commit ID at
>> that time).
>>
>> When done rebasing, I attached a new name to the new (rebased) branch,
>> deleted the old name (pointing at the same rebase commit), then
>> recreated the old branch from the temporary branch name (created to
>> remember the commit id).
>>
>> When I wanted to delete the temporary branch (which is of no use now), I
>> got a message that the branch is unmerged.
> 
> This is actually as designed, at least for performance reasons (it is not
> exactly cheap to figure out whether a given commit is contained in any
> other branch).
> 
>> I think if more than one branches are pointing to the same commit, one
>> should be allowed to delete all but the last one without warning. Do you
>> agree?
> 
> No, respectfully disagree, because I have found myself with branches
> pointing to the same commit, even if the branches served different
> purposes. I really like the current behavior where you can delete a
> branch with `git branch -d` as long as it is contained in its upstream
> branch.

Hi!

I'm not talking about the intention of a branch, but of the state of a branch: If multiple branches point (not "contain") the same commit, they are equivalent (besides the name) at that moment. As no program can predict the future or the intentions of the user, it should be safe to delete the branch, because it can easily be recreated (from the remaining branches pointing to the same commit).

It shouldn't need a lot of computational power to find out when multiple branches point to the same commit.

Regards,
Ulrich


