Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346D7209A9
	for <e@80x24.org>; Mon, 17 Oct 2016 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755267AbcJQNRg (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 09:17:36 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:50944 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754646AbcJQNQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 09:16:16 -0400
Received: (qmail 23278 invoked from network); 17 Oct 2016 13:16:13 -0000
Received: (qmail 13531 invoked from network); 17 Oct 2016 13:16:13 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Oct 2016 13:16:11 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 3/4] i18n: credential-cache--daemon: mark advice for translation
Date:   Mon, 17 Oct 2016 13:15:28 +0000
Message-Id: <20161017131529.27856-3-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.459.g5fd885d
In-Reply-To: <20161017131529.27856-1-vascomalmeida@sapo.pt>
References: <20161017131529.27856-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark permissions_advice for translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 credential-cache--daemon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 1e5f16a..46c5937 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -219,11 +219,11 @@ static void serve_cache(const char *socket_path, int debug)
 	close(fd);
 }
 
-static const char permissions_advice[] =
+static const char permissions_advice[] = N_(
 "The permissions on your socket directory are too loose; other\n"
 "users may be able to read your cached credentials. Consider running:\n"
 "\n"
-"	chmod 0700 %s";
+"	chmod 0700 %s");
 static void init_socket_directory(const char *path)
 {
 	struct stat st;
@@ -232,7 +232,7 @@ static void init_socket_directory(const char *path)
 
 	if (!stat(dir, &st)) {
 		if (st.st_mode & 077)
-			die(permissions_advice, dir);
+			die(_(permissions_advice), dir);
 	} else {
 		/*
 		 * We must be sure to create the directory with the correct mode,
-- 
2.10.1.459.g5fd885d

