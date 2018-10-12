Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066D61F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 03:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJLKbq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 06:31:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37367 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeJLKbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 06:31:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so11448726wmt.2
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EH3IfUP1qBIcmmExf//iWVvuhhsVYQaRyVaQ6CfeRLw=;
        b=eNo88bkf0p38sjJ9ylywlNyLluyzR+2w9TYfN185bYzKkgBUELWe2yn5DJvPTRjvJj
         eDBe1Y8QjLc//uTYYVzHjqFrh8kVs/egoNHi31RPzA50x7Wo9vgk9Rtr3GTbkuH5UTDP
         zQ6kZNSjXcoFw51X/KWQGZ8PWgNFO1S7ypYfi70ejE8mx8ymHYCEa/Vb3afO0kLtcfZh
         +Gog33eh48KeVh5Mx3DJ8YmwRy1yMxchm7I9Lbe3/zytKgAHac8xLjAf9iIF74DiQ7rm
         QtGZSq3NvmmQiWPHsKMeMjkNuQcNck4gUhBKBZC2sVh12V1qgSTaGNWyJFm6QmbzCAIR
         9wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EH3IfUP1qBIcmmExf//iWVvuhhsVYQaRyVaQ6CfeRLw=;
        b=K/lso9rHcBdYhhvdBnUts2vIXkVj+TiNu5YjMjLCfqMhRD2eHZe+ZoedYMCAseaX8p
         gzgmxKbQB970df8PySCXi6Uzd8POWRoollbiebLtSMhe4kRuWVKF/m9fJSjo2Sf5dq7B
         bdUW0ETnWM62PUh+v419o8EbVDLKAkE96V3tkJAAkJS/u66seNYVqGR+Xu9CpSjeVySZ
         NpzGThP/4H/8l6cf/Uj7oYOQqVk+xNs8SaJXMfurRRZV4q724itlBBhH+UNMhTnQk+FW
         bu+GkeIj/cXeXO41MTzJPcAxkjnA8RY9hxo8Rg4PaK5YF1tgu6FTmz9L+42cSrWxi9E8
         FMJQ==
X-Gm-Message-State: ABuFfoh1iYqvaOU7cOiHEsTldeoN6eOVKWmNBP7QrDUC8jFD6hHhregs
        HRmeNiOxQglCoUrJfXY1X8c=
X-Google-Smtp-Source: ACcGV60QysTEbDEdx0bNRB8Mr/QfvfDRF7oCrUfL1cKYTYF1qx6pW7pF4dIv8GDnh/cG65exMbBvnQ==
X-Received: by 2002:a1c:4b15:: with SMTP id y21-v6mr3590481wma.122.1539313292313;
        Thu, 11 Oct 2018 20:01:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 65-v6sm96315wmm.36.2018.10.11.20.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 20:01:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 0/1] contrib: Add script to show uncovered "new" lines
References: <pull.40.v3.git.gitgitgadget@gmail.com>
        <pull.40.v4.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Oct 2018 12:01:30 +0900
In-Reply-To: <pull.40.v4.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Mon, 08 Oct 2018 07:52:08 -0700 (PDT)")
Message-ID: <xmqq5zy7eulx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> CHANGES IN V4: I reduced the blame output using -s which decreases the
> width. I include a summary of the commit authors at the end to help people
> see the lines they wrote. This version is also copied into a build
> definition in the public Git project on Azure Pipelines [1]. I'll use this
> build definition to generate the coverage report after each "What's Cooking"
> email.
>
> [1] https://git.visualstudio.com/git/_build?definitionId=5

Thanks.  Let's move this forward by merging it down to 'next'.
