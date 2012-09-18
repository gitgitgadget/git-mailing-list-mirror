From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] grep.c: Fix a sparse warning
Date: Tue, 18 Sep 2012 18:30:25 +0100
Message-ID: <5058AFB1.3040600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 19:32:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE1ev-0004dv-5C
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 19:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab2IRRcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 13:32:21 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:44526 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752585Ab2IRRcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 13:32:20 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id BC35C400172;
	Tue, 18 Sep 2012 18:32:17 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 1289040012E;	Tue, 18 Sep 2012 18:32:17 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Tue, 18 Sep 2012 18:32:15 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205841>


In particular, sparse complains that "... 'dump_grep_expression'
was not declared. Should it be static?". In order to suppress
the warning, since this function does not need more than file
scope, we simply include the static modifier in it's declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I prefer to catch these before they progress to next, but it seems
I've not been quick enough lately! Sorry about that. :(  [I will have
to git-fetch more frequently; at present I only fetch about 3 times
a week.]

I've been away for a few days, so I'm well behind ... (I'm just
about to download 350+ emails for me to read tonight!).

ATB,
Ramsay Jones

 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 925aa92..38c4d75 100644
--- a/grep.c
+++ b/grep.c
@@ -403,7 +403,7 @@ static void dump_grep_expression_1(struct grep_expr *x, int in)
 	}
 }
 
-void dump_grep_expression(struct grep_opt *opt)
+static void dump_grep_expression(struct grep_opt *opt)
 {
 	struct grep_expr *x = opt->pattern_expression;
 
-- 
1.7.12
