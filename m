Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C22BC388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0C422201
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 17:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgKURrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 12:47:40 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:35408 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgKURrj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 12:47:39 -0500
Received: from client3368.fritz.box (i5C747C51.versanet.de [92.116.124.81])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 2B8673C0506;
        Sat, 21 Nov 2020 18:47:38 +0100 (CET)
Subject: Re: [PATCH v2] git-gui: Basic dark mode support
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org
References: <20200922110419.ymqj4ol76kg6qshf@yadavpratyush.com>
 <20200926145443.15423-1-serg.partizan@gmail.com>
 <20201008130741.mz7k3uy65xdbdkeh@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
Date:   Sat, 21 Nov 2020 18:47:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201008130741.mz7k3uy65xdbdkeh@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.10.20 15:07, Pratyush Yadav wrote:
> On 26/09/20 05:54PM, Serg Tereshchenko wrote:
>> Removed forced colors in ttext widget calls,
>> instead using Text.Background/Foreground options.
>> This way colors can be configured dependent on current theme, and even
>> overriden by user via .Xresources.
>>
>> Extracted colors for in_sel/in_diff tags into colors:: namespace,
>> where they can be configured from current theme colors.
>>
>> Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
>> ---
>>  git-gui.sh     | 17 +++++++++++------
>>  lib/themed.tcl | 38 ++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 49 insertions(+), 6 deletions(-)
> 
> Merged to git-gui/master. Thanks.

This caused a regression: when selecting text in the diff pane or in the
commit message window, the selected text now has a black background (on
Mac and on Windows, I don't have a Linux system to test this). This
looks quite ugly; it used to be light blue on both of these systems.

When setting gui.usettk to 0, it is light blue as before (as expected).

I'm sorry that I can't give any suggestions how to fix this, because I
have trouble understanding the code related to themes, even after
staring at it for quite a while this afternoon.

Best,
Stefan
