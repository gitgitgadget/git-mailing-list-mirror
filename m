From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 04/39] i18n: transport: mark strings for translation
Date: Wed,  1 Jun 2016 16:40:54 +0000
Message-ID: <1464799289-7639-5-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:43:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89El-0004Ip-G9
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161539AbcFAQmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:42:53 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:46254 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932631AbcFAQmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:42:52 -0400
Received: (qmail 10381 invoked from network); 1 Jun 2016 16:42:48 -0000
Received: (qmail 5410 invoked from network); 1 Jun 2016 16:42:48 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:42:46 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296100>

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
2.7.3
