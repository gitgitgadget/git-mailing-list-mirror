Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8590220A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeLJQmr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:42:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40884 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:42:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so5487979plq.7
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g4hO2A6WhnkK+0Xu4O9k7rPrftRPwAkIN8AY9QiikNk=;
        b=G0m7bSEkWJoIoqRySKzN0ZeRHWGmSwsn+kcrmHshhl9poWcGKr375aYJuSYXDAbEIL
         AjDlldA89m0P+7o8CeeeXVZf4qtQj53IVUc4rJrasFV/8enyzSGVJxLTXufE8JO4GEOO
         6zBBc5Lecp/zpwcg5DTQ8eTuxVOAujFrEFa/5Nuhd1fDHqrzVEtebpbI7/6s79iZwzBA
         xSFAZXq8YI43iFsaSMofNUmHtMNBITHC7TVa+DVomt4pEN5inUY6fkOF/i2TqcCkrKnI
         xM92sYWFk+AvM/How/MifciCcBbQe9GnHY/FuiZsWr3v/C7qtd9evhjXY6h8hdcbvoLF
         8fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g4hO2A6WhnkK+0Xu4O9k7rPrftRPwAkIN8AY9QiikNk=;
        b=X4v35688+JevS600UMv9W4bRnyC6Ari6lONCRiQTmzL3V6Zz54ovPLLotcOdFVvLUm
         +kzdV7HHlIWh0wURFfpDik4jr9Zp/ku7d89EuPqnLBWYxPnn+QX0vuK/qYJP7OpplGaU
         PApKGMt8kmRgmG5lV4n6vcj3iCwamMMNIOWsLK1Lq1Ql8eVuHcwsVJtG0FYL97PoDnWG
         qxjcgAB/6VU79qQC751gpamUeyHqzWS/SGvRX1CPXyMpOw2zo32DdvxkOmdl5AoWLw1E
         FIZtUV3ljmGaviJptro4EGWAnoR5CtX//m/xUmI2hBAQKZOh9ClQh9NGNIiXbnulJ5dj
         +bAQ==
X-Gm-Message-State: AA+aEWaPm/SofiGJh2uGgGJirghsDDDeF/Sc45DmckeQYXF2JaF1AJSB
        M6TkKrEBNTFzzs06lMhtzkxqgfGk
X-Google-Smtp-Source: AFSGD/XjXJ4tZl8bv82CGtzXmuZbhyyZnwkf7s+4GswKx3IXC1Ggww7NZcMVRRwaUWIFZMvgKqJXFg==
X-Received: by 2002:a17:902:6f09:: with SMTP id w9mr13040444plk.309.1544460164986;
        Mon, 10 Dec 2018 08:42:44 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id e23sm17973566pfh.68.2018.12.10.08.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:42:44 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:42:44 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 16:42:35 GMT
Message-Id: <4ef318bdb2f1f7c55130f875280604e816cc183f.1544460159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v3.git.gitgitgadget@gmail.com>
References: <pull.89.v2.git.gitgitgadget@gmail.com>
        <pull.89.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/6] pack-objects: add --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a '--sparse' option flag to the pack-objects builtin. This
allows the user to specify that they want to use the new logic
for walking trees. This logic currently does not differ from the
existing output, but will in a later change.

Create a new test script, t5322-pack-objects-sparse.sh, to ensure
the object list that is selected matches what we expect. When we
update the logic to walk in a sparse fashion, the final test will
be updated to show the extra objects that are added.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-pack-objects.txt |  11 ++-
 builtin/pack-objects.c             |   5 +-
 t/t5322-pack-objects-sparse.sh     | 115 +++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 40c825c381..e45f3e680d 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
 	[--stdout [--filter=<filter-spec>] | base-name]
-	[--shallow] [--keep-true-parents] < object-list
+	[--shallow] [--keep-true-parents] [--sparse] < object-list
 
 
 DESCRIPTION
@@ -196,6 +196,15 @@ depth is 4095.
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
+--sparse::
+	Use the "sparse" algorithm to determine which objects to include in
+	the pack, when combined with the "--revs" option. This algorithm
+	only walks trees that appear in paths that introduce new objects.
+	This can have significant performance benefits when computing
+	a pack to send a small change. However, it is possible that extra
+	objects are added to the pack-file if the included commits contain
+	certain types of direct renames.
+
 --thin::
 	Create a "thin" pack by omitting the common objects between a
 	sender and a receiver in order to reduce network transfer. This
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5f70d840a7..7d5b0735e3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -84,6 +84,7 @@ static unsigned long pack_size_limit;
 static int depth = 50;
 static int delta_search_threads;
 static int pack_to_stdout;
+static int sparse;
 static int thin;
 static int num_preferred_base;
 static struct progress *progress_state;
@@ -3135,7 +3136,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge, 0);
+	mark_edges_uninteresting(&revs, show_edge, sparse);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
@@ -3292,6 +3293,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
 		  N_("unpack unreachable objects newer than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
+		OPT_BOOL(0, "sparse", &sparse,
+			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
 			 N_("create thin packs")),
 		OPT_BOOL(0, "shallow", &shallow,
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
new file mode 100755
index 0000000000..81f6805bc3
--- /dev/null
+++ b/t/t5322-pack-objects-sparse.sh
@@ -0,0 +1,115 @@
+#!/bin/sh
+
+test_description='pack-objects object selection using sparse algorithm'
+. ./test-lib.sh
+
+test_expect_success 'setup repo' '
+	test_commit initial &&
+	for i in $(test_seq 1 3)
+	do
+		mkdir f$i &&
+		for j in $(test_seq 1 3)
+		do
+			mkdir f$i/f$j &&
+			echo $j >f$i/f$j/data.txt
+		done
+	done &&
+	git add . &&
+	git commit -m "Initialized trees" &&
+	for i in $(test_seq 1 3)
+	do
+		git checkout -b topic$i master &&
+		echo change-$i >f$i/f$i/data.txt &&
+		git commit -a -m "Changed f$i/f$i/data.txt"
+	done &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic2
+	^topic3
+	EOF
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+# Demonstrate that both algorithms send "extra" objects because
+# they are not in the frontier.
+
+test_expect_success 'duplicate a folder from f3 and commit to topic1' '
+	git checkout topic1 &&
+	echo change-3 >f3/f3/data.txt &&
+	git commit -a -m "Changed f3/f3/data.txt" &&
+	git rev-parse			\
+		topic1~1		\
+		topic1~1^{tree}		\
+		topic1^{tree}		\
+		topic1			\
+		topic1:f1		\
+		topic1:f1/f1		\
+		topic1:f1/f1/data.txt	\
+		topic1:f3		\
+		topic1:f3/f3		\
+		topic1:f3/f3/data.txt | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+test_expect_success 'duplicate a folder from f1 into f3' '
+	mkdir f3/f4 &&
+	cp -r f1/f1/* f3/f4 &&
+	git add f3/f4 &&
+	git commit -m "Copied f1/f1 to f3/f4" &&
+	cat >packinput.txt <<-EOF &&
+	topic1
+	^topic1~1
+	EOF
+	git rev-parse		\
+		topic1		\
+		topic1^{tree}	\
+		topic1:f3 | sort >expect_objects.txt
+'
+
+test_expect_success 'non-sparse pack-objects' '
+	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git index-pack -o nonsparse.idx nonsparse.pack &&
+	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
+	test_cmp expect_objects.txt nonsparse_objects.txt
+'
+
+test_expect_success 'sparse pack-objects' '
+	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
+test_done
-- 
gitgitgadget

