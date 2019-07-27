Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85CD01F462
	for <e@80x24.org>; Sat, 27 Jul 2019 21:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfG0Vme (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 17:42:34 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:36682 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfG0Vmd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 17:42:33 -0400
Received: by mail-vs1-f50.google.com with SMTP id y16so38348012vsc.3
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvnCKtm0RzimIsJCImajQ4VFUweSEDyOhYtj9bpqZ74=;
        b=fZOmArnSGjhDV9vZh8SvB3oZyplUn1W/nz8Myo9MG7RQxtYHsYNMaaU39LUJKFa2x+
         MdmeCopz2gkyfphS9MSn5fmTv5EVHk8VpmkmyjnOuK/y4Z1xLfRoxhLNyvbKD3HGfGwF
         2Wd8WnAqX7Db0c0ypJaWpHqrDLY9SODMs8xgecfJUZbGlmKkCUEXMBudadcuqGa6mRa9
         arazaaeInbwDK1K3pxGgPXXWPKfbOyhA6gvM4k6ACLLZI8xia3YgpjUZhi7ToxAd5n3W
         zQeQpqyOtiwCL6PHb9xz2nE+urXaX+URcp3sbQGid9V7k2hHbgpfgDjlN/p9bQJ732Y9
         tgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvnCKtm0RzimIsJCImajQ4VFUweSEDyOhYtj9bpqZ74=;
        b=aETi84El2bKoWoXeCeg7OC7az50/n2dz/AMJyoHPOT2Nt3VPAqtePRc+HsIikDURMo
         0BKzbWJ+ljBFYQ/QUZ1IoN5mOBv1ej53w1ZZiNiOx/ZWsu6xzK+AEAgLbmRh7xA9XljJ
         d1F9wBbpjvZMs80Z7wt+x8KSrLsiYNolv8Kq5QNZoZ+Br3Jen/FExwPbpxckp8+xZ9bC
         5Fx7bJyP0Ck/iBwXKPn0ktcnxwnixNXAUShzpqvtr6lf2nxDU41en/S3ANjzrdiQJj7i
         UvObqFBgjXQGeV+BmfKjnz0bG9N7xHnF+d87+JEjLlOGfVHzq/9j3c4SKWYYJtP+UfIG
         Tc4Q==
X-Gm-Message-State: APjAAAVNuxXorh3krZ1jfd/0SpQ2AmwQ7k1tOb3lAbEA5o+yho5bq64s
        Y2Tl8VoLzQyjedmwhVJiWgzvNGgD0AdgQwytOmLitg==
X-Google-Smtp-Source: APXvYqxiM48DVbrYDyFlF6BTuErR61CH949aYIbJz+d4304qm8AY9OMv4tjWispjzqsjNiutmCxAyz+vDBX74WcUYkM=
X-Received: by 2002:a67:8081:: with SMTP id b123mr65505332vsd.117.1564263752537;
 Sat, 27 Jul 2019 14:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEq+d=9G+U4im4fSEL2jGhggBwpoa+X7ZUjEGMPOPuFTw@mail.gmail.com>
 <20190727205732.16361-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190727205732.16361-1-rohit.ashiwal265@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 27 Jul 2019 14:42:20 -0700
Message-ID: <CABPp-BHrfKsKu+=9+TEGmg8SZ6+nZdRNmSitxdwRucKGHvL9CQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 27, 2019 at 2:00 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
> > In general, once submitted, avoid rebasing unless needed to integrate
> > with someone else's work and clean up conflicts.
>
> I have not checked but git/git:master is like 569 commits ahead of
> r1walz/git:master, there _might_ be conflicts. Should I rebase if
> need be?

First get your topic ready using the same base as you did for your
earlier submission(s) of your series.  Then when your changes are
ready:

* Try to merge with origin/master.  If there are no conflicts, undo the merge.
* Try to merge with origin/next.  If there are no conflicts, undo the merge.
* Try to merge with origin/pu.  If there are no conflicts, undo the merge.

If there are no conflicts in any of these steps, submit the next round
of your series.  If there are conflicts in any step, there's more work
to do.  If it conflicts with master, then yeah, just rebase on master.
If it conflicts with next or pu, there are a few different steps you
could take: (1) rebase on the topic that yours conflicts with
(assuming it's just one), (2) rebase on next (if next conflicts,
though this means your topic can't advance until everything else in
next does first so is strongly discouraged), (3) if the conflicts are
small/trivial you could just submit anyway and prominently call it out
in your cover letter.

If there were any conflicts or you rebased at all, make sure to call
it out in your cover letter, especially if your series depends on
anything not in master.  And if you did anything other than rebasing
on master, then expect a discussion to start around who should rebase
on whom and what order we want to apply topics in, and maybe other
steps to take.

Elijah
