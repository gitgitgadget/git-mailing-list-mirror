Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7972C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 21:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbfFJViV (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 17:38:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35561 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbfFJViV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 17:38:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so761902wml.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 14:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WguhKx+IwNehgEPDf03AdauZCTqJcY0yNcg+pyQt3LM=;
        b=rHIWrhpM8isH3lGqf86jq5KBiWUrkhRsKx6FBtTRLjqFZCERpS5qWvLHHB8UFNUrYb
         KszIWkfFlpi/oCpSz7oGahSpQdWASXhk0Q0vbVeSkYZozh0yPk1qWMr7B7GCBhU2+h+f
         huM2vtDPAfWlLv+UcbDz3zT+L7yo9JbVGkwPgcboCUueSkXwcIE7tmoLTWjQIVrQg76c
         Ei/pxCYO2zVhDWQoSTboxVqn4xlgpng9r1Fb4FzedrMgyEAcTWw0RYx4YBVn/x6LJoMW
         RlmxYml0Q0Tbj8cF4i0RfCMLUkamky5moJ9qwlUQMSRedgAWzBl2kVcAoXikSar9Rwz0
         WSqg==
X-Gm-Message-State: APjAAAUO5mDqSJSJgkKYJHXY9w78ZVPmYdTiptV7dfQAHKZqzL2A4n4z
        Nhxz5X2O81d/xqnaiLFwAgW9yFj8AFKdmhIW+Xs=
X-Google-Smtp-Source: APXvYqxogF7dHtVGGXmnKKki6c4FevZlED58Ibk6llZfqKreHefE7CNWn8BfgD0fY2j+L0GmsUuN0TA5jwJOSv5XIMk=
X-Received: by 2002:a05:600c:218d:: with SMTP id e13mr15168371wme.101.1560202699375;
 Mon, 10 Jun 2019 14:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <CAPig+cTZFL=GzM_-S2JMWWxRU7poJ87f3a9ZcFjjUe1T131eEQ@mail.gmail.com> <xmqq36khm8rj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36khm8rj.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Jun 2019 17:38:08 -0400
Message-ID: <CAPig+cQiDjMd5gG+JPE-7gxWxVYpUGAHGm39Z1kXh4WsEiMZkQ@mail.gmail.com>
Subject: Re: [PATCH] documentation: add tutorial for revision walking
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 5:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +#include <stdio.h>
> >> +#include "builtin.h"
> >
> > Git source files must always include cache.h or git-compat-util.h (or,
> > for builtins, builtin.h) as the very first header since those headers
> > take care of differences which might crop up as problems with system
> > headers on various platforms. System headers are included after Git
> > headers. So, stdio.h should be included after builtin.h. In this case,
>
> Actually the idea is that platform agnostic part of the codebase
> should not have to include _any_ system header themselves; instead,
> including git-compat-util.h should take care of the system header
> files *including* the funky ordering requirements some platforms may
> have.  So, we'd want to go stronger than "should be included after";
> it shouldn't have to be included or our git-compat-util.h is wrong.

Thanks for clarifying that.
