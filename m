From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/reset.c: Fix a sparse warning
Date: Mon, 14 Jan 2013 19:28:59 +0000
Message-ID: <50F45C7B.9030608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: martinvonz@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 14 20:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TupkT-0004Bj-ET
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418Ab3ANTas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:30:48 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:49916 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab3ANTas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:30:48 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id D952AA64431;
	Mon, 14 Jan 2013 19:30:45 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 31DFCA643AC;	Mon, 14 Jan 2013 19:30:45 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Mon, 14 Jan 2013 19:30:44 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213520>


In particular, sparse issues an "symbol not declared. Should it be
static?" warning for the 'parse_args' function. Since this function
does not require greater than file visibility, we suppress this
warning by simply adding the static modifier to it's decalaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Martin,

When you re-roll your "reset" patches (branch 'mz/reset-misc'), could
you please squash this into commit b24b3654 ("reset.c: extract function
for parsing arguments", 09-01-2013). Note that this patch is on top of
the pu branch (@75ea4ed3), which includes Junio's style fix patch
(commit 9f45c39f, "[SQUASH???] style fix", 10-01-2013).

Thanks!

ATB,
Ramsay Jones

 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index a37044e..c69f9da 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -171,7 +171,7 @@ static void die_if_unmerged_cache(int reset_type)
 
 }
 
-const char **parse_args(int argc, const char **argv, const char *prefix, const char **rev_ret)
+static const char **parse_args(int argc, const char **argv, const char *prefix, const char **rev_ret)
 {
 	const char *rev = "HEAD";
 	unsigned char unused[20];
-- 
1.8.1
