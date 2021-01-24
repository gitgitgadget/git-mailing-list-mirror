Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB60FC433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBDB22CB9
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 08:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbhAXIwQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 03:52:16 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39460 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXIwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 03:52:09 -0500
Received: by mail-ed1-f51.google.com with SMTP id b21so11575763edy.6
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 00:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3a4f4yonU526aPQDB6OMzfyzdvD+LNsxHFC3FcFeBY=;
        b=kAkxMVezTlgKIlkdSdO6YIk3I/7qbPaCRfOwdSqh9/tFQoNmtNAVD302AYMrQxOpEQ
         2YsCeAmxdELeqAUZ27HRK/o76mjxQwy+lUuaK7eIAUoSI+cbZGv2rqr2VujQGmCD7DJx
         MsQt0vKSUAvzhDrjke16CB3nCoORrFZeWzhk53vkIGFdtcDAiMqpcsd2jlN61ahTXONH
         XSb9t3tK54pkZuo4aTx5GkOGw0gxXdljC45jaufKpLo8L96DQze+bJAhVnibkL9P770P
         lsOduvDGsSbWNs/PZsd5ifMr/7zlzajO9wr1EonKEZU4rsyqxmQC7h9YV6n7J8sX2zp3
         TOkA==
X-Gm-Message-State: AOAM532M7XTvNlB/vaUcVFjlDW44O9sXa6ITWVAdG9166KvrHNGsmwkn
        nVNkm/iPvCujExWK/4PXyFiO0YPZTKon4N7/uJsZ4IcICEHZCA==
X-Google-Smtp-Source: ABdhPJyBFT5dmWFJwrf1MUsNTHLh6qbZVfFPKs9atxOSlIkJ/SvUID4zVCfRjcK0Y72Be2gzVzw+ssriSjpVtpqZz+4=
X-Received: by 2002:a05:6402:3088:: with SMTP id de8mr688008edb.221.1611478287205;
 Sun, 24 Jan 2021 00:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Jan 2021 03:51:16 -0500
Message-ID: <CAPig+cS8ZPwkVZZbfsndd-sYV=oWsLUYsmDAqL3FTYsTFgmguQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] teach `worktree list` verbose mode and prunable annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Changes in v3
> =============
> v3 is 1-patch bigger than v2 and it includes the following changes:

Thanks. I gave v3 a complete read-through, and it is just about perfect.

Aside from a very minor problem with the tests in [5/7] and [7/7] and
the documentation enhancement (`core.quotePath`) suggested by Phillip,
this is really, really close. (In fact, I would be happy to accept v3
as-is; those minor changes could easily be done on top.)

I look forward to giving v4 my Reviewed-by:.

> Range-diff against v2:
> -:  ---------- > 1:  66cd83ba42 worktree: libify should_prune_worktree()
> 1:  9d47fcb4a4 ! 2:  81f4824028 worktree: teach worktree to lazy-load "prunable" reason

The range-diff seems slightly off. The "libify
should_prune_worktree()" patch existed in v1 and v2, but the
range-diff suggests that it's new with v3. You probably just need a
minor adjustment to your `git format-patch --range-diff` invocation.
