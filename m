Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99954200B9
	for <e@80x24.org>; Fri,  4 May 2018 05:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbeEDFYZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 01:24:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52011 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeEDFYY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 01:24:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4so2118072wme.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 22:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6YmI/NakQ7tgK+0FPhlHT5QYuoucTIzfqiWljjiWPA0=;
        b=HSblwycTEfrCyg2W9h5q9JcYmv3cUYl5C4/1ofKVDSp8U2ooUXFyV1eZfQP/l54BR0
         zhyr3ypNe9mseXBa1rwtIa8/cI1V4HWFYrwHJHeJUwCmBBtvC1fwf2arHSkSyUdokVEl
         nK4ryf4iiBNS8iEtFAU1pmP2UYgowLkpzakZs++I9J9pJhcs2N3IxckVOFs90e+6grGS
         4BzboJhatsFtDkMYAovfjiescnQlNn9Uc5O0Q3XyA4Fpr+7axOGuAJNM//T18zhve2b9
         2kF0eZz0dbKBXN0EPb328SMEV1N7FEaYJcZXB2E+RWAR1NYlAe2ultbIjctO7WLLw5J7
         7olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6YmI/NakQ7tgK+0FPhlHT5QYuoucTIzfqiWljjiWPA0=;
        b=IQirVx5bwIHrJNx3t1uA3e/uYPym4bTyQfzR9BURPTkK1Jc0wWFQSLcsFDYG5C5xxn
         mvstwSDvmBut/2RmbjusFgVgO0e5Rfa4L0TfcJAzkzSwJUDsFRo/ZZnom/9D3MQeU9qx
         yeGS/OrET0H8gejp2Ugp7u4P/uctzYxWMrcbN6XQk91tCPFpH1+JJaxRALwbmpgZcJN4
         hLTUm6Akw21LqH5rUC7tVaHdRNEGfSsFbXjRtxTZb5cTTC1Gde2bqFU7N81tJDTeqakI
         chGuCbfyj9LClKgX4/w/WxRy8L8A9NrLnR5QANjjfUEi1DnzxUSDCJ8PYzRrvVtTocyF
         dwHw==
X-Gm-Message-State: ALQs6tDS0Is/8cVd80O9rRZ+63GfoQvXBtnNVx1F5QrbkIJH2SbyELq9
        XCYQzguN8rLdfBvDUQNXH+Y=
X-Google-Smtp-Source: AB8JxZqV0wDnBYeN1S6NuNbrNjLOjrfDnQ666XjO7zjrXKoruP7EWVplEaZ11+3MCJSWEPx0WQOzAw==
X-Received: by 10.28.227.132 with SMTP id a126mr18525925wmh.93.1525411463308;
        Thu, 03 May 2018 22:24:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 194-v6sm1695771wml.20.2018.05.03.22.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 22:24:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Date:   Fri, 04 May 2018 14:24:22 +0900
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 3 May 2018 17:30:20 +0200")
Message-ID: <xmqq1sest2m1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Johannes Schindelin (17):
>   Add a function to solve least-cost assignment problems
>   Add a new builtin: branch-diff
>   branch-diff: first rudimentary implementation
>   branch-diff: improve the order of the shown commits
>   branch-diff: also show the diff between patches
>   branch-diff: right-trim commit messages
>   branch-diff: indent the diffs just like tbdiff
>   branch-diff: suppress the diff headers
>   branch-diff: adjust the output of the commit pairs
>   branch-diff: do not show "function names" in hunk headers
>   branch-diff: use color for the commit pairs
>   color: provide inverted colors, too
>   diff: add an internal option to dual-color diffs of diffs
>   branch-diff: offer to dual-color the diffs
>   branch-diff --dual-color: work around bogus white-space warning
>   branch-diff: add a man page
>   completion: support branch-diff
>
> Thomas Rast (1):
>   branch-diff: add tests

Lovely.  

I often have to criticize a series whose later half consists of many
follow-up patches with "don't do 'oops, the previous was wrong'",
but the follow-up patches in this series are not such corrections.
The organization of the series to outline the basic and core idea
first in the minimum form and then to build on it to improve an
aspect of the command one step at a time is very helpful to guide
the readers where the author of the series wants them to go.
