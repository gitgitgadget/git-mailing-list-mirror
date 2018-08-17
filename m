Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C691F954
	for <e@80x24.org>; Fri, 17 Aug 2018 13:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHQQGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 12:06:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39390 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeHQQGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 12:06:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so7349956wmq.4
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJliRksLZpO8Wx8mDiANeOtLp2fPs099JQvGKgnHV70=;
        b=p+e3nL66CFRA+gz/9kjMKL6zP/RaoGEoEdMzE4AbGvz8E/ydsXbPCU2UkHgGZ7Iemc
         m4v2rK92CcCwJrcCMAn732INnPxjA4sUTlXsnY/PSaECeCvFVnIWJEd0n3DwHkmsWlYK
         IS83HY/Qm1Suyf9/CTVWSbamOYzpcTVhbyDbhms3gYaMzex4Lu38ulE+VnkhevZLH/DJ
         2ONUcbJziEfOLm1ug5dPSiV4MR7oXYblVGnllBbHk/aUhdUc0bVU7dsWc1/CUtI3lWa0
         gw4iCjMDaNswhqvats3iaLDQ0cYDw0J2s3iBO4PJyJ2vVNYte5wmlpDDFyOTy5oPSwzW
         xi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJliRksLZpO8Wx8mDiANeOtLp2fPs099JQvGKgnHV70=;
        b=ijHXFLOuOH4sBGVrO4tkJtfOFBX8O9SN6LisITuF5KNCorJFy1PsPdK04IxzUV676D
         8WDnfrYq2Z+XWMVOu/n2cVbg38ILKhjRbZYwiG642pd4uuLirrzOw6uOzj6BCo3mB9rD
         6Ad/dJlbu+Zk1gL1234Iaqvwxmplxi15hs+b+7e5f9SxNF0xI4gCswpjntkzqfz0clpk
         t4HVW4N2hzEwlB6fxDZtz/B6P1nhDFDa/tUdUb7G8VXSJslvppXGvj0/rxDygeCiGj4I
         WqP+1AQTBIKXLHj44BXOFyST+dXNe2v72+Qt/OZeafNOUfGYi4qLvWRO2uAQOe7hO8Z4
         UxRA==
X-Gm-Message-State: AOUpUlFJCTOzzyJ7cBWm0RWO0tYfgggK3gPjRXs8nomJzA5ThS6jg8oZ
        Z6Uscd9l1S1jYp0leIeTY8bFLtj1zYM=
X-Google-Smtp-Source: AA+uWPwDO3XyS6TltNfiT2kNBCwRKNSyWVgInTdnTckwhIGfX5pfw3i63EaUF4Ps8qyddiaeQO9kYA==
X-Received: by 2002:a1c:9945:: with SMTP id b66-v6mr18288699wme.159.1534510979242;
        Fri, 17 Aug 2018 06:02:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q188-v6sm6836371wmd.36.2018.08.17.06.02.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 06:02:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] refactor various if (x) FREE_AND_NULL(x) to just FREE_AND_NULL(x)
Date:   Fri, 17 Aug 2018 13:02:50 +0000
Message-Id: <20180817130250.20354-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <1534498806.1262.8.camel@gentoo.org>
References: <1534498806.1262.8.camel@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the few conditional uses of FREE_AND_NULL(x) to be
unconditional. As noted in the standard[1] free(NULL) is perfectly
valid, so we might as well leave this check up to the C library.

1. http://pubs.opengroup.org/onlinepubs/9699919799/functions/free.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Let's do the opposite of this instead.

 blame.c     | 4 +---
 branch.c    | 4 +---
 http.c      | 4 +---
 tree-diff.c | 4 +---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/blame.c b/blame.c
index 58a7036847..b22a95de7b 100644
--- a/blame.c
+++ b/blame.c
@@ -334,9 +334,7 @@ static void fill_origin_blob(struct diff_options *opt,
 
 static void drop_origin_blob(struct blame_origin *o)
 {
-	if (o->file.ptr) {
-		FREE_AND_NULL(o->file.ptr);
-	}
+	FREE_AND_NULL(o->file.ptr);
 }
 
 /*
diff --git a/branch.c b/branch.c
index ecd710d730..776f55fc66 100644
--- a/branch.c
+++ b/branch.c
@@ -25,9 +25,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			tracking->remote = remote->name;
 		} else {
 			free(tracking->spec.src);
-			if (tracking->src) {
-				FREE_AND_NULL(tracking->src);
-			}
+			FREE_AND_NULL(tracking->src);
 		}
 		tracking->spec.src = NULL;
 	}
diff --git a/http.c b/http.c
index b4bfbceaeb..4162860ee3 100644
--- a/http.c
+++ b/http.c
@@ -2418,9 +2418,7 @@ void release_http_object_request(struct http_object_request *freq)
 		close(freq->localfile);
 		freq->localfile = -1;
 	}
-	if (freq->url != NULL) {
-		FREE_AND_NULL(freq->url);
-	}
+	FREE_AND_NULL(freq->url);
 	if (freq->slot != NULL) {
 		freq->slot->callback_func = NULL;
 		freq->slot->callback_data = NULL;
diff --git a/tree-diff.c b/tree-diff.c
index fe2e466ac1..553bc0e63a 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -557,9 +557,7 @@ struct combine_diff_path *diff_tree_paths(
 	 * free pre-allocated last element, if any
 	 * (see path_appendnew() for details about why)
 	 */
-	if (p->next) {
-		FREE_AND_NULL(p->next);
-	}
+	FREE_AND_NULL(p->next);
 
 	return p;
 }
-- 
2.18.0.865.gffc8e1a3cd6

