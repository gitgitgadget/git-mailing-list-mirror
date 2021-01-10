Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,FSL_HAS_TINYURL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87644C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 22:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F8F229C7
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 22:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbhAJWYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 17:24:03 -0500
Received: from mail-gateway-shared11.cyon.net ([194.126.200.64]:45208 "EHLO
        mail-gateway-shared11.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbhAJWYD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 17:24:03 -0500
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1kyj7G-0002dj-2r
        for git@vger.kernel.org; Sun, 10 Jan 2021 23:23:20 +0100
Received: from [10.20.10.232] (port=62366 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <dev+git@drbeat.li>)
        id 1kyj7E-00Bheo-Tm; Sun, 10 Jan 2021 23:23:16 +0100
Subject: Re: [PATCH] gitk: check main window visibility before waiting for it
 to show
To:     Tobias Pietzsch via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Tobias Pietzsch <tobias.pietzsch@gmail.com>,
        Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
References: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <bdaab72b-37f4-658a-716a-d6a958b6f709@drbeat.li>
Date:   Sun, 10 Jan 2021 23:23:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-CH
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.01.21 00:26, Tobias Pietzsch via GitGitGadget wrote:
> From: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
>
> If the main window is already visible when gitk waits for it to
> become visible, gitk hangs forever.
> This commit adds a check whether the window is already visible.
> See https://wiki.tcl-lang.org/page/tkwait+visibility
>
> Signed-off-by: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
> ---
>     gitk: check main window visibility before waiting for it to show
>
>     If the main window is already visible when gitk waits for it to become
>     visible, gitk hangs forever.
>
>     This commit adds a check whether the window is already visible. See
>     https://wiki.tcl-lang.org/page/tkwait+visibility
>
>     The symptom of the for-ever waiting is that gitk shows just an empty
>     window, like this: https://tinyurl.com/yxr5qlf6 It happens (to me) on
>     macOS 11.1 with git-gui installed via homebrew. It doesn't happen on
>     macOS 10.14.

Thanks, this also occurred on my macOS 10.14.6 just an hour ago after a
recent brew upgrade, and the patch makes gitk usable again.

Cheers, Beat
