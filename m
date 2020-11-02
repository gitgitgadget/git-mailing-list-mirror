Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E02C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 13:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3DB21D40
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 13:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgKBNP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 08:15:28 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36555 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgKBNP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 08:15:27 -0500
X-Originating-IP: 103.82.80.169
Received: from localhost (unknown [103.82.80.169])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B4F14FF803;
        Mon,  2 Nov 2020 13:15:25 +0000 (UTC)
Date:   Mon, 2 Nov 2020 18:45:22 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] git-gui: Auto-rescan on activate
Message-ID: <20201102131522.coj5gb2bssvjqngo@yadavpratyush.com>
References: <20201101170505.71246-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101170505.71246-1-stefan@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On 01/11/20 06:05PM, Stefan Haller wrote:
> Do an automatic rescan whenever the git-gui window receives focus. Most other
> GUI tools do this, and it's very convenient; no more pressing F5 manually.

I submitted a patch for this a while back but there was a lengthy 
discussion. [0] would be a good read. IIRC the major blocker was that 
rescan is a very expensive operation on Windows.
 
> People who don't like this behavior can turn it off using
> "git config gui.autorescan false".

To make sure the experience on Windows (and for anyone who faces long 
rescan times) does not degrade, I think we should keep this off by 
default. That said, I would love to be convinced to keep this on by 
default because IMO this is a really good feature to have. I tried 
coming up with ways to avoid slowdowns while keeping the auto rescan on 
but I didn't come up with anything convincing.
 
> Stefan Haller (2):
>   git-gui: Delay rescan until idle time
>   git-gui: Auto-rescan on activate
> 
>  git-gui.sh | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 

[0] https://lore.kernel.org/git/20190728151726.9188-1-me@yadavpratyush.com/

-- 
Regards,
Pratyush Yadav
