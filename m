Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17B71F461
	for <e@80x24.org>; Mon,  1 Jul 2019 01:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfGABhT (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 21:37:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41000 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfGABhT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 21:37:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so3696274pgj.8
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CY/cigdIsZ06wo3ypY12Mx0HaNrU1KVo2hH8zSuL8Hs=;
        b=RWSx5ygobKcXlxG909eTbkQFKL1YA5FmzFmabFuZumfW45B52GIUkozVo6lBka3NTP
         7M/iIfAbwZH+bgFJvMCMSrTRuvjKRofuIfb34pYFcf1hMr861cuEQvcFeN+ogeBgWkcM
         xUhh5DImZCx1VBg+/LgfJKQH8PzWa5A7j/+V92HHkrFbUvg4QEyAUhSkQRiacxRHXb6k
         fsG+zwKgE7sY7isvBMNiBQbWo2qIeVYYd6TIyCrlV8Hl3WooBeH0Gb26EYHdKWEZCLWC
         uuUE+6dfqCEcZNqPCa3pLf11LtC6FwaOt0QAE6fRVH05S3ia956rJFh/SYQ6+diBNq7j
         GM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CY/cigdIsZ06wo3ypY12Mx0HaNrU1KVo2hH8zSuL8Hs=;
        b=t/0QfP5dksDySKWqX6kh4Boak2xAAkm10VbhShdv1INv/Ne0vuDViDVLS4yq/oAKIV
         Ri3ySIzkD4tw1ZQqT8txmTfuk9O4qYcdN6cRWBM6iEBomjidaUsYtD56yVHGDG/JGZMM
         LJob3pwO3A9BS+HIZRwQnhJPTtUXxzQcyWw70Jg1LbRhBz0Swc5sIb98gXWB50XzwIzu
         XJVoF4lK6i2o1earoDQh1wX+3ZXMrGRpla4nEFGH9qivc2+HOj2g1rUBjBBBNPLKLe53
         lANAe3RIM3UtpZNwzW6JPZ35edqYu/NbVv0C0Wr3AcWFcJVn429H1/efZj44tNE16baq
         GEVw==
X-Gm-Message-State: APjAAAVeil7sU+cBKuFNbOCLjYkeUzIB1DFdOhfG72iVOBf4L7nZDh39
        uLk+TiW07o0WSy4pWQasEPsEB11zIWUf2MYZPCAn8iwF
X-Google-Smtp-Source: APXvYqy8fA4GIfPbP9p04kuRIQK0IZ9UPoHc5awmtYXHhUKCq5tG74IlAQ2IXrnSuDC1eDOewNwtkdKYwGIowTN9YrQ=
X-Received: by 2002:a63:6b07:: with SMTP id g7mr22567127pgc.325.1561945038642;
 Sun, 30 Jun 2019 18:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190630051816.8814-1-eantoranz@gmail.com> <20190630065358.GB31264@sigill.intra.peff.net>
 <CAOc6etYMzOpEDs1GpLChAEhp2SbZcKjO82S=qm4P-t6SkUEWcw@mail.gmail.com> <20190630223951.GB21696@sigill.intra.peff.net>
In-Reply-To: <20190630223951.GB21696@sigill.intra.peff.net>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 30 Jun 2019 19:37:07 -0600
Message-ID: <CAOc6etZxHWQ24TNsYDf74zgn-VJzbwDsxWxO4-tMkvv92KRKkw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 4:39 PM Jeff King <peff@peff.net> wrote:
>
>
> But perhaps the squashed version is easier to work with for further
> modifications? I'm not sure how, though. Certainly in your example
> rewriting changes in F1 with "rebase --interactive" would be a pain. But
> I think the end-state of the tree after your rebuash is identical to
> what you'd get by just merging from master. So in either case, just
> building new work on top should be the same.

> I'm still not quite sure of the greater workflow where having the
> rebuash-ed commit on the feature branch is more useful than just having
> a merge from master.

Hmm... I as a gatekeeper would rather get either a straight line of
revisions for a feature with no merges (even if a final merge takes
care of solving conflicts with the upstream branch) or a single
revision (if I thought that the change is not worth having more than a
single revision). I'd ask the developer to rebase the whole thing and
give a straight line (with rebase -i or cherry-picks) or to give me a
single revision (where rebuash would come into the picture).

Also, I wonder how it would make life easier for people that are
learning to use git and the command that they see thrown around very
often is to use `git pull` in order to get updates from the other
developers.

But that might be me being opinionated.

PS About rebuash ordering not to use commit: Sure, at the moment,
rebuash is not commit-safe.... or merge-continue-safe.... but I can
add checks for that in case the user runs them before using rebuash
--continue
