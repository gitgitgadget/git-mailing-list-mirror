Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04631F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeEMFww (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44796 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeEMFw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id h197-v6so13349891lfg.11
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNw60YK45KTxBb/ak8D55j1bp9aQb/W8Gr/+QJAdf6o=;
        b=b+iGraWtU3m3VanMHOSkvpoF3mocH+KTF/qhx4A64V8aoCw6MMeGNY0nI1byewb8AI
         bDH2I6DDHwKuqHvhXWZYJdXLMJSD5h/gqWox86zlw5abfnuUS8h0noi20DD2Hi2GQaLk
         Q9QmUrH5/4WWpmsV5LQcXNriHykRs/qx+FINITiv37KhVwg91NpEnktPc9dW2A5th2nL
         jouzyMcbMSmFPb+gJiY7OV91PqVpsJNF6iclEN4pIUuwa134QUDLpaAYkxa7UFrXDKqL
         9S4aNd1cKoFvyi0YSiyssvVbk1MR5j1920gPRRsijrBTu5TvB/yaxXFTBtNLOilP8LlN
         U8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNw60YK45KTxBb/ak8D55j1bp9aQb/W8Gr/+QJAdf6o=;
        b=E83zm7Ni/Vvz7RpN/Nd1zW5MnT70yPxCDk/+W1jAxXHo+v8F6E2JHQf5wMnpd5+Blu
         JMkmikjuM22VKhifqIU5NJnOfSkbCjQsGsrflvyczenIwisP4Em9NRPnS7DQZPzlJsuw
         n9+zwFOrTfwKIBqiDuRfHFmyNPd8QhlUTl03yaBAamDflvJbkSyauenOafdHlCB3/PUr
         GRv82rtQSUJfnoC4WXj7f23btHU64r0Sgj5431QSygVkH297B+G9lbEgXwy4aW9H4CBn
         XOGxIoQ4tgPRupwUW8IGwW5ZIfuqQPUEy3eW9sGVh+QK/VfuYxeltL7yuvbL2D8h6ujO
         yd5w==
X-Gm-Message-State: ALKqPwfgPHwk1E6Jjqp80AwZawDIT02iNb+bwdbGkkYvqI0FL4VrDUDh
        riTZy33PawSiLXvJm5R3/6zT/A==
X-Google-Smtp-Source: AB8JxZqJThoSCfH4YmVPnmAvoBj4i0J9V2cOtmbo6+Z67Pzv2LR9KFZqomDz7XzmxQ2tEwAoDfQ48A==
X-Received: by 2002:a2e:86d9:: with SMTP id n25-v6mr1906217ljj.18.1526190745334;
        Sat, 12 May 2018 22:52:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/14] name-rev: use commit-slab for rev-name instead of commit->util
Date:   Sun, 13 May 2018 07:52:04 +0200
Message-Id: <20180513055208.17952-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/name-rev.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 387ddf85d2..0eb440359d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -6,6 +6,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "sha1-lookup.h"
+#include "commit-slab.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
@@ -17,11 +18,26 @@ typedef struct rev_name {
 	int from_tag;
 } rev_name;
 
+define_commit_slab(commit_rev_name, struct rev_name *);
+
 static timestamp_t cutoff = TIME_MAX;
+static struct commit_rev_name rev_names;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
+static struct rev_name *get_commit_rev_name(struct commit *commit)
+{
+	struct rev_name **slot = commit_rev_name_peek(&rev_names, commit);
+
+	return slot ? *slot : NULL;
+}
+
+static void set_commit_rev_name(struct commit *commit, struct rev_name *name)
+{
+	*commit_rev_name_at(&rev_names, commit) = name;
+}
+
 static int is_better_name(struct rev_name *name,
 			  const char *tip_name,
 			  timestamp_t taggerdate,
@@ -65,7 +81,7 @@ static void name_rev(struct commit *commit,
 		int generation, int distance, int from_tag,
 		int deref)
 {
-	struct rev_name *name = (struct rev_name *)commit->util;
+	struct rev_name *name = get_commit_rev_name(commit);
 	struct commit_list *parents;
 	int parent_number = 1;
 	char *to_free = NULL;
@@ -84,7 +100,7 @@ static void name_rev(struct commit *commit,
 
 	if (name == NULL) {
 		name = xmalloc(sizeof(rev_name));
-		commit->util = name;
+		set_commit_rev_name(commit, name);
 		goto copy_data;
 	} else if (is_better_name(name, tip_name, taggerdate,
 				  generation, distance, from_tag)) {
@@ -296,7 +312,7 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (o->type != OBJ_COMMIT)
 		return get_exact_ref_match(o);
 	c = (struct commit *) o;
-	n = c->util;
+	n = get_commit_rev_name(c);
 	if (!n)
 		return NULL;
 
@@ -413,6 +429,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	init_commit_rev_name(&rev_names);
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
 	if (all + transform_stdin + !!argc > 1) {
-- 
2.17.0.705.g3525833791

