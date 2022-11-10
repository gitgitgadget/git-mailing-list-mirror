Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A4C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiKJQpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKJQpS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:45:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55148773
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:43:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so3112573wrb.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIZDCQABGSlYaTcnnGMCUft3/eGRj00TAVmFHOTmju4=;
        b=fvEAGclXI4k6CJpALsrgFOywEPHLJoxTSsqTMOXJrXbuF9l+yQEWEPs8cdGONv/DV7
         BiPoVybmO7TXklJMjlxEl1FdUfYWeFffuiaPE6BWZ9fJmkl4m8iETexQrl+HqdVid/m3
         3v4Ooog/fFDjfAnfu3/QqLvmHu+BVarD8rrIwLLvnGMND3vSerRInsnF+Ez7ObVoJLmK
         VNu9Vz1GnyOGBNbJyFp6f9sDBzazmBxpfrJFmVYDvAz/hQTagfiEuclWsJa5VnNR5fWn
         nvW3QU+EFaX0PKre3+KYC4024XTypyUs0/dS5L7ts9FZMV0oCcMyh/Ir+kZ40UsleBqf
         /F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIZDCQABGSlYaTcnnGMCUft3/eGRj00TAVmFHOTmju4=;
        b=cZwOcdKVGQc5KLWnRwnVSelp5hf0SOK72cVn2TUHa2fRhqnZ7s9yQmvbE3MZaZNRSf
         GkxyaFL7mDPL3l/OZXi6nxiLPoaoVu6u9n4ZL9EEpsMMObvenTF1MqpOlWSQdIy3N6+S
         /UeSN5ZdvHbeSalOJX1c/4Q9XU5O/BTwo2CpKV2vrA54iu37AkYzWs2FP+OjbGz+hE6j
         7jMl2bJVv+4Jz1sx8qth5I0Cb0LIC+lIJIo12J4mmLvigwsYmLCEnLYcUNZBNgvDw4D9
         aid0q6ZrOqkzbOoZG//7t6X633Q7XUp9QRwk8KT7OsvUDet/3wzFLuxnxhzJvPZ8aIHg
         iHTw==
X-Gm-Message-State: ACrzQf3ZyRQltKxwTF9yoBlHrcb/ApxmYXDdxYsNGStaddVTuhmD028Z
        fjv0/VavJ0jbjNik92Xe7ctKSQD9eCY=
X-Google-Smtp-Source: AMsMyM5KvHs3FS6Fl/iP1pITzcD4ay0Jbm7PyB9GSQdFTNm1dbcaLjzGHQnl/NdD1rCVad1pqEdkvg==
X-Received: by 2002:a05:6000:818:b0:236:8a38:5278 with SMTP id bt24-20020a056000081800b002368a385278mr41150211wrb.88.1668098626150;
        Thu, 10 Nov 2022 08:43:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4532000000b0024165454262sm947964wra.11.2022.11.10.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:43:45 -0800 (PST)
Message-Id: <d3a7ed20b9282348a9ebc2490ca70c9e89cf324b.1668098622.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
References: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 16:43:41 +0000
Subject: [PATCH 2/2] sequencer: tighten label lookups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The `label` command creates a ref refs/rewritten/<label> that the
`reset` and `merge` commands resolve by calling lookup_label(). That
uses lookup_commit_reference_by_name() to look up the label ref. As
lookup_commit_reference_by_name() uses the dwim rules when looking up
the label it will look for a branch named
refs/heads/refs/rewritten/<label> and return that instead of an error if
the branch exists and the label does not. Fix this by using read_ref()
followed by lookup_commit_object() when looking up labels.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c              | 14 ++++++++------
 t/t3430-rebase-merges.sh |  9 +++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 21f5032df0d..927da04e709 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3696,15 +3696,17 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
-static struct commit *lookup_label(const char *label, int len,
-				   struct strbuf *buf)
+static struct commit *lookup_label(struct repository *r, const char *label,
+				   int len, struct strbuf *buf)
 {
 	struct commit *commit;
+	struct object_id oid;
 
 	strbuf_reset(buf);
 	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
-	commit = lookup_commit_reference_by_name(buf->buf);
-	if (!commit) {
+	if (!read_ref(buf->buf, &oid)) {
+		commit = lookup_commit_object(r, &oid);
+	} else {
 		/* fall back to non-rewritten ref or commit */
 		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
 		commit = lookup_commit_reference_by_name(buf->buf);
@@ -3755,7 +3757,7 @@ static int do_reset(struct repository *r,
 				break;
 		len = i;
 
-		commit = lookup_label(name, len, &ref_name);
+		commit = lookup_label(r, name, len, &ref_name);
 		if (!commit) {
 			ret = -1;
 			goto cleanup;
@@ -3854,7 +3856,7 @@ static int do_merge(struct repository *r,
 		k = strcspn(p, " \t\n");
 		if (!k)
 			continue;
-		merge_commit = lookup_label(p, k, &ref_name);
+		merge_commit = lookup_label(r, p, k, &ref_name);
 		if (!merge_commit) {
 			ret = error(_("unable to parse '%.*s'"), k, p);
 			goto leave_merge;
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fbbc4439bfe..fa2a06c19f0 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -146,6 +146,15 @@ test_expect_success '`reset` rejects trees' '
 	test_must_be_empty out
 '
 
+test_expect_success '`reset` only looks for labels under refs/rewritten/' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git branch refs/rewritten/my-label A &&
+	test_must_fail env GIT_SEQUENCE_EDITOR="echo reset my-label >" \
+		git rebase -i B C >out 2>err &&
+	grep "could not resolve ${SQ}my-label${SQ}" err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b conflicting-merge A &&
-- 
gitgitgadget
