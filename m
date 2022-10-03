Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5429EC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 14:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJCOYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJCOYm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 10:24:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A9965E8
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 07:24:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w18so8265664wro.7
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=snmdJQy46P2z6rAZbZ8iJ5SsvmeFHl9J0EhQOqgXTgI=;
        b=e8xvjkbezppY3enC1jt1il2Dz9DRtT2JUn7ZSYRaD5L4bFx9EVmp09PQSbltb/ct1f
         PHDiD19bn1kFtkOfar+ReGM6jNRW5Sq7K5cFzvZvUKa7LLlr5BukTC/6btPR4sxugr7C
         V32gmXHjMj3kKJ4qzEE4vi6CteykNy7fWP8/GmwWj108LRIxgCRKzwK6KmX57RkLGqr0
         Aa+CGrB37HB5NRrPfBcUJ6T9xYPyuR67GThuFr4bRylhafOm74RHzF/t/GKpeweQy6J6
         ker2JJmXZW2MdAt4fVpNf9VfU4N0SpVS/UWtltg4ggr7eSkJw9Yw0pa7S0Aw7HWsQ9Y6
         OEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=snmdJQy46P2z6rAZbZ8iJ5SsvmeFHl9J0EhQOqgXTgI=;
        b=HQgSUGSowk96Risjep6Yc4GEuyNGYgwvVzJVRttKb7pe25VsLz/WJCWY2LXZ24VoQI
         M91MAiGTQ4h0Xb5EAbnZcwpYHp8CvnJ5qfuHUOmapssqs0adK8qeSi7cQd+S5T8ApOTc
         imqlU6qT0MxKwoJBMiFuWW7IndkBBOMKGEULTHASBVbizouwMTC3QxXP/mUBfd0yzkCw
         qyge1G7vZIUswMFPe5k5iGHbzxm1VNCsPTcBQs6pZ+JTnYbLYZA7vD+rq9skRBJTtjaI
         6YWHzs5uHwHN01MKnZjtXEDkacyJ8/hsRRfge0eXRlieameBq2cZrqr5o/MjUwMREgF4
         EO4g==
X-Gm-Message-State: ACrzQf1GVwFUp8S9SCRclevOCbPYkavSTVtGwxQBrQUmSnm827Aqclv7
        W1ew7vXsTmzO+Jc/WeprvDk/lq/U6hw=
X-Google-Smtp-Source: AMsMyM5ioAUFSxuRf0zGg8QWnmenKXtLcNv7ZkusWFdcw3+F3LnxTZzMhxvSg6MBCk4QvqjhFGDemw==
X-Received: by 2002:adf:d84a:0:b0:22e:3f73:372c with SMTP id k10-20020adfd84a000000b0022e3f73372cmr2275530wrl.500.1664807080172;
        Mon, 03 Oct 2022 07:24:40 -0700 (PDT)
Received: from localhost (78-131-14-129.pool.digikabel.hu. [78.131.14.129])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003b339438733sm11485773wmi.19.2022.10.03.07.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 07:24:39 -0700 (PDT)
Date:   Mon, 3 Oct 2022 16:24:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Tim Jaacks <timjaacks@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: Bash completion for git aliases containing nested subcommands
Message-ID: <20221003142437.GB7659@szeder.dev>
References: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <em8d7ca854-51a3-4cb5-aaf9-30ed37b4194b@acer-switch-tim>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 11:45:51AM +0000, Tim Jaacks wrote:
> Hello everyone,
> 
> I have set up the following alias in my .gitconfig file:
> 
> [alias]
>     ss = stash show
> 
> Unfortunately bash completion does not work correctly on this alias. When I
> type "git ss <TAB>", I get:
> 
> $ git ss <TAB>
> apply clear drop pop show
> branch create list push
> 
> Which is obviously the completion for "git stash" instead of "git stash
> show".
> 
> With the original command I get the list of available stashes:
> 
> $ git stash show <TAB>
> stash@{0} stash@{1}
> 
> Is there a way to get the completion on the alias behave like on the
> original command?

In general: no.  Our Bash completion script is organized as one
_git_cmd() function for each git supported command.  If a command has
subcommands, then its completion function looks for any of its
subcommands amond the words on the command line, and takes the
appropriate action, which is usually executing a particular arm of a
case statement.  The two main issues are that in case of such an alias
there is no subcommand ("show") on the command line, and there is no
dedicated function to handle only the completion for 'git stash show'.

However, it is possible to make completion work for your particular
alias by using our completion script's extension mechanism that allows
users to specify completion functions to their own git commands.  If
you type 'git foo <TAB>' and there is a _git_foo() function in your
shell's environment, then the completion script will invoke that
function to perform completion; this works not only for commands but
for aliases as well.  So for your alias you only need to "borrow" all
the "show"-subcommand-specific case arms from _git_stash() and place
them in a _git_ss() function, e.g. like this:

_git_ss () {
	case "$cur" in
	--*)
		__gitcomp_builtin stash_show "$__git_diff_common_options"
		;;
	*)
		__gitcomp_nl "$(__git stash list | sed -n -e 's/:.*//p')"
		;;
	esac
}

Add it to your ~/.bashrc, or to a separate file that you source from
your .bashrc;  If you use bash-completion, then you don't even have to
touch you .bashrc: save that function to a file 'git-ss' (dash, not
underscore!) in one of the directories scanned by bash-completion
($BASH_COMPLETION_USER_DIR, ~/.local/share/bash-completion/completions
or its XDG_DATA_HOME-equivalent) and it will be auto-loaded as needed.

This approach should work just as well for any other similar "command
subcommand" alias that you might have; with the downside that you'll
have to write all these functions yourself.

> I am on Ubuntu 20.04 and using the distro's default git completions.
> 
> Kind regards,
> Tim
> 
