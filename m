Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA251F404
	for <e@80x24.org>; Sun,  7 Jan 2018 22:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbeAGW2d (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 17:28:33 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34057 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbeAGW23 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 17:28:29 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so13495276wmg.1
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xiRG0McDpkruh+OktUidvRzoIUdckkGzLBB2SMRfQmA=;
        b=C07NJb0mKr1HA6H+uXCWEfmzgbKYsU53PugKBIsTMnwA7i8SqdGt/vvzaifY/9+ZtU
         WLnO4B/LxIJH9VhX8u3K4YMAJSZ8He9NNiAzWHlorm1p8E5HqKydD8uRlVKIXwFr8HnT
         i9adQna/pQ8JguTN1hgFiVRmvdvWNWd7ikG7cp7OK2jgHEp+N1Y2dgW7Maz8ATEzxdTB
         JFrAf6V7f5ZKY2pwsEEz/mXkR8GWhtkflMq6kN0a9aSliGv54hfTuprZZToYjslhWe6k
         1a49QrO5u3jhJhDir4MB5Am+SUjSQpPRedCb0tVbhLSE8P9M7Vpk9T8URt9XJO9VPrFP
         XBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xiRG0McDpkruh+OktUidvRzoIUdckkGzLBB2SMRfQmA=;
        b=WA1TA/XMfblPMa452loGyuAID7CziTJuDZY+NBK3qH+AKXrJ6f0GaVN20K3gdBAwy9
         JBYyAFo3iAKKQDGlrCLoJNggMaqtkhOILbtWCY0g0bxt4hwnr++cl7jO+LZ1/ERxSfB1
         XT9WCy8N2SQmMkp83AP99zzZLjmLKVvRmXM/i32I9VCHpoRo1CDN9j80GqxCzL/UpZRl
         29h8gvj9mcbyYUwSOMMvbQQqXHY7ucJZ0NRt3DhcEdctNIPrkbhmm2L92vL3uFXALkTv
         bEBJra52NRZwKjyXBpC/kNB+7I8oMBuMY7dLUU3iybWH7spIrOidI4GpsWUBqo1TC80v
         +BQA==
X-Gm-Message-State: AKGB3mI4ivyP2gOCBGazmX08Lu1Zzfi5XjDsjrUX2BsjU91cMVDfeWZS
        LoJjK/jqECotLgG9hhCFh7Xq57hr
X-Google-Smtp-Source: ACJfBosn5RNSomRHO2zUAkOcnh3TNThxkmbfC/mqBtQe8brU3bN6QnkNKM1+sq34FyQhuIgqc9RvaQ==
X-Received: by 10.28.24.11 with SMTP id 11mr7138147wmy.108.1515364108493;
        Sun, 07 Jan 2018 14:28:28 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i65sm27622852wme.20.2018.01.07.14.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jan 2018 14:28:27 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/3] split-index: don't write cache tree with null oid entries
Date:   Sun,  7 Jan 2018 22:30:14 +0000
Message-Id: <20180107223015.17720-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79
In-Reply-To: <20180107223015.17720-1-t.gummerer@gmail.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a96d3cc3f6 ("cache-tree: reject entries with null sha1", 2017-04-21)
we made sure that broken cache entries do not get propagated to new
trees.  Part of that was making sure not to re-use an existing cache
tree that includes a null oid.

It did so by dropping the cache tree in 'do_write_index()' if one of
the entries contains a null oid.  In split index mode however, there
are two invocations to 'do_write_index()', one for the shared index
and one for the split index.  The cache tree is only written once, to
the split index.

As we only loop through the elements that are effectively being
written by the current invocation, that may not include the entry with
a null oid in the split index (when it is already written to the
shared index), where we write the cache tree.  Therefore in split
index mode we may still end up writing the cache tree, even though
there is an entry with a null oid in the index.

Fix this by checking for null oids in prepare_to_write_split_index,
where we loop the entries of the shared index as well as the entries for
the split index.

This fixes t7009 with GIT_TEST_SPLIT_INDEX.  Also add a new test that's
more specifically showing the problem.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h                |  3 ++-
 read-cache.c           |  2 +-
 split-index.c          |  2 ++
 t/t1700-split-index.sh | 19 +++++++++++++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d5a7d1d7f1..fd755c32cf 100644
--- a/cache.h
+++ b/cache.h
@@ -345,7 +345,8 @@ struct index_state {
 	struct split_index *split_index;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
-		 initialized : 1;
+		 initialized : 1,
+		 drop_cache_tree : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
diff --git a/read-cache.c b/read-cache.c
index 3f5b4afa36..d13ce83794 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2243,7 +2243,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct stat st;
 	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
-	int drop_cache_tree = 0;
+	int drop_cache_tree = istate->drop_cache_tree;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
diff --git a/split-index.c b/split-index.c
index 83e39ec8d7..284d04d67f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -238,6 +238,8 @@ void prepare_to_write_split_index(struct index_state *istate)
 				ALLOC_GROW(entries, nr_entries+1, nr_alloc);
 				entries[nr_entries++] = ce;
 			}
+			if (is_null_oid(&ce->oid))
+				istate->drop_cache_tree = 1;
 		}
 	}
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index af9b847761..c087b63367 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -401,4 +401,23 @@ done <<\EOF
 0642 -rw-r---w-
 EOF
 
+test_expect_success 'writing split index with null sha1 does not write cache tree' '
+	git config core.splitIndex true &&
+	git config splitIndex.maxPercentChange 0 &&
+	git commit -m "commit" &&
+	{
+		git ls-tree HEAD &&
+		printf "160000 commit $_z40\\tbroken\\n"
+	} >broken-tree &&
+	echo "add broken entry" >msg &&
+
+	tree=$(git mktree <broken-tree) &&
+	test_tick &&
+	commit=$(git commit-tree $tree -p HEAD <msg) &&
+	git update-ref HEAD "$commit" &&
+	GIT_ALLOW_NULL_SHA1=1 git reset --hard &&
+	(test-dump-cache-tree >cache-tree.out || true) &&
+	test_line_count = 0 cache-tree.out
+'
+
 test_done
-- 
2.16.0.rc1.238.g530d649a79

