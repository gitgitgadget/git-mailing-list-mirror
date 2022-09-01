Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35914ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 07:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiIAHJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 03:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiIAHI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 03:08:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F912205E
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 00:08:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so18322567wrm.8
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=E0aGUFG6eZNOA3RgnVzdQdu9rzC1KBfbb2w+H7CLKJM=;
        b=MiX269tpxsvyr5KqADk7h9B6FpkIG3OIyBGaajiDnwMc+bXr2/Ns25lGq9UuU9aBFV
         Sc1OZc79A4LLOWs03Y3E1svG5QPUjcIfyP/H4Qy9StfHaBI93yGkM9ff10QefC0SmgWl
         0hT9x8wfQWODZz2Yeazpur+XqaNF8eToqqrUCGARZq/7Szd/4abS9rt1XtsvVUfxlMtJ
         xEeW0Xezvrcbey5jL40MtkwCsGgVGI0IMvzM+ZOHZdnp3DaaIeAyybFF5CsEm0EagTGG
         0izrTSZBl2QZgQ9DIJBl3wKq9xkuJakGTkgzgaRTTIrZceqTV9YMjfJ25EZQicky7f4q
         ULbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=E0aGUFG6eZNOA3RgnVzdQdu9rzC1KBfbb2w+H7CLKJM=;
        b=aKQwsLmgo9ybfaDkIPjvK4zavqLcQq+cXn+Oqykn7Hdcr2MToykxnZmrZvSKunS+y9
         gq4MDdpXc3HDelMHnlg5ufU156KmbSlbGdc/0+FzrtoPzN/TworQiCOZHbpOphMe36Ca
         EgsecTqcALaofwDCROjK+kg4BpTh3SoQzH9TzovTKaUTUJBtb535YLKx9TAR4aHFX+C4
         FXkj1fQJgDl4GRb1O69nUQFAwN25SmwzpqCCkmT3F7npgEaGllHnnOQrMwLeqFjiQXAy
         3JNhxW4QZqYseqRX0rU/e8xSI8ICSWC/VGmoC7QRbL+1+S8TtMTWgzSLEMKf0inCqp7s
         KRDw==
X-Gm-Message-State: ACgBeo0NfY0pHehEfFZo8uNt53ZLDnVRrNHWC/ZQldhCita8kVik4o81
        jlCxeMjCHOULiapQnJVXNjaqe275yXw=
X-Google-Smtp-Source: AA6agR5v3pNz4In37hiG1KdyLtvxE3IjMP0QMYDNSIlbAeM+CbFGh8ziwRaD0z3McHM2wxA3NYThMw==
X-Received: by 2002:adf:fe44:0:b0:226:da5d:990 with SMTP id m4-20020adffe44000000b00226da5d0990mr10975810wrs.334.1662016094536;
        Thu, 01 Sep 2022 00:08:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bq13-20020a5d5a0d000000b00226fa6cf1d3sm284558wrb.7.2022.09.01.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:08:13 -0700 (PDT)
Message-Id: <7903f8380dc512ba827209ba3b152d0784df7b60.1662016088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 07:08:07 +0000
Subject: [PATCH v2 3/3] diff: fix filtering of merge commits under
 --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 95433eeed9 ("diff: add ability to insert additional headers for
paths", 2022-02-02) introduced the possibility of additional headers.
Because there could be conflicts with no content differences (e.g. a
modify/delete conflict resolved in favor of taking the modified file
as-is), that commit also modified the diff_queue_is_empty() and
diff_flush_patch() logic to ensure these headers were included even if
there was no associated content diff.

However, the added logic was a bit inconsistent between these two
functions.  diff_queue_is_empty() overlooked the fact that the
additional headers strmap could be non-NULL and empty, which would cause
it to display commits that should have been filtered out.

Fix the diff_queue_is_empty() logic to also account for
additional_path_headers being empty.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  | 1 +
 t/t4069-remerge-diff.sh | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/diff.c b/diff.c
index 85905261ce4..5ea9071ff07 100644
--- a/diff.c
+++ b/diff.c
@@ -5916,6 +5916,7 @@ int diff_queue_is_empty(struct diff_options *o)
 	int i;
 	int include_conflict_headers =
 	    (o->additional_path_headers &&
+	     strmap_get_size(o->additional_path_headers) &&
 	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 95a16d19aec..07323ebafe0 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -56,6 +56,11 @@ test_expect_success 'remerge-diff on a clean merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'remerge-diff on a clean merge with a filter' '
+	git show --oneline --remerge-diff --diff-filter=U bc_resolution >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'remerge-diff with both a resolved conflict and an unrelated change' '
 	git log -1 --oneline ab_resolution >tmp &&
 	cat <<-EOF >>tmp &&
-- 
gitgitgadget
