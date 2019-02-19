Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_RP_RNBL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352E61F453
	for <e@80x24.org>; Tue, 19 Feb 2019 22:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBSWOG (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 17:14:06 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38373 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfBSWOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 17:14:06 -0500
Received: by mail-vs1-f65.google.com with SMTP id h132so928933vsd.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 14:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltky84VZghR6Y2v7CzMLKdxPZODG/4NqGCHw9cxAF94=;
        b=psvNhK/zyCQXGfgPyA1vTICl21syRIi0zNzvR/1GuOLZVeQhmn72cPMlruEm2JUKnl
         O/2iXH5ws8VGanWH6yvJDZvHTrRnH55U4rxxolKx4GeTKJdFfk1QAh2kQC7/uTkQgY+5
         GKk934HsgEKRP84ufU1bZOrSOKUyyTpM2Cynwec5qHUuNWiLS+g1U8DJ74kiNNvSKo51
         cEClxIoX4nfw54gAzFmycIEKUK5bC1KVebJLWa7unY9Idt9TlqTP/qA1PifLoi7ej6SB
         yHX0TuF7bMB1xLMnhaOYYuganjpEeiaof1Yf6gfdAgOAYj9+a7NzyupB+6UKkF3QZuKr
         BRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltky84VZghR6Y2v7CzMLKdxPZODG/4NqGCHw9cxAF94=;
        b=o9PCkO7gpZKpniHlYLZTxeT47laTeqxfJJYYEwFOPDpSYexQ7mlHiVSWYNetViPUy4
         Mf1Vf4HjPWa/2O1Zo+sr2wOBe2YUPDwQ2osomlocI6N/M200C0RN0715Cg0cF9h6gVej
         NHmczQTw0447d2Q9epSjfyVdMp3D+VFAtn/pAp6xsO+VZu/Pq34+cwiFvufLZ1cO9Ilj
         ThNQOWTncWbE7Ol1Ubtvjma2eJPsthOTE804/mW4jkK/tOn9KL+ui++Cojek/l6Im5Zq
         lGQmikXN+yK7wuPwxpyuIur28xqDxkZk2BT624FSV2TnI9Z9SbK6CYyA+NZyEUjZB1Wm
         npsQ==
X-Gm-Message-State: AHQUAuZIUS7kt0HxUjL/tlPtZTQsMCDrwEXYNSebrIvGHqa8c7Q8f/F9
        F96ja/iRRiIs5vJFEtlOwYknWXSadRhveU6e/GQ=
X-Google-Smtp-Source: AHgI3IbbWnO4GsUa/SGn8v65DSh8bqYhe9TWegq16vxPrDuKdS8vjPqWJwkbHEp1VdZ5Z4ZjeHB4s7jCHxYbWKaKCaE=
X-Received: by 2002:a67:f696:: with SMTP id n22mr17103051vso.175.1550614445103;
 Tue, 19 Feb 2019 14:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com> <CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com>
 <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwolv1tzw.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 Feb 2019 14:13:52 -0800
Message-ID: <CABPp-BEsK8grsGCMq9-QCWd4fgYzm7GfzQudbhFvGj_C55LNyA@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>  * --no-index --worktree <path>...
>
>    Update only the working tree files without touching the index
>    (new feature that cannot be done with the current Git, although
>    "cat-file -p >path" may be close enough at times), from the index

I worry slightly that wording like this might paint ourselves into a
similar corner of only correctly handling files as paths, rather than
also handling directories as paths, and/or which presumes the
no-overlay mode that I find problematic.  Maybe your "at times" just
meant "when dealing with a path that is a file that existed in the
given source", but I wonder if you are pushing more than that?
