Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738AC56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3AAB20715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgKXVUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:20:01 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:42516 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKXVUB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:20:01 -0500
Received: from client3368.local (i5C747A7D.versanet.de [92.116.122.125])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 2B2453C052F;
        Tue, 24 Nov 2020 22:19:59 +0100 (CET)
Subject: Re: [PATCH] git-gui: Fix selected text colors
To:     serg.partizan@gmail.com
References: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
 <20201122133233.7077-1-serg.partizan@gmail.com>
 <2436cd2e-26b9-a7cc-722a-7f27212f58f4@haller-berlin.de>
 <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
 <b4571217-ea98-a282-48d3-e9679c600f4c@haller-berlin.de>
 <NKO9KQ.ECZZ8I6WPK063@gmail.com>
Cc:     git@vger.kernel.org, me@yadavpratyush.com
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <55348fbb-95bb-1dd2-4e17-4fc622ae7603@haller-berlin.de>
Date:   Tue, 24 Nov 2020 22:19:59 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <NKO9KQ.ECZZ8I6WPK063@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.11.20 21:50, serg.partizan@gmail.com wrote:
> 
> 
> On Mon, Nov 23, 2020 at 20:03, Stefan Haller <stefan@haller-berlin.de>
> wrote:
>> The problem is that it needs to be recalculated when the
>> theme changes, and I have trouble testing that because the
>> <<ThemeChanged>> event doesn't appear to be sent on Mac, as far as I can
>> see.
> 
> How are you testing this?

By changing the Appearance setting from Light to Dark or back in Mac's
preferences window. The git gui window does update dynamically when you
do this.

However, I think I was wrong when I assumed that this would change the
theme; there's only one theme on Mac, the "aqua" theme. It just changes
its colors, it seems.

> So you can safely put your code inside "color::sync_with_theme".

Will do; I'll send out v2 in a moment.

> And We should move call to sync_with_theme from git-gui.sh into
> InitTheme. I don't know why I have not put it there before.

Yes, I was wondering this too. But as it doesn't seem to make a
difference in practice, I'll leave this for someone else to fix at some
point.
