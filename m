Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE961F404
	for <e@80x24.org>; Mon,  9 Apr 2018 23:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeDIXLr (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 19:11:47 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44594 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDIXLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 19:11:46 -0400
Received: by mail-qt0-f174.google.com with SMTP id j26so11237762qtl.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qouYtD/1lc1uz9ne6PxND5WqRV+Xn2PGeWHL4CXDeGU=;
        b=evKc0JUhbm5lorHZCzd3kfzGgxHvWQoW2lIh/pmq9/X9k5H6iYJCa/xWVlsoKjR5uq
         QuedsBY6y1gvVIiaUKyQ42jQZ2je1GeYLEbZDBJC9JLQJQQTCSWBR84algjtepbomH1A
         V5PDtu3fWi3yodmhMdrRck5D91elU2g1vPBXLsRx5/YNQOabONpXqiueqpASnO1SROVQ
         6g62qFR+Cq1TWemJ5EStnhAoXMuB7P4v4ZzzFoFzAwlcbnMxvdsuqarykCbI7YANQqL6
         X3070wbWzp1E1BOlYq+tIZ4wq+AzWuXQx4gvNJ5Z95hkgSLejQBFc625tCurSU17fnO2
         zKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qouYtD/1lc1uz9ne6PxND5WqRV+Xn2PGeWHL4CXDeGU=;
        b=ID8WpgXGxqPUoEi7tubh4psnOs22L+3m2ZEQS7TNoqp76FctzSX7lmWluFbXMeW3CK
         8drZZsjVLUmwypFaooaivYhErQNjjezHAwMQG12y5NVDRZE2d7WkxWQp2PpNOcxk2tP1
         hgSuG29er39dwmff73nHuELLqC2ZLvjxrpaalLk/A5lxgwprF975uKRC08ETF/fmQMpU
         rSGvQucDpUDDj1z5mG+3AbbENL0H03s+eDeqWD/eOEvcSGvqPFdMeMRe2xNudDhoQ3fT
         w0WtF/IYGpA8yKB3gvWcpwriLS1OvxZKcYAyYolc03rAFcv/w61/AewM2YHkU7ATfiqB
         fzyQ==
X-Gm-Message-State: ALQs6tBuE+CdvXjJwYczQdivny6YmxIEqx6b2LHamuCItkImwNYOSj9S
        AP7gjR+5cfJ9vWhGw5rCVAGy0cqXFzNoU5RxJxsm4Q==
X-Google-Smtp-Source: AIpwx4/OY/wtpmvoSlYRkqS4u06BPE/ya3Kq0AnQ2k/+gTmMDGgFamrnpRk7+ERccdW/AZTbgiFKdIhJZpYdMwdEAws=
X-Received: by 10.200.80.78 with SMTP id h14mr30266571qtm.154.1523315505458;
 Mon, 09 Apr 2018 16:11:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 16:11:45 -0700 (PDT)
In-Reply-To: <20180409224650.GA34547@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com> <20180409224650.GA34547@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 19:11:45 -0400
X-Google-Sender-Auth: zOavUk2p_MTs1ro3KpdVFyiYq90
Message-ID: <CAPig+cTw5ZXKGOcnombwiM4P+9iRpbYUvOagQ0XujLB0ttXsOg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        ericsunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 6:46 PM, Taylor Blau <me@ttaylorr.com> wrote:
> Attached is the seventh re-roll of my series to support '--type=<type>'
> instead of '--<type>' in 'git-config(1)'.
>
> Since v6, I have changed only the wording in
> Documentation/git-config.txt, which Eric and I reached consensus upon in
> a sub-thread [1]. Per Eric's suggestion, I have also included an
> inter-diff between this re-roll and the one previous for easier
> consumption.

Thanks, this iteration seems to address the issues raised by my
earlier reviews, and I didn't find anything else upon which to
comment.

I had meant earlier to say that the subject of 2/2:

    builtin/config.c: support `--type=<type>` as preferred alias for `--type`

should probably be typeset as:

    builtin/config.c: support `--type=<type>` as preferred alias for `--<type>`

but I'd rather not see a re-roll just for that. (Perhaps Junio can
tweak it when queuing.)
