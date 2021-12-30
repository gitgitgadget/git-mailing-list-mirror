Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE27C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 19:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbhL3T07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbhL3T05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 14:26:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD7C06173E
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:26:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s1so52314317wrg.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qgF1+BTQPuGV4qh5BCcVuYySkHoEJLcnieQpUFV2Z8=;
        b=S0jYsx4qlR9dTUkNiKQZHauqQWYyy0oaBUQ/bIdaMzvg3+Xl2yXBEWHLbHZjIRpDAJ
         QG1szVIraur3Czach0lx/QAoflNJ7L1NWZZRL38r4CxsM3X+pIz818PvJ6sloSNHCg7B
         s2OMY7zPxG5GG9Me4auQE6K9dqh8moUZ33yR9y074vVbJoJwGA5GuXD4KjX89V35SAKK
         m5jzq+C8R3idK44jsaDMWjt7lc4UQXVWUOnmJtDOGGKZAmziHWUnlrcefi9qkEuhbkR+
         oGmfg8ZLtUq4+qxcHUMMISzwy7T3hEFoNOGlCQAZ46lc7p64LNQIaLtm1sOqITFAAi+m
         BpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2qgF1+BTQPuGV4qh5BCcVuYySkHoEJLcnieQpUFV2Z8=;
        b=2zpgkmVHNkHojC5HIGwWDVqCUmieU2aCbZSH7PcrBmwq6CHRUMOkG1ZuAAZ4UXW/oT
         9dwi4zE0BtbbHdyBuTIiLTsVXyAgBWWj2IeZz/k/CHujsHgoFVKiEYXXW+jw5kHU/K25
         8vx7u4CeWyqfSKHJ9VmEf+jgXb2mwanmU278stbypWYUZjrvh7p91QhFqBUVrcjxlUQy
         CKyZ9sIe+S29Igiwng6ohcpM/LYNPMQCiDteQ8OXEvvaXOMkCmQObu3o0fiXzLCl4TGW
         MkiIX5vuKUqsPL5Bi3OOpXMMwbbnHRb2ZDT7TvBpQD1WBGnFiZXjT4xlOSPX4gso9zHo
         Qubw==
X-Gm-Message-State: AOAM5333EJMcqJ/p7ErxoFyvZnihwWdg/oSLKmZ6k1Hl3hATk6NWaidj
        r9moB7j/Vx0+K+9LPnH8G2Pe5qp5WJU=
X-Google-Smtp-Source: ABdhPJy2ytG1ataNtPoV6b7sCaHq3uqKSHHyHshVmWT0BL435WCRASYTpE5d5RZmOycwL4BcoC+jsQ==
X-Received: by 2002:adf:e74c:: with SMTP id c12mr26357008wrn.200.1640892415701;
        Thu, 30 Dec 2021 11:26:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17sm24440624wrp.68.2021.12.30.11.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:26:55 -0800 (PST)
Message-Id: <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
        <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 19:26:52 +0000
Subject: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Add tests for missing/incorrect components of custom tab completion for the
sparse-checkout command. These tests specifically highlight the following:

1. git sparse-checkout <TAB> results in an incomplete list of subcommands
(it is missing reapply and add).
2. git sparse-checkout --<TAB> does not complete the help option.
3. Options for subcommands are not tab-completable.
4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
both file names and directory names.

Although these tests currently fail, they will succeed with the
sparse-checkout modifications in git-completion.bash in the next commit in
this series.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 t/t9902-completion.sh | 85 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 518203fbe07..51d0f2d93a1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1447,6 +1447,91 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	EOF
 '
 
+test_expect_failure 'sparse-checkout completes subcommands' '
+	test_completion "git sparse-checkout " <<-\EOF
+	list Z
+	init Z
+	set Z
+	add Z
+	reapply Z
+	disable Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes options' '
+	test_completion "git sparse-checkout --" <<-\EOF
+	--help Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes subcommand options' '
+	test_completion "git sparse-checkout init --" <<-\EOF &&
+	--cone Z
+	--no-cone Z
+	--sparse-index Z
+	--no-sparse-index Z
+	EOF
+
+	test_completion "git sparse-checkout set --" <<-\EOF &&
+	--cone Z
+	--no-cone Z
+	--sparse-index Z
+	--no-sparse-index Z
+	--stdin Z
+	EOF
+
+	test_completion "git sparse-checkout reapply --" <<-\EOF &&
+	--cone Z
+	--no-cone Z
+	--sparse-index Z
+	--no-sparse-index Z
+	EOF
+
+	test_completion "git sparse-checkout add --" <<-\EOF
+	--stdin Z
+	EOF
+'
+
+test_expect_failure 'sparse-checkout completes directory names' '
+	# set up sparse-checkout repo
+	git init sparse-checkout &&
+	(
+		cd sparse-checkout &&
+		mkdir -p folder1/0/1 folder2/0 folder3 &&
+		touch folder1/0/1/t.txt &&
+		touch folder2/0/t.txt &&
+		touch folder3/t.txt &&
+		git add . &&
+		git commit -am "Initial commit"
+	) &&
+
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout sparse-checkout init --cone &&
+	git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
+
+	# test tab completion
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set f" <<-\EOF
+		folder1 Z
+		folder1/0 Z
+		folder1/0/1 Z
+		folder2 Z
+		folder2/0 Z
+		folder3 Z
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout/folder1 &&
+		test_completion "git sparse-checkout add " <<-\EOF
+		./ Z
+		0 Z
+		0/1 Z
+		EOF
+	)
+'
+
 test_expect_success 'git switch - with -d, complete all references' '
 	test_completion "git switch -d " <<-\EOF
 	HEAD Z
-- 
gitgitgadget

