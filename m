Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456821F461
	for <e@80x24.org>; Thu, 16 May 2019 12:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfEPM3Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 08:29:25 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:34594 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEPM3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 08:29:25 -0400
Received: by mail-io1-f54.google.com with SMTP id g84so2435158ioa.1
        for <git@vger.kernel.org>; Thu, 16 May 2019 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGiIlWt0jLMFAvLUVdcmInV+fdnOpf8IuYP/k01OElQ=;
        b=TXgurfvIBGzDcj2lrNPgmAwYz9nk7klRVk3rXcwdToS28CiLgRUEwMX+MWSqgf4osf
         1Qi2FKeam75zExzYHabTZxMZtjKUgqPj3LytPxsy3HhxC2YEROgOACakTPIhsjW/E7Yc
         NsVxY89ozAOWse4GtZy++2A2imy+aTAZDXKLrezNm1iKTCXMlijIGcg/pxo9bmGPmI+p
         QhbwCZKbz1l6MnhX1k1kj29FTepTPVGefPGSVlsksFfUL81M5aP6rS+3BY9sW9HzqQ9z
         26+hLl80OcZzl/OFumTAB9yVjtUFk+pbRxQxFn7h9gC1KCjIYLGHDHfeXT9H6HOpJKLh
         AVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGiIlWt0jLMFAvLUVdcmInV+fdnOpf8IuYP/k01OElQ=;
        b=ofSch4p3ahSlgoRAH8O4de88hyW2QexZZa9b+tsg7qiklKv8mpSy60w0izb+bB1k+q
         mhKmno+zGAnP9B92oNf2PEPP4BoM+s9+Tecaa4pEzjAKXt3sYeAomUO6QwSBuWQALgFU
         6z0/GO83MdVciJW8gyc/4nanmwBynVB9cv9XuGPr7B4h0ZryZz6hpozbLu4EdCFR01gS
         VnH0sc9X9Ht6h3g9BGjz6YZwS/qiAjhOSYhGFUxqNJmcDhlZLsTfRH9oC4QNKjB4EK+o
         6SmhVIO7k85pahgthPKZybwH7op2sX2FSseU6/ErWdrcxr16h1Vb00hJj5OqmyFyD5n4
         38OA==
X-Gm-Message-State: APjAAAWEQ22uTE97Ux9cRmfC8J7zTLHxPWghXaFOlFqjvt86vT+1ZZ/Z
        YNBqxvICzgqrdv2aWgqcdzG/mhzsjfdLzH+DW74=
X-Google-Smtp-Source: APXvYqzc8Dqa5DtGxN3p0Jc3iQrXGhiKo5NRvy9nUQJo4OmEo7bZ8S51uoPhvsbflwgYsYjcYG3Xe1ysjyU36dT1PEo=
X-Received: by 2002:a6b:8e84:: with SMTP id q126mr9213603iod.118.1558009764704;
 Thu, 16 May 2019 05:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
 <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com>
 <CACsJy8BXxVggL7CWA5Q0d7U4B+encfZ85NshxLJ=VvHhf_LUYg@mail.gmail.com> <CAPig+cTCdBkru-6tJVeYxQSaosv7pb8R5ge_aedzi5C7w39mQg@mail.gmail.com>
In-Reply-To: <CAPig+cTCdBkru-6tJVeYxQSaosv7pb8R5ge_aedzi5C7w39mQg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 May 2019 19:28:58 +0700
Message-ID: <CACsJy8BP6af7YBGQXc_a_dEYeFgbpP3WaGAb0Z-NvTRRCgeTMw@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 7:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, May 16, 2019 at 7:42 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, May 16, 2019 at 6:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > You run afoul of it in other situations, as well. For instance, say
> > > you have your index file in a non-standard location:
> > >
> > >     $ export GIT_INDEX_FILE=../storage/index
> > >     $ git worktree add --detach other
> > >     Preparing worktree (detached HEAD c9156d2)
> > >     fatal: Unable to create '/.../foo/other/../storage/index.lock': No
> > > such file or directory
> > >     $
> > >
> > Oh if it's relative $GIT_INDEX_FILE then I think its our environment.c
> > code that does not work so well when we chdir() away. I vaguely recall
> > something about this when discussing Jeff's chdir-notify series. But
> > it turns out that's about chdir() in run-command.c [1]. But the idea
> > is still the same, all variables are supposed to be relative to $CWD.
> > Whenever you move $CWD you should reparent all of them, including
> > $GIT_INDEX_FILE.
>
> builtin/worktree.c:add_worktree() is already assigning
> new-worktree-specific values for GIT_DIR and GIT_WORK_TREE, so for the
> specific example I showed above, the correct fix would be for
> add_worktree() to remove GIT_INDEX_FILE from the environment before
> invoking other Git commands, correct?

I'll work on the assumption that all $GIT_* are for the _current_
worktree, not the one we're creating. If so, yes we need to sanitize
$GIT_*, maybe do it the same way submodules do (I think
prepare_submodule_repo_env() is the right one).
-- 
Duy
