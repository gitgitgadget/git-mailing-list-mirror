Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18591F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 09:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbeGIJnQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 05:43:16 -0400
Received: from s019.cyon.net ([149.126.4.28]:60298 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932436AbeGIJnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 05:43:14 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 05:43:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iI8tbZMHW6VPRkYfZmNNzC00S2zG5BJwBTJ35gR76Wk=; b=EtGOe/IRH1KDy/v6AiJeTt8Lo/
        sxjhmMezrF2SuHvh7U+6jxdqbZDYY8jkjcYxIPueNPFPwWFj3GYrvQThpE/Ii2K99FXyOT65PZCWq
        3M2U9wMGxc5z+HGs68DRXVa9nPed27ilWT2EyF9t/UXFUOP1+/4asdLzl6Jxv5m2EFv11VsPvEmdb
        rPDPxZlEEQ7k03o48gsaNvXNSvonOFSiAwwhbfPc6iSkI/Xw6jkqOuH8qxpmWHMZq9yNZnRVB8meP
        3iywF3TKvHbh/Z6D5FYFMkNJa930aKEWfO7dt5Q6q1ZiTNZpOqg7GQeRNfUcJbzPMDblHBQn47yI0
        VQOiLX0A==;
Received: from [10.20.10.231] (port=20840 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <ig@drbeat.li>)
        id 1fcSbh-009mq0-HT; Mon, 09 Jul 2018 11:37:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Jul 2018 11:37:21 +0200
From:   ig@drbeat.li
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 4/6] sequencer.c: avoid empty statements at top level
In-Reply-To: <AED9D71037D249F8A56FDF0B1AA48603@PhilipOakley>
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180708144342.11922-5-dev+git@drbeat.li>
 <CAPig+cSGj6Pt4OmRAQauZCiVG3PnjWeXm20RtYGbsjdZ5Tk4gg@mail.gmail.com>
 <AED9D71037D249F8A56FDF0B1AA48603@PhilipOakley>
X-Priority: 4 (Low)
Message-ID: <b1427480e2b70c2ad1ab5873409e5fdc@drbeat.li>
X-Sender: ig@drbeat.li
User-Agent: cyon Webmail/1.2.9
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.2018 23:17, schrieb Philip Oakley:
> From: "Eric Sunshine" <sunshine@sunshineco.com>
> To: "Beat Bolli" <dev+git@drbeat.li>
>> On Sun, Jul 8, 2018 at 10:44 AM Beat Bolli <dev+git@drbeat.li> wrote:
>>> The marco GIT_PATH_FUNC expands to a complete statement including the
> 
> s/marco/macro/

ACK. In addition, the whole sentence is wrong: GIT_PATH_FUNC defines a
function, not a statement. Will be fixes in a reroll.

>>> semicolon. Remove two extra trailing semicolons.
>>> 
>>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>>> ---
>>>  sequencer.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> While you're at it, perhaps it would be a good idea to fix the example
>> in path.h which teaches the "wrong" way:
>> 
>> /*
>> * You can define a static memoized git path like:
>> *
>> *    static GIT_PATH_FUNC(git_path_foo, "FOO");
>> *
>> * or use one of the global ones below.
>> */

Thanks,
Beat
