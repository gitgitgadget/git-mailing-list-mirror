Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF1DC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355117AbiBCUrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356616AbiBCUqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:32 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A76C0619C6
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 12:44:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so2593970wmb.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 12:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QsJGh1wZjzhbH/vr5krwPCPbeeokupZ5HxSf+KQV73s=;
        b=Qpcb52dhAYv33MVBVQxEpcAgKw50R/HJaha0qdQxWBsYX+KeWBCk28Kaat4mvzBzfO
         myWpdB4yDGhp+hDGI98dvt5W0CnTqmQg0EceuMhcoC9zR8GZK21OGplJ/Hl21/wH4jb+
         cjQHMvdPf2XKHZaC8S9FEMeqzn6dTkrhRXA9LmyZnK03G/dmIIwzp5QpsUV2WwsQ/Mz4
         OO43cwG55UrhSJPONTpFSLcFKRBfGr2kkrtxRqPf7IoYBkZVs6WA4jDYQjX9LEN9WuXc
         mUh2WS5t0Nr7jdMp5FvoUos4fv9rDUH8i9zd+FH7JybURSyWlPibP/YOc/+preyNVtA5
         d/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QsJGh1wZjzhbH/vr5krwPCPbeeokupZ5HxSf+KQV73s=;
        b=OIzQKyRjARuc9D0u87UXFqKcrWKYmMl66lwxSsuRbX3kHWu4YRqvTOuKuibwrbJqf6
         UD0FCE6C6NwFNsMDEx75CYWr6gDjlD98SzpVdODDodv5tb6jGS6wZdElGz6sc3O5q8iK
         A86WDxhd34na5op+7B5lLjJqhAWez5Ldvzn3IlO6stD1PEeQwQV5ZU6S60rgxv74Thfg
         Sbh+/hm7wZMy5fWBErQ/hsY2VWcSQI9HgDAlzu24zh97+FI5MyCRuYNEubiDUIpLbQ4J
         fG9NbVlBRdH+UoyQEf9RZ0XlqOZ4MhIc4I56h/kW9Diwwy5+O07nIJkshnt3ezGaXriZ
         XF7w==
X-Gm-Message-State: AOAM533dFv89Ccow+2+dK1zKIdtgyjKZvrK/CVv7G8O5CINp8uUCIXu6
        UGd58r5DxfxxUrqkl8gQUmOtRahJs3Y=
X-Google-Smtp-Source: ABdhPJz8QUve+2JuPnSg+UC7sLYtbF5QS/rqtdJoJ9Dk0QciBIZ+4DsS4Zh13v2JFRxjTPUIDrTaIA==
X-Received: by 2002:a05:600c:3b90:: with SMTP id n16mr11665002wms.178.1643921094851;
        Thu, 03 Feb 2022 12:44:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm10223076wru.107.2022.02.03.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:44:54 -0800 (PST)
Message-Id: <ddf5e583dd71a729d6fb0513aed9fc4eb6ebbdd7.1643921091.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
        <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 20:44:51 +0000
Subject: [PATCH v5 3/3] completion: handle unusual characters for
 sparse-checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Update the __gitcomp_directories method to de-quote and handle unusual
characters in directory names. Although this initially involved an attempt
to re-use the logic in __git_index_files, this method removed
subdirectories (e.g. folder1/0/ became folder1/), so instead new custom
logic was placed directly in the __gitcomp_directories method.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 50 +++++++++++++-------------
 t/t9902-completion.sh                  | 28 +++++++++++++++
 2 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c5c8df6b6e5..c47e9ce09b2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2988,32 +2988,30 @@ _git_show_branch ()
 
 __gitcomp_directories ()
 {
-     local _tmp_dir _tmp_completions
-
-     # Get the directory of the current token; this differs from dirname
-     # in that it keeps up to the final trailing slash.  If no slash found
-     # that's fine too.
-     [[ "$cur" =~ .*/ ]]
-     _tmp_dir=$BASH_REMATCH
-
-     # Find possible directory completions, adding trailing '/' characters
-     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
-         sed -e s%$%/%)"
-
-     if [[ -n "$_tmp_completions" ]]; then
-         # There were some directory completions, so find ones that
-         # start with "$cur", the current token, and put those in COMPREPLY
-         local i=0 c IFS=$' \t\n'
-         for c in $_tmp_completions; do
-             if [[ $c == "$cur"* ]]; then
-                 COMPREPLY+=("$c")
-             fi
-         done
-     elif [[ "$cur" =~ /$ ]]; then
-         # No possible further completions any deeper, so assume we're at
-         # a leaf directory and just consider it complete
-         __gitcomp_direct_append "$cur "
-     fi
+	local _tmp_dir _tmp_completions _found=0
+
+	# Get the directory of the current token; this differs from dirname
+	# in that it keeps up to the final trailing slash.  If no slash found
+	# that's fine too.
+	[[ "$cur" =~ .*/ ]]
+	_tmp_dir=$BASH_REMATCH
+
+	# Find possible directory completions, adding trailing '/' characters,
+	# de-quoting, and handling unusual characters.
+	while IFS= read -r -d $'\0' c ; do
+		# If there are directory completions, find ones that start
+		# with "$cur", the current token, and put those in COMPREPLY
+		if [[ $c == "$cur"* ]]; then
+			COMPREPLY+=("$c/")
+			_found=1
+		fi
+	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
+
+	if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
+		# No possible further completions any deeper, so assume we're at
+		# a leaf directory and just consider it complete
+		__gitcomp_direct_append "$cur "
+	fi
 }
 
 _git_sparse_checkout ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index b38a7302249..7f63d6057be 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1508,6 +1508,34 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
 	)
 '
 
+# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes in paths
+test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with special characters' '
+	# reset sparse-checkout
+	git -C sparse-checkout sparse-checkout disable &&
+	(
+		cd sparse-checkout &&
+		mkdir "directory with spaces" &&
+		mkdir "$(printf "directory\twith\ttabs")" &&
+		mkdir "directory\with\backslashes" &&
+		mkdir "directory-with-áccent" &&
+		>"directory with spaces/randomfile" &&
+		>"$(printf "directory\twith\ttabs")/randomfile" &&
+		>"directory\with\backslashes/randomfile" &&
+		>"directory-with-áccent/randomfile" &&
+		git add . &&
+		git commit -m "Add directories containing unusual characters" &&
+		git sparse-checkout set --cone "directory with spaces" \
+			"$(printf "directory\twith\ttabs")" "directory\with\backslashes" \
+			"directory-with-áccent" &&
+		test_completion "git sparse-checkout add dir" <<-\EOF
+		directory with spaces/
+		directory	with	tabs/
+		directory\with\backslashes/
+		directory-with-áccent/
+		EOF
+	)
+'
+
 test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
 	# reset sparse-checkout repo to non-cone mode
 	git -C sparse-checkout sparse-checkout disable &&
-- 
gitgitgadget
