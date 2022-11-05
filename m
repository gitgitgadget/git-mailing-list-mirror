Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2746EC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKER2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiKER2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:28:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC58E11171
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:28:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so10932845wrb.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92Ncc9rJv04TkiUK5ha/7qGnfOdm0AwxOTwbJ7SHa3s=;
        b=Nm8PQThPNFRBr0DNWDGPwaRBka+d5zEhelXbXP97t5URefKfl+0/HYStp3z0kttkrR
         XzapSfQBqfATZPalAJ6klBSmon/XCoJXM3CUXb0+f/KJQhHvTbfgVl/QvN6rErKdlavS
         Rs3Oh4fOzVlgDAeYg8cPRqziJmi58EhrGc6nBn388TmFF69CMPCk6kSGhuavOJ0TXMLb
         SL0ss9FKP407RZQD5m07iHw+KIScimxal46PnC+bC48ymbRKEymOGiJR5OmJPliGET31
         oZ+dIiIhfg55tM7tYtXdrs8XYS5PIpuUCWbStSuPFxaNddcz7EfSYVX7hw357yFCzRtw
         gG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92Ncc9rJv04TkiUK5ha/7qGnfOdm0AwxOTwbJ7SHa3s=;
        b=QvRaVvHru/bIZBMKhMcq6ezF0cKzylL8exF/puaDFzdhxVvgiM7k9yhDKGavyDLdK3
         6iisnM5HSmsDYTRKy4cQppZxF1NTF3q/XnpaNrex00hFAm0THgLqrflttmIT6A/NMFls
         x4XxooEqCPrZIPJRcqBgbRYL2uC0KAsnSEREwZVGI+nkK0S8Vn1cBCgAdets+k53pWPF
         nSgNvHBYqHkcDdqbHlNrnbtIQql9dFNom6EMPeUm5ZZ0fDTjsU3w8os9kx3WgYhWNXAy
         IV8xvq/KhJYe7ZJ2DRClTP/cXhOC5ggVWTi60gPLZeASMYBlLMnYFhPHXk4wI45LV+xA
         m71w==
X-Gm-Message-State: ACrzQf00jYhatfxbBdagv60AEDQRwHGBjtHSikOj2TcgvH4af1j6yEoh
        WHs4vIfW4Ou+wsRU4inVQD7T41lYsfE=
X-Google-Smtp-Source: AMsMyM61d0uRVa+BNT0VGyFVMXNge/BC5nmfyTczeaeRudihfYxFUTKn9u/Konp/zj5nMtro4m4MxA==
X-Received: by 2002:adf:f501:0:b0:22c:cbea:240a with SMTP id q1-20020adff501000000b0022ccbea240amr27058162wro.78.1667669319248;
        Sat, 05 Nov 2022 10:28:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b0023655e51c14sm2661810wrw.32.2022.11.05.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:28:38 -0700 (PDT)
Message-Id: <c455e855395dcc9215ea4ce3181eb3cbaff4000b.1667669315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
From:   "Alison Winters via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Nov 2022 17:28:35 +0000
Subject: [PATCH 2/2] completion: add case-insensitive match of pseudorefs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alison Winters <alisonatwork@outlook.com>,
        Alison Winters <alisonatwork@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alison Winters <alisonatwork@outlook.com>

When GIT_COMPLETION_IGNORE_CASE=1, also allow lowercase completion text
like "head" to match HEAD and other pseudorefs.

Signed-off-by: Alison Winters <alisonatwork@outlook.com>
---
 contrib/completion/git-completion.bash | 10 +++++++---
 t/t9902-completion.sh                  | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8ed96a5b8b6..161327057da 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -745,6 +745,7 @@ __git_refs ()
 	local format refs
 	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
 	local match="${4-}"
+	local umatch="${4-}"
 	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
 	local ignore_case=""
 
@@ -772,6 +773,8 @@ __git_refs ()
 	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
 	then
 		ignore_case="--ignore-case"
+		# use tr instead of ${match,^^} to preserve bash 3.2 compatibility
+		umatch=$(echo "$match" | tr a-z A-Z 2> /dev/null || echo "$match")
 	fi
 
 	if [ "$list_refs_from" = path ]; then
@@ -780,6 +783,7 @@ __git_refs ()
 			fer_pfx="$fer_pfx^"
 			cur_=${cur_#^}
 			match=${match#^}
+			umatch=${umatch#^}
 		fi
 		case "$cur_" in
 		refs|refs/*)
@@ -790,7 +794,7 @@ __git_refs ()
 		*)
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD; do
 				case "$i" in
-				$match*)
+				$match*|$umatch*)
 					if [ -e "$dir/$i" ]; then
 						echo "$pfx$i$sfx"
 					fi
@@ -824,7 +828,7 @@ __git_refs ()
 	*)
 		if [ "$list_refs_from" = remote ]; then
 			case "HEAD" in
-			$match*)	echo "${pfx}HEAD$sfx" ;;
+			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
 			esac
 			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 				$ignore_case \
@@ -833,7 +837,7 @@ __git_refs ()
 		else
 			local query_symref
 			case "HEAD" in
-			$match*)	query_symref="HEAD" ;;
+			$match*|$umatch*)	query_symref="HEAD" ;;
 			esac
 			__git ls-remote "$remote" $query_symref \
 				"refs/tags/$match*" "refs/heads/$match*" \
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f62a395d827..b4c46567fa4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2271,6 +2271,22 @@ test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGN
 	)
 '
 
+test_expect_success 'checkout completes pseudo refs' '
+	test_completion "git checkout H" <<-\EOF
+	HEAD Z
+	EOF
+'
+
+test_expect_success 'checkout completes pseudo refs case insensitively with GIT_COMPLETION_IGNORE_CASE' '
+	(
+		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&
+		test_completion "git checkout h" <<-\EOF
+		HEAD Z
+		EOF
+	)
+'
+
 test_expect_success 'git -C <path> checkout uses the right repo' '
 	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
 	branch-in-other Z
-- 
gitgitgadget
