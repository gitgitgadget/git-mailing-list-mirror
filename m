Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C950C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D2B61A6C
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhKPFNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhKPFNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:13:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475CC0BC547
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 18:13:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i12so14712359wmq.4
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 18:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tn+Yup20qjD9E22IRE29YWxpahjLdja0sz4mTvoFh8o=;
        b=OjfJCMoQlNeQAbENTWxqy7qr8aaELQe0x39/SEMT0K+jN2NkViRII19W7nedfrUB+G
         t5CybP5Zo6gnr559OquVAIiuCioR7ef3csTSgfQuxSWwX6diWZBRSENSqta6cN3F/scW
         eBnhYey+OReUXii3mV0jcmu91DHlY1y0xhxHUBRLZJESm1V1iqihiZa2q+jRyA6q0BDA
         U9HQ94s1m7RxfRORHy2BaeLpFIQmbduGoVWCxPUVGSZeshAtz/8dZK+OHbUaLrKUb7tr
         7JItjmoc4CPUG40UAQ+aef5Mw5iw4fcZ62veP0Th7wIznXomCY4+vaxw149P1T/IcoIr
         WAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tn+Yup20qjD9E22IRE29YWxpahjLdja0sz4mTvoFh8o=;
        b=Go34NCyUDJ44iohWD/1Tn2w1lHIC+EHLzO0q9kV9joqV30jq6UztyAHf4ORZh7mq9D
         +KsNOOFOfVuz/lCTBbUMlCfZMnEeDb0WgCPlQ/jCDIB8ugs1wNPfjn/J4NhM8y3a+qbt
         LEEt/oo/yDByqdPocy9xfYQ2deoer1DsrDLVSBoj7MEiiHt+AjX6miedExFfnIiaAefD
         KDOFZEvoShbRXfACNOrXrZ63Msjq09ujtwjCnSxS7oOBrSbHf6mMcs8LAVxr0y3dIK3D
         aKVC4xkKSu4cQTh2OMfjU4Xokau3H3z+eN8R+iNp/2OU+KL5wl9+iJoEaEclQlaKT/YZ
         PODQ==
X-Gm-Message-State: AOAM530wSNMlmFuTgoF4fE/bgKPUH+FakwxpUXvr1CE7bJL6NsTbktnr
        U74uBSBbIAvNGSBTS5ayK0HmB54WAqo=
X-Google-Smtp-Source: ABdhPJz3/zQaIQRKIIff1KxTyRADLgkH8qQkzzCv6PZpX/svXV2DNzD7WANTtJXH+hnbjiQ3gGDllw==
X-Received: by 2002:a05:600c:1e27:: with SMTP id ay39mr54583374wmb.84.1637028787420;
        Mon, 15 Nov 2021 18:13:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm15483616wrh.16.2021.11.15.18.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 18:13:06 -0800 (PST)
Message-Id: <473fae82da160459189a6ef11b909ee074464184.1637028785.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
References: <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
        <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 02:13:04 +0000
Subject: [PATCH v4 1/2] xdiff: implement a zealous diff3, or "zdiff3"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

"zdiff3" is identical to ordinary diff3 except that it allows compaction
of common lines on the two sides of history at the beginning or end of
the conflict hunk.  For example, the following diff3 conflict:

    1
    2
    3
    4
    <<<<<<
    A
    B
    C
    D
    E
    ||||||
    5
    6
    ======
    A
    X
    C
    Y
    E
    >>>>>>
    7
    8
    9

has common lines 'A', 'C', and 'E' on the two sides.  With zdiff3, one
would instead get the following conflict:

    1
    2
    3
    4
    A
    <<<<<<
    B
    C
    D
    ||||||
    5
    6
    ======
    X
    C
    Y
    >>>>>>
    E
    7
    8
    9

Note that the common lines, 'A', and 'E' were moved outside the
conflict.  Unlike with the two-way conflicts from the 'merge'
conflictStyle, the zdiff3 conflict is NOT split into multiple conflict
regions to allow the common 'C' lines to be shown outside a conflict,
because zdiff3 shows the base version too and the base version cannot be
reasonably split.

