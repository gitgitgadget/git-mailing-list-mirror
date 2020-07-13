Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B8DC433E3
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558EB2075B
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGMUnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:43:53 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:32365 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgGMUnx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:43:53 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4B5Fx15XRwz5tl9;
        Mon, 13 Jul 2020 22:43:49 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 28604149;
        Mon, 13 Jul 2020 22:43:49 +0200 (CEST)
Subject: Re: FETCH_HEAD files and mirrored repos
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
 <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
 <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
 <20200713200049.6a22nek4xckwtpt6@chatter.i7.local>
 <xmqqtuybmba1.fsf@gitster.c.googlers.com>
 <20200713202211.GA2355588@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <234fc5b6-9a64-725c-afd3-e102ea849e97@kdbg.org>
Date:   Mon, 13 Jul 2020 22:43:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713202211.GA2355588@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.07.20 um 22:22 schrieb Jeff King:
> I occasionally use FETCH_HEAD for such things. If we were to stop
> writing it automatically, I think the key thing to notice is whether the
> result was actually stored anywhere else. Or more accurately, whether
> the user asked for any refspecs on the command line (since we'd still
> update tracking refs in some cases).
> 
> If I do:
> 
>   git fetch
> 
> or:
> 
>   git fetch origin refs/heads/foo:refs/heads/foo
> 
> then I probably don't care about FETCH_HEAD. But if I do:
> 
>   git fetch origin refs/heads/foo
> 
> then I'm probably interested in picking the result out of FETCH_HEAD.

Very good observation. The latter is exactly the "many cases" I
mentioned where I do care about FETCH_HEAD.

-- Hannes
