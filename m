Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C5D1F428
	for <e@80x24.org>; Sat, 30 Dec 2017 12:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbdL3MTc (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 07:19:32 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:41551 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdL3MTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 07:19:31 -0500
Received: by mail-wr0-f180.google.com with SMTP id p69so34616308wrb.8
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 04:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kQiEWdYAygYWJhjd/Ty2VY4GufPhTwfix7MHC0oiURI=;
        b=QYIPdgPjaGECxVAZgVVvQK176J0IrUbPmIJBQpinOuQfkGlwE0a2pjmusGBXxupMfG
         WnrokN/ygYnoukAVbynwri7hYqEWwHx6Vqi5di27B2jQ5k6oR64nQ4EvcOdqzW2FRUg1
         bimpxLNmh+lbWZqQurzxx/vozydu+WP1o12IjiC00VWI6rMEr3yhh0bh7Ibay8Ih9hLp
         7C72FOUN0tMe2QLf0oNdbBA30HMlqgtRONYqMW7Ke5A/FYM42TyCyPyagu9//ZKgh+C9
         EJSIee7uxe0w/C/NRYQf5Chfw+TpDH59CR2PvS3iy7Wt2XnmChPAxinIy8EW9K0Z3q6s
         bNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kQiEWdYAygYWJhjd/Ty2VY4GufPhTwfix7MHC0oiURI=;
        b=V6Kurx2SGxYFuOm6PSRXLxHNjHPqSYmzpHTHAK5tTCKtby1kaCd4aWR4/B6a5lSthp
         LCUj4/vFcp5bafvmltWxOFy6+pj47Tpr2gYUOS7ZZjoTneeIkKgB5oKR3XzFF6ixzDe+
         NQEx8kN6jSUlqzVJVH5LgYKAeHEiJIS+E/j++Aenq8fRoI41Pc8p6BugqDuyZZT+Ir8I
         L78wA9NvH6YkPYzLbpFyAC4GMHgkE6V7Vq9evzgyaiEdzSyiQAg6hoNdqAAZUfQGR70h
         +MICggWVFip2OmRgYZqgwq83faMmaiVH8BcZj+WaniaLBHoZ+dvN60572u2rep1brGaP
         JIfQ==
X-Gm-Message-State: AKGB3mLW0+OHqqu0guk9iZ7nozZ96c2V9OGppaURrRGJordzEUsglhid
        88VzdaIyUm+inFSRBthNgQ4=
X-Google-Smtp-Source: ACJfBovvI0b5mx2s/lbwRr7uFFw8N8DXLaP3m4g211uJ3GGIjCLW1ANB3jyWawZgfj/iSS5YNfd0/w==
X-Received: by 10.223.188.141 with SMTP id g13mr38565532wrh.169.1514636369533;
        Sat, 30 Dec 2017 04:19:29 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id b7sm44958316wrd.69.2017.12.30.04.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Dec 2017 04:19:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Keith Smiley <k@keith.so>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
References: <20171229135240.GQ3693@zaya.teonanacatl.net> <20171229224825.31062-1-szeder.dev@gmail.com> <87y3ll6s0e.fsf@evledraar.gmail.com> <20171230005222.GT3693@zaya.teonanacatl.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171230005222.GT3693@zaya.teonanacatl.net>
Date:   Sat, 30 Dec 2017 13:19:27 +0100
Message-ID: <87vago76i8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 30 2017, Todd Zullinger jotted:

> Ævar Arnfjörð Bjarmason wrote:
>>> I think adding 'rm' to completion definitely counts as advertisement.
>>> It doesn't have much practical use, after all: typing 'rm' with
>>> completion is actually one more keystroke than without (r<TAB>m vs. rm).
>>
>> This is only one use of the completion interface, maybe you only use it
>> like that, but not everyone does.
>>
>> The completion interface has two uses, one is to actually save you
>> typing, the other is subcommand discovery, and maybe someone who has a
>> use neither you or I have thought of is about to point out a third.
>>
>> I'll type "git $whatever $subcommand<TAB>" as *validation* that I've
>> found the right command, not to complete it for me. This is a thing
>> that's in my muscle memory for everything.
>
> Is that meant to be in favor of including rm in the
> completion results or against? :)

