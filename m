Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011821FD4F
	for <e@80x24.org>; Wed, 30 May 2018 17:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeE3Rci (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 13:32:38 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:36353 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbeE3Rch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 13:32:37 -0400
Received: by mail-yb0-f178.google.com with SMTP id o14-v6so6635974ybq.3
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u1KddpR4nirr747Rv5jQGUitRQinwzpcys91wZz1XXk=;
        b=O8yaUp6fH+Y9+vAfNgDwPfm4kROEfAfTEKqo/Y+yiyfPx3hD9o29Bbl1df3anU+0sh
         zd56FKOfQkg/3n28ZZVqynHwA4NnYdGLknq3uti83btYNOqqyhykBbOQLj87Pkev4wXX
         0wgRVd2kYa2mgqMltoV+Qv34IQfCn3MoMa246asWqgLkdDo+KLOx1+R0q0xFkAK3+meY
         rfpBrn14ZzCdZVDidFiuihMeyx1spM7pu95j3Mu6f1Clttb2bOI4cUy1qhgpxOEnoeX8
         s6InzZfTz2VTngjyf6bDBpxEobKUa3S/tiyB8eRnLPFgMFVsrhowQSuAvK0Q/AJK3EUR
         gpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u1KddpR4nirr747Rv5jQGUitRQinwzpcys91wZz1XXk=;
        b=reKc5V4COVnjI42DUU0VafPqpg0mHP+HVBLN678aXxjKrw/lgeXANjvRaZAEbIRTXC
         ZHYTNzcsASM6TeqhZpmgGWjNy6cDPTuQCplM1Ucysef9BrVQ8CHXW9lVrC3QPf9xm1Zc
         PGZGgu8g8hJk/ynsFYyoLOcp4RH95mf+SJqlzl+EH31COJJ1DxtCyiPT9YXNV3yqoMjj
         T2U5BKXZCSa2+VShBwF3wvuOe7ijxh4R3bnfPlP8odeVwg0QDd/L6LxjmZmdZVAI4S5R
         O1lG8vaM6Nz09i1QGuoXZLu9FuvqqHh6enflLnA71C3Gn7ZpfKjPdKVRBV0cN1vsAKC6
         y6NQ==
X-Gm-Message-State: ALKqPwf6Yi60NUydlOZ7b7WWrgf50lTDnLb6f3LXRJ4t06vuImCMgge4
        JZeLOM0DHRyT4y2pcTq0X9KTZtACW5sWeBJy+bKNcTeqA3M=
X-Google-Smtp-Source: ADUXVKKrVLAPqW+bexjcEOiww1jRcFzL4iM5iux3Z/Z3O/dqw+rCtRfZPkvqe7xHtg1SzacmPjD4Jr+M5YGcjvrA3rM=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr2110297ybc.307.1527701556252;
 Wed, 30 May 2018 10:32:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 10:32:35 -0700 (PDT)
In-Reply-To: <1527700562.4289.87.camel@novalis.org>
References: <1527700562.4289.87.camel@novalis.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 10:32:35 -0700
Message-ID: <CAGZ79kaT2KM0cZOSEXMpnr53TxUdH=gSbyQaGdBw1wEGnkK2Kw@mail.gmail.com>
Subject: Re: git push requires a worktree?
To:     David Turner <novalis@novalis.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 10:16 AM, David Turner <novalis@novalis.org> wrote:
> I am doing a funny thing where I do git -C .git/modules/morx push
> fleem:fleem.

I can do that, too. :)

> This is failing in the case where I have a sparse
> checkout and the worktree directory "morx" (which is where
> .git/modules/morx/config's core.worktree points) doesn't exist.

I could reproduce that without sparseness by removing that directory.

Before removing the dir in the worktree, the push worked fine; after
removing I got a

    fatal: cannot chdir to '../../../entropy': No such file or directory

> I don't know why git push cares about the worktree -- it'll happily
> work in a bare repo with no worktree at all, or if the worktree is an
> unrelated git repo or whatever.

I think we should unset the worktree config for submodules that are
not checked out. I confirm that running
  git config --unset -f .git/modules/<name>/config core.worktree
will have the push working as expected.

So I think it is not so much a bug in push, but there is
* a bug in the submodule data design: Why do we need to store
  core.worktree if there is no worktree? (I'll research if there are
  historic artefacts that would suggest we need that)
* the setup code for commands that do not have the
  NEED_WORK_TREE flag in git.c

> I can work around it, but if there's a bug, I think we should fix it.

I think so, too.
