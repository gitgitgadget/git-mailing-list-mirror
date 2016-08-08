Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CBA11F859
	for <e@80x24.org>; Mon,  8 Aug 2016 11:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbcHHLRF (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 07:17:05 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:44957 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752116AbcHHLRC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 07:17:02 -0400
Received: (qmail 19679 invoked from network); 8 Aug 2016 11:17:00 -0000
Received: (qmail 4993 invoked from network); 8 Aug 2016 11:17:00 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Aug 2016 11:16:55 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/3] i18n: setup: mark error messages for translation
Date:	Mon,  8 Aug 2016 11:15:59 +0000
Message-Id: <1470654961-2842-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 setup.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/setup.c b/setup.c
index 6d0e0c9..fe572b8 100644
--- a/setup.c
+++ b/setup.c
@@ -759,9 +759,9 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 static const char *setup_nongit(const char *cwd, int *nongit_ok)
 {
 	if (!nongit_ok)
-		die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
+		die(_("Not a git repository (or any of the parent directories): %s"), DEFAULT_GIT_DIR_ENVIRONMENT);
 	if (chdir(cwd))
-		die_errno("Cannot come back to cwd");
+		die_errno(_("Cannot come back to cwd"));
 	*nongit_ok = 1;
 	return NULL;
 }
@@ -842,7 +842,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		*nongit_ok = 0;
 
 	if (strbuf_getcwd(&cwd))
-		die_errno("Unable to read current working directory");
+		die_errno(_("Unable to read current working directory"));
 	offset = cwd.len;
 
 	/*
@@ -912,19 +912,19 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 			if (parent_device != current_device) {
 				if (nongit_ok) {
 					if (chdir(cwd.buf))
-						die_errno("Cannot come back to cwd");
+						die_errno(_("Cannot come back to cwd"));
 					*nongit_ok = 1;
 					return NULL;
 				}
 				strbuf_setlen(&cwd, offset);
-				die("Not a git repository (or any parent up to mount point %s)\n"
-				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).",
+				die(_("Not a git repository (or any parent up to mount point %s)\n"
+				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
 				    cwd.buf);
 			}
 		}
 		if (chdir("..")) {
 			strbuf_setlen(&cwd, offset);
-			die_errno("Cannot change to '%s/..'", cwd.buf);
+			die_errno(_("Cannot change to '%s/..'"), cwd.buf);
 		}
 		offset = offset_parent;
 	}
@@ -986,9 +986,9 @@ int git_config_perm(const char *var, const char *value)
 	/* A filemode value was given: 0xxx */
 
 	if ((i & 0600) != 0600)
-		die("Problem with core.sharedRepository filemode value "
+		die(_("Problem with core.sharedRepository filemode value "
 		    "(0%.3o).\nThe owner of files must always have "
-		    "read and write permissions.", i);
+		    "read and write permissions."), i);
 
 	/*
 	 * Mask filemode value. Others can not get write permission.
-- 
2.7.4

