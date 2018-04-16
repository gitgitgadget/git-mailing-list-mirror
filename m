Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29A01F404
	for <e@80x24.org>; Mon, 16 Apr 2018 02:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDPCJu (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 22:09:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47056 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeDPCJt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 22:09:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id d1so21551418wrj.13
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WHSzMqf7suLFF5JXSKv3jl0cYLt7tSlSXAMjeJsWhPM=;
        b=T+aGaaG9EWv62F4hFmbhBgcramedUzTbCwu51xIS3zjuhSoCF0x2KBU4lYfURQyQVs
         x7tRPS/0SBpeJdqNn4KNtNTgmd/vWOhFQpVUmI6zT8AH6XsoX1VQJF9VZtdAmZnnf+4g
         QLda9R2VXLaLdIFM7H2nr7BrbGCTfnyEZu/OGUoRHOFJASFpxSzo9MUutyixdQwApsjW
         NwhfVBfHGDac/eXdtCq9MxAJ1CHjUMVpePFiU0KTCY0Be9Bb32G7ILs2TzxWE+YDRzMb
         /8J/HnHi4XLsilJXGBpazVafArAPcUMJ//QCm65ykRowT0dLq9iMujL768CSTf8K2ctn
         yFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WHSzMqf7suLFF5JXSKv3jl0cYLt7tSlSXAMjeJsWhPM=;
        b=uRU0WUYQosjEt677+5Lab+ASYJVyRlulfR+U0XTYj5XALsioefCPYb5EhQ6LUXCO9d
         Und0I9/EL4E8P2Yt2Cn2NFh5INKPRa0rpd7bSGtU8rncsIwl4qZ19c2TgWe6GTq27rcC
         bTL4KZGZsNlR7EQ6YokU99I8lmNcv3lSzOMfFrVH/SSXbXm5RT8hLtRhp6RN9NaRqSNS
         i4bTHz23RmRqyBXSyCJSbgIIrXTalmUZGuWjlWYqayo9RBR1nwiulAmi3vDDVIzd7LzG
         iFl9CeVtntu1MzUfiMfsu5cARwg1UZbHIWcDVCLGyRGmkBbGLsioZCtGMALeBo4jy+7+
         mqyw==
X-Gm-Message-State: ALQs6tAnB3A2aYWXPrh9d+3ag1zJ5vZLVS3jaDnqb1kMC3snaZaDmr08
        +xem4qJW7bmq4Iz8s4YbJ5o=
X-Google-Smtp-Source: AIpwx4/BrRrDIAFce6Hi1pwYezbnQU6EjQ79iQ5bkmkFxHsrjSpJzXdj9vjzuxi9Hw77Fgb43tv+jg==
X-Received: by 10.223.225.71 with SMTP id f7mr8362685wri.172.1523844588285;
        Sun, 15 Apr 2018 19:09:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b97sm10140979wrd.64.2018.04.15.19.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 19:09:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 2/4] worktree: improve message when creating a new worktree
References: <20180331151804.30380-1-t.gummerer@gmail.com>
        <20180415202917.4360-1-t.gummerer@gmail.com>
        <20180415202917.4360-3-t.gummerer@gmail.com>
Date:   Mon, 16 Apr 2018 11:09:46 +0900
In-Reply-To: <20180415202917.4360-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 15 Apr 2018 21:29:15 +0100")
Message-ID: <xmqq604rzytx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently 'git worktree add' produces output like the following:
>
>     Preparing ../foo (identifier foo)
>     HEAD is now at 26da330922 <title>
>
> The '../foo' is the path where the worktree is created, which the user
> has just given on the command line.  The identifier is an internal
> implementation detail, which is not particularly relevant for the user
> and indeed isn't mentioned explicitly anywhere in the man page.

OK.  Maybe there once was a place or two that took the identifier as
an input to name a specific worktree to work on (perhaps "prune"?),
but if we no longer do that (which makes sense, as we should be able
to uniquely identify a worktree by the path to it), then it makes
perfect sense to prevent it from appearing in the UI.

> Instead of this message, print a message that gives the user a bit more
> detail of what exactly 'git worktree' is doing.  There are various dwim
> modes which are perform some magic under the hood, which should be

s/are perform/perform/, I think (no need to reroll, only to fix this).

> Additionally currently the "Preparing ..." line is printed to stderr,
> while the "HEAD is now at ..." line is printed to stdout by 'git reset
> --hard', which is used internally by 'git worktree add'.  Fix this
> inconsistency by printing the "Preparing ..." message to stdout as
> well.  As "Preparing ..." is not an error, stdout also seems like the
> more appropriate output stream.

I think it is a bug for reset to give this kind of informational
message to the standard output stream.  A rule of thumb I use is "is
this something that a user who wants quiet operation would wish to
squelch with --quiet option?" and if the answer is yes, it should go
to the standard error output, so info and progress should go to the
standard output in general.

But I am OK to unify to the standard output with this patch.  We may
want to come back and correct _both_ this new message and what reset
says, but that is outside the scope of this topic.

Thanks.
