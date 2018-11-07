Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31511F453
	for <e@80x24.org>; Wed,  7 Nov 2018 01:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388837AbeKGLAV (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 06:00:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36140 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeKGLAV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 06:00:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so14151598wmf.1
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 17:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WhTOOdgD03hfm+l3uomSNMyH5sJxvtfLqr4TjqCVjus=;
        b=XgDursajpoc6AMkd4ypzfByMZOR8QUeYbnwGxTkt7JK+DUlz53Sr/RRF5/achzzFit
         /gZ5P/DGgyEcidES68gpcjKNasf7N/qfWb14ZWquY8mtyDD+5cyrG7yAPUqRsqLJwuP6
         YrzRjeSCIUufOap0bxhUqBkwEgmNJteRiDH2KlRJ5p1vhsAiVRZYWrouHmQJdgQb2rKt
         HgQhGb7EkDobFOTGHmp+jfRsysIYAR+8rj0PQi9euP5rEc7h3F+Jnh9vvelEYh/5VSQC
         rnmS4kRrG3QoqfSVhC1VRYdtDK70RNygZHERYRiOhlNRWtQLqTDuVRap1edHlnTuIOPt
         XJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WhTOOdgD03hfm+l3uomSNMyH5sJxvtfLqr4TjqCVjus=;
        b=VWWx9nN+Or7/3C/xlFCDiJXxE0W2jFC4EUJMwriibFJaJu/A6JhHmnB4o0x6SH9SmI
         DyH2h4KgdkMN/Lk0p61hgq7XuLkqlLMwR9xQLbtsRdPcHkS8+qR4B8FY2fTAYf89UPir
         YjfcKgTmTdnnKDK+KXol/J29j8CXJ2JMdNJK7RcEWF8w9h04RC807ukxcci9vHZa3FeR
         iG5NGVgvbXbUmUyS0GAV4Lv4FsPYi0mwFEs15x7++V+hNqnSLCcG8ZT0SBal+G9rheUA
         PqFwE3xFScxwxTgEnSV7VRqblTIIBTgcEy5rSnsPOGVCtdZQqmhFbKPoV0GVrfpCSGFO
         rgUA==
X-Gm-Message-State: AGRZ1gId8Ywfv6+toofk5e0eMS6p3aEKgVXJxKu2LOtJ9v9fm91g4PU5
        9M+vGk4s2EDzXwTfF8sLviE=
X-Google-Smtp-Source: AJdET5diA1GO0/eqZtNRLs6xXDYVHEsVINQZ5PYWz8IUhfJ8nGf75/tp4sV4eLnOWEKE7SdyujeWYA==
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr188636wma.91.1541554332403;
        Tue, 06 Nov 2018 17:32:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l186-v6sm3816601wma.13.2018.11.06.17.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 17:32:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Windows: force-recompile git.res for differing architectures
References: <pull.67.git.gitgitgadget@gmail.com>
        <87794514ef3a83f95d81f89287b81aeed5c92296.1541516148.git.gitgitgadget@gmail.com>
        <c4e3790e-4c41-0d15-38d9-79fa288fb9b3@kdbg.org>
Date:   Wed, 07 Nov 2018 10:32:10 +0900
In-Reply-To: <c4e3790e-4c41-0d15-38d9-79fa288fb9b3@kdbg.org> (Johannes Sixt's
        message of "Tue, 6 Nov 2018 22:44:07 +0100")
Message-ID: <xmqqk1lpd65h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 06.11.18 um 15:55 schrieb Johannes Schindelin via GitGitGadget:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> When git.rc is compiled into git.res, the result is actually dependent
>> on the architecture. That is, you cannot simply link a 32-bit git.res
>> into a 64-bit git.exe.
>>
>> Therefore, to allow 32-bit and 64-bit builds in the same directory, we
>> let git.res depend on GIT-PREFIX so that it gets recompiled when
>> compiling for a different architecture (this works because the exec path
>> changes based on the architecture: /mingw32/libexec/git-core for 32-bit
>> and /mingw64/libexec/git-core for 64-bit).
>
> On Linux, when I recompile for a different architecture, CFLAGS would
> change, so I would have thought that GIT-CFLAGS were the natural
> choice for a dependency. Don't they change in this case on Windows,
> too?

Depending on GIT-CFLAGS would have a better chance of being safe, I
guess, even though it can at times be overly safe, than GIT-PREFIX,
I suspect.  As a single user target in Makefile, which is only used
by Dscho, who intends to stick to /mingw(32|64)/ convention til the
end of time, I think the posted patch is OK, though.

