Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F5E202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdGHUkU (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 16:40:20 -0400
Received: from mail.eclipso.de ([217.69.254.104]:48984 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdGHUkT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 16:40:19 -0400
Received: from localhost.localdomain (136.ip-92-222-84.eu [92.222.84.136])
        by mail.eclipso.de with ESMTPS id 1CA860F7
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 22:35:15 +0200 (CEST)
X-ESMTP-Authenticated-User: 00022B69
From:   astian <astian@eclipso.at>
To:     git@vger.kernel.org
Cc:     astian <astian@eclipso.at>
Subject: [PATCH 3/4] Doc/git-send-email.txt: clarify a couple of options
Date:   Sat,  8 Jul 2017 20:34:12 +0000
Message-Id: <20170708203413.16442-4-astian@eclipso.at>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170708203413.16442-1-astian@eclipso.at>
References: <20170708203413.16442-1-astian@eclipso.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify the meaning of --smtp-encryption and --smtp-server-option.

Signed-off-by: astian <astian@eclipso.at>
---
 Documentation/git-send-email.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index bac9014ac..158b51045 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -161,7 +161,8 @@ Sending
 	unspecified, choosing the envelope sender is left to your MTA.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
+	Specify the encryption to use, either 'ssl' (direct TLS) or
+	'tls' (plain text upgraded to TLS via STARTTLS).  Any other
 	value reverts to plain SMTP.  Default is the value of
 	`sendemail.smtpEncryption`.
 
@@ -216,13 +217,15 @@ a password is obtained using 'git-credential'.
 	`sendemail.smtpServerPort` configuration variable.
 
 --smtp-server-option=<option>::
-	If set, specifies the outgoing SMTP server option to use.
+	Specifies a command line option to pass to the local sendmail-like
+	binary.  Only useful when `--smtp-server` (or `sendemail.smtpServer`)
+	points to a local absolute path corresponding to the program binary.
 	Default value can be specified by the `sendemail.smtpServerOption`
-	configuration option.
+	configuration variable.
 +
-The --smtp-server-option option must be repeated for each option you want
-to pass to the server. Likewise, different lines in the configuration files
-must be used for each option.
+This option must be used once for each command line argument you want to pass
+to the program.  Correspondingly, the configuration variable is multivalued:
+set it, in order, once per command line argument.
 
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption ssl'.
-- 
2.13.2



