Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDA320374
	for <e@80x24.org>; Sat, 13 Apr 2019 10:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDMKj4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 06:39:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35519 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMKj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 06:39:56 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so19893664itc.0
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WITDXqORYHB4yx+qSJ3KtOED2iNpGIVDK7aH2wE7VmY=;
        b=f/jBeKFjq1bEH1sS+hBA8LxzXPvzMAieQaVGvvdvMr1iVIUPf7LPPf8+xUgT/Ii8+4
         g9c453eYmVu71TqYmsaEbMgwh9d9tD40SJcbVBz1oZIC0/lzXrzfmlDwKjlRgBV9yB1g
         b4LzI0CDhlF6LnqQ3LsgU1QqYq60VSaWOP8rdmIhFdJhYeEN9z4t/kUPlewMLYFghp7m
         rocwZL8TCCGVF3EAej4R5QPBrECmq8y3Z+RyVOt9nHaDhcMpWCvHql0mJC/HbdBvpN9q
         DTjPvmpfKS/nGeYJvk96GiipeAeEDKY05KTgwvf7I+T9TpDzwbodyJDts3RUZYgz1R4u
         4+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WITDXqORYHB4yx+qSJ3KtOED2iNpGIVDK7aH2wE7VmY=;
        b=S4jNGkQgIPuxCfi1M0VjQTOhfpwP4G4MSEcwqVYvvtUJsWV6lPHZDApBEFFgzQNsF5
         Rc30FlRiunkm97RsLLotDoUIDXdc8/pdMa7pcnl0AL8wbJh+jqo3uwrCEkp7OJp+LARf
         p/ix2O13COubRX4r2Ev5JPSm9sQY7B727unUxKV5QFjDGylr+O4bhy0fwuGSIyHkmIAq
         PKBmOtzX3Sj49+Z/LDJgdPqxPtqOan9Z/Aw6+REqHuRU14CqyK+NwNdWxMkxR4XnffvC
         pzsjrAPeJA7U8oLKnNzYOC0bYYp7q6t+9pT1jqFuph7D4md0Ls3IFwtwYprrwb4xXNZF
         8SfA==
X-Gm-Message-State: APjAAAV5iFchexdrB3LMpU15N5ZSleMXlbgYFO1EwCo+rJiNnVcVtehu
        RBnFNsr5SRXeQ0RAlB59jv54aytbv3agRyBcaGQ=
X-Google-Smtp-Source: APXvYqwcCMEWSIltvxAR8EtR7lnCdjDIq03ZbHowArRVgW3TUMIcu8y8Z54BdkANAsHkhcBWrh5NfBF8e0sMNks+Lc8=
X-Received: by 2002:a02:c50b:: with SMTP id s11mr9280376jam.84.1555151995023;
 Sat, 13 Apr 2019 03:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190411131218.19195-1-pclouds@gmail.com>
 <xmqq4l73ztxf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l73ztxf.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 13 Apr 2019 17:39:28 +0700
Message-ID: <CACsJy8A42eObPkDvuPd7GodKxfaRMk0cd1YLUz+G-K4Qed2X7Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Add new command 'restore'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 12:14 PM Junio C Hamano <gitster@pobox.com> wrote:
> > - git-rm learns about --staged as an alias of --cached (in fact it's
> >   more the other way around). This is to keep suggestions consistent
> >   because we tell people to do "git foo --staged" everywhere.
>
> I am not sure 100% about this one.  If "--staged" is only about
> updating the index without touching the working tree, then existing
> "--cached" is already serving its purpose and there is no need to
> add yet another.

It's so we suggest the same option name in "git status" instead of

 - git add/rm/retore <paths>
 - git restore [--source] --staged <paths>
 - git rm --cached <paths>

It's in the name of consistency but perhaps it's just not worth it? It
could also be seen as the continuation of adding --staged [1]

[1] https://public-inbox.org/git/1225296936-1357-1-git-send-email-dsymonds@gmail.com/

> Why did we need it for "restore-paths" in the
> first place?  Is it because the target of restoring can be one of
> the three (index+working-tree, index-only, or working-tree only),
> not just the traditional two (index+working-tree that is signalled
> by "--index", and index-only that is signalled by "--cached")?

Yes.

> I think it would make sense to introduce --staged to "git rm", if we
> teach the third target (i.e. "working-tree only") to the command,
> but otherwise, I am not sure if it would help reducing conflusion.

I could add that. "git rm --worktree" then is almost like "rm" except
that only tracked paths are affected. The default target of "git rm"
is still "both worktree and index" though. I don't think we can ever
change that (e.g. to match "git restore" which defaults to worktree
only)
-- 
Duy
