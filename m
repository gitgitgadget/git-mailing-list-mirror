Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86825C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 10:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHKKd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjHKKdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 06:33:25 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67887C5
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 03:33:24 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E683324054;
        Fri, 11 Aug 2023 06:33:22 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qUPSM-TTh-00; Fri, 11 Aug 2023 12:33:22 +0200
Date:   Fri, 11 Aug 2023 12:33:22 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
Message-ID: <ZNYOco835hbiDZAC@ugly>
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
 <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
 <xmqqv8dqd2bh.fsf@gitster.g>
 <ZNO7IVphPf8KOC3Q@ugly>
 <xmqqbkfgm2di.fsf@gitster.g>
 <ZNTTTAtNE2/DY9vT@ugly>
 <xmqqleeihok5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqleeihok5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 09:03:54AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> On Wed, Aug 09, 2023 at 12:39:37PM -0700, Junio C Hamano wrote:
>>>Thanks.  Then this patch is still a strict "Meh" to me.
>>>
>> i can't really think of a reason why you reject such a no-brainer
>> other than that you consider it churn. in that case i need to tell you
>> that you have unreasonable standards, which actively contribute to the
>> code remaining a mess.
>
>An ad-hominem remark is a signal that it is good time to disengage.
>
i'm pointing out what i consider a systematic mistake. there is no way 
of doing that in a way that isn't somewhat personal.

the thing is that after _such_ an experience, no sane person would ever 
invest into something that falls under pure code maintenance in this 
project again. is that really what you want?

>There are certain style differences that may be acceptable if it
>were written from the get-go,
>
it's not just a style difference. it clarifies the code semantically, 
and potentially shrinks the executable a bit.

>but it is not worth the patch churn to switch once it is in the tree.
>
what is the problem _exactly_?

the time it takes to discuss such patches? the solution would be not 
bike-shedding them to death.

process overhead in applying them? then it's time to amend the process 
and/or tooling to accomodate trivial changes better.

minimizing history size and preserving git blame? then rethink your 
priorities. i'm rather OCD about this myself and would usually reject 
random style cleanups, but the actual experience is that a few "noise" 
commits don't really get into the way of doing archeology - searching in 
variations of `git log -p` and using "blame parent revision" in 
interactive tools are usually required anyway. saving a few seconds in 
this process really isn't worth keeping the current code messier than 
necessary.

anything else?

regards

