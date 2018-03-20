Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC15D1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 06:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCTGkD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 02:40:03 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41342 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeCTGkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 02:40:02 -0400
Received: by mail-qt0-f193.google.com with SMTP id j4so496272qth.8
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PGBuVCKCw2lBtdRZ58wxLMQj/jYoHq5y8osEgP71fGI=;
        b=JOdtzJacFk8EDJPLZ3yJxoqWPbagUI3HNI/G6wlIhqx/Fp9hUjyt/kk4loXLefaivW
         ZXzqTAQHte/txWeNj10qZVclHCrZwHiIdb3CtKC4D4692iSC87ikScW8AyyoU49gA2hL
         cqN+ysGxRORi6NuOjw02FgzC6zZ+Oypuh48z+UF5fdMI7+we3PAcV6dLOxdAm4VXNp7U
         mgyITvPHNs9S3SuZbKUK/IoSu9uvBuvd3iktLyj7g3iWtopE7LyfhEzIWCqDy+l7/IDi
         d10JwqF+neMmqoJalMBRv4GdDEXwaLKFPOw0Nd7jxuh0BZKnS5QGoUu+2+TYItTqaCrv
         dBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PGBuVCKCw2lBtdRZ58wxLMQj/jYoHq5y8osEgP71fGI=;
        b=sodE0WD4P9zZhMLpWkXsKfxkZBcpNgh+m5enESGreASOmPLfrGJO1r+Utvp5C2sfMH
         SzXrdj/LUawvCW5nLdXrGSJMp845eGJm2ZEYAw+6n1dnr4G50kXGgKHqjPxAzLg1BTjA
         SK0Xgvfs43JaIJ4RpbThfOYL/lLQx6EPocr2fj6NKXocctf4W4vpc3HHFaa0atnHiaPB
         wMkhdnucpniUo60jJWBYVxOGQ4CbBhDqEIu/WR/NFrcPNC9/vD7ekbNTScF17rzNr8hb
         zjBfgABAnQzebxczpIrAuec6aT4eWnOjGFd5rh2esdbguXy3g+1xznyze36kdOl8SEw4
         skaQ==
X-Gm-Message-State: AElRT7GVnO8Rv2eCdCs1Iow/f14aXajb+rwomwRZbJHS+a3QG+KD4dOq
        lefvhN4AuWcn1ePjScDPQaeqPsoK8dnVjYxbrhU=
X-Google-Smtp-Source: AG47ELvjFKRS7tY4FzYEUz5WOcc8R+wSdmEwBe9JN65npXW5WyFX+40CV1xUiKXbTbPQPDDD7YZh4yUkZKCLxg++qG8=
X-Received: by 10.200.50.174 with SMTP id z43mr21603953qta.250.1521528001775;
 Mon, 19 Mar 2018 23:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Mon, 19 Mar 2018 23:40:01 -0700 (PDT)
In-Reply-To: <20180317222219.4940-3-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com> <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-3-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 02:40:01 -0400
X-Google-Sender-Auth: CbSaTk9qSa2pUXplY_9CdyL_Inw
Message-ID: <CAPig+cSaA+N0jWfbWccH45kVzz-0g4hTkg-KwgwTTTPL8pixuw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] worktree: be clearer when "add" dwim-ery kicks in
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently there is no indication in the "git worktree add" output that
> a new branch was created.  This would be especially useful information
> in the case where the dwim of "git worktree add <path>" kicks in, as the
> user didn't explicitly ask for a new branch, but we create one from
> them.
>
> Print some additional output showing that a branch was created and the
> branch name to help the user.

Good idea.

> This will also be useful in the next commit, which introduces a new kind
> of dwim-ery of checking out the branch if it exists instead of refusing
> to create a new worktree in that case, and where it's nice to tell the
> user which kind of dwim-ery kicked in.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
