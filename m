From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Fix t7601-merge-pull-config.sh on AIX
Date: Sat,  5 Jul 2008 02:32:00 +0200
Message-ID: <1215217920-8506-1-git-send-email-vmiklos@frugalware.org>
References: <20080705002634.GF4729@genesis.frugalware.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>, git@vger.kernel.org,
	Mike Ralphson <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 02:32:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEvhm-0005Cf-S9
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 02:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYGEAbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 20:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbYGEAbt
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 20:31:49 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46666 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYGEAbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 20:31:49 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 8D7E21DDC5B;
	Sat,  5 Jul 2008 02:31:46 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 013381A9833; Sat,  5 Jul 2008 02:32:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <20080705002634.GF4729@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87426>

The test failed on AIX (and likely other OS, such as apparently OSX)
where wc -l outputs whitespace.

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Here is the same, with backticks avoided, and with a proper commit
message.

 t/t7601-merge-pull-config.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 32585f8..12f71ad 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -70,10 +70,10 @@ test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octo
 
 conflict_count()
 {
-	eval $1=`{
+	eval $1=$({
 		git diff-files --name-only
 		git ls-files --unmerged
-	} | wc -l`
+	} | wc -l | tr -d \ )
 }
 
 # c4 - c5
-- 
1.5.6.1
