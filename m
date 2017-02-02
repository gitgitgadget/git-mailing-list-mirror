Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3952E20A78
	for <e@80x24.org>; Thu,  2 Feb 2017 01:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdBBBjA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 20:39:00 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34460 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdBBBi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 20:38:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so628599wmi.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 17:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=wJv43mBx+xN9QWQOAKHZmzHdL9WMZaz+704ZbwVerj8=;
        b=I4iJOsM1CTfq8I1xTQz5WUX43XY9ap1Dmi+3KXaKRxMCIvqG9c7iyf9aI4+te7VQx3
         Mz94JqZF1R834DWCH0uXxV40nB2S9VmaBorRdOw/xf6YmqAhWu6jWK060jS5yIELMOFL
         sXcCBzJ31gfLXWF2CxdtHb8OuRmMj044AYAiTBrNh4gGh7n+QBeQ4U4SqutuleXiYo9g
         uSY9OoJComC6yAXiassT0DNdAGmu1jDS6wNqxG2lKh73iBIXcnSHCXQaZQm9Kyi3UAkJ
         kRd0DWAXdbdQqeQ7FdSi4HLAcvrWyHpG0UYzzKhDQPxlPMezuN2pOeb/XvNpdxhU1Pld
         UN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=wJv43mBx+xN9QWQOAKHZmzHdL9WMZaz+704ZbwVerj8=;
        b=iQWzh7I/GInKzcDTGMtnSgDLAEFsZI/t89qqcEvtpw9wR4zG5zzhlfNbOlK4y032ai
         uR7dpQKMuqxoQF2KlekUQl1f+eKpaSk3L5pJgT7MJIldEDbs31i9xvPg9rVtFCG99Gvq
         aLTIl6Z5MAQCw7P1mREOXCl140hw0GliQUO8ycrSW0K5jBxG6CEo5G4oU3tdGkyGfV9j
         a5zIF/ZPlkv8lYkitrMKE72BuZLFirwym6zOE9zNUrGY4UVjlFJUCrFmSVVU1Sqf2H+T
         0AiNEjZkU5gYpsTBJz30/bV9lLQZEWmDnRk3mUFLPefCdLoD8SFj/nfA/gRF+AOLifEi
         P8JQ==
X-Gm-Message-State: AIkVDXKPZlDC+aRQH1AuFZDU8HSHmC/gKR7Zj9e9AjWzL7rFPAs/JR37c/RhQg2579yf7Q==
X-Received: by 10.223.171.149 with SMTP id s21mr5081808wrc.64.1485999538347;
        Wed, 01 Feb 2017 17:38:58 -0800 (PST)
Received: from localhost.localdomain (x4db0ed96.dyn.telefonica.de. [77.176.237.150])
        by smtp.gmail.com with ESMTPSA id c202sm32230226wmd.10.2017.02.01.17.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 17:38:57 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
Subject: Re: [PATCH 6/7] completion: teach remote subcommands option completion
Date:   Thu,  2 Feb 2017 02:37:59 +0100
Message-Id: <20170202013759.25789-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170122225724.19360-7-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Git-remote needs to complete remote names, its subcommands, and options
> thereof. In addition to the existing subcommand and remote name
> completion, do also complete the options
> 
>  - add: --track --master --fetch --tags --no-tags --mirror=

Oh, '--track' and '--master' are not even in the manpage or in 'git
remote -h', I could only find them after looking at the source code...

Good eyes :)

>  - set-url: --push --add --delete
>  - get-url: --push --all
>  - prune: --dry-run
> ---
>  contrib/completion/git-completion.bash | 36 +++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e76cbd7..0e09519 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2384,24 +2384,46 @@ _git_config ()
>  
>  _git_remote ()
>  {
> -	local subcommands="add rename remove set-head set-branches set-url show prune update"
> +	local subcommands="
> +		add rename remove set-head set-branches
> +		get-url set-url show prune update
> +		"
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
> -		__gitcomp "$subcommands"
> +		case "$cur" in
> +		--*)
> +			__gitcomp "--verbose"
> +			;;
> +		*)
> +			__gitcomp "$subcommands"
> +			;;
> +		esac
>  		return
>  	fi
>  
> -	case "$subcommand" in
> -	rename|remove|set-url|show|prune)
> -		__gitcomp_nl "$(__git_remotes)"
> +	case "$subcommand,$cur" in
> +	add,--*)
> +		__gitcomp "--track --master --fetch --tags --no-tags --mirror="
>  		;;
> -	set-head|set-branches)
> +	add,*)
> +		;;
> +	set-head,*|set-branches,*)

The 'set-head' subcommand has '--auto' and '--delete' options, and
'set-branches' has '--add'.

>  		__git_complete_remote_or_refspec
>  		;;
> -	update)
> +	update,*)

The 'update' subcommand has a '--prune' option.

Otherwise it all looks good.


>  		__gitcomp "$(__git_get_config_variables "remotes")"
>  		;;
> +	set-url,--*)
> +		__gitcomp "--push --add --delete"
> +		;;
> +	get-url,--*)
> +		__gitcomp "--push --all"
> +		;;
> +	prune,--*)
> +		__gitcomp "--dry-run"
> +		;;
>  	*)
> +		__gitcomp_nl "$(__git_remotes)"
>  		;;
>  	esac
>  }
> -- 
> 2.10.2


