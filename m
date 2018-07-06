Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24411F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 17:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933739AbeGFRuW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 13:50:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52989 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932895AbeGFRuV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 13:50:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id w16-v6so15553293wmc.2
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t9sKmfzL3OJ+EsJdvW8L08OyO2mITDYkcu8FKxB5RBA=;
        b=L1k7PXMY+IWNDjaFRy6tjnPzbTOnA/2Yz0tWtXxqQH6V2QamQKaHCj9xpCykD/OoFo
         pOBa1VSp9r0R4PCm5/7oCdCFj8/3+vo2nXgSpIDhO6h98GCvFiV0WXXksUd/3ljq7EmY
         LrhYmov1TD60tSnY1PSolOdcy5OyGSn4xyonM3FTt4u75bxlSc++PEKusipUAwjle8Kf
         f/bjy7fgD0Sn2Qrpv7scGi5cevasbX02/u1hLwwUyhHY9LMUAfRrJM9B/Rp8d0Voy1rQ
         AJejW/9Ghi73PVk6meLCfeYKgFrYUus3+OtY/KEvojiRNkGiKSje7RqrluxpffTHlq9i
         3KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t9sKmfzL3OJ+EsJdvW8L08OyO2mITDYkcu8FKxB5RBA=;
        b=geIoWVojKj+p6C1R2GIU9IzwXOI2IIk1L2YspLIeOZlhQAd2S5yX/VrwW+3MEjs5V+
         NXdeE8owSSVcaEwE0cQoN2S33E2KazOW6WuDf3AXIz8hbzCvkDHc+ML3KNbP87fmXqkd
         q+jAXwLEGRxEjgoZLfxy8BTB5HD9ztmGN6rwcbEPQ/UF4X79ivNjTXQBXKFERII89b3O
         RDMwzUDZ1RmVD0lZrr4ky7LdAX1dpvOB9h+mGjoJZsOUpwxyu4DBvx/rxg6nOTBz3iXV
         VSFOIVHuVpmN6aByrqyjqwlUmGkWBK58dUn1UZag4sqza2hDSWdqwa5pvtTyMGkmOcWo
         4WOg==
X-Gm-Message-State: APt69E09CPIEf7ahKO6EsMXQOtbyG5MqqKpgRHxXvZEatOt3XAmkWEvD
        8SL467HueZfVAsuT8oodbaM=
X-Google-Smtp-Source: AAOMgpe3VxV56lLgiS8Aeet6tAIfOwtU/Z9uT0jYOizENbbxN7lf5a6UwF893f8AAjqE3NUiN1LTcQ==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr7611169wmd.79.1530899420454;
        Fri, 06 Jul 2018 10:50:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o21-v6sm6710081wmg.28.2018.07.06.10.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:50:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: ag/rebase-i-rewrite-todo, was Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807031438240.75@tvgsbejvaqbjf.bet>
Date:   Fri, 06 Jul 2018 10:50:17 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807031438240.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 3 Jul 2018 14:52:32 +0200 (DST)")
Message-ID: <xmqq601smexy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The latest iteration of this is here:
> https://public-inbox.org/git/20180702105717.26386-5-alban.gruin@gmail.com/T/#r8eea71077745d6f2c839acb6200bb8b2bea579d3

Good.  I think we have it in tree now.

> I would *strongly* encourage you to allow Alban to go back to the small,
> incremental patch series he sent before, because it will make it
> *substantially* easier to not only review, but also develop, and for you
> to merge.

An organization in which you can make sure that the order of
dependency and which ones have been updated since previous rounds
are clear, even to those who are looking from the sidelines ("these
4 patches are to replace patch 3, 7 and 8 from the previous round"
is already hostile to late reviewers and doing so without a pointer
to the archive is even worse---a full reroll with the unchanged ones
marked below the three-dash lines would be perfect), would be good.
A random collection of seemingly separate but actually
interdependent topics is very hard to work with with limited mental
bandwidth.

Once the core of _a_ topic hits 'next', we can go incremental
(because by definition things get quiet and require small updates by
then), but not before.

I think the 7 patches in ag/rebase-i-in-c are more or less in good
shape, modulo the issues pointed out on the list yet to be
addressed, which I do not think require redesign.  Which is good.



