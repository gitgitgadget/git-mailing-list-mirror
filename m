Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2050D200B9
	for <e@80x24.org>; Tue,  8 May 2018 15:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933020AbeEHPYf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 11:24:35 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:46294 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbeEHPYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 11:24:33 -0400
Received: by mail-oi0-f49.google.com with SMTP id y15-v6so28690699oia.13
        for <git@vger.kernel.org>; Tue, 08 May 2018 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4IYxSb/VxRsGD92X+sIw6e5p59vJE/a4kLdFl9mLIc4=;
        b=qqN3olWsX1HnBbaj0dat/110URQtiutrRcuE0Y5JywJne53ar+J8e2nmDxB9Ruq8/R
         +ymLCaPxvzP5+FPZ7p8JRyaMNMHYyQszKdVYuls9BT93Gq0TKkmH/EPmE9C1wUVL2NiW
         Nn0Mm33z9oa3qM8nkmXSILFpmr12hWNGHoLQ3UUaIn5C9mIAb8czkTTA1zUCb1YnJYEg
         chZVLR/JLNZKtc/2HJQnQ6yD9dqf+A4d21z5G+EOAFb7UkdXAvlst+9ree+oj9ZReDMH
         OwAvsRnlentKX2ovzqldEV2KbH4qy7RixTKo3I2q13KWv53xJcjVPAoM1RkysfPgtw5a
         ClXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4IYxSb/VxRsGD92X+sIw6e5p59vJE/a4kLdFl9mLIc4=;
        b=X1uLOrj5vzKm+wx3TfbfRMuevq8trc72CGAAIke4OnIki0Oy6gyto+b/TjpGyA+bxq
         RRgGFqN3lxsDI/2YXG4TmZ51nY6SKtyIjzHTfqV0P8N42qZVflOjYWqyK6IUCyEHnI+2
         HzmDM9Nb2fcPHn0AqQPNu06WGlNJ5Am1OU7HKN1V/cAM4hcXNKmUShQSNQiNizpGyyod
         HiMrdln1JgSYb93WDjmnfBZgHBeLkEjhLwklt7n5Eg2d+vh/auiHl5JO4YSG8qn9/TQ5
         Hs8oRhvopGYXK0a3GGcgtGqvCe5dFUsimdJfEs8d1FAYAXghKt178um207+sQNvn5IiF
         Vrag==
X-Gm-Message-State: ALQs6tBZjax+fIwaBqgcUNaM4CNnr6j37/72eCLQxQCZKeX4SUohWqMz
        A/KQLacTfSG6+VUEMO57sIYT/GMfrxT35hB7hddpcA==
X-Google-Smtp-Source: AB8JxZraaCjONYWK2EZ1iZ4nnfxem+oL3aowTG03yLQ1/gdYsyVSXxH4TZbs1gsOSTsD+4vuHx4DAArje5qqPoJMa7E=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr27380957oie.30.1525793072459;
 Tue, 08 May 2018 08:24:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Tue, 8 May 2018 08:24:02 -0700 (PDT)
In-Reply-To: <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 May 2018 17:24:02 +0200
Message-ID: <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 7:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> I haven't looked at the implementation, so this may be an entirely
> stupid suggestion, but would it be possible to instead render the
> completions as?
>
>     % git checkout --<tab>
>     --[no-]conflict=                   --[no-]patch
>     --[no-]detach                      --[no-]progress
>     --[no-]ignore-other-worktrees      --[no-]quiet
>     --[no-]ignore-skip-worktree-bits   --[no-]recurse-submodules
>     --[no-]merge                       --theirs
>     --[no-]orphan=                     --[no-]track
>     --ours
>
> This would address the problem of the --no-* options taking double the
> screen space.

It took me so long to reply partly because I remember seeing some guy
doing clever trick with tab completion that also shows a short help
text in addition to the complete words. I could not find that again
and from my reading (also internet searching) it's probably not
possible to do this without trickery.

> It's also more intuitive than that lone and somewhat weird-looking
> "--no-" suggestion.

It's not that weird if you think about file path completion, where you
complete one path component at a time not full path, bash just does
not show you full paths to everything.

I'm arguing about this because I want to see your reaction, because
I'm thinking of doing the very same thing for config completion. Right
now "git config <tab>" gives you two pages of all available config
variables. I'm thinking that we "git config <tab>" just shows the
groups, e.g.

> ~/w/git $ git config
add.              interactive.
advice.           log.
alias.            mailmap.
am.               man.

Only when you do "git config log.<tab>" that it shows you log.*
-- 
Duy
