Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4995EC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2F561154
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhGBUBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 16:01:48 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.98]:62651 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBUBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 16:01:48 -0400
X-Greylist: delayed 33312 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 16:01:48 EDT
Received: from [84.163.67.238] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <test2@mfriebe.de>)
        id 1lzGe7-0003G1-BD; Fri, 02 Jul 2021 12:43:43 +0200
Subject: Re: [PATCH 5/5] config: add default aliases
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch>
From:   martin <test2@mfriebe.de>
Message-ID: <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
Date:   Fri, 2 Jul 2021 12:44:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60dee7d4e27bf_2964b20817@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2021 12:17, Felipe Contreras wrote:
> Andreas Schwab wrote:
>> On Jul 02 2021, Felipe Contreras wrote:
>>> +ALIAS
>>> +~~~~~
>>> +'git co'
>> That's `checkout' in hg, bzr, svn and cvs.
> I know, and commit is ci in many of them.
>
> The reason why I decided to make checkout co, is that we have already an
> alternative for checkout: switch. So unlike all those other VCS, in git
> we can have:
>
>    co = commit
>    sw = switch
>

If I may jump into the discussion.

IMHO it would be good to (partly) follow other vcs, and have
commit = ci

but then keep
switch = sw

And leave co empty.

Reasons for co not used:
1) co would be CheckOut, and not switch. But checkout should be faded 
out and replaced by switch/restore
2) co is ambiguous, in the sense that people coming from other vcs 
expect checkout,
    but people who started on git (especially who started with switch, 
instead of checkout) expect commit.
3) if co is not a default, then people can set it according to their own 
taste, with less confusion, than if they override a default.

