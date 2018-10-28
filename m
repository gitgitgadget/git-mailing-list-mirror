Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0C91F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJ1Pfz (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38828 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJ1Pfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id p86so1524024lfg.5
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvvMgAJSeswtJBb3pPBlLR8926Q83KYihev9/fULTWM=;
        b=C6qPZB36tc/a3OUrfZonQdaMSlB/UJSB0gRexNLQ2P8QflxqQMdxlo+Zs0kiZMx7pm
         z0FQMlUDwDzA1T+P2XEP0Kj13q4bUt3q7+YUXjWt3yvOHVb9T3l+Lu/H+p0yX8hj2Mw3
         ps+j4CD37m1zPQzdw6cmPPRY8g4ZDh+7CJE80UPZmZ0OCoU9mEq0cUAVu0itd3nYEK+s
         7CVufh2eOh5Xr/p/4sjZnHOUg4m9vdf74hqmladsOnnfbpw59jOQmazyegbVuc0wfhST
         g+L9B7xy+wF+BoGp0olyS/9a4ty7j3QvEe9/RNiA6sQ984/vYpgg7mam6Oqizjyy0WFW
         nA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvvMgAJSeswtJBb3pPBlLR8926Q83KYihev9/fULTWM=;
        b=JEDG/Xowi0fe3ryYZuR4upzEfEyXRo5ctHQPjJ9+cFoZxyu19WcD414wJtBB/aXQuX
         M4Y2Jf+uhLzfshOjHzOLMMia8BW3WwLqPb/BvhE6hU4HJ2iG7SAuUY5Q3tci90r/9/39
         gDWCXN30rola7yihEmXqbiOnoZSxifAldFtD8l+N51KduzhHs9YA3B8LCGUpBhbxQwaO
         Op+jVMQf+/B8sgyXIjgNqmlD90LpLTxuY/qp9I8gakW+5+CHvzC8rUVDBoDkwtLNqRaq
         6rjJ71PCDpuFFzyWrJ40CFcjtPDymZMAlT0CMjnKBDae1SGGnGdohyj5TCfhrVkVqOoe
         0EXQ==
X-Gm-Message-State: AGRZ1gJ82dEmzTn+/zjjAtDjnANEumoERm3LaxRdLZfG7WFEdsCwoU+B
        tLcAfYnDGOzjUPl4n2yXlzpMV3Vs
X-Google-Smtp-Source: AJdET5f8ef/HfAbpCo+DZ/dnL1/xs+jq892mCAa8grEKanp1gKn7P9dOOIPmebph7WLBpQn7FJHl9A==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr5254388lfk.155.1540709529908;
        Sat, 27 Oct 2018 23:52:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/12] reflog: mark strings for translation
Date:   Sun, 28 Oct 2018 07:51:52 +0100
Message-Id: <20181028065157.26727-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/reflog.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b5941c1ff3..33cb20b7d8 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,11 +13,15 @@
 
 /* NEEDSWORK: switch to using parse_options */
 static const char reflog_expire_usage[] =
-"git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
+	N_("git reflog expire [--expire=<time>] "
+	   "[--expire-unreachable=<time>] "
+	   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
+	   "[--verbose] [--all] <refs>...");
 static const char reflog_delete_usage[] =
-"git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
+	N_("git reflog delete [--rewrite] [--updateref] "
+	   "[--dry-run | -n] [--verbose] <refs>...");
 static const char reflog_exists_usage[] =
-"git reflog exists <ref>";
+	N_("git reflog exists <ref>");
 
 static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
@@ -556,7 +560,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			break;
 		}
 		else if (arg[0] == '-')
-			usage(reflog_expire_usage);
+			usage(_(reflog_expire_usage));
 		else
 			break;
 	}
@@ -569,7 +573,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	if (cb.cmd.stalefix) {
 		repo_init_revisions(the_repository, &cb.cmd.revs, prefix);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
-			printf("Marking reachable objects...");
+			printf(_("Marking reachable objects..."));
 		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
 		if (flags & EXPIRE_REFLOGS_VERBOSE)
 			putchar('\n');
@@ -598,7 +602,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		char *ref;
 		struct object_id oid;
 		if (!dwim_log(argv[i], strlen(argv[i]), &oid, &ref)) {
-			status |= error("%s points nowhere!", argv[i]);
+			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
@@ -644,13 +648,13 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			break;
 		}
 		else if (arg[0] == '-')
-			usage(reflog_delete_usage);
+			usage(_(reflog_delete_usage));
 		else
 			break;
 	}
 
 	if (argc - i < 1)
-		return error("Nothing to delete?");
+		return error(_("nothing to delete?"));
 
 	for ( ; i < argc; i++) {
 		const char *spec = strstr(argv[i], "@{");
@@ -659,12 +663,12 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		int recno;
 
 		if (!spec) {
-			status |= error("Not a reflog: %s", argv[i]);
+			status |= error(_("not a reflog: %s"), argv[i]);
 			continue;
 		}
 
 		if (!dwim_log(argv[i], spec - argv[i], &oid, &ref)) {
-			status |= error("no reflog for '%s'", argv[i]);
+			status |= error(_("no reflog for '%s'"), argv[i]);
 			continue;
 		}
 
@@ -699,7 +703,7 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
 			break;
 		}
 		else if (arg[0] == '-')
-			usage(reflog_exists_usage);
+			usage(_(reflog_exists_usage));
 		else
 			break;
 	}
@@ -707,10 +711,10 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
 	start = i;
 
 	if (argc - start != 1)
-		usage(reflog_exists_usage);
+		usage(_(reflog_exists_usage));
 
 	if (check_refname_format(argv[start], REFNAME_ALLOW_ONELEVEL))
-		die("invalid ref format: %s", argv[start]);
+		die(_("invalid ref format: %s"), argv[start]);
 	return !reflog_exists(argv[start]);
 }
 
@@ -719,12 +723,12 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
  */
 
 static const char reflog_usage[] =
-"git reflog [ show | expire | delete | exists ]";
+	N_("git reflog [ show | expire | delete | exists ]");
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
 	if (argc > 1 && !strcmp(argv[1], "-h"))
-		usage(reflog_usage);
+		usage(_(reflog_usage));
 
 	/* With no command, we default to showing it. */
 	if (argc < 2 || *argv[1] == '-')
-- 
2.19.1.647.g708186aaf9

