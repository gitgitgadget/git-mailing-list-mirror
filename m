Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAA32036D
	for <e@80x24.org>; Fri, 24 Nov 2017 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbdKXSJZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 13:09:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45525 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdKXSJY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 13:09:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so23834944wme.4
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=aFd3Q4mfgdNiGZbVg9cPz8K8OAsCivgBQlleq9KtFOQ=;
        b=T9fKNwHaLqzZNfsOlVG0xycHkc0y3y4tjaMeoIyRAu3GXA0jEcpoC5Lb+2Fivj0YkL
         KVMHFxabdrZRVxoJQDaJRhUYrRwjHqx/WS+KfN27j4qotoJLQXLTYxR8XkuwJWecvGxl
         Q6bEyDjodQwxrsQQAeOsQrd24aw9cTMi6hpGNvyKjjBOmJTWX6qkZJKrBFJzFIpyibZU
         XKCkfw6m+ju8I9BxK4mWhxTrXn6xzmMv3Jlw1onsWNu25O+K2mgVQW0o+ibXBeFYeVcr
         UxVPrLbr7KeH3wAqn+sdZqXgNH4bl85a7wnEBI3rHQVyg8dkUZk3U03XrycBLrxEo9+K
         vPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=aFd3Q4mfgdNiGZbVg9cPz8K8OAsCivgBQlleq9KtFOQ=;
        b=U+5NR1GhJ2uZGioGsrKC/5nzrjJxMcnfD8U+32KyL15Igb6/P8mUBZilFJZHUl2Oz6
         HlnKth82JiAZ7hkwokBWKfkB99ethnFdSj3+6VMDmFM231L7AGNRmleWJDQNU+vrqNU3
         J7eVyEP5fVPis63UmZCe4PM+WV6Je1+8jz5XC8ZDzV49OXPYkjeyHY6JCULSGXSwIg8T
         M9FErNdZEPM+HvE7mUOr2WLGfo3mrOX4MW4d5iWvyZKmT7y86TNHZ/Bp/ngjfR0ldd8N
         zKmZPkjNJJ7v3dhb1wixLVszvN35BmQeigqedINF+SKPoyuStpU3AfiwTPuRytLHstKN
         Emew==
X-Gm-Message-State: AJaThX52TcMIy2M4ab4tFezTUYFdpeX6FWSjxCuf/HRSGOf97YQuVzFW
        3XXtRp3expmyEkZS4L88iGyYlA==
X-Google-Smtp-Source: AGs4zMYzNMTUmo81c38m1qF1qzvzqdFKGgerLHtn9piqCLFfY7ddic1Pw9Ais65APyvjlBGuxq/LrQ==
X-Received: by 10.28.4.146 with SMTP id 140mr9891004wme.38.1511546963423;
        Fri, 24 Nov 2017 10:09:23 -0800 (PST)
Received: from localhost.localdomain (x590db49d.dyn.telefonica.de. [89.13.180.157])
        by smtp.gmail.com with ESMTPSA id 65sm10327213wrn.27.2017.11.24.10.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Nov 2017 10:09:22 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Albert Astals Cid <albert.astals.cid@kdab.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] bash completion: Add --autostash and --no-autostash to pull
Date:   Fri, 24 Nov 2017 19:09:02 +0100
Message-Id: <20171124180902.31253-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.384.g4c06762c1
In-Reply-To: <94455771.5s97AYBuGd@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ideally we should only autocomplete if pull has --rebase since
> they only work with it but could not figure out how to do that
> and the error message of doing git pull --autostash points out
> that you need --rebase so i guess it's good enough

You could use the completion script's __git_find_on_cmdline() helper
function to easily check whether the '--rebase' option is already
present on the command line.

Having said that, I don't think we should go there, it feels that's
trying to be overly and unnecessarily clever.  After all, the order of
command line options doesn't matter, and 'git pull --autostash
--rebase' is a perfectly legit command.


> Signed-off-by: Albert Astals Cid <albert.astals.cid@kdab.com>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-
> completion.bash
> index 539d7f84f..7ded58f38 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1923,6 +1923,7 @@ _git_pull ()
>  	--*)
>  		__gitcomp "
>  			--rebase --no-rebase
> +			--autostash --no-autostash
>  			$__git_merge_options
>  			$__git_fetch_options
>  		"
> -- 
> 2.15.0
> 
> 
> 
