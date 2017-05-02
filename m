Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60F98207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbdEBWXn (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:43 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33238 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbdEBWXh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:37 -0400
Received: by mail-pf0-f182.google.com with SMTP id q20so3539745pfg.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87bGvMR2t+FQTPWf4sT6GOUyE3X41iATG4sw0YGbIk8=;
        b=Cq7nIsjwjV9JXdu81DMIx32sJP3bi8qhO6O6dzvvwhj29r4FuL33YsxlvxXHXOiBwd
         B2PNKbnzrn/eqMdFdkjXVNV24lpT3kKMdMRhcpp4O9u3n0O3zpoEPLD8YalpPETPJqFg
         uqwAd2HVFefsIrgkb+3EZdI2gkL+/6eD8F5JQz9y45zizyNZMe/90NiVYStGuivvfpKR
         HHfwzpgli/MUxkjYCjXqvze86uOQ+1Q4OFBzTkx2EotSugDLaMLGnHbNH8I7U/KcRlXm
         HamrdUi3TRYcNTU44BwNaDW5m8omPPDW1QtjLhu/18jdeVM4iDVAvH5MNwbqk+FDMrua
         d7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87bGvMR2t+FQTPWf4sT6GOUyE3X41iATG4sw0YGbIk8=;
        b=kJFJ6m5dB4k4g4PE/J1dElW7j8ENDm9jVtOINZ4Y4OR5XQnE6Ped/+sdIJoGJOwbfI
         WyWu1zYCHGNzc+0OCkCjreYb1gbEL4UCRHKnIZV+P/2cVlabQb2dtlK0TM4IlE75g6YM
         hVYEt1na3ltyzyRBzXfE0STHTkD0TKZY/Mn3Xz7d0N8OkXdig7hj/bBF0quoZdLbPbms
         Wcn22dk/CabyElKIt299IMUiQJuWeTur92ZRYKWhjGv9s6b+goNSLSQhCpYOl7ymHpBy
         j0VaBZP142veAtZ1sVmTjKlTf3TMxISzVPsTxPvYEam6IMD3zqkUzIWobSJ+M0WpqdAf
         Q2ng==
X-Gm-Message-State: AN3rC/5zvN1oWB5p0aTKa4wiBVyYUCScri/Dh/uhSYbeOn1bENGxoaB0
        Mun18ldIYl3DfUTK
X-Received: by 10.98.1.22 with SMTP id 22mr1354395pfb.263.1493763816193;
        Tue, 02 May 2017 15:23:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id y78sm674670pff.107.2017.05.02.15.23.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/24] unpack-trees.c: rename parameter 'the_index'
Date:   Tue,  2 May 2017 15:23:04 -0700
Message-Id: <20170502222322.21055-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As "the_index" is already a global variable, we do not want to confuse
the local variable with the global variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index aa15111fef..3dd8f60fc1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1199,7 +1199,7 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
  */
 static void mark_new_skip_worktree(struct exclude_list *el,
-				   struct index_state *the_index,
+				   struct index_state *index,
 				   int select_flag, int skip_wt_flag)
 {
 	int i;
@@ -1208,8 +1208,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 1. Pretend the narrowest worktree: only unmerged entries
 	 * are checked out
 	 */
-	for (i = 0; i < the_index->cache_nr; i++) {
-		struct cache_entry *ce = the_index->cache[i];
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
 
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
@@ -1224,7 +1224,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(the_index->cache, the_index->cache_nr,
+	clear_ce_flags(index->cache, index->cache_nr,
 		       select_flag, skip_wt_flag, el);
 }
 
-- 
2.13.0.rc1.39.ga6db8bfa24

