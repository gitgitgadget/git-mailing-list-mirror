Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1151F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 23:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfJIXof (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 19:44:35 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50495 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732453AbfJIXof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:35 -0400
Received: by mail-pg1-f202.google.com with SMTP id r24so2848719pgj.17
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aAAGT4NUjKelOyrzYd7LK/IP6qzbo5FVS6y/TzQyBAI=;
        b=HYbfYV2XKme90/AIpKwFJpk44CCHx4r8+q8kA3jRhSK0tMw/2ZhXNaiOxStA7FScut
         rsN/CsHoyvZA+SBhuBnY9kk2M+3eluRkmJ1YG0ayQrBq5AZl+nOQHwsOeLHsv27fHoBi
         mGfWamzZkPuPt+q9WgLrM7xDW42MIgnEYQQC8R7RD1c326TyDosp4XCd0e4aeA4iq7w9
         MZzZeNxAoF/ui63aG6lgZjfCA/OcOVENNZDMeoEGl9ni4Gxiw/uOg3UIi0YuWwrfj+cY
         bne0MoYs8Fh1DKmzJmnyRSeA2r4ibHaBGIF/KlX8j27DJAAbmXRBEQ1/PHS31vNrP/sY
         gHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aAAGT4NUjKelOyrzYd7LK/IP6qzbo5FVS6y/TzQyBAI=;
        b=n0Pv1fE5J/93XCwkSAwRCTWt+4RdbCllwcnCmGTXMuRElBY8XqP/tIowr36jshqd/4
         eop3wbBuV3nAM5Q1RSAspsV9DLvYXiRpO5oOexan8qKjBLPgMJiA+TvQvg3ajFyTgOCZ
         KTBZFVESv3aapNow0s25LIyCi3Mk8/rWssXt/lmOhG1rnP+4i+ObPva2c6ogco3TGcRi
         6lIGjzfwbc4aco+oNreh910TjJuW6e1VuEXrCOS4vx/DhuzSUa71PDNZQk0fJm46M66W
         xWGM+xTJEY030mVD27lwtsA9iiG67fFxAevBiGIocWsk+PUZMSWDcfswAzrdvuXJR0TG
         gOwA==
X-Gm-Message-State: APjAAAXP8tSaGhJtk4UVohFSM5qRnc1LM4P2I1GEXZcrT0+u5jno3x8U
        v1dikypyNPAvLzqIW301Ow3FZf+wmnTHNAIe3ozInvfqAc2/glNap45UR8OhT8KH22YzP4+BaBu
        kAgte/iB9fBFTX8Ep71ILQ9ml4fiKRWUbc5zhxHzBCzX4MS4ATCDwJng5Oei5R9aEsEQc3Iopho
        5i
X-Google-Smtp-Source: APXvYqxdjideep1pLHhT+s6QudyoLVQqy88HcnyiSNOhEZPSKLvpydHMjSMohkv88xZHRASPXIe1x4LxxGU9lVTPCKGs
X-Received: by 2002:a65:5a08:: with SMTP id y8mr7151913pgs.4.1570664673042;
 Wed, 09 Oct 2019 16:44:33 -0700 (PDT)
Date:   Wed,  9 Oct 2019 16:44:18 -0700
In-Reply-To: <cover.1570663470.git.jonathantanmy@google.com>
Message-Id: <cf6c9f6e1799c587b4defa0e874b07aa9b72548b.1570663470.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 2/6] index-pack: remove redundant parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1a2600d4b3..99f6e2957f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -614,7 +614,7 @@ static int compare_ofs_delta_bases(off_t offset1, off_t offset2,
 	       0;
 }
 
-static int find_ofs_delta(const off_t offset, enum object_type type)
+static int find_ofs_delta(const off_t offset)
 {
 	int first = 0, last = nr_ofs_deltas;
 
@@ -624,7 +624,8 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 		int cmp;
 
 		cmp = compare_ofs_delta_bases(offset, delta->offset,
-					      type, objects[delta->obj_no].type);
+					      OBJ_OFS_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -637,10 +638,9 @@ static int find_ofs_delta(const off_t offset, enum object_type type)
 }
 
 static void find_ofs_delta_children(off_t offset,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ofs_delta(offset, type);
+	int first = find_ofs_delta(offset);
 	int last = first;
 	int end = nr_ofs_deltas - 1;
 
@@ -668,7 +668,7 @@ static int compare_ref_delta_bases(const struct object_id *oid1,
 	return oidcmp(oid1, oid2);
 }
 
-static int find_ref_delta(const struct object_id *oid, enum object_type type)
+static int find_ref_delta(const struct object_id *oid)
 {
 	int first = 0, last = nr_ref_deltas;
 
@@ -678,7 +678,8 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 		int cmp;
 
 		cmp = compare_ref_delta_bases(oid, &delta->oid,
-					      type, objects[delta->obj_no].type);
+					      OBJ_REF_DELTA,
+					      objects[delta->obj_no].type);
 		if (!cmp)
 			return next;
 		if (cmp < 0) {
@@ -691,10 +692,9 @@ static int find_ref_delta(const struct object_id *oid, enum object_type type)
 }
 
 static void find_ref_delta_children(const struct object_id *oid,
-				    int *first_index, int *last_index,
-				    enum object_type type)
+				    int *first_index, int *last_index)
 {
-	int first = find_ref_delta(oid, type);
+	int first = find_ref_delta(oid);
 	int last = first;
 	int end = nr_ref_deltas - 1;
 
@@ -982,12 +982,10 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 {
 	if (base->ref_last == -1 && base->ofs_last == -1) {
 		find_ref_delta_children(&base->obj->idx.oid,
-					&base->ref_first, &base->ref_last,
-					OBJ_REF_DELTA);
+					&base->ref_first, &base->ref_last);
 
 		find_ofs_delta_children(base->obj->idx.offset,
-					&base->ofs_first, &base->ofs_last,
-					OBJ_OFS_DELTA);
+					&base->ofs_first, &base->ofs_last);
 
 		if (base->ref_last == -1 && base->ofs_last == -1) {
 			free(base->data);
-- 
2.23.0.581.g78d2f28ef7-goog

