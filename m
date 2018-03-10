Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A3F1FAE2
	for <e@80x24.org>; Sat, 10 Mar 2018 09:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeCJJht (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 04:37:49 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.111]:51198 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeCJJhs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 04:37:48 -0500
X-Greylist: delayed 1179 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Mar 2018 04:37:48 EST
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1euadr-0005po-Fv; Sat, 10 Mar 2018 10:18:15 +0100
Subject: Re: git stash push -u always warns "pathspec '...' did not match any
 files"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
References: <349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com>
 <20180303154654.GH2130@hank>
 <08d765ec-b2d7-7087-fca5-2eecefcef9cf@syntevo.com>
 <xmqqwoyk51w4.fsf@gitster-ct.c.googlers.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <d49b1b73-3d16-f29d-4363-a5dba4853842@syntevo.com>
Date:   Sat, 10 Mar 2018 10:18:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqwoyk51w4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.03.2018 23:18, Junio C Hamano wrote:
> Marc Strapetz <marc.strapetz@syntevo.com> writes:
> 
>> Thanks, I can confirm that the misleading warning message is fixed.
>>
>> What I've noticed now is that when using -u option, Git won't warn if
>> the pathspec is actually not matching a file. Also, an empty stash may
>> be created.
> 
> Soooo..., does it mean that the patch Thomas posted and you
> confirmed trades one issue with another issue with a similar
> graveness?

 From my understanding these are two separate problems for which the new 
one was somewhat hidden by the one Thomas has fixed: Thomas has fixed 
post-processing code after the stash has already been saved away. The 
problem I'm referring to is a missing check for invalid paths before the 
stash is saved away.

-Marc
