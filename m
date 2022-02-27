Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8435C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiB0T5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiB0T5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:57:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2800933E1F
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b5so12386649wrr.2
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8r4KzvmBJBcEcejQQCQP/18C5CUaTPDCtesBQXHNvBw=;
        b=RBDzSUtBnHMg2alUOfgZSsk0CLsf94iQppAA2C+heUJj/FI6gAVLZL92Xue3GC/7X3
         nBMHmcVgeQWrfnX2o+uBCkIYc+A8cliJmlaaCdVnBCkGA9wHTevKk+q7TN+gqIeffF0c
         RBXmV6dd8qDhikhQlbvqvPx4ympMR8egQokWuXDcDvO7NnU18v+iaMcUV5hrA0LtSgVQ
         7zBcv2YEKeDJrskVdD+AlKOWj/Vz5YfAtFhTFmcg7kAz4q9Aq1GE4/MBjuIY8Bt7SDWj
         nVYLwP684/W9KFXab8upHgSOrOARL41RdFOXXL1KTPV2FlKbrCYR/zXk8sfyQXh6hyb7
         OeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8r4KzvmBJBcEcejQQCQP/18C5CUaTPDCtesBQXHNvBw=;
        b=F90M+hJrxkTBnNCqMYNVvgZRvJYUgEcK5Aa6HBaNwCqFnV1zCK6jQfZg0iAbwYAdAZ
         gvBRp0kC8btFncbCijnzxkvGIJZv+1bJcsDpmz7t7IinsBbJ4Iu6drO3RznhVcJOdgFw
         ZITCNe0VqVknVy/Lo9TIpLADfvE+hr3YEmO/yCpO2DIlZP49ojbmrctnupti/mo3izk8
         UH575pnG5m81LV31cd7ORssku3vJRgrq4wmR6PD6/v/VpygFbq5f4l9ynobLaU399ILl
         yaQwezwNZC/VtVfZDIuiw96MAPygS1gGRRwA2VvvYoRZ/C5K4//h0tVQ0OCbDXQars20
         b3sA==
X-Gm-Message-State: AOAM533MVelOmQUz4YiYzVBsb41+vNrn6Nfn7eOL11FvtbSY7kv/soQo
        YSunYSvqv4WKjXBq3qutbdOi0WgOeAk=
X-Google-Smtp-Source: ABdhPJxiAuP60JaHybHocsykYPaCkQJsuWiJWv2wRUHaAnbMIGxnj2iLBP7q18Aok+9cMVtzIXkDLw==
X-Received: by 2002:a05:6000:1e0c:b0:1ed:a700:65dc with SMTP id bj12-20020a0560001e0c00b001eda70065dcmr12933916wrb.485.1645991834419;
        Sun, 27 Feb 2022 11:57:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d4dc4000000b001d8e67e5214sm8572955wru.48.2022.02.27.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 11:57:13 -0800 (PST)
Message-Id: <1db836bb309989c4ad93ed6d32a5ef4075ac7020.1645991832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
        <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 19:57:09 +0000
Subject: [PATCH v2 1/4] git-prompt: rename `upstream` to `upstream_type`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Justin Donnelly <justinrdonnelly@gmail.com>

In `__git_ps1_show_upstream` rename the variable `upstream` to
`upstream_type`. This allows `__git_ps1_show_upstream` to reference a
variable named `upstream` that is declared `local` in `__git_ps1`, which
calls `__git_ps1_show_upstream`.

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index db7c0068fb5..3997e099aa7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -115,7 +115,7 @@ __git_ps1_show_upstream ()
 {
 	local key value
 	local svn_remote svn_url_pattern count n
-	local upstream=git legacy="" verbose="" name=""
+	local upstream_type=git legacy="" verbose="" name=""
 
 	svn_remote=()
 	# get some config options from git-config
@@ -132,7 +132,7 @@ __git_ps1_show_upstream ()
 		svn-remote.*.url)
 			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
 			svn_url_pattern="$svn_url_pattern\\|$value"
-			upstream=svn+git # default upstream is SVN if available, else git
+			upstream_type=svn+git # default upstream type is SVN if available, else git
 			;;
 		esac
 	done <<< "$output"
@@ -141,16 +141,16 @@ __git_ps1_show_upstream ()
 	local option
 	for option in ${GIT_PS1_SHOWUPSTREAM}; do
 		case "$option" in
-		git|svn) upstream="$option" ;;
+		git|svn) upstream_type="$option" ;;
 		verbose) verbose=1 ;;
 		legacy)  legacy=1  ;;
 		name)    name=1 ;;
 		esac
 	done
 
-	# Find our upstream
-	case "$upstream" in
-	git)    upstream="@{upstream}" ;;
+	# Find our upstream type
+	case "$upstream_type" in
+	git)    upstream_type="@{upstream}" ;;
 	svn*)
 		# get the upstream from the "git-svn-id: ..." in a commit message
 		# (git-svn uses essentially the same procedure internally)
@@ -167,12 +167,12 @@ __git_ps1_show_upstream ()
 
 			if [[ -z "$svn_upstream" ]]; then
 				# default branch name for checkouts with no layout:
-				upstream=${GIT_SVN_ID:-git-svn}
+				upstream_type=${GIT_SVN_ID:-git-svn}
 			else
-				upstream=${svn_upstream#/}
+				upstream_type=${svn_upstream#/}
 			fi
-		elif [[ "svn+git" = "$upstream" ]]; then
-			upstream="@{upstream}"
+		elif [[ "svn+git" = "$upstream_type" ]]; then
+			upstream_type="@{upstream}"
 		fi
 		;;
 	esac
@@ -180,11 +180,11 @@ __git_ps1_show_upstream ()
 	# Find how many commits we are ahead/behind our upstream
 	if [[ -z "$legacy" ]]; then
 		count="$(git rev-list --count --left-right \
-				"$upstream"...HEAD 2>/dev/null)"
+				"$upstream_type"...HEAD 2>/dev/null)"
 	else
 		# produce equivalent output to --count for older versions of git
 		local commits
-		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
+		if commits="$(git rev-list --left-right "$upstream_type"...HEAD 2>/dev/null)"
 		then
 			local commit behind=0 ahead=0
 			for commit in $commits
@@ -229,7 +229,7 @@ __git_ps1_show_upstream ()
 		esac
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
-				--abbrev-ref "$upstream" 2>/dev/null)
+				--abbrev-ref "$upstream_type" 2>/dev/null)
 			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
 				p="$p \${__git_ps1_upstream_name}"
 			else
-- 
gitgitgadget

