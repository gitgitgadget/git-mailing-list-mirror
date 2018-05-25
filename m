Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B52E1F42D
	for <e@80x24.org>; Fri, 25 May 2018 03:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754941AbeEYD2V (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 23:28:21 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35126 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754593AbeEYD2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 23:28:20 -0400
Received: by mail-wr0-f176.google.com with SMTP id i14-v6so6634982wre.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 20:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M2L1T9vRNnnL2xUuQoHEhKITQMggXL22+X8LudfSCCI=;
        b=hg6aKLBjUtPeTGHqaC2GnbkSmOS/APoH5xWzG9rBvOZHU1ccG83IsjKrV5rKcRHna7
         25t33MY5OMut9lArnRv/sPxEWLScKrDM+GJtBOBNXUnHsMW5r9NOwCCtWLSNm4X0oJ6a
         bTVN8noKgLmz7D9mCwdkwkYhrt+uAxWSFLiZ24mTc9L5QGj/CuWQpdCo2Wdb+kF7tj1N
         c2RTNHu/G3ai+XeG0wQWHwzgdEOHpCJ0zWVWdeLpxSJCvWjJrsRxFzYPgN6fhCwqyjEG
         u30omnXNjk3r2Zcd25qh4YQURqIYftTvaKaXwIzs+VvYJhGsidRUpuDM+M+BXNurmfzY
         aW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M2L1T9vRNnnL2xUuQoHEhKITQMggXL22+X8LudfSCCI=;
        b=hJDUASXUUCIkNTGEDqa2n6K72jcE9Y4uy3bdPeAtyJFyyeUqxE0XfzBbElCUBwxnPo
         g3zPOFkIAAWYJ+Yq9KsZM7cnu7ZIWcOr2sDdz+OSOw2lo8D7XQO91XMMzbxgLFVxu34p
         uwZHJue/Pn4y5uNxZYYec8qD9kbktujVamEvgqI3ZNS6Q+xbV8SORhUbpPSuI+2NQMhZ
         s9DxCzx0a5/xVB03n5ek7Ljyv9t9r5e5Kr8+t9MKzZd4qZnsSaVaem5rRykh1QIfJtwH
         +rEir5oAwAETwkKQybxUE58OYwhh5U9M8I46nvNMITnd1+tixAKHbGRPm3DoHp1w4zRg
         hkog==
X-Gm-Message-State: ALKqPwfxk5RuKkIytUnpm8aNRQGICgsYI1nrtNeeAIKch4dWfNdUCOXz
        RQoDzDuH0nkDDHq+Y5w3HA0=
X-Google-Smtp-Source: AB8JxZoJ2GmzK/sDT1INGOWnyC8YhmPJTy8yowAn2otRHlsgNK1z44jluKeaJqt820UkKCmdcpvQIQ==
X-Received: by 2002:a5d:4182:: with SMTP id m2-v6mr438374wrp.134.1527218532236;
        Thu, 24 May 2018 20:22:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m134-v6sm7691353wmg.4.2018.05.24.20.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 20:22:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] config doc: elaborate on what transfer.fsckObjects does
References: <20180524190214.GA21354@sigill.intra.peff.net>
        <20180524193516.28713-1-avarab@gmail.com>
        <20180524193516.28713-4-avarab@gmail.com>
        <CAPig+cSd32O3ELaHxLD0_yRFmjMAo2k-jApopJmuEt7Z6W40-g@mail.gmail.com>
Date:   Fri, 25 May 2018 12:22:11 +0900
In-Reply-To: <CAPig+cSd32O3ELaHxLD0_yRFmjMAo2k-jApopJmuEt7Z6W40-g@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 24 May 2018 16:15:33 -0400")
Message-ID: <xmqq4liwpggs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +will instead be left unreferenced in the repository. That's considered
>> +a bug, and hopefully future git release will implement a quarantine
>> +for the "fetch" side as well.
>
> If this was a "BUGS" section in a man-page, the above might be less
> scary. In this context, however, I wonder if it makes sense to tone it
> down a bit:
>
>     On the fetch side, malformed objects will instead be left
>     unreferenced in the repository. (However, in the future, such
>     objects may be quarantined for "fetch", as well.)

I had an impression that nobody else sayd it is considered as a
bug.  Do we need to say it in this series?  I'd rather not--with or
without such a future modification (or lack of plan thereof),
teaching the fetch side to pay attention to the various fsck tweaks
is an improvement.

