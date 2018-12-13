Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4778520A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeLMTyO (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:54:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38580 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMTyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:54:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so1617831pfi.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UBwY1QhEaJEp1jHceX2no8Wo0gb2M8Z4XjNeAWFHFVM=;
        b=jL0aLsyQbmziZ7wC741p0Fgd7jpGuBmQYHI+XaKLdxx/4z37Pm97R7RbCi+Y0dg3nP
         vWH+skoiezKWKo5oE8HGqRz8hXCgSSf1J83Ycl18TzKITMn5OPmNrIT+B0i4b2kBGSO+
         KSnYzhetcBsxjiIIst617MN0oe3/0LPAxP8Fxo340+7mQuIVdcQRdo6P6tDIztJGLqX3
         /OMEJaqQHjGhJpjU7W4oovmh0fQ31NYJtTe1fMfLk/6QMC6QRV2gT2RncCVkOI88Chad
         qssFqN1RVNVyj2rDUps65bAbw8m8J/AyJzUYNTWLLsuZwbcLwNVKzQjrs8Zo/liRgGmp
         vZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UBwY1QhEaJEp1jHceX2no8Wo0gb2M8Z4XjNeAWFHFVM=;
        b=XBV3v/ohhcrOTD8GKeMy6PdXWtq2ATwYGs3nP0rHWo4g5lNVkXesSE6LGuoRg2a0Nu
         PKnUgy/Chc6ImJiwNe2ngjLJxX3ksQuTa5Fgb9fgcMKvytVLwe/mgIZjIboGBFBMQSDR
         N/WJV1gZVzo9zlOHOi46YPqHwHeyltzwfz+clmpn5qKsJLCEVfnK3Ekb5CK5NVC7yqhe
         De4/cgr6Nwcy1I8E9Y5KAh72+BKbv8BZW9/xZ3EGMii1re9YyWU0Mbd1ymaJxT62jiip
         SGAeq36v9oaqcCa32zZbotNfkq8yrrHxds9X54fdsc+1z+MzU76zonvAX8B3zUNKz+lm
         zzLw==
X-Gm-Message-State: AA+aEWas8I2VL4p9lhxXZGcGtxeksLNU5S5bbjzEESJBX/mlNNRQfb0f
        3/pgoD1tbd34BKxFUtBr60fO4asY
X-Google-Smtp-Source: AFSGD/UmRpSSxp/ExacH80K4d+ijj/Jzqv62XIO4s5c2Vqz4LQLqxGCJuII9BDW76iOmXes5fbHp4A==
X-Received: by 2002:a63:c10f:: with SMTP id w15mr108673pgf.199.1544730852284;
        Thu, 13 Dec 2018 11:54:12 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r66sm3724140pfk.157.2018.12.13.11.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:54:11 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:54:11 -0800 (PST)
X-Google-Original-Date: Thu, 13 Dec 2018 19:54:07 GMT
Message-Id: <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.100.git.gitgitgadget@gmail.com>
References: <pull.100.git.gitgitgadget@gmail.com>
From:   "Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Rappazzo <rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Rappazzo <rappazzo@gmail.com>

On a worktree which is not the primary, using the symbolic-ref 'head' was
incorrectly pointing to the main worktree's HEAD.  The same was true for
any other case of the word 'Head'.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 refs.c                   | 8 ++++----
 t/t1415-worktree-refs.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index f9936355cd..963e786458 100644
--- a/refs.c
+++ b/refs.c
@@ -579,7 +579,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
+		} else if ((flag & REF_ISSYMREF) && strcasecmp(fullref.buf, "HEAD")) {
 			warning(_("ignoring dangling symref %s"), fullref.buf);
 		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
 			warning(_("ignoring broken ref %s"), fullref.buf);
@@ -627,7 +627,7 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
+	return !strcasecmp(refname, "HEAD") ||
 		starts_with(refname, "refs/worktree/") ||
 		starts_with(refname, "refs/bisect/") ||
 		starts_with(refname, "refs/rewritten/");
@@ -847,7 +847,7 @@ int should_autocreate_reflog(const char *refname)
 		return starts_with(refname, "refs/heads/") ||
 			starts_with(refname, "refs/remotes/") ||
 			starts_with(refname, "refs/notes/") ||
-			!strcmp(refname, "HEAD");
+			!strcasecmp(refname, "HEAD");
 	default:
 		return 0;
 	}
@@ -855,7 +855,7 @@ int should_autocreate_reflog(const char *refname)
 
 int is_branch(const char *refname)
 {
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+	return !strcasecmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
 struct read_ref_at_cb {
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index b664e51250..e7f8a129fd 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -76,4 +76,13 @@ test_expect_success 'reflog of worktrees/xx/HEAD' '
 	test_cmp expected actual.wt2
 '
 
+test_expect_success 'head, Head, and HEAD are the same in worktree' '
+	test_cmp_rev worktree/foo initial &&
+	git -C wt1 rev-parse HEAD >uc_ref.wt1 &&
+	git -C wt1 rev-parse Head >mc_ref.wt1 &&
+	git -C wt1 rev-parse head >lc_ref.wt1 &&
+	test_cmp uc_ref.wt1 lc_ref.wt1 &&
+	test_cmp uc_ref.wt1 mc_ref.wt1
+'
+
 test_done
-- 
gitgitgadget
