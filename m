Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE331F576
	for <e@80x24.org>; Fri, 26 Jan 2018 09:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752863AbeAZJZe (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 04:25:34 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:35415 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752814AbeAZJZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 04:25:29 -0500
Received: by mail-ot0-f177.google.com with SMTP id w26so211872otj.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5MfFSCXc+/4GDv2VHgUWDdWz1kufQobVdp/5J4t81GM=;
        b=ugvcY7LXGnvbVDzHfhfdQhHQI8jdz3OT4LlZNMc8a50/mxCf+sO7g1I7goVLnC8Hxz
         fiowauUAltdsbzBEFJI6nf5TXgG+kY5eFIvCqpXrDo+h3oj4oJric2Yaoc6Qzyp8TJ4F
         W3DXFyoxNkxDIOrJZa/IWMJVbU0pLAgjD3SquqEm1KZaPJgtgylmvHwakGz4TaY62o2O
         wK0eJ9ZY4eO2D0NmMQolFFtOvC9MyJylm63hy+MXd9NS7AiJB950yJ06OGj87h0t3cVA
         BcZ2EcQMkicS+5QPfyE5f0xZJ5IaRi5xCjt/QVV6hkr6m6/oP38t1raKQu0yP+RXMvPg
         TAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5MfFSCXc+/4GDv2VHgUWDdWz1kufQobVdp/5J4t81GM=;
        b=X7T8Ik4DNIqReynZLU4WRndi8+JN8EzaPBaXNrB+GG2cSOel/JGp5eJGEZvdaztVWy
         QBCO63B7+ImZZQxkfIgmdvFpVlhXx59h7AMt6Cnlb2ipRBfIUiDKnROosyeezW895mbO
         rDPdu0zxk3TYQsbDQJI7U1yyqmJFgwR83gw/IEXglKq0iWYsZR3iP0Sg21NXqc4zXEUx
         BZiMpemysJcenP4trEBrLwqeIhXhx3cqSNCWhG9AlJpYevsNB1fCby3dArh77Dbcgd7b
         qjm7xEj5tytoEx9E+oRWVDyQgNHj7YRNG/dK4gxI0Sa2jow+6gHmES9xvKz/Sf5WJKdg
         9niA==
X-Gm-Message-State: AKwxytecpv2HtCEq3/SlJMY13Sm6/DmBAH0rvIgkYjJPd/INOVAOEDui
        s595vaDeCzJaWzxjh1ecNn9M4xNCryjNwRRn4Jw=
X-Google-Smtp-Source: AH8x2277Kh0cBQQy07ATXUOKtomxr7I3YxRZrYPGUr5+3mfECoONT4ZgjVR8I6IOTdc6WsXp95EW0W2eMqomVmb9L8k=
X-Received: by 10.157.112.12 with SMTP id k12mr3626544otj.165.1516958729202;
 Fri, 26 Jan 2018 01:25:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Fri, 26 Jan 2018 01:24:58 -0800 (PST)
In-Reply-To: <1516953056.8886.3.camel@gmail.com>
References: <CACsJy8Dzh5E8JUDkwFmYTwS6KgqGc_1rJBVsDCoC9EpcSShN2Q@mail.gmail.com>
 <1516953056.8886.3.camel@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 26 Jan 2018 16:24:58 +0700
Message-ID: <CACsJy8DjXBv_HMbRFPjCLuYt-bk=Ec3VPKorXJ_SBJN8pDu=PQ@mail.gmail.com>
Subject: Re: Bug, git rebase -i does not abort correctly
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 2:50 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> This might seem to be a bug as the comment in "git-rebase-todo" says,
>
>     However, if you remove everything, the rebase will be aborted.
>
> But "man git rebase" clearly says,
>
>     If <branch> is specified, git rebase will perform an automatic "git
>     checkout <branch>" before doing anything else. Otherwise it remains
>     on
>     the current branch.
>
> Junio has previously confirmed that "git rebase [-i] <upstream>
> <branch>" is just a short hand for "git checkout <branch> && git rebase
> [-i] <upstream>".[ref 1] So, it's not surprising that it left HEAD at
> @~3 when you completely removed the contents of git-rebase-todo and
> exited the editor.
>
> Does that help solve your issue?

Sort of. It smells bad design to me when a mistake can easily become a
feature. But with your help, I think I should be able to disable this
feature on my local build. Thanks.
-- 
Duy
