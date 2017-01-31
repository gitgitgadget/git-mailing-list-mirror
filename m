Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EBB1F437
	for <e@80x24.org>; Tue, 31 Jan 2017 18:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbdAaSKJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 13:10:09 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36829 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdAaSIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 13:08:41 -0500
Received: by mail-wj0-f196.google.com with SMTP id kq3so11675667wjc.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 10:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=LpCSLhg2xzxXkpypw4u1gZIkVvtw/nzlNSmNY1RYisI=;
        b=M0ScH+u1aWV4r+nDLvunmwuNuFOmqqmmk/jadAh68CaxCJB/Ei4XWlJ56IWaN8qLZM
         wHhMhloQwX5ngYivy2hxjcJBtwyfxFx/dZPaOL2h5Xv0h9HFXCA99n4Eixy+YlAwJNXy
         KkXM7SYVprvdEZfKnjUPh4OpMim+8D1hvP7drPHqCQf84ceK/YeWZxmppFyDmQ1zxTVJ
         BPxQdxhVawxLQ7CRebSSfUqcEXTbqOnO7e5I8wr/HFr8pNgZ72BZvUzD4IGgmhJH3SZF
         5n46juarxkPMY7YuEK5HzY6CeT9NoMzdMk/piwhcN4kHk5U21/jUoPxHkG3lPXLpj7B5
         rVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=LpCSLhg2xzxXkpypw4u1gZIkVvtw/nzlNSmNY1RYisI=;
        b=qOp+7j/YVjVYbGxeMsZbZ7QXYmb7xblQ7NuUigUdgZA5tZxnumIutstDbIEMrH3hHR
         ORvgVJBz/+LATp0GEdoNPWCYnvEe5dR00rYdW+jIOby3mwnkpAVL98Ls9fSZDhr5yx8s
         q6vNgYoiWvLfTnpS1uSbF7iX1zrbyo24O1YbIorNrh0X5Q3l39mzEWZtJG3ShmuCW1zv
         TIf8JMqFBRwWYV/kzW7A/ejbeWdywK+SYuR/DJboe+nN4cgoPo3HtfReJN8HarzUjSzf
         IG8Nv1FIFBdud6+Cfe/ZRnokkwnv59oVKGb8dhjkY6Un3xo3AbPk3fsAqL96H5gbgWO3
         86rQ==
X-Gm-Message-State: AIkVDXIxL55OdgPmcl3GY0oMIYwbSo0N7MKdDwMLURU3tH8vN/XNnp95396ooXSDVq0Lwg==
X-Received: by 10.223.142.111 with SMTP id n102mr23928569wrb.11.1485886120031;
        Tue, 31 Jan 2017 10:08:40 -0800 (PST)
Received: from localhost.localdomain (x590c3414.dyn.telefonica.de. [89.12.52.20])
        by smtp.gmail.com with ESMTPSA id w69sm25063937wmw.22.2017.01.31.10.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 10:08:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Benjamin Fuchs <email@benjaminfuchs.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        sbeller@google.com, sandals@crustytoothpaste.net,
        ville.skytta@iki.fi, git@vger.kernel.org
