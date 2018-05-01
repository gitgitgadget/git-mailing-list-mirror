Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B38E215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbeEAMHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:38 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35239 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755066AbeEAMHg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:36 -0400
Received: by mail-wr0-f180.google.com with SMTP id i14-v6so7478118wre.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Djydfvk5FDCOvGeRdNDrgDjTnSAkKVuGv7UN6PYrFI8=;
        b=FCKTbO5mAOwCAoZyGh3DSoMRxgTjXpcD46ifkVUghBLJizQvegZ2egWigEQa9MFciE
         DT1SO7ugg95hN4iuSdhNkEUZQDALQsvi72kkDv2g7uuF5a8WJPG9DYNORdLebJZOG8+9
         IuzYL7aRjhppIK3oDyRQMc6DNwG7XZbYeJ2snO93cxgbfsmrXIz7xOX3uHTyOzMIKF63
         5oy/3jqcgXttkJLPiW1orrWw1JhvAvFA1QPwy8RUhxOXTg2peofnyMhukdkiJ4McDlPR
         BrNqhLc/jJzGGBKywJhklPUNJnAD0bMcw2kCA+NQ+58k+PSqXJVyyN7iidGj/jBej0m6
         0mPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Djydfvk5FDCOvGeRdNDrgDjTnSAkKVuGv7UN6PYrFI8=;
        b=twV0G9419wHZuy7AMiazucFw7mHykNtXm1AmjuVZu6yATOFY5fd5UTh8rjI3v+8NQF
         o/5PTSzxOpz6u9mfpISIN23WSsg1BM33fuOz2f+PASErw6mGKIW3+TvUPw4VniuESdpS
         Q/esK6jyTSuyw6nppKYlVFk73Fd5/8h21qsAE6btxnesPqEN+JQp/WvMmKIIgbDAu5Ww
         tKEYdDJecKgwxFnt37hpwh4UvxuA1cov1aiY3Zlg2J2L578yu0bm9ADRpGfYwbKYox9q
         KoX2eu2Y7YwK9VuQ+vbXQgZliZQIuul8uQqALEc66KqqrXwNFGXeyBc2pHUWGCqIv/xj
         ErWA==
X-Gm-Message-State: ALQs6tAY+LzoOjHOMr9Vk4Yxz/TgUyfUMN3afDb3MMLYnOcwSgR9kcKk
        QzdieNY7zDCkKCEHAZKx4hNEdNDb
X-Google-Smtp-Source: AB8JxZpKE8TjK/UI9LBq929JmgO0obLHAx1xxGEJyFvG9qjSQ9C6CDVvreTkKVLazDmQz3yboFYksg==
X-Received: by 2002:adf:ac81:: with SMTP id o1-v6mr11094969wrc.220.1525176454012;
        Tue, 01 May 2018 05:07:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/12] get_short_oid: learn to disambiguate by ^{tag}
Date:   Tue,  1 May 2018 12:06:46 +0000
Message-Id: <20180501120651.15886-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for ^{tag} to the disambiguation logic. Before this ^{tag}
would simply be ignored:

    $ git rev-parse e8f2^{tag}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f2650052 tag v2.17.0
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob
    e8f2^{tag}

Now the logic added in ed1ca6025f ("peel_onion: disambiguate to favor
tree-ish when we know we want a tree-ish", 2013-03-31) has been
extended to support it.

    $ git rev-parse e8f2^{tag}
    e8f2650052f3ff646023725e388ea1112b020e79

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h                             |  5 +++--
 sha1-name.c                         | 13 ++++++++++++-
 t/t1512-rev-parse-disambiguation.sh |  5 ++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 354903c3ea..a141995cc7 100644
--- a/cache.h
+++ b/cache.h
@@ -1330,8 +1330,9 @@ struct object_context {
 #define GET_OID_TREE             010
 #define GET_OID_TREEISH          020
 #define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
+#define GET_OID_TAG             0100
+#define GET_OID_FOLLOW_SYMLINKS 0200
+#define GET_OID_RECORD_PATH     0400
 #define GET_OID_ONLY_TO_DIE    04000
 
 #define GET_OID_DISAMBIGUATORS \
diff --git a/sha1-name.c b/sha1-name.c
index 46d8b1afa6..68d5f65362 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -221,6 +221,12 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
+static int disambiguate_tag_only(const struct object_id *oid, void *cb_data_unused)
+{
+	int kind = oid_object_info(oid, NULL);
+	return kind == OBJ_TAG;
+}
+
 static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
 {
 	int kind = oid_object_info(oid, NULL);
@@ -288,7 +294,8 @@ int set_disambiguate_hint_config(const char *var, const char *value)
 		{ "committish", disambiguate_committish_only },
 		{ "tree", disambiguate_tree_only },
 		{ "treeish", disambiguate_treeish_only },
-		{ "blob", disambiguate_blob_only }
+		{ "blob", disambiguate_blob_only },
+		{ "tag", disambiguate_tag_only }
 	};
 	int i;
 
@@ -429,6 +436,8 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 		ds.fn = disambiguate_treeish_only;
 	else if (flags & GET_OID_BLOB)
 		ds.fn = disambiguate_blob_only;
+	else if (flags & GET_OID_TAG)
+		ds.fn = disambiguate_tag_only;
 	else
 		ds.fn = default_disambiguate_hint;
 
@@ -958,6 +967,8 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	lookup_flags &= ~GET_OID_DISAMBIGUATORS;
 	if (expected_type == OBJ_COMMIT)
 		lookup_flags |= GET_OID_COMMITTISH;
+	else if (expected_type == OBJ_TAG)
+		lookup_flags |= GET_OID_TAG;
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_OID_TREEISH;
 
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 2701462041..74e7d9c178 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -334,7 +334,10 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
 	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
 	grep ^hint: stderr >hints &&
 	# 5 commits, 1 tag (which is a commitish), plus intro line
-	test_line_count = 7 hints
+	test_line_count = 7 hints &&
+	git rev-parse 000000000^{tag} >stdout &&
+	test_line_count = 1 stdout &&
+	grep -q ^0000000000f8f stdout
 '
 
 test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
-- 
2.17.0.290.gded63e768a

