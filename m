Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E80C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 15:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJ1PYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJ1PYM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 11:24:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335AC20C988
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:24:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h9so7080507wrt.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oKu2ikdZsOecZ1tF6eazFWTlct7vD6/gYFmvO2GOgY=;
        b=HzlC0JSvgiigC+IcQPHFiXrEeykFOj0Tquh2Ni6E9cr31+aowuLzCf0qqkUhPq0b06
         iq/ifQk+tTvXah/EroeJn4JU1j7Yq8ThOeZYhWJScI5XPKPfxCF75NiBkeiDNapT0A9N
         htNpJcXPWcE02zXStFII4ytb9VFVLYrwqg5WryXPc5G16RpFXmb9X/Y87KuioPUsaacl
         1RlXR2C4AJs1w2cd15e8tr/N20kQJYPJBpmYuj5G5zKetLYGU1OdYh2/S3mH6X0OPWR7
         eefdNZJnDRnzi8G24TdLNQ4nt98Dna5YqomczpwxQUCQT6ZgfyBQSY2Z/Vad7Fe4JZX5
         2rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oKu2ikdZsOecZ1tF6eazFWTlct7vD6/gYFmvO2GOgY=;
        b=bM8YfvFXEtoMk2SU9QX9DDNNRqiHEV/2uZug1kJbPke2Sny35ri+4a4wREO1mdb68q
         DGTvOs4h6wDHi1+LfLK1y8fw+JOJzyRUB/W8CuegJzJzEEq3ohLpUlgOielN7WSNWf4f
         GDKU9aCka7l5GQASl4iQpkyJg32G9r8dB9wsuqXPCGP68MOiuaqdGMScD4unLUTIIWcm
         +ZjFheTwtESn2TvDQSm7EQWjYU3UjPRcSxxVB0s8glN38GxbhPeeiZuv33UAXbaWqYBL
         quLY/es9321OC89rbLwYj/+F2jEASXL5wwDWnyw4A9RgHyaO+J1EbLxIX68y2MB7JZZh
         lT0g==
X-Gm-Message-State: ACrzQf3Y+BBuEMv+YG8k1wBUKD3NJSmTRh8WOT+cFgnxTRslM8Qmri/L
        c9utUp02bLJ5ca9icf9ELNFrI84XIhU=
X-Google-Smtp-Source: AMsMyM6PhLhhA32gUJxZIm81u41lGGJWDxXiwaqtIeSYEIkLscvouIUKFii6SKgnUyiMV+ifeqGKjw==
X-Received: by 2002:a05:6000:1d94:b0:22e:34ef:b07f with SMTP id bk20-20020a0560001d9400b0022e34efb07fmr36107868wrb.272.1666970647459;
        Fri, 28 Oct 2022 08:24:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b003cf4006a9casm4372586wme.39.2022.10.28.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:24:07 -0700 (PDT)
Message-Id: <d0a6eea93b58f5a267352690adde00a5b0f3f089.1666970645.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
References: <pull.1373.git.git.1666970645.gitgitgadget@gmail.com>
From:   "Simon Gerber via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 15:24:04 +0000
Subject: [PATCH 1/2] tests: add test case for autocorrect in work tree for
 bare clone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Simon Gerber <gesimu@gmail.com>, Simon Gerber <gesimu@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Gerber <gesimu@gmail.com>

Currently, auto correction doesn't work reliably for commands which must
run in a work tree (e.g. `git status`) in Git work trees which are
created from a bare repository.

This commit adds a test which shows the broken autocompletion by calling
`git stauts` which gets autocorrected to `git status`. This works fine
in a work tree created with `git worktree add` from a regular clone, but
doesn't work in a work tree created with `git worktree add` from a bare
clone.

Signed-off-by: Simon Gerber <gesimu@gmail.com>
---
 t/t9005-help-autocorrect-worktree.sh | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 t/t9005-help-autocorrect-worktree.sh

diff --git a/t/t9005-help-autocorrect-worktree.sh b/t/t9005-help-autocorrect-worktree.sh
new file mode 100755
index 00000000000..4fecc8a8e01
--- /dev/null
+++ b/t/t9005-help-autocorrect-worktree.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='test autocorrect in work tree based on bare repository'
+. ./test-lib.sh
+
+test_expect_success 'setup non-bare' '
+	echo one >file &&
+	git add file &&
+	git commit -m one &&
+	echo two >file &&
+	git commit -a -m two
+'
+
+test_expect_success 'setup bare' '
+	git clone --bare . bare.git &&
+	cd bare.git
+'
+
+test_expect_success 'setup worktree from bare' '
+	git worktree add ../bare-wt &&
+	cd ../bare-wt
+'
+
+test_expect_success 'autocorrect works in work tree created from bare repo' '
+	git config help.autocorrect immediate &&
+	git stauts
+'
+
+test_done
-- 
gitgitgadget

