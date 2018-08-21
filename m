Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B19D1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 09:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeHUNE7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 09:04:59 -0400
Received: from forward106j.mail.yandex.net ([5.45.198.249]:46483 "EHLO
        forward106j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbeHUNE7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Aug 2018 09:04:59 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2018 09:04:58 EDT
Received: from mxback2j.mail.yandex.net (mxback2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10b])
        by forward106j.mail.yandex.net (Yandex) with ESMTP id EABFC180565B;
        Tue, 21 Aug 2018 12:37:55 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9w9IswbDR3-btL8f26b;
        Tue, 21 Aug 2018 12:37:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1534844275;
        bh=7MPkpachCKWFo1rYD6yL2j1OstMYRHMWRHiDhHGIfwM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=UHc/oDtS4mMemX2x+G01iBcYYdhxvanap8GFHAM0GQnpLMKRS0Q3FJ+kJx5RjBt8O
         if/7YNeYLaX4vNdvvcQPzv4zCHafyoSD4J+oFQy7G4o0M16BddMnQq0xA5bJsx2mrw
         y+8mG4Nh6o1GpyNMw+/P+nkZqMuplHJpOa21dCuw=
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id YdUIZVbEnZ-bsoushek;
        Tue, 21 Aug 2018 12:37:54 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1534844274;
        bh=7MPkpachCKWFo1rYD6yL2j1OstMYRHMWRHiDhHGIfwM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=j9tsdvXyUAEKbMk9KixT567q6aZ2WJeEqyKb/hw3F8+V9XsTv9RP37snzOVL0f26c
         ptkeoWU+ZrFdr4PpJB7CKdIQ1RD3LG5Z/uN3lNwVNmCO6eNqibiUVw5O0IKkaT0ZwG
         w03XLNjh/3zhQCPrHdYOqrMOssAXj1xESuTRPgYk=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Subject: Re: Do not raise conflict when a code in a patch was already added
To:     Johannes Sixt <j6t@kdbg.org>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <fae8346d-398f-e984-5aa5-e3dc3ee71d70@yandex.ru>
 <ab5021a9-6980-b96c-9d51-cc301844f2af@talktalk.net>
 <0d36d185-23d5-a656-67dd-5df86abed3e9@kdbg.org>
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Message-ID: <e5f65c19-0f49-d48e-c600-7dfcd95f3218@yandex.ru>
Date:   Tue, 21 Aug 2018 12:37:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0d36d185-23d5-a656-67dd-5df86abed3e9@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20.08.2018 22:22, Johannes Sixt wrote:
> Am 20.08.2018 um 19:40 schrieb Phillip Wood:
>> On 20/08/2018 11:22, Konstantin Kharlamov wrote:
>>> It's spectacular, that content of one of inserted conflict markers is
>>> empty, so all you have to do is to remove the markers, and use `git add`
>>> on the file, and then `git rebase --continue`
>>>
>>> Its a lot of unncessary actions, git could just figure that the code it
>>> sees in the patch is already there, being a part of another commit.
>>
>> If there are conflict markers where one side is empty it means that some
>> lines from the merge base (which for a rebase is the parent of the
>> commit being picked) have been deleted on one side and modified on the
>> other. Git cannot know if you want to use the deleted version or the
>> modified version.
> 
> There's another possibility (and I think it is what happens actually in 
> Konstantin's case): When one side added lines 1 2 and the other side 
> added 1 2 3, then the actual conflict is << 1 2 == 1 2 3 >>, but our 
> merge code is able to move the identical part out of the conflicted 
> section: 1 2 << == 3 >>. But this is just a courtesy for the user; the 
> real conflict is the original one. Without this optimization, the work 
> to resolve the conflict would be slightly more arduous.

Yeah, thanks, that's what happens. And I'm wondering, is it really 
needed to raise a conflict there? Would it be worth to just apply the 
line "3", possibly with a warning or an interactive question to user 
(apply/raise) that identical parts were ignored?
