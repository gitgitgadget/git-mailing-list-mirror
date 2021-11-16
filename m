Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E39C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B4E61BF9
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 05:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKPFNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 00:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKPFNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 00:13:44 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC8C0BC545
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 18:13:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso1214078wmf.0
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 18:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=r9DQZ5BxVMAkSjzmGrmhN7452+2vpExPmzD3c2a3wzw=;
        b=L6rT5wbemZoCiGR5ONXi2wYJiZeK72W1goEWux11t84ICcjZFaY4Fbjdr2zhZ63+YB
         WhOVsGqYkxRFUyMVUHn7qdnIv5UajK2x+dSdj7pOHSsctEhq8PFhIR/bniRLlxN0USPj
         8UY5uv9xmTdIc9fLLTIeGNH32DtC764pL41b9NK04r55LNzj/S0KxnPpNiv5MTsMCtkX
         Uvs4AXwhpaIb+HxZ5q29ilPwuKmxvDsVqbn5mF+DAvnPdKGzcD3+5/66wAE57oj7dOGo
         F4AmX02h51x0caYVOI5L6R/6Hs71C+MQNWFG0Kpid6DjurK0PCxl72LUCKZ9HcDa1T0f
         2Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=r9DQZ5BxVMAkSjzmGrmhN7452+2vpExPmzD3c2a3wzw=;
        b=D6SN63v79krqpQOiSthLWUBwNh46PFvwDu2mLhNBinU4lSYf6VViKBaEgISTAPRvdf
         iJ6e82p54pT0w+e5QApiMU2ccf1XFJbVOySuSzew29mLIEwlg+0AWoJGQENod9V2Qjy2
         EhgSDfrsJkJrp0LzM/6f1dTUBiITbuhAOFFGHcw3vyakoly7d0I1noN9qZwMAPGsFPe/
         DrAXWobK4418S4ypXXWoFQqFRNYP2f2+e4u3bJQ8zqgUl0SX8G+if/H0tGBGPKYCTLE8
         1MRf4B0iCllaY5t8qU5x2t0lwCdLQhhU+/KVt4Cb5FndfzxnAdJ06CdgwfSy3A5Ga9Ki
         RKfQ==
X-Gm-Message-State: AOAM532jTLZXX51zn9uXB8qvqbz/M9XWjeJl5TQFTvlrQza+lSpN+TMA
        lpObQ+aKjiMRi7P9x2OSLa35MpUCDyI=
X-Google-Smtp-Source: ABdhPJz5LqEnZMQKGL5PztLCxGmu+dBorKKODM0wEA+vl1ELRq+va6VCHL/Ijb2gCKdZf3kDtZbzyQ==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr66265913wml.146.1637028786638;
        Mon, 15 Nov 2021 18:13:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm15661328wrt.58.2021.11.15.18.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 18:13:06 -0800 (PST)
Message-Id: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
References: <pull.1036.v3.git.git.1632006164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 02:13:03 +0000
Subject: [PATCH v4 0/2] Implement new zdiff3 conflict style
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement a zealous diff3, or "zdiff3". This new mode is identical to
ordinary diff3 except that it allows compaction of common lines between the
two sides of history, if those common lines occur at the beginning or end of
a conflict hunk.

Changes since v3:

 * More fixes from Phillip.
 * Marked Phillip as the author of the first commit because he's written
   most the code now; gave myself a co-authored-by trailer on that commit.
 * Removed the RFC label since it's now passing our tests.

Changes since v2:

 * Included more fixes from Phillip, and a new testcase

Changes since v1:

 * Included fixes from Phillip (thanks!)
 * Added some testcases

Elijah Newren (1):
  update documentation for new zdiff3 conflictStyle

Phillip Wood (1):
  xdiff: implement a zealous diff3, or "zdiff3"

 Documentation/config/merge.txt         |  9 ++-
 Documentation/git-checkout.txt         |  3 +-
 Documentation/git-merge-file.txt       |  3 +
 Documentation/git-merge.txt            | 32 +++++++--
 Documentation/git-rebase.txt           |  6 +-
 Documentation/git-restore.txt          |  3 +-
 Documentation/git-switch.txt           |  3 +-
 Documentation/technical/rerere.txt     | 10 +--
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +-
 t/t6427-diff3-conflict-markers.sh      | 90 ++++++++++++++++++++++++++
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 63 ++++++++++++++++--
 15 files changed, 205 insertions(+), 30 deletions(-)


