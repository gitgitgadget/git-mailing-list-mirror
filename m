From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] send-email: expand paths in sendemail.{to,cc}cmd config
Date: Tue, 17 Nov 2015 22:01:06 +0000
Message-ID: <db0b817c4be57635248a48a529a32719ad232f02.1447797487.git.john@keeping.me.uk>
References: <cover.1447797487.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 01:15:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyqPh-0002VW-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 01:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbbKRAPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 19:15:49 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:42336 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbbKRAPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 19:15:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E599BCDA75C;
	Tue, 17 Nov 2015 23:10:21 +0000 (GMT)
X-Quarantine-ID: <dbpRoJxrMavt>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dbpRoJxrMavt; Tue, 17 Nov 2015 23:10:18 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 044B396251E;
	Tue, 17 Nov 2015 22:01:34 +0000 (GMT)
X-Mailer: git-send-email 2.6.3.462.gbe2c914
In-Reply-To: <cover.1447797487.git.john@keeping.me.uk>
In-Reply-To: <cover.1447797487.git.john@keeping.me.uk>
References: <cover.1447797487.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281433>

These configuration variables specify the paths to commands so we should
support tilde-expansion for files inside a user's home directory.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 719c715..8e4c0e1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -242,9 +242,7 @@ my %config_settings = (
     "smtpdomain" => \$smtp_domain,
     "smtpauth" => \$smtp_auth,
     "to" => \@initial_to,
-    "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
-    "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
     "suppresscc" => \@suppress_cc,
@@ -259,6 +257,8 @@ my %config_settings = (
 my %config_path_settings = (
     "aliasesfile" => \@alias_files,
     "smtpsslcertpath" => \$smtp_ssl_cert_path,
+    "tocmd" => \$to_cmd,
+    "cccmd" => \$cc_cmd,
 );
 
 # Handle Uncouth Termination
-- 
2.6.3.462.gbe2c914
