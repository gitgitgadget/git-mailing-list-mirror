Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6061120282
	for <e@80x24.org>; Fri, 23 Jun 2017 18:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbdFWSx1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 14:53:27 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36602 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbdFWSxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 14:53:23 -0400
Received: by mail-pf0-f176.google.com with SMTP id q86so27196681pfl.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=44XaSNASM5TYtw5hTLcuvNSi5ZU0wsg+AF4ZjmGjjyQ=;
        b=tH7/bhYTdzDYFdUvf/HtEKuAzF2DNBxIfH2HQgdLn+Y/SnRNuRNkxy6NuxtGY2f/tM
         5cxP5DZTxZL0cfLICks5rs2jLoLtIcghBFpUYSACPE5/jX/mWlQEITZHEjPcz1zknCfc
         qFshDm98o3eDcUmpsLokise/lFeouAQ2rgTkEYSmxdfTJuaaiM8xrkEvVoW2Rz8xcpaN
         gdFkoIS88KE1jYdvirBOcpJvoT3mcO86KDmhBoqPKFApNHsQBLr54qnbXnEUpEVSqKtK
         ai+nhwTO/wgdD8IsT3yix42F/knhRr4N41D4dktlzuWffk7MSlyMGZOlYWnFVPbLfyfY
         jfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=44XaSNASM5TYtw5hTLcuvNSi5ZU0wsg+AF4ZjmGjjyQ=;
        b=DRsJFQIyA9ws7KOAFLkKJOI7ikiWXrLoY75UzE0Ryi+FSsQeLgQsjqIyydNQZ8sRX7
         to2y4K+IedAQzd1Ob4DF1cvVZ3fX3z/6RTUmimWqZMRbq/WKHC7X2YdGfrH/UkutdJ5O
         gotz+Tu4roGgef+V5Ebds2OBrkh/W1EKgya9PLWmV7N+nddS8H4/AxxgZtFwOb/CKuwn
         yduwm11aSGlTu5LThiErosIbqc3KRGOds70toocJz97vgG79p9Ty0f5GU1/j1UVVRyDC
         F29qvHnR2YDvJBTShUnAFwKq9gd7Swz9jiR1b/ts95jlf9hMb7d84tZnPODFZlGHRMDG
         XygQ==
X-Gm-Message-State: AKS2vOy38TFdb6blF4ZyykuiX2an21IMzwZH61lJBGN1e0077a9CQ6Kw
        3aFG2kjBJr2xyA==
X-Received: by 10.98.40.132 with SMTP id o126mr9824335pfo.238.1498244002295;
        Fri, 23 Jun 2017 11:53:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id x3sm12703559pgx.29.2017.06.23.11.53.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 11:53:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/4] Add regression tests for recent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170619175605.27864-1-phillip.wood@talktalk.net>
        <xmqqa84zgwx9.fsf@gitster.mtv.corp.google.com>
        <xmqqwp83fg0h.fsf@gitster.mtv.corp.google.com>
        <bc0c32fa-2df6-a4a3-5966-8efabfa349cd@talktalk.net>
        <xmqqfueqfxfv.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 11:53:20 -0700
In-Reply-To: <xmqqfueqfxfv.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 23 Jun 2017 10:03:48 -0700")
Message-ID: <xmqqr2yaedsv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> 3404 needs a similar fix-up for the series to be able to stand on
> its own.  Alternatively, at least we need to understand what in 'pu'
> makes the result of the merge pass---the symptom indicates that this
> topic cannot be merged to a released version without that unknown
> other topic in 'pu' merged if we want to keep POISON build passing
> the tests.

Ah, no worries.  I think I figured it out.  

The topic "rebase -i regression fix", which this "regression fix
tests" builds on, is queued on an older codebase than 0d75bfe6
("tests: fix tests broken under GETTEXT_POISON=YesPlease",
2017-05-05); it is natural these old test breakages can be seen when
the topic is tested alone.

So we can safely merge this topic down.

Thanks for prodding me to take a deeper look.


