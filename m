Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DD620248
	for <e@80x24.org>; Wed, 17 Apr 2019 06:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfDQGOb (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 02:14:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38295 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDQGOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 02:14:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so30265938wro.5
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/oHQmaPT+2Egleu2X4g769+mpLExCn7+VUkpNr912ws=;
        b=J8rO/V0HUJdVwYkNt7xDRgfASTdosqun2ZG+VSJomGo5K94aalIXIGpJc2gAY9O/RS
         39kBTaFZNuWZeJKYByi3Y7NH/c/1JdtF81O7cy89PvCaEXuf9ZW7cQxlTZVFkpS8YqB4
         qp/t84lg2aEL1NT6ce3zFfC/J3oF7IcORVC/8xSRzPvB+aJxH2GA7a+JBqKNYt5Vyysl
         4O9uBTYnaeC0K/RIMuTNXDFIBFCg/CIBnWv9H2+mIgSRE4zsyc8LYom7dMxe9wP2XF0D
         Asm9OXxdRskS9TON+YyPksLhZM2/j0z/1WwSi2A8mb4LktvPkV2gCVQlRptv8SEKtk/S
         txgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/oHQmaPT+2Egleu2X4g769+mpLExCn7+VUkpNr912ws=;
        b=V7rRmNq/Lkcyo2SOLpB+O+ovGzUdacPUuwogy0H1pOp0dyTnOdaVKdRIS0r+4onPP3
         dJu4wWedf24xByIpdCxfnSWHHG+rODm4tOLdmrPkvUXVh5+6TysKYmzDHCMd7wIS5HCC
         dRhtB/jqap2f6oAotNBqztxROIMSpTaU4tq8EJFYKwPBB3ABaw+Ek2W1YVJwEYhuMn3C
         T2KvMQ+Z8/Aq5Zt42oUL3ValcFAzGwySp/T7hpu/HuoQdf47usJExazqKpwkY3O0MQ0Q
         mQ3uoXhWfPvQ4JweGoTRh2SlRWzXOooQPxJX/CDEHBQ+mD0PsYySKYR0HOEeHgRP3RCW
         dbIA==
X-Gm-Message-State: APjAAAVc65CIWXaAxnY8DpUxO9ivl25fsajbA4vY1Mc0raQWWorUHROY
        ldTU0TNkpQ5AqNdG6FdHiBjLJYbScbc=
X-Google-Smtp-Source: APXvYqx2z2rpBJNQ0519XA32hLUq+7MmVVyz0H2Xu4vmdG/cBN6gYOO0y+Wc9+pmSuIJBonedHT6Qg==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr53258525wrd.254.1555481669210;
        Tue, 16 Apr 2019 23:14:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b9sm2563313wmc.9.2019.04.16.23.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 23:14:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
        <20190417023706.GA86159@Taylors-MBP.hsd1.wa.comcast.net>
        <xmqq7ebtkx7p.fsf@gitster-ct.c.googlers.com>
        <20190417054250.GA98165@Taylors-MBP.hsd1.wa.comcast.net>
Date:   Wed, 17 Apr 2019 15:14:28 +0900
In-Reply-To: <20190417054250.GA98165@Taylors-MBP.hsd1.wa.comcast.net> (Taylor
        Blau's message of "Tue, 16 Apr 2019 22:42:50 -0700")
Message-ID: <xmqqwojtjgzf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> That's this one
>>
>>     Date: Tue, 9 Apr 2019 19:13:06 -0700 (1 week, 3 hours, 23 minutes ago)
>>     Subject: [PATCH v2 0/7] harden unexpected object types checks
>>
>> which I think is what has been queued and what is listed in the
>> message you are responding to.
>
> Ah, perhaps you could clarify some confusion I have about the "What's
> Cooking" emails (or at least point me somewhere I could un-confuse
> myself).
>
> This topic is in the "Cooking" section with a "-" (which I recall means
> that it's in 'pu'), but there is no "Will merge to ..." line below it
> from you.
>
> That makes sense to me, but I'm not sure whether or not that means it's
> queued. Do you say that a topic is queued once it's on your pu, or once
> you have written "Will merge to..."?
>
> Thanks in advance for your clarification.

Hmph, I guess I shouldn't use the verb "queue" if it implies a lot
more than there is to it.  I create a topic branch out of a patch
series on the list at some point in the iteration of a series and
merge it to 'pu'; I can say "I queued the topic to 'pu'" after doing
so.  The verb to me does not mean anything more than that.

The fact that a topic is queued on 'pu' does not mean much.  It can
be taken as a sign "Gitster thought that it may become 'next' worthy
material, either as-is or with further polishing and replacing."
Once a topic gets discussed on list and it seems apparent that there
is a concensus that supports it, I may mark the topic as "Will merge
to 'next'" in the What's cooking report, but I may not realize that
the list already reached such a concensus and may leave it unmarked
in the report.

So "this has been battle tested in such and such environment" and/or
"this round was reviwed by the thread here and they were supportive"
etc. is a very appreciated response to the "what's cooking" report
to help me merge the topic down to 'next'.

"I have sent a reroll at ..." I typically hear when I miss a
rerolled version and what is listed is still from an old iteration,
hence my "Eh, you are pointing at what I have queued" reaction.

Thanks.
