Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A3C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbiA0VWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiA0VV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:21:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB28C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c2so2861517wml.1
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AyUX98jHiz4d9t0sthFC67+vY1meE25DkgIlmuUYxFk=;
        b=LHs1+AXu7smI3o6AMSgJJ8PKgWG4Ocs7X/9e5btIVZuYjEkzYLhLvo8G0x0zvSMkOh
         kccPUj+bAN8dfX17eA8JpVuROfkIo4Ld4Y/pWppRS2RmpBZS1TPbqLhHcbPaTp+ra7ez
         DZYrWGM57rJhV04ke07W8Qxmayx0cYJXxTQW6Oynq3Lw+CNtoRZjBtgiE9HvzSFVJxKk
         YKmws2IDhn9EEAcP8tkU2Dzt4yS3yfA6WgJyzXjV7H2yW45nRreN+xRoa92ONvN3j4tw
         n+9BTWcpmaO66J3RrpXT+NQg+IMS0e+3GeV2K5jQk9lhpX4P2gOsAe+CLxam+eSjGbeG
         zOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AyUX98jHiz4d9t0sthFC67+vY1meE25DkgIlmuUYxFk=;
        b=xpbaUWpcbCVAfvFSO1por9aiQ/VRZwmTpCqD0Tv+p0UrTMNAdZ1TVsG14N9/HmV0qL
         kcz2iFg75uAtQSOXnOgt9I41fUI0RDAjr5wI+FLuRASZDTHH29m+7akRw83Lr/eFQf1y
         CBJ88wE44uDnPzwp08OLWcBMP0DGlHGp9WhBYVLJAu9dtv2p0bMNVqtKwBdBI25uvsK9
         d6zwepV8SjFs740CZdIw2gW0gzhscSEAmk3fJkpjm5qpgc5CyhhngJQgc9WV/B+0+7N2
         QS2Y8XL05E8rhk9ybfqorRmD74u4LQ3R/m7tP3oG9zL4on2rVmBMc2u3be+mLaYuFSY8
         zhlw==
X-Gm-Message-State: AOAM532KCp+WhhiUpM+f8qBDS8b81IfmyDRbi7EiLun4HfjsaYPoB7Mj
        1AJFPFaLWixz1vblg4sTPDFqKft7hE4=
X-Google-Smtp-Source: ABdhPJyJtiiApMicTNQg2KtN/G9yhLppm9QcGH/wOIz/ey7ox2OkbYgDJthx4aQkMV/4RAaK8ir7Vw==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr13313156wmi.186.1643318517315;
        Thu, 27 Jan 2022 13:21:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm3071293wrm.68.2022.01.27.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:21:56 -0800 (PST)
Message-Id: <7d70beb2a6b3967c51d1d7feb34bfb9368066cdb.1643318514.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
        <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 21:21:53 +0000
Subject: [PATCH v4 2/3] completion: sparse-checkout updates
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

Fix custom tab completion for the sparse-checkout command. This will
ensure:

1. The full list of subcommands is provided when users enter git
sparse-checkout <TAB>.
2. Subcommand options are tab-completable.
3. A list of directories (but not files) is provided when users enter git
sparse-checkout add <TAB> or git sparse-checkout set <TAB> in cone mode
only. In non-cone mode, these commands will continue to complete both
directory and file names.

Failing tests that were added in the previous commit to verify these
scenarios are now passing with these updates.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++-------
 t/t9902-completion.sh                  |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c82ccaebcc7..a920cdab201 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2988,21 +2988,22 @@ _git_show_branch ()
 
 _git_sparse_checkout ()
 {
-	local subcommands="list init set disable"
+	local subcommands="list init set disable add reapply"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 		return
 	fi
 
 	case "$subcommand,$cur" in
-	init,--*)
-		__gitcomp "--cone"
-		;;
-	set,--*)
-		__gitcomp "--stdin"
+		*,--*)
+			__gitcomp_builtin sparse-checkout_$subcommand "" "--"
 		;;
-	*)
+		set,*|add,*)
+			if [ $(__git config core.sparseCheckoutCone) ]; then
+				__git_complete_index_file "--directory"
+			fi
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6004d854102..f56ba3f64c9 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1447,7 +1447,7 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
-test_expect_failure 'sparse-checkout completes subcommands' '
+test_expect_success 'sparse-checkout completes subcommands' '
 	test_completion "git sparse-checkout " <<-\EOF
 	list Z
 	init Z
@@ -1458,7 +1458,7 @@ test_expect_failure 'sparse-checkout completes subcommands' '
 	EOF
 '
 
-test_expect_failure 'cone mode sparse-checkout completes directory names' '
+test_expect_success 'cone mode sparse-checkout completes directory names' '
 	# set up sparse-checkout repo
 	git init sparse-checkout &&
 	(
-- 
gitgitgadget

