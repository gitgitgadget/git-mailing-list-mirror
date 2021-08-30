Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C44C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D000960F57
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhH3APO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:15:14 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:41150 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhH3APO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:15:14 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 17U0EHc4014071
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 29 Aug 2021 17:14:17 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: Git re-creates newly added directory when it is pushed
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
 <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
 <xmqqv93n7q1v.fsf@gitster.g>
From:   Yuri <yuri@rawbw.com>
Message-ID: <da2bfcc8-09b2-c909-a316-343ab3108a58@rawbw.com>
Date:   Sun, 29 Aug 2021 17:14:15 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv93n7q1v.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/21 5:07 PM, Junio C Hamano wrote:
> This is one of the reasons why "rebase" (especially "rebase -i") may
> want to insist starting at the top-level of the working tree, like
> "git bisect" does.  Because running the command from a subdirectory
> works most of the time until it doesn't, people tend to complain why
> they should go up to the top-level before they can run the command.
>
> And this is why---it causes end-user confusion.


But there's no confusion here - git doesn't have to delete the directory 
and recreate it, but it does it anyway.

So this is just a bug that git disturbs users more than it should.


Yuri


