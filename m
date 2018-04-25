Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A42D1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeDYJy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:50095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbeDYJyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:13 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MMXVC-1fJWS00KaM-008Ibe; Wed, 25 Apr 2018 11:54:06 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 02/11] commit: Let the callback of for_each_mergetag return on error
Date:   Wed, 25 Apr 2018 11:54:04 +0200
Message-Id: <97428f56890413d16f1487309972c446b61f784f.1524650028.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:85SZAVz/8KWUbWl2RkanO82WuQVTeT22j7IjK3eJgNrjZyUVAie
 FhhWjGs5L7BROGHqKeTd0TYmDqkYcoV32KUy66PJitP4IaV3A7/Vgl6AY1kft7jEWdfXfbK
 Jg22zzwGPFFOko1+pWp5Bv5xI8PkYL2qPn/Rh89MfLfPzSGfw1j3DdTwpBCWSkXiUopLeFj
 MP/bBFHJ4sd1dwnEeWYsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yzxkKc1HPGc=:kHzG2FZ0BZWIA2zwyyItAC
 dz019jHYrwY/qv8MA9P2A0PiaUOWCEa1qtqXDFVEoC/XqEgaAa4qat4jkgbhRIFzKJxnxsqHn
 gt/JLsgmlv0x4vWiIvJUHxS8Gm0kM74yfsmdHStYzXbFNm3ELzLenB3OaoP9awy3yK3mHZGil
 ZiivTrnAGmjdNXR6J4Ex/qs8AXTr0IeMi0xyAWBRGhaSCcnYv7Mj7C50DpBPcRN5yA8FktcP1
 hFlOz3DrthFRZvevvaUHuSkcZO4Hk6dxWgOxs9aXv9H7B51ENkwBMHHjIpBZVzhqpTZuFFxx7
 ol+lTBlySSFX9/JwHreACjSqu+O0puVrN1P4+9Y/PVdhyViregYPe9dRaEbiGZ/9sEt89YP7t
 0rdqW5tLaoBCUTi1i0a/uGHI7VbL3QXRJmEEiwoUB1uMXL5u+SRJgNZPpjoUYsfAHOz041wpE
 pplTpvvyZAB3gQlQEMENd/OuSWkgg5TkGAQrpnl1UtwBxJmjnepNU8ReRvkhvrFWZej9e38VV
 tLKcgOQ4fVTDP33uJZ7xHIgYABjBu0P4PHzMVDyIdtSIID0XtAVaa6ZaTYuVnDeDTp00CGGj4
 wUNDII2XIpIaP3EvLjtVwl9OfQDYdC/bIUL7ovA0TX9OFmR32P5lkbXrubzzoBaXgGC1csdz9
 SoI5dNnizVIZxcHO++wHU2LvS0zsrYTAhzGdkAd1q0myDxlH3fuplL4ptMXttd7o9224JWc54
 PcDhULgixBaP7WgXiOU8eIO9amSzIrtE0TK5ixW83f0MqsFUK7Rj8+hqwPsQjW6T6F4jlq5F5
 lGgkmqQcvbNvTY5VZYfZwRiwKzd8YrCoPtwT8T3X6bFMxZ4P3dkJ66oeuZy7RyQ9nANUfWm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch to be filed under the keyword "libification".

There is one subtle change in behavior here, where a `git log` that has
been asked to show the mergetags would now stop reporting the mergetags
upon the first failure, whereas previously, it would have continued to the
next mergetag, if any.

In practice, that change should not matter, as it is 1) uncommon to
perform octopus merges using multiple tags as merge heads, and 2) when the
user asks to be shown those tags, they really should be there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c |  8 ++++----
 commit.c          |  8 +++++---
 commit.h          |  4 ++--
 log-tree.c        | 13 +++++++------
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 935647be6bd..245d3f4164e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -345,7 +345,7 @@ struct check_mergetag_data {
 	const char **argv;
 };
 