Note also that the removing of lines common to the two sides might make
the remaining text inside the conflict region match the base text inside
the conflict region (for example, if the diff3 conflict had '5 6 E' on
the right side of the conflict, then the common line 'E' would be moved
outside and both the base and right side's remaining conflict text would
be the lines '5' and '6').  This has the potential to surprise users and
make them think there should not have been a conflict, but there
definitely was a conflict and it should remain.

Based-on-patch-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Co-authored-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +-
 t/t6427-diff3-conflict-markers.sh      | 90 ++++++++++++++++++++++++++
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 63 ++++++++++++++++--
 6 files changed, 155 insertions(+), 9 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 06a2f90c487..e695867ee54 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -34,6 +34,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
 		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
+		OPT_SET_INT(0, "zdiff3", &xmp.style, N_("use a zealous diff3 based merge"),
+				XDL_MERGE_ZEALOUS_DIFF3),
 		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our version"),
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &xmp.favor, N_("for conflicts, use their version"),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8108eda1e86..a7fb14e9a40 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1566,7 +1566,7 @@ _git_checkout ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--*)
 		__gitcomp_builtin checkout
@@ -2446,7 +2446,7 @@ _git_switch ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--*)
 		__gitcomp_builtin switch
@@ -2887,7 +2887,7 @@ _git_restore ()
 
 	case "$cur" in
 	--conflict=*)
-		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
 		;;
 	--source=*)
 		__git_complete_refs --cur="${cur##--source=}"
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index 25c4b720e72..a9ee4cb207a 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -211,4 +211,94 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
 	)
 '
 
+test_setup_zdiff3 () {
+	test_create_repo zdiff3 &&
+	(
+		cd zdiff3 &&
+
+		test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
+		test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 >evil &&
+
+		git add basic middle-common interesting evil &&
+		git commit -m base &&
+
+		git branch left &&
+		git branch right &&
+
+		git checkout left &&
+		test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
+		test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
+		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
+		test_write_lines 1 2 3 4 X A B C 7 8 9 >evil &&
+		git add -u &&
+		git commit -m letters &&
+
+		git checkout right &&
+		test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
+		test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
+		test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
+		test_write_lines 1 2 3 4 Y A B C B C 7 8 9 >evil &&
+		git add -u &&
+		git commit -m permuted
+	)
+}
+
+test_expect_success 'check zdiff3 markers' '
+	test_setup_zdiff3 &&
+	(
+		cd zdiff3 &&
+
+		git checkout left^0 &&
+
+		base=$(git rev-parse --short HEAD^1) &&
+		test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
+
+		test_write_lines 1 2 3 4 A \
+				 "<<<<<<< HEAD" B C D \
+				 "||||||| $base" 5 6 \
+				 ======= X C Y \
+				 ">>>>>>> right^0" \
+				 E 7 8 9 \
+				 >expect &&
+		test_cmp expect basic &&
+
+		test_write_lines 1 2 3 \
+				 "<<<<<<< HEAD" CC \
+				 "||||||| $base" AA \
+				 ======= EE \
+				 ">>>>>>> right^0" \
+				 4 5 \
+				 "<<<<<<< HEAD" DD \
+				 "||||||| $base" BB \
+				 ======= FF \
+				 ">>>>>>> right^0" \
+				 6 7 8 \
+				 >expect &&
+		test_cmp expect middle-common &&
+
+		test_write_lines 1 2 3 4 A B C \
+				 "<<<<<<< HEAD" D E F \
+				 "||||||| $base" 5 6 \
+				 ======= 5 6 \
+				 ">>>>>>> right^0" \
+				 G H I J 7 8 9 \
+				 >expect &&
+		test_cmp expect interesting &&
+
+		# Not passing this one yet; the common "B C" lines is still
+		# being left in the conflict blocks on the left and right
+		# sides.
+		test_write_lines 1 2 3 4 \
+				 "<<<<<<< HEAD" X A \
+				 "||||||| $base" 5 6 \
+				 ======= Y A B C \
+				 ">>>>>>> right^0" \
+				 B C 7 8 9 \
+				 >expect &&
+		test_cmp expect evil
+	)
+'
+
 test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 75b32aef51d..2e3a5a2943e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -313,6 +313,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 			die("'%s' is not a boolean", var);
 		if (!strcmp(value, "diff3"))
 			git_xmerge_style = XDL_MERGE_DIFF3;
