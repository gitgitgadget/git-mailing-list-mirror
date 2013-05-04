From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] revision.c: Fix a sparse warning
Date: Sat, 04 May 2013 18:25:56 +0100
Message-ID: <518544A4.4080202@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: kevin@bracey.fi
X-From: git-owner@vger.kernel.org Sat May 04 19:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYgEb-0000ve-5j
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 19:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761707Ab3EDR0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 13:26:52 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:38122 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757433Ab3EDR0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 13:26:52 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 0787EA0C081;
	Sat,  4 May 2013 18:26:50 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 51542A0C080;
	Sat,  4 May 2013 18:26:49 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Sat,  4 May 2013 18:26:48 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223368>


Sparse issues an "'sole_interesting' not declared. Should it be static?"
warning. In order to suppress the warning, since this symbol does not
need more than file visibility, we simply add the static modifier to
its declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Kevin,

If you need to re-roll your 'kb/full-history-compute-treesame-carefully'
branch, could you please squash this into commit 039bdad1 ("revision.c:
discount UNINTERESTING parents", 30-04-2013).

Thanks!

ATB,
Ramsay Jones

 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index dd48c55..60c8d8c 100644
--- a/revision.c
+++ b/revision.c
@@ -349,7 +349,7 @@ static int everybody_uninteresting(struct commit_list *orig)
  * (and multiple UNINTERESTING ones), then we can't choose a parent to follow,
  * and we should not be simplified.
  */
-struct commit *sole_interesting(struct rev_info *revs, struct commit_list *orig)
+static struct commit *sole_interesting(struct rev_info *revs, struct commit_list *orig)
 {
 	struct commit_list *list = orig;
 	struct commit *interesting = NULL;
-- 
1.8.2