-static void check_one_mergetag(struct commit *commit,
+static int check_one_mergetag(struct commit *commit,
 			       struct commit_extra_header *extra,
 			       void *data)
 {
@@ -368,20 +368,20 @@ static void check_one_mergetag(struct commit *commit,
 		if (get_oid(mergetag_data->argv[i], &oid) < 0)
 			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
 		if (!oidcmp(&tag->tagged->oid, &oid))
-			return; /* found */
+			return 0; /* found */
 	}
 
 	die(_("original commit '%s' contains mergetag '%s' that is discarded; "
 	      "use --edit instead of --graft"), ref, oid_to_hex(&tag_oid));
 }
 
-static void check_mergetags(struct commit *commit, int argc, const char **argv)
+static int check_mergetags(struct commit *commit, int argc, const char **argv)
 {
 	struct check_mergetag_data mergetag_data;
 
 	mergetag_data.argc = argc;
 	mergetag_data.argv = argv;
-	for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
+	return for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
 }
 
 static int create_graft(int argc, const char **argv, int force)
diff --git a/commit.c b/commit.c
index ca474a7c112..2952ec987c5 100644
--- a/commit.c
+++ b/commit.c
@@ -1288,17 +1288,19 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 	return extra;
 }
 
-void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
+int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
 {
 	struct commit_extra_header *extra, *to_free;
+	int res = 0;
 
 	to_free = read_commit_extra_headers(commit, NULL);
-	for (extra = to_free; extra; extra = extra->next) {
+	for (extra = to_free; !res && extra; extra = extra->next) {
 		if (strcmp(extra->key, "mergetag"))
 			continue; /* not a merge tag */
-		fn(commit, extra, data);
+		res = fn(commit, extra, data);
 	}
 	free_commit_extra_headers(to_free);
+	return res;
 }
 
 static inline int standard_header_field(const char *field, size_t len)
diff --git a/commit.h b/commit.h
index 0fb8271665c..9000895ad91 100644
--- a/commit.h
+++ b/commit.h
@@ -291,10 +291,10 @@ extern const char *find_commit_header(const char *msg, const char *key,
 /* Find the end of the log message, the right place for a new trailer. */
 extern int ignore_non_trailer(const char *buf, size_t len);
 
-typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
+typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				 void *cb_data);
 
-extern void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
+extern int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
 
 struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
diff --git a/log-tree.c b/log-tree.c
index d1c0bedf244..f3a51a6e726 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -488,9 +488,9 @@ static int is_common_merge(const struct commit *commit)
 		&& !commit->parents->next->next);
 }
 
-static void show_one_mergetag(struct commit *commit,
-			      struct commit_extra_header *extra,
-			      void *data)
+static int show_one_mergetag(struct commit *commit,
+			     struct commit_extra_header *extra,
+			     void *data)
 {
 	struct rev_info *opt = (struct rev_info *)data;
 	struct object_id oid;
@@ -502,7 +502,7 @@ static void show_one_mergetag(struct commit *commit,
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
 	tag = lookup_tag(&oid);
 	if (!tag)
-		return; /* error message already given */
+		return -1; /* error message already given */
 
 	strbuf_init(&verify_message, 256);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
@@ -536,11 +536,12 @@ static void show_one_mergetag(struct commit *commit,
 
 	show_sig_lines(opt, status, verify_message.buf);
 	strbuf_release(&verify_message);
+	return 0;
 }
 
-static void show_mergetag(struct rev_info *opt, struct commit *commit)
+static int show_mergetag(struct rev_info *opt, struct commit *commit)
 {
-	for_each_mergetag(show_one_mergetag, commit, opt);
+	return for_each_mergetag(show_one_mergetag, commit, opt);
 }
 
 void show_log(struct rev_info *opt)
-- 
2.17.0.windows.1.33.gfcbb1fa0445