For.

>> Since I've been typing "git remote rm<TAB>" for a while (started before
>> this deprecation happened) I've actually been meaning to submit
>> completion for "rm" since it works, not knowing about Duy's patch until
>> now.
>>
>> Now, even if someone disagrees that we should have "rm" at all I think
>> that in general we should not conflate two different things, one is
>> whether:
>>
>>     git remote <TAB>
>>
>> shows both "rm" and "remove" in the list, and the other is whether:
>>
>>     git remote rm<TAB>
>>
>> Should yield:
>>
>>     git remote rm<SPACE>
>>
>> Or, as now happens:
>>
>>     git remote rm<NOTHING AND ÆVAR THINKS IT'S BROKEN>
>>
>> I can see why we'd, in general, we'd like to not advertise certain
>> options for completion (due to deprecation, or just to avoid verbosity),
>> but complete them once they're unambiguously typed out.
>>
>> I don't know whether the bash completion interface supports making that
>> distinction, but it would be useful.
>
> It can be done, though I think that it's probably better to
> subtly lead people to use 'git remote remove' going forward,
> to keep things consistent.  I don't have a strong preference
> for or against the rm -> remove change, but since that's
> been done I think there's a benefit to keeping things
> consistent in the UI.

We changed it in the past, we can always change it again, it's never too
late to fix the UI.

Now whether we *should* change/fix this particular thing is another
matter. I'm just pointing out that we shouldn't fall into the trap of
thinking that git's UI is an established platform that can't be changed.

The vast majority of people who'll ever use git will most likely start
using a version that we're going to release many years into the future.

I'm reminded of the story about the guy who decided makefiles must have
tabs, who didn't want to change it because he already had some dozens of
users.

> And I think that should also apply to
> not offering completion for commands/subcommands/options
> which are only kept for backward compatibility.

Yeah I think it makes sense to at some point stop completing things if
we're going to remove stuff, if we decide to remove it.

> Here's one way to make 'git remote rm <TAB>' work without
> including it in the output of 'git remote <TAB>':
>
> diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
> index 3683c772c5..aa63f028ab 100644
> --- i/contrib/completion/git-completion.bash
> +++ w/contrib/completion/git-completion.bash
> @@ -2668,7 +2668,9 @@ _git_remote ()
>  		add rename remove set-head set-branches
>  		get-url set-url show prune update
>  		"
> -	local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +	# Don't advertise rm by including it in subcommands, but complete
> +	# remotes if it is used.
> +	local subcommand="$(__git_find_on_cmdline "$subcommands rm")"
>  	if [ -z "$subcommand" ]; then
>  		case "$cur" in
>  		--*)

Neat!

> Keeping 'git remote rm' working to avoid breaking scripts is
> one thing, but having it in the completion code makes it
> more likely that it will continue to be seen as a
> recommended subcommand.
>
> This leads to patches like this one, where it's presumed
> that the lack of completion is simply an oversight or a bug.
> Of course, the lack of completion hasn't caused everyone to
> forget that 'remote rm' was changed to 'remote remove', so
> that reasoning may be full of hot air (or worse). ;)
>
> The current result of 'git remote rm <TAB>' isn't so great.
> It's arguably worse to have it pretend that no subcommand
> was given than to list the remotes.
>
> $ git remote rm <TAB>
> add            remove         set-head       update
> get-url        rename         set-url
> prune          set-branches   show

Although that's a bug that has nothing to do with remove/rm, because you
also get:

    $ git remote blahblah <TAB>
    $ git rebase doesntexist <TAB>

etc. showing you valid subcommands, when perhaps we should show
"warning: no such subcommand `blahblah`/`doesntexist`!" instead.

> I think completing nothing or completing the remotes
> (without offering rm in the subcommand list) would be
> better, after looking at it a bit.
>
> I don't know how to disable file completion, but I'm not
> intimately familiar with the git completion script (thanks
> to it working so damn well).  I'm guessing there's a way to
> do that, if there's a strong desire to not complete the
> remotes at all.
>
> I don't think we should include rm in 'git remote <TAB>'
> completion, but I don't care much either way what 'git
> remote rm <TAB>' includes.  But it should be better than
> including the other subcommands.
