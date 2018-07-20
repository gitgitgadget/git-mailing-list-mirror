Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC55F208E9
	for <e@80x24.org>; Fri, 20 Jul 2018 19:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbeGTUYl (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:24:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36615 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbeGTUYl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:24:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9-v6so12274485wro.3
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iGPyGnvwxrEQPVxhi4YK+3HNbLUMK1TkfO62id2XkVI=;
        b=BsHpruQIb61TqvaV2Fpu7BbCeWDoOc6xfngFb4V4yMT96tUequmTRmstmKTDb1UZeg
         NSsMpPNDEeH4OvWj5ipPcjqwomuqcEOnF3pDVFSbws3xPhniFv3b56Sm0qA3axiwKkle
         PW67rBbVBnTLNMGe2k/DiA9R2JLANAiIE8OR546+R2LQ88LawU72aIJsnEPRMq9c1JrM
         WT1m/yeZMM9ZR6OvsOQdy0eWX2o1Ob6vIY49wpvx1670l9RX182dA2g/0rvBFKiDGNu0
         t0HT1dx8/tydywwxtdb0BvMcu+CkGevQq/tM9HZep5BCWUFhueUSLvi1dGjZfuPtAYDC
         qncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iGPyGnvwxrEQPVxhi4YK+3HNbLUMK1TkfO62id2XkVI=;
        b=luMKrFeY29ZvEszbg4oE39QLCCXEx5GK49uq+9S+yZAarkvfOS378rGY2BBzWfRICJ
         MOZAybSskiXNpSHgexSgT9H4OXg06b4RD1MDDx6zNNg3UGh0HJg/lF8zC8gT9450eEdq
         WLLbVFMJ6m2oabWIt0IkVvDVTkRKYNQOEsNI994VslCPW/d3IGeeEZbfTcx8bt0l9V3r
         DEIhR8JB8YG0drJ3XUBNV6D/F+RE4Lkv6jjXAvlAd360+5hEhb04mRww4tTujD/qd3RY
         9ucGOstI12Ckr5jcKJxLD4wfPCwESsxktqAI4HPJ4YB7COipfI0L8eQrTSYzZaI9Mqh9
         /Bfg==
X-Gm-Message-State: AOUpUlFl44uLqHVFR8RfaS7/JpibDTZSlDrjq3UH5TASPDJts/sV/1ZM
        nehkY9aMTj7eOOcLvej5WAWuV++M
X-Google-Smtp-Source: AAOMgpfi+7b7Im2RfiDf4jSqODms6grFtaOuAFHYljPQVjzbEzlq3MtXagztjOfpEACGkb7x3vCIIg==
X-Received: by 2002:adf:e9c1:: with SMTP id l1-v6mr2280457wrn.14.1532115298345;
        Fri, 20 Jul 2018 12:34:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l10-v6sm2245230wrv.23.2018.07.20.12.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 12:34:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
        <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
        <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
        <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
        <xmqqa7qngnon.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet>
Date:   Fri, 20 Jul 2018 12:34:57 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807202049540.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 20 Jul 2018 20:51:54 +0200 (DST)")
Message-ID: <xmqq1sbxbt0e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> AFAICT there is at least one scenario where you run `rebase -i`, the notes
> get updated, and of course the *reverse mapping* does *not* get updated:

It turns out that I never had a rewrite hook; the notes.rewriteref
mechanism is the only thing that has been used to maintain amlog.

I've stopped populating the reverse mapping, by the way.  The script
that I feed a message from gmane or public-inbox when I need to
learn the set of commits that resulted from the message instead uses
"git grep $message-id notes/amlog".  And that is fast enough for my
purpose.

There is no good reason to abuse the notes mechanism to map a random
object-name looking string (i.e. hash result of message id), other
than the ease of "quick access" when somebody is making a lot of
inquiry, but that "database" does not have to be stored in notes.
It certainly does not belong to cycles worth spending by me *while*
I work during the say with various history reshaping tools to record
and/or update the reverse mapping and that is why my post-applypatch
hook no longer has the "reverse map" hack.

It is not like anybody (including me) needs realtime up-to-date
reverse mapping from amlog while I run my "commit --amend", "rebase
-i", etc. and the reverse map is constructable by reversing the
forward map, obviously, with a postprocessing.  And I think that is
a reasonably way forward if anybody wants to have a reverse mapping.
The postprocessing can be done either by me before pushing out the
amlog ref, or done by any consumer after fetching the amlog ref from
me.  If I did the postprocessing and refuse to use rewrite hook you
wouldn't even know ;-)

