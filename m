Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CE41F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdAXRSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 12:18:46 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34527 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdAXRSp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 12:18:45 -0500
Received: by mail-qt0-f196.google.com with SMTP id a29so26674418qtb.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OJ1yWMzJB6N57/djta0JXR/b4QJaTdZIp5p3OMQzbco=;
        b=sbRntNI+EZLJpYfXvaLVlQsD/z6nzCrgToQ7tU3f0lXEQfPBSpJ+WHMbGZPLAsZy1+
         vN8ZkkBQgbrweIWBHzh2Bk6CkETp6+vtjTKL/6ckJXpveuLIL6dAC8vYnB0yuBX1lLxI
         oqj3pmfqtwYp3LNiATlH3HvdHhMMbAl4quXMqBKUFT0XvDM6B1KaYkIR8w7bNTP6R6RC
         blBvtX+em6qcz4Xe6154O2kYVkXXIvlxPg/Kwhy/QhEOoU7Xu0Yx3I7rHZwOwuamYauh
         0mhPbjNDlcxc/nSxcKJER4PVsm9mgLyxKd2IFVquVrVbF3qRhQkkV2IMTFPsLIJHR5T0
         EeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OJ1yWMzJB6N57/djta0JXR/b4QJaTdZIp5p3OMQzbco=;
        b=N3tDILVebPnD5LqD4qZdaXA8ARJd4BHyGg3D6xKLOFH9VeEJwXPGw2jvCxaOAYMwkt
         96XMHHHbZKg8yO9FTpPgcbviaOn/7ej7vBodn16ausnGQsryja2fgi3TSzn1trzOeeHg
         xjjMIr5W1916E1xBvF9mqQ87miKmXk/FY//+BXnJz3nVU8M/fVqLH4YUT0nK75nIY2ht
         TPWAKzSiL0jKRwmd+CYnjhWMWdVXporDLZa34MMMQGfmk4SNNBKGocn2KGYDkhsiNePK
         nJ3UAfg7cuQzPnDxu2/ro2CbqyepepfxH0q+b+KqMo+/zZCb0IvIWYFA9/cTA/Biu4fd
         Cfgw==
X-Gm-Message-State: AIkVDXJ0eTMkhLJOazoYOXa84jTwXQiafIfHN/ahJLM0RzeGuXI35/LwBvjGlp1tef4UuS1uWywQ9EXQxZAlzQ==
X-Received: by 10.55.16.11 with SMTP id a11mr33049507qkh.3.1485278324317; Tue,
 24 Jan 2017 09:18:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.162.6 with HTTP; Tue, 24 Jan 2017 09:18:23 -0800 (PST)
In-Reply-To: <20170123132918.GM29186@stefanha-x1.localdomain>
References: <20170119150347.3484-1-stefanha@redhat.com> <20170119150347.3484-3-stefanha@redhat.com>
 <xmqqpoji2851.fsf@gitster.mtv.corp.google.com> <20170120141212.GC17499@stefanha-x1.localdomain>
 <20170120141954.xyocl6oqoykqmpl5@sigill.intra.peff.net> <xmqq60l9wdb9.fsf@gitster.mtv.corp.google.com>
 <20170123132918.GM29186@stefanha-x1.localdomain>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 24 Jan 2017 09:18:23 -0800
Message-ID: <CABURp0qbvwSA1RcmCnVQVo-3O6rHZ3kP9dv0T9+mCzPWbAkHeQ@mail.gmail.com>
Subject: Re: [RFC 2/2] grep: use '/' delimiter for paths
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 1:54 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The use of "git show" you are demonstrating is still about showing
> > the commit object, whose behaviour is defined to show the log
> > message and the diff relative to its sole parent, limited to the
> > paths that match the pathspec.
> >
> > It is perfectly fine and desirable that "git show <commit>:<path>"
> > and "git show <commit> -- <path>" behaves differently.  These are
> > two completely different features.
>
> Thanks for explaining guys.  It all makes logical sense.  I just hope I
> remember the distinctions in that table for everyday git use.


Familiar itch; previous discussion here:

https://public-inbox.org/git/1377528372-31206-1-git-send-email-hordp@cisco.com/

Phil
