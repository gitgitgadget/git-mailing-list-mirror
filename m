Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB9C1F859
	for <e@80x24.org>; Mon,  8 Aug 2016 11:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbcHHLRI (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 07:17:08 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:39068 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752063AbcHHLRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 07:17:05 -0400
Received: (qmail 12879 invoked from network); 8 Aug 2016 11:17:02 -0000
Received: (qmail 5619 invoked from network); 8 Aug 2016 11:17:02 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Aug 2016 11:17:00 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/3] i18n: archive: mark errors for translation
Date:	Mon,  8 Aug 2016 11:16:00 +0000
Message-Id: <1470654961-2842-2-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1470654961-2842-1-git-send-email-vascomalmeida@sapo.pt>
References: <1470654961-2842-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 archive.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/archive.c b/archive.c
index 42df974..dde1ab4 100644
--- a/archive.c
+++ b/archive.c
@@ -458,11 +458,11 @@ static int parse_archive_args(int argc, const char **argv,
 	argc = parse_options(argc, argv, NULL, opts, archive_usage, 0);
 
 	if (remote)
-		die("Unexpected option --remote");
+		die(_("Unexpected option --remote"));
 	if (exec)
-		die("Option --exec can only be used together with --remote");
+		die(_("Option --exec can only be used together with --remote"));
 	if (output)
-		die("Unexpected option --output");
+		die(_("Unexpected option --output"));
 
 	if (!base)
 		base = "";
@@ -484,14 +484,14 @@ static int parse_archive_args(int argc, const char **argv,
 		usage_with_options(archive_usage, opts);
 	*ar = lookup_archiver(format);
 	if (!*ar || (is_remote && !((*ar)->flags & ARCHIVER_REMOTE)))
-		die("Unknown archive format '%s'", format);
+		die(_("Unknown archive format '%s'"), format);
 
 	args->compression_level = Z_DEFAULT_COMPRESSION;
 	if (compression_level != -1) {
 		if ((*ar)->flags & ARCHIVER_WANT_COMPRESSION_LEVELS)
 			args->compression_level = compression_level;
 		else {
-			die("Argument not supported for format '%s': -%d",
+			die(_("Argument not supported for format '%s': -%d"),
 					format, compression_level);
 		}
 	}
-- 
2.7.4

