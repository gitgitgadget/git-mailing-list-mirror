Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26FA1FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 12:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755478AbcLNMzp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 07:55:45 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:56612 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755608AbcLNMzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 07:55:43 -0500
Received: (qmail 2107 invoked from network); 14 Dec 2016 12:55:40 -0000
Received: (qmail 26790 invoked from network); 14 Dec 2016 12:55:40 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 14 Dec 2016 12:55:39 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 05/16] i18n: clean.c: match string with git-add--interactive.perl
Date:   Wed, 14 Dec 2016 11:54:28 -0100
Message-Id: <20161214125439.8822-6-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.44.g7d42c6c
In-Reply-To: <20161214125439.8822-1-vascomalmeida@sapo.pt>
References: <20161214125439.8822-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change strings for help to match the ones in git-add--interactive.perl.
The strings now represent one entry to translate each rather then two
entries each different only by an ending newline character.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/clean.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 0371010af..d6bc3aaae 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -287,11 +287,11 @@ static void pretty_print_menus(struct string_list *menu_list)
 static void prompt_help_cmd(int singleton)
 {
 	clean_print_color(CLEAN_COLOR_HELP);
-	printf_ln(singleton ?
+	printf(singleton ?
 		  _("Prompt help:\n"
 		    "1          - select a numbered item\n"
 		    "foo        - select item based on unique prefix\n"
-		    "           - (empty) select nothing") :
+		    "           - (empty) select nothing\n") :
 		  _("Prompt help:\n"
 		    "1          - select a single item\n"
 		    "3-5        - select a range of items\n"
@@ -299,7 +299,7 @@ static void prompt_help_cmd(int singleton)
 		    "foo        - select item based on unique prefix\n"
 		    "-...       - unselect specified items\n"
 		    "*          - choose all items\n"
-		    "           - (empty) finish selecting"));
+		    "           - (empty) finish selecting\n"));
 	clean_print_color(CLEAN_COLOR_RESET);
 }
 
@@ -508,7 +508,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
 		    (is_single && bottom != top)) {
 			clean_print_color(CLEAN_COLOR_ERROR);
-			printf_ln(_("Huh (%s)?"), (*ptr)->buf);
+			printf(_("Huh (%s)?\n"), (*ptr)->buf);
 			clean_print_color(CLEAN_COLOR_RESET);
 			continue;
 		}
@@ -774,7 +774,7 @@ static int ask_each_cmd(void)
 static int quit_cmd(void)
 {
 	string_list_clear(&del_list, 0);
-	printf_ln(_("Bye."));
+	printf(_("Bye.\n"));
 	return MENU_RETURN_NO_LOOP;
 }
 
-- 
2.11.0.44.g7d42c6c

