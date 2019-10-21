Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BB51F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 16:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfJUQBI (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 12:01:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41048 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfJUQBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 12:01:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so14623603wrm.8
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sa3f5BckwxaktFgPnRapmZd6eaJatuycR9TIbrlM4C4=;
        b=lQRZsesFFKWtVTVmYgL84MFsD0QHhxyLQ3syYDnVhH0E1zS/cA0k43QpdX80hWW6ou
         yszSXZdGYRLm9NJOI+aIUgJ7f7KCMYwgOoSv5S9ptkJ48INEpsJaOzR7cR/CpoiPS+A0
         C7cbCQjqXBR+W1dh0qYQuA0BjhRhWTUQqWjob/78Qe93s8y6epyE/zyho7A2sBH9E7vR
         p+IJLfWLsxiwyxC1Witl2aHdVjBOhKNxmlRoM55/OjRxPSInG/deV78FoodRHA+2n0m0
         VCIRQKyylggUeF9j4q7EmeDGMxpqZVeOR+69PIN4uZ3xKor44pcugcb+3OWZBSSJjaqR
         DDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sa3f5BckwxaktFgPnRapmZd6eaJatuycR9TIbrlM4C4=;
        b=XhmTZ9AJZgIr6MagkPOQQEbDmcqwzMDt9/FUdS+mf8tAkHmAgA8oBNA5cGwa7ULK2F
         iFYUOE2fGi0k5MuSTMR4HcAykOQm1L04dw8f1rX+sa54N9kGl9antfuI9rfu5+7Bdrfi
         /hCmL5NDWL3Gz/gpBy/tK6WkiY6AUZtpVGhYfMmVyE8ONNPkZUimBHjNmsy0N0NqsDFF
         DYgrglJpLitFSH/Ckc6OhO7/fnwkouFDDHkXyLwwvB38aoWc+lK8a0jJzoSrbyxY4JU2
         6Ua0O9Aih0xAkUCCKizQE5Kljb38gTvsg86+iH9UyprM6TpPn8Uou9aHI0wtJoY3CjLr
         yt9Q==
X-Gm-Message-State: APjAAAUUvBTOeJ/xkmW1i+N/hBFAcEEwwYPZEmeOA7d/f/IG/plhfbN/
        SmJSHJCnMNxF999M6+dPB5U9bnBh
X-Google-Smtp-Source: APXvYqyu6xrLq8em45nkOer4yLEEv0+nkiMaVrqYmiHqBJQCE/dXh3oby9WVUB8W1KgTjCQNsb5sMQ==
X-Received: by 2002:adf:a109:: with SMTP id o9mr19415045wro.96.1571673663380;
        Mon, 21 Oct 2019 09:01:03 -0700 (PDT)
Received: from localhost.localdomain (x4db66cac.dyn.telefonica.de. [77.182.108.172])
        by smtp.gmail.com with ESMTPSA id u26sm16293196wrd.87.2019.10.21.09.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 09:01:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] path.c: clarify two field names in 'struct common_dir'
Date:   Mon, 21 Oct 2019 18:00:42 +0200
Message-Id: <20191021160043.701-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.472.ga6f06c86b4
In-Reply-To: <20191021160043.701-1-szeder.dev@gmail.com>
References: <20191021160043.701-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An array of 'struct common_dir' instances is used to specify whether
various paths in $GIT_DIR are specific to a worktree, or are common,
i.e. belong to main worktree.  The names of two fields in this
struct are somewhat confusing or ambigious:

  - The path is recorded in the struct's 'dirname' field, even though
    several entries are regular files e.g. 'gc.pid', 'packed-refs',
    etc.

    Rename this field to 'path' to reduce confusion.

  - The field 'exclude' tells whether the path is excluded...  from
    where?  Excluded from the common dir or from the worktree?  It
    means the former, but it's ambigious.

    Rename this field to 'is_common' to make it unambigious what it
    means.  This, however, means the exact opposite of what 'exclude'
    meant, so we have to negate the field's value in all entries as
    well.

