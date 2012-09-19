From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 5/4] rebase -i: suggest using --edit-todo to fix an unknown
 instruction
Date: Wed, 19 Sep 2012 08:43:54 +0200
Message-ID: <505969AA.1070509@viscovery.net>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com> <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 08:44:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEE1J-0000uj-9t
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 08:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab2ISGoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 02:44:16 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:45347 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752877Ab2ISGn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 02:43:59 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TEE0p-0000aC-4W; Wed, 19 Sep 2012 08:43:55 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BDC3B1660F;
	Wed, 19 Sep 2012 08:43:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205909>

From: Johannes Sixt <j6t@kdbg.org>

We have now an explicit UI to edit the todo sheet and need not disclose
the name of the file.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-rebase--interactive.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2b8f2a9..4b2ef11 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -575,11 +575,12 @@ do_next () {
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
+		fixtodo="Please fix this using 'git rebase --edit-todo'."
 		if git rev-parse --verify -q "$sha1" >/dev/null
 		then
-			die_with_patch $sha1 "Please fix this in the file $todo."
+			die_with_patch $sha1 "$fixtodo"
 		else
-			die "Please fix this in the file $todo."
+			die "$fixtodo"
 		fi
 		;;
 	esac
-- 
1.7.12.1721.gd1d8b74
