Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1065C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKHWoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiKHWoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:44:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634BA21241
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:44:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p16so9705377wmc.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/qBtdZ69IG5ihaw98dYPOr1oYuv5CWv1pqA2wxwrrQ=;
        b=oXK/93sI3u1gfnCspoklK2nymcSt/iW1Vy9ClpoNzFyY+WRkxHbNuEck7Vniq0WvLS
         q8Yc2d2upcDjiCE+SM7OsLgdpiZqIY0rC5nACobU2jcp3k91iA3YkeePhfyqZUb8e1jO
         NoSdyLxy1vWdlRlKFgFSBaUOFTypuKweo5/gbGKFFzwR6eValC29LbiKrmOYVDF/agYC
         hcBohb92cBGDWTxzkpDF26lB6ENoeXpzqraBB5fnas0RBw1Zl/QWuqUWZvBFigvKVJyW
         JT5Iw6+BGp3K98JUB0R3a8juAm7Q/B6h1dLhACFXXE6B+g1Yo3MRf793NAiPtskIMKtB
         ix3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/qBtdZ69IG5ihaw98dYPOr1oYuv5CWv1pqA2wxwrrQ=;
        b=NR2LkmX1QjHpF59fOjkwW5my8unfWLVngoiLfYUiKLzle1IC8oGGsxSCSjj9rhsh7L
         dyZlKgDan7cuT5an9oHYtj0wrtKLRBC5PyStE3KyFSy6jcNp/XVuQ25EXSw9ohZndNqQ
         R3GZuMKBZveAO1IX31anNOwSxOcg7auLe6mtqQna5LmDzSjDvWbTwnz8OT1sNHGOy4CM
         CvzQiOOGjw8DSIzpaHrug1z7q7GG+E1XWeDAmOfEkDzCW5ZX2SJ8yEjfPV5BRrvdkAWq
         VQivMqTJveBEhxgs3gxBAYp7Glejliqc/NSLSefMtOh1SNIUUjXOFyB2Bctup+fAguZE
         biCQ==
X-Gm-Message-State: ACrzQf2ghjZO9WZxUyrnh2JHi5Lgyx6oyeaBtcOjedkdHTFMQ6rSalJ1
        a6HWW32Wz8iAD1aD+tlYFjQStySpMLs=
X-Google-Smtp-Source: AMsMyM7KB3iq4IedjXDlTRHYYkWaLmL8P7ZxJQ3q9QHz2lKvi/4Ehi5VdgwCB9nebn5zdSS61poCzA==
X-Received: by 2002:a05:600c:2e07:b0:3cf:92cc:4aa8 with SMTP id o7-20020a05600c2e0700b003cf92cc4aa8mr20136233wmf.68.1667947470769;
        Tue, 08 Nov 2022 14:44:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b003c701c12a17sm16922358wmq.12.2022.11.08.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:44:30 -0800 (PST)
Message-Id: <dd4edd7cad8d06b3464608cc3ce79bb0368a5e2e.1667947465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 22:44:25 +0000
Subject: [PATCH 5/5] rebase: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable the 'skip_cache_tree_update' option in both 'do_reset()'
('sequencer.c') and 'reset_head()' ('reset.c'). Both of these callers invoke
'prime_cache_tree()' after 'unpack_trees()', so we can remove an unnecessary
cache tree rebuild by skipping 'cache_tree_update()'.

When testing with 'p3400-rebase.sh' and 'p3404-rebase-interactive.sh', the
performance change of this update was negligible, likely due to the
operation being dominated by more expensive operations (like checking out
trees). However, since the change doesn't harm performance, it's worth
keeping this 'unpack_trees()' usage consistent with others that subsequently
invoke 'prime_cache_tree()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 reset.c     | 1 +
 sequencer.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/reset.c b/reset.c
index e3383a93343..5ded23611f3 100644
--- a/reset.c
+++ b/reset.c
@@ -128,6 +128,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (reset_hard)
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
diff --git a/sequencer.c b/sequencer.c
index e658df7e8ff..3f7a73ce4e1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3750,6 +3750,7 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
-- 
gitgitgadget
