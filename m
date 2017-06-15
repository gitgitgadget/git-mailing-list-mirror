Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EEE20282
	for <e@80x24.org>; Thu, 15 Jun 2017 00:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbdFOAko (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 20:40:44 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35309 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdFOAkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 20:40:43 -0400
Received: by mail-wr0-f174.google.com with SMTP id q97so22400263wrb.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 17:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=plWsFHir5p4DRGNtXJ16ZewjYKiv99L+/+FfRv7s36c=;
        b=LlsxCAGjdFUwsNKkgR26KeDFAxfuDuHxTFaxrbDGhH1K7rbOuwGfbz22QSIlOOWn8l
         A3scBo+/0kX/cJh5pbpjtVw2UuUxnE+oLIpuF60McrczBA+mlvV/c0SuEv8wEtOrQzIl
         gbCxtH56ra8t4qZXBD7WDSz6cDqV1GoLt7cjykY3yfPTw8EHZWpfyMz3Nhcng9gdvWuS
         DeaIymzvcRe7tl4J+6al1FxkbktzqQ7KvU4zGdYTO6aFhFUFqi45fyj35jMGD+3x+0Zf
         HQHs2mlkLB4EfO+M8PQ7UaVvtc09T/tRVTZgOOxLnNT78L20Gykn4ZoE1Qf+Cox7KNA4
         Pr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=plWsFHir5p4DRGNtXJ16ZewjYKiv99L+/+FfRv7s36c=;
        b=HP+f/FDJWk2lhat3oXr1fRzccgC8q2p2KgryhBJZOwGy25A4v9aGmDsY7yZ2piJXrD
         TpLIKgShupwQytY/vNMAE2hXOhGbNr+K3ndm1QfnEgo2QtZ1gwvFODqM/tCrpzd+kwHa
         vR1qJcF4IEZDtHZ5pdqv2lEGjTVmX00Vy3WaRA/DRgRWZ7L3zr0PAltQThXoq71vy4Nt
         WhgoEAPxPp0hmFGPAqy01tzCPynAJKhBTlIGmzoJaU0209RRBTYlFiv+olLlzukhcwNj
         sRGh07yUvE0cXJjcOolylvS6imNw8SlJFsyYWJTx6kcLxWrLGay+ilcs3ofeHWkTBHKs
         ZN/g==
X-Gm-Message-State: AKS2vOy6LPkk97eocAI40qhvwsClX0G2VgaMIN/x1U584oY8nfTmBYnp
        SnwiC0QCp9VYyoYgYTBg+DrZ7qfFgQ==
X-Received: by 10.28.193.137 with SMTP id r131mr1578074wmf.59.1497487241988;
 Wed, 14 Jun 2017 17:40:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.148.130 with HTTP; Wed, 14 Jun 2017 17:40:21 -0700 (PDT)
In-Reply-To: <1497444089.13409.108.camel@mad-scientist.net>
References: <CAMvDr+Qxjdgnm0aW3WenDpFs2NBhyrNXZA2M7sjsCjJs+RzM3Q@mail.gmail.com>
 <1497444089.13409.108.camel@mad-scientist.net>
From:   Yichao Yu <yyc1992@gmail.com>
Date:   Wed, 14 Jun 2017 20:40:21 -0400
Message-ID: <CAMvDr+TsdO5V694R5gpaWwyjkSHXW=QYG8n74ULVYZ5pbuY-zA@mail.gmail.com>
Subject: Re: Minor missing features in worktree compare to new-workdir
To:     paul@mad-scientist.net
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> 2. worktree doesn't seem to support multiple worktree on the same
>> branch.
>
> I think this is a very good thing about worktrees as opposed to
> workdirs.
>
> In a situation where I may want multiple worktrees pointing to the same
> commit I just check out the SHA rather than the branch: you can have as

Hmm, this could be workable. Though in that case it'll be nice to have
a easier way to checkout the SHA corresponding to a branch.

> many branches set to the same SHA (detached HEAD) as you like, and
> there's no concern about dirty workspaces.  This latter can actually be
> a really big problem (suppose the workdir contained some modified files
> then you update another workdir with the same branch... it's not easy to
> figure out what happened here!)

Unless it can cause internal corruption I'd still prefer to allow this
with warning/option. I have indeed cause dirty state myself though 95%
of the time it's because I forgot to remove the checkout that I'm done
using and the rest 5% being temperary state that I intentionally cause
(e.g. update in one checkout before hard resetting the second one).
