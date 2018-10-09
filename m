Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5441F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 01:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJIIR5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 04:17:57 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51611 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIIR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 04:17:57 -0400
Received: by mail-wm1-f50.google.com with SMTP id 143-v6so135776wmf.1
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 18:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MD1aFAiNGYE2y+ZR/VQUvC7dqcezJ3+p9QtLtitd/js=;
        b=gEFtUOrzmjJtwsk8erEGKIT+HM8/q+CKiKZXBZEPfmCmuvLEHCVjdSB2FxmjK/pKnW
         2XPUsHMBaD9LJtnN51ulNna7oBlr0FIIYlVXN5SZk8fWYB1XCEqFVqXCWsZH6C6jPXyN
         ejEeE91murxkUhYkdBpck15wAd5bETgdryWklbEW+Hk4CNTT2eYxlqT6fvpsQyOaz9TQ
         HHZQR2To3MaF9B0Y0+YU/1xztVFxEnRU6kf5EbkFGcKcN4n8yDsHeKOMTei9a2ekkfmF
         9EsTqrRgPItLavhU1WRw9XBduF+DzEP5ZHMnNLOeS4Rhmnzo0Y1fkcLVfV4SQOe0I6xZ
         h0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MD1aFAiNGYE2y+ZR/VQUvC7dqcezJ3+p9QtLtitd/js=;
        b=ekY64bU1ilaG7pWPpi5mhmTG5KRdfdtq+ZNA6JbeiiquZAztKfU9QjIuSIcY/8unh2
         u8QeGpbstdmge1wZVwGKczEXs9Nhuv2dWGZy7mUXNrh2uKX1Tf+Jo/+1gmZPk9U5jXh6
         QbgrjJBFZEWlVXW6h3StoVnvn6pWkyKBFredZlXNWO6zVYmekf3ssfljIXuLg0XOH56a
         z/QGXSwDV/mEO9UVQ7/NOeIbN4cmTmOTWJ+NAGQu+Tpf34g6nNV92C4h1y38q9FPg45A
         ZB6KFa6oEj4iXNTuIRdrrsWXIBWWhDbx293crh+Ez5OqR+o4dwPAmOvrWlDkRQyx8YEM
         cSFA==
X-Gm-Message-State: ABuFfogJ8kVdCJKxPMAti+luSvdB2d7Jtd0dzxahNHX506EZi9WO2pF/
        cTzwRwuF3PnB35cHU5lqDJk=
X-Google-Smtp-Source: ACcGV61GF6cB16aJcfitJPDjjRwpv3lWlYpPEyyZLlfQU3aaZG+YAs9a6nmLWMLbM+AjsqKMU8h9oA==
X-Received: by 2002:a1c:8fc5:: with SMTP id r188-v6mr188297wmd.136.1539047013248;
        Mon, 08 Oct 2018 18:03:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l67-v6sm32242275wma.20.2018.10.08.18.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 18:03:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        nico@cam.org, nix@esperi.org.uk, koreth@midwinter.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>
Subject: Re: What's so special about objects/17/ ?
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
        <87k1mta9x5.fsf@evledraar.gmail.com>
        <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com>
        <xmqqlg79tta8.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZq3xtsbscrRFD8CSn++yrvdM6Ux+nkQ3AamgabXtPL+w@mail.gmail.com>
Date:   Tue, 09 Oct 2018 10:03:31 +0900
In-Reply-To: <CAGZ79kZq3xtsbscrRFD8CSn++yrvdM6Ux+nkQ3AamgabXtPL+w@mail.gmail.com>
        (Stefan Beller's message of "Mon, 8 Oct 2018 12:17:40 -0700")
Message-ID: <xmqq4ldwszh8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Sun, Oct 7, 2018 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>
>> > ...
>> > by general public and I do not have to explain the choice to the
>> > general public ;-)
>>
>> One thing that is more important than "why not 00 but 17?" to answer
>> is why a hardcoded number rather than a runtime random.  It is for
>> repeatability.
>
> Let's talk about repeatability vs statistics for a second. ;-)

Oh, I think I misled you by saying "more important".  

I didn't mean that it is more important to stick to the "use
hardcoded value" design decision than sticking to "use 17".  I've
made sure that everybody would understnd choosing any arbitrary byte
value other than "17" does not make the resulting Git any better nor
worse.  But discussing the design decision to use hardcoded value is
"more important", as that affects the balance between the end-user
experience and debuggability, and I tried to help those who do not
know the history by giving the fact that choice was made for the
latter and not for other hidden reasons, that those who would
propose to change the system may have to keep in mind.

Sorry if you mistook it as if I were saying that it is important to
keep the design to use a hardcoded byte value.  That wasn't what the
message was about.
