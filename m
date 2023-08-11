Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4EBC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 12:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjHKMt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 08:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKMtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 08:49:25 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8192696
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 05:49:24 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 22EC52425B;
        Fri, 11 Aug 2023 08:49:23 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qURZy-Wq6-00; Fri, 11 Aug 2023 14:49:22 +0200
Date:   Fri, 11 Aug 2023 14:49:22 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Linus Arver <linusa@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
Message-ID: <ZNYuUh27ByphTH04@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <owly5y5mh81i.fsf@fine.c.googlers.com>
 <owly8raih8ho.fsf@fine.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 02:50:59PM -0700, Linus Arver wrote:
>Nit: the "doc: revert: add discussion" subject line should probably be more
>like "revert doc: suggest adding the 'why' behind reverts".
>
this is counter to the prevalent "big endian" prefix style, and is in 
this case really easy to misread.
i also intentionally kept the subject generic, because the content 
covers two matters (the reasoning and the subjects, which is also the 
reason why this is a separate patch to start with).

>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> +DISCUSSION
>> +----------
>> +
>> +While git creates a basic commit message automatically, you really
>> +should not leave it at that. In particular, it is _strongly_
>> +recommended to explain why the original commit is being reverted.
>> +Repeatedly reverting reversions yields increasingly unwieldy
>> +commit subjects; latest when you arrive at 'Reapply "Reapply
>> +"<original subject>""' you should get creative.
>
>The word "latest" here sounds odd. Ditto for "get creative".
>
yeah, i suppose. i wasn't sure how formal i should make it - things 
aren't consistent to start with.

> How about the following rewording?
>
>    While git creates a basic commit message automatically, it is
>    _strongly_ recommended to explain why the original commit is being
>    reverted. In addition, repeatedly reverting the same commit will
>    result in increasingly unwieldy subject lines,

>for example 'Reapply "Reapply "<original subject>""'.
>
you turned it from a suggested threshold into an example. at this point 
it appears superfluous to me.

>Please consider rewording such
>    subject lines to reflect the reason why the original commit is being
>    reapplied again.
>
the reasoning most likely wouldn't fit into the subject.
also, the original request to explain the reasoning applies 
transitively, so i don't think it's really necessary to point it out 
explicitly.

On Thu, Aug 10, 2023 at 03:00:41PM -0700, Linus Arver wrote:
>Hmph, "repeatedly reverting the same commit" sounds wrong because
>strictly speaking there is only 1 "same commit" (the original commit).
>Perhaps
>
>    In addition, repeatedly reverting the same progression of reverts will
>
>or even
>
>    In addition, repeatedly reverting the same revert chain will
>
>is better here?
>
we used "recursive reverts" elsewhere. but i'm not sure whether that's 
sufficiently intuitive and formally correct.

anyway, what's wrong with my original proposal?

so in summary, how about:

     While git creates a basic commit message automatically, it is
     _strongly_ recommended to explain why the original commit is being
     reverted. In addition, repeatedly reverting reversions will
     result in increasingly unwieldy subject lines. Please consider 
     rewording these into something shorter and more unique.

regards
