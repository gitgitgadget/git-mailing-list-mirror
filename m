Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050CAC677F1
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 06:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjAIGcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 01:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjAIGcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 01:32:47 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8288311810
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 22:32:46 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id y1so8492119plb.2
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 22:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6oRggZoySZrIMQdLLv55pfNhDblXf/tJ3wRSPstvfo=;
        b=oVYyuRJglTRfDgtbLDL9+3af1ECYGBSR1FJS9zjmaO5RNdFWjq1Bo4x808mgrKud2z
         +htqn1t5MTOx99Sf+DqxBEQQRpIdEGmAr89ecpnOoXMaMJymCzInfCHugNQr9VVxti2i
         fHcw3bzNQEIT4AoQRdMPvvaP3Lpj5HngqBK2He5CZjd/hOkBeVkAsucmVnoxXoO3lXeB
         WeW7IKBpATsFJLaOsfVvmnyvhs4QmNj8U6KnD0L8C7/eBgD7iCyqGhC0bqvG8PIWoPId
         B1MbrTBpXpo8sbFB4s9RdR5SxUCFH0pG+5kYLmeQkZ63SkOrY6lEB5KPUcdCwc4G6OIV
         4krw==
X-Gm-Message-State: AFqh2koVSN9aQsD5yIvSSxbxsSFj+ELEWIb/unQIDqEIP3cRBBOGwCKB
        YN9g9V7XZHbCK7kPNSy9WPlsPbKGdKWHf77IOY4=
X-Google-Smtp-Source: AMrXdXsndlWHiW1YXZ7zxrD3tv13OOVg3Y872quts5l7++Q50cKlbJZUhepIcaU93kWjXXs+5oTkEUHmBcRpCDS6Eck=
X-Received: by 2002:a17:902:ccc5:b0:191:271f:47a0 with SMTP id
 z5-20020a170902ccc500b00191271f47a0mr4175472ple.120.1673245965925; Sun, 08
 Jan 2023 22:32:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com>
 <xmqqbkn8wcqo.fsf@gitster.g> <CAPig+cQe_VMW2KV+ZyZwosFw07Q+hePryDVushRJ-jFfD4yzpw@mail.gmail.com>
 <xmqqk01wusmz.fsf@gitster.g>
In-Reply-To: <xmqqk01wusmz.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Jan 2023 01:32:34 -0500
Message-ID: <CAPig+cTO1jBjcwjX4UpxG813OwrDAaYVvViC_XGWorwbXvOfvw@mail.gmail.com>
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 1:30 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > touches is given merely as examples one might use, then I could see
> > git-switch being prepended to the list rather than entirely replacing
> > git-checkout. For instance:
> >
> >     $ git switch -c foo     <1>
> >     $ git checkout -b foo   <1>
> >     $ git branch foo        <2>
> >     $ git tag foo           <3>
>
> That can invite "do we need to use checkout after doing switch?"
> confusion.  I would understand if it were
>
>         $ git checkout -b foo # or "git switch -c foo" <1>
>
> or something that makes it clear either one, but not both, is used
> there.

That refinement looks good to me.
