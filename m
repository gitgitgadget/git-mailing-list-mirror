Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F669C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiKJQpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiKJQpN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:45:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0AF20F6F
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:43:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso3865060wma.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acpYSDUIewdtFFcgd8UGUK9FpudTYxMisxgvK0Dy9rw=;
        b=EskH2Ji8rV4apz7RnZcDnK9DP5skNC+m2Ju801whVq/DZ6m9/Zlc8bX35Ks8/icKVl
         eykXez40Y0xJ4CFsmMEYjKMmhQ7Vw/LykB69/pUYATBB8YFYeRMgmLDyJe9YhF5bxjb3
         +QrdVWW3R9tAIt4W/IAS1uUpTYoAY0rh/W2N537jeMkU5HWNJQoHKnsQp45svjzpomag
         zJdQs2dGH6/bHAcuH/I5mHkrt+YYjZ6TtGu9ZU91BO8zRGvcG6sc044BI9eww8lvOavz
         1Kr3uiri2+bk74D4blnCfFUQLj1wr2t4FefQ9O3KOCuK6V0eIOLvq3YRTooTYVfJ6bqo
         I0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acpYSDUIewdtFFcgd8UGUK9FpudTYxMisxgvK0Dy9rw=;
        b=ZhOkkAIAlcMZV57fsMH0qZYyq9javzFXbRGFQeR+knNM4Rul0NgfYCEdlek2RuLe+6
         5Gu1AHb9RFX1cVEu6hNT9O3eguwHArplIH/pIIOMM2Aux6nkR98WE/f3V63lsr01hNh1
         k69SaeE5/3HSn3cwdYiwDWVHepUI+Hrn6xPunmRxxz/T8YpvtZkr7AcVCORUQ5+QKjvM
         3zY8AidjU0PPd3JrkIPXKNqeJt2xK2F1zid9jCTMwxUP3euyobYUdYjtrbNU3XQ490oC
         0gmyEBmnlbrLEWmBZB1ZuBw5spicwRaRbno9xgsvu1wqOrpiywBDvuQRQ3hwhcDJvtmN
         cp5w==
X-Gm-Message-State: ACrzQf0zP0/Gmeo333dbnzzoEOT0z/X7h/5BXS/s3DFAqZDCQBa9hCfR
        MLix+bRyFCydQ833eEKQcbdU4as6xU4=
X-Google-Smtp-Source: AMsMyM6Y5QAf7pGrHj25WWRaDIM6ZacJ5RE/pPYEa9FuEtmG443t2OxpAfUdvmy06OLjkfPUti+08A==
X-Received: by 2002:a05:600c:29a:b0:3cf:8e62:66f1 with SMTP id 26-20020a05600c029a00b003cf8e6266f1mr26516014wmk.39.1668098625147;
        Thu, 10 Nov 2022 08:43:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v23-20020a1cf717000000b003c6c4639ac6sm34093wmh.34.2022.11.10.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:43:44 -0800 (PST)
Message-Id: <ecb81b873a8d72c57fd4812ec86d103927437cf1.1668098622.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
References: <pull.1414.git.1668098622.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 16:43:40 +0000
Subject: [PATCH 1/2] sequencer: unify label lookup
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

The arguments to the `reset` and `merge` commands may be a label created
with a `label` command or an arbitrary commit name. The `merge` command
uses the lookup_label() function to lookup its arguments but `reset` has
a slightly different version of that function in do_reset(). Reduce this
code duplication by calling lookup_label() from do_reset() as well.

This change improves the behavior of `reset` when the argument is a
tree.  Previously `reset` would accept a tree only for the rebase to
fail with

       update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object da5497437fd67ca928333aab79c4b4b55036ea66 to branch 'HEAD'

Using lookup_label() means do_reset() will now error out straight away
if its argument is not a commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c              | 49 ++++++++++++++++++++--------------------
 t/t3430-rebase-merges.sh |  8 +++++++
 2 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e658df7e8ff..21f5032df0d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3696,6 +3696,26 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static struct commit *lookup_label(const char *label, int len,
+				   struct strbuf *buf)
+{
+	struct commit *commit;
+
+	strbuf_reset(buf);
+	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
+	commit = lookup_commit_reference_by_name(buf->buf);
+	if (!commit) {
+		/* fall back to non-rewritten ref or commit */
+		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
+		commit = lookup_commit_reference_by_name(buf->buf);
+	}
+
+	if (!commit)
+		error(_("could not resolve '%s'"), buf->buf);
+
+	return commit;
+}
+
 static int do_reset(struct repository *r,
 		    const char *name, int len,
 		    struct replay_opts *opts)
@@ -3727,6 +3747,7 @@ static int do_reset(struct repository *r,
 		oidcpy(&oid, &opts->squash_onto);
 	} else {
 		int i;
+		struct commit *commit;
 
 		/* Determine the length of the label */
 		for (i = 0; i < len; i++)
@@ -3734,12 +3755,12 @@ static int do_reset(struct repository *r,
 				break;
 		len = i;
 
-		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
-		if (get_oid(ref_name.buf, &oid) &&
-		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
-			ret = error(_("could not read '%s'"), ref_name.buf);
+		commit = lookup_label(name, len, &ref_name);
+		if (!commit) {
+			ret = -1;
 			goto cleanup;
 		}
+		oid = commit->object.oid;
 	}
 
 	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
@@ -3786,26 +3807,6 @@ cleanup:
 	return ret;
 }
 
-static struct commit *lookup_label(const char *label, int len,
-				   struct strbuf *buf)
-{
-	struct commit *commit;
-
-	strbuf_reset(buf);
-	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
-	commit = lookup_commit_reference_by_name(buf->buf);
-	if (!commit) {
-		/* fall back to non-rewritten ref or commit */
-		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
-		commit = lookup_commit_reference_by_name(buf->buf);
-	}
-
-	if (!commit)
-		error(_("could not resolve '%s'"), buf->buf);
-
-	return commit;
-}
-
 static int do_merge(struct repository *r,
 		    struct commit *commit,
 		    const char *arg, int arg_len,
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index f351701fec2..fbbc4439bfe 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -138,6 +138,14 @@ test_expect_success '`reset` refuses to overwrite untracked files' '
 	git rebase --abort
 '
 
+test_expect_success '`reset` rejects trees' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	test_must_fail env GIT_SEQUENCE_EDITOR="echo reset A^{tree} >" \
+		git rebase -i B C >out 2>err &&
+	grep "object .* is a tree" err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b conflicting-merge A &&
-- 
gitgitgadget

