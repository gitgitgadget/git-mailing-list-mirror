Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF651F453
	for <e@80x24.org>; Mon,  5 Nov 2018 00:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeKEJrV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:47:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKEJrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 04:47:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so7599687wrv.2
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 16:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LylEk+o0iZiL2dc1Qh+saNgyHX+U+x96xXykl1+RENE=;
        b=DHe7wXRcZQVnjO4RbkkE7fLD075qKQzcorvXAvFPSw47o2zXd3h28+/RVX7DNKX+YL
         +kkm1tt8eSaokbI+OaSBn2c5UlYeXRvWpnaeTpaQHIf7qVQj+Od2KBUpIh4daXmDL/b7
         jLF6pbAjQQoZlRn35eijpEDa3Rr7OIsKrN7H7jSygB7bKkyBanQN43DWBRmumBCUsL3C
         sUzTOAmdwGs+U6vfuYUcqLtkirusy9d1mYvQ62qcfUEjmoYB+OW83QIlmYdEXqKnShRG
         HYQvZRxAVQnBpB0WQdOuBmUqlUgO7GZrjr+lO2Buyr/+FHC6p4GZVQtx1zpkVoBkkmjB
         PQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LylEk+o0iZiL2dc1Qh+saNgyHX+U+x96xXykl1+RENE=;
        b=LKJ+5mB6RPqZ+UGVbP7+BwpZivTrTw6luX/nxd/tvf+0LSVL0zKS/SkoVfp8XIQ83D
         ghu1Xe0YrzWw0ZQGYjo77GufPs5L0DvVfUOHVqNsKvRk7AEkBgjVn0WYCoStviS+YyJf
         B8Nwm+bUK7qBz2vTiqzXFVSD39o9zTz2RSkRWym2hrHoNspmfWXN3ob2YwYOUOr3GbvB
         d/ax2Lq4zYjmoMgJNVwuCjL6DggGAWgH7O/U2el8CDCvp1R2LadkPxjxtWvfIsTE9t0J
         M+7jmgplID2Vhv5e65J5ap3Nm+q9Q5cHoXXMEJ3simvsdrxRSr6e8v6E4L0KazNJypbN
         gJXA==
X-Gm-Message-State: AGRZ1gJ2qS80gviPIheRBnSReUlRk+k+ElG0zxzFaonxPz6nM/tHkLgJ
        gsnPP5C7Gwc8v6E5zd15x4jtNI+6mNU=
X-Google-Smtp-Source: AJdET5dAJ+seTkU51uu1jsEkzJk6Ms68+pCV66MY8XMTwvhQUOrZ4Aa+A93cfrtVFrfzT0BswIGIEw==
X-Received: by 2002:adf:ef04:: with SMTP id e4-v6mr17839646wro.292.1541377827042;
        Sun, 04 Nov 2018 16:30:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y13-v6sm10501285wrp.46.2018.11.04.16.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 16:30:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     tanushree27 <tanushreetumane@gmail.com>, pclouds@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v3] commit: add a commit.allowEmpty config variable
References: <CACsJy8DttJ2EBcN8Kq-yECY0Pvp3vd0Vx45=szWD0cBW0Mcixw@mail.gmail.com>
        <20181103151205.29122-1-tanushreetumane@gmail.com>
        <87d0rm7zeo.fsf@evledraar.gmail.com>
Date:   Mon, 05 Nov 2018 09:30:23 +0900
In-Reply-To: <87d0rm7zeo.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 03 Nov 2018 20:07:43 +0100")
Message-ID: <xmqq5zxcmkm8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I.e. you seemingly have no interest in using "git commit" to produce
> empty commits, but are just trying to cherry-pick something and it's
> failing because it (presumably, or am I missing something) cherry picks
> an existing commit content ends up not changing anything.
>
> I.e. you'd like to make the logic 37f7a85793 ("Teach commit about
> CHERRY_PICK_HEAD", 2011-02-19) added a message for the default.
>
> So let's talk about that use case, and for those of us less familiar
> with this explain why it is that this needs to still be optional at
> all. I.e. aren't we just exposing an implementation detail here where
> cherry-pick uses the commit machinery? Should we maybe just always pass
> --allow-empty on cherry-pick, if not why not?
>
> I can think of some reasons, but the above is a hint that both this
> patch + the current documentation which talks about "foreign SCM
> scripts" have drifted very far from what this is actually being used
> for, so let's update that.

The command line "--allowAnything" in general is meant to be an
escape hatch for unusual situations, and if a workflow requires
constant use of that escape hatch, there is something wrong either
in the workflow or in the tool used in the workflow, and it is what
we should first see if we can fix, I would think, before making it
easy to constantly use the escape hatch.

I didn't look at the external reference you looked at but it sounds
like your review comment is taking the topic in the right direction.

Thanks for digging for the backstory.  
