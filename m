From: david@statichacks.org
Subject: [PATCH 4/4] Changed timestamps to time_t
Date: Thu,  6 Nov 2008 09:48:48 -0800
Message-ID: <1225993728-4779-5-git-send-email-david@statichacks.org>
References: <1225993728-4779-1-git-send-email-david@statichacks.org>
 <1225993728-4779-2-git-send-email-david@statichacks.org>
 <1225993728-4779-3-git-send-email-david@statichacks.org>
 <1225993728-4779-4-git-send-email-david@statichacks.org>
Cc: David Bryson <david@statichacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:50:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8zh-0005K1-IC
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbYKFRsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbYKFRsx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:48:53 -0500
Received: from cryptobackpack.org ([64.105.32.74]:38691 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYKFRsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:48:52 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 43E5410D0267; Thu,  6 Nov 2008 09:48:51 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id A158810D0271;
	Thu,  6 Nov 2008 09:48:50 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 928AC144A9; Thu,  6 Nov 2008 09:48:48 -0800 (PST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1225993728-4779-4-git-send-email-david@statichacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100255>

From: David Bryson <david@statichacks.org>

Some static values and return codes from approxidate()
have now been changed from unsigned long to time_t
---
 builtin-reflog.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index fdf78a9..f8ee25a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -17,8 +17,8 @@ static const char reflog_expire_usage[] =
 static const char reflog_delete_usage[] =
 "git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
 
-static unsigned long default_reflog_expire;
-static unsigned long default_reflog_expire_unreachable;
+static time_t default_reflog_expire;
+static time_t default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
@@ -462,7 +462,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cb;
-	unsigned long now = time(NULL);
+	time_t now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
 
-- 
1.6.0.1