base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1036%2Fnewren%2Fzdiff3-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1036/newren/zdiff3-v4
Pull-Request: https://github.com/git/git/pull/1036

Range-diff vs v3:

 1:  798aefbb40a ! 1:  473fae82da1 xdiff: implement a zealous diff3, or "zdiff3"
     @@
       ## Metadata ##
     -Author: Elijah Newren <newren@gmail.com>
     +Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
          xdiff: implement a zealous diff3, or "zdiff3"
     @@ Commit message
          definitely was a conflict and it should remain.
      
          Based-on-patch-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     -    Co-authored-by: Phillip Wood <phillip.wood123@gmail.com>
     +    Co-authored-by: Elijah Newren <newren@gmail.com>
     +    Signed-off-by: Phillip Wood <phillip.wood123@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/merge-file.c ##
     @@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'rebase --apply describes
      +	)
      +}
      +
     -+test_expect_failure 'check zdiff3 markers' '
     ++test_expect_success 'check zdiff3 markers' '
      +	test_setup_zdiff3 &&
      +	(
      +		cd zdiff3 &&
     @@ xdiff/xmerge.c: static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
       		if (!dest) {
       			size += marker_size + 1 + needs_cr + marker3_size;
      @@ xdiff/xmerge.c: static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
     -  * lines. Try hard to show only these few lines as conflicting.
     -  */
     - static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
     --		xpparam_t const *xpp)
     -+				xpparam_t const *xpp, int style)
     - {
     - 	for (; m; m = m->next) {
     - 		mmfile_t t1, t2;
     -@@ xdiff/xmerge.c: static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
     - 			continue;
     - 		}
     - 		x = xscr;
     -+		if (style == XDL_MERGE_ZEALOUS_DIFF3) {
     -+			int advance1 = xscr->i1, advance2 = xscr->i2;
     -+
     -+			/*
     -+			 * Advance m->i1 and m->i2 so that conflict for sides
     -+			 * 1 and 2 start after common region.  Decrement
     -+			 * m->chg[12] since there are now fewer conflict lines
     -+			 * for those sides.
     -+			 */
     -+			m->i1 += advance1;
     -+			m->i2 += advance2;
     -+			m->chg1 -= advance1;
     -+			m->chg2 -= advance2;
     -+
     -+			/*
     -+			 * Splitting conflicts due to internal common regions
     -+			 * on the two sides would be inappropriate since we
     -+			 * are also showing the merge base and have no
     -+			 * reasonable way to split the merge base text.
     -+			 */
     -+			while (xscr->next)
     -+				xscr = xscr->next;
     + 	return size;
     + }
     + 
     ++static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
     ++{
     ++	return xdl_recmatch(rec1->ptr, rec1->size,
     ++			    rec2->ptr, rec2->size, flags);
     ++}
      +
     -+			/*
     -+			 * Lower the number of conflict lines to not include
     -+			 * the final common lines, if any.  Do this by setting
     -+			 * number of conflict lines to
     -+			 *   (line offset for start of conflict in xscr) +
     -+			 *   (number of lines in the conflict in xscr)
     -+			 */
     -+			m->chg1 = (xscr->i1 - advance1) + (xscr->chg1);
     -+			m->chg2 = (xscr->i2 - advance2) + (xscr->chg2);
     -+			xdl_free_env(&xe);
     -+			xdl_free_script(x);
     ++/*
     ++ * Remove any common lines from the beginning and end of the conflicted region.
     ++ */
     ++static void xdl_refine_zdiff3_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
     ++		xpparam_t const *xpp)
     ++{
     ++	xrecord_t **rec1 = xe1->xdf2.recs, **rec2 = xe2->xdf2.recs;
     ++	for (; m; m = m->next) {
     ++		/* let's handle just the conflicts */
     ++		if (m->mode)
      +			continue;
     ++
     ++		while(m->chg1 && m->chg2 &&
     ++		      recmatch(rec1[m->i1], rec2[m->i2], xpp->flags)) {
     ++			m->chg1--;
     ++			m->chg2--;
     ++			m->i1++;
     ++			m->i2++;
      +		}
     - 		m->i1 = xscr->i1 + i1;
     - 		m->chg1 = xscr->chg1;
     - 		m->i2 = xscr->i2 + i2;
     -@@ xdiff/xmerge.c: static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
     - static void xdl_merge_two_conflicts(xdmerge_t *m)
     - {
     - 	xdmerge_t *next_m = m->next;
     -+	m->chg0 = next_m->i0 + next_m->chg0 - m->i0;
     - 	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
     - 	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
     - 	m->next = next_m->next;
     -@@ xdiff/xmerge.c: static void xdl_merge_two_conflicts(xdmerge_t *m)
     -  * it appears simpler -- because it takes up less (or as many) lines --
     -  * if the lines are moved into the conflicts.
     -  */
     --static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
     -+static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m, int style,
     - 				      int simplify_if_no_alnum)
     - {
     - 	int result = 0;
     - 
     --	if (!m)
     -+	if (!m || style == XDL_MERGE_ZEALOUS_DIFF3)
     - 		return result;
     - 	for (;;) {
     - 		xdmerge_t *next_m = m->next;
     ++		while (m->chg1 && m->chg2 &&
     ++		       recmatch(rec1[m->i1 + m->chg1 - 1],
     ++				rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
     ++			m->chg1--;
     ++			m->chg2--;
     ++		}
     ++	}
     ++}
     ++
     + /*
     +  * Sometimes, changes are not quite identical, but differ in only a few
     +  * lines. Try hard to show only these few lines as conflicting.
      @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
       	int style = xmp->style;
       	int favor = xmp->favor;
       
     +-	if (style == XDL_MERGE_DIFF3) {
      +	/*
      +	 * XDL_MERGE_DIFF3 does not attempt to refine conflicts by looking
      +	 * at common areas of sides 1 & 2, because the base (side 0) does
     @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
      +	 * of the conflict block.  Since XDL_MERGE_ZEALOUS_DIFF3's
      +	 * conflict refinement is much more limited in this fashion, the
      +	 * conflict simplification will be skipped.
     -+	 *
     -+	 * See xdl_refine_conflicts() and xdl_simplify_non_conflicts()
     -+	 * for more details, particularly looking for
     -+	 * XDL_MERGE_ZEALOUS_DIFF3.
      +	 */
     - 	if (style == XDL_MERGE_DIFF3) {
     ++	if (style == XDL_MERGE_DIFF3 || style == XDL_MERGE_ZEALOUS_DIFF3) {
       		/*
       		 * "diff3 -m" output does not make sense for anything
     + 		 * more aggressive than XDL_MERGE_EAGER.
      @@ xdiff/xmerge.c: static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
     + 	if (!changes)
       		changes = c;
       	/* refine conflicts */
     - 	if (XDL_MERGE_ZEALOUS <= level &&
     +-	if (XDL_MERGE_ZEALOUS <= level &&
      -	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
      -	     xdl_simplify_non_conflicts(xe1, changes,
     -+	    (xdl_refine_conflicts(xe1, xe2, changes, xpp, style) < 0 ||
     -+	     xdl_simplify_non_conflicts(xe1, changes, style,
     - 					XDL_MERGE_ZEALOUS < level) < 0)) {
     +-					XDL_MERGE_ZEALOUS < level) < 0)) {
     ++	if (style == XDL_MERGE_ZEALOUS_DIFF3) {
     ++		xdl_refine_zdiff3_conflicts(xe1, xe2, changes, xpp);
     ++	} else if (XDL_MERGE_ZEALOUS <= level &&
     ++		   (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
     ++		    xdl_simplify_non_conflicts(xe1, changes,
     ++					       XDL_MERGE_ZEALOUS < level) < 0)) {
       		xdl_cleanup_merge(changes);
       		return -1;
     + 	}
 2:  90aee68e14a = 2:  69f20a702b4 update documentation for new zdiff3 conflictStyle

-- 
gitgitgadget
