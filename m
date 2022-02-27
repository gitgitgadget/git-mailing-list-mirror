Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3659AC433FE
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiB0T55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiB0T5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:57:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4EF33E29
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i20so4589737wmc.3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HWs1rPDv/cLW73s5386uGZiZZlTu1GFX5tT6NSOjMqw=;
        b=OC9r11R4MDDujAKC0jEqSIO8gR1rqgEz4+x9TKgUz/o/oj93AD/y6xCcUcvpswiT4U
         I6y6wv+lcDEh6JF284odxAsR5okkDz5wxNASAYQeeJUy+f8hxQQ/FuHCFg2to7EgCj+7
         BuQ8zwEnIz6lq/e8bJtWgU5YPd7Mbq92MdV9z1EpaV9eeIZNOJH/vqnMtLQuap2sIzox
         RtJ2d0ZQqq9z1AOGJZmd098D9n48ac0sbizVXjzvhqj0fibhygSGYXwQfz6tT5UZOI83
         ppoTpYC+AxrgjPhHelQw1d+9lelNV3Of6jcM9Igv9/XNQV08bbVKGEgM2cGWYU3Q0tBg
         4Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HWs1rPDv/cLW73s5386uGZiZZlTu1GFX5tT6NSOjMqw=;
        b=nprjnrUIU9hlp5MDDXoWmprGuw2/344kVPqQZHw8KNXQysTq35h2/MtlkuiaW5m9VK
         6PyceQZYGx0nJ31sATKIblaVA4898q7Ge5rwo5ovxas7NkWRE8LIhakR5m6pk75x0DKV
         r/6dg/lbG6OU/6xt1ZSlFkAuwIfHPqAMaDeJvtyPqOk4UGnTFH+cXSekpYM0BLz9K0Lu
         kq94mCK2WEF5E8DanRqC4yULr7hABQ/ce1E8LMUMQpC8JaWxMsSZnpqtR729xrACRILB
         h4Yk3Cs7oY/XnkvQgom6uXpVKHG7msZbRJ1KodSR2PwcMFkrSykQ1iFS9AJaiHowpgf6
         Q0xQ==
X-Gm-Message-State: AOAM532HSRXwvaXLVlP2m9XdtLf/INejgbzihGTS43lTLYLwoHkKPa8X
        TNYkZGIMgPhq9XOwdqkMCVRF58hBzVw=
X-Google-Smtp-Source: ABdhPJxDysmyd2mpIyi/7hf0IhLs6Z1D3PLcAoUT8xR+Ufu1nZ3DsUxd5FYb4Y6MJIjxbzgT25+dQQ==
X-Received: by 2002:a05:600c:4f55:b0:381:2322:6b2 with SMTP id m21-20020a05600c4f5500b00381232206b2mr10732608wmq.169.1645991835116;
        Sun, 27 Feb 2022 11:57:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d4891000000b001e74e998bf9sm8441392wrq.33.2022.02.27.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 11:57:14 -0800 (PST)
Message-Id: <4bf120b1bf89dfd10b2a1a9297169904223a6d9b.1645991832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com>
        <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
From:   "Justin Donnelly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 19:57:10 +0000
Subject: [PATCH v2 2/4] git-prompt: make upstream state indicator location
 consistent
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

Make upstream state indicator location more consistent with similar
state indicators (e.g. sparse). Group the short upstream state indicator
(`=`, `<`, `>`, or `<>`) with other short state indicators immediately
after the branch name. Previously short and long upstream state
indicators appeared after all other state indicators.

Use a separator (`SP` or `GIT_PS1_STATESEPARATOR`) between branch name
and short upstream state indicator. Previously the short upstream state
indicator would sometimes appear directly adjacent to the branch name
instead of being separated.

For comparison, `__git_ps1` examples without upstream state indicator:
(main)
(main %)
(main *%)
(main|SPARSE)
(main %|SPARSE)
(main *%|SPARSE)
(main|SPARSE|REBASE 1/2)
(main %|SPARSE|REBASE 1/2)

Note that if there are short state indicators, they appear together
after the branch name and separated from it by `SP` or
`GIT_PS1_STATESEPARATOR`.

Before/after examples with short upstream state indicator:
| Before           | After            |
| ---------------- | ---------------- |
| (main=)          | (main =)         |
| (main|SPARSE=)   | (main =|SPARSE)  |
| (main %|SPARSE=) | (main %=|SPARSE) |

Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
---
 contrib/completion/git-prompt.sh | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 3997e099aa7..613389a53bc 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -109,7 +109,7 @@
 __git_printf_supports_v=
 printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
-# stores the divergence from upstream in $p
+# stores the divergence from upstream in $p (for short status) or $upstream (for verbose status)
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
 {
@@ -214,26 +214,26 @@ __git_ps1_show_upstream ()
 		*)	    # diverged from upstream
 			p="<>" ;;
 		esac
-	else
+	else # verbose, set upstream instead of p
 		case "$count" in
 		"") # no upstream
-			p="" ;;
+			upstream="" ;;
 		"0	0") # equal to upstream
-			p=" u=" ;;
+			upstream=" u=" ;;
 		"0	"*) # ahead of upstream
-			p=" u+${count#0	}" ;;
+			upstream=" u+${count#0	}" ;;
 		*"	0") # behind upstream
-			p=" u-${count%	0}" ;;
+			upstream=" u-${count%	0}" ;;
 		*)	    # diverged from upstream
-			p=" u+${count#*	}-${count%	*}" ;;
+			upstream=" u+${count#*	}-${count%	*}" ;;
 		esac
 		if [[ -n "$count" && -n "$name" ]]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
 			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
-				p="$p \${__git_ps1_upstream_name}"
+				upstream="$upstream \${__git_ps1_upstream_name}"
 			else
-				p="$p ${__git_ps1_upstream_name}"
+				upstream="$upstream ${__git_ps1_upstream_name}"
 				# not needed anymore; keep user's
 				# environment clean
 				unset __git_ps1_upstream_name
@@ -512,7 +512,8 @@ __git_ps1 ()
 	local u=""
 	local h=""
 	local c=""
-	local p=""
+	local p="" # short version of upstream state indicator
+	local upstream="" # verbose version of upstream state indicator
 
 	if [ "true" = "$inside_gitdir" ]; then
 		if [ "true" = "$bare_repo" ]; then
@@ -568,8 +569,8 @@ __git_ps1 ()
 		b="\${__git_ps1_branch_name}"
 	fi
 
-	local f="$h$w$i$s$u"
-	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
+	local f="$h$w$i$s$u$p"
+	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
 
 	if [ $pcmode = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
-- 
gitgitgadget

