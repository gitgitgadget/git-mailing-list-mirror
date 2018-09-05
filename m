Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615531F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIETRH (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETRH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so3561513pgo.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mqAJZMyqNhm+YG40xvDtrYpo6jqgv79TKc/V/Hzr+Qk=;
        b=b+qE9uEmZ9F/YAWFNqCbQHX+dZ3/q3w8n+Z/H3GDuAG4D3382Ugg5XgU6nEIi3gxJ8
         FqgTmjR9XzstHjYvQIMFMzSM/xpGTtHXIayq46Hd/h5sfLaO/dxuhNziBWZWNzPd1YGI
         +6zEbdXPv5jEOZ4+SFlzB2yHx9Rs6OVmiuToKkuz8BVFbn7WIEzKTXPLH1PI8XjtLGpL
         SH+iX/PDeHlp2IohiF8vaGLE3SrCYlhQfR8asI12IYDGKdOf59ODgyZdXqql2z8Nlp36
         jS8M15WCR4DfqwdIDp6XkQFCHbcbBtymqUk0odaGhscDOPDTFsSxPCQg4HqoSSXLEtsq
         MKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mqAJZMyqNhm+YG40xvDtrYpo6jqgv79TKc/V/Hzr+Qk=;
        b=odPNKGN8WS9vIIIP4QikmmhxV6V0fV9CIKIBFsn/YL64zFRUNSkx6rOjPz13RB0Sir
         LdvMq6QJ2Dc8sW+hUa20LqdHAY7Xh4hYdENiI2MGdQ9/G8KOCkPNKN4TrPSwfmRBvEpW
         oSWPZGotylhn8UQlugoodeX73wvwIGIuav0pEi+7DTL9k0mNGnLbbKRU58THTkGdsYND
         0IfdHaq0MAfeLjxYQ3BypciOzqzZdY/cJ3heyrdD+PzInBXK4FLuoWLQYLbj1hjWrXII
         TaErsmOw4VDBbNzG4VeZSnGy4UVSyLqINL7cFFItPfprhWBzC3Nt1VjjUb0x2+aA9Ngc
         KcVQ==
X-Gm-Message-State: APzg51BlpRPPwex7OaEKYypbFk6KKEWDeKl4zuUcAI5ujvjqLyB2Db2k
        xO4W0yC4RqffbyLMki/fbLpIyRyA
X-Google-Smtp-Source: ANB0VdaDUY+SzZf9vnzGlbMqKREgcFvPhIOYux4EaUcjdUj0mqKSCrMc2EGVCTj61CoexhBx09NslA==
X-Received: by 2002:a63:d150:: with SMTP id c16-v6mr37095800pgj.188.1536158795273;
        Wed, 05 Sep 2018 07:46:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f62-v6sm3800302pfg.74.2018.09.05.07.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:34 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:34 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:20 GMT
Message-Id: <787e1fb61626afe79cfc846c4175d4b4d169ff42.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/11] multi-pack-index: verify bad header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When verifying if a multi-pack-index file is valid, we want the
command to fail to signal an invalid file. Previously, we wrote
an error to stderr and continued as if we had no multi-pack-index.
Now, die() instead of error().

Add tests that check corrupted headers in a few ways:

* Bad signature
* Bad file version
* Bad hash version
* Truncated hash count
* Extended hash count

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 18 +++++----------
 t/t5319-multi-pack-index.sh | 46 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/midx.c b/midx.c
index b253bed517..ec78254bb6 100644
--- a/midx.c
+++ b/midx.c
@@ -76,24 +76,18 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	m->local = local;
 
 	m->signature = get_be32(m->data);
-	if (m->signature != MIDX_SIGNATURE) {
-		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
+	if (m->signature != MIDX_SIGNATURE)
+		die(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
 		      m->signature, MIDX_SIGNATURE);
-		goto cleanup_fail;
-	}
 
 	m->version = m->data[MIDX_BYTE_FILE_VERSION];
-	if (m->version != MIDX_VERSION) {
-		error(_("multi-pack-index version %d not recognized"),
+	if (m->version != MIDX_VERSION)
+		die(_("multi-pack-index version %d not recognized"),
 		      m->version);
-		goto cleanup_fail;
-	}
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
-	if (hash_version != MIDX_HASH_VERSION) {
-		error(_("hash version %u does not match"), hash_version);
-		goto cleanup_fail;
-	}
+	if (hash_version != MIDX_HASH_VERSION)
+		die(_("hash version %u does not match"), hash_version);
 	m->hash_len = MIDX_HASH_LEN;
 
 	m->num_chunks = m->data[MIDX_BYTE_NUM_CHUNKS];
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1c4e0e6d31..836d2bdb53 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -154,6 +154,51 @@ test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
 
+# usage: corrupt_midx_and_verify <pos> <data> <objdir> <string>
+corrupt_midx_and_verify() {
+	POS=$1
+	DATA="${2:-\0}"
+	OBJDIR=$3
+	GREPSTR="$4"
+	FILE=$OBJDIR/pack/multi-pack-index &&
+	chmod a+w $FILE &&
+	test_when_finished mv midx-backup $FILE &&
+	cp $FILE midx-backup &&
+	printf "$DATA" | dd of="$FILE" bs=1 seek="$POS" conv=notrunc &&
+	test_must_fail git multi-pack-index verify --object-dir=$OBJDIR 2>test_err &&
+	grep -v "^+" test_err >err &&
+	test_i18ngrep "$GREPSTR" err
+}
+
+test_expect_success 'verify bad signature' '
+	corrupt_midx_and_verify 0 "\00" $objdir \
+		"multi-pack-index signature"
+'
+
+MIDX_BYTE_VERSION=4
+MIDX_BYTE_OID_VERSION=5
+MIDX_BYTE_CHUNK_COUNT=6
+
+test_expect_success 'verify bad version' '
+	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
+		"multi-pack-index version"
+'
+
+test_expect_success 'verify bad OID version' '
+	corrupt_midx_and_verify $MIDX_BYTE_OID_VERSION "\02" $objdir \
+		"hash version"
+'
+
+test_expect_success 'verify truncated chunk count' '
+	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\01" $objdir \
+		"missing required"
+'
+
+test_expect_success 'verify extended chunk count' '
+	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_COUNT "\07" $objdir \
+		"terminating multi-pack-index chunk id appears earlier than expected"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
@@ -191,7 +236,6 @@ test_expect_success 'multi-pack-index in an alternate' '
 
 compare_results_with_midx "with alternate (remote midx)"
 
-
 # usage: corrupt_data <file> <pos> [<data>]
 corrupt_data () {
 	file=$1
-- 
gitgitgadget