The diff is best viewed with '--color-words'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 path.c | 66 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/path.c b/path.c
index 3fac5f5726..cf57bd52dd 100644
--- a/path.c
+++ b/path.c
@@ -101,36 +101,36 @@ struct common_dir {
 	/* Not considered garbage for report_linked_checkout_garbage */
 	unsigned ignore_garbage:1;
 	unsigned is_dir:1;
-	/* Not common even though its parent is */
-	unsigned exclude:1;
-	const char *dirname;
+	/* Belongs to the common dir, though it may contain paths that don't */
+	unsigned is_common:1;
+	const char *path;
 };
 
 static struct common_dir common_list[] = {
-	{ 0, 1, 0, "branches" },
-	{ 0, 1, 0, "common" },
-	{ 0, 1, 0, "hooks" },
-	{ 0, 1, 0, "info" },
-	{ 0, 0, 1, "info/sparse-checkout" },
-	{ 1, 1, 0, "logs" },
-	{ 1, 0, 1, "logs/HEAD" },
-	{ 0, 1, 1, "logs/refs/bisect" },
-	{ 0, 1, 1, "logs/refs/rewritten" },
-	{ 0, 1, 1, "logs/refs/worktree" },
-	{ 0, 1, 0, "lost-found" },
-	{ 0, 1, 0, "objects" },
-	{ 0, 1, 0, "refs" },
-	{ 0, 1, 1, "refs/bisect" },
-	{ 0, 1, 1, "refs/rewritten" },
-	{ 0, 1, 1, "refs/worktree" },
-	{ 0, 1, 0, "remotes" },
-	{ 0, 1, 0, "worktrees" },
-	{ 0, 1, 0, "rr-cache" },
-	{ 0, 1, 0, "svn" },
-	{ 0, 0, 0, "config" },
-	{ 1, 0, 0, "gc.pid" },
-	{ 0, 0, 0, "packed-refs" },
-	{ 0, 0, 0, "shallow" },
+	{ 0, 1, 1, "branches" },
+	{ 0, 1, 1, "common" },
+	{ 0, 1, 1, "hooks" },
+	{ 0, 1, 1, "info" },
+	{ 0, 0, 0, "info/sparse-checkout" },
+	{ 1, 1, 1, "logs" },
+	{ 1, 0, 0, "logs/HEAD" },
+	{ 0, 1, 0, "logs/refs/bisect" },
+	{ 0, 1, 0, "logs/refs/rewritten" },
+	{ 0, 1, 0, "logs/refs/worktree" },
+	{ 0, 1, 1, "lost-found" },
+	{ 0, 1, 1, "objects" },
+	{ 0, 1, 1, "refs" },
+	{ 0, 1, 0, "refs/bisect" },
+	{ 0, 1, 0, "refs/rewritten" },
+	{ 0, 1, 0, "refs/worktree" },
+	{ 0, 1, 1, "remotes" },
+	{ 0, 1, 1, "worktrees" },
+	{ 0, 1, 1, "rr-cache" },
+	{ 0, 1, 1, "svn" },
+	{ 0, 0, 1, "config" },
+	{ 1, 0, 1, "gc.pid" },
+	{ 0, 0, 1, "packed-refs" },
+	{ 0, 0, 1, "shallow" },
 	{ 0, 0, 0, NULL }
 };
 
@@ -331,8 +331,8 @@ static void init_common_trie(void)
 	if (common_trie_done_setup)
 		return;
 
-	for (p = common_list; p->dirname; p++)
-		add_to_trie(&common_trie, p->dirname, p);
+	for (p = common_list; p->path; p++)
+		add_to_trie(&common_trie, p->path, p);
 
 	common_trie_done_setup = 1;
 }
@@ -349,10 +349,10 @@ static int check_common(const char *unmatched, void *value, void *baton)
 		return 0;
 
 	if (dir->is_dir && (unmatched[0] == 0 || unmatched[0] == '/'))
-		return !dir->exclude;
+		return dir->is_common;
 
 	if (!dir->is_dir && unmatched[0] == 0)
-		return !dir->exclude;
+		return dir->is_common;
 
 	return 0;
 }
@@ -376,8 +376,8 @@ void report_linked_checkout_garbage(void)
 		return;
 	strbuf_addf(&sb, "%s/", get_git_dir());
 	len = sb.len;
-	for (p = common_list; p->dirname; p++) {
-		const char *path = p->dirname;
+	for (p = common_list; p->path; p++) {
+		const char *path = p->path;
 		if (p->ignore_garbage)
 			continue;
 		strbuf_setlen(&sb, len);
-- 
2.24.0.rc0.472.ga6f06c86b4

