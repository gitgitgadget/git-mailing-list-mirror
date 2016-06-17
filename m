Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706C81FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbcFQUYH (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:07 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52061 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932065AbcFQUYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:06 -0400
Received: (qmail 23516 invoked from network); 17 Jun 2016 20:24:04 -0000
Received: (qmail 1223 invoked from network); 17 Jun 2016 20:24:04 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:23:58 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 04/38] i18n: transport: mark strings for translation
Date:	Fri, 17 Jun 2016 20:20:53 +0000
Message-Id: <1466194887-18236-5-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark one printf string and one error string for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 transport.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/transport.c b/transport.c
index 095e61f..59b911e 100644
--- a/transport.c
+++ b/transport.c
@@ -59,7 +59,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 				localname + 11, transport->remote->name,
 				remotename);
 		else
-			printf("Would set upstream of '%s' to '%s' of '%s'\n",
+			printf(_("Would set upstream of '%s' to '%s' of '%s'\n"),
 				localname + 11, remotename + 11,
 				transport->remote->name);
 	}
@@ -148,7 +148,7 @@ static int set_git_option(struct git_transport_options *opts,
 			char *end;
 			opts->depth = strtol(value, &end, 0);
 			if (*end)
-				die("transport: invalid depth option '%s'", value);
+				die(_("transport: invalid depth option '%s'"), value);
 		}
 		return 0;
 	}
@@ -767,19 +767,19 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 {
 	int i;
 
-	fprintf(stderr, "The following submodule paths contain changes that can\n"
-			"not be found on any remote:\n");
+	fprintf(stderr, _("The following submodule paths contain changes that can\n"
+			"not be found on any remote:\n"));
 	for (i = 0; i < needs_pushing->nr; i++)
 		printf("  %s\n", needs_pushing->items[i].string);
-	fprintf(stderr, "\nPlease try\n\n"
-			"	git push --recurse-submodules=on-demand\n\n"
-			"or cd to the path and use\n\n"
-			"	git push\n\n"
-			"to push them to a remote.\n\n");
+	fprintf(stderr, _("\nPlease try\n\n"
+			  "	git push --recurse-submodules=on-demand\n\n"
+			  "or cd to the path and use\n\n"
+			  "	git push\n\n"
+			  "to push them to a remote.\n\n"));
 
 	string_list_clear(needs_pushing, 0);
 
-	die("Aborting.");
+	die(_("Aborting."));
 }
 
 static int run_pre_push_hook(struct transport *transport,
-- 
2.6.6

