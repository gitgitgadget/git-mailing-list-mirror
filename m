Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30CA220D13
	for <e@80x24.org>; Mon, 30 Jan 2017 23:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbdA3Xsf (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 18:48:35 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33363 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdA3Xse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 18:48:34 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so24623923pfg.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 15:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g8wKYYNpYDej6m29Jpl+PpeaeMNNYnF8Dpeug18UNus=;
        b=Lm3p+NGnd6Mm6d/zR/eT7bY5RW3Kd9lG9EDCrxpZZN3T/R/NEr/R2WKCnZB4mH0tVw
         ah9xvDHfBSdnsB8QK3AUdG691RvXG5vRsBl4Eqfky6/aATev9Uq84i9JRpRxrirdboxN
         pDZG6+fcQulOLymBfI0uZFq14XuRv4rIRnkIpsQSTrDUfwk8w7Nd9xzEieqm8tUxiZf3
         c9+krOEzxKZOpY24d6kDjEjXZjrY6frohuipPhPanbu/RxdkbIgcA3iBYTjYcmdFW8iU
         RqmIH2FatmggOdnTLGmG+EeHcPPVPQRITMHzjfPK2dsnuMmOrZrR6reBzUxRnyZP55bS
         wDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g8wKYYNpYDej6m29Jpl+PpeaeMNNYnF8Dpeug18UNus=;
        b=GJM0xMFKMLE++Ya7dmn7gd9gATI4w4VL8iGzyRL7vDondl9coP60M1VZ+zqRyLcdO6
         McpBGQBbqY1kNA10Pk2bk7hs7rIYq7mV0Ix7Ry106riElYmV7XVUQr4AoFHoJmSGdaXd
         /uWcCFu4LTZWPH3lBPh7NoB/ZgxBtP4plqFZEToKSb8wkS8I/WraXMG+RtI6jxtsfRiH
         oJuysH90BsrvjyCXbSCENavwG4ZzphOdgXIQi4DNEoTsvygTZc49dCxs8IQHwqSZjOpR
         ElagnR1WdIWTu4BnqI3HSwQhlBKgomwtChFsmfJbTMrbSd48qB90Gcyn2LEeDhuqaRlP
         NC1w==
X-Gm-Message-State: AIkVDXIip++yXMff3teZqWhT/o9uxkR3djSElXioNksl5aED6RPJFmSzELfu29t89rTV/g==
X-Received: by 10.99.61.202 with SMTP id k193mr26655110pga.154.1485820113311;
        Mon, 30 Jan 2017 15:48:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id z29sm35461920pgc.7.2017.01.30.15.48.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 15:48:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Benjamin Fuchs <email@benjaminfuchs.de>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, sbeller@google.com,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [PATCH 1/4] git-prompt.sh: add submodule indicator
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
        <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
Date:   Mon, 30 Jan 2017 15:48:31 -0800
In-Reply-To: <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
        (Benjamin Fuchs's message of "Mon, 30 Jan 2017 21:44:22 +0100")
Message-ID: <xmqqr33krtww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Benjamin Fuchs <email@benjaminfuchs.de> writes:

> I expirienced that working with submodules can be confusing. This indicator
> will make you notice very easy when you switch into a submodule.

I am not quite sure what the above wants to say.  If you work on two
projects, A and B, then having something that quickly reminds you
which one you are in is beneficial and people often do so by having
the current directory name in the prompt.  

The log message needs to explain why working on a submodule C of a
project A is any more special, i.e. why are the existing ways the
users are using to remind them between A and B cannot be used for C.

> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 97eacd7..4c82e7f 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -93,6 +93,10 @@
>  # directory is set up to be ignored by git, then set
>  # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
>  # repository level by setting bash.hideIfPwdIgnored to "false".
> +#
> +# If you would like __git_ps1 to indicate that you are in a submodule,
> +# set GIT_PS1_SHOWSUBMODULE. In this case a "sub:" will be added before
> +# the branch name.
>  
>  # check whether printf supports -v
>  __git_printf_supports_v=
> @@ -284,6 +288,32 @@ __git_eread ()
>  	test -r "$f" && read "$@" <"$f"
>  }
>  
> +# __git_is_submodule
> +# Based on:
> +# http://stackoverflow.com/questions/7359204/git-command-line-know-if-in-submodule
> +__git_is_submodule ()

It seems like this function is checking if you are "IN" submodule,
not "IS" submodule.  A misnamed function?

> +{
> +	local git_dir parent_git module_name path
> +	# Find the root of this git repo, then check if its parent dir is also a repo
> +	git_dir="$(git rev-parse --show-toplevel)"
> +	module_name="$(basename "$git_dir")"

This does not give "module_name" in the sense the word is used in
the submodule subsystem.  If this variable is useful, call that
with "path" in its name (I do not think it alone is useful at all).

> +	parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"
> +	if [[ -n $parent_git ]]; then
> +		# List all the submodule paths for the parent repo
> +		while read path
> +		do
> +			if [[ "$path" != "$module_name" ]]; then continue; fi
> +			if [[ -d "$git_dir/../$path" ]];    then return 0; fi
> +		done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)

Instead of doing this "loop over submodules and just get true or
false", it may make a lot more sense to find the module name and
report that.  That would allow you to have the actual submodule
name, not a generic "sub:" which does not help the users to tell
which one of 47 submodules they have in their top-level project
they are currently in.

If your projects are layed out like so

	/home/bf/projects/A/
	/home/bf/projects/A/lib/B/ -- submodule
	/home/bf/projects/A/Doc/ -- another submodule
	/home/bf/projects/A/Doc/technical -- a subdirectory of Doc submodule

and you are in /home/bf/projects/A/Doc/technical/ subdirectory, your
$git_dir variable (which is grossly misnamed, too; call it "top"
perhaps?) would be "/home/bf/projects/A/Doc" and then your
$parent_git variable (again, that is misnamed; call it
"parent_top"?) would be "/home/bf/projects/A".  The submodule path
to the submodule you are currently in is "Doc" (you learn it as the
difference between these two).

You can ask the top-level project the name of the submodule that is
currently at "Doc" with "submodule--helper name".  Unless the project
has moved it since it first added the submodule, the module name may
also be "Doc", but if it were moved, it may be different.

And that "module name" is a more useful thing than a hardcoded
string "sub:" to use in the prompt, I would think.
