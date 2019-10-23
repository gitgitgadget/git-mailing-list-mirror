Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642491F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfJWRL1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 13:11:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42376 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfJWRLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 13:11:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so12496085pgi.9
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZhQYVrS1eVcPN54wLWEz8VVXV5XRnl1pG+qXIJXCss=;
        b=PjvuSD+SEuRO/z5YfnX6IwHNQhfQDTFQer0Vg2aY8tSf4rMyEWKCuQ0d5QmtWC0xqT
         hNq3tyM8go3va949ZWUr//JEifqzgZWhRZWgD4nRhDkMkfLomgjpNeKLH/ObTs/RY4jX
         pEhTsvXxbVVC5BMbWJgu+cHg6dvBbtREnt+TbsNbeuIENHahjQq5VUkvw918eeOMsrJN
         arJfN4SnSv2VGpyOg2BpF7XDxVoFuNntclVHQM3uvpRC8ctwGAmap/Cz1VXEpUPFwZJZ
         RXDcJb96ELfU3VwYFI/wZ1QRu7UYBkLVQbrb9lBm0yZQ8RyzcKAAWkVjkBAj3d0btSmt
         1jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZhQYVrS1eVcPN54wLWEz8VVXV5XRnl1pG+qXIJXCss=;
        b=HBWlICQUwGIf8QD8F184ra0EJZu7BxWZe3SQjQUrC5Saz+HZYB2ZVBj/5HANiDhE+L
         JX/QZa1IbbRbGqBvffxgGc/eTjqLT+7klqWVjeG9KvfKltUlCL+bAxsHHP1Xn0uX+827
         nFweY7ZiVKpS/i3dEXnRwdyTeHqJoeP9mszz7NmIY2bBf3zWZ7dRstvQBlMs20ji1tO+
         NuS3aj0qgT84xgoB65QwcGwtiIJkwS/tFvfoDuLF8VYDe62p5acmDOGMXHGogNW4fNfk
         MWK8igayCQABGr4BqAdWFSX9aMUu5GSXBNs7bfnZqd1oTNW0gjEPpxRVThzf9/vBWdk1
         w1Fg==
X-Gm-Message-State: APjAAAWunM2DDOI20YrTBKSr978Y+0WxrDhXrRDb3sQlRwfoAjgP3aVq
        Q4bLZy0Ys/J1cnftSonIPcY=
X-Google-Smtp-Source: APXvYqz9BIbKE4w/uIgBVUlNHD2JCLOwwAIGz05iVfABCGgYTEukzkLTPMr8N4ze0qeHknmYaGyRCg==
X-Received: by 2002:a62:ed01:: with SMTP id u1mr1293741pfh.122.1571850684309;
        Wed, 23 Oct 2019 10:11:24 -0700 (PDT)
Received: from generichostname ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id d10sm23046826pfh.8.2019.10.23.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:11:22 -0700 (PDT)
Date:   Wed, 23 Oct 2019 10:11:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t4108: remove git command upstream of pipe
Message-ID: <20191023171120.GA87013@generichostname>
References: <cover.1571832176.git.liu.denton@gmail.com>
 <9d915748c1953cc2683fa3189c3c98b1e9a1e299.1571832176.git.liu.denton@gmail.com>
 <CAPig+cQ6RCMOaf4ZtOKNtiDdKu1JED=zMKZ8afwSr0cvE2zMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQ6RCMOaf4ZtOKNtiDdKu1JED=zMKZ8afwSr0cvE2zMgw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 09:32:26AM -0400, Eric Sunshine wrote:
> On Wed, Oct 23, 2019 at 8:04 AM Denton Liu <liu.denton@gmail.com> wrote:
> > Before, the output of `git diff HEAD` would always be piped to
> > sanitize_conflicted_diff(). However, since the Git command was upstream
> > of the pipe, in case the Git command fails, the return code would be
> > lost. Rewrite into separate statements so that the return code is no
> > longer lost.
> >
> > Since only the command `git diff HEAD` was being piped to
> > sanitize_conflicted_diff(), move the command into the function and rename
> > it to print_sanitized_diff().
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
> > @@ -4,11 +4,12 @@ test_description='git apply --3way'
> > -sanitize_conflicted_diff () {
> > +print_sanitized_diff () {
> > +       git diff HEAD >diff.raw &&
> >         sed -e '
> >                 /^index /d
> >                 s/^\(+[<>][<>][<>][<>]*\) .*/\1/
> > -       '
> > +       ' diff.raw
> >  }
> 
> Nit: By hard-coding "HEAD" in this function, you lose the flexibility
> of the original. An alternative would have been to accept the ref
> against which to diff as an argument to this function:
> 
>     print_sanitized_diff () {
>         git diff "$@" >diff.raw &&
>         ...
> 
> Or, better yet, keep the original design and pass the diff in as the
> shell function's input, so a caller would say:
> 
>     git diff HEAD >diff.raw &&
>     sanitize_conflicted_diff <diff.raw >expect.diff &&
> 
> However, not necessarily worth a re-roll if we never expect anyone to
> pass anything other than "HEAD".

Since it doesn't really make sense to commmit conflicts, I decided to
hardcode it to be a diff against HEAD and the worktree since that's the
only sensible place where the conflict should live.

Speaking of conflicts, I dropped the "conflicted" part of the old
function name. I think that removes a lot of clarity so I'll reroll
renaming the function to print_sanitized_conflicted_diff() or something
like that.
