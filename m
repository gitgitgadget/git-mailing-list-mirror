From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] send-email: expand path in sendemail.smtpsslcertpath config
Date: Tue, 17 Nov 2015 22:01:05 +0000
Message-ID: <5b9c60c07329ee166409f9d7f0b2ad4ad6e2dca3.1447797487.git.john@keeping.me.uk>
References: <cover.1447797487.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 01:55:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zyr1w-0005Ve-I9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 01:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbbKRAzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 19:55:20 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:38971 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbKRAzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 19:55:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CA58086A764;
	Tue, 17 Nov 2015 22:18:02 +0000 (GMT)
X-Quarantine-ID: <VN9XgHygqa21>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VN9XgHygqa21; Tue, 17 Nov 2015 22:18:01 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DDE098E2740;
	Tue, 17 Nov 2015 22:01:20 +0000 (GMT)
X-Mailer: git-send-email 2.6.3.462.gbe2c914
In-Reply-To: <cover.1447797487.git.john@keeping.me.uk>
In-Reply-To: <cover.1447797487.git.john@keeping.me.uk>
References: <cover.1447797487.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281435>

As it says in the name, the SSL certificate path is a path so treat it
as one and support tilde-expansion.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e907e0e..719c715 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -239,7 +239,6 @@ my %config_settings = (
     "smtpserveroption" => \@smtp_server_options,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
-    "smtpsslcertpath" => \$smtp_ssl_cert_path,
     "smtpdomain" => \$smtp_domain,
     "smtpauth" => \$smtp_auth,
     "to" => \@initial_to,
@@ -259,6 +258,7 @@ my %config_settings = (
 
 my %config_path_settings = (
     "aliasesfile" => \@alias_files,
+    "smtpsslcertpath" => \$smtp_ssl_cert_path,
 );
 
 # Handle Uncouth Termination
-- 
2.6.3.462.gbe2c914
