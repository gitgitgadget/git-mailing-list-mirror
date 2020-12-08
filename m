Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F00C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0119923B3E
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 17:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgLHRnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:43:23 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45315 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHRnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 12:43:22 -0500
Received: by mail-ed1-f44.google.com with SMTP id r5so18410652eda.12
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 09:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z66jsszaznKc1xzO3k31ooNfxKIb1eOZjYKnLIhv3hM=;
        b=WoJ4jLtRrePOVJZdjUiQjRGkBcwiI72cSJItEr2jQP03hE7ZFjPDnFn8jENa2v+MXt
         zrZReLT0xZbBIAuM11xEnfUt6QS0l6gLMkUc0QJ4v6LcnDhSkmLGFGqHmvCZwgPL8xXY
         8CYvmfzyz7WtVnglV9E+GGnqfr8Y7DaH9wTY6V/fxJTZdQD1OX1hvgYtEJo+CJ37cEA+
         JZ9uO26skhmflS6iEMmxjPwdMz2OxXzxH1GkNYCYW034zfCgQSAAuIPXZWIRD+tJlW97
         n+ufzIj+XbK7MFAZC75ASTB2j2QSNVUXlBO9zgn9Ro8CRS9PXn+djur7/qc0VCsClSSp
         t1rQ==
X-Gm-Message-State: AOAM531otTnbxfb/0pw8s/Sll3MCXD89TjN8lHhC1URwhordL4tVx+bU
        7a7jAP+7QY959qtBO+x6wEY8GTyQ3c+WRKir1TIzLEiDpyk=
X-Google-Smtp-Source: ABdhPJxZ1ebiSwSrnKegDMpjxQ47V2o+8pF8zY/O9P4L6Gr+eYGvb7GrNFHiR8Oc3zESqoCTOdI1aG+JcAC7XEMINlc=
X-Received: by 2002:a50:ab51:: with SMTP id t17mr25775465edc.89.1607449354856;
 Tue, 08 Dec 2020 09:42:34 -0800 (PST)
MIME-Version: 1.0
References: <63AC7AC2-5D32-479B-BF9E-0E5C31351A1B@gmail.com> <CAPig+cT=-nNcfrzjSmTXymhFkB22bPFE6QRKXqPtat2ipUdboQ@mail.gmail.com>
In-Reply-To: <CAPig+cT=-nNcfrzjSmTXymhFkB22bPFE6QRKXqPtat2ipUdboQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Dec 2020 12:42:23 -0500
Message-ID: <CAPig+cSEHR+S+y66zm5HFQCybtino0Ne=Z7qwB7tsc50pi1kpg@mail.gmail.com>
Subject: Re: 'git worktree repair' can't repair when main and linked worktrees
 are moved
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 4:22 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Dec 4, 2020 at 6:14 PM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
> > I've had to move all my Git clones to a new filesystem.
> > Several of them use secondary worktrees [...]
> > I had hoped to use the new 'git worktree repair' command
> > but it seems it does not work for this use case.
>
> This is a situation which `git worktree repair` can not yet handle.

A patch[1] addressing this shortcoming has been posted.

[1]: https://lore.kernel.org/git/20201208173705.5770-1-sunshine@sunshineco.com/
