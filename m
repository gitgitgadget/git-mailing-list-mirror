Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427F8C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 23:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhLVXE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:04:27 -0500
Received: from siwi.pair.com ([209.68.5.199]:24336 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhLVXE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 18:04:27 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C26463F40FB;
        Wed, 22 Dec 2021 18:04:26 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8E4253F40F5;
        Wed, 22 Dec 2021 18:04:26 -0500 (EST)
Subject: Re: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
 <xmqqlf0equs3.fsf@gitster.g>
 <a6f2a38b-926a-4b47-fd3f-b1327a7c3fcb@jeffhostetler.com>
 <xmqqwnjwdz9j.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a7489206-e203-bb4d-c89b-9bda80118db3@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 18:04:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnjwdz9j.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/22/21 5:56 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> I hadn't really thought about the term "TLS" in the context
>> of crypto -- I had "thread local storage" on the brain.  I guess
>> I've spent too much of my youth using Win32 thread APIs. :-)
>>
>> Let me take a look at removing those terms.
> 
> Nah, it may be just me.  As long as what TLS stands for is clear in
> the context, it is fine.
> 

ok thanks.  i took a quick look at scrubbing the
code of TLS and even though most of the uses are
in private (or protected) tr2_*.[ch] files, it
will be a large churn-type change and i'm not
sure it's worth the effort.

thanks
jeff
