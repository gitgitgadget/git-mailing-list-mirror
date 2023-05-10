Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0446C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 07:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbjEJHIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjEJHIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 03:08:44 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D8F3C02
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:08:40 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51f10bda596so3307799a12.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683702520; x=1686294520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0ZrDLvCTSXHovp32MrQJnrXfcinTS4/ywbRgLqaTlY=;
        b=3LH6ddv6J0MltO5yv9jnbSYuEwi61y/8qCI0YljVRbFS+DOuD3w2JvKrLJaKDPXWG8
         PhfhYZ8JIluU5FJa/XQ4uoPavWvkLvllHo7xGRQHis6cbMfP9+4/ohXQlMWDqxNZfdcz
         QtGbMCVHpnFHY31yN4YKpyi5QwV0ax6a0pMUuTCw6b6Rv37goeL2pqeGOiacb72LcHOi
         79KKDyqz2ov8sRPvOZy0f1FK/HrvApS2uQ14HJOo8Omms2WiNHWDaR6Hw+ltYa9RTNmt
         GIkxyeHM/APqMAPfCXPzDtAGDCRZdBLO0EB/BIfClIl3G7OxUH/cB7YxCZQocrBNL6dO
         R2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702520; x=1686294520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0ZrDLvCTSXHovp32MrQJnrXfcinTS4/ywbRgLqaTlY=;
        b=jciUrPFKlephZTWZOpFTzMS9AMjZR88fvTJQ+2M5TbJYgQMs63eVCSgQms9dCiRmhk
         KenFDM6WA0faEVfWsi9X4v4X4APVxQDslZMunUslGaICihzSPRhr7P7VNIsuCCp4SpsB
         F6L3syWP1lAZhEf2kmSr2JE18FQAwVvkOM3c1f3pAqJFLuNUseK89Z8bFD3O0gUvpIox
         J1wA+VLqD5jFLkulXn+skJYzCA9qEzvw6KPeGIytoBlcadfyZ7ijzUnmCweaRdEJexkk
         VaMRudjlzbyAfmO+PR9pOSLhMGqy3cbdQ+irhUMLyDK8nAKyGlXsMuystLORJlLaD7eU
         KxhQ==
X-Gm-Message-State: AC+VfDxF2akyUlLxVR/1U+zKJgZg7eD/2ByM8eVLPeRnOYwPw2fhbIWW
        4GGlDZzfAVjAg/2e6PDtdUklq6wEklI=
X-Google-Smtp-Source: ACHHUZ7ccQX7pI7PjlVwDrZgh9+TbwzS/8X10DeAXdlK9C3JUVX3t2xAR4UaRvgh0iFfu0Qmw6Ym42TCoQk=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:2b04:0:b0:521:62ef:9b38 with SMTP id
 r4-20020a632b04000000b0052162ef9b38mr4734008pgr.3.1683702519967; Wed, 10 May
 2023 00:08:39 -0700 (PDT)
Date:   Wed, 10 May 2023 00:08:38 -0700
In-Reply-To: <xmqqwn1imwqk.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
 <5980432179352054955e602cf97b57e97694a28c.1683566870.git.gitgitgadget@gmail.com>
 <xmqqwn1imwqk.fsf@gitster.g>
Message-ID: <owlyh6skmznt.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 08/11] doc: trailer.<token>.command: refer to existing example
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> From: Linus Arver <linusa@google.com>

>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>   Documentation/git-interpret-trailers.txt | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)

> This patch has more annoying "just rewrapping the text in a strange
> way without changing anything"

Noted. I will remove the whitespace churn in v2.

> than the real change which is to
> enclose <value> inside the angle brackets (which is good) and adding
> a new sentence.

I should probably move the angle bracket changes into 07.

> We are discouraging the use of .command and recommending folks to
> use .cmd instead, by the way.

I was motivated to add the reference to the example because I could not
understand what

     Instead the first occurrence of substring $ARG is replaced by the
     value that would be passed as argument.

meant in the existing language. In hindsight maybe it's not worth adding
the reference, because of the deprecation.

> At some point we may drop the
> example, and adding a reference to the example would mean somebody
> needs to remember removing this when it happens.

Wouldn't we also delete the entire `trailer.<token>.command::` section
(and therefore the reference to the example) also at the same time?

>> diff --git a/Documentation/git-interpret-trailers.txt  
>> b/Documentation/git-interpret-trailers.txt
>> index ac448fd732e..5ca758e363f 100644
>> --- a/Documentation/git-interpret-trailers.txt
>> +++ b/Documentation/git-interpret-trailers.txt
>> @@ -234,10 +234,11 @@ trailer.<token>.ifmissing::
>>   	that option for trailers with the specified <token>.

>>   trailer.<token>.command::
>> -	This option behaves in the same way as 'trailer.<token>.cmd', except
>> -	that it doesn't pass anything as argument to the specified command.
>> -	Instead the first occurrence of substring $ARG is replaced by the
>> -	value that would be passed as argument.
>> +	This option behaves in the
>> +	same way as 'trailer.<token>.cmd', except that it doesn't pass  
>> anything as
>> +	argument to the specified command. Instead the first occurrence of  
>> substring
>> +	$ARG is replaced by the <value> from the trailer. See the
>> +	'trailer.see.command' trailer example in the "EXAMPLES" section below.
>>   +
>>   The 'trailer.<token>.command' option has been deprecated in favor of
>>   'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
