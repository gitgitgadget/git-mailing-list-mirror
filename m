Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE821F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfJ2ULc (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:11:32 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:45987 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2ULc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:11:32 -0400
Received: from [84.175.178.241] (helo=[192.168.2.6])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iPXpv-0005fi-0j; Tue, 29 Oct 2019 21:11:27 +0100
Subject: Re: [PATCH v2 1/1] vreportf(): avoid relying on stdio buffering
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
 <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
 <e426627e1494e31e548fe044c1c1806ff59340cf.1572356272.git.gitgitgadget@gmail.com>
 <1a6119b4-b44f-0edd-da18-46b7d31a274f@syntevo.com>
 <nycvar.QRO.7.76.6.1910292049530.46@tvgsbejvaqbjf.bet>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <97291857-42a2-4865-b265-d55fcf131ba5@syntevo.com>
Date:   Tue, 29 Oct 2019 21:11:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910292049530.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.10.2019 20:57, Johannes Schindelin wrote:

> It is not entirely obvious to me what exactly you mean by "this",
> assuming that you refer to comparing two pointers via `<`, I agree that
> this is not the best idea, I changed it to `off < pend - msg`. If my
> assumption is correct, however, we are still talking about C, so I
> wonder how this C++ document you linked could bear any relevance:

The linked portion of text speaks about adding to pointer. The paragraph 
is a bit long and my quote was indeed hard to grasp. And yes, sorry, C++ 
habits. However, the same thing applies to C, let's have this link instead:

https://web.archive.org/web/20181230041359if_/http://www.open-std.org/jtc1/sc22/wg14/www/abq/c17_updated_proposed_fdis.pdf

Hopefully a better quote this time (c/c++ standard are hard to read for 
mortals like me):

When an expression that has integer type is added to or subtracted from 
a pointer <...> If both the pointer operand and the result point
to elements of the same array object, or one past the last element of 
the array object, <...> otherwise, the behavior is undefined.

> Quite honestly, I purposefully refrained from copying that information.

That's a pity, I've put quite an effort into researching all that.
