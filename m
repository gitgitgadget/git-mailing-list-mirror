Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F752C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 06:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjEJGwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjEJGw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 02:52:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B82718
        for <git@vger.kernel.org>; Tue,  9 May 2023 23:52:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5212ed3b16eso3674211a12.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 23:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683701548; x=1686293548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zag30k63fge5lUC3dXpFlOKywJjbwiSs5ssJDZATQI=;
        b=Uk3xh95tof+w3yV0OCyiFUQblGsQQ7+daef8+KeUekWxW718PkWeh2lkuykV3bHmIR
         CVo4B+2DM6+KUaG3EVlknGEDcRaDsYNLKeMvi7IBSho9ISV1dhW6K3XsgRQKM89RCeCD
         HJm7bP7arDXik+Yi+UC7X3ayC3ie8w5/iT0MOfvZFOXEF46nBWt1jGX5JNmtCoWpQ85u
         hceF4rvoSMEiy++cqRce+qWYQmaLMRLZ0lJMIEltKvxYrdbSJ8B04XA1yNNxWwwiP6Nz
         82COCkbdut5QS279Xzt4rL+2iik7WcngsWTCcw3jpXQz8Mi50j6DsogqOiaSFREfwS77
         8SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683701548; x=1686293548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zag30k63fge5lUC3dXpFlOKywJjbwiSs5ssJDZATQI=;
        b=JqtCH643SH+TZM5vDK0GyT059JfNIxSUXZFoE//ZSHv1isSp32zJNHwiO24hQGIuiZ
         rp4JPB8CyhmBJ1dSgYYcBrFD6LYHGn3M7h/7ll/CP4QuAi9e8Plvgb2RXsDoY3pMjPNx
         2HYRq2eFecSVKPU9N72miOj4RfhPGMaFjrxlEO8GX8yb4vhElWOABBmgK+kMNm9aN3D0
         s6aL+ACqwHPeRIX9dIclq0jW0fDOEcIn72x6bnnsZTSqU1tOqAdZy774kxJlwgaHmN2i
         REThk2xIQCYT9JE4Y40RkneU0MxCrGxeo7jai7ZldE5wNQ9ri5ZEiRmeGjHbdTbBGhCV
         CqVA==
X-Gm-Message-State: AC+VfDy8NXpsjXXJq/C+BJa7tiskjYE6KYpIDPhYlu0wmlS/UhMsVzNb
        6Mp93OnetJoYf87N2bFoucL6gq/Hp5c=
X-Google-Smtp-Source: ACHHUZ5XFBn5+y7GTTyKsRIEMNMwlPPS5TcqOfK+TpuV1mb84iZyDNxmz+rwpFbHOYZEL8xaX/o1QMmEuTU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:2b85:0:b0:507:8088:9e0d with SMTP id
 r127-20020a632b85000000b0050780889e0dmr4630196pgr.7.1683701548115; Tue, 09
 May 2023 23:52:28 -0700 (PDT)
Date:   Tue, 09 May 2023 23:52:26 -0700
In-Reply-To: <xmqq1qjqobl9.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
 <8e36d1bd1f0c8ca6b1210a537f4bb8403fab7c47.1683566870.git.gitgitgadget@gmail.com>
 <xmqq1qjqobl9.fsf@gitster.g>
Message-ID: <owlyjzxgn0et.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 06/11] doc: trailer: trailer.<token>.cmd: add missing verb phrase
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

>> The phrase "is specified" is implied. Make it explicit.

> Makes sense.  Calling it "implied" is generous ;-)

Haha yes, I suppose so. I wrote "implied" because supplying the
(missing) phrase "is specified" was the only way I could make sense of
the existing wording.

> Isn't the
> original just outright ungrammatical?

Indeed.

Should I combine 01+06 together?



>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>   Documentation/git-interpret-trailers.txt | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)

>> diff --git a/Documentation/git-interpret-trailers.txt  
>> b/Documentation/git-interpret-trailers.txt
>> index e80a9cd161b..c4675d9d3bb 100644
>> --- a/Documentation/git-interpret-trailers.txt
>> +++ b/Documentation/git-interpret-trailers.txt
>> @@ -248,10 +248,10 @@ for the same <token>, 'trailer.<token>.cmd' is  
>> used and
>>   'trailer.<token>.command' is ignored.

>>   trailer.<token>.cmd::
>> -	This option can be used to specify a shell command that will be called:
>> -	once to automatically add a trailer with the specified <token>, and  
>> then
>> -	each time a '--trailer <token>=<value>' argument to modify the <value>  
>> of
>> -	the trailer that this option would produce.
>> +	This option can be used to specify a shell command that will be called  
>> once
>> +	to automatically add a trailer with the specified <token>, and then  
>> called
>> +	each time a '--trailer <token>=<value>' argument is specified to  
>> modify the
>> +	<value> of the trailer that this option would produce.
>>   +
>>   When the specified command is first called to add a trailer
>>   with the specified <token>, the behavior is as if a special
