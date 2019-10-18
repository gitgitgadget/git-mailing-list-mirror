Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918401F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393591AbfJRQkf (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:40:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39056 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfJRQke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 12:40:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so6713466wml.4
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qqGU3wD/Zd4NleLPHDs6CKQmOUSHBXFQZa0Kl9AXX1k=;
        b=mL8u9HFgkrd7Cl1hGK0DfTmUoI7RaVKrufvEwSDUfTB4xE/ZWGzzpC8CeV64b5P6iW
         X5rmNg0aadzNZNUSxpBS99Dc76uWonL36/kb9HgAOMDPkS1/7WSA5sI2dPuS//oMHjD+
         n5pOY/EYQ0Yw0mAPUbTyDqRY0LmfYccAXHK/LAGfTR/wP9tgC4bja0nydmnZwyD0Fl6w
         NVChcfTwviiMqnxkfLJ+uN9tkUcUawNqpZtvXY8CUzUHvNdkXmAT6k/oaAl54J08VlYS
         E0dnmfovNhGzhpSfuuMDlktKL8e7rIEBQhu+rzXqgS5/dOm5kpEHN/eI4VUfFX53TaZ7
         g1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qqGU3wD/Zd4NleLPHDs6CKQmOUSHBXFQZa0Kl9AXX1k=;
        b=kumjKoTz0zWRrzhJTy2fqQ7UzGO1wXzNHhdZ2lKULEgfp7uNSSkJ1guQIfwTGEvmZo
         QUOtYI8hBww9/clD6PTpv9M9byqrQuIdjeyB2Y8nMgFsz8NsbJ6U3S+UugUkqouvhomd
         maZNKKkMV5y6vmDf0BeVeIUAy5/+dv/9RAMcZNjZwhL3qIwKU0Mpq/SnWlRWBHcCcGo0
         xRMU5VB0ozgFSrtMEKQ7CzITB8HefFbdLZ/N6Id1/nPHLX0NXY0KAPDa+vVgxCiQUxBt
         CzJQYouy4GyZ3yrzkf7vZHIYqzq+hYoMDKyIRnF7dcAfPPp0O3UVDCBy3ZVD/hHzZsij
         jkmQ==
X-Gm-Message-State: APjAAAVI1Sk8rOIkkwf63wy9SsgOZm4cja0FfPjEFgI8gkrvkcJtc5Kj
        jUVhwyKDHA7OXaSCXi15uwQ=
X-Google-Smtp-Source: APXvYqxZ3dV5cZTp0G7HqvdG03WyZ680RzqaAlkSVqD26G8u7fcyGTbgDCNUu+Wjj2gnVqgqC3axEg==
X-Received: by 2002:a1c:2306:: with SMTP id j6mr8632794wmj.96.1571416830753;
        Fri, 18 Oct 2019 09:40:30 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id p85sm6253172wme.23.2019.10.18.09.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 09:40:30 -0700 (PDT)
Date:   Fri, 18 Oct 2019 18:40:27 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/2] documentation: add tutorial for first contribution
Message-ID: <20191018164027.GI29845@szeder.dev>
References: <20190517190359.21676-1-emilyshaffer@google.com>
 <20190517190701.49722-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517190701.49722-2-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 12:07:02PM -0700, Emily Shaffer wrote:
> +=== Adding a New Command
> +
> +Lots of the subcommands are written as builtins, which means they are
> +implemented in C and compiled into the main `git` executable. Implementing the
> +very simple `psuh` command as a built-in will demonstrate the structure of the
> +codebase, the internal API, and the process of working together as a contributor
> +with the reviewers and maintainer to integrate this change into the system.
> +
> +Built-in subcommands are typically implemented in a function named "cmd_"
> +followed by the name of the subcommand, in a source file named after the
> +subcommand and contained within `builtin/`. So it makes sense to implement your
> +command in `builtin/psuh.c`. Create that file, and within it, write the entry
> +point for your command in a function matching the style and signature:
> +
> +----
> +int cmd_psuh(int argc, const char **argv, const char *prefix)
> +----
> +
> +We'll also need to add the declaration of psuh; open up `builtin.h`, find the
> +declaration for `cmd_push`, and add a new line for `psuh` immediately before it,
> +in order to keep the declarations sorted:
> +
> +----
> +int cmd_psuh(int argc, const char **argv, const char *prefix);
> +----
> +
> +Be sure to `#include "builtin.h"` in your `psuh.c`.
> +
> +Go ahead and add some throwaway printf to that function. This is a decent
> +starting point as we can now add build rules and register the command.
> +
> +NOTE: Your throwaway text, as well as much of the text you will be adding over
> +the course of this tutorial, is user-facing. That means it needs to be
> +localizable. Take a look at `po/README` under "Marking strings for translation".
> +Throughout the tutorial, we will mark strings for translation as necessary; you
> +should also do so when writing your user-facing commands in the future.
> +
> +----
> +int cmd_psuh(int argc, const char **argv, const char *prefix)
> +{
> +	printf(_("Pony saying hello goes here.\n"));
> +	return 0;
> +}
> +----
> +
> +Let's try to build it.  Open `Makefile`, find where `builtin/push.o` is added
> +to `BUILTIN_OBJS`, and add `builtin/psuh.o` in the same way next to it in
> +alphabetical order. Once you've done so, move to the top-level directory and
> +build simply with `make`. Also add the `DEVELOPER=1` variable to turn on
> +some additional warnings:
> +
> +----
> +$ echo DEVELOPER=1 >config.mak
> +$ make
> +----
> +
> +NOTE: When you are developing the Git project, it's preferred that you use the
> +`DEVELOPER` flag; if there's some reason it doesn't work for you, you can turn
> +it off, but it's a good idea to mention the problem to the mailing list.
> +
> +NOTE: The Git build is parallelizable. `-j#` is not included above but you can
> +use it as you prefer, here and elsewhere.
> +
> +Great, now your new command builds happily on its own. But nobody invokes it.
> +Let's change that.
> +
> +The list of commands lives in `git.c`. We can register a new command by adding
> +a `cmd_struct` to the `commands[]` array. `struct cmd_struct` takes a string
> +with the command name, a function pointer to the command implementation, and a
> +setup option flag. For now, let's keep mimicking `push`. Find the line where
> +`cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
> +line in alphabetical order.
> +
> +The options are documented in `builtin.h` under "Adding a new built-in." Since
> +we hope to print some data about the user's current workspace context later,
> +we need a Git directory, so choose `RUN_SETUP` as your only option.

Just leaving a quick note here: an entry about the new command should
be added to 'command-list.txt' as well, so it will be included in the
list of available commands in 'git help -a' or even in 'git help'
and in completion, if the command is marked with the necessary
attributes.
 
