Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17DF71F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbeDWTus (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:50:48 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:51557 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932292AbeDWTur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:50:47 -0400
Received: from [192.168.2.240] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id AhU3fvAAoLjjAAhU4fZ5Pu; Mon, 23 Apr 2018 20:50:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524513045;
        bh=g7tONGnXkuJliW/OHAXMtqlJ0AtGJ263432IE3cBhhc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZRX9Oj/GcLGLzj1iK/9EwuwyFGTsvvdYcdxi8FSO7IgXtQPmuac1ejDtCcttl2zCQ
         QHlqOVee0KB6TzZ5fC2TF2zr+zysa3STSxNKLs10uK65EPizRKi7IqwPLkZxdWo6gf
         0TBSB8sI7BCi++ar9Ar0geeag30/SMuDrULw8ZBc=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=nN7BH9HXAAAA:8 a=YIwomQ02dqkuXrBahrcA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combinationof"
 in commit messages
To:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524296064.git.johannes.schindelin@gmx.de>
 <CAGZ79kbK7j0njrZ8-d_Da6+XyH_RVRhBu=hcpzr7EFsOCSFJVQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <12fa9a1f-9dc2-9108-132f-48b75ae5a8d3@talktalk.net>
Date:   Mon, 23 Apr 2018 20:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbK7j0njrZ8-d_Da6+XyH_RVRhBu=hcpzr7EFsOCSFJVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP0ARfaywYZ7L94XAGMu6O42rRv3uIFV00v1K0kI1Uw3RJIXoA8jM5E9xARdSqL9oXDUldwEI/7HW7O/foRRS1zY3syaJfnaCRsbHYFsH5ZWtLALtObn
 ijCgqdX2VaBf11kp82YnQBd44iDR8Y1vt6rTRxaOy2vYMjQ19lfZmfHRndkSeIbDGwCcAp/uMSjGFVWsKCfA264H9RM2Dxz452xnd19cxF7Z1L+mWT3Lt7bZ
 ga64AFD0IbAjG5P+JuGuAcvk2THYgDFoKV0a2Ct/wm8MUHLqmxuhgneePIWU0JD0XKHjkcyFooYGA1bB+U1k7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/18 19:11, Stefan Beller wrote:
> 
> On Sat, Apr 21, 2018 at 12:34 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Eric Sunshine pointed out that I had such a commit message in
>> https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
>> and I went on a hunt to figure out how the heck this happened.
>>
>> Turns out that if there is a fixup/squash chain where the *last* command
>> fails with merge conflicts, and we either --skip ahead or resolve the
>> conflict to a clean tree and then --continue, our code does not do a
>> final cleanup.
>>
>> Contrary to my initial gut feeling, this bug was not introduced by my
>> rewrite in C of the core parts of rebase -i, but it looks to me as if
>> that bug was with us for a very long time (at least the --skip part).
>>
>> The developer (read: user of rebase -i) in me says that we would want to
>> fast-track this, but the author of rebase -i in me says that we should
>> be cautious and cook this in `next` for a while.
> 
> I looked through the patches again and think this series is good to go.

I've just realized I commented on an outdated version as the new version 
was posted there rather than as a reply to v1. I've just looked through 
it and I'm not sure it addresses the unnecessary editing of the commit 
message of the previous commit if a single squash command is skipped as 
outlined in 
https://public-inbox.org/git/b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net/

Best Wishes

Phillip

> Thanks,
> Stefan
> 
