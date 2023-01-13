Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A6DC3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 18:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjAMSBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAMSAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 13:00:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FB8CD05
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:54:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso13577448wms.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oUfk3ovjgcdJH96om8TQw792PBaWTHon3HDTEOfD+VA=;
        b=K7iIpyTLgH3PvZgmhg24msgsQqoQHWQ/dyVCc0YbbgSj0YRBnIcCZFWWssEx8e7clb
         u7ahq6gsn2OEMu7+INfeo60w3HXSFSl+cfGrSee8A3ZWXR+MKf0kEGMMIHOll1EnC58v
         CDOzywBI3xxSuRrZXmARVWlW+9PXMxWJx9l9hJPCa2kAzZHf04gOGPQloMz0rMVyBJ1x
         VRhkFhQlGHZTl73vdsgAN95Fm16UXEToEyL4hs7P8AO63PTjDmrGvbAY318mstgdI+SR
         VjX6XPcECsmQP6LKIZLUcFAhST+jEbGginR8Jluqe8H11hFk0eZx9EF4z8QCIq0RJwbL
         p1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUfk3ovjgcdJH96om8TQw792PBaWTHon3HDTEOfD+VA=;
        b=eKsMYSMQvUXUY2d7Klm1TmmiDZXMsjcOsPrmEbaU2pHTbFZDV+9+cqdCdRHezH57Zp
         sF434wYUNUJtYhs1iFXTj9+MGF09wFxhU6VI6R2Xi1P6x7Pqh5zVgUIiYCufNg42iyVs
         S0cG/e6X2YURdK/B/qK7rgtjqO14UeJThHjn8+Gj1wiYvTZnYSYoXkTxtN5B4SNLpnGb
         iQxY0f6pg8UpixsyqFB1pAVYO3J6xosvV2EADbxbiugDTfPHuQMMIaxuh2vApqfY/ebk
         q7I/yhkoEuFuhjaFSHo2GEx0w/O9vgjEpn1UNTPwe5wFBJAaj1QMN/QTOdx2ldQCcpZQ
         9NqA==
X-Gm-Message-State: AFqh2kpKC1lcUvEGmFZPx0GRPFrZ0XoPYoYI50zyu42MwswBU/SqPrfN
        kg3BZW2kPnAjCOmrFec5iHZ9cMKwVVc=
X-Google-Smtp-Source: AMrXdXu6jsW6PY9WEY1jOBsUhppFHGKp9K1BZAV9/TWux3BSBwt4P1Lz7bNtyjfOFmMK5gQC4wCUcg==
X-Received: by 2002:a05:600c:a06:b0:3da:230e:9531 with SMTP id z6-20020a05600c0a0600b003da230e9531mr2445864wmp.13.1673632439119;
        Fri, 13 Jan 2023 09:53:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a1c770f000000b003da286f8332sm223918wmi.18.2023.01.13.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:53:58 -0800 (PST)
Message-Id: <pull.1433.git.git.1673632438204.gitgitgadget@gmail.com>
From:   "Alessandro via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 17:53:58 +0000
Subject: [PATCH] git-prompt: customizable symbols
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alessandro <alezini94@hotmail.it>,
        Alessandro <alezini94@hotmail.it>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alessandro <alezini94@hotmail.it>

Add the possibility to customize git-prompt symbols by adding a bunch of
additional variables. The variables default to the original symbol.

Signed-off-by: Alessandro Zini <alezini94@hotmail.it>
---
    git-prompt: customizable symbols

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1433%2Faleeraser%2Ffeat%2Fcustomize-git-prompt-symbols-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1433/aleeraser/feat/customize-git-prompt-symbols-v1
Pull-Request: https://github.com/git/git/pull/1433

 contrib/completion/git-prompt.sh | 39 ++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 57972c2845c..d29209f0cef 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -39,25 +39,31 @@
 # unstaged (*) and staged (+) changes will be shown next to the branch
 # name.  You can configure this per-repository with the
 # bash.showDirtyState variable, which defaults to true once
