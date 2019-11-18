Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F25A1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 22:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKRWi0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 17:38:26 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:46292 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfKRWi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 17:38:26 -0500
Received: by mail-pg1-f180.google.com with SMTP id r18so10285398pgu.13
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xcBDmQIe8SB+gAwNxPQx4mq+iAERn5apIGttbDG2jns=;
        b=GM84nGod8pD2vA5WkvFdIZOu6ziZmJXox8g0OMjvp0DpLHEZSc6VMHBdCW8PlR2DKl
         +Q9oW8nHIFgGbAt40uy2CyQRYMyN61qC86Nzyv2yUFf9/PbJCgYz1XpcAAHLwioZqsAH
         06MlUapGUK7fr7MfyeBBDcVYGXnO5Ieeo0YmzNwaq/hSdNXCEIP6h7zraC1Ye0ElInZ+
         odeQ6GW9ZUQWe3Jx9qgSdiULNcuHFNumGDDQlaZNaQaZZUbl9vgGpZVRSO0uR/5DXDsk
         0MoqeUriuS6b7YL5zvxH3wYF2j6RKKh3aEGr2oAucCVnrLR8VXn9vsOpv7zIxWjkaNV0
         W42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xcBDmQIe8SB+gAwNxPQx4mq+iAERn5apIGttbDG2jns=;
        b=ohn9uFt+GYEiVR2uGuXYJIh/r3BUAA/Ti/Z5nTCqHubYQSZHgYSzSBdflDDYAgcinB
         Xk/YRA82obAPKyhbkUArBcUvBivUHh8ta5ONdUGi+qj7s+DalDIk5lvOk995kvJhTq/S
         ea0qGU+1faIF5Hi4Z1IPqt54p3xNqxM4QNaB+bFUdJEvlJL0VxSAf1MKm46YF0x6qeX2
         RHVIH2LWjUORKAUAn6fZUZ6nWT0tSaxdNrpwaKbTxcayp8q/XwkBlNyCqpfvci7EFO1O
         /QHooB8BZ3lr3OmKw6qjutkFDz1XqEQp6GYBeXN+CK9lxx9cv75Ccfx5JKc9RDfNTwX8
         TaaQ==
X-Gm-Message-State: APjAAAUUxTTdQE+nYgeCmqlQcaksq7gY+I2RXO0nWbymRzrDnGYrAoZe
        MUe+ZE+JRef+69aHp5AiERJDkE+URkc=
X-Google-Smtp-Source: APXvYqxAL328hZ5AN/uKC4pJ5cyj7G8WFP5rCpcEA/vXOjKUOQrGiKFxVzSY9DX+5mRAiCXyYMQjmQ==
X-Received: by 2002:a63:1c1f:: with SMTP id c31mr1825109pgc.292.1574116704214;
        Mon, 18 Nov 2019 14:38:24 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id s15sm715760pgc.3.2019.11.18.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:38:23 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:38:19 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191118223819.GI22855@google.com>
References: <20191116011125.GG22855@google.com>
 <20191116054501.GA6538@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116054501.GA6538@camp.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 16, 2019 at 05:45:01AM +0000, brian m. carlson wrote:
> On 2019-11-16 at 01:11:25, Emily Shaffer wrote:
> > Here's my suggestion.
> > 
> >  - Let configs handle the hook list and ordering, via 'hook.{hookname}' which
> >    can be specified more than once.
> >    - global config: hook.update = /path/to/firsthook
> >      user config: hook.update = /path/to/secondhook
> >      worktree config: hook.update = -/path/to/firsthook #eliminate the firsthook
> >       call
> >    - global config: hook.update = /path/to/firsthook
> >      repo config: hook.update = /path/to/secondhook
> >      repo config: hook.update = ^/path/to/firsthook #move firsthook execution
> >        after secondhook for this project
> 
> I'd like to hear more about how we handle multiple hooks that are
> repo-specific and don't live in the PATH.  This is a common situation
> for existing tools that handle multiple hooks, and it's one I think we
> should support.

