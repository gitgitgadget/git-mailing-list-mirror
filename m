From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Thu, 5 May 2011 21:10:28 +0200
Message-ID: <20110505191027.GA3242@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 21:10:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3wf-0001E3-GX
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab1EETKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:10:35 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:34788 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab1EETKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:10:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 8D92B5F0049
	for <git@vger.kernel.org>; Thu,  5 May 2011 21:10:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uA6ISQ-S2YkW for <git@vger.kernel.org>;
	Thu,  5 May 2011 21:10:28 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 383995F0046
	for <git@vger.kernel.org>; Thu,  5 May 2011 21:10:28 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 249E580AC5; Thu,  5 May 2011 21:10:28 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172883>

In bash and some other shells the script:

x=2; unset a; echo "${a:-'$x'}"

prints '2'. However ksh shell prints $x. The quoting is added to
reproduce bash behaviour.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t1506-rev-parse-diagnosis.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 4a6396f..bad09f9 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -8,8 +8,8 @@ exec </dev/null
 
 test_did_you_mean ()
 {
-	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
-	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
+	printf "fatal: Path '$2$3' $4, but not ${5:-\'$3\'}.\n" >expected &&
+	printf "Did you mean '$1:$2$3'${2:+ aka \'$1:./$3\'}?\n" >>expected &&
 	test_cmp expected error
 }
 
-- 
1.7.5

-- 
  Kacper Kornet
