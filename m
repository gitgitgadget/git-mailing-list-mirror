Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8324020248
	for <e@80x24.org>; Thu, 14 Mar 2019 21:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfCNVr4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 17:47:56 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:54062 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfCNVr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 17:47:56 -0400
Received: by mail-wm1-f47.google.com with SMTP id e74so4573396wmg.3
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TryJBwAkwQxDm1aGGzWLrQtjnpTYQFOtNncA80STXMk=;
        b=EXTtRbE1zkQMHHTAqi+ZVr9Dd515NrdffFcwvILVkgISYKJI55rE5yAmpvFyhTxF4c
         aR9gt1wdOd1xBW9kUI3mF0BBLf6Fu0fkhImMyedQDrVKxo6b94isPtlHEsE4fs/P2cby
         kZkfukAJ0bbhdqspAoE+mN1tSJYO+YKEKsGTVTRR8yILYrSubUT70KPQKfItOUbbuDwb
         3JJQYcINJ6gGp8hwMzQGxnyI217iUC6xSJsNxPbnz3wp/CZBfG3cXFVCsFh3qCkWj0ts
         Ox73sss0qBU1aA0NrI8ddcCCY34wafF33gKA+OVa3Q5udBc2Ucydc8//ohutcLdZic7d
         VmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TryJBwAkwQxDm1aGGzWLrQtjnpTYQFOtNncA80STXMk=;
        b=m7vsNKPLbod+Jyh2pNaniecBsgzrjAdhW7mzicNVxkqdGOU1C9mrbKOHAJI4hU5PO0
         eFDRSfrI+N27KVGPTYl0nM/Hn1TjqFYiPy4l3dLH9mShh33Sk+aCBX8PmgtiKziiaDdv
         yg0Jtp3W1DgqlhMnQIKsYjNt1aWsP5VeP+Ug7iubn1kxKdJp6gLUFIsYuX4sVl+owmAq
         8QmbhBu00rbebDYAM+/2wWd7ner70PQpv/WCQbkSgAiOLPa6lzESWwVAfqViZ0gGRbTm
         uM0RD57gu+0jo1Ryc6DnrnDv3Ox/Cgfq9oNe8FQ84XNMrdKf1sfbxlDyTt5Be6omLd7p
         9hkQ==
X-Gm-Message-State: APjAAAXf3aKh9mDMnu7louMWJ1VfN8tfx4n5mRpPfvqqfhzlE6vbBXxs
        7B50HPp/zomRQEbvLG9n1+7bXUoQJco=
X-Google-Smtp-Source: APXvYqyYjDz8/WorNw029JqTBtTiRNZL2EPkJI79ih2gt+S6+6dbvoyi+OGWpCvznsWDLPvg5CdWPg==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr345435wmb.89.1552600073726;
        Thu, 14 Mar 2019 14:47:53 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h137sm194348wmg.41.2019.03.14.14.47.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 14:47:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] commit-graph tests: split up corrupt_graph_and_verify()
Date:   Thu, 14 Mar 2019 22:47:33 +0100
Message-Id: <20190314214740.23360-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the corrupt_graph_and_verify() function added in
d9b9f8a6fd ("commit-graph: verify catches corrupt signature",
2018-06-27) into its logical components of setting up the test itself,
doing the corruption in a particular way with "dd", and then finally
testing that stderr is what we expect.

This allows for re-using everything except the now slimmer
corrupt_graph_and_verify() to corrupt the graph in a way that doesn't
involve inserting a given byte sequence at a given position,
e.g. truncating it entirely to a custom value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 561796f280..56a616831e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -366,6 +366,19 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
 GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 
+corrupt_graph_setup() {
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	cp $objdir/info/commit-graph commit-graph-backup
+}
+
+corrupt_graph_verify() {
+	grepstr=$1
+	test_must_fail git commit-graph verify 2>test_err &&
+	grep -v "^+" test_err >err &&
+	test_i18ngrep "$grepstr" err
+}
+
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
 # Manipulates the commit-graph file at the position
 # by inserting the data, optionally zeroing the file
@@ -376,17 +389,14 @@ corrupt_graph_and_verify() {
 	pos=$1
 	data="${2:-\0}"
 	grepstr=$3
-	cd "$TRASH_DIRECTORY/full" &&
+	corrupt_graph_setup &&
 	orig_size=$(wc -c < $objdir/info/commit-graph) &&
 	zero_pos=${4:-${orig_size}} &&
-	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
 	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
-	test_must_fail git commit-graph verify 2>test_err &&
-	grep -v "^+" test_err >err &&
-	test_i18ngrep "$grepstr" err
+	corrupt_graph_verify "$grepstr"
+
 }
 
 test_expect_success 'detect bad signature' '
-- 
2.21.0.360.g471c308f928

