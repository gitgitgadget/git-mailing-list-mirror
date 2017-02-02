Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4089120A79
	for <e@80x24.org>; Thu,  2 Feb 2017 01:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750873AbdBBBk5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 20:40:57 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34648 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdBBBk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 20:40:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so637126wmi.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 17:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=VKgeCd4rOC55tt2sfw+B/AYdd0khIIl2D/8kEow96fU=;
        b=Xzmzw/SUV/2nr6YG9MZK3nQhNyBLQx3P6IFa/PZF83nzFGbJjrfnxjDvMerjrpub+i
         yp7RJnJT4o05/0HU+zcR/2CH4hwXCK9jM+X06kCqNfxfrqSknYppjmKRsOxiJ2U4rnkQ
         nxX8sxYR1+5bXFJbkJ5UYGRWgvVy7S1HvodbLGGY+on7x3E193qimxEfDYUEyKKAmhA+
         n6j2FlZ+Y/ClgIj+mtjGmtxPMoaq9zFLxSng5bP3r8lkJREBw7LF640y/ckGBX5EVWSV
         MeRSdDakMZyvLkqO29XApnhqm+xSsBMa7RVcvKmK1by6BJb1QaKZBWktvEa3dovUslq4
         9zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=VKgeCd4rOC55tt2sfw+B/AYdd0khIIl2D/8kEow96fU=;
        b=L06emS2UVnpAhBLcb7u+BB7c3qFG5oRgoC0mHX6HRuKXWUJZvpx/bSMHVZECdse+iy
         A9Ygp2OJDlHWu8N8GXwItjlq/tNXpsoPgHaSBvF36Yp8XhVPKvGg8vyiqyJYYFke6iNA
         /Hw2veQgT+tTGUjW1INOJY4OlIXNiyIaMrQuJ8o3ozAUJNmz772ABwQunb0c7q7lK5cP
         8l4vNkEe+LoF6Ie8k/q+l5xNjfXCvU9khoKBX9pNEI8mEfwtLokYjumdXB/9EeWS/ktM
         +bunj6C/Jwia5OTRjuY/alJJIwZZ40EQPMl0IMZg5GpheLqgg4/FhO1u7AriTWCVaiuv
         N67g==
X-Gm-Message-State: AIkVDXL8EuvK4qlbP7Uvs6VoVdu0dupesKoskP7puqhE9NwTxjC8V1lY+M0NruJ+7Bt7Jg==
X-Received: by 10.223.169.85 with SMTP id u79mr5072430wrc.169.1485999655021;
        Wed, 01 Feb 2017 17:40:55 -0800 (PST)
Received: from localhost.localdomain (x4db0ed96.dyn.telefonica.de. [77.176.237.150])
        by smtp.gmail.com with ESMTPSA id n10sm36946099wrb.9.2017.02.01.17.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 17:40:54 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] completion: teach ls-remote to complete options
Date:   Thu,  2 Feb 2017 02:40:14 +0100
Message-Id: <20170202014014.25878-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170122225724.19360-5-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> ls-remote needs to complete remote names and its own options.

And refnames, too.

> In
> addition to the existing remote name completions, do also complete
> the options --heads, --tags, --refs, and --get-url.

Why only these four options and not the other four?

There are eight options in total here, so there is really no chance
for cluttered terminals, and all eight are mentioned in the synopsis.

> ---
>  contrib/completion/git-completion.bash | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 652c7e2..36fe439 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1449,6 +1449,12 @@ _git_ls_files ()
>  
>  _git_ls_remote ()
>  {
> +	case "$cur" in
> +	--*)
> +		__gitcomp "--heads --tags --refs --get-url"
> +		return
> +		;;
> +	esac
>  	__gitcomp_nl "$(__git_remotes)"
>  }
>  
> -- 
> 2.10.2


