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
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C161F461
	for <e@80x24.org>; Thu, 16 May 2019 11:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfEPLpG (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:45:06 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:52274 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfEPLpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:45:05 -0400
Received: by mail-it1-f173.google.com with SMTP id q65so5568591itg.2
        for <git@vger.kernel.org>; Thu, 16 May 2019 04:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcqkPZHZBmtaw9rkyABiADmhwK4LlqNNZRQkw4TFYc4=;
        b=mb/i2gOwAGgdFv07CvUTgjDH1KojbQ1oaj3brFlJWjGfKUjcb/zV3MC5czabpmWMnz
         0YC/4xP24exJ5sVhckF4r+3GkzzampR1b8yHROtpuN/K3WcfpeZH8r+FtXt1G4UQt2AG
         5i2CgNVQNa75z4ynDXNaFUQQod4rfxs5XBewPRr9wLXxZEzmk9EUCF2HPsgSRkkHFRcU
         AXIOYMTZtqufe4rnlxpetfZAh/S0hHqOoR/U/jTs0NK73Ef3ZPwvIwplv1KfQNOHwrGD
         FvO8RVHNk3eoyK73uiABJvyk3UnUl8ZLaqSYfvX8/C8YZ1vT7sQ+M1/h5sxprTWuntHn
         SKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcqkPZHZBmtaw9rkyABiADmhwK4LlqNNZRQkw4TFYc4=;
        b=QYHhC3tjPCfWeJqLk0ufAGvgEpetbCp7q79y1ZoKiV89IMd01NyhfzF3hOGi8sQq7L
         TggVffaTLacKKEjaePvh/x4YpZNZT6/v7G1ZbQJb8KJkaH2IRmfqCGlm4frnoYuE/d+o
         1tYEIDFEEW1y9cC8+GSZesOfZ6ddJ43JxfMiF7Ig+RqxjJqGdJLDKLntnEvTPOm49pl6
         5LjwCeVhJ6zvzCiEDSNF+kLTZZncIBFciibLBMdH1Z2appzFt2XUtTaBMYkdZ8EGWiCq
         vruuUENlloeLvO6Lwu/qr4QdaV5iYG//Ta2o1eZT5NAV3uIRMhVf4nAMdUz1mbMpSscv
         kouQ==
X-Gm-Message-State: APjAAAUfnEABr2oOID2OvNxEt79HMS/t/7zI20juWJvNW/s581iUq0ST
        h3lZn4GfFsBVsmfNeejm5GfbltA/lbqctaXxFB0=
X-Google-Smtp-Source: APXvYqyBKjSy3OY4Rf18YDLOcyjJPlB30vKl7MXHf5u5ZjvTIN1vrzsVfV/jX0cst54c12n07sxqCTaqnr9KUtHtcik=
X-Received: by 2002:a24:1711:: with SMTP id 17mr12212832ith.70.1558007104435;
 Thu, 16 May 2019 04:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
 <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com> <CAPig+cS1iypB9oZ+O=KsJ7CHyWUEOKzr8djRthrXMdC+uNHVKA@mail.gmail.com>
In-Reply-To: <CAPig+cS1iypB9oZ+O=KsJ7CHyWUEOKzr8djRthrXMdC+uNHVKA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 May 2019 18:44:38 +0700
Message-ID: <CACsJy8AgzSZ_Gj9JW2yTdgkGQNCMMLy8i+pH_+A93+V95anQWQ@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 6:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, May 16, 2019 at 7:33 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I researched this also and concluded that it's a bug in git-commit.
> > You run afoul of it in other situations, as well. For instance, say
> > you have your index file in a non-standard location:
> >
> >     $ export GIT_INDEX_FILE=../storage/index
> >     $ git worktree add --detach other
> >     Preparing worktree (detached HEAD c9156d2)
> >     fatal: Unable to create '/.../foo/other/../storage/index.lock': No
> > such file or directory
> >     $
> >
> > I think the correct fix is for git-commit to assign GIT_INDEX_FILE
> > with the absolute path to the index file, not a relative path.
>
> Thinking more clearly on it, a better fix might be for git-worktree to
> deal with this itself, converting such a path to absolute before
> cd'ing to the new worktree directory (or something -- I don't have the
> code in front of me to provide a more concrete suggestion).

Our mails crossed. But yeah it's basically the same thing.

Although I still doubt a good $GIT_INDEX_FILE would fix the problem.
Even if you manage to create a new worktree, when you cd there and
start using it, this $GIT_INDEX_FILE will still mess things up (unless
you do mean to ignore the worktree's index file and update one
provided by pre-commit hook).
-- 
Duy
