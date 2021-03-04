Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F471C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5882664F09
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhCDNa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 08:30:28 -0500
Received: from siwi.pair.com ([209.68.5.199]:52710 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhCDNaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 08:30:08 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2A2283F40DA;
        Thu,  4 Mar 2021 08:29:28 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E5DE53F40D9;
        Thu,  4 Mar 2021 08:29:27 -0500 (EST)
Subject: Re: [PATCH v4 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
 <YDihb2Kspbh4FIlW@coredump.intra.peff.net>
 <9304ac66-f493-2150-95e3-15303c914ee3@jeffhostetler.com>
 <xmqq1rcwjacv.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <85cd4d20-f68d-ef1d-c95b-f34f61f906b1@jeffhostetler.com>
Date:   Thu, 4 Mar 2021 08:29:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rcwjacv.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/3/21 2:38 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> Right, I think it would be fine to malloc it here, but I didn't
>> want to assume that everyone would think that.
>>
>> I'll change it.
> 
> I agree with both of you that the code is unnice in its stack usage
> and we want fix with malloc(), or something like that, but sorry, I
> think I merged this round by mistake to 'next'.
> 
> As we won't be merging the topic to the upcoming release anyway, I
> am willing to revert the merge to 'next' and requeue an updated one,
> when it appears (I am also OK to see an incremental update, "oops,
> no, we realize we don't want to have it on the stack" fix-up, if
> this is the only glitch in the series that need to be fixed).
> 
> Thanks.
> 

I'm preparing a follow-on patch series to address Peff's comments
from Friday/Monday and yours from yesterday.  I thought I'd send
it as a set of new changes to sit on top of what we have in "next"
if that would make things easier for you.

After the upcoming release we can talk about whether it would be
better for me to smash together the 2 series or not.

Jeff
