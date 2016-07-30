Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E996B1F955
	for <e@80x24.org>; Sat, 30 Jul 2016 15:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbcG3PMb (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 11:12:31 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35023 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcG3PMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 11:12:19 -0400
Received: by mail-pa0-f67.google.com with SMTP id cf3so6844923pad.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 08:12:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBlcF25N5xJHiRR7SxF13cVb62Qdv6mEkx8VNdRe0Wg=;
        b=n1i8bSmiRnorVPHSh9lujxq4ntzlUG9bs3eykleqMeus/OpXRPfk8jn04w3iMJpym0
         g7JP48aL8XLNrWJEbPIBfdtu7tQkRh9Khb5lxWs5ixPPZxkOaUkHPJaEX+pwVwk1v2pv
         kFTIw3oT4UWWcgI5Bcti6aag6zItZzUQECoC1QlRGCo9I0qGRLevOtTVLZ0vp6Qk5nR9
         KgMpeatukBxBPf2yqb6oS+JT2iKjqEK4RcrZzoyBEF1idjH7jlj3VtPH1dBwb838xKsh
         RrGYlvZjJLi1zX7evEoYPaRwunVFVK4Jjoc9Z7U8r5sdl17scFSm0EZQ7Ei7e4WHctlj
         vBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBlcF25N5xJHiRR7SxF13cVb62Qdv6mEkx8VNdRe0Wg=;
        b=kSXDuG3iTBuzfnnIYa5GewCoFLptOSQpxpmK02nFhkHQgXJ19ckNsXDxGTIk0HO9r2
         hfiaLfqzPPVmwKrzI+1dOq9ZDwecwP8l83iHEGlRSWzLcD0ZH/yOIQnCy2B+7ZubOrqj
         kmfCO842Qhu3joqTeGaPm4OaHPDNfQbek21LEfXt3GvXjDBgqJnzYczn8KyHjBWD5OSt
         LEJeoho61oPcb//FwJgt1nX9QMXKheghurMcLU6N/5phdJW4vo/oe75AfJq8PjZ0Lfjm
         9H0yldY4JjnKweF/h0oz/YOkJRWJC+dU3YJ05HnuU83jOBuT4IlJx4D0U2Vtf7aQhBWk
         5amA==
X-Gm-Message-State: AEkoouvZFTL1YBatYZWMwmPF+vPRDxkCTIaZmnaNlOynPMD1hhySmTFu5xlpbO8qxg8kIA==
X-Received: by 10.66.150.4 with SMTP id ue4mr40108416pab.10.1469891539110;
        Sat, 30 Jul 2016 08:12:19 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id x184sm33113398pfd.70.2016.07.30.08.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 08:12:18 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH 2/3] diff-highlight: add failing test for handling --graph output.
Date:	Sat, 30 Jul 2016 08:11:48 -0700
Message-Id: <20160730151149.15980-3-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160730151149.15980-1-henderson.bj@gmail.com>
References: <20160730151149.15980-1-henderson.bj@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 13 ++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 42 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index ca7605f..2fb4869 100644
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -60,4 +60,17 @@ test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
 
 # TODO add multi-byte test
 
+test_expect_success 'diff-highlight highlightes the beginning of a line' '
+  dh_graph_test \
+    "aaa\nbbb\nccc\n" \
+    "aaa\n0bb\nccc\n" \
+    "aaa\nb0b\nccc\n" \
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
index 9b26271..162a694 100644
--- a/contrib/diff-highlight/t/test-diff-highlight.sh
+++ b/contrib/diff-highlight/t/test-diff-highlight.sh
@@ -67,3 +67,45 @@ dh_commit_test() {
 
   diff commit.exp commit.act
 }
+
+dh_graph_test() {
+  local a="$1" b="$2" c="$3"
+
+  {
+    printf "$a" > file
+    git add file
+    git commit -m"Add a file"
+
+    printf "$b" > file
+    git commit -am"Update a file"
+
+    git checkout -b branch
+    printf "$c" > file
+    git commit -am"Update a file on branch"
+
+    git checkout master
+    printf "$a" > file
+    git commit -am"Update a file again"
+
+    git checkout branch
+    printf "$b" > file
+    git commit -am"Update a file similar to master"
+
+    git merge master
+    git checkout master
+    git merge branch --no-ff
+  } >/dev/null 2>&1
+
+  git log -p --graph --no-merges > graph.raw
+
+  # git log --graph orders the commits different than git log so we hack it by
+  # using sed to remove the graph part. We know from other tests, that CMD
+  # works without the graph, so there should be no diff when running it with
+  # and without.
+  < graph.raw sed -e 's"^\(*\|| \||/\)\+""' -e 's"^  ""' | $CMD > graph.exp
+  < graph.raw $CMD | sed -e 's"^\(*\|| \||/\)\+""' -e 's"^  ""' > graph.act
+
+  # ignore whitespace since we're using a hacky sed command to remove the graph
+  # parts.
+  diff -b graph.exp graph.act
+}
-- 
2.9.0

