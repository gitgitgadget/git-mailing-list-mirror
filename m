Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CAAC433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 13:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F732068D
	for <git@archiver.kernel.org>; Tue, 26 May 2020 13:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgEZNkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 09:40:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50808 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388672AbgEZNkm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 09:40:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so3201911wmj.0
        for <git@vger.kernel.org>; Tue, 26 May 2020 06:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPIfr3OpNeN0OXq+RiO5JPalAFBUN7xvTzX8Gk3PqwE=;
        b=niD8UCm3sBkLohoBAnTIPpxeAIr1yaC6wTmWWwsbxh8RDpfkop9G3TJ+n300u96kzc
         i83LUjxcM8AJtazYGPN9Dq/828Vj6nF+0rPX8fpnyozGak+YPy/9TIk2hDY3aa+PXZTy
         UDtieQ0abzIsXQkGh0QNlMFd9wbN22FUvgrYDZcmf395ztYbzFctqrKjcKzK25tPMlqv
         0wDilysj30Hmc2Z1Ko24P//0TDAxn6ZzCPpVEFAaNYG2JtSjvcdG0G8+CgwM8vcot4LQ
         ZIqvFi3mqfFe2hv1C8j6rpZjscTKIZiOZOookBTHN5dx6Q2VxQH52Z9cG7Ik2MBno8xd
         sidQ==
X-Gm-Message-State: AOAM530mWWXVkg8Esg4HWpUOTw+b5YOuEDcL17fG+gISKGXiA8f6wy4b
        a2/xMjaL+PSOkJkkKMS3+bVSh1VTkHUsyFhowWw9JUqE
X-Google-Smtp-Source: ABdhPJzDpOXAtpoDZqwZi5ABRC7nHwcM8WY7ASSClulxh9ZsJLDD/7/TZu4NQluJE++OllOG9tr9mUs9U7MMNwJs4Xo=
X-Received: by 2002:a1c:2702:: with SMTP id n2mr1499329wmn.107.1590500440366;
 Tue, 26 May 2020 06:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <4WK2xPaKLXPbLE0jjY0rBR9M_BVt69rzJKBN17M0ily4VPYuMNC_a2kXsIKWR8y6lc7j58WpBmaIqdbJ1whnjonrfEWz7YE-WpdQqCu_lN0=@emersion.fr>
In-Reply-To: <4WK2xPaKLXPbLE0jjY0rBR9M_BVt69rzJKBN17M0ily4VPYuMNC_a2kXsIKWR8y6lc7j58WpBmaIqdbJ1whnjonrfEWz7YE-WpdQqCu_lN0=@emersion.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 May 2020 09:40:29 -0400
Message-ID: <CAPig+cTkwUyyji19XyTBRvC=RjLNK_OipLJ-+6GTf8PWRfC8WA@mail.gmail.com>
Subject: Re: [PATCH] grep: add configuration variables for --heading
To:     Simon Ser <contact@emersion.fr>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 26, 2020 at 4:37 AM Simon Ser <contact@emersion.fr> wrote:
> There are already configuration variables for -n and --column. Add one
> for --heading, allowing users to customize the default behaviour.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> ---
>  Documentation/git-grep.txt | 3 +++
>  grep.c                     | 5 +++++
>  2 files changed, 8 insertions(+)

To round this out, adding a test -- probably in t7810-grep.sh -- would
be a good idea.
