Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB09C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 10:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2909208B3
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 10:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgJNK1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 06:27:25 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:60024 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJNK1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 06:27:25 -0400
Received: from client3368.local (i5C745714.versanet.de [92.116.87.20])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id F3CFC3C03AC;
        Wed, 14 Oct 2020 12:27:23 +0200 (CEST)
Subject: Re: [PATCH] git-gui: Make usettk off by default on Mac OS X
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <20201013190243.62313-1-stefan@haller-berlin.de>
 <20201014100111.c43f2fqipc52dtsg@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <0aef1f02-5eed-41ed-c402-540fa50d79f1@haller-berlin.de>
Date:   Wed, 14 Oct 2020 12:27:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201014100111.c43f2fqipc52dtsg@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14.10.20 12:01, Pratyush Yadav wrote:
> Hi Stefan,
> 
> On 13/10/20 09:02PM, Stefan Haller wrote:
>> This option is supposed to make a Tcl/Tk app look more like a native app
>> for the respective platform. This doesn't seem to work on Mac, it looks
>> worse than the non-ttk appearance (for instance, the colored pane
>> headers are grey).
> 
> I think we should actually fix the root of the problem instead of just
> fixing the symptoms by disabling ttk.
> 
> There were recently some changes to how git-gui works with ttk in commit
> c02efc1 (git-gui: improve dark mode support, 2020-09-26). Are you
> running git-gui with that commit? If yes, what results do you see with
> it reverted. If no, what results do you see with it applied?

I agree that it would be better to fix the root cause; my suspicion was 
that the themed widgets on Mac simply don't support a background color, 
but I didn't investigate that any further.

I was indeed not running with "git-gui: improve dark mode support" yet, 
but applying it didn't make a difference.

I'm also happy to drop this if you are uncomfortable with it; it's easy 
enough to set gui.usettk to 0 to fix the problem locally.

Best,
Stefan
