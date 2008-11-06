From: david@statichacks.org
Subject: [PATCH 3/4] Changed timestamps to time_t instead of unsigned long for approxidate()
Date: Thu,  6 Nov 2008 09:48:47 -0800
Message-ID: <1225993728-4779-4-git-send-email-david@statichacks.org>
References: <1225993728-4779-1-git-send-email-david@statichacks.org>
 <1225993728-4779-2-git-send-email-david@statichacks.org>
 <1225993728-4779-3-git-send-email-david@statichacks.org>
Cc: David Bryson <david@statichacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:50:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8zj-0005K1-Nd
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYKFRs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYKFRsz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:48:55 -0500
Received: from cryptobackpack.org ([64.105.32.74]:38692 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYKFRsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:48:52 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 47D7510D02A4; Thu,  6 Nov 2008 09:48:51 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id A146510D0267;
	Thu,  6 Nov 2008 09:48:50 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 8F20D144A8; Thu,  6 Nov 2008 09:48:48 -0800 (PST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <1225993728-4779-3-git-send-email-david@statichacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100254>

From: David Bryson <david@statichacks.org>

---
 builtin-gc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 7af65bb..168f484 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -58,7 +58,7 @@ static int gc_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "gc.pruneexpire")) {
 		if (value && strcmp(value, "now")) {
-			unsigned long now = approxidate("now");
+			time_t now = approxidate("now");
 			if (approxidate(value) >= now)
 				return error("Invalid %s: '%s'", var, value);
 		}
-- 
1.6.0.1
