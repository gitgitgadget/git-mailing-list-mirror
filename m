From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-submodule summary: fix that some "wc" flavors produce
 leading spaces
Date: Wed, 12 Mar 2008 09:30:01 +0100
Message-ID: <47D79489.2070004@viscovery.net>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com> <1205243539-797-2-git-send-email-pkufranky@gmail.com> <1205243539-797-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 09:31:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZMMp-0000pc-U2
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 09:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbYCLIaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 04:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYCLIaI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 04:30:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26090 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbYCLIaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 04:30:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZMKr-0001A5-Hc; Wed, 12 Mar 2008 09:29:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 26A316D9; Wed, 12 Mar 2008 09:30:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1205243539-797-3-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76940>

From: Johannes Sixt <johannes.sixt@telecom.at>

We print the number of commits in parentheses, but without this change
we would get an oddly looking line like this:

    * sm1 4c8d358...41fbea9 (      4):

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

	How portable is this?

	-- Hannes

 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f7a6ee2..221a4c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -462,7 +462,7 @@ cmd_summary() {
 			GIT_DIR="$name/.git" \
 			git log --pretty=oneline --first-parent $range | wc -l
 			)
-			total_commits=" ($total_commits)"
+			total_commits=" ($(($total_commits + 0)))"
 			;;
 		esac

-- 
1.5.4.4.1329.g2c612
