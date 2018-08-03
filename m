Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE1E1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 23:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbeHDBkn (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 21:40:43 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34362 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHDBkn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 21:40:43 -0400
Received: by mail-yw1-f67.google.com with SMTP id j68-v6so1599443ywg.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 16:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2WTX20tuw6lCSSMKBMmuuT0QRa/xcqjjUVhgldAZfA=;
        b=ZOYqbz5j/T1FMNgRFURz5eeEvmk0zjmBZ9GhZmkTe3zqz4eitt1YDrMS4WswXPhtpK
         I9x2yTeV8W9aO/hhusjwvmNwKUY205HQ0tCUCt/1XJFP4NV4OYUJT457WtBDmNeje2d1
         ZYYaqUSHBBz9YlVdPi+9mnJhn3MMwUGJHp77x3HSqQz8wPCJfJysOvt5hkc1L+TGZKuP
         oNv8tW15CrvxE3J9U1R+LCgZZxMitsi8kbtwPvj1zVWXJ71jnIEGQqE4k4D6segtsdjN
         cZZMCjQQUECRJphs82DPTlKkW+Er7gvXpSkebh/vvsRInV57kanCuy5zi3qAS+x2J2jT
         xECw==
X-Gm-Message-State: AOUpUlFIU9HionVpT//Q+aBGQbwBMuwJ90jQ3gpvgTY2M7+NPqB+mMfQ
        2LKyMCSZQXqhOCWncAAopFQxewxsUTgd1lKt2zNrILesHcg=
X-Google-Smtp-Source: AAOMgpdSKU53m58zl/4dadqcZIkC+4+u9kxR02fe5SQ8CrzFzLLePj5iQ0Gb8gXdSKKOikczKG+TlujIoldtODJ9P68=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr3344528ywk.418.1533339737183;
 Fri, 03 Aug 2018 16:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180803231407.10662-1-newren@gmail.com> <CAPig+cR75Q7HDipttU9dqtNjf23SYNJ98o=0-=JFtPgMMjFxHA@mail.gmail.com>
In-Reply-To: <CAPig+cR75Q7HDipttU9dqtNjf23SYNJ98o=0-=JFtPgMMjFxHA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 19:42:05 -0400
Message-ID: <CAPig+cRWxns2t60G5gnQwMGuWyN8BLHq_CLwHznDy=g9haVAMg@mail.gmail.com>
Subject: Re: [PATCH] t7406: Make a test_must_fail call fail for the right reason
To:     Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 7:40 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>     git diff --raw >out &&
>     ! grep "<literal-tab>" out &&


> (where <literal-tab> is a literal TAB)
>
> Since this script has a number of instances of Git commands upstream
> pipes, it may not make sense to fix just this one. So, either a
> preparatory cleanup patch could fix them all at once, and then this
> patch could come on top or, if you don't want to fix all the pipe
> cases, you could do this instead:
>
>     ! git diff --raw | grep "<literal-tab>" &&

Of course, I mean "<literal-tab>submodule".
