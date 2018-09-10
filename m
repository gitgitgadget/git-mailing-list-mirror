Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE141F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeIJU57 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 16:57:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43531 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeIJU56 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 16:57:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so22519035wre.10
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EPUeP7lVAujP/J3kvbi/CSPL1lqU6csfj+Z+3kyLqeA=;
        b=DJ+8O+YBrW1Sl/B19NaAL3BtHsguMeZ/pOkq4IXJqneGyiWKgDTs2ugCh7IdpDTV2A
         B/h/4xR7zeyZdzkvlPk3NQgx9c27/DikHj8NE5OPKXAVfsmUKG91D6ib6KxjZZ2R1RKP
         AkmrR0F3rXels+9vFeAdtFI62kX3nXmvkaokj1ryTbVLASVhCdMR32W3yPb5oI/eOwmK
         D7T5ni7Mj4lAjPDmjxs/Kk4QVMr6tIhlC2IHaArciHk6NBPg/6FL1Pj8VkNCHY05LmHQ
         Dbwf8o6Riil8iMUKIFCmxILO+ee0zZj10nTMAH+Uflu1zBTvIjVL7eYHzvJd3EAMaJQK
         A4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EPUeP7lVAujP/J3kvbi/CSPL1lqU6csfj+Z+3kyLqeA=;
        b=gU2R3Hbl9kSFXTploo/9U51uKeXJjJg2x3qwpDyidqA6w/VwAGu9loKcaQeP62NJzX
         gz8v/FN+4vC/TjKZvvYiWqYASqaTuTzJdK6sFbwVwg+mbOSYieGN8uULFISyDFPBf9Y1
         +wK41+DV+MbQB4CLtdFg9wSx2aP3oRsycFgUWij/Ft0uwLuVcyskG7GaaF9f6Qj86Kld
         LWY9eAqJaJjsl/o/DiLOzvxL4bVQOih+6Fe065R8In12JHS4XeyAOx4BixbeSjQf02IV
         oQBcZCHxwMDrxnQLPRtcENnPBO2/oWLiv1a0TlGGMYSNOKco++RBXMkCnAUUnh/3cE4o
         uzww==
X-Gm-Message-State: APzg51DS/u6QEYS0PMg/wehUZiC8YN+ecA71Bi2ONdBrAeQ2m4tgfvse
        UVyZ6Cr4R1IyHGZg/FTVpw4=
X-Google-Smtp-Source: ANB0Vdb6dYNk84Z6k5tDJZQM4fFlBKSGcwG0Neja8Mm/3dEalIf8Bp+dLt0wWdqllcowaP0Kk5yGbA==
X-Received: by 2002:adf:d20a:: with SMTP id g10-v6mr16646642wri.66.1536595391193;
        Mon, 10 Sep 2018 09:03:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6-v6sm11977346wru.64.2018.09.10.09.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:03:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>, dylanyoungmeijer@gmail.com,
        Git Users <git@vger.kernel.org>
Subject: Re: [Possible GIT Bug]
References: <CAPGJNu5RPXjeib-vayVzmFkU9cZ=h5o5VDoM1vQqv2+HgtNXLw@mail.gmail.com>
        <CAPGJNu5=GkiALR1=RYgHLv3NDrycqv13jpU5_=SOW-yWtRXduw@mail.gmail.com>
        <CAGyf7-EFiZ7ouUPDMtv3eb57QEiM2pkavyKQe7iNO7+eBeuZ9w@mail.gmail.com>
        <20180910132452.GB5233@sigill.intra.peff.net>
Date:   Mon, 10 Sep 2018 09:03:10 -0700
In-Reply-To: <20180910132452.GB5233@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 10 Sep 2018 09:24:53 -0400")
Message-ID: <xmqqin3duypt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Your explanation is correct. To be fair, though, it seems like
> --find-copies-harder is made a lot less useful by the not considering
> the larger set of sources, since that's kind of its point. I'm not sure
> if this behavior actually is intentional, or simply what happens to
> occur based on the combination of features.

It is neither but if I have to pick one between the two, it is much
closer to the former than the latter.  The primary source of this is
that we have only *one* pathspec given to the diff machinery, but in
order to implement your ideal "find harder", you'd need *two*.  That
is, one set of paths for which you are interested in their origin,
and the other set that you allow the machinery to consider as possible
origins.  Since we can only give one pathspec machinery, that one
pathspec is used to specify both of these sets.
