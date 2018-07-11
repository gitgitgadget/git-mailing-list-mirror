Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6D51F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbeGKPpJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:45:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52099 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389141AbeGKPpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:45:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so2874480wmc.1
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m+YX4iIBuKrCDHabqvOjVC4Eq/4lcNkSo/olkldINko=;
        b=szne+CNyayd+gOeDcpG+i2RoaUge9w6lljHvGoEn2+9XzL9NxP5WAzskvm4eKtKHbz
         BV5IOpm+BVPoo4ZHNTKS1ars7FPmU1btaBAmRU7jbUEpzjY6lBmdILFVeDSmMjvM/vPK
         PucS+Bhgr+0oPTSDPPtCxEKzHyQngXOJfxSucRa7n91IyFE+f0KojQQNQl5A5aTcE67o
         /nLU+0op6GZq237dAhhRVbwmU9Y/5ETpgUb2ZIpiEt7rJf1I7reHOed40T05DaItQYQt
         vTDNcmQmfu9uJ3ontu8lTmGkge37BM7SRhuXcvPR8+7HiY2ZDR4rCBHFfYwGmPUYlJKc
         pgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m+YX4iIBuKrCDHabqvOjVC4Eq/4lcNkSo/olkldINko=;
        b=nebpxr7HOb7WsO4KPZAo1uQOjxn15pzqkZg6Xk3N9LKFnMnlofR+26VqyybM/cdeD8
         xYW6epzs94JLGItDrGy4u/b8mLtHSyAwh65Iu1q7gSGFJb2dWPoa5TfqFfrozL2SKfCu
         T2OgNtd8GAnUkxvIu5lLDL0ciUvQzXzoGoq7PQQRmkUZXVwTqmdRK0TCLfd6nkn5Mb9e
         c0XJg7X0Uumfizd64EKd+F/JTNr93vrabAmdbrX9dhNc/G0V5LccSim2tbOHO0b5QMIE
         eyo9aWA2H5ee+hK+QhG3pquycPvfQAekJvKauZNeR9ygbT8PnmnygtHMc7KrDo7zr6pR
         M0GQ==
X-Gm-Message-State: APt69E1R62H4QgrBJZ7KwlzpaOq2SUwD+NWbBjzH6xKTmyVnspya92Fz
        usSRls7ToIDk1q2uS6D0aII=
X-Google-Smtp-Source: AAOMgpd8wQz5JldVtPAv8ZT6rUEie0VePbDANOyRIwHwV+XWeH1+MkM5CeMFZ/+bxf/akAC7xX0a0w==
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr16838690wmb.118.1531323613586;
        Wed, 11 Jul 2018 08:40:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 31-v6sm14902094wra.26.2018.07.11.08.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:40:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] Add merge recursive testcases with undetected conflicts
References: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com>
        <20180709202229.10222-1-newren@gmail.com>
        <CABPp-BGH+6XkJwqhUOydT0CQBRTr=Hf79SU5PGZ2NrvV5uNjCw@mail.gmail.com>
Date:   Wed, 11 Jul 2018 08:40:12 -0700
In-Reply-To: <CABPp-BGH+6XkJwqhUOydT0CQBRTr=Hf79SU5PGZ2NrvV5uNjCw@mail.gmail.com>
        (Elijah Newren's message of "Tue, 10 Jul 2018 21:02:32 -0700")
Message-ID: <xmqqmuux4w83.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jul 9, 2018 at 1:22 PM, Elijah Newren <newren@gmail.com> wrote:
>> On Mon, Jul 9, 2018 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>>> When a merge succeeds, we expect the resulting contents to depend only
>>>> upon the trees and blobs of the branches involved and of their merge
>>>> base(s).  Unfortunately, there are currently about half a dozen cases
>>>> where the contents of a "successful" merge depend on the relative
>>>> commit timestamps of the merge bases.  Document these with testcases.
>>>>
>>>> (This series came out of looking at modifying how file collision
>>>> conflict types are handled, as discussed at [1].  I discovered these
>>>> issues while working on that topic.)
>>>
>>> I have a topic branch for this series but not merged to 'pu' as
>>> test-lint gives these:
>>>
> ...
>>
>> ... here's a fixup to the topic; as you pointed out, the exact contents
>> of the script being written were actually irrelevant; it was just an
>> input to a merge.
>>
>> -- 8< --
>> Subject: [PATCH] fixup! t6036: add a failed conflict detection case: regular
>>  files, different modes
>>
>
> Does a 'fixup!' commit require a Signed-off-by?  Just realized that
> this one didn't have it, though I don't know if it's necessary.  If it
> is:
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Thanks.  I queued it separately before running out of time Monday,
but will actually squash it in to the main patch.

