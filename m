Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61951F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 15:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeKTCTv (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 21:19:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39692 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeKTCTt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 21:19:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so5758092wmc.4
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 07:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vva+IMv8REsiSdT0gMMxeYoPHjPrC4FPexk22ixDOhs=;
        b=c257zUwdZq/JQtkkp4kjHKDWLft75kdTU3nzZxTUrA2DC8yFpe3GtnGG3c/uWTQTfX
         VJ86qy9i/FD2qjz3CSCd5UkF+jUhhyCSAwQCXep5Ke71KeMpHDvrhg7VLcSyArMXAbc8
         FrhjAdWI+O2rFg7gWQU/Ezzshk/2QrLevMYCck5l9ZpUqmuh/MjQEsqsjUDgVrj9Ku8X
         JDn5o1H3VZKVYDWMwgfUe/OlmRr6tM2FVloEFLMeWo/nayoTHm1nOGenEfxjZIzMEnfp
         3fyb/zbUWT+lGXS9/0oz6Kke2RBDjnQrs5Uj6yupE8TIQs0vPB/DcxbuNLog/fGkeZOD
         yY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vva+IMv8REsiSdT0gMMxeYoPHjPrC4FPexk22ixDOhs=;
        b=XiULaOnagFbF9Z1zm5bUWnLRbqk7lGID8VkMAYv9uwpsl2M3Q5lm1D9MW82waZfD8X
         hsYqX7ufaQ3hf+LFTmKLTEZXmhljmfIyW4fgTQ9H0n/5aTkyv7m6ULZGIIBjRkvx5FoE
         OnzoiakyGMXWK58gs5W5lTwbfxJro2wZl/DT84XL5m6rRuqQHrNxbBl1fkyB//CFfbsP
         BgUfdQII4uHgGrpWfaGhEILUkD+r86AXyHgYJ/cRNeAOoYhkgOrg14z2+YwrciKNNz06
         UiZkTgdYW4xHlPxDqRtB/n+G4vKykQ4PWfN5uVCHxkO7ZT3aL2khHCWvMN613BJw9mfR
         51Bw==
X-Gm-Message-State: AGRZ1gLRaGLctJDh5cc32b2zgZY/vUDSIo1PqFZeOkMfLXzdyUOa2e1Y
        pLl2UMq8VqGqSrQdOU0wV5Q=
X-Google-Smtp-Source: AFSGD/WbwOJQae4aoPruAI0L+G8lpbR0VELyeT7Onrgv+m9EKUhjUtQFfcfKsWdwXZf6Wld5Dh1dlA==
X-Received: by 2002:a1c:18c:: with SMTP id 134mr6745131wmb.94.1542642948772;
        Mon, 19 Nov 2018 07:55:48 -0800 (PST)
Received: from szeder.dev (x4db04f16.dyn.telefonica.de. [77.176.79.22])
        by smtp.gmail.com with ESMTPSA id h67-v6sm43055553wma.10.2018.11.19.07.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:55:47 -0800 (PST)
Date:   Mon, 19 Nov 2018 16:55:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
Message-ID: <20181119155545.GT30222@szeder.dev>
References: <20181115005546.212538-1-sxenos@google.com>
 <nycvar.QRO.7.76.6.1811151344490.41@tvgsbejvaqbjf.bet>
 <CAPL8Zitk1UBxpVCRWc-SV+1MtaOCJUOYUqCh7eJQcdR_wqpNfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPL8Zitk1UBxpVCRWc-SV+1MtaOCJUOYUqCh7eJQcdR_wqpNfQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 17, 2018 at 12:30:58PM -0800, Stefan Xenos wrote:
> > Further, I see that this document tries to suggest a proliferation of new commands
> 
> It does. Let me explain a bit about the reasoning behind this
> breakdown of commands. My main priority was to keep the commands as
> consistent with existing git commands as possible. Secondary goals
> were:
> - Mapping a single intent to a single command where possible makes it
> easier to explain what that command does.
> - Having lots of simpler commands as opposed to a few complex commands
> makes them easier to type.
> - Command names are more descriptive than lettered arguments.

Subcommand names and --long-options are just as descriptive.


> Git already has a "log" and "reflog" command for displaying two
> different types of log,

No, there is 'git log' for displaying logs in various ways, and there
is 'git reflog' which not only displays reflogs, but also operates on
them, e.g. deletes specific reflog entries or expires old entries,
necessitating and justifying the dedicated 'git reflog' command.

> so putting "obslog" on its own command makes
> it consistent with the existing logs, easier to type, and keeps the
> command simple.

> - We could turn "obslog" into an extra option on the "log" command,
> but that would be inconsistent with reflog and would complicate the
> already-complex log command.

On one hand, it's unclear to me what additional operations the
proposed 'git obslog' command will perform besides showing the log of
a change.  If there are no such operations, then it can't really be
compared to 'git reflog' to justify a dedicated 'git obslog' command.

OTOH, note that 'git log' already has a '--walk-reflogs' option, and
indeed 'git reflog [show]' is implemented via the common log
machinery.  And this is not a mere implementation detail, because "git
reflog show accepts any of the options accepted by git log" (quoting
its manpage), making it possible to filter, limit and format reflog
entries, e.g.:

  git reflog --format='%h %cd %s' --author=szeder -5 branch file

I think 'git obslog' should allow the same when showing the log of a
change.


> Personally, I don't
> consider a proliferation of new commands to be inherently bad (or
> inherently good, really). Is there a reason new commands should be
> avoided?

If a user wants to deal with reflogs, then there is 'git help reflog'
which in one manpage describes the concept, and how to list and
expire reflogs and delete individual entries from a reflog using the
various subcommands.  If a user wants to deal with stashes, then there
is 'git help stash', which in one manpage describes the concept, and
how to create, list, show, apply, delete, etc. stashes using the
various subcommands.  See where this is going?  The same applies to
bisect, notes, remotes, rerere, submodules, worktree; maybe there are
more.  This is a Good Thing.

By adding several new commands users will have to consult the manpages
of 'evolve', 'change', 'obslog', etc., even though the commands and
the concepts are closely related.


