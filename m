Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132E81F461
	for <e@80x24.org>; Wed, 15 May 2019 00:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEOAq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 20:46:56 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:39950 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOAq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 20:46:56 -0400
Received: by mail-it1-f172.google.com with SMTP id g71so1805261ita.5
        for <git@vger.kernel.org>; Tue, 14 May 2019 17:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVN38tc1rhE5sbykJCgupuvhqh3ZG6Ouc9w8vcW3qbQ=;
        b=j/VYwJ/p/x7sss/qgZD91jXFMfpVXFkRPokD3bmG4UtG3KB0Ar2E3Mdh6p9sTSq+p3
         16p9rYe3zOfcmz9+F4IQ9BoBbWtljO/TVylb5xjR/sm2N3kTtW2hRu+dWyGsnOYpxzaV
         mzREpMs5q5zOivHb2yLtZ58Pk/j14Z081VZ74qtILePcUSYvqBts19HUmX6rPKPdgKPt
         YjnhdO6il1OuS0pDQrrNpjjJ21thxyoQZm7ZcVHFnp08KcMiNX26DijQe2JfsP+nAO6z
         voZW/JLGiq+KlWbfWvNrju2AnBp11axjJgHgqrsrdtypWt/04R1G8OZ+r+DSdEvUthmf
         d7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVN38tc1rhE5sbykJCgupuvhqh3ZG6Ouc9w8vcW3qbQ=;
        b=SMIluWhoMAppdZPsaqUW+LYHu1an3yVd7/QxK9IXt6TiuLXh2egPqHnFvOwOLT7PVI
         ByUU7QboyzDERMmdn6/RmKf45dvPvIRgF0ftrRnA+KQI04yQOZjH+DVDUEor6OkvXUU9
         xRMYQ5z5fYqPYy7mdNWLvPRIQHoH4sos8tbxMMs6dFZVFJB2IpolFNm80ycw5CXK1f0Y
         CivglcTfxUqaiJr45oF8xUDNCTn/C8aoo6M2GLpertM/cVng8CRxkgyLHFNLOPEVwRn6
         ClM2MilWHY2/dkiSqez/i5fYRVxfdlJMThSwuzRdiU0YnRhOmpSm//Lg1W8UpJx/3ygb
         9JHQ==
X-Gm-Message-State: APjAAAXMdKzWyXAjf0BmuajHj12BOukAU9jx0Qifb1vMwc05JCFykCxu
        mRPabo6Eoc3hTcmlqlqwZYCFusFr1SChWklWStPORSo58FE=
X-Google-Smtp-Source: APXvYqzK/13Uy4ZqsmjPyd0lXEBA2/PqK0UTqNJoPwdnH4mfN9IlRvlU99YDM7Sxfk6iYUgIvnycTWXkElNDeGUccy0=
X-Received: by 2002:a24:734c:: with SMTP id y73mr5388710itb.72.1557881214851;
 Tue, 14 May 2019 17:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
In-Reply-To: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 14 May 2019 17:46:43 -0700
Message-ID: <CAGyf7-GtnCqfqPWVpBAELB4xAE6syn7+DfKXgfhL0UoMfvbn4A@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Cosmin Polifronie <oppturbv@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 7:53 AM Cosmin Polifronie <oppturbv@gmail.com> wrote:
>
> Hello! I am trying to run 'git worktree add <path> HEAD' in the
> 'pre-commit' hook, more specifically in a Python script that is being
> called from the hook. When doing so, I am greeted with the following
> error:
>
> On Windows 10:
> Preparing worktree (detached HEAD cbfef18)
> fatal: Unable to create 'C:/Users/meh/Desktop/abc/.git/index.lock': No
> such file or directory
>
> On Arch Linux:
> Preparing worktree (detached HEAD cbfef18)
> fatal: Unable to create '/home/cosmin/Downloads/abc/.git/index.lock':
> Not a directory
>
> Is it forbidden to call this command from a hook? If yes, what kind of
> alternatives do I have? I need to make a copy of the repo in its HEAD
> state, process it and then decide if I will pass the current commit or
> not.

I can't speak to whether `git worktree add` should succeed or fail
inside a `pre-commit` hook, but...

Why do you need a new work tree, versus whatever working copy you're
running `git commit` in? Is there a reason whatever validation needs
to be done can't be done in the existing working copy? `HEAD` is the
_previous, existing commit_, not the new, currently-being-created
commit, so your validation in the new work tree, if you actually
managed to create one, would be applied to the _latest existing
commit_, not the new changes you're trying to commit. Even trying to
copy the changes over wouldn't necessarily result in the same state,
because there may be unstaged changes.

What type of validation are you trying to do? I think the failure
you're running into is an alarm bell indicating what you're trying to
do may not make sense. However, without any insight into what "process
it and then decide if I will pass the current commit or not" actually
looks like, it's hard to offer you much help.

Bryan

>
> Thanks! :)
