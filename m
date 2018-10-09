Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BB9A1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 05:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeJIMnB (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 08:43:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37162 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJIMnB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 08:43:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so310855wrd.4
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 22:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UZlwdcRvfM7TKIpQhENIvqCo+DrRLLB0ylTDQVWl0K0=;
        b=QUrualZ7z90+sdZP1qCUClw0SgNZO3cfZ1tKl0w/bnUrv+g+SqEPHVBrj0iZnmoxF3
         OHCeIavTJDAFjZyiZUdwmXrbEn30SxAjUy5x6DkcRRl4mzXZmcfVcD/PuNHn5cr556hI
         7knzMIUjuOM1YvsC+vN7oN5zkjRFCxCgt9ZWZtXSvDH39HDDs+0QMsDqyn65I8q8btEW
         pRalFn/UA8ckQKmIzxpIUukGQ+eTM83/b4aqy1FfS3sE4Z/XcOUHT2avXOI57TizSbiM
         uADNgXOB0SSxVMaAqgRzxcSy9l+jDPEnWqRUvdc96ZjAfqEIE2iC85C16W43olZXgXDI
         Ff2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UZlwdcRvfM7TKIpQhENIvqCo+DrRLLB0ylTDQVWl0K0=;
        b=h9UswCQ+51PiUDgsR2pm277LvzQrMsAkYBqMyrnX47uFJc/5PON6I9i3pi1ky3/f/u
         S11BxuOrW5yWsIgJqyoiZ43GSbaFle/Py2JE/vtH7BA5CRvYJEqdyVp7QxC56HcRX4nh
         l5WPGycuxkeujDDwAhtF1qZ6XieoD0EqcAIUhU2ri9iWXis3ssOLfe92DMQBSjfWxBC8
         HUmeEqH5Vb+tA5LEdWdpGFazDHIH82klYXX2AH7aqPTi6WEvrA2MsemDp97kKEFgsnFx
         3Yi18hZ44Ej8YhFCT2eznw2/HMAVexkqiIH1TOARiLdbGxthJcjLRgesfYjx1yd5VDxs
         x+5Q==
X-Gm-Message-State: ABuFfogNwu8USMPjohc1aUDJDuAtxQt+SsWouQHx55PO3j66mAba5dAE
        BYzxRxmHabb/SixucDvlPb0=
X-Google-Smtp-Source: ACcGV63Qyi6naqMepPDLfzoBrdIHddioATDD6f2xqHB6H6X+su56KFBmMrX5FdQxnewt2Fxe22U6Og==
X-Received: by 2002:adf:de92:: with SMTP id w18-v6mr20067634wrl.300.1539062872212;
        Mon, 08 Oct 2018 22:27:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z15sm10694210wrw.15.2018.10.08.22.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 22:27:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/1] rebase -i: introduce the 'break' command
References: <pull.43.git.gitgitgadget@gmail.com>
        <b358178548bdc9134d4e4b83b1d0384ebb257a72.1538578818.git.gitgitgadget@gmail.com>
        <xmqq1s9424ig.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810051409220.2034@tvgsbejvaqbjf.bet>
        <xmqq1s8zsrbq.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 09 Oct 2018 14:27:50 +0900
In-Reply-To: <xmqq1s8zsrbq.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 09 Oct 2018 12:59:37 +0900")
Message-ID: <xmqqsh1fr8o9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> There is one crucial difference: the exit code.
>
> OK, and it was good that you explicitly said "with exit code 0" in
> the log message.  Together with the idea to update the doc I floated
> earlier, this probably is worth documenting, too.

Heh, I am becoming sloppy in reviewing.  The patch does not even
update any doc.

It is not a reason to reject the change (the change looks reasonably
simple and reviewers and those who have to look at the code to build
upon it would understand it in the current shape), but it is a
blocker for the change to be merged to 'next' and down.

