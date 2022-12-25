Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC4BC3DA7A
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 17:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLYRTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 12:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLYRTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 12:19:16 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297A121B4
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 09:19:13 -0800 (PST)
Received: (Authenticated sender: i@isandrew.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 11785240002
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 17:19:11 +0000 (UTC)
Message-ID: <5b64c7f5-59e3-f319-4efa-4624907436b6@isandrew.com>
Date:   Mon, 26 Dec 2022 02:19:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   git@isandrew.com
Subject: Theirs merge strategy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Would it be possible to revisit the decision to not have a "theirs" 
merge strategy?

I think there are legitimate reasons to use it, beyond the plenty of 
rope argument.

One example is you're working with a successfully written and operating 
branch through multiple releases, but due to some external change 
(product direction, upstream changes) you decide that an approach in a 
different branch is better.  You want to use the other branch, while 
keeping the history of the successful prior releases, for all the normal 
reasons one wants to keep history.  A hard reset wouldn't help in this case.

The decision to remove it was to prevent people from having bad 
workflows.  In reality, in lieu of theirs people use ours in reverse 
which is even worse.

The previous discussion I found was at 
https://marc.info/?l=git&m=121637513604413&w=2

