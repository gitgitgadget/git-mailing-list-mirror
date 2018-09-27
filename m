Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 808CA1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 16:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeI0W42 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 18:56:28 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:37602 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI0W41 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 18:56:27 -0400
Received: by mail-it1-f179.google.com with SMTP id m9-v6so8379628ita.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wj49vABbJ5WViMYynFi/oULZkwj1pSm6Yi687buh0qU=;
        b=RNzM78DUGRPgn59/u0Wi9FdCb9Gpy+zUixcBI4QMIJ1R5zgq31crM4retS+gpu+UzA
         BlIM+6dcgQAsQUQXzTKvn8vfupjyd9p7KrCiA4NQFh4rQZcoTYzE3G7NTsQSpdvrCUdC
         AtEMPc4bmay1eMhGzTEiM66oqGmrXuAi5UHSuTTo27PJg2IJpO3OIReKPZMqDwhMgyDj
         GoaIVz8pJu5GT7AI5eob3FUc36dS37OoVAVaOuHcN6QJjfjoH8hLtgE71ndbpFcP+cqb
         PGghktmMbmBQQOH2XjWi33BvZfpx7XNCat2AXhAghKcjSFrY+j0hE1fNPy2MYPmPDtyO
         I6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wj49vABbJ5WViMYynFi/oULZkwj1pSm6Yi687buh0qU=;
        b=O0UQ4HY4qe4dYny/dtMZhNd8a99z51qKDL/SQ0H8Nn03PskghT7DeKnCoK5+UvccY0
         r4kLPYqpUMQ4/wukTm2KbDlekQ6DDLtixBht+llQKoOHLpJDD2ZjotRJfZk+AnclyvR/
         Rpp3P0psdfhecw8rqvGdaxXEust/XhdAzzdnQ+flQLKyu/M/2cL/RvrK3NFUTXNvU+Kw
         pU6BrlMobuYhMPnllAgz6XHmFUkUr3e/iZNIVQqzb4wLbmUFAdYmfOHmkTHFXhEkDunt
         cOcPW6SYObaMwNKWWEd07DLf59aa/EVKd+IuiCgcGee2a+R00OMy0HdBqjhgHFytcCWH
         r+aQ==
X-Gm-Message-State: ABuFfohca+obcYmzUqNV8Lm4FzeTCO/3BwwT6/EjZs5juIdk/wqx31UP
        kfKeJe3yeNbE53iOO56wcc6muIklMy9k1zdJCak=
X-Google-Smtp-Source: ACcGV622Td0DQoNrLHo5Q3y5AGdQp42V684ip3J3RhJZi8Vu3qeuIzwfHExYSR41lBfrQfC1EL9tAemeHTLRxOd/tdE=
X-Received: by 2002:a02:49d7:: with SMTP id p84-v6mr10650422jad.97.1538066242137;
 Thu, 27 Sep 2018 09:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <xmqqtvmdnuab.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bux0iiOp+zjELM4DuZwiQMA6EDaL0M71Jkp_qPACD8og@mail.gmail.com> <e7f63c0f-90dd-0e53-9721-35d2b827e101@xiplink.com>
In-Reply-To: <e7f63c0f-90dd-0e53-9721-35d2b827e101@xiplink.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 18:36:55 +0200
Message-ID: <CACsJy8B_xDUQjC7uGRpR6FhFVuToUwim3sjUTk9tWUfLY2LkBA@mail.gmail.com>
Subject: Re: Wherefor worktrees?
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 5:24 PM Marc Branchaud <marcnarc@xiplink.com> wrote:
>
> On 2018-09-26 11:48 AM, Duy Nguyen wrote:
> >
> > I believe the main selling point of multiple worktrees is sharing
> > refs. You could easily avoid expensive clones with --local, but
> > synchronizing between different clones is not very convenient. Other
> > than that, different worktrees tend to behave like separate clones.
>
> Sharing hooks is also useful

Well yes, but for hooks I think a better way is moving hook management
back to config files. I think we have a rough idea what to do, and
AEvar highlighted the mand roadblocks elsewhere. Hopefully it will
materialize someday.

> Having used git-new-workdir for a long time, it's main deficiency for me
> is submodules (the shared bisection state didn't bother me much).  It
> would be nice if all my worktrees' submodules also shared refs.  That's
> "nice", but not "essential".

Heh I've been thinking about this a bit too. I thought separate refs
was a requirement for submodules, but if you don't actively use
branches in submodules and go with detached HEAD, it might work.
-- 
Duy
