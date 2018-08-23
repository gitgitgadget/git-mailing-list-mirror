Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6912A1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeHXAc5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:32:57 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:35628 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeHXAc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:32:57 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 4BC392003C8;
        Thu, 23 Aug 2018 23:01:27 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] i18n: fix mistakes in translated strings
Date:   Thu, 23 Aug 2018 23:00:56 +0200
Message-Id: <20180823210056.27489-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix typos and convert a question which does not expect to be replied
to a simple advice.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/submodule--helper.c | 2 +-
 config.c                    | 2 +-
 sequencer.c                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2bcc70fdfe..b56028ba9d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -542,7 +542,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		argv_array_pushv(&cpr.args, info->argv);
 
 		if (run_command(&cpr))
-			die(_("run_command returned non-zero status while"
+			die(_("run_command returned non-zero status while "
 				"recursing in the nested submodules of %s\n."),
 				displaypath);
 	}
diff --git a/config.c b/config.c
index 9a0b10d4bc..3461993f0a 100644
--- a/config.c
+++ b/config.c
@@ -124,7 +124,7 @@ static const char include_depth_advice[] = N_(
 "	%s\n"
 "from\n"
 "	%s\n"
-"Do you have circular includes?");
+"This might be due to circular includes.");
 static int handle_path_include(const char *path, struct config_include_data *inc)
 {
 	int ret = 0;
diff --git a/sequencer.c b/sequencer.c
index 65d371c746..84bf598c3e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -720,7 +720,7 @@ static const char *read_author_ident(struct strbuf *buf)
 	/* dequote values and construct ident line in-place */
 	for (in = buf->buf; i < 3 && in - buf->buf < buf->len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
-			warning(_("could not parse '%s' (looking for '%s'"),
+			warning(_("could not parse '%s' (looking for '%s')"),
 				rebase_path_author_script(), keys[i]);
 			return NULL;
 		}
-- 
2.18.0

