Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B61EC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C7861002
	for <git@archiver.kernel.org>; Tue, 18 May 2021 10:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbhERKcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 06:32:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:29340 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241563AbhERKcK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 06:32:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 707D33F4139;
        Tue, 18 May 2021 06:30:51 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 37D503F40E6;
        Tue, 18 May 2021 06:30:51 -0400 (EDT)
Subject: Re: [Broken] RE: [ANNOUNCE] Git v2.32.0-rc0
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Cc:     'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
References: <007201d74b25$de5f2710$9b1d7530$@nexbridge.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <461ca908-b88f-9e09-572d-ed49131b84fd@jeffhostetler.com>
Date:   Tue, 18 May 2021 06:30:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <007201d74b25$de5f2710$9b1d7530$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/17/21 10:06 AM, Randall S. Becker wrote:
> On May 17, 2021 3:06 AM, Junio C Hamano wrote:
>> To: git@vger.kernel.org
>> Cc: Linux Kernel <linux-kernel@vger.kernel.org>; git-
>> packagers@googlegroups.com
>> Subject: [ANNOUNCE] Git v2.32.0-rc0
>>
>> An early preview release Git v2.32.0-rc0 is now available for
>> testing at the usual places.  It is comprised of 545 non-merge
>> commits since v2.31.0, contributed by 76 people, 29 of which are
>> new faces [*].
> 
> Git 2.23.0 no longer builds on NonStop x86. Reference to pthreads is not permitted in s non-pthread build.
> 
> **** ERROR **** [1210]:
>     libgit.a(ipc-unix-socket.o): In function `thread_block_sigpipe':
>     ipc-unix-socket.o(.text+0xb87): unresolved reference to pthread_sigmask.
> 
> We are not building with pthreads. This is net-new for 2.32.0-rc0, not seen in 2.31.0.
> 
> I'm unsure as to why this file is even being included in a non-thread build.
> 
> Randall
> 
> 

I should have ifdef'd that code with NO_PTHREADS it seems.
Let me take a look.

Jeff
