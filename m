Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32DDB1FEB3
	for <e@80x24.org>; Mon,  2 Jan 2017 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755320AbdABI6O (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 03:58:14 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36808 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdABI6N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 03:58:13 -0500
Received: by mail-pg0-f54.google.com with SMTP id f188so201903357pgc.3
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=obuAhKcBCwPHqH7orI/wpRcnScbOd321twAtqCfTNVc=;
        b=Neq1KE38/bMgVf+luJM+czy6HN5d3XazzC69n63IyFUZ8uilY0uEqeNio7iEEOs4Gt
         5Yxk/MLo5u/I6U6PA7kPIIhhG+8nbq8QxpQk4uBpbuJWSeGlrszPpN5HeumzEd/Mcodj
         p4Kmp3zxiGxXfQYLolnp3HJZVRk4Sf3GfRu1iG5RIBjH1dvefSIWzbzpokRo/xa8dL6z
         baN+WY3rZg18j+Xqpv2Nc4gIqakHsYpC4do4RQz9U/V9esa++IRC1JapX3UtxDodiXUX
         mWTN6/0nnYeaCWrlqWaijQve6/a8OBhjvNMk+LfxINDvgiU61a2ZMYouolRjKtBAbYOI
         oMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=obuAhKcBCwPHqH7orI/wpRcnScbOd321twAtqCfTNVc=;
        b=J9kUDPenuVX2lNCbfw7nbobnFA+eMQ950HHtQiOlviK+WLC5a/L5Rt08SbUd4wRCme
         HYJCH3yiYsbheWDTH8EqrdxUtIAiYtx4jJVh8XsXjHC3DFNDuN9znkTlQNIYzzP24QqV
         2e3aMJSrstMGW0yUF+BqN6qB3WhPip/qdg65oLeQXMDyryguSgJf/HaSjdPt9LMCdijx
         9bR8YoDE4EdJn8IdJhntfvy/Dz//COEV8echui5vBA/cGZrn1zjg2W+iRpRt5poyAjiz
         DdRIkL8v4kOLioiL1Kgqb8aDwggdKCpX3nP8zq+pjl9X0WUw7F0j+U3/gg5BAc2//awk
         4vQQ==
X-Gm-Message-State: AIkVDXIucwlTuu/gAUOGilNkK9+jRpPrDlkGH7HPOUYBxzZwMUGOxQ6LnjXBabAQhaxhMA==
X-Received: by 10.84.232.197 with SMTP id x5mr89219445plm.102.1483347493252;
        Mon, 02 Jan 2017 00:58:13 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id c2sm130302341pfl.66.2017.01.02.00.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jan 2017 00:58:12 -0800 (PST)
Date:   Mon, 2 Jan 2017 00:58:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     spearce@spearce.org, gitster@pobox.com
Subject: [PATCH] completion: complete git submodule subcommands
Message-ID: <20170102085810.GA10331@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow git submodule subcommands to be completed. This allows the
'--remote' in the command 'git submodule update --remote', for example,
to be fully completed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Hi Shawn, sorry this is my first contribution to a mailing-list based
project. If I've done anything wrong, please let me know.

Thanks,

Denton Liu

---
 contrib/completion/git-completion.bash | 46 ++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8d..941fbdfe2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2556,17 +2556,41 @@ _git_submodule ()
 	__git_has_doubledash && return
 
 	local subcommands="add status init deinit update summary foreach sync"
-	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
-		case "$cur" in
-		--*)
-			__gitcomp "--quiet --cached"
-			;;
-		*)
-			__gitcomp "$subcommands"
-			;;
-		esac
-		return
-	fi
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+
+	case "$subcommand,$cur" in
+	,--*)
+		__gitcomp "--quiet"
+		;;
+	,*)
+		__gitcomp "$subcommands --quiet"
+		;;
+	add,--*)
+		__gitcomp "--force --name --reference --depth"
+		;;
+	status,--*)
+		__gitcomp "--cached --recursive"
+		;;
+	deinit,--*)
+		__gitcomp "--force --all"
+		;;
+	update,--*)
+		__gitcomp "
+			--init --remote --no-fetch --no-recommended-shallow
+			--recommended-shallow --force --rebase --merge --reference
+			--depth --recursive --jobs
+			"
+		;;
+	summary,--*)
+		__gitcomp "--cached --files --summary-limit"
+		;;
+	summary,*)
+		__gitcomp_nl "$(__git_refs)"
+		;;
+	foreach,--*|sync,--*)
+		__gitcomp "--recursive"
+		;;
+	esac
 }
 
 _git_svn ()
-- 
2.11.0

