Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98362C64E69
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566F420728
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgKWTDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:03:34 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:37944 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKWTDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:03:33 -0500
Received: from client3368.fritz.box (i5C7462D2.versanet.de [92.116.98.210])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id B3B1D3C052F;
        Mon, 23 Nov 2020 20:03:32 +0100 (CET)
Subject: Re: [PATCH] git-gui: Fix selected text colors
To:     serg.partizan@gmail.com
Cc:     git@vger.kernel.org, me@yadavpratyush.com
References: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
 <20201122133233.7077-1-serg.partizan@gmail.com>
 <2436cd2e-26b9-a7cc-722a-7f27212f58f4@haller-berlin.de>
 <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <b4571217-ea98-a282-48d3-e9679c600f4c@haller-berlin.de>
Date:   Mon, 23 Nov 2020 20:03:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.11.20 18:16, serg.partizan@gmail.com wrote:
> I think calculating that gray color from current selection bg is too
> much work for just one color.
> 
> We can just set inactiveSelectBackground to some neutral gray color like
> #707070 or #909090 which will work fine with both dark and light themes.

I tested this, but it doesn't work well enough, in my opinion. An
#888888 gray is too dark for normal mode, but too bright for dark mode
on Mac.

Calculating a gray color is not really so difficult, so I'll just do
that in v2. The problem is that it needs to be recalculated when the
theme changes, and I have trouble testing that because the
<<ThemeChanged>> event doesn't appear to be sent on Mac, as far as I can
see.

-Stefan
