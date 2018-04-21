Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE061F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeDUJrU (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:47:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:57859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeDUJrS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:47:18 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHso5-1f8RfY2GFx-003dfk; Sat, 21
 Apr 2018 11:47:13 +0200
Date:   Sat, 21 Apr 2018 11:46:43 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 02/11] commit: Let the callback of for_each_mergetag return
 on error
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <9e3238893668e2d3d0b1f2f17aebac9b90a5759c.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eAqozrWNQ9DrekiveKOm0XOchsoHn1lint9nabT8gBpmvLKLuV9
 UGEtYNRHYeuthBtjMr801+USlRA54bbWFj8dMJ1wh4XNM+Qtb5i8lBMaqA/z8T966BKH9QE
 DA2nZBrPS7XwwYVkYIZ410fwjm8S3eqx5Fw4a8+WecmHmbtVgaiWnkk4TGLPKzLc8INLT/t
 rpA3w9eLNZpJ/4EeFVDyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KZ+VMSFwlKU=:nVVRXxHKKRNayQq6qRj77S
 eo0b6qU1usToKk2XXS88znR3KPRWp5PgwzsyQy44ec94N8ZJw9zNVrfjYDwE51brdZAA4H2+Y
 NGcilwjosVXYCDznarP71KyCMy777wMQRfzNOURbGTch5w3vFXBGWy8Gvyx26DlJ1Af9Dxz+d
 DQLgXPC8NdQNujXyCcVXP/tPJOiyDvcXWg6qoAxPDj6SJ4XljFj5BUZzRM2uqw0z/UZT7iMMv
 8Q6A0RYXgw2sCXmOfcWWqBVf4UpvaE0OZY6hn8Wng+GD3hLWqXCJIHIUJ/Ycr728uMmOSI0K2
 6/JTPb02k/wenvmUKxpPczpeqvnl2dgMPtIU0IDF1bSLm5PoaY7NxNHn1FlRMGy4LHGGMExU6
 h3ZKg/3btB0cESI50MOP3Zfsz60y/jpAr5lwgt7N2vNSlhA1t+ZkAn0f1fDumneE4SJuQUPf9
 gPIov2LQ1WZd5ddiVcanhVqSwC0UtiIFftEiH5pUkev7Sg2hE3NYW2Zn+7trcqWfZ5YW8sP2O
 Me2pFKBTH9LrB2xxJsbb36DGPqSubUzSjXhOx2MTjPZdWsPROemn6UQBJiPNWOh+Zcui61K1r
 8I7OhVh4wLRF4u/JKMZl5oSXNow8YR3ByUKof66Sslpu0KsJJ1oRkN0IIsvY2om2ebjfEtd9Z
 EU9altxSvKbMukpSMpgvGAI/GcdJmPce6hW+klN+Kv6pfw7a/eXMVWNcDJyw/GRD4uQag/Jmx
 4mmAaagxUlyZZwKen79pFaFnYYxN/+wBZAJR1yl0APjVRSC8sksuNNPp2gQz+lBnDX6jL/QDF
 cqydIO64Wbw/IKcdIXWOiHeUUVtrt0bG28BnplSQnQK2hZ8Ssw=
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
2.17.0.windows.1.15.gaa56ade3205