+		else if (!strcmp(value, "zdiff3"))
+			git_xmerge_style = XDL_MERGE_ZEALOUS_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style = 0;
 		/*
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b29deca5de8..72e25a9ffa5 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -66,6 +66,7 @@ extern "C" {
 
 /* merge output styles */
 #define XDL_MERGE_DIFF3 1
+#define XDL_MERGE_ZEALOUS_DIFF3 2
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1659edb4539..fff0b594f9a 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -230,7 +230,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
 			      dest ? dest + size : NULL);
 
-	if (style == XDL_MERGE_DIFF3) {
+	if (style == XDL_MERGE_DIFF3 || style == XDL_MERGE_ZEALOUS_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
 			size += marker_size + 1 + needs_cr + marker3_size;
@@ -322,6 +322,40 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 	return size;
 }
 
+static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
+{
+	return xdl_recmatch(rec1->ptr, rec1->size,
+			    rec2->ptr, rec2->size, flags);
+}
+
+/*
+ * Remove any common lines from the beginning and end of the conflicted region.
+ */
+static void xdl_refine_zdiff3_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
+		xpparam_t const *xpp)
+{
+	xrecord_t **rec1 = xe1->xdf2.recs, **rec2 = xe2->xdf2.recs;
+	for (; m; m = m->next) {
+		/* let's handle just the conflicts */
+		if (m->mode)
+			continue;
+
+		while(m->chg1 && m->chg2 &&
+		      recmatch(rec1[m->i1], rec2[m->i2], xpp->flags)) {
+			m->chg1--;
+			m->chg2--;
+			m->i1++;
+			m->i2++;
+		}
+		while (m->chg1 && m->chg2 &&
+		       recmatch(rec1[m->i1 + m->chg1 - 1],
+				rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
+			m->chg1--;
+			m->chg2--;
+		}
+	}
+}
+
 /*
  * Sometimes, changes are not quite identical, but differ in only a few
  * lines. Try hard to show only these few lines as conflicting.
@@ -482,7 +516,22 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int style = xmp->style;
 	int favor = xmp->favor;
 
-	if (style == XDL_MERGE_DIFF3) {
+	/*
+	 * XDL_MERGE_DIFF3 does not attempt to refine conflicts by looking
+	 * at common areas of sides 1 & 2, because the base (side 0) does
+	 * not match and is being shown.  Similarly, simplification of
+	 * non-conflicts is also skipped due to the skipping of conflict
+	 * refinement.
+	 *
+	 * XDL_MERGE_ZEALOUS_DIFF3, on the other hand, will attempt to
+	 * refine conflicts looking for common areas of sides 1 & 2.
+	 * However, since the base is being shown and does not match,
+	 * it will only look for common areas at the beginning or end
+	 * of the conflict block.  Since XDL_MERGE_ZEALOUS_DIFF3's
+	 * conflict refinement is much more limited in this fashion, the
+	 * conflict simplification will be skipped.
+	 */
+	if (style == XDL_MERGE_DIFF3 || style == XDL_MERGE_ZEALOUS_DIFF3) {
 		/*
 		 * "diff3 -m" output does not make sense for anything
 		 * more aggressive than XDL_MERGE_EAGER.
@@ -603,10 +652,12 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	if (!changes)
 		changes = c;
 	/* refine conflicts */
-	if (XDL_MERGE_ZEALOUS <= level &&
-	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
-	     xdl_simplify_non_conflicts(xe1, changes,
-					XDL_MERGE_ZEALOUS < level) < 0)) {
+	if (style == XDL_MERGE_ZEALOUS_DIFF3) {
+		xdl_refine_zdiff3_conflicts(xe1, xe2, changes, xpp);
+	} else if (XDL_MERGE_ZEALOUS <= level &&
+		   (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
+		    xdl_simplify_non_conflicts(xe1, changes,
+					       XDL_MERGE_ZEALOUS < level) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
-- 
gitgitgadget

