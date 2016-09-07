Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5AB1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757160AbcIGOwP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 10:52:15 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:59454 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757035AbcIGOuq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 10:50:46 -0400
Received: (qmail 31089 invoked from network); 7 Sep 2016 14:50:42 -0000
Received: (qmail 1995 invoked from network); 7 Sep 2016 14:50:40 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Sep 2016 14:50:38 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/13] i18n: merge-recursive: mark error messages for translation
Date:   Wed,  7 Sep 2016 14:49:11 +0000
Message-Id: <1473259758-11836-7-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lowercase first word of such error messages following the usual style.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/merge-recursive.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index fd2c455..0bc88a7 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -42,30 +42,30 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 			if (!arg[2])
 				break;
 			if (parse_merge_opt(&o, arg + 2))
-				die("Unknown option %s", arg);
+				die(_("unknown option %s"), arg);
 			continue;
 		}
 		if (bases_count < ARRAY_SIZE(bases)-1) {
 			struct object_id *oid = xmalloc(sizeof(struct object_id));
 			if (get_oid(argv[i], oid))
-				die("Could not parse object '%s'", argv[i]);
+				die(_("could not parse object '%s'"), argv[i]);
 			bases[bases_count++] = oid;
 		}
 		else
-			warning("Cannot handle more than %d bases. "
-				"Ignoring %s.",
+			warning(_("cannot handle more than %d bases. "
+				  "Ignoring %s."),
 				(int)ARRAY_SIZE(bases)-1, argv[i]);
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
-		die("Not handling anything other than two heads merge.");
+		die(_("not handling anything other than two heads merge."));
 
 	o.branch1 = argv[++i];
 	o.branch2 = argv[++i];
 
 	if (get_oid(o.branch1, &h1))
-		die("Could not resolve ref '%s'", o.branch1);
+		die(_("could not resolve ref '%s'"), o.branch1);
 	if (get_oid(o.branch2, &h2))
-		die("Could not resolve ref '%s'", o.branch2);
+		die(_("could not resolve ref '%s'"), o.branch2);
 
 	o.branch1 = better_branch_name(o.branch1);
 	o.branch2 = better_branch_name(o.branch2);
-- 
2.7.4

