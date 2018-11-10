Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D01E1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeKJPcf (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:32:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34158 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbeKJPcf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:32:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so3386806ljd.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhbCYGASniDW1U0xw1uPf5kqCdgNyEcxbXAcgyq59hE=;
        b=m/B8WzOJ5oO9qivSREboMv0Wys+KVC3O45EltHHIJn8/bjKyMyuzlCxkwX3tYZS3sF
         mPUJovSngDucZRXgpTQ+lFGVW6Z1gb3YSdBimQlLH4seBUeqfNi6gWmT8Mw8niNZElPO
         xnRvshKfYkSsu03ombq37/pHZyWiFEhx3823ZxN3Zb9V5QiSDXi/QuIQn7cWxCfbwtUr
         XukY3WKfMKCYQCEhka/yYsKO++NptxkiRaI8q4zqbN+E1SlUWCysJ7rkyaMShEyxZNNJ
         5UUOqnW8mHhw1MOpJdCTwiYaq5DDm1o2pexl2siLY6ngv3Wp9PJf3zVB0Ou6GeVMzRpS
         MPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhbCYGASniDW1U0xw1uPf5kqCdgNyEcxbXAcgyq59hE=;
        b=PCoDF/O7MbjHypX7W5w3Oq6I8UCcIJww5b9VKbr0MJQEzKoP50zqerYBF7fNOj8RBL
         uqP7DN5REr9WI3A689d0oxZnz8HP1KsMz5L1GpdcsBGPQRFcJ4uDIt5Ln28vuqWdV0bH
         HQfnXx7Y9rpfdMmCm4e25xtv9ifGZZT3Dr2Vm0MeDZnb89JmyOFQYCxRvDTGbL1U/QM6
         T7BkrS46SvHokW8It3NyFbdZLOry9qsUcKo2FC7nI87fCUuZZO27XvjucHoLfhyDM7vk
         mWQPMlpO8N70KRK0ItQpHVhjgLrAcUvFQfZGnBZdrnS6kmS1ixuspz9xtlfY4ttvQgO5
         caYQ==
X-Gm-Message-State: AGRZ1gLc+tULUc0IuWN7tJfAcrqDP5eCtZDJhQjiNcbXz3cIjfFn4Fdn
        j55M1SXmH18LQ71QxO2N7YJ1yQr7
X-Google-Smtp-Source: AJdET5dULLCskaeXPFs8WXriu7DtR8UzvgG4zfNVQKZwG6sPfbbP864/5dPxvc+sP3FrKW72tiXdKA==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr6266125ljo.10.1541826991234;
        Fri, 09 Nov 2018 21:16:31 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:30 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 08/16] reflog: mark strings for translation
Date:   Sat, 10 Nov 2018 06:16:07 +0100
Message-Id: <20181110051615.8641-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One string "nothing to delete?" is rephrased to be more helpful.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/reflog.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b5941c1ff3..5a74ccf7ab 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -13,11 +13,15 @@
 
 /* NEEDSWORK: switch to using parse_options */
 static const char reflog_expire_usage[] =
-"git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
+N_("git reflog expire [--expire=<time>] "
+   "[--expire-unreachable=<time>] "
+   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
+   "[--verbose] [--all] <refs>...");
 static const char reflog_delete_usage[] =
-"git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
+N_("git reflog delete [--rewrite] [--updateref] "
+   "[--dry-run | -n] [--verbose] <refs>...");
 static const char reflog_exists_usage[] =
-"git reflog exists <ref>";
+N_("git reflog exists <ref>");
 
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
+		return error(_("no reflog specified to delete"));
 
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
+N_("git reflog [ show | expire | delete | exists ]");
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
 	if (argc > 1 && !strcmp(argv[1], "-h"))
-		usage(reflog_usage);
+		usage(_(reflog_usage));
 
 	/* With no command, we default to showing it. */
 	if (argc < 2 || *argv[1] == '-')
-- 
2.19.1.1231.g84aef82467

