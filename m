Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBECC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F8560C41
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhE3V5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:57:50 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:43907 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhE3V5t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:57:49 -0400
Received: from yv.noip.me (c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 14ULu0Db091908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 30 May 2021 14:56:00 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-189-35-76.hsd1.ca.comcast.net [73.189.35.76] claimed to be yv.noip.me
Subject: Re: [BUG REPORT] File names that contain UTF8 characters are
 unnecessarily escaped in 'git status .' messages
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <f7e2e271-dcec-2886-f33e-62778a429850@rawbw.com>
 <xmqq35u9ax5j.fsf@gitster.g> <6318ccec-ec96-91a8-fd65-85daf4a9a22b@rawbw.com>
 <20210527045628.uvesihyhtqrfyfae@tb-raspi4>
 <YK+mWZP+sl3zXECx@coredump.intra.peff.net>
 <4dd22f16-72f0-a28a-8be0-aec622acf0d3@rawbw.com>
 <50e2780a-21f3-499f-7960-76bf24f550f0@gmail.com>
 <6fef4b1e-1ec7-b697-c311-59caf6408b29@rawbw.com>
 <20210529092752.kifzqt3haddzgsob@tb-raspi4>
 <YLQHPu0bIy4qHEWP@coredump.intra.peff.net>
From:   Yuri <yuri@rawbw.com>
Message-ID: <481fbc88-3e7d-6b00-0997-1a80b87a637d@rawbw.com>
Date:   Sun, 30 May 2021 14:55:59 -0700
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLQHPu0bIy4qHEWP@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/30/21 2:44 PM, Jeff King wrote:
> Yeah, I'm not sure how such a check would be done. On most Linux systems
> I've seen, $LANG will mention "en_US.UTF-8" or similar. But I've no idea
> how portable that convention is, not to mention that people may have
> more complex setups anyway (e.g., not setting $LANG but setting some of
> LC_*).


When 'locale charmap' prints 'UTF-8' the terminal can be assumed to be 
able to accept UTF-8 characters.

'locale charmap', I think, determines this only based on environment 
variables.



Yuri

