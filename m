Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EB01F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFUWbZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39772 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfFUWbW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id m202so5757735oig.6
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RLbNim9Vif88HyHoqQEa9iwKKR6YgexW+MYrsUumBiA=;
        b=YTwisq0iPsbm48Me07mAwVgXtBCCA81i3uGDSxvYEpY5pkbwHGwAhMf+jf+PpVqBZj
         2AQY4uDpxAlmWPHc9Aqqh1SK77OyaVZp15v0ZoPGc5m+ant6CyEWL82rFiS0VA0pI2kA
         vKS/6Nnv+XHnAYPserJJkaIxxe75jLvSx0KpNtFAN17QOpzHUpxh2hiLC3mDWlODg2Fg
         59MB/T0xO4NnLpq9gO8rA0PB7JLNUIRHxkgJjqXJV21qvXF9HnAA5sEa1RQqLcugaSUd
         jFXkAD/bnA34qlUMrZzXX9qMOIN2hNW+9yoWWvecwsOCyEXn874Cl36v3uDdxFleI2cx
         iGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RLbNim9Vif88HyHoqQEa9iwKKR6YgexW+MYrsUumBiA=;
        b=oiUGlW+KzI9SuIjBCAVCF24nr+DLq7mcDz/zqRvr5P4eFn75XVjrihuDFeCdOePil7
         GcHhccjYS7dSZon7r08ukVicqau756QX8tQW/z1L4ndPiWkJXUNJsFfJjngzUFoRmoxM
         v9UU6+UN3mqy7zBmvJiAYJQ1FpsEpbL66pjAaXtOLWsxb5IE3zrVsD+fa4beafL8picp
         5ls6AxOOVuvOLwDN0FvjaSt5vHa+gnSPzmD7p2sIS0ylNAUbtjwyCxKQuh2hLpfHdQOt
         OLf3gtpJ+//JhaSNlR4E48WrTa4X5lPrdKQURVcczj4RqmM4krEl7phTFzklJl9PBZCG
         Mt+Q==
X-Gm-Message-State: APjAAAXR9zIc0HbqkwoRIjRMmGKVwBoLZ+gGiKNxgI23wGyzsCuT38Cg
        KnRCWI8w8ln3R4pkJi4NtQ/nE3hkYYg=
X-Google-Smtp-Source: APXvYqyoLG8Xt4Qky064L1Rz12qi9CgsxAVpkuT1ZnwmrCLRtZBiRtNLe35zqyaLdHc2pQk4E754Zg==
X-Received: by 2002:aca:40d5:: with SMTP id n204mr4018269oia.94.1561156281393;
        Fri, 21 Jun 2019 15:31:21 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id 103sm1381947otu.33.2019.06.21.15.31.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/14] completion: bash: remove zsh wrapper
Date:   Fri, 21 Jun 2019 17:31:02 -0500
Message-Id: <20190621223107.8022-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been deprecated for more than seven years. It's time to move on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 84 +-------------------------
 1 file changed, 2 insertions(+), 82 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1f9b833913..d3ee6c7dc2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2969,88 +2969,8 @@ __gitk_main ()
 	__git_complete_revlist
 }
 
-if [[ -n ${ZSH_VERSION-} ]] &&
-   # Don't define these functions when sourced from 'git-completion.zsh',
-   # it has its own implementations.
-   [[ -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
-	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
-
-	autoload -U +X compinit && compinit
-
-	__gitcomp ()
-	{
-		emulate -L zsh
-
-		local cur_="${3-$cur}"
-
-		case "$cur_" in
-		--*=)
-			;;
-		*)
-			local c IFS=$' \t\n'
-			local -a array
-			for c in ${=1}; do
-				c="$c${4-}"
-				case $c in
-				--*=*|*.) ;;
-				*) c="$c " ;;
-				esac
-				array[${#array[@]}+1]="$c"
-			done
-			compset -P '*[=:]'
-			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-			;;
-		esac
-	}
-
-	__gitcomp_direct ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -- ${${=1}% } && _ret=0
-	}
-
-	__gitcomp_nl ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
-	}
-
-	__gitcomp_file_direct ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -f -- ${=1} && _ret=0
-	}
-
-	__gitcomp_file ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -p "${2-}" -f -- ${=1} && _ret=0
-	}
-
-	_git ()
-	{
-		local _ret=1 cur cword prev
-		cur=${words[CURRENT]}
-		prev=${words[CURRENT-1]}
-		let cword=CURRENT-1
-		emulate ksh -c __${service}_main
-		let _ret && _default && _ret=0
-		return _ret
-	}
-
-	compdef _git git gitk
+if [[ -n ${ZSH_VERSION-} && -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
+	echo "ERROR: this script is obsolete, please see git-completion.zsh" 1>&2
 	return
 fi
 
-- 
2.22.0

