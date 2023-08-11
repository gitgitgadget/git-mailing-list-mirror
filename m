Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A09C04E69
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 23:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjHKXD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 19:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbjHKXBq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 19:01:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6BD4207
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 16:00:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d664f9c5b92so1453261276.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691794854; x=1692399654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrwhH2GRcrZpx8xKC4nUr8hZuAjXBbg6opI+RgForsI=;
        b=qOkUGALt4wllXJQuoQFhwhDcIZgB/Pk+MPrq1gjRDXOh29Knh0vc0pLEQLAwiuObAq
         0lStIbehbzSGg+cDJBWYzQoClvDzM84KIppTv6/aQyFTDt8/fWPcF+Av9m/CnwiW3SoN
         E8cmoue9S9+3/peQ6xs/v8g/Oo05L7+Xg8QwOYVw8lZzkIzSIqkwshQvD9I7Z/29JGX5
         CRcOoV2gDnVrVKtu8cMEzwmifQmkR/8Rw2QniJzOPimnC3Ib92ev5HTC6SZbtpMTjP23
         yVOhNHpIcEcIr3UMfUv0gDHECGbJk+nxLjuP6w+lkaenB0Z0yH9pAmM4BZJVZCAr8XcG
         Cn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794854; x=1692399654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrwhH2GRcrZpx8xKC4nUr8hZuAjXBbg6opI+RgForsI=;
        b=WR9avighdqVFT1MWM/OoVOU5aD40mVCUQnx4iAhTBQCiaVWTal4R7AolLofGN/UtDQ
         bl7DQoPjsKJJH4g8JJWf3BLQpQ8GAqd+SEqlJKhOKC19xWYsx4PCi4rf7Z26MittSTAq
         voYnf0KiW80feF3E/jU1y/jFqxQSiPdmXOrHF62jSZuxA7qIlAUELN5ZG+XewnPuFCDM
         MS0vsdlqRjioKISOiUJS+wKWNc4QVYBCr2b1P74xpeV8MMqbCSHbDDzAR2JPvvsfdocl
         iFn45HXzvPaDf/dgVkJJyV7N1tRsCV20ReLqIlzbwBw2mnB2gH9VsNg3Z/RbZU0TfcLG
         VcvQ==
X-Gm-Message-State: AOJu0Yx9WSWCODJS7VOT+YcpnPdcaPJs3/HePMW0PBAtc4qQKrgQJDsU
        MmR3Vg4lXhth9Kykkmb4MMy4rsiQE4U=
X-Google-Smtp-Source: AGHT+IESU+6BKTXMhijnHpngpoeaxqsK3vAel9VI6MdwBGJOay2lO3r5XztplKHrwMCL9nbVPf6mJ7lRHSI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1584:b0:d10:5b67:843c with SMTP id
 k4-20020a056902158400b00d105b67843cmr59840ybu.4.1691794854487; Fri, 11 Aug
 2023 16:00:54 -0700 (PDT)
Date:   Fri, 11 Aug 2023 16:00:53 -0700
In-Reply-To: <ZNYuUh27ByphTH04@ugly>
Mime-Version: 1.0
References: <ZNYuUh27ByphTH04@ugly>
Message-ID: <owly350pfal6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
From:   Linus Arver <linusa@google.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Thu, Aug 10, 2023 at 02:50:59PM -0700, Linus Arver wrote:
>>Nit: the "doc: revert: add discussion" subject line should probably be more
>>like "revert doc: suggest adding the 'why' behind reverts".
>>
> this is counter to the prevalent "big endian" prefix style, and is in 
> this case really easy to misread.
> i also intentionally kept the subject generic, because the content 
> covers two matters (the reasoning and the subjects, which is also the 
> reason why this is a separate patch to start with).

I think the phrase "add discussion" in "doc: revert: add discussion"
doesn't add much value, because your patch's diff is very easy to read
(in that it adds a new DISCUSSION section). I just wanted to replace it
with something more useful that gives more information than just repeat
(somewhat redundantly) what is obvious by looking at the patch.

I also learned recently that there should just be one colon ":" in the
subject, which is why I suggested "revert doc" as the prefix instead of
"doc: revert: ...".

>>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>>> +DISCUSSION
>>> +----------
>>> +
>>> +While git creates a basic commit message automatically, you really
>>> +should not leave it at that. In particular, it is _strongly_
>>> +recommended to explain why the original commit is being reverted.
>>> +Repeatedly reverting reversions yields increasingly unwieldy
>>> +commit subjects; latest when you arrive at 'Reapply "Reapply
>>> +"<original subject>""' you should get creative.
>>
>>The word "latest" here sounds odd. Ditto for "get creative".
>>
> yeah, i suppose. i wasn't sure how formal i should make it - things 
> aren't consistent to start with.

For our discussion I will define "formal" style as the writing style
used in traditional reference texts, for example dictionaries and
encyclopedias.

For manpages, I think we should stick to formal style as much as
possible. The main concern I have is for readers of our manpages where
English may not be their first language. Although I understood what you
meant by the phrase "get creative", others may not understand so
readily. If there are places in our manpages where we do not use formal
style, I think we should fix them.

For other types of documentation like tutorials, I think the style
doesn't have to be as formal, (in fact it should be as informal as
possible) because a tutorial should be enjoyable to read from beginning
to end. This is unlike a manpage where most of the time the user reads
specific (sub)sections to get the exact, precise information they need
(just like looking up a word in a dictionary).

>> How about the following rewording?
>>
>>    While git creates a basic commit message automatically, it is
>>    _strongly_ recommended to explain why the original commit is being
>>    reverted. In addition, repeatedly reverting the same commit will
>>    result in increasingly unwieldy subject lines,
>
>>for example 'Reapply "Reapply "<original subject>""'.
>>
> you turned it from a suggested threshold into an example. at this point 
> it appears superfluous to me.
>
>>Please consider rewording such
>>    subject lines to reflect the reason why the original commit is being
>>    reapplied again.
>>
> the reasoning most likely wouldn't fit into the subject.

Hence the language "to _reflect_ the reason", because the "reason"
should belong in the commit message body text.

> also, the original request to explain the reasoning applies 
> transitively, so i don't think it's really necessary to point it out 
> explicitly.

It may be that a user will think only giving the revert reason in the
body text is enough, while leaving the subject line as is. I wanted to
break this line of thinking by providing additional instructions.

> On Thu, Aug 10, 2023 at 03:00:41PM -0700, Linus Arver wrote:
>>Hmph, "repeatedly reverting the same commit" sounds wrong because
>>strictly speaking there is only 1 "same commit" (the original commit).
>>Perhaps
>>
>>    In addition, repeatedly reverting the same progression of reverts will
>>
>>or even
>>
>>    In addition, repeatedly reverting the same revert chain will
>>
>>is better here?
>>
> we used "recursive reverts" elsewhere. but i'm not sure whether that's 
> sufficiently intuitive and formally correct.

Agreed. We might have to just define the correct phrasing ourselves in
"man gitglossary". Surprisingly I see that the term "revert" (which can
be both a verb _and_ a noun) is not defined there.

> [...]
>
> so in summary, how about:
>
>      While git creates a basic commit message automatically, it is
>      _strongly_ recommended to explain why the original commit is being
>      reverted. In addition, repeatedly reverting reversions will
>      result in increasingly unwieldy subject lines. Please consider 
>      rewording these into something shorter and more unique.

This is definitely better. But others in this thread have already
commented that my version looks good (after seeing your version also,
presumably).
