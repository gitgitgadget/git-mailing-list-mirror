Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8FD1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932435AbeDBUaD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:30:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33889 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756678AbeDBUaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:30:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id w2so7929779wmw.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PaB8za4tdkqehYYTPr1iN/RwhgHc+VFIJdtTYDFSl6Y=;
        b=MCwpZCPdbgNJAfJ2moNicv3dSCp5lsSq7dQQLo85/4cc73CsaXkDzuA9zw5AdQ23ys
         ft/+IztxAiYoZvxtOzDTWvJ8FAdrVeRKJa5xVRxOp2E33xUOjSOPh3pKyLHgrtfkIEpU
         RQ2jyhPnr1o0e8GYrGwPQ2GmqcF4p0nc18gAgI0EFHZyIDsdp3KRl4u8peHOjyedUdNe
         Qw/0yKgf1readSgIMdnZIxfhZbzwZLGfzNzD0NwNPS5ubZAR8r9QXsY1k6crz+odWSI9
         iAXR5D9SEQVL6468tuTno95846z7bawry9NraJylhfObUzD+A/iLdS5SN9Z9PqawYbdu
         0P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PaB8za4tdkqehYYTPr1iN/RwhgHc+VFIJdtTYDFSl6Y=;
        b=E9MwR9wNZLcVeFy3pkiF20M9SasosLl4fU6INZpRGqS5L/t8yuPjVoQGtwNsangWPq
         ZwQmpkVI3T1pbFfzy1XeBsOsc0SCwj3px+tzKhcSEU/xM9cJquqUVZQut3MG3xbWuGwG
         lYn2ViQZPUZNoCqBxHjDvUZE/pS/1lcGi6VPgxcsPT+++1PypxtmKGYgS8UFHKv7FGYf
         28reD2s4UTOzW/HlvBfx3pLAzA7YHvWc8YojTTFlDdVMYOK+Wa5xw5gikbOK248TRree
         xdfC6aDRTY4drYLmzflMofIXrvjT04YUIaS7vcLBIlgD7YKC91/L14UWezHu/6jwLeVW
         sbZA==
X-Gm-Message-State: AElRT7GcfOQxEowdYi5DZ8xa7Eko9/5e1D5uKikUql1jL1AyqewsSUTG
        EyIxp0nJBKH/LLgEGvfs/zQ=
X-Google-Smtp-Source: AIpwx49vPvwF78lAUEWSRbONa6VSe2fA1uyLWvPL5csoccBCwFPumsGs+7yAGfkKk2dWCTJn1v7sgg==
X-Received: by 10.28.63.148 with SMTP id m142mr2001479wma.153.1522700998757;
        Mon, 02 Apr 2018 13:29:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z12sm1380652wrb.29.2018.04.02.13.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 13:29:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v6 2/6] reset: introduce show-new-head-line option
References: <20180325134947.25828-1-t.gummerer@gmail.com>
        <20180331151804.30380-1-t.gummerer@gmail.com>
        <20180331151804.30380-3-t.gummerer@gmail.com>
Date:   Mon, 02 Apr 2018 13:29:56 -0700
In-Reply-To: <20180331151804.30380-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 31 Mar 2018 16:18:00 +0100")
Message-ID: <xmqqwoxpxsfv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Introduce a new --show-new-head-line command line option, that
> determines whether the "HEAD is now at ..." message is printed or not.
> It is enabled by default to preserve the current behaviour.
>
> It will be used in a subsequent commit to disable printing the "HEAD is
> now at ..." line in 'git worktree add', so it can be replaced with a
> custom one, that explains the behaviour better.
>
> We cannot just pass the --quite flag from 'git worktree add', as that
> would also hide progress output when checking out large working trees,
> which is undesirable.
>
> As this option is only for internal use, which we probably don't want
> to advertise to our users, at least until there's a need for it, make
> it a hidden flag.

As a temporary hack, adding something like this may be OK, but in
the longer run, I think we should (at least) consider refactoring
"reset --hard" codepath to a freestanding and silent helper function
so that both cmd_reset() and add_worktree() can call it and report
the outcome in their own phrasing.

And I support the decision not to advertise this as a new feature or
an option by implementing it as hidden-bool.

This is completely offtopic tangent, but I wonder how hidden-bool or
hidden options[] element in general interacts with the recent
addition of helping command line completion.  Are we already doing
the right thing?
