Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6961F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 16:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbfJOQhN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 12:37:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36486 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJOQhM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 12:37:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23so12480131pgk.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyzSCRt0zvpwaXWv7f44EZ1PtFcPzYiM4w4+E1GJkeU=;
        b=drRxIrMklLp0IseHcjQskRLzOjjMEtgg5voDwbmYLA7gNp4GlSek1j9dR5eyP3vI0Z
         XIoN+NR+nMwb+MLsD1qiDTWeK7iMflai78EXPZbUO8FVhp20Q31BqEDgZREnsw/Rqbqc
         XSmaVyAnhGzyM3X3d/NTU/Nh7iIGPoynhLLigh+LpgdcH05OVBqTSL7p0HJ3sI01pIiF
         y0GOysooWZeWxXBEn97KGzKnVi/7M6T6/AWmREzr6jhKC4xmbspYgXXQqcgo5ba4uVZy
         RlvDZ1HomdO45+fFtSbnseNB5y5Z2UVNgEMdpvHYWpEO5px7s9z7m09VKlJjgVW1eQWD
         c8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyzSCRt0zvpwaXWv7f44EZ1PtFcPzYiM4w4+E1GJkeU=;
        b=FU8qXNbJmPVZYUulz/j8CPpfOmDEqqfLmjQvjMT/QnEbePmiWIyypYaf4vvxQJcvtS
         fd+ytrcdhNv8DzMtwYL5noD1gSZFxS21B7+92O7Ue8ckS6ZkrLagSkF3OCuUbmm1eeQU
         8yEsdoBUt4mk6Dm3lp1afh/H+nz1Vzouvt7RZPEHYQN0UX2t20sG99B+jzuxxZKvOxfL
         E0OYoGTTzRh6J+sFlqnOqmfbdFvwm36Iob/gJltWvFHR+CtNAE/vMzx2wC1iMaykFPWb
         FjWp8t5faOY/FqWh8zsHP0BrIib1u7q2ntMFOD0u8HI9xeUvjNpvgFkeab1UIDASEnpT
         i4yg==
X-Gm-Message-State: APjAAAWmgJAsRGbKSen+fkwXRHNUd+DbKOz4r+UZQ3qo1x0IEHXWzjNw
        Hj0EgsL5QHlF7qNBdhtNbGe7ONrU
X-Google-Smtp-Source: APXvYqwAc31LKia3xQt4CZr09nlmfnfMJe255i1mjD9ceUzwuaCuToYVwweIgdik9X95tHQXvV2/mQ==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr40722734pgb.416.1571157431611;
        Tue, 15 Oct 2019 09:37:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:2b61:f51c:7233:c8a4:1e74])
        by smtp.gmail.com with ESMTPSA id c8sm9347151pjo.1.2019.10.15.09.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:37:11 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 1/1] notes: copy notes to HEAD by default
Date:   Tue, 15 Oct 2019 23:36:31 +0700
Message-Id: <20191015163631.21808-2-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015163631.21808-1-congdanhqx@gmail.com>
References: <20191015163631.21808-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The target objects for copying notes was defaulted to HEAD from very
early stage of git-notes.

However, that default was limited by commit bbb1b8a35a, ("notes: check
number of parameters to "git notes copy"", 2010-06-28).

Lift that limitation by adjust the check for numbers of arguments.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 Documentation/git-notes.txt | 6 +++---
 builtin/notes.c             | 2 +-
 t/t3301-notes.sh            | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index f56a5a9197..ced2e8280e 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git notes' [list [<object>]]
 'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
-'git notes' copy [-f] ( --stdin | <from-object> <to-object> )
+'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
 'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [--allow-empty] [<object>]
 'git notes' show [<object>]
@@ -68,8 +68,8 @@ add::
 	subcommand).
 
 copy::
-	Copy the notes for the first object onto the second object.
-	Abort if the second object already has notes, or if the first
+	Copy the notes for the first object onto the second object (defaults to
+	HEAD). Abort if the second object already has notes, or if the first
 	object has none (use -f to overwrite existing notes to the
 	second object). This subcommand is equivalent to:
 	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
diff --git a/builtin/notes.c b/builtin/notes.c
index 02e97f55c5..95456f3165 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -513,7 +513,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (argc < 2) {
+	if (argc < 1) {
 		error(_("too few parameters"));
 		usage_with_options(git_notes_copy_usage, options);
 	}
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d3fa298c6a..a8f9a0f36c 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -908,6 +908,10 @@ test_expect_success 'allow overwrite with "git notes copy -f"' '
 	git notes copy -f HEAD~2 HEAD &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
+	git notes copy -f HEAD~2 &&
+	git log -1 >actual &&
+	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
 '
 
-- 
2.23.0

