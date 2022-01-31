Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387EC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 11:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbiAaLEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 06:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358552AbiAaLDY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 06:03:24 -0500
Received: from mail.inka.de (mail.inka.de [IPv6:2a04:c9c7:0:1073:217:a4ff:fe3b:e77c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE932C0619CF
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 03:02:09 -0800 (PST)
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1nEURi-008Gsv-MJ; Mon, 31 Jan 2022 12:02:06 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id 2A3AC60335; Mon, 31 Jan 2022 12:01:50 +0100 (CET)
Date:   Mon, 31 Jan 2022 12:01:50 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Why won't "git rebase -Xrenormalize -i $REBASE_SHA" do anything?
Message-ID: <20220131110149.GE16463@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've added "* text=auto" to an existing repo with a completely linear history.

Now, as expected, every rebase operation gives me lots of conflicts, which are
hard to resolve.

So I'd like to clean up the history:

  $ git rebase -Xrenormalize -i $REBASE_SHA

But this turns out to be a no-op? It says immediately

  Successfully rebased and updated refs/heads/wip-normalize

without even the counter which is usually output to show progress during an
interactive rebase as it is working through the rebase-todo. I can confirm
that nothing has happened by checking the sha of the branch.

So, what am I missing? How would I renormalize all the commits of a branch?
The branch has linear history, no merges there.

Thanks,

-- 
Josef Wolf
jw@raven.inka.de
