Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 440E020A10
	for <e@80x24.org>; Fri, 29 Sep 2017 03:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdI2DtA (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 23:49:00 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:49284 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdI2Ds7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 23:48:59 -0400
Received: by mail-pf0-f182.google.com with SMTP id l188so81863pfc.6
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsqiD7KGWSHIezTI2ZcZm7C941iMqmTfYE/0VjLlanY=;
        b=FOPA1DvtKH8bIb2pM9J5ZRAvS6rKGV+DFzpqSZuKvMOdIdEfLxdmRvRnnWnTUpAVcN
         ZW5aZLgWBuamxzb7ze1dB5XwsibkeG/DTvzP7t2k3G9oxnTF3Db7afyJeQmXTcoLpPip
         BpnJrGRXX+kwuNrOpGSFFlqrW+Re2oWJZtr+WhDb6PhnXbUCmUzLvgu/f2/niYc8dXud
         whiLE2h804HS6KCx89xrFaoATpKHlxjXf32EvTPhFIldjNiJeH5tVME1nMZBaIwVrytX
         HwcjEhMQkjlSGzBmoGkWUi/JkrXuHyJB7vw6f/CtkvLomaq2OyibFU02PjjMvJq0lSHW
         1izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsqiD7KGWSHIezTI2ZcZm7C941iMqmTfYE/0VjLlanY=;
        b=KJyOsVFXv8H63D2a3LumT5/nkWtvOk3R+oslbkhGGYEpVSkEP8llQmyS4EPGgE1/cm
         8YVxTVqBWaV6xhDlXAWLc9k6qIHvhHHl4Wum7V2osPb3PnpfiQ3JJpMdZJ9bWQMyQTgO
         Ysvg9eDx6sp4Jl1paQ0UcTSiIQqKProxfn0iFFGxPEwvioPKrxcCIR1zbux+IBUUeb9W
         vLHeSpGDVx4hhg1tJsgiRjppE3SVxSaZjcb1+WbRRUsqzXNuXD1G5t+XV8CUrwgKD3wK
         HzGGb4fA9SJuPV6yZ38KF/WSZs25EEwN9ZTc+HDlWTRJdP09sgS1LkDQIEw/XUbOARvX
         avzg==
X-Gm-Message-State: AHPjjUhKVqE4egt13dZL1ipYxB2H899PvqtYJBqj5qQr28qpEs2EGEFU
        R97OkHZ5jBbKspdAlJ1fHkM=
X-Google-Smtp-Source: AOwi7QDsw1stiNR6yQ9w7iAKtVlmaFwPmHCuZc57/xwhgNTAWBjpjrCEq9lpJnSf9LEiBF++ZXRu5w==
X-Received: by 10.98.207.194 with SMTP id b185mr6141955pfg.243.1506656938418;
        Thu, 28 Sep 2017 20:48:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c47c:760e:a02b:2eef])
        by smtp.gmail.com with ESMTPSA id 13sm4891631pfm.138.2017.09.28.20.48.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Sep 2017 20:48:57 -0700 (PDT)
Date:   Thu, 28 Sep 2017 20:48:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Dridi Boukelmoune <dridi.boukelmoune@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-sh: Avoid sourcing scripts with git --exec-path
Message-ID: <20170929034856.GB28303@aiede.mtv.corp.google.com>
References: <20170928223134.GA30744@varnish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928223134.GA30744@varnish>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Dridi Boukelmoune wrote:

> For end users making use of a custom exec path many commands will simply
> fail. Adding git's exec path to the PATH also allows overriding git-sh-*
> scripts, not just adding commands. One can then patch a script without
> tainting their system installation of git for example.
>
> Signed-off-by: Dridi Boukelmoune <dridi.boukelmoune@gmail.com>

This has been broken for a while, but better late than never to
address it.

[...]
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -151,6 +151,28 @@ For shell scripts specifically (not exhaustive):
>     interface translatable. See "Marking strings for translation" in
>     po/README.
>  
> + - When sourcing a "git-sh-*" file using "git --exec-path" make sure
> +   to only use its base name.
> +
> +	(incorrect)
> +	. "$(git --exec-path)/git-sh-setup"
> +
> +	(correct)
> +	. git-sh-setup

I wonder if we can make this so intuitive that it doesn't need
mentioning in CodingGuidelines.  What if the test harness
t/test-lib.sh were to set a GIT_EXEC_PATH with multiple directories in
it?  That way, authors of new commands would not have to be careful to
look out for this issue proactively because the testsuite would catch
it.

[...]
> +++ b/contrib/convert-grafts-to-replace-refs.sh
> @@ -5,7 +5,8 @@
>  
>  GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
>  
> -. $(git --exec-path)/git-sh-setup
> +PATH="$(git --exec-path):$PATH"
> +. git-sh-setup

I wish there were a simple way to do this that doesn't involve
polluting $PATH with the dashed commands.  E.g. we can do something
like

	OIFS=$IFS
	IFS=:
	set -f
	for d in $(git --exec-path)
	do
		if test -e "$d/git-sh-setup"
		then
			. "$d/git-sh-setup"
			break
		fi
	done
	set +f
	IFS=$OIFS

but that is not very simple.  Something like

	old_PATH=$PATH
	PATH=$(git --exec-path):$PATH
	. git-sh-setup
	PATH=$old_PATH

looks like it could work, but it would undo the work git-sh-setup
does to set a sane $PATH on platforms like Solaris.

> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -7,7 +7,8 @@ USAGE="$me rev-list-args"
>  
>  SUBDIRECTORY_OK=Yes
>  OPTIONS_SPEC=
> -. "$(git --exec-path)/git-sh-setup"
> +PATH="$(git --exec-path):$PATH"
> +. git-sh-setup

This makes me similarly unhappy about PATH pollution, but it may be
that there's nothing to be done about that.

[...]
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -32,7 +32,6 @@ squash        merge subtree changes as a single commit
>  "
>  eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
>  
> -PATH=$PATH:$(git --exec-path)
>  . git-sh-setup

This looks like a change that could be separated into a separate
patch, both because it is to contrib/subtree (which is maintained
separately) and because it is not necessary for the goal described in
this patch's commit message.  I do like this change, since it improves
consistency with other commands.

> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -44,7 +44,7 @@ git_broken_path_fix () {
>  # @@BROKEN_PATH_FIX@@
>  
>  # Source git-sh-i18n for gettext support.
> -. "$(git --exec-path)/git-sh-i18n"
> +. git-sh-i18n

Do git-mergetool--lib.txt, git-parse-remote.txt, git-sh-i18n.txt,
and git-sh-setup.txt in Documentation/ need the same treatment?

Summary: I like the goal of this patch but I am nervous about the
side-effect it introduces of PATH pollution.  Is there a way around
that?  If there isn't, then this needs a few tweaks and then it should
be ready to go.

Thanks and hope that helps,
Jonathan
