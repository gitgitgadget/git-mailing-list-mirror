Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4076120248
	for <e@80x24.org>; Thu, 18 Apr 2019 18:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfDRS73 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 14:59:29 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50673 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfDRS72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 14:59:28 -0400
Received: by mail-pl1-f202.google.com with SMTP id b7so342722plb.17
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EdOTkrhwrn7L/KG1iq6UjyfnZl2T9lZfydF/D0IZn7w=;
        b=vK+h9dqyrltrLlo0WQM5HXgbNcENhhqKQ04o3e3YIkffVbqvmwwX7H5gk2GqBnjT8k
         Y3ttLaumXhFiRKeiSm1vToaUhoMkBUy4eVjTs8t8reOGW4qpuwHMstO7vKQTocuTdWoY
         pkEXISsepuQNjKDGUwEIoDp2yxmqPNEDso52IyRfqa4HROdkhmsafY9aEaMnWZQjvi3F
         z3m6IuYjqK5gPLdAtJm0HOllMDECyDi7Er1TMPzZTWdxLM93w6WvLERhzHwQKVzboykg
         iIDb7vTR1ABNn4RHxy6+kTT3L3+2dsQJ3KqzfNEMURqtCkl4OlkE/AQO0NmQz5BX453Z
         7gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EdOTkrhwrn7L/KG1iq6UjyfnZl2T9lZfydF/D0IZn7w=;
        b=hEUtKgxk75fKaGbfEfUvhpCbWICV83BA9PbHUTHXtrQErj1ZNijh1RtnQ4kgZLdPe8
         lrSnn4S64bnKozJsVstBaK3gehq/BVKaAsoqs3QKaH+kI0vmaEhMNG5ndJuNwT/HvTQH
         QPJycZdB3XiBdCu+UjmuvGe5HdBeArMcTO3wbVib93xOzMNARBtENtXugb7ybvoRiEMo
         V1ZOZzUsevtzVaIC/PV0+6zL5UpI7EFktBj4i5Rswb2yafjBHGiphtg9f8FBIonKiObZ
         oXH2WxxZmoQNy7hVSz3ArdFvEstYqe0T4LUQ5dZ92k55DCZb9/O6A1vTvn8ceoYjrOVS
         qH0Q==
X-Gm-Message-State: APjAAAV82nbFgKh+PJ7CmlxMS3J0hF1NCx4eNUN5gtGuBzBsHFO8BkQD
        EGG/A/WlrOTEbDKgG6M/eubGxw875Fjx32kZHN2L
X-Google-Smtp-Source: APXvYqxfuwLzvWyEVDupP98p1ITwp4cKBZARq9FTchV7qlC1o7AilTs0XbqoWF1ChD2OrNni9lzIIwCmMYlMqQUk1TvB
X-Received: by 2002:a65:424d:: with SMTP id d13mr9850496pgq.318.1555613967720;
 Thu, 18 Apr 2019 11:59:27 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:59:22 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1904181157010.46@tvgsbejvaqbjf.bet>
Message-Id: <20190418185922.84159-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <nycvar.QRO.7.76.6.1904181157010.46@tvgsbejvaqbjf.bet>
X-Mailer: git-send-email 2.21.0.314.g8007d49101.dirty
Subject: Re: [PATCH] worktree: update is_bare heuristics
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes.Schindelin@gmx.de
Cc:     gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
        rappazzo@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > >  - Teach get_main_worktree() to use is_bare_repository() instead,
> > >    introduced in 7d1864ce67 ("Introduce is_bare_repository() and
> > >    core.bare configuration variable", 2007-01-07) and updated in
> > >    e90fdc39b6 ("Clean up work-tree handling", 2007-08-01). This solves
> > >    the "git branch -D <name>" problem described above. However...
> > >
> > >  - If a repository has core.bare=1 but the "git" command is being run
> > >    from one of its added worktrees, is_bare_repository() returns false
> > >    (which is fine, since there is a worktree available). However,
> > >    commands like "git worktree list" currently distinguish between a
> > >    repository that has core.bare=1 but has a worktree available, and a
> > >    repository that is truly non-bare (core.bare=0). To preserve this
> > >    distinction, also check core.bare when setting is_bare. If
> > >    core.bare=1, trust it, and otherwise, use is_bare_repository().
> >
> > I am not sure if the latter is worth keeping, but the former
> > definitely is a huge improvement, I would imagine.
> 
> I think that both are improvements, with the former definitely being the
> more impactful one.

Thanks.

These comments spurred me to look at it a bit closer, and omitting the
latter not only results in "git worktree list" changes, but means that
the following test now fails:

    test_expect_success 'bare main worktree has HEAD at branch deleted by secondary worktree' '
    	git init nonbare &&
    	test_commit -C nonbare x &&
    	git clone --bare nonbare bare &&
    	git -C bare worktree add --detach ../secondary master &&
    	git -C secondary branch -D master
    '

(At current master, it succeeds.)

In the next reroll, I'll include this test and update the commit message
to use this as a rationale instead.

> > Somebody did "git branch -D <that-branch>" by accident in a submodule
> > checkout, or something?
> 
> /me shudders at the thought of it

Yes, that happened.

> The patch makes tons of sense to me.

Thanks!
