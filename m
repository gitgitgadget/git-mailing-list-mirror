From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] Revert "gitweb: There can be empty patches (in git_patchset_body)"
Date: Sun,  7 Jan 2007 02:52:26 +0100
Message-ID: <11681347532843-git-send-email-jnareb@gmail.com>
References: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 07 02:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NDK-0001C8-Tv
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 02:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbXAGBwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 20:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbXAGBwh
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 20:52:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:5836 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbXAGBwc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 20:52:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8960302nfa
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 17:52:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y0z9DptZWfOgJgXhQQzyKeDPc5jRLNNTWbwMjOt40A9zi5deNAwZU4kfbEWRfqulfHFFgvakm34nY1B6sXvavNAmedU9CnA71mERt/dpGBzrYLXvFK3ja4ZXyRWsFNXrAy6vkh6zByxsp0N6slu1v98akm65UJjZkryJK5x08lM=
Received: by 10.49.93.13 with SMTP id v13mr8942479nfl.1168134752172;
        Sat, 06 Jan 2007 17:52:32 -0800 (PST)
Received: from roke.D-201 ( [81.190.18.145])
        by mx.google.com with ESMTP id r33sm101829055nfc.2007.01.06.17.52.31;
        Sat, 06 Jan 2007 17:52:31 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l071qZsA007272;
	Sun, 7 Jan 2007 02:52:35 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l071qXqe007265;
	Sun, 7 Jan 2007 02:52:33 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36114>

This reverts commit 1ebb948f656c03a5bdaab4de1a113b9ffcb98bea,
as that patch quieted warning but was not proper solution.
The previous commit was.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7ebdfbb..d60d7c6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2533,7 +2533,7 @@ sub git_patchset_body {
 		print "<div class=\"diff from_file\">$patch_line</div>\n";
 
 		$patch_line = <$fd>;
-		last PATCH unless $patch_line;
+		#last PATCH unless $patch_line;
 		chomp $patch_line;
 
 		#assert($patch_line =~ m/^+++/) if DEBUG;
-- 
1.4.4.3
