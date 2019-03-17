Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75FE20248
	for <e@80x24.org>; Sun, 17 Mar 2019 13:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCQNlC (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 09:41:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39181 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfCQNlC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 09:41:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so11304809edc.6
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=rWPlcB72Jj1xG+l2gk79oFrFOTCr1W9dkmAKFTJ6S2E=;
        b=b7DsHNlfQZmPkQcePTw0pxDbDG3Hgg/O+4ppb3erlOJJB/49Xt1+nKzbLnuR0p9ZP/
         lv37RjuvZ0nxQWPH91KGJ+PMDBpNTxs3GCijIoZ3832DMOLX5XnyT1G/Z9xX/PA9bYPu
         8G+ZCP48K1KtJCMdc3vCUDVdrA9ZAlBgG72jRoJaszzK0DnEUuqCUvRdVBoPjeJ3nmAL
         7GGsDgE7PsycQaxQQNlo140qGyVOYl8ItmQdBc7EAJccJm+shv90PWqSR/S399MkUqUx
         xvxDlrhkW7OYAWWSP0XVY4tWDEUGDXZqMO7TQn8tJ9Po9fC0VDFiNoxeCvEOR0WkSI3/
         aGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=rWPlcB72Jj1xG+l2gk79oFrFOTCr1W9dkmAKFTJ6S2E=;
        b=rhcjVYoBSnB1tSN15i+SH6DO160FIXDpCcp2FSuXaQ1y/idhWg/cS3nkI88VK4w6qn
         Lmzgd7AqmtG9TphKn/We/lhRXcyueLsHIRtLEyhxjckdR3dtNUDnJhlHBb/LGjt52PEI
         LRp7m+92HP9IHMO21A1ZuEPQUeok3icz7Taie7f756QZnRBL2/pAfiX6546ZRUOdfe3R
         F+KnOIOTUHZALNmIbi58iQ8E6a/wuyYcWrQYBzp1SLsN3skUSPArj2x5z8KyYbDJ1hoJ
         DaYkxFlRDuAbWax8eveo+LMVhNXGa5T955pbugZCZfshYTq/vmWj4TN0AvG/wVD9z3z0
         cCiA==
X-Gm-Message-State: APjAAAXAlW8SBsLub06LMXyL1LBtjCuTicFET8uY2pWrMiJnn9AIkJkv
        1XmkO5evXGQPtvyP9N6aaP4e1u2T
X-Google-Smtp-Source: APXvYqwe5Hsc18O22XOgzRVncqtup6jThqQw/B8OKczjNguAYwUk8AHWG92k31j1oKBoqmMO77DCjg==
X-Received: by 2002:a17:906:5946:: with SMTP id g6mr8332087ejr.58.1552830060131;
        Sun, 17 Mar 2019 06:41:00 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b46sm2531965edd.18.2019.03.17.06.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 06:40:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        vincent.guittot@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
Date:   Sun, 17 Mar 2019 14:40:59 +0100
Message-ID: <87multaaac.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 17 2019, Denton Liu wrote:

> The documentation used to consider
>
> 	git diff <commit> <commit>
>
> and
>
> 	git diff <commit>..<commit>
>
> to be equal counterparts. However, rev-list-ish commands also use the
> <commit>..<commit> notation, but in a logically conflicting manner which
> was confusing for some users (including me!).
>
> Deprecating the notation entirely is not really an option because it
> would be an arduous process without much end-value. In addition, there
> are some valid use-cases that we don't want to break.
>
> Document the preference of the first form so that future confusion can
> be minimised.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Thanks all on your feedback on the discussion thread[1]! I opted for
> just the documentation-only route so we don't break any valid use-cases.
>
> [1]: https://public-inbox.org/git/20190311093751.GA31092@archbookpro.localdomain/
>
>  Documentation/git-diff.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 72179d993c..10c7a2220c 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -63,7 +63,11 @@ two blob objects, or changes between two files on disk.
>
>  'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
>
> -	This is synonymous to the previous form.  If <commit> on
> +	This is synonymous to the previous form.  However,
> +	users should prefer the previous form over this form
> +	as this form may be more confusing due to the same
> +	notation having a logically conflicting meaning in
> +	linkgit:git-rev-list[1]-ish commands.  If <commit> on
>  	one side is omitted, it will have the same effect as
>  	using HEAD instead.

I think we're better off just consistently recommending "A..B" instead
of "A B" and "fixing" any occurrence of the latter to the
former. I.e. not taking this patch & going in the other direction.

As noted in the thread you linked we'll always need ".." when one side
is "HEAD" implicitly, and that's a really common case.

So as confusing as the whole ".." v.s. "..." is in diff v.s. log I think
we're worse off with "A B", since we'll *still* need to document the
likes of "A.." and how that differs from log "A.." or "A...".

So sometimes using the whitespace form for two revs and then the ".."
when we just have one side makes things more confusing, not less. The
reader will be left having to juggle more complexity in their head, not
less.
