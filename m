Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1D991F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeFUVS1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:18:27 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35780 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932753AbeFUVS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:18:26 -0400
Received: by mail-yb0-f194.google.com with SMTP id a16-v6so1778108ybm.2
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92d/5vVO3Higz9HyoJGVFPEYfj1Y+2gruW5zSxhSdk4=;
        b=fVYPZTnpglUM8+d8XamTjX6nXXMaP0sddCvjV1dRVgnSjfFV1EI+QMBgGLBUp8FIkN
         k2qSGlacj6KUSQZXD7Jb8hJwTiVXQbHM6mOGXfJ+voW/p/6EwI5fcveIUx2/7AH+0Q8E
         Q9/5UXZCUqLmi9IZc778gjOaXjAI7lvNhvos0740S1BLltLO/ltHGv9k+PSiREeZPsvC
         4Cgw1kAzbrsh+3YcKfo6BaKHa5r+ow4zlEE7eS3v5wZUxs65xhjFYOEBn+fWOn6Vy8I8
         fdQS6N7F++w/M6Ab6mqJQVMcgc6zEfDeW4F4Z/ln64HDqCwIA4UIq1byYnCzLdQb2d9u
         BBCw==
X-Gm-Message-State: APt69E1JB0G8G0fQYnHbHMnuskC8azuE6LM4Ek1r1jvCV5iFFefnbCXQ
        RnajapZ4aVLcycqCUrNopNjQ0COpBffsTPX6rM7noA==
X-Google-Smtp-Source: ADUXVKIIHWua2d4ATQF4tFQPecxtTYJNJkXovhv85Ru9Z4Yw92DLqjQ+7dNgdHvTsKOKv/GrDxFkH3bHqNKqBESAWp4=
X-Received: by 2002:a25:a224:: with SMTP id b33-v6mr937961ybi.295.1529615905279;
 Thu, 21 Jun 2018 14:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com>
 <20180621150023.23533-4-newren@gmail.com> <xmqqvaabsy6y.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqvaabsy6y.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Jun 2018 17:18:13 -0400
Message-ID: <CAPig+cSVJk_mf8UeOoXysMZfP5c-MFBqa3H-w+Wns6_oZ8u5Ug@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] t3422: new testcases for checking when
 incompatible options passed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 4:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
> > +     # This is indented with HT SP HT.
> > +     echo "          foo();" >>foo &&
>
> I often wonder, whenever I see a need for a comment like this, if
> saying the same thing in code to make it visible is cleaner and less
> error prone way to do so, i.e. e.g.
>
>         echo "_ _foo();" | tr "_" "\011" >>foo &&

Or use q_to_tab() from test-lib-functions.h:

    echo "q qfoo();" | q_to_tab