Subject: Re: [PATCH 2/4] git-prompt.sh: rework of submodule indicator
Date:   Tue, 31 Jan 2017 19:06:33 +0100
Message-Id: <20170131180633.22369-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <1485809065-11978-3-git-send-email-email@benjaminfuchs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Rework of the first patch. The prompt now will look like this:
> (+name:master). I tried to considere all suggestions.
> Tests still missing.
> 
> Signed-off-by: Benjamin Fuchs <email@benjaminfuchs.de>
> ---
>  contrib/completion/git-prompt.sh | 49 ++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 4c82e7f..c44b9a2 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -95,8 +95,10 @@
>  # repository level by setting bash.hideIfPwdIgnored to "false".
>  #
>  # If you would like __git_ps1 to indicate that you are in a submodule,
> -# set GIT_PS1_SHOWSUBMODULE. In this case a "sub:" will be added before
> -# the branch name.
> +# set GIT_PS1_SHOWSUBMODULE to a nonempty value. In this case the name
> +# of the submodule will be prepended to the branch name (e.g. module:master).
> +# The name will be prepended by "+" if the currently checked out submodule
> +# commit does not match the SHA-1 found in the index of the containing repository.
>  
>  # check whether printf supports -v
>  __git_printf_supports_v=
> @@ -288,30 +290,27 @@ __git_eread ()
>  	test -r "$f" && read "$@" <"$f"
>  }
>  
> -# __git_is_submodule
> -# Based on:
> -# http://stackoverflow.com/questions/7359204/git-command-line-know-if-in-submodule
> -__git_is_submodule ()
> -{
> -	local git_dir parent_git module_name path
> -	# Find the root of this git repo, then check if its parent dir is also a repo
> -	git_dir="$(git rev-parse --show-toplevel)"
> -	module_name="$(basename "$git_dir")"
> -	parent_git="$(cd "$git_dir/.." && git rev-parse --show-toplevel 2> /dev/null)"
> -	if [[ -n $parent_git ]]; then
> -		# List all the submodule paths for the parent repo
> -		while read path
> -		do
> -			if [[ "$path" != "$module_name" ]]; then continue; fi
> -			if [[ -d "$git_dir/../$path" ]];    then return 0; fi
> -		done < <(cd $parent_git && git submodule --quiet foreach 'echo $path' 2> /dev/null)
> -    fi
> -    return 1
> -}
> -
> +# __git_ps1_submodule
> +#
> +# $1 - git_dir path
> +#
> +# Returns the name of the submodule if we are currently inside one. The name
> +# will be prepended by "+" if the currently checked out submodule commit does
> +# not match the SHA-1 found in the index of the containing repository.
> +# NOTE: git_dir looks like in a ...
> +# - submodule: "GIT_PARENT/.git/modules/PATH_TO_SUBMODULE"
> +# - parent: "GIT_PARENT/.git" (exception "." in .git)
>  __git_ps1_submodule ()
>  {
> -	__git_is_submodule && printf "sub:"
> +	local git_dir="$1"
> +	local submodule_name="$(basename "$git_dir")"
> +	if [ "$submodule_name" != ".git" ] && [ "$submodule_name" != "." ]; then
> +		local parent_top="${git_dir%.git*}"
> +		local submodule_top="${git_dir#*modules}"
> +		local status=""
> +		git diff -C "$parent_top" --no-ext-diff --ignore-submodules=dirty --quiet -- "$submodule_top" 2>/dev/null || status="+"

This 'git diff' has to read the index of the parent repository, right?
That can be potentially very expensive, if the parent repository, and
thus its index, is big.

You might want to provide finer granularity controls and separate the
"$PWD is in a submodule" indicator from the "submodule commit doesn't
match" indicator.  Even if someone is in general interested in the
former, he might have some huge repositories where he would prefer to
disable the latter, because executing 'git diff' would make the prompt
lag.

I'm not sure we need brand new control knobs, though.  Perhaps we can
get away by checking the env and config variables used for the dirty
index and worktree status indicator, after all they, too, are about
whether to run 'git diff' for the prompt in a repository or not.

> +		printf "$status$submodule_name:"
> +	fi
>  }
>  
>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
> @@ -545,7 +544,7 @@ __git_ps1 ()
>  
>  	local sub=""
>  	if [ -n "${GIT_PS1_SHOWSUBMODULE}" ]; then
> -		sub="$(__git_ps1_submodule)"
> +		sub="$(__git_ps1_submodule $g)"

In Bash, and in shells in general, the visibility of variables works
differently than in "regular" programming languages:

  - Any variable existing in a caller, even the ones declared as
    'local' in the caller, are visible in all callees.
    
    This means you don't have to pass $g as parameter to
    __git_ps1_submodule(), because you can access it inside that
    function directly.  This has the benefit that there is one less
    place where you can forget to quote a path variable :)

  - If the callee modifies any variable that isn't declared as local
    in the callee, then the caller will see the modified value of that
    variable, unless the callee was invoked in a subshell.

    Here your sole purpose is to set $sub to something like "+sub:",
    which is determined in __git_ps1_submodule().  You don't need the
    command substitution for that, you can set $sub directly in
    __git_ps1_submodule(), sparing the overhead of fork()ing a
    subshell.  That's important for the sake of git users on Windows.

>  	fi
>  
>  	local f="$w$i$s$u"
-- 
2.7.4


