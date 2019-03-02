Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9020520248
	for <e@80x24.org>; Sat,  2 Mar 2019 04:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfCBEHM (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 23:07:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34332 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBEHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 23:07:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id o10so155592wmc.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 20:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7w81cm7kKsUtZExDvWCryfTlrP/XXgmm77twn3B7MBM=;
        b=UyA3TIb8szOuOuDMWUbY1l5222ZQzigDxvh1d1GqFHD8S4xrpHyQYjvTMaukVplqhJ
         B/SoQpVz969fJytwdaqs/5Whbb59DGe4TKUoBCnmii2tHuCU8JW1H5Iv8gAz3SaoFscg
         pe+LVg81ir58bbueJl3QGic8B+KwTEbcNPoCpL0NV7peKVyUarM1Iuvu/7d7Re++cFd7
         K/h7iRx3AlFxPXNg5KGHkukM4rT1xjZi2WEm5uArwqmXgStF/W9m4h0rj7uhbKVJPZGj
         EzUiLb4/5NfB3iNeo8avTTwMek0tIsV60gqc6k8DBhBJ22YflbBPHzm0R8oi/xWurdzR
         Xasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7w81cm7kKsUtZExDvWCryfTlrP/XXgmm77twn3B7MBM=;
        b=sdQYOlqSrBEYcpvDziLgyt5PA43nOiXtYUXqAnjKk39PfJTGMRjfJwDXpLT7WoGo/m
         BkRNOW0ABa597NklsujLLIcPH1/XIzyMVYy3n5mqPTxcjcgl7z6NWqFYtm+WGtAg+B5L
         tmgB5NHTUeC391o/VeE8BTxZQUDH4FMrqbZLsI6DHJ+3F7p5mMdATDgs/2dWNyWOTiPp
         FBANtnTGNkojlbLW3FrHjALcnWi2pZtmS1tMAL/bkQP0Z+d1zmhsk9kcDt8IH1sMVmiK
         8cAnO/jfA+6KI4meExqEw5O66rpDzl+HabTVWiBksv2Pbx9I2vEO8SPw0Ofe3cjWwfjz
         Sl+A==
X-Gm-Message-State: APjAAAXPUs+5Qcc9/JjNUjK+XYLcEPkWKXj1QtREWv0+w2U2cdW80qJO
        jiV9gDP3CjfEtRPbxORAZig=
X-Google-Smtp-Source: APXvYqxJ06xfwsgJ0HwSlFRixVRPCiUjrGt5yvV44PC9r8xmkmM3ajqBPPkKf4AQ5HDhrAHTv9qhKw==
X-Received: by 2002:a1c:cb86:: with SMTP id b128mr4910220wmg.46.1551499628933;
        Fri, 01 Mar 2019 20:07:08 -0800 (PST)
Received: from szeder.dev (x4db3813f.dyn.telefonica.de. [77.179.129.63])
        by smtp.gmail.com with ESMTPSA id r63sm565235wmr.32.2019.03.01.20.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 20:07:08 -0800 (PST)
Date:   Sat, 2 Mar 2019 05:07:04 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190302040704.GN19739@szeder.dev>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-1-tmz@pobox.com>
 <20190301183017.GB30847@sigill.intra.peff.net>
 <20190301221551.GD31362@zaya.teonanacatl.net>
 <xmqqef7q6pm1.fsf@gitster-ct.c.googlers.com>
 <20190302024011.GF31362@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190302024011.GF31362@zaya.teonanacatl.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 09:40:12PM -0500, Todd Zullinger wrote:
> Hi,
> 
> Junio C Hamano wrote:
> > Todd Zullinger <tmz@pobox.com> writes:
> > 
> >> Hmm.  The comments in list_cmds_by_config() made me wonder
> >> if not using a local repo config was intentional:
> >>
> >>         /*
> >>          * There's no actual repository setup at this point (and even
> >>          * if there is, we don't really care; only global config
> >>          * matters). If we accidentally set up a repository, it's ok
> >>          * too since the caller (git --list-cmds=) should exit shortly
> >>          * anyway.
> >>          */
> > 
> > Doesn't the output from list-cmds-by-config get cached at the
> > completion script layer in $__git_blah variables, and the cached
> > values are not cleared when you chdir around?
> 
> In testing, I didn't find any evidence of caching.  Setting
> commands to be added and removed in the global and local
> configs worked reasonably.
> 
> Duy's reply suggests that was considered but not
> implemented.  I there were caching (and if it were tedious
> for the completion code to keep fresh between repos), then
> it would a bad plan to allow per-repo config.

The completion script used to cache the list of porcelain commands,
but then Duy came along and removed it in 3301d36b29 (completion: add
and use --list-cmds=alias, 2018-05-20).

We cached the commands, because it was a bit involved to get them:
first we run 'git help -a' to list all commands, then extracted the
command names from the help output with 'grep', and finally an
enormous case statement removed all plumbing commands.  Caching spared
us the overhead of these external processes and maybe 2-3 subshells.
Note that because of this caching if you dropped a third-party
'git-foo' command in your $PATH, it didn't show up in completion until
you re-sourced the completion script, which was the standard way to
invalidate/refresh the caches.

However, even when we cached porcelain commands, we didn't cache
aliases, even though getting them is a bit involved as well, requiring
running 'git config', two subshells and a shell loop.  I presume that
back then the reason for not caching aliases was that they could be
repo-specific.

Now, ever since Duy revamped commands completion, we only run a simple
$(git --list-cmds=...), i.e. a git command and a subshell takes care
of all that.  IMO this is the best we ever had, because it uses one
less subshell than before to list both commands and aliases, and it
lists everything afresh, including third-party 'git-foo' commands.

I don't see the benefit of bringing back caching.  Yes, on one hand we
could complete commands with a single variable expansion, which is
clearly faster than that $(git --list-cmds=...).  OTOH, that's only
commands, but what about aliases?  If we cache aliases, too, then that
could be considered a regression by those who do have repo-specific
aliases; if we don't, then we are back at running 'git config' and two
subshells, i.e. one subshell more than we currently have.

And if we won't cache commands, then we might as well modify
list_cmds_by_config() to read 'completion.commands' from the
repo-specific config, too.  I'm fairly neutral on this, because I
can only imagine rather convoluted scenarios where a repo-specific
command list would be useful, but at least it would make it consistent
with aliases, which we read from the current repo's config and we
always have.


Note, however, that for completeness sake, if we choose to update
list_cmds_by_config() to read the repo's config as well, then we
should also update the completion script to run $(__git
--list-cmds=...), note the two leading underscores, so in case of 'git
-C over/there <TAB>' it would read 'completion.commands' from the right
repository.


