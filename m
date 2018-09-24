Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532F11F453
	for <e@80x24.org>; Mon, 24 Sep 2018 15:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbeIXVUH (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 17:20:07 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36829 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbeIXVUH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 17:20:07 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so2259452itd.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0mHSFe/ijFfoeXCGiM7xlCNMznHN7Cxx0ntvHrapes=;
        b=qZBjUKTNMXbFBSbEOkFMey4ip3/DwRmjsQw+L25dfADqUjMaubnVqFt+jxmq9XlhBa
         5wO9Zd0GqKpGu4SgDVcGhORds7/QJqhn4UhGF1mrrqWNkSkQLAXCicISD2/VToykDVKN
         wVvyacHCHkKxMIHIalI0sZsBKCrxBaNm4bBUR84iPTkNvYhA9yVp/mhgMg4tyMBdnh+6
         8xzjGXyPUsRXJwgwXCk700YPnoN4ocCeV4GT62nCBHLOUvDgWitJCura/qFEHq36yMoz
         19WpefXzwHUdDNC8h9i4ft8/B6sb81ROeCX3ZTLNpM6mcDdpDaAgvnh3iX8PCa4oO3Ii
         zXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0mHSFe/ijFfoeXCGiM7xlCNMznHN7Cxx0ntvHrapes=;
        b=AgIPIxjf8MBvCOPtAF9MVu3wcAYDsEXz7LipjZi6XcoR3HobnJ2Pt7zOYyEoTISbS1
         ztwKUzVyRR6xq0PCMUPbUJKLYNyrlK5/jTwiGObtivZwRZqsn8xFrGp/3E5NFlGTXfPW
         j6nWYvYsDCvQ9ahr/OyciyohNl8jpwGO8M+7zeaWYS+yVnPKFWEoxtQ4thmhSQu7yjnh
         jy+ZzRqsfh1X509lSOB4rKRlBsKCLxwpqHWUIBRbN2wqhOypflSCyMx4gFnAn6Xi9ODz
         uwX5kOKOBvoNoNjKKGzYY1VGehkmKMIvyNg+pI3T+rAKD6m09wTsC79rj2f+EoMov7P3
         OlkQ==
X-Gm-Message-State: APzg51AOAbgRWdD0vCq1ANZ7zqCWUYNAIP20Y0kDe25S0QM/ZVirXc97
        fcrKKQNv5TFh2SfPytUWngt0eMBsvrQZAxQc490=
X-Google-Smtp-Source: ANB0VdaNgbKfUYbNzekxus350GWGb6IEiVUeA8UH8PREBfOpytEz0TR2Etx4jfRj9GlE8xwnpB1w/sE33GtIWJHiGX8=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr8271086ita.5.1537802247047;
 Mon, 24 Sep 2018 08:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
In-Reply-To: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Sep 2018 17:17:00 +0200
Message-ID: <CACsJy8D_37U+4sb7tb8KqGM=_3CRrTaZX1ZE9VqDVrYJT-AhnA@mail.gmail.com>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a worktree
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 10:19 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi,
>
> I was actually trying to automae the building and installation of Git
> source code to reduce my burden. I tried to automate it with the help
> of a script that runs daily via cron and a separate worktree used only
> by the build script.y run
>
> The script typically fetches new changes for the next branch by running
> the following in the build worktree (which is not the main worktree):
>
>    $ git fetch origin next
>
> I thought that would result in FETCH_HEAD pointing to the latest
> changes for origin/next if the command succeeded.
>
> Unfortunately, it seems to be behaving weirdely when run in a worktree.
> It sems to be behaving as if I ran 'git fetch origin'. To add to that
> confusion when I run
> ...
>    Why is this weirdness happening when run in other worktrees?
>
>    Why isn't 'git fetch <remote> <branch> not fetching the changes for
>    just the specified branch?
>
>    Am I missing something?

Yes, some bugs. It behaves correctly for me. There must be something
strange that triggers this. What's your "git worktree list" (iow
anything strange there, duplicate worktrees perhaps)? Also please try
"git fetch" again with GIT_TRACE=1 and GIT_TRACE_SETUP=1. Hopefully we
could catch something with that.
-- 
Duy
