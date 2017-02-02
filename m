Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BEE20A78
	for <e@80x24.org>; Thu,  2 Feb 2017 00:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbdBBA6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 19:58:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32866 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdBBA6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 19:58:39 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so461916wmv.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 16:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=j01zKNY0DPz0v9Nm5hRLOTrGGBZ3chbrBNIAGrtn1DY=;
        b=rbsugEIDIskg+M3ObYR894QA8olvA4tUhiJRNN9k5elEJCvcj1omXTxHS4kK5W163/
         0NZOvzQV6GX7mc0XtOZumUA9Pn/y857w2J4y1kvc2sRHb1cC34r1+o7ma1KRkdZ+8vSS
         hfrdvwLgh5NZ2q543pfsb59TvX8RG8VJngsPPUPvvhieMWsD5wH7r2OYteGnJvqy64Yf
         kXB3gJ56ojsgn2NrOGFLcahNPV8zk6mqubuI+AJYqShhaPO6l0neCvtVwnJIa8qp9lEO
         VRr0MIyYlXoCvwMVkCCnE/9Rlpu6U4NUyL5RtXQ0Z0p/3+wqM7TaNAJGuQbINllHRGVZ
         iQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=j01zKNY0DPz0v9Nm5hRLOTrGGBZ3chbrBNIAGrtn1DY=;
        b=R1zB83SEgjOPBlY7+PVUJ/l8LMG5gJirT+tDfFnF94pJlFdPmNIA9YpPErmbmtp1LI
         PevV5KIjd9se9LveWwppNEicIf+FbxKBxmPpaqX36w5XKvhba9RKfAsyAOLxRrUD1psx
         sp7SRklfMcSeMcnfejbLoj8plgWvAHgDIxbKoX+TKIe2fzk9DvYJlXPR0Znmdli31Erv
         0nMLksFAZ/n4ql4/c8emPw47J1pIpEFy1m8AuPZNKtP+mVaXOwKGvx7opd6P816j+R6z
         rPFPKfbV8uAtF2VTQkAg9KcWy9fnU2MDxstdzLTFm4o5BFW5P78cI6F0yCjFP+z5eLQq
         3n/w==
X-Gm-Message-State: AIkVDXIToG0AGqOO1qPg09MnpyCr2DSVdNGwcj3pQyhXu2lSSDsV7EVMHjtqKgi0PHwRxw==
X-Received: by 10.223.134.173 with SMTP id 42mr5886279wrx.95.1485997117827;
        Wed, 01 Feb 2017 16:58:37 -0800 (PST)
Received: from localhost.localdomain (x4db0ed96.dyn.telefonica.de. [77.176.237.150])
        by smtp.gmail.com with ESMTPSA id b87sm170991wmi.0.2017.02.01.16.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 16:58:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
Subject: Re: [PATCH 2/7] completion: add subcommand completion for rerere
Date:   Thu,  2 Feb 2017 01:57:24 +0100
Message-Id: <20170202005724.24754-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170122225724.19360-3-cornelius.weig@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Managing recorded resolutions requires command-line usage of git-rerere.
> Added subcommand completion for rerere and path completion for its
> subcommand forget.
> ---
>  contrib/completion/git-completion.bash | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c54a557..8329f09 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2401,6 +2401,17 @@ _git_replace ()
>  	__gitcomp_nl "$(__git_refs)"
>  }
>  
> +_git_rerere ()
> +{
> +	local subcommands="clear forget diff remaining status gc"
> +	local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +	if test -z "$subcommand"
> +	then
> +		__gitcomp "$subcommands"
> +		return
> +	fi
> +}
> +
>  _git_reset ()
>  {
>  	__git_has_doubledash && return
> -- 
> 2.10.2

You didn't add 'rerere' to the list of porcelain commands, i.e. it
won't be listed after 'git <TAB><TAB>'.  I'm not saying it should be
listed there, because I can't decide whether 'rerere' is considered
porcelain or plumbing...  Just wanted to make sure that this omission
was intentional.

