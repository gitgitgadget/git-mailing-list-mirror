Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821251F461
	for <e@80x24.org>; Mon, 13 May 2019 12:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbfEMMzf (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 08:55:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33754 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfEMMzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 08:55:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id m204so9231262oib.0
        for <git@vger.kernel.org>; Mon, 13 May 2019 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NN5qIFoIl8ibOwsAYzEvizo6HC5NgbSW9zZEzi6naoQ=;
        b=qpEk2/2EgR3graEUV5NGOIN4nSfNE4kg3rIdRSqdNyGW6SjZ4awkv4gPwQe8g1w3pv
         badpiQqjsHtdKUQ6dTHlMmTuAxaU7fEznhaqQ5GY3O8XunHmxGPpTn+zWQI9BRIbZWL3
         uTGpQLHNIeqhZ2Y/Cifq7Dt2XzEf3R8gMdScNI1f3O1EXusHJsVCkFKPJ0StMjvx1Uoc
         D6/HYwRRYhxgh0Ullma9VMwy7wWm8Xwn7bveKv5KGi4bz6MA1AXdxIBoW/BoPINpWAwo
         mmTDSlmPqm31yvS145/6DaMH4Xnlipv/GzWEpqo/Sd8VD4nfAAMtNkxPjYtLHUhy8KF4
         f80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NN5qIFoIl8ibOwsAYzEvizo6HC5NgbSW9zZEzi6naoQ=;
        b=Sjv1A3TVZLb4tPKq+uJepOzvCXwMroO5y5exg8sPBEila14OdriQmen192Ur0Hq170
         Bq4n+3HpjXIEKpOkdY2wNLvo/lLg3McZ4xGiZ+hRwhC+XYecB+2H3yzHp+t44tswAkHF
         o7LpOpM/dm5p7P22Xs6rqE7JIDREozZ0siy/8TPNR+TLiJPeT599zAOOzxGiOB6u8WEb
         riQZ6RFVxJTWNfq/JsewCVS907cMZHhTo+bv1CS4Dl+2zxLhoo9dsZ1YbN/7tn2jmKuZ
         fqHcKdfbmfYigoeiTTvOE8EhqiZo2EYyRPJ+pQtW4dFl+BA4C3xY8RNwq5qR/2/4U+8O
         cqeA==
X-Gm-Message-State: APjAAAWYwx3Ql75Kl1qvPZ/yZV77iSedkjExbGPe8tZIti8HEzmVNy7X
        0Kmt3IJ+WkJMx1tkAqVwHl5OdNIemut1GQObkDM=
X-Google-Smtp-Source: APXvYqxFbet7iS3LfxnALyQXHHo5hl0gNJhe9QW92Rw/Bjkgcq8+Gk2hMwJv+Y3WOhN2OI9rnp3ju9yzCpMO+1NxcSw=
X-Received: by 2002:aca:2d41:: with SMTP id t62mr13650848oit.53.1557752134449;
 Mon, 13 May 2019 05:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
 <CACsJy8C++Ds4kfs_Wc8UiVQgni-ypbyJ+0bFg1m5brt+s0Tfig@mail.gmail.com>
In-Reply-To: <CACsJy8C++Ds4kfs_Wc8UiVQgni-ypbyJ+0bFg1m5brt+s0Tfig@mail.gmail.com>
From:   Shaheed Haque <shaheedhaque@gmail.com>
Date:   Mon, 13 May 2019 13:55:23 +0100
Message-ID: <CAHAc2jf2Ojve=NaEshXx9qk8rtD4NHxqLEpqZq8c9t0yE4m_Qw@mail.gmail.com>
Subject: Re: "add worktree" fails with "fatal: Invalid path" error
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Mon, 13 May 2019 at 10:21, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sun, May 12, 2019 at 5:14 PM Shaheed Haque <shaheedhaque@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm running git v.2.20.1 on Ubuntu from a program which follows the pattern:
> >
> > ============
> > 1. create a temporary directory /tmp/tmpabc
>
> When is this directory deleted? After step 3a?

Yes. I note that I screwed up the numbering in my note - the order is
["git branch -D", "git worktree prune", delete directory].

> > 2. in a loop:
> >     2a. create a second level of temporary directory /tmp/tmpabc/tmpworktree123
> >     2b. use "git worktree add" on the second level directory
> >     2c. do something
> > 3. cleanup
> >     3b. "git branch -D" on each basename(second level directory)
> >     3a. "git worktree prune"
> > ============
> >
> > The loop size is of the order of 8-20. In step 2b, I often get errors
> > like this (from a Bash reproducer):
> >
> > ============
> > $ git worktree add /tmp/tmpgtxug4y9/git_worktree.gBGqnfnU
> > Preparing worktree (new branch 'git_worktree.gBGqnfnU')
> > fatal: Invalid path '/tmp/tmp1q9ysvyl': No such file or directory
> > ============
> >
> > I can see that the problematic path exists in the "gitdir" file of
> > what must be an earlier worktree from an older run (the branch is
> > gone, but the tree is still there). The path appear to relate to the
> > older run's first level directory:
> >
> > ============
> > $ grep -r /tmp/tmp1q9ysvyl ../.git/worktrees/
> > ../.git/worktrees/git_worktree.frcwtjt_/gitdir:/tmp/tmp1q9ysvyl/git_worktree.frcwtjt_/.git
> > $ git worktree list
> > ...
> > /tmp/tmp1q9ysvyl/git_worktree.frcwtjt_  edde3f25 (detached HEAD)
> > ...
> > $ git branch | grep frcwtjt_
> > <no matches>
> > ============
>
> Yeah I think I know where that "Invalid path" comes from and it should
> not be there (at least it should not be a fatal error). I'll need to
> reproduce this first. But I'm certain you've given me enough
> information to do so.
>
> > NOTE: I've not yet had to try deleting the worktree, since "add
> > worktree" does appear to work some of the time, so I am able to limp
> > along.
>
> It's probably best to stay clean and delete things after you're done.
> At least you should be able to avoid this problem this way until it's
> fixed.

Ack.

> > I have these questions:
> >
> > 1. There is no branch or first level directory, but "git prune" has
> > not deleted the worktree, is this expected?
>
> I assume you meant "git worktree prune", not "git prune". See
> gc.worktreePruneExpire. Dead worktree info stays for a while until
> it's deleted, so that you can recover stuff if you need to.

Yes, sorry for typo.

> > 2. Is there something wrong with the sequence of steps I am following?
>
> Nope. I mean, you could try "git worktree remove" to be on the safe
> side. But it should work even without that. To me this looks very much
> like a bug.

The original code used the more obvious "git worktree remove" rather
than "git worktree prune" but I switched partly because remove seemed
slow (I cannot now quantify what caused me to think that), and partly
because I was having other issues which, I now realise, you probably
addressed in your recent "stat versus mkdir race" change.

BTW: I *love* worktrees. I have used/wrapped/developed multiple source
control systems over the years, and IMHO, this is one of the killer
features of git.

Thanks, Shaheed

> > Thanks, Shaheed
> >
> > P.S. I have an strace of a failing worktree add if needed.
> --
> Duy
