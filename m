Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5D11F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeGKRzD (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:55:03 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45434 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbeGKRzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:55:03 -0400
Received: by mail-oi0-f66.google.com with SMTP id q11-v6so25250743oic.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kDjmWH9EZJ3L/8wEivpa0GCRNZJ1BuPB6sK4KN1NHWY=;
        b=TjehIvPalDE6cAAzv8MoJ5ihrNjsZJ+yNB51SfzGS+kO6vNCBqhWYvvnSyuDJkeX5N
         QvYB1DYOluixHTlkZFAyt9yutq6zpm1GSYLIG3n67nNNHh4czLiJ6BoYxHj5bhLNsCa6
         UmiNAhf9DcYIcKw4e9DjI2Vntm+KFzjCuBKmR86/Ka2P4hGcJgKhEY6poLR8EVMsIfCu
         tigZLDIbgwlio9Dmjph8c6TyAy8MfBZXg1ppvyOze4HGXvNxnF1uHVt3mhQCNrkNYfiG
         9KefpOaT/+0HfJLzIrP5ne5PRJ0b0e2B7djbDBc7/pmM4PbbkEEvLnz2WqwOFPJVPMU4
         gdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kDjmWH9EZJ3L/8wEivpa0GCRNZJ1BuPB6sK4KN1NHWY=;
        b=XCtyRVIaHKs5E2x6JNl0SLLOVzHjxTTCYqxRc7nUzYxpAgrPQsR0y7kd4fPfzwV9l/
         nhrpqNpFfJhe+bUvyrEfnkA9LLjKhNw0ERbrFenJbSUGT0iogKvAHn6/2aPmVoH9Bof3
         GOksqPM8vMGT3Ubyhx082ybGhXnCh1KJa9PxVjR5ZUr0nt0bGFMXYkTf4FgztMI8KoKL
         V+azNzsJc58SUZXU+Uev9wYgzaQIi/4Awa7OJNsfty85DR/M1hzlmG1ettRI/Co9QSCB
         BM3y7kOwV01Ow25X7c2Sdl4teMz/OqHFQu02HiHU9x0M22LpuBtEK2ZesZmKtMmMPN83
         daSg==
X-Gm-Message-State: AOUpUlETgSr0P882ZAddBUhOLQTjD/980xxixmnLt+2znhyc3T8G4+bk
        Vv8AG2ObKME2YMUWCx3TFh3Y19CaNUiDVIKL+/g=
X-Google-Smtp-Source: AAOMgpc1Z6fY7/I8MOWwo+ulmBk89wKdrojJjuSHb3RCl+bHvUogU2ktNW+hKwY9Re30I39yAajSN3vuBIWvFnS/owQ=
X-Received: by 2002:aca:665b:: with SMTP id a88-v6mr281042oic.101.1531331378530;
 Wed, 11 Jul 2018 10:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:49:18
 -0700 (PDT)
In-Reply-To: <CACsJy8AMwKHUyUe-4-MKLn1D3x-+iiFW-Wdjj+HeX_JZ=MkO+w@mail.gmail.com>
References: <20180710154106.5356-1-wchargin@gmail.com> <CACsJy8CBJvpKAAtVjrdcuO06WossxcMmqwmSRL9Shr7g+qVySA@mail.gmail.com>
 <xmqqfu0p3czt.fsf@gitster-ct.c.googlers.com> <CACsJy8AMwKHUyUe-4-MKLn1D3x-+iiFW-Wdjj+HeX_JZ=MkO+w@mail.gmail.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Wed, 11 Jul 2018 10:49:18 -0700
Message-ID: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Does for_each_ref() iterate over per-worktree refs (like "bisect",
> > perhaps)?
>
> No.

To be clear: it iterates only over the per-worktree refs for the current
worktree. So, if you mark an unreachable commit as "bad" with bisect,
then that commit is reachable (and found by ":/") in the enclosing
worktree only.

With this patch, ":/" now behaves the same way with HEADs, which makes
sense to me. Agreed with the above discussion.

I can add a test for this.
