Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A101F453
	for <e@80x24.org>; Thu, 18 Oct 2018 05:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJRNXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 09:23:05 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:34041 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeJRNXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 09:23:05 -0400
Received: by mail-wm1-f46.google.com with SMTP id z25-v6so1002411wmf.1
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 22:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/c53UxqTgylQwhZ6sRG/R+5KxJnbF19O6rSOvz6AHEU=;
        b=U0mVmMlIZ5MQruJwUUXoVZRdbzim6uj3J3IOtysY0dwh1u99kKtpBhECrmavsw5PBZ
         wxjUnYT1ApWJRaPURslVwl496ya30U8GXKGqgV56VBdnSeRijAJ1nu8apMDp7jT1P9JN
         4ITKFPSMA+iuDCSIQJIXjWqTfVSUEwa9b+moSYcxmUbzQKrubQ2Zgy7xP/suurngDn7k
         7e827iNY3zSIXBs/IJrv5z7xbGPjIouvT2I6J/lYAwE4zxV6wspGS0iDivPmtIej7K+r
         j67YT8DEcTonOQi2gNVcyTG4Bu/OIXSH12zM/8/QsmXWC2Hp3Ndt9HgQSpWDOgTFyT4x
         pVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/c53UxqTgylQwhZ6sRG/R+5KxJnbF19O6rSOvz6AHEU=;
        b=kan+OUkKHbIRv1sJVqTErWlb5uCoyJ43YugPKeFp3Z2ZRFg4/P5ytIF14WX8zJae94
         nQlr8b8FyRY7oMoAv0EcAxNgbLGAY3v4K0lF77lwVr4G9VUCoT4Vdo6TMqDxzQMCQQ3I
         XonhBLm9tyc3wE9tM6O4SBmgmhRU+tWjdCcdODpCVpOhWGOEDmvtpd/ID+Z7a/E1CmQg
         KoxLASQtrk03WNV+kA+XMfVAl1FdBHaPrwp+d6nRl74EJN2/si2PrNYfbinZSIcdnUQw
         /3bwFn5nnxiYUo1Shjngjwbac+VsruTD6bjBUgV1ZEVB6GF9HBULWkAlxSrslHKtHIAU
         LbAQ==
X-Gm-Message-State: ABuFfoiShrCa1kMpwL6QaP6Syx4rYe3iPzdGSvjmht+I6Oqp5/VIUtx5
        6whtsxo2hmibIJM/REte6Ms=
X-Google-Smtp-Source: ACcGV60WN/0p3tUfzNW7QsFXQbzZGvqUo7zEmkKWqOox5rXSIpJ9zN0IzR9m7ugipQe0cjoSonM5jQ==
X-Received: by 2002:a1c:ee9d:: with SMTP id j29-v6mr6060451wmi.52.1539840230963;
        Wed, 17 Oct 2018 22:23:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w192-v6sm3067151wmf.33.2018.10.17.22.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 22:23:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] t6501: use --quiet when testing gc stderr
References: <pull.50.git.gitgitgadget@gmail.com>
        <ab118e60e9988076edf43d0ed8c1924e6569a9d0.1539808389.git.gitgitgadget@gmail.com>
Date:   Thu, 18 Oct 2018 14:23:49 +0900
In-Reply-To: <ab118e60e9988076edf43d0ed8c1924e6569a9d0.1539808389.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 17 Oct 2018
        13:33:12 -0700 (PDT)")
Message-ID: <xmqq1s8nvndm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The test script t6501-freshen-objects.sh has some tests that care
> if 'git gc' has any output to stderr. This is intended to say that
> no warnings occurred related to broken links. However, when we
> have operations that output progress (like writing the commit-graph)
> this causes the test to fail.

I see that the descriptor #2 is redirected into a regular file.  Why
should we be writing the progress indicator in that case in the
first place?  Shoudln't we be doing the usual "are we showing this
to an interactive terminal?" test?
