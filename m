Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44F51F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfA0XOt (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:14:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45932 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfA0XOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:14:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so16020526wrr.12
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VeTTQEx/wHfUTlXWH96Ux7XnONsF0LNQmfkuUu97PU8=;
        b=S6wyakFPQSqpoB1oQU7UAf7WSX6b5PipYa1lCkSfZ6nVUDKxK4DmgkR8eIxUI8sdX8
         HpsjNSXcSCDmqsmb8KHgBsMHzoyIDKqX10oU8TKZVEgxF30vp9n+dbSUMSw2dueoGySG
         SXrdafrZdrcfpPYXsXSeRWGkol+yebhsT1SI8v/qWsLbYgbnYGoOR3fWnqSFPt+QWtzH
         //rV6bHwo8OSQEANRPZGKhzi0teYfVryp7xA1nKiDwVsIEufEwuW2CcnC7ALHOpbG4JV
         XFjV+GOqTpcf2iWlgQA59Qn4thVpN74lQeovl7PU7s0Rdn2/euRiB0p41puSGTmYrA8A
         ARKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VeTTQEx/wHfUTlXWH96Ux7XnONsF0LNQmfkuUu97PU8=;
        b=ZoN2zIOzHgCFtQ2IKT8hfnglgsEAAfQUsM67/fXPs8wri0LBlHdKCFCUtzcej9FrmF
         8SbpsV9/zSyqxtHWN5ntziyb4vDTHGGbBrLfXjOgzvK/Wb861RFu1XS7btGbEDmVABKB
         yo86xT2lWepZYEabTrqgBuCVLtH96OrhtPHTgdXIAFAMwpxzB3OwTrnXcRN5OQnB6Kes
         J/2LY11vml1oZrPD12Zzr9QMvpck61MO7ZMVF6dkUkaK8/Y35twhnKz5CsPKy3eOxMIT
         1G0N9pGsg0ct+bHVi2t8ByOvYPoFcCuTQbnYNzi7fH6K4mWKjLd2Ykc68I6TlIc5A/df
         Ck7Q==
X-Gm-Message-State: AJcUukesQ3MEKIgVMuQG4YLlpL6a1bXHP6Ux1tUWixcVcvtsf+l3dsm3
        tbIdzC1tNo9Q8xoSiz6y7s4=
X-Google-Smtp-Source: ALg8bN7O2N44A7qgXHKBExl8yAcr75dG8oNhjfEkQfeikiijByWEu9pr7SwqnhmFixqvSybayzrZtw==
X-Received: by 2002:adf:9083:: with SMTP id i3mr19196518wri.124.1548630887475;
        Sun, 27 Jan 2019 15:14:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b12sm86327662wrt.17.2019.01.27.15.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 15:14:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 06/21] test-date: add a subcommand to measure times in shell scripts
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <aa053ed9936ebae0ca5e18d27de96f1d054d7f89.1548254412.git.gitgitgadget@gmail.com>
        <xmqqo98754gy.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 27 Jan 2019 15:14:45 -0800
In-Reply-To: <xmqqo98754gy.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 23 Jan 2019 14:29:02 -0800")
Message-ID: <xmqqsgxdelqy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think the goal to have our own stopwatch so that we do not have to
> worry about differences among system-provided ones makes sense.
>
> The only thing that may become an issue is how widely available
> getnanotime() is.  As "test-date" itself is built on any platform an
> end-user/developer runs our tests, which is wider set of platforms
> than what we run Travis and other CIs on, unconditionally relying on
> its availability might pose an issue.

Sorry for a false alarm, as the codebase in many places like
fsmonitor, progress, trace and wt-status have been assuming
getnanotime() to be available for quite some time, and this is just
another user of the same function.

