Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C0A203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbdGXVvX (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:51:23 -0400
Received: from mail.mathema.de ([195.110.18.10]:49064 "EHLO mail.mathema.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdGXVvV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:51:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.mathema.de (Postfix) with ESMTP id 36FBC1DA26FC;
        Mon, 24 Jul 2017 23:51:19 +0200 (CEST)
Received: from mail.mathema.de ([127.0.0.1])
        by localhost (mail.mathema.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tO9D7aVYkE4u; Mon, 24 Jul 2017 23:51:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.mathema.de (Postfix) with ESMTP id 7A54A1DA26B7;
        Mon, 24 Jul 2017 23:51:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.mathema.de
Received: from mail.mathema.de ([127.0.0.1])
        by localhost (mail.mathema.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ltfWerAf3qaV; Mon, 24 Jul 2017 23:51:18 +0200 (CEST)
Received: from [192.168.178.20] (ppp-82-135-68-5.dynamic.mnet-online.de [82.135.68.5])
        by mail.mathema.de (Postfix) with ESMTPSA id 2F0A31DA22FF;
        Mon, 24 Jul 2017 23:51:18 +0200 (CEST)
Subject: Re: Bug^Feature? fetch protects only current working tree branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Heiduk <andreas.heiduk@mathema.de>,
        Git Mailing List <git@vger.kernel.org>
References: <cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathema.de>
 <xmqqo9saer9f.fsf@gitster.mtv.corp.google.com>
From:   Andreas Heiduk <andreas.heiduk@mathema.de>
Message-ID: <3989d621-e0fd-5075-b42a-abe4fff7ff97@mathema.de>
Date:   Mon, 24 Jul 2017 23:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9saer9f.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.07.2017 um 00:13 schrieb Junio C Hamano:
> Andreas Heiduk <andreas.heiduk@mathema.de> writes:
> 
>> A `git fetch . origin/master:master` protects the currently checked out 
>> branch (HEAD) unless the `-u/--update-head-ok` is supplied. This avoids a
>> mismatch between the index and HEAD. BUT branches which are HEADs in other
>> working trees do not get that care - their state is silently screwed up.
>>
>> Is this intended behaviour or and just an oversight while implementing
>> `git worktree`?
> 
> The latter.  

Ok, so I can adjust some of my helper scripts to catch and forbid this case.

> [...]"git worktree" is an interesting feature and has
> potential to become useful in wider variety of workflows than it
> currently is, but end users should consider it still experimental as
> it still is with many such small rough edges like this one.
> 
> Patches to help improving the feature is of course very welcome.

Since the core of the check is in C, I'll pass on this one. I could
supply a patch adding this to the "BUGS" section of git-worktree(1)
though :-)


