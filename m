Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F9BC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiCWVjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiCWVjk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:39:40 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 14:38:08 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB21A836
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:38:08 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4KP1gS1x5Wz1s75c;
        Wed, 23 Mar 2022 22:28:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4KP1gS03vwz1qr2t;
        Wed, 23 Mar 2022 22:28:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 1J7pcH2oNv4h; Wed, 23 Mar 2022 22:28:35 +0100 (CET)
X-Auth-Info: a8LZK+RgBHoxksDH3Ym5xau+esOQCKUunYpF+6M32bn1/DSZWCc9DzDBwmB12WIt
Received: from igel.home (ppp-46-244-163-88.dynamic.mnet-online.de [46.244.163.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 23 Mar 2022 22:28:35 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id C7E012C3A88; Wed, 23 Mar 2022 22:28:34 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     John Garry <john.garry@huawei.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Question] .git folder file updates for changing head commit
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
X-Yow:  I used to be a FUNDAMENTALIST, but then I heard about the
 HIGH RADIATION LEVELS and bought an ENCYCLOPEDIA!!
Date:   Wed, 23 Mar 2022 22:28:34 +0100
In-Reply-To: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com> (John Garry's
        message of "Wed, 23 Mar 2022 15:19:06 +0000")
Message-ID: <87wngkpddp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 23 2022, John Garry wrote:

> For building the linux perf tool we use the git head commit id as part of
> the tool version sting. To save time in re-building, the Makefile rule has
> a dependency on .git/HEAD for rebuilding.

There is no guarantee that .git is a directory.  In a separate worktree
.git is actually a gitfile.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
