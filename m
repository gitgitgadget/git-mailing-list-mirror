Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7CCC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C4720692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgAHRmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:42:19 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.106]:18238 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgAHRmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 12:42:19 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ipFLS-0000mA-Ps; Wed, 08 Jan 2020 18:42:14 +0100
Subject: Re: [PATCH v4 0/3] t: rework tests for --pathspec-from-file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.503.v3.git.1577786032.gitgitgadget@gmail.com>
 <pull.503.v4.git.1577787313.gitgitgadget@gmail.com>
 <xmqqh8173r8e.fsf@gitster-ct.c.googlers.com>
 <12861b02-386c-3ae8-cd2f-ffe07c6aabc7@syntevo.com>
 <xmqqimll3lmn.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <0b54d95c-a5e0-c156-b972-a1e171678785@syntevo.com>
Date:   Wed, 8 Jan 2020 18:42:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqimll3lmn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.01.2020 18:26, Junio C Hamano wrote:
>> I will implement the next --pathspec-from-file patches as if this
>> third patch was accepted (that is, without copy&pasted tests).
> 
> I am not sure if that is a good idea.  I'd rather see the planned
> new changes not to be taken hostage of the third step.

In my understanding, the new patches will not be taken hostage, they 
will simply adopt the new approach. Everything will work just fine 
whether or not third step is present.

> Besides, with the third step, your preference is not to test the
> behaviour of end-user facing commands that would learn the option at
> all and only test the underlying machinery with test-tool tests, no?

That's not exactly correct. Third step removes duplicate tests that give 
no real benefit. With test-tool tests in place and succceeding, these 
duplicate tests are super unlikely to fail.

I will still provide a few tests for every new command to make sure that 
said command works as intended. I will only skip indirectly testing 
global API again and again.

> If you are not adding tests for the higher-level end-user facing
> commands as part of these new series, would it make a difference if
> the codebase has the third step applied (i.e. missing tests for the
> end-user facing commands that have already learned the option) or
> not (i.e. the commands that have already learned the option are
> still tested end-to-end)?

I will be adding good tests and skip useless tests. For new commands, it 
doesn't really matter if "third step" patch is applied or not.
