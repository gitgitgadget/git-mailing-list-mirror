Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19711215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932131AbeEASlm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:41:42 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:40226 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756441AbeEASkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:49 -0400
Received: by mail-wr0-f181.google.com with SMTP id v60-v6so11572272wrc.7
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Djydfvk5FDCOvGeRdNDrgDjTnSAkKVuGv7UN6PYrFI8=;
        b=vLG/xgmzQy9n7H51i/ke0hYjHW2YZXh+Be8mng40oM6k7J6SOCveg8K0QLAemWnzzQ
         q9o3b4ZRmd0QJGMSUXAV9w1mR5G23MRdT0pjW6k/6ReGB3WsTFLra0mRuSsJk84l2yHq
         v/D94LHqv+rb/EM3d3EzRHXeEEQ4+wW+SibvEWwkIDcn0eoq4Qb+caIIExzh99ba9pSo
         yQaGT9mVW33dCyDZ4BG5cRx1h3jmrg1xroU3wP3c1rvmH68drW5Om8lMn+3J+Rx0j439
         eFWSQa5Ruk9D7WDuKpv8JarEP11WKv4vKz56PVwiAOx6p65jK/aSRo/0/3alutwPw06g
         3TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Djydfvk5FDCOvGeRdNDrgDjTnSAkKVuGv7UN6PYrFI8=;
        b=MRm91AGs8NUICAh3Ld8+LpoWgPlFu18dsmSHKrIhu9sjiOM1QZPT3fq6wYSgE4G//Z
         R4cdKb3fxkvQnj4Ml2moLPw3HicU4v4RmlWd7WRJl9OrAC/RJvhtk9fmZUCqxr7eY8ah
         5LsTBX0BamugHDwpXB32h+ijnCNCamBSgdPGLxerkjHiPrEt9N3IGID249lr9WV2tIAM
         7ufwvnuwZNm/XOhD3oJwhYYomXRDrwcNnmH4VNvPg//8/nVNicJoMv/Mo9sxyhWBxPOb
         4w5cvvz2uXn4H2aTLPTKINU7qRubvfHKBhggNv6M8V46NYnHD9TjRJEtqIvmITFdLeZ8
         bLKA==
X-Gm-Message-State: ALQs6tBhpI7Dw68ikpDxyVK1F+uAbUeo2a6ftLtzRo8YiDcAjMlfKVza
        daPRF8gPpmhvNm01I/Prz64xWpHj
X-Google-Smtp-Source: AB8JxZozOt2toUj06D/9VLvUzxylP4VWpK2tFANov6vPsulJNCPi87cSqkth6D4R8ZbQoG+0v0IeHw==
X-Received: by 2002:adf:88c2:: with SMTP id g2-v6mr12213131wrg.78.1525200048226;
        Tue, 01 May 2018 11:40:48 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:47 -0700 (PDT)
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
Subject: [PATCH v3 07/12] get_short_oid: learn to disambiguate by ^{tag}
Date:   Tue,  1 May 2018 18:40:11 +0000
Message-Id: <20180501184016.15061-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
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

