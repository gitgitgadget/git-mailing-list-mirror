Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3CD41FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 18:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952868AbdDYS1C (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 14:27:02 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:52134 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952865AbdDYS0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 14:26:55 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wCBWK3ByBz5tlC;
        Tue, 25 Apr 2017 20:26:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 03D3D42D2;
        Tue, 25 Apr 2017 20:26:53 +0200 (CEST)
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
 <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1704211135430.3480@virtualbox>
 <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
 <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org>
 <CAP8UFD1r9TFE9ns5pobDOpugF8MBiJAYgrRALCqGVmgWud=QjQ@mail.gmail.com>
 <3bd4a2d7-ada9-6198-8cf1-573d80cae1b4@kdbg.org>
 <xmqqa875uggj.fsf@gitster.mtv.corp.google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1336f7a6-4785-d60d-d100-df38e22aa9e8@kdbg.org>
Date:   Tue, 25 Apr 2017 20:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa875uggj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2017 um 08:52 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> The idea of marking git-gui and gitk histories that none of their
>> commits is checked out: it erases all Git source code from the working
>> directory, and a later bisection step places all code back and it
>> requires a full build. Not a big deal with Git, but there are much
>> larger code bases.
>>
>> The current bisect behavior makes this idea unworkable. For me, it was
>> a big step backwards when it was implemented. :-(
>
> I think it is sort-of unfair to blame bisect for that.  It talks
> more about how "coolest merge evar!" cross project merges are
> unworkable in practice.

No, it has nothing to do with the "coolest merge ever". The same problem 
occurs when I'm working on a topic branch:

      A--....--B   <- topic
     /
  --g--....--G     <- integration branch ("good by default")

While fiddling with B, I find a bug and suspect it somewhere on the 
topic from A to B. When A has a change that causes a substantial or 
complete rebuild, testing g causes burden for no good reason.

But, as I said, this is a tangent. I have no mission to change git bisect.

-- Hannes

