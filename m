Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5778EB64D7
	for <git@archiver.kernel.org>; Sun, 18 Jun 2023 09:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjFRJsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jun 2023 05:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRJsB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2023 05:48:01 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5044B18B
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 02:47:59 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 7132323F13;
        Sun, 18 Jun 2023 05:47:57 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1qAp0n-zZl-00; Sun, 18 Jun 2023 11:47:57 +0200
Date:   Sun, 18 Jun 2023 11:47:57 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Nadav Goldstein <nadav.goldstein96@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
Message-ID: <ZI7SzSuT26XXKzah@ugly>
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
 <xmqqjzw3qry6.fsf@gitster.g>
 <ZIzALOe8GBsNGIhR@ugly>
 <xmqqv8fnrwtt.fsf@gitster.g>
 <ZI1xLwemOs9Vxorf@ugly>
 <xmqqwn02qqp4.fsf@gitster.g>
 <f6a510f8-f569-6b1e-a74d-cdd103b39c10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f6a510f8-f569-6b1e-a74d-cdd103b39c10@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2023 at 12:05:21PM +0300, Nadav Goldstein wrote:
>Let me try to explain my motivation:
>I heavily use stash to set quick points in my code so I could go back to 
>them (during thought process), and I want to store my changes quickly 
>and continue from there.
>
so why are you (ab-)using stash for that, rather than just committing 
each time, and later cleaning it by using `reset [--mixed]` and 
re-committing (or using `rebase --interactive`)? the reflog holds 
information about "lost" commits (the stash is just a somewhat special 
reflog, too).

regards,
ossi
