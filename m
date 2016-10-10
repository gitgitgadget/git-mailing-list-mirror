Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A7420986
	for <e@80x24.org>; Mon, 10 Oct 2016 12:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbcJJMzw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 08:55:52 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:37546 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752218AbcJJMzv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 08:55:51 -0400
Received: (qmail 11409 invoked from network); 10 Oct 2016 12:55:49 -0000
Received: (qmail 15349 invoked from network); 10 Oct 2016 12:55:49 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 10 Oct 2016 12:55:44 -0000
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
Subject: [PATCH v4 04/14] i18n: clean.c: match string with git-add--interactive.perl
Date:   Mon, 10 Oct 2016 12:54:39 +0000
Message-Id: <20161010125449.7929-5-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.396.g621fe23
In-Reply-To: <20161010125449.7929-1-vascomalmeida@sapo.pt>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
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
index 0371010..d6bc3aa 100644
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
2.7.4