I guess I'm confused about where PATH comes into play. Do you mean that
the hook being run relies on PATH to be set appropriately? I had
envisioned absolute paths in the config.

> Perhaps we add a "git hook execute" subcommand that executes scripts
> from the hook directory.

Can you give an example of when you'd use it? I'm not understanding your
concern and I think an example use case would help me see what you mean.

> 
> >  - Let users decide whether they want to check core.hookDir in addition to their
> >    config, instead of their config, or not at all, via a config
> >    'hook.runHookDir' "hookdir-first", "hookdir-only", "config-only", etc.
> >  - Let users ask to be notified if running a hook from .git/hooks via a config
> >    'hook.warnHookDir'. (Mentioning .git/hooks rather than core.hookDir is
> >    intentional here.) Alternatively, ask for 'hook.warn' with values "hookdir",
> >    "all" depending on how trusting the user feels.
> >    - If we want to phase out .git/hooks, we can make this notification opt-out
> >      instead of opt-in, someday.
> >    - between runHookDir and warnHookDir, users are able to phase out
> >      .git/hooks scripts at their own pace.
> >  - Abstract most of this via a 'git hooks' command.
> >    - 'git hooks add <hookname> [--<scope>] <path>' to append another hook;
> >      let the scope setting match 'git config'.
> >    - 'git hooks show [<hookname>]' to indicate which hooks will be run, either
> >      on a specific event or for all events, and in which order, as well as each
> >      hook's config origin
> >    - 'git hooks edit <hookname>' to modify the hook order, or choose not to run
> >      a hook locally
> >    - By managing it through a command, we can reorder the contents of config
> >      files if it makes sense to do so.
> >  - Add a hook library.
> >    - Optionally specify all hook events via enum, so we aren't string-typing
> >      calls to find_hook() anymore.
> >    - Resolve configs into a list of hooks to run by concatenating them together
> >      in config precedence order.
> >      - Also allow configs formatted like "-<path>" to remove an
> >        earlier-configured invocation of that hook, or "^<path>" to move the
> >        earlier-configured invocation to this point in the execution order
> >    - Move the find_hook() implementation to here, to account for the multihook
> >      ordering
> 
> I think this addresses most of the concerns that I had about ordering.
> It is still a little suboptimal that we're relying on the ordering of
> the config file, since it makes things equivalent to numbered files in
> .d directories hard.

Hm, I suppose I don't see why, if the final ordering is determined by
the .git/config (or future replacement for that). Can you explain what
you mean? I want to understand where you're coming from.

> 
> Possibly as an alternative to the ^ syntax, we could make the hook value
> be of the form "key program", where key is a sort key (e.g., a number)
> and program is the program to run.  We pick normal config file ordering
> if the keys are identical.  Then if the system config wants to have a
> hook that always runs at the end, it can do so easily.

Interesting. This way if you decide after you've set up all your configs
just so that you really want something to run at the end of the update
event, you can change one place, not n=number of Git repos. (I do still
want to be able to say "don't run that global hook in this project"
though.)

> 
> In addition, we should be sure that attempting to remove a hook which
> doesn't exist isn't an error, since a user might want to set their
> ~/.gitconfig file to always unset a global hook that may or may not
> exist.

I'd be comfortable with a warning when exiting 'git hook edit' mode and
silence when actually running the hook list.

> 
> We also need to address exit codes with multiple hooks and whether we
> fail fast or not.  My series may provide some valuable options here, or
> we may choose to go with a single, simpler approach.  Whatever we do, we
> should document the behavior clearly.

Agree. I'll take a look at your series this week to see how you solved
it; this feels like a place where it'd be easy to give too many knobs
that users would never pull.

I was going to write my gut feeling about what we should do, but my gut
came up with reasonable arguments for lots of approaches. So I'll read
what came first before I say anything more :)

> 
> Overall, though, I think this approach has a lot of potential and I feel
> positive about it.  Thanks for bringing this up again in a productive
> and helpful way.

Thanks for being open minded about it.

 - Emily
