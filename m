Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57FB1F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 22:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdAaWnj (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 17:43:39 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36065 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdAaWni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 17:43:38 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1463957wmd.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=ebDf7NYIcAaC70UcNGb0QHhmPm8w2NjLD0XeyzgOcRw=;
        b=K41rEkuhAYWjZZlpblYeBPgmQumqY30pKNEVfJUmnLT37taMu7YDibrO55BX6X4iUG
         bTZgNeWi7z2Q21c6877GS04y68/XMlN/T7FnLBiX1ENBp3KSb8U44KEfzY3ZpT9OAUzx
         cmk5Xg6LW2O6tkWbxdQCw6JLs8ITK21ufsMAD9prUlF+utDrNGyx1fGCKHn7D+1ZJUAq
         n366lkQbk9Kxggq/5DSLeLW8LqLZNvCy/YOywnUZfFrVCmRUrNjGAHuvRgHWijfSwISk
         LXrq5N5BRfJkE80u4joWdwdIy4sLgwr3KiBmzDoqMTgdSS+W7r0W2bvILYowplTIS6wb
         2kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=ebDf7NYIcAaC70UcNGb0QHhmPm8w2NjLD0XeyzgOcRw=;
        b=GOPJCYjVO7P8w1cuD3hNrXlcqCA5LOa+w3aX8owlppqvlLRcq6P4NY16oEthYP2WGh
         0mX2caYUW3i2yBBTOhus6mmJMaxqqicgXEKOYdxBe2/+g5Ts9lvMxmhRo8HPC7xsrW8E
         7qllYBBM45BAHzQK3TsCqE1OG/SS0wqu43nCx1M/f8tZpp/g+AZ5avFzqI+ohddPKF8k
         YScrEd/NJmhFqVifGdwh64/NhV/HW+ZcIfb6uYqu+Fs3gw2s34U23QLSkSTx38VR60iB
         jkNVEG7e9neZUicxOfYjL5J0YejV/oQZHB9961PUlMIArxU2MPkdQeYttgFO3k3IbNeO
         jrOg==
X-Gm-Message-State: AIkVDXIiP5B+amytQ9oi1Q6W2ZHadjrEtqPlVqE98lt9cSsT231pXNNYjnrptyS3/x1XHg==
X-Received: by 10.28.0.73 with SMTP id 70mr19446790wma.109.1485902617493;
        Tue, 31 Jan 2017 14:43:37 -0800 (PST)
Received: from localhost.localdomain (x590c3414.dyn.telefonica.de. [89.12.52.20])
        by smtp.gmail.com with ESMTPSA id 36sm30636692wrz.8.2017.01.31.14.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 14:43:36 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
Subject: Re: [PATCH 3/7] completion: improve bash completion for git-add
Date:   Tue, 31 Jan 2017 23:42:41 +0100
Message-Id: <20170131224241.25138-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Add some long-options for git-add and improve path completion when the
> --update flag is given.

Please tell us in the commit message _how_ this improves path
completion.

> ---
>  contrib/completion/git-completion.bash | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8329f09..652c7e2 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -947,13 +947,17 @@ _git_add ()
>  	--*)
>  		__gitcomp "
>  			--interactive --refresh --patch --update --dry-run
> -			--ignore-errors --intent-to-add
> +			--ignore-errors --intent-to-add --force --edit --chmod=

I almost started complaining that '--force' should be used with care,
but then realized that for 'git add' it only means adding ignored
files.  So in this particular case '--force' is not destructive and we
can offer it among other long options.  Good.

>  			"
>  		return
>  	esac
>  
> -	# XXX should we check for --update and --all options ?
> -	__git_complete_index_file "--others --modified --directory --no-empty-directory"
> +	local complete_opt="--others --modified --directory --no-empty-directory"
> +	if test -n "$(__git_find_on_cmdline "-u --update")"
> +	then
> +		complete_opt="--modified"
> +	fi
> +	__git_complete_index_file "$complete_opt"
>  }
>  
>  _git_archive ()
> -- 
> 2.10.2


