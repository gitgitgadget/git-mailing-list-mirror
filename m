Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA87C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjCXOnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjCXOnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:43:08 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA80811654
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:43:05 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id ED4F6242E9
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:42:49 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pficz-Nd4-00
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:42:49 +0100
Date:   Fri, 24 Mar 2023 15:42:49 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] rebase: preserve interactive todo file on checkout
 failure
Message-ID: <ZB226RPsBRghnruI@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
 <47558c14-ba2c-18ec-0532-b21fdfd223f8@dunelm.org.uk>
 <ZBzU5lzZBtI8/Q7+@ugly>
 <55ee99fc-69e6-7635-10fb-56de9d3b17b6@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <55ee99fc-69e6-7635-10fb-56de9d3b17b6@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 02:15:47PM +0000, Phillip Wood wrote:
>On 23/03/2023 22:38, Oswald Buddenhagen wrote:
>> so you basically want to convert the magic `onto` into an explicit 
>> todo command? i'm not sure what the advantage would be, and i 
>> certainly can think of disadvantages re. usability and backwards 
>> compat.
>
>If the initial checkout of "onto" fails I want the rebase to stop so the 
>user can try and fix the problem (usually remove an untracked file) and 
>then run "git rebase --continue" to continue the rebase including the 
>initial checkout. Adding a "reset" command to the beginning of the todo 
>list when the initial checkout fails is one way of achieving that.
>
i suppose, but patch 8/8 does pretty much the same, only with fewer side 
effects.

>>> How does this patch ensure the checkout happens when the user 
>>> continues the rebase?
>>>
>> the idea was never that the user --continue's. we're talking about a 
>> fatal error,
>
>If it is a fatal error what is stopping the user from running "rebase 
>--continue" and wreaking havoc? [...]
>
>It would be much more user friendly to simply allow them to fix the 
>problem with the checkout and run "git rebase --continue"
>
i'll reorder the patch to the end of the series, as after the currently 
last patch we'll be in a much better position to deal with the fallout 
in a sane way.

thanks!
