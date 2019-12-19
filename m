Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FCCC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A622467E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 19:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLSTxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:53:10 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:43641 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLSTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 14:53:10 -0500
X-Originating-IP: 157.36.156.64
Received: from localhost (unknown [157.36.156.64])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9C264FF805;
        Thu, 19 Dec 2019 19:53:07 +0000 (UTC)
Date:   Fri, 20 Dec 2019 01:23:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Insane Sharpness <insane.sharpness@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: New Git Visualiser Tool - GitVine
Message-ID: <20191219195303.ckeuucm5c7n56eew@yadavpratyush.com>
References: <CAMNO-Ba0-Me67qEEfHoJyBoWg0X_x7=qmmZ1D8ZK9S_0Tk=J5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMNO-Ba0-Me67qEEfHoJyBoWg0X_x7=qmmZ1D8ZK9S_0Tk=J5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 19/12/19 10:53AM, Insane Sharpness wrote:
> Hey All,
> 
> I made an application recently to better visualise git commits on a
> per file basis.
> And added this to the git kernel wiki here
> https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#GitVine
> 
> Does not try to compete with more feature rich & powerful clients like
> Gitk, Kraken etc..
> Just tries to be simpler.
> 
> Free Standalone & runs on Windows, Linux & macOS
> Just needs git in your path. (Developed using Python, Qt & packaged
> with PyInstaller)
> Project Page Here: https://insanesharpness.gitlab.io/GitVine/
> 
> Its still a rough cut and loads of room to improve + add more features.
> Please try, would love to hear what you all think.

I have only used it for a few minutes, but one thing I immediately 
noticed is that the startup time is _really_ slow. On the git-gui repo 
[0] with only about 1200 commits, it takes around 10-15 seconds to load. 
On the git.git repo [1] with around 57,000 commits, it takes nearly two 
minutes to load. In comparison, gitk it almost instant. These two repos 
are relatively small in size, and examples of bigger ones would be 
Linux, Chromium, etc where I expect startup times to be even slower.

I'm running it on Linux on Git v2.24.1. Speeding up the startup time 
would be really nice.

The log for git-gui is missing some merge commits like d32e065 and 
2763530 but then it shows some other merges like 69fdb92. I'm not sure 
why this inconsistency happens. This also leads to the tool showing 
39acfa3 as the HEAD (as of writing this it is also the 'master') when in 
reality the HEAD is at d32e065.

Also, when I double click a commit in the list at the right side, a 
popup opens with the commit information like hash, author, commit 
message, etc. But, I notice that the "Signed-off-by" trailers are 
missing the email addresses. The popup when hovering over a node in the 
graph shows them correctly though. So, for example the trailers of 
39acfa3 are:

    Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>
    Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

But they show up as:

    Signed-off-by: Kazuhiro Kato 
    Signed-off-by: Pratyush Yadav 

All this said, I like the simple and clean UI. Looking forward to how 
the tool grows :)

[0] https://github.com/prati0100/git-gui
[1] https://github.com/git/git

-- 
Regards,
Pratyush Yadav
