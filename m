From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] diff: added '-q' option, short option for '--quiet'
Date: Wed, 14 Jan 2015 23:35:01 +0600
Message-ID: <1421256901-30560-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRqd-00070M-U5
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbbANRfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:35:08 -0500
Received: from mail-la0-f47.google.com ([209.85.215.47]:61920 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbANRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:35:07 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so9401755lab.6
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8ZbTZG7xVf44oprWLsw1xzOHr84oBZ4r4g8j4c/Zq5o=;
        b=xGNsrOdbowxesS2CZ9v5W0ogUmCz5b8q4jadfpwgkHUKAOURlRg0SRdgGj2CzkVRjE
         kJOcl/q3s8WNKOS36z/9rG/gkkgGh1/RknKRxo0qsWp7yz+eLYa4ujKeGQmMUe4yaTm4
         1Y5Aq0Sc2s3cXrop0kLmdDw+OCcPN61CTq2bwIAiPENsiLj5iIBPtykGQOVKBiM1FWRJ
         6EXsp1HjKu26BOMCrc8rTK4+CnmmIGedCk8Tv5UEYHL+NFf1UBZ9B0GqXcU2IGLhE3iA
         9weSPh6w/je9dXa1Y8bFjEEjNY3IDBw9U4XX+cNtkY/cbfSCFw5wnvd8IwgqBkYzws28
         a37A==
X-Received: by 10.152.23.98 with SMTP id l2mr5253510laf.46.1421256905821;
        Wed, 14 Jan 2015 09:35:05 -0800 (PST)
Received: from localhost.localdomain ([178.89.21.160])
        by mx.google.com with ESMTPSA id r5sm1943351lae.34.2015.01.14.09.35.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Jan 2015 09:35:04 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.256.gb0e92c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262399>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/diff-options.txt | 1 +
 diff.c                         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2b15050..9160c90 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -491,6 +491,7 @@ ifndef::git-log[]
 	That is, it exits with 1 if there were differences and
 	0 means no differences.
 
+-q
 --quiet::
 	Disable all output of the program. Implies `--exit-code`.
 endif::git-log[]
diff --git a/diff.c b/diff.c
index 6ad8970..d778df7 100644
--- a/diff.c
+++ b/diff.c
@@ -3798,7 +3798,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
-	else if (!strcmp(arg, "--quiet"))
+	else if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q"))
 		DIFF_OPT_SET(options, QUICK);
 	else if (!strcmp(arg, "--ext-diff"))
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
-- 
2.3.0.rc0.256.gb0e92c0
