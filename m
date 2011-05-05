From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] Fix test t3701-add-interactive.sh
Date: Thu, 5 May 2011 18:50:29 +0200
Message-ID: <20110505165029.GD31229@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 18:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI1lR-0003UE-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 18:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab1EEQug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 12:50:36 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:59404 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755670Ab1EEQuf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 12:50:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 1636F5F0049
	for <git@vger.kernel.org>; Thu,  5 May 2011 18:50:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XkOXijpSHZRz for <git@vger.kernel.org>;
	Thu,  5 May 2011 18:50:29 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 945F75F0046
	for <git@vger.kernel.org>; Thu,  5 May 2011 18:50:29 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 8455180AF5; Thu,  5 May 2011 18:50:29 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172847>

One of the tests used to fail due to EOF not in the first column and not
continued &&.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t3701-add-interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d6327e7..018f5d9 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -83,9 +83,9 @@ EOF
 
 test_expect_success PERL 'setup fake editor' '
 	cat >fake_editor.sh <<EOF
-	EOF
+EOF
 	chmod a+x fake_editor.sh &&
-	test_set_editor "$(pwd)/fake_editor.sh" &&
+	test_set_editor "$(pwd)/fake_editor.sh"
 '
 
 test_expect_success PERL 'dummy edit works' '
-- 
1.7.5

-- 
  Kacper Kornet
