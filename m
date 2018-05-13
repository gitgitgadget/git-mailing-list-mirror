Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94201F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeEMFwc (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41375 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeEMFw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id m17-v6so8218607lfj.8
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqGeNKNj44iiILMTAZw/VQug82Tcoy3TG9cEYUxTO9o=;
        b=m8pzoXWf6I+xggegBFnq0B6J4Erki1x9qLTjKPF0rdykmM5yTBbs2Vfcd7Ju37toK3
         xYwpirPc7nYFjcqKEo/kzAzY0r227ejVFq8qmkMhoVkxhPjxxuOQ/ayuOFXHXcKz6oHH
         20Rf1SWKlTOgRrqjqXKZ2u+G8IYcY1JFL0D3r+4ad5gW9LdF27grLPJzwrMY8e+XvraA
         cCemg4NtSnVDlEyV1bMG2Gri/BG/0g+kzScBDcGyL3pDSBixjRqHOUtqow61RuPUP44C
         FBrDq48dQKuj6i+UkR2abza8aTY0VHl8FZ+XXtQr+vXXAc8LLktha1IMus2MRuJ0NNJk
         vhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqGeNKNj44iiILMTAZw/VQug82Tcoy3TG9cEYUxTO9o=;
        b=SiAkLySrumIfAgvIymqxBb5JdLpJH6auN9WnUHVt6ubM+aFWhakESfCaKCQbMSrWH4
         1nu6M30kB+E/pYShbaK8v0sqkYW/xLmB3T86OXWdNexaw4JZoMCY82e5KMuNL4hkgfPw
         AcDJEO2FHDE+bTrP5BLfIYCK/bW9xyHRBodUe/1h1MSmY1nRyp0XU57aahqx4rTnZLZq
         +Ul7ioc4q7faZ8luoJorRCjoI4Rh1HIuPW2juHVnDg6BbHa/4esgB1hE2wUmFnAiZICL
         vgH5wTh/Am5FV1lPilRnU9XpRW8doTTu0TCwZc9IyZUnF1k84lQPZPDrQm+I3aKGr48E
         TBjg==
X-Gm-Message-State: ALKqPwe6sKK30zlAHnysBeLPJJqLof+6/la+imEE+jozCk0dXKnQyRRD
        FQslGAMgn42aU4aFj9cW5iX0MQ==
X-Google-Smtp-Source: AB8JxZoleMlFljVFmMtEZQLHd0J2TgKKD4Gv7MjuvpOG1m1Izo8066AE2aPonZsGAgKVUB2W1bUTfQ==
X-Received: by 2002:a2e:9ac3:: with SMTP id p3-v6mr1956460ljj.60.1526190747338;
        Sat, 12 May 2018 22:52:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 12/14] log: use commit-slab in prepare_bases() instead of commit->util
Date:   Sun, 13 May 2018 07:52:06 +0200
Message-Id: <20180513055208.17952-13-pclouds@gmail.com>
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
 builtin/log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d017e57475..967fbc5caa 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -28,6 +28,7 @@
 #include "mailmap.h"
 #include "gpg-interface.h"
 #include "progress.h"
+#include "commit-slab.h"
 
 #define MAIL_DEFAULT_WRAP 72
 
@@ -1340,6 +1341,8 @@ static struct commit *get_base_commit(const char *base_commit,
 	return base;
 }
 
+define_commit_slab(commit_base, int);
+
 static void prepare_bases(struct base_tree_info *bases,
 			  struct commit *base,
 			  struct commit **list,
@@ -1348,11 +1351,13 @@ static void prepare_bases(struct base_tree_info *bases,
 	struct commit *commit;
 	struct rev_info revs;
 	struct diff_options diffopt;
+	struct commit_base commit_base;
 	int i;
 
 	if (!base)
 		return;
 
+	init_commit_base(&commit_base);
 	diff_setup(&diffopt);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
@@ -1365,7 +1370,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	for (i = 0; i < total; i++) {
 		list[i]->object.flags &= ~UNINTERESTING;
 		add_pending_object(&revs, &list[i]->object, "rev_list");
-		list[i]->util = (void *)1;
+		*commit_base_at(&commit_base, list[i]) = 1;
 	}
 	base->object.flags |= UNINTERESTING;
 	add_pending_object(&revs, &base->object, "base");
@@ -1379,7 +1384,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object_id oid;
 		struct object_id *patch_id;
-		if (commit->util)
+		if (*commit_base_at(&commit_base, commit))
 			continue;
 		if (commit_patch_id(commit, &diffopt, &oid, 0))
 			die(_("cannot get patch id"));
@@ -1388,6 +1393,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		oidcpy(patch_id, &oid);
 		bases->nr_patch_id++;
 	}
+	clear_commit_base(&commit_base);
 }
 
 static void print_bases(struct base_tree_info *bases, FILE *file)
-- 
2.17.0.705.g3525833791

