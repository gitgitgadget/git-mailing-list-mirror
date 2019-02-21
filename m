Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5801F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfBUUEb (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:04:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35841 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBUUEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:04:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so32017379wrw.3
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9qeP75ErwdPkHp2Jd20gdo/Cza74au6gtSLMLP2xJ78=;
        b=dimy++ecEBZPcTDjShY21nPZjwyp8xAgcN//58Tl5dUWxV0WfD/qsH9tClMBolg2Gr
         K9IlJf5zzWIGT+agSEKoiLf116jQXC/qzyE8Lml8j9STgv7juR1mjGlpmQ+c684Y/YrA
         gxwSPaICM0CwzT9K31E1TNeCNsaDKaCS5d1ue5h1ZmbdxI7yBIN0d3UVvl6GQukRfjd7
         ZSkUgCPKG2ZlwoG0Zxj4zLBGV2zqalWYL04b9D6mcMRWDX0BqQPkYI+Ywr1QWcqjQn2h
         gMB4L5Wv9V81XFMmA+ffiZmPWE5oPOrt+/PQb3dBL4Ymu94KMovgHRq+Oh3dYA+P6swx
         w44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9qeP75ErwdPkHp2Jd20gdo/Cza74au6gtSLMLP2xJ78=;
        b=cIDY0AtKKVEDA1IdycZNL6GPMnftmn32kf3vQ4Xokn1v6XgYZNQNjegG7DNruYWPu6
         wAtyk5xLWagL1LPq0ZwpXncnPjEgeqm089kF6Yby21hoWf73DT455O6FFebR+lcbBCgR
         RQlePmlai2QYjWjPWgg6LXPC+/8sBGkHi4J/7suAyVhWH9Ip3mCWeidOShcXWyZVcFMX
         HhpLbHxey7WcADNqtJCcC/FBmHT4r/T5NLGzI0UgtupxJCLoLhN20q+Ki1Mf8ayPEUKa
         utUrbA77zyHkYNUkVnBAS7LxyXm5AXX//Mv/WyOKYgGJGj41jrczOfilg/GWmV9InVnV
         Dg/A==
X-Gm-Message-State: AHQUAub0nK/bDBIOm5/XQsBs5+mq0FSYkePNRc94E0/1QKo6bUyXB3Yb
        lVVZ22xP6jcs6xYUAXokkhc=
X-Google-Smtp-Source: AHgI3Iag0ypecNkjZO6lL5eTfsNu8um8wdzr1VKIJpDuVSHcnpSbn7FWoAghM+Gz6autvFM3kBYGhg==
X-Received: by 2002:adf:e548:: with SMTP id z8mr217387wrm.52.1550779469010;
        Thu, 21 Feb 2019 12:04:29 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j5sm17419875wrw.59.2019.02.21.12.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 12:04:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
        "'Duy Nguyen'" <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc2
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
        <012601d4c8b5$54f1b730$fed52590$@nexbridge.com>
        <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
        <001501d4c9fd$bf80dfb0$3e829f10$@nexbridge.com>
Date:   Thu, 21 Feb 2019 12:04:28 -0800
In-Reply-To: <001501d4c9fd$bf80dfb0$3e829f10$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 21 Feb 2019 10:54:31 -0500")
Message-ID: <xmqqlg28ucvn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Here's what we get with this patch (and without it):
>
> /home/git/git/t: sh t4153-am-resume-override-opts.sh
> ok 1 - setup
> ok 2 # skip --3way overrides --no-3way (missing TTY)
> ok 3 - --no-quiet overrides --quiet
> ok 4 - --signoff overrides --no-signoff
> ok 5 # skip --reject overrides --no-reject (missing TTY)
> # passed all 5 test(s)
> 1..5
>
> Technically, we have TTY, but not that dev. The TTYs are not under
> /dev/tty*, however.

Ah, OK, that explains it.
