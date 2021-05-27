Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA91AC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27B56113B
	for <git@archiver.kernel.org>; Thu, 27 May 2021 20:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhE0Uwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 16:52:38 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:57369 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhE0Uwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 16:52:36 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 14RKoxBo029844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 27 May 2021 13:50:59 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g> <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
 <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
From:   Yuri <yuri@rawbw.com>
Message-ID: <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
Date:   Thu, 27 May 2021 13:50:58 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not clear from the conversation if git reads terminal capabilities 
at all.


But the default behavior, without any options set, should be to read 
terminal capabilities, and write non-ASCII characters verbatim when 
terminal supports this and escape them when terminal doesn't support them.

Current default behavior appears to be to always escape non-ASCII 
characters.


Then options can change this basic behavior according to user's choice.



Yuri


