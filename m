Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF01C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D4F2087E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBCU1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:27:51 -0500
Received: from mx.sdas.de ([88.198.162.67]:41069 "EHLO mx.sdas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgBCU1u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 15:27:50 -0500
Received: from [192.168.1.58] (unknown [31.36.247.254])
        (Authenticated sender: etienne.servais@voucoux.fr)
        by mx.sdas.de (Postfix) with ESMTPSA id C496B11C0F0;
        Mon,  3 Feb 2020 21:27:47 +0100 (CET)
Subject: Re: [PATCH] doc: add documentation for git log --no-follow
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <85e71c97-9e0a-863e-179f-a6e1f14365ce@voucoux.fr>
 <20200201111636.GC1864948@coredump.intra.peff.net>
From:   =?UTF-8?Q?=c3=89tienne_Servais?= <etienne.servais@voucoux.fr>
Message-ID: <8d0dbaa2-938e-1797-98d7-3f9abeb5b863@voucoux.fr>
Date:   Mon, 3 Feb 2020 21:27:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200201111636.GC1864948@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 01/02/2020 à 12:16, Jeff King a écrit :
> On Sat, Feb 01, 2020 at 12:24:31AM +0100, Étienne Servais wrote:
> 
>> This feature was added by commit
>> 076c98372e (log: add "log.follow" configuration variable, 2015-07-07)
>> but remained undocumented.
> 
> That commit just touched the code; it was originally added by aebbcf5797
> (diff: accept --no-follow option, 2012-09-21). But I think the general
> intent of your patch is still valid.

Good catch. Corrected in upcoming patch v2

>> I couldn't figure if I shall merge the --no-follow doc with the follow
>> as is done for --no-decorate and --decorate just after.
> 
> I think it would make more sense to just put it with --follow, like:
> 
>   [--no-]follow::
> 
> which matches how --use-mailmap is defined, for instance.

Ok, I've turned it to (inspired by the --[no-]rename-empty doc)

---follow::
-       Continue listing the history of a file beyond renames
+--[no-]follow::
+       Whether to continue listing the history of a file beyond renames
        (works only for a single file).


> 
>> @@ -205,7 +208,8 @@ log.follow::
>>  	If `true`, `git log` will act as if the `--follow` option was used when
>>  	a single <path> is given.  This has the same limitations as `--follow`,
>>  	i.e. it cannot be used to follow multiple files and does not work well
>> -	on non-linear history.
>> +	on non-linear history. This setting can be disabled by the `--no-follow`
>> +	option.
> 
> I'm on the fence on this hunk. There are a number of config options that
> can be canceled or overridden by command-line options. It's a normal
> pattern for the "--no" variant to do so. So while it often doesn't hurt
> to give a pointer in the right direction, I don't know that we'd want to
> start doing so in every such case.

OK. I had just borrowed that sentence from notes.displayRef few lines below.
Some config options doc follow this direction like log.abbrevCommit or log.mailmap.

I'll follow you on this.


-- 
Étienne Servais
