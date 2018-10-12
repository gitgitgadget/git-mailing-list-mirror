Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B901F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 14:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeJLVeX (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:34:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33330 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeJLVeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:34:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id e4-v6so13582723wrs.0
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rrnrvDeom/IT8xJxfU49h6Bq9oKZtSiAy/qLVG04B0w=;
        b=uLmWjGQF7Yozj+PK5YXeb/qMct/FryAZli/4V/aodpmOZGkkyYdKasw9RiVIFJJAO7
         hQiywSFsWVS0ZRfJCFt7mXwe+CgCwKYhvSOvWyb8j+BbJ098kaWVjVes8el/CtyLoltx
         2u0uNzsywv4lVGuGeWI4P3oUcHETsBOhHdzlW6wezSUhI6XUrtgmI8dozqXooUVdnMhG
         DDi+8z6SOqVjTGgJT4rjrA944+ZCcdcnPr6dku0qA8gncUPfn5HJeZkGwazCAPRk+QM4
         yYJ2yz0ov282g7c0cUi1FFGr8THTrkGd84uiOE67N/eQZ1cBZyfcaFiT6zD0PjwZNLUj
         gb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rrnrvDeom/IT8xJxfU49h6Bq9oKZtSiAy/qLVG04B0w=;
        b=RkN71dNFsUQqtSX7nj5Suzci48lRJbYiMlmxeNTyq7aQYYxJS8uk4xx7cnQYQ1Sd8U
         ssugNIxNS/LO9Hnhb3CFXleACLFsnA+5DBDHZQBoFyw130+kKFJ0Rnl08bnoW8LrvWC4
         1YeSPgNmz3eUwzfR5vq9iE+kQWTicXbAJ/Dxc2IMBG44J7vTP8reYuzN51bJxVsd56nJ
         l1lbZhzLqk6TINapnJZRLdGhSYY/fwJvAoir02uHqPLDPjEfmbaoYRHJcb4oE2wAvPtP
         tr3NCFtFRv8sLpXi145cxZ92YRHhnoXtRiNVK/yUVksZh5NGk2zdwN0cVOxmbQX3O3Us
         oPvg==
X-Gm-Message-State: ABuFfogcwB2+gYIkYlwKHNg+eOSvyOUEBMSznZLjTHXB+o6riAXZA3JE
        TJbMtLX6Av4opPd1fj8q0igIiQq+4P0=
X-Google-Smtp-Source: ACcGV63zTKeGXteXIqDX8m144KnJTZKbhGDBliMaWEotsVnCSMFH9xLE2j9Sawf0+NhMhu+rhmlBSw==
X-Received: by 2002:adf:d082:: with SMTP id y2-v6mr5321734wrh.314.1539352906087;
        Fri, 12 Oct 2018 07:01:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n15-v6sm782449wrm.27.2018.10.12.07.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 07:01:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v3 0/2] rebase -i: introduce the 'break' command
References: <pull.43.v2.git.gitgitgadget@gmail.com>
        <pull.43.v3.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Oct 2018 23:01:43 +0900
In-Reply-To: <pull.43.v3.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Fri, 12 Oct 2018 06:14:23 -0700 (PDT)")
Message-ID: <xmqqva679sc8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch introduces that, based on ag/rebase-i-in-c.
>
> Changes since v2:
>
>  * Fixed two typos.
>  * When interrupting the rebase, break now outputs a message.

I was about to merge the whole collection of topics to 'next', but
this came to stop me just in time.

The typofixes are appreciated of course, and look trivially correct.

I find that the if() condition that does too many side-effect-full
operations in stopped-at-head shows bad taste.  It is still short
enough to understand what each step is trying to do, but would
encourage others who later may touch the code to make it even more
complex.

But it is a short and isolated static helper function, so I won't
complain too loudly.

Will replace and requeue.

Thanks.
