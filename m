Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8F21F731
	for <e@80x24.org>; Thu,  1 Aug 2019 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfHAUk1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 16:40:27 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:56458 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfHAUk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 16:40:27 -0400
Received: from [87.165.16.84] (helo=[192.168.2.6])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htHs6-0004WQ-N3; Thu, 01 Aug 2019 22:40:22 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <20190731171956.GA26746@sigill.intra.peff.net>
 <ab333992-35c6-a5a9-0bcb-cef51f004679@syntevo.com>
 <06daa8c1-d955-1e49-e5e6-85d53ffce6e6@gmail.com>
 <xmqqmugsmy2e.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <27220d22-8c9a-dda2-764b-709dcd85d788@syntevo.com>
Date:   Thu, 1 Aug 2019 22:40:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqmugsmy2e.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.08.2019 22:26, Junio C Hamano wrote:
> All true.  Perhaps we need a separate tutorial for scripters to
> teach them how to properly combine the plumbing commands?

@Phillip thanks for your effort!

However, I must admit that for us, this cure is worse then the problem.

We're not exactly scripting, rather we're assisting users to make
their work with git more convenient/efficient. If we replace all the
familiar commands with exotic combinations of 2-3 chained plumbing,
this will definitely leave most users completely clueless about what
our UI is doing (we have a window that shows all executed commands).

On top of that, I think that my quick analysis only uncovered like
1/3 of all the new edge cases (compared to using high-level commands)
and the solutions already look quite scary to me. Taking the other 2/3
into account, it really feels that this would be a path of lots of pain
and many bugfixes.
