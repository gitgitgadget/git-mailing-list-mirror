Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59F91F404
	for <e@80x24.org>; Sat, 30 Dec 2017 00:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbdL3Aw2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 19:52:28 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:47008 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdL3Aw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 19:52:27 -0500
Received: by mail-qt0-f181.google.com with SMTP id r39so55732531qtr.13
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 16:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SBqRPQ+9N0LYNg4KByd9k9em2n7QtEH41pdkvxNXJMs=;
        b=MkYXu1iND0+TDiMHyvqGXAX6jOdfGgUMJ2IzIPjQ/P/IKJQnkHphE3zjTw5D/Omh9C
         TBHjnf7wdOZ9DVALB8z2ARJzY69DBkwxmKv02QZUk1Oum0Ef8k3SwxMOh3AuPML8pwbt
         5DPwnv0pmm5iNQsEWWZotNibv/Ij0x0BhwJc27N/Kj9VvtrnlDtynvd5SHIOVvaJ2ts+
         RQp6tzqKsQ+hpgDlghlTxShBIiVMYQhET3FHvNNwa/h28exo+n2OVwrxxJ4g57bZPTzF
         v6FyIpxTNvQ0Ps8+BArTI3gwcDPkK/fY9iJgsaEeeak0qz/3yUPFZMAxBO8WA/3vfiX1
         3uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SBqRPQ+9N0LYNg4KByd9k9em2n7QtEH41pdkvxNXJMs=;
        b=E/ns3qkZ6KCUSiOHp+KA6L5BAkr0bLjM5pMtYMemBGTCgm4wSGLZAKwDSZ9IPklTjF
         InnylMqrHq9L5apY9uN47QZmJI6bJnr8ZLjouoNfvwJFnTr14gEfN8AO0jTeFmsdEm+f
         WxolXGVIC9XOAcLagy3ssMq5f0d6llUA6aSGds+GI1N/JZYEC6b2YCrA7t83qMrD43Cz
         my5DPlkw8GCzjq/3VDyaFSdyaix7C4HPtBHb9FJqayoXnEQwuHe6LUmRkBRzF2pdwQap
         c0/JC0EknY7oHQAr3AVNkjIQaY0YcpWGcFVKZf4CsY4qD5rqx92nSBGaVkAzNvNaGor9
         AlOw==
X-Gm-Message-State: AKGB3mJZz7gvgrO5BmuMdWyuCGlWJNiRy0Xj1zpHPN/mjpYZEVL0U7bh
        HhfqFQH5Abxerbhs3JruPVtnOZCi7Jg=
X-Google-Smtp-Source: ACJfBosJcn9pdZsAiB70NQWBQnaSgijKVFHs+qU5ggPRo+wg33Pd9DQqF9T+gWwBm7bQ4QYD8WzfeQ==
X-Received: by 10.237.37.85 with SMTP id w21mr29846019qtc.268.1514595146476;
        Fri, 29 Dec 2017 16:52:26 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id k63sm2245587qkc.42.2017.12.29.16.52.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Dec 2017 16:52:24 -0800 (PST)
Date:   Fri, 29 Dec 2017 19:52:22 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Keith Smiley <k@keith.so>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171230005222.GT3693@zaya.teonanacatl.net>
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
 <20171229224825.31062-1-szeder.dev@gmail.com>
 <87y3ll6s0e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3ll6s0e.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
>> I think adding 'rm' to completion definitely counts as advertisement.
>> It doesn't have much practical use, after all: typing 'rm' with
>> completion is actually one more keystroke than without (r<TAB>m vs. rm).
> 
> This is only one use of the completion interface, maybe you only use it
> like that, but not everyone does.
> 
> The completion interface has two uses, one is to actually save you
> typing, the other is subcommand discovery, and maybe someone who has a
> use neither you or I have thought of is about to point out a third.
> 
> I'll type "git $whatever $subcommand<TAB>" as *validation* that I've
> found the right command, not to complete it for me. This is a thing
> that's in my muscle memory for everything.

Is that meant to be in favor of including rm in the
completion results or against? :)

> Since I've been typing "git remote rm<TAB>" for a while (started before
> this deprecation happened) I've actually been meaning to submit
> completion for "rm" since it works, not knowing about Duy's patch until
> now.
> 
> Now, even if someone disagrees that we should have "rm" at all I think
> that in general we should not conflate two different things, one is
> whether:
> 
>     git remote <TAB>
> 
> shows both "rm" and "remove" in the list, and the other is whether:
> 
>     git remote rm<TAB>
> 
> Should yield:
> 
>     git remote rm<SPACE>
> 
> Or, as now happens:
> 
>     git remote rm<NOTHING AND ÆVAR THINKS IT'S BROKEN>
> 
> I can see why we'd, in general, we'd like to not advertise certain
> options for completion (due to deprecation, or just to avoid verbosity),
> but complete them once they're unambiguously typed out.
> 
> I don't know whether the bash completion interface supports making that
> distinction, but it would be useful.

It can be done, though I think that it's probably better to
subtly lead people to use 'git remote remove' going forward,
to keep things consistent.  I don't have a strong preference
for or against the rm -> remove change, but since that's
been done I think there's a benefit to keeping things
consistent in the UI.  And I think that should also apply to
not offering completion for commands/subcommands/options
which are only kept for backward compatibility.

Here's one way to make 'git remote rm <TAB>' work without
including it in the output of 'git remote <TAB>':

diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 3683c772c5..aa63f028ab 100644
--- i/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -2668,7 +2668,9 @@ _git_remote ()
 		add rename remove set-head set-branches
 		get-url set-url show prune update
 		"
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	# Don't advertise rm by including it in subcommands, but complete
+	# remotes if it is used.
+	local subcommand="$(__git_find_on_cmdline "$subcommands rm")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)

Keeping 'git remote rm' working to avoid breaking scripts is
one thing, but having it in the completion code makes it
more likely that it will continue to be seen as a
recommended subcommand.

This leads to patches like this one, where it's presumed
that the lack of completion is simply an oversight or a bug.
Of course, the lack of completion hasn't caused everyone to
forget that 'remote rm' was changed to 'remote remove', so
that reasoning may be full of hot air (or worse). ;)

The current result of 'git remote rm <TAB>' isn't so great.
It's arguably worse to have it pretend that no subcommand
was given than to list the remotes.

$ git remote rm <TAB>
add            remove         set-head       update
get-url        rename         set-url
prune          set-branches   show

I think completing nothing or completing the remotes
(without offering rm in the subcommand list) would be
better, after looking at it a bit.

I don't know how to disable file completion, but I'm not
intimately familiar with the git completion script (thanks
to it working so damn well).  I'm guessing there's a way to
do that, if there's a strong desire to not complete the
remotes at all.

I don't think we should include rm in 'git remote <TAB>'
completion, but I don't care much either way what 'git
remote rm <TAB>' includes.  But it should be better than
including the other subcommands.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
There, I've gone and soiled myself, are you happy now?!
    -- Stewie Griffin

