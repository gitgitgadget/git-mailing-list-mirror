Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4F01F453
	for <e@80x24.org>; Tue, 23 Oct 2018 04:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJWNKN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 09:10:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32813 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeJWNKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 09:10:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so77891wrn.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 21:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2xQdyFgiFLNc8t7DKjzA8vtb1oG0PxM7/W5ZpBhecvQ=;
        b=mYfbr2Z5SzhKIytOxEH8ActB9Zm1WQG4+d261Etz2nU7OR47QzXEZN0HPZ8mgCoK/G
         /tmmlFmSnFKMi02PslKpZVGYYvCiDhL1GROn07S/L73JIFswZTq9a0fxmVDg/QZrEbXQ
         RHbwhNrXijpfdd4TGi0aJiK9d70FKweoSlAkda5mOUy2RWUsCwfl9OC3QNyA5q0uaTXm
         1eO6ooTkD4R/bkXuxkVMtTMhO+D3RjU7SEm3MdO1QvSd+pQEcjhzQ5Q4Fju6nCuO6R2X
         fF9mhSpRNeBA9V8unPPmedeYQnFEjyH+IUKmXHcCsr5h9PkGJ7EjZSy1JpAtToXaP6DK
         0ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2xQdyFgiFLNc8t7DKjzA8vtb1oG0PxM7/W5ZpBhecvQ=;
        b=Q8rI1VxjKPjEAdAxEBhehfvpge6S/tIIw9JHZ/JMQlh2u72rREK9PCz/+ce3RlDLZB
         BG2VIPO21SyaXwa89Z/2u+jS3VTz8a4u33VeshqoZe4U7s6JOlaEOl66xlKWnvQpj0Hw
         nKkdBTWD44hOLuGKy6tgop2WXSjbVNJqfJ2bBkXSyFgwg7maHeSwB++feTGYLLEMwqC9
         bIgg+qoOYTVkZiUrZzsODeYPBVCv55mJSETXqDX6ZkztT2tYb26DxkkP1gvI8p1HKNew
         Libg+QtJAv/zxnO/GgVq4L4Rp79DjYO2psRJK7eQT7NTqEzmyB+GQdplytjB0mSknCgc
         zuAA==
X-Gm-Message-State: ABuFfog6+JHLu7yPUbT5ciSRC9axZ7sEG/4v55qZ3RnP+6nAEDFqYlSW
        0XHQ3yYvL/Q1fzJydRLfZ58=
X-Google-Smtp-Source: ACcGV605m2+IQxGJYFoHCsdU5VVj5Wq1ZzLxzmPoXlO+na5/bn1w2geZSHBOkO1GhFYlhpL7WB7QLA==
X-Received: by 2002:a5d:480b:: with SMTP id l11-v6mr50680013wrq.28.1540270112512;
        Mon, 22 Oct 2018 21:48:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b5-v6sm74699wrs.34.2018.10.22.21.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 21:48:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, peff@peff.net,
        jonathantanmy@google.com, jeffhost@microsoft.com,
        matvore@comcast.net
Subject: Re: [RFC 0/2] explicitly support or not support --exclude-promisor-objects
References: <cover.1540256910.git.matvore@google.com>
Date:   Tue, 23 Oct 2018 13:48:30 +0900
In-Reply-To: <cover.1540256910.git.matvore@google.com> (Matthew DeVore's
        message of "Mon, 22 Oct 2018 18:13:40 -0700")
Message-ID: <xmqqmur5s1y9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> This patch set fixes incorrect parsing of the --exclude-promisor-objects
> option that I found while working on:
>
>   https://public-inbox.org/git/cover.1539298957.git.matvore@google.com/
>

Thanks; both patches make sense.  

As the problematic feature appeared in 2.17.x track, I'll see if I
can easily make it ready to be merged down to maint-2.17 track later
when somebody wants to.

> Matthew DeVore (2):
>   Documentation/git-log.txt: do not show --exclude-promisor-objects
>   exclude-promisor-objects: declare when option is allowed
>
>  Documentation/rev-list-options.txt | 2 +-
>  builtin/pack-objects.c             | 1 +
>  builtin/prune.c                    | 1 +
>  builtin/rev-list.c                 | 1 +
>  revision.c                         | 3 ++-
>  revision.h                         | 1 +
>  t/t4202-log.sh                     | 4 ++++
>  t/t8002-blame.sh                   | 4 ++++
>  8 files changed, 15 insertions(+), 2 deletions(-)
