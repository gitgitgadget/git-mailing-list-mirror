Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BBF1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 15:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbcHQPcD (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 11:32:03 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35907 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcHQPcC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 11:32:02 -0400
Received: by mail-pa0-f68.google.com with SMTP id ez1so7452794pab.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 08:32:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ziM4t1Z0Y8vs/IKRgdu1uqETBPujPP0RydKgVZPumUs=;
        b=jyyU0knZ2nfqnCvzRHdFKW8Z+LE/RnJ9n8HTL3W1LYcjsXe533ttdaBx11V6UW/UFy
         /g3syMWN9JRWPXe2Ly85QdVcklyHZRs/Lo3azgQlipxettYQ1hfpI8YNwimML9lFPOkm
         b67auKtG2ZdBUneDx9vDagSwe61s1uCo6cWX6fx7+Ub9vwy5tmWxaJYj+Zwzn0tr5dQO
         yIVWX2yhl73O21klcmiX+4EKyPZ8yN7cNM1h2VpKeglDnwbHF4BOBKlr/7HRuqtuHUGb
         V03wGZYr1hZ2WodPL8UnJj6ksRWiTY+blDU8z7paiDBCFgS6JdiMNjon2DIPs+I45OTw
         gpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ziM4t1Z0Y8vs/IKRgdu1uqETBPujPP0RydKgVZPumUs=;
        b=VIcUPkvBRc/DQ07g++xkqfIuLt3StyyhXi+QkQi/Ie1SYzBewQEyD3J+C1EGccH5hJ
         fzrhZKxhebI1G49CPw8q2ir+05/p9/OJqBkfPy3sRGVNdwujrJQqzI6zQeSQ3cXDhnsZ
         Hn7lLlDPLilZ/yGehyNpzQQkyqsm11Z+2z5K1GAntNjiXwI8LjYOxqx9jhpowNnGtRvV
         1p4QOl1tITAtFMzC3pockVyZ5LKtziWDmHA/mfmRvbxC+Bec3lCiLFMhV3CtTuHqN0XJ
         ag95JHfph1+V3FTtxWt9p2EFA+MkGfBZ45Hb34cTLFTzyrI4IHYjkdjXaHZ+jx0zWlBj
         S3Dg==
X-Gm-Message-State: AEkoouv0oSMo+7qjOQNRk/fZMK9iE/QEBbNsdTqE4ebY1iGFMOkixN/Zbi5z12frCV3AEA==
X-Received: by 10.67.15.8 with SMTP id fk8mr75378310pad.19.1471447921778;
        Wed, 17 Aug 2016 08:32:01 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id fe8sm48311671pad.2.2016.08.17.08.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 08:32:01 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, e@80x24.org,
	Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v2 2/3] diff-highlight: add failing test for handling --graph output.
Date:	Wed, 17 Aug 2016 08:31:23 -0700
Message-Id: <20160817153124.7770-3-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160817153124.7770-1-henderson.bj@gmail.com>
References: <20160817153124.7770-1-henderson.bj@gmail.com>
In-Reply-To: <20160810085635.GA1672@starla>
References: <20160810085635.GA1672@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 13 +++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 43 ++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 8eff178..39707c6 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -59,4 +59,17 @@ test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
 
 # TODO add multi-byte test
 
+test_expect_success 'diff-highlight highlights the beginning of a line' '
+	dh_graph_test \
+		"aaa\nbbb\nccc\n" \
+		"aaa\n0bb\nccc\n" \
+		"aaa\nb0b\nccc\n" \
+"
+ aaa
+-${CW}b${CR}bb
++${CW}0${CR}bb
+ ccc
+"
+'
+
 test_done
diff --git a/contrib/diff-highlight/t/test-diff-highlight.sh b/contrib/diff-highlight/t/test-diff-highlight.sh
index 38323e8..67f742c 100644
--- a/contrib/diff-highlight/t/test-diff-highlight.sh
+++ b/contrib/diff-highlight/t/test-diff-highlight.sh
@@ -64,6 +64,49 @@ dh_commit_test() {
 	test_cmp commit.exp commit.act
 }
 
+dh_graph_test() {
+	a="$1" b="$2" c="$3"
+
+	{
+		printf "$a" >file
+		git add file
+		git commit -m"Add a file"
+
+		printf "$b" >file
+		git commit -am"Update a file"
+
+		git checkout -b branch
+		printf "$c" >file
+		git commit -am"Update a file on branch"
+
+		git checkout master
+		printf "$a" >file
+		git commit -am"Update a file again"
+
+		git checkout branch
+		printf "$b" >file
+		git commit -am"Update a file similar to master"
+
+		git merge master
+		git checkout master
+		git merge branch --no-ff
+	} >/dev/null 2>&1
+
+	git log -p --graph --no-merges >graph.raw
+
+	# git log --graph orders the commits different than git log so we hack it by
+	# using sed to remove the graph part. We know from other tests, that DIFF_HIGHLIGHT
+	# works without the graph, so there should be no diff when running it with
+	# and without.
+	<graph.raw sed -e 's"^\(*\|| \||/\)\+""' -e 's"^  ""' | "$DIFF_HIGHLIGHT" >graph.exp
+	<graph.raw "$DIFF_HIGHLIGHT" | sed -e 's"^\(*\|| \||/\)\+""' -e 's"^  ""' >graph.act &&
+
+	test -s graph.act &&
+	# ignore whitespace since we're using a hacky sed command to remove the graph
+	# parts.
+	git diff -b --no-index graph.exp graph.act
+}
+
 test_chomp_eof() {
 	perl -pe 'chomp if eof'
 }
-- 
2.9.0

