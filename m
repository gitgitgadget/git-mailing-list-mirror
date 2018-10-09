Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006D31F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJIR3e (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 13:29:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53476 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIR3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 13:29:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id y11-v6so1250528wma.3
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DtGK2Gg14gB3e/R8SM64vC/j6BmOdtdiKmI7BAEAcQY=;
        b=Qu+l3ICCrJuhBg6evCI4yVNWbvPUZVl0V5BNx/9XYRk/KW/1jh5eq1ais5AwwfM9/q
         hThbE5kj1dIlZouSuteIOpIJhOP63d9N/OHztXu6YXzQm+8SKp3NNVmwLj8SANY61X8b
         zqK27mBOvbpeS1pe/7iGOMStYuVtgWizRFj4856ehkbKyuGVMCCBtu29iy0M3S8IRllZ
         +t5JPiz56YO3zEBpTdBX/c1IV9EcR8XRCofRMjBpXR0tdzIMifVoL1EKn/tr2caX4Y8G
         Q5xNR666XjbneqIzh3dBfRM1nSZjwjdcbK++5NMqQbgBZgzPROAMxRqQmrVcpknFpL0P
         HVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DtGK2Gg14gB3e/R8SM64vC/j6BmOdtdiKmI7BAEAcQY=;
        b=b4/VlDfToa9SL4C9H0jgdCmbVMfNck5GZ0yerDOMEl0PTKE9VO7jDGMq6xGf926Jk8
         6Whibr8yuefVIf8NxeEvh8U4h4iHyV2Dh7JYyYUmoZIPN9aEasNroGCoLMoh1fmtae4j
         2Hg0MQTK0FhvL/juoV990CKkmScLe5i9S5B6TU8tg4lXdqGdVk3UIm7TSAqbUbkpThGz
         ExWLhOxPwUfVtwtabe9YQ++/o3i4KytfO4eOAYP/4oujEoMhP517G6LTQMVG6dmCiCmU
         2u+7V5zHiH9tbPW6sw98lreSzOf1DAkjMPwoIdMSXxLXFpUcHPd3XFz+M/ULe5br7PY9
         XoWA==
X-Gm-Message-State: ABuFfogKHM+BKcq19DyuyoyVRWlfCCPRH3fPRNA+z7zXyfqOp5muU2qi
        CqeAfdhqxNYnUhbLTYf2aLQ=
X-Google-Smtp-Source: ACcGV60k1LcqrWCiDFzWudA3OwrDhSuIRLlReEJC36irEBiNP/BbtOE9uxoBHQrNzqUbMcNC8k7IkQ==
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr1372890wmd.128.1539080000702;
        Tue, 09 Oct 2018 03:13:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t66-v6sm8762319wmt.5.2018.10.09.03.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:13:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ananya Krishna Maram <ananyakittu1997@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH][Outreachy] remove all the inclusions of git-compat-util.h in header files
References: <20181008170505.GA13134@manohar-ssh>
        <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com>
Date:   Tue, 09 Oct 2018 19:13:18 +0900
In-Reply-To: <b1824db3-1c0d-6851-2f5a-800cc88ee50f@gmail.com> (Derrick
        Stolee's message of "Mon, 8 Oct 2018 13:13:26 -0400")
Message-ID: <xmqqd0sjpgw1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/8/2018 1:05 PM, Ananya Krishna Maram wrote:
>> Hi All,
> Hello, Ananya! Welcome.
>
>> I was searching through #leftovers and found this.
>> https://public-inbox.org/git/CABPp-BGVVXcbZX44er6TO-PUsfEN_6GNYJ1U5cuoN9deaA48OQ@mail.gmail.com/
>>
>> This patch address the task discussed in the above link.
> The discussion above seems to not be intended for your commit message,
> but it does show up when I run `git am` and provide your email as
> input. The typical way to avoid this is to place all commentary below
> the "---" 
> that signifies the commit message is over.

>> From: Ananya Krishan Maram <ananyakittu1997@gmail.com>
>>
>> skip the #include of git-compat-util.h since all .c files include it.
>>
>> Signed-off-by: Ananya Krishna Maram <ananyakittu1997@gmail.com>
>> ---
>>   advice.h             | 1 -
>>   commit-graph.h       | 1 -
>>   hash.h               | 1 -
>>   pkt-line.h           | 1 -
>>   t/helper/test-tool.h | 1 -
>>   5 files changed, 5 deletions(-)
>>
>> diff --git a/advice.h b/advice.h
>> index ab24df0fd..09148baa6 100644
>> --- a/advice.h
>> +++ b/advice.h
>> @@ -1,7 +1,6 @@
>>   #ifndef ADVICE_H
>>   #define ADVICE_H
>>   -#include "git-compat-util.h"
>>     extern int advice_push_update_rejected;
>>   extern int advice_push_non_ff_current;

The way I read the original discussion is "C source that includes
compat-util.h shouldn't if it already includes cache.h"; advice.h is
not C and does not (should not) include cache.h.

The "left over bits" should not be blindly trusted, and besides,
Elijah punted to examine and think about each case and left it to
others, so whoever is picking it up should do the thinking, not a
blind conversion.  I am not getting a feeling that this patch was
done with careful thinking after checking only this one.