-# GIT_PS1_SHOWDIRTYSTATE is enabled.
+# GIT_PS1_SHOWDIRTYSTATE is enabled. Variables GIT_PS1_UNSTAGED_SYMBOL
+# and GIT_PS1_STAGED_SYMBOL can be used to change the shown symbol.
 #
 # You can also see if currently something is stashed, by setting
 # GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
-# then a '$' will be shown next to the branch name.
+# then a '$' will be shown next to the branch name. Variable
+# GIT_PS1_STASH_SYMBOL can be used to change the shown symbol.
 #
 # If you would like to see if there're untracked files, then you can set
 # GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
 # files, then a '%' will be shown next to the branch name.  You can
 # configure this per-repository with the bash.showUntrackedFiles
 # variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
-# enabled.
+# enabled. Variable GIT_PS1_UNTRACKED_SYMBOL can be used to change the
+# shown symbol.
 #
 # If you would like to see the difference between HEAD and its upstream,
 # set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
 # indicates you are ahead, "<>" indicates you have diverged and "="
-# indicates that there is no difference. You can further control
-# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
-# of values:
+# indicates that there is no difference. Symbols can be configured by
+# setting variables GIT_PS1_UPSTREAM_NOT_PRESENT_SYMBOL,
+# GIT_PS1_UPSTREAM_EQUAL_SYMBOL, GIT_PS1_UPSTREAM_AHEAD_SYMBOL,
+# GIT_PS1_UPSTREAM_BEHIND_SYMBOL, GIT_PS1_UPSTREAM_DIVERGED_SYMBOL
+# You can further control behaviour by setting GIT_PS1_SHOWUPSTREAM to a
+# space-separated list of values:
 #
 #     verbose       show number of commits ahead/behind (+/-) upstream
 #     name          if verbose, then also show the upstream abbrev name
@@ -208,15 +214,15 @@ __git_ps1_show_upstream ()
 	if [[ -z "$verbose" ]]; then
 		case "$count" in
 		"") # no upstream
-			p="" ;;
+			p="${GIT_PS1_UPSTREAM_NOT_PRESENT_SYMBOL-}" ;;
 		"0	0") # equal to upstream
-			p="=" ;;
+			p="${GIT_PS1_UPSTREAM_EQUAL_SYMBOL-"="}" ;;
 		"0	"*) # ahead of upstream
-			p=">" ;;
+			p="${GIT_PS1_UPSTREAM_AHEAD_SYMBOL-">"}" ;;
 		*"	0") # behind upstream
-			p="<" ;;
+			p="${GIT_PS1_UPSTREAM_BEHIND_SYMBOL-"<"}" ;;
 		*)	    # diverged from upstream
-			p="<>" ;;
+			p="${GIT_PS1_UPSTREAM_DIVERGED_SYMBOL-"<>"}" ;;
 		esac
 	else # verbose, set upstream instead of p
 		case "$count" in
@@ -537,8 +543,8 @@ __git_ps1 ()
 		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
 		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
 		then
-			git diff --no-ext-diff --quiet || w="*"
-			git diff --no-ext-diff --cached --quiet || i="+"
+			git diff --no-ext-diff --quiet || w="${GIT_PS1_UNSTAGED_SYMBOL-"*"}"
+			git diff --no-ext-diff --cached --quiet || i="${GIT_PS1_STAGED_SYMBOL-"+"}"
 			if [ -z "$short_sha" ] && [ -z "$i" ]; then
 				i="#"
 			fi
@@ -546,14 +552,17 @@ __git_ps1 ()
 		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
 		   git rev-parse --verify --quiet refs/stash >/dev/null
 		then
-			s="$"
+			s="${GIT_PS1_STASH_SYMBOL-"$"}"
 		fi
 
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
 		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
 		   git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
 		then
-			u="%${ZSH_VERSION+%}"
+			u="${GIT_PS1_UNTRACKED_SYMBOL-"%"}"
+			if [ -n "$ZSH_VERSION" ] && [ "$u" = "%" ]; then
+				u="%%"
+			fi
 		fi
 
 		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE-}" ] &&

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
