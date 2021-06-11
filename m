Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D8C4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184F461374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFKHE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:04:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30114 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhFKHEz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 03:04:55 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4G1Wy61lmBz5tlC;
        Fri, 11 Jun 2021 09:02:54 +0200 (CEST)
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net> <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org> <xmqqy2bg3nqw.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
Date:   Fri, 11 Jun 2021 09:02:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2bg3nqw.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.06.21 um 08:43 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> But I would estimate that most conflicts (in absolute number among all
>> developers using Git) arise during rebase operations and cherry-picking,
>> i.e., while one is working on their own code. In such sitations, the
>> simpler conflict markup is sufficient, because one knows the background
>> and reason of the conflicts.
> 
> "rebase -i" to reorganize one's own series would be a prime example
> of "conflicts you need to resolve in code that is purely your own
> and nobody else's", and cherry-picking used while reorganizing one's
> own series falls into the same category.  I agree that a simpler
> markup would be more appropriate in such cases.
> 
> Rebasing to catch up with updated upstream is a different story,
> though.  The same for cherry-picking an earlier change to an updated
> upstream.

I've reflected on this a bit more as well. I've forgotten about the
"catch up with someone else" case. That is certainly helped by diff3
style. I retract my opposition and am now neutral to a potential change
of default. (I still don't endorse it because it upsets my workflow.)

The case that inner conflicts are presented sub-optimally under diff3
remains, though.

-- Hannes
