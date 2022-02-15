Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D3DC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiBOIc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:32:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiBOIcl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A9DC3309
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k1so30740890wrd.8
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dHb1rCKERi19T6nYLYN6+lO0wE8S9YzSIrHxyIls5Uo=;
        b=ghaH3arehw06Xoip3gy1y29DS5XT3QdFEuG3ict4sIl54I8hRisQfDe+3RHNqO2oOw
         2xXx6CNaIPXrEfSJ/6jDN7ITAe66xJFy2qhKt/5BHTfSdVyZrByuIV/QMPb1Qkl9/E0y
         GJwAMUolELMB69c2yVGQ3NXlihUAH6S/Fz+aInBWVnW6EBebYqJt3PBcXnXs2Q5zm1wY
         FfBGihcUvCKMS+lhLUELf3Uu0b8I9ARZJHSKFZMZ2MxQiU1cjePTYF0H7njLN8xATYDz
         G+CU0lVEPJLI9tiMCtFAzEEmB5KXHeQGXeJaMPxDTqvGo8qdb94FBWbJAD2sC/96t1dp
         88sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dHb1rCKERi19T6nYLYN6+lO0wE8S9YzSIrHxyIls5Uo=;
        b=Z01+KBTaQuXh/CcHbdC2A7zbxnqKWEyuK4rEMzNZGPjeRrnY9zjwmW06ftneOCRRn8
         NdREJUB3baoamv5+4TbUofcYoGQ77bXUEu9WG1HNNVLDE2jEqDFi+7mNfOoNYQ+X3Y7x
         ga0IwYstIr+I164dJpsBVur6lah6ZrxgV5FO9tZbs60jl5Q/Lyl/ROAF7UnMNIpN67M8
         N6r6K3TqO3vdVsVta2XcVbFyxO6XdRqUoF+pJcuAVyTAP/ZtWLvjdT2I5vb/ARI5U5/W
         hSdDaICsn/TfrmgetBNFHzvPQxyBdOS1yZ1n2jbhTA9cWp1oB0+pWI4xpwEPlBoxY1Mp
         MJ6A==
X-Gm-Message-State: AOAM532YaKXiIkXWQ0hGA9rOzBeEfGyBS2fwGz0z/wQiTx/Mew2X9t00
        kqfrrwWHBPJ3vg5EwLpl82K7SiBl2lY=
X-Google-Smtp-Source: ABdhPJxW1HRLV2mW2rziiW/t34mgifxjugNKurzbA3fMffOxM5yzQYQyFH2a+x6aAJ/10O3a317p1A==
X-Received: by 2002:a5d:58c8:: with SMTP id o8mr2183222wrf.233.1644913949734;
        Tue, 15 Feb 2022 00:32:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7sm13869391wrb.43.2022.02.15.00.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:32:29 -0800 (PST)
Message-Id: <c5d4ae2cfd6744a22d9feda1c0c14235af2b6a46.1644913943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 08:32:22 +0000
Subject: [PATCH v2 5/6] sparse-checkout: reject non-cone-mode patterns
 starting with a '#'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In sparse-checkout add/set, in cone mode any specified directories will
be transformed into appropriate patterns.  In non-cone mode, the
non-option arguments are treated as patterns.

Since .git/info/sparse-checkout will ignore any patterns starting with a
'#' (they are just gitignore patterns), if the user passes an argument
starting with a '#' to sparse-checkout add/set in non-cone mode, it
would just be treated as a comment and ignored.  Error out in such
cases, informing the user that they need to backslash escape it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 5 +++++
 t/t1091-sparse-checkout-builtin.sh | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 64583fa704f..74d64ada9f9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -710,6 +710,11 @@ static void sanitize_paths(int argc, const char **argv,
 	if (skip_checks)
 		return;
 
+	if (!core_sparse_checkout_cone)
+		for (i = 0; i < argc; i++)
+			if (argv[i][0] == '#')
+				die(_("paths beginning with a '#' must be preceeded by a backslash"));
+
 	for (i = 0; i < argc; i++) {
 		struct cache_entry *ce;
 		struct index_state *index = the_repository->index;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3b39329266b..3c811724d5d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -853,4 +853,10 @@ test_expect_success 'by default, non-cone mode will warn on individual files' '
 	grep "pass a leading slash before paths.*if you want a single file" warning
 '
 
+test_expect_success 'paths starting with hash must be escaped in non-cone mode' '
+	test_must_fail git -C repo sparse-checkout set --no-cone "#funny-path" 2>error &&
+
+	grep "paths beginning.*#.*must be preceeded by a backslash" error
+'
+
 test_done
-- 
gitgitgadget

