Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE09C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C402C60E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbhJ0MHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbhJ0MHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E26C061226
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so3731909wrh.8
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXlUzK0eG1nytfPPrkrw0gtj2yvs5u/jSO3jH2X9/oQ=;
        b=Ny7ItUp5bXqcNZURu/8HjGGU1SI0CxFP5+FOOYbrENZ910DWEvs2w+uRUnQvgZ2Qdm
         cbJjivC87bLBPxyFimTs8hrwMnJZdVtK7TfwO7AD9TK7uRGOEIq2sZ/vQqXw7zzV3LHh
         OfOrLKA7Z9jFjA3AOTJxRVRfed8BCjOJg9kPKlxvGzmCoJr0pmKy4xE4alLyZ47iGMCu
         W2hVdE+VaFoSYis95iB40c5vz/qnVYpWjeIBF0SiDZLbOnG6U95G+8GrEEfp72BxSrb7
         tOdgg8e//OqqfUJCPfTcypit2qr32Q+acT1t+FnSGsoLC8KG+GGbHkdypcduSg865K66
         3xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nXlUzK0eG1nytfPPrkrw0gtj2yvs5u/jSO3jH2X9/oQ=;
        b=GUGnezYvCdIIxxI7iJxwK/YATrJ3bqK2U/2vtz6t94aTcupt3sDE+beNU5SkquIL04
         LM8CkQ6pA46gSre9ccf6+nCobn43kue/sGdfGSMy8oB+z5k48dX6fnViLyRqupmEEKGb
         9VBv09h3oRp7pxH0cEx53hCtXGR+8bHnMLa1qHANv/50yWs1oenMswb9lu9GUGp5u1jN
         JhEmO+WckoykD+Hg128YlapPqDTmIIAr8c3OKMIgalrXzWgZjoYI8prPt9aIrMdYwts+
         unXG3GwyzH4ufXMuQhE011beiJM0WprN3oGfhWYDjzGQ19yuMMt3mrDoU66y4Reg7Cwa
         hPKw==
X-Gm-Message-State: AOAM532LWPll3Gdbmw6BoGwZu96ufPjthGgu3Y/i4TteXfL5qJpuDe5J
        aivpsHCuS4t8OuWjOsXwBbTrI745jug=
X-Google-Smtp-Source: ABdhPJzD0wMG9+9jqXL4tJhqfgXYVs/oUNntXxcx1OMXZPtwfJf4GTYzYLyPEw7t+O0vCsa1qh10og==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr18917633wri.226.1635336273830;
        Wed, 27 Oct 2021 05:04:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm3385790wrt.96.2021.10.27.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:33 -0700 (PDT)
Message-Id: <f142f33276a17b5ad74a60c26b54f099b25ba5d6.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:16 +0000
Subject: [PATCH v3 09/15] diff --color-moved: call comparison function
 directly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This change will allow us to easily combine pmb_advance_or_null() and
pmb_advance_or_null_multi_match() in the next commit. Calling
xdiff_compare_lines() directly rather than using a function pointer
from the hash map has little effect on the run time.

Test                                                                  HEAD^             HEAD
-------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.35+0.03)   0.38(0.32+0.06) +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.87(0.83+0.04)   0.87(0.80+0.06) +0.0%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.97(0.92+0.04)   0.97(0.93+0.04) +0.0%
4002.4: log --no-color-moved --no-color-moved-ws                      1.17(1.06+0.10)   1.16(1.10+0.05) -0.9%
4002.5: log --color-moved --no-color-moved-ws                         1.32(1.24+0.08)   1.31(1.22+0.09) -0.8%
4002.6: log --color-moved-ws=allow-indentation-change                 1.36(1.25+0.10)   1.35(1.25+0.10) -0.7%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 78a486021ab..22e0edac173 100644
--- a/diff.c
+++ b/diff.c
@@ -994,17 +994,20 @@ static void add_lines_to_move_detection(struct diff_options *o,
 }
 
 static void pmb_advance_or_null(struct diff_options *o,
-				struct moved_entry *match,
-				struct hashmap *hm,
+				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
 				int pmb_nr)
 {
 	int i;
+	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
+
 	for (i = 0; i < pmb_nr; i++) {
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
-		if (cur && !hm->cmpfn(o, &cur->ent, &match->ent, NULL)) {
+		if (cur && xdiff_compare_lines(cur->es->line, cur->es->len,
+						l->line, l->len,
+						flags)) {
 			pmb[i].match = cur;
 		} else {
 			pmb[i].match = NULL;
@@ -1195,7 +1198,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
 			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
-			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
+			pmb_advance_or_null(o, l, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
gitgitgadget

