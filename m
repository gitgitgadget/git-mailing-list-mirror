From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/5] pack-objects: Limit visibility of 'indexed_commits' symbols
Date: Thu, 07 Nov 2013 22:11:22 +0000
Message-ID: <527C100A.6030907@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXrO-0000TZ-RP
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab3KGWPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:15:20 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:47456 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755538Ab3KGWPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:15:14 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 64A4240146A;
	Thu,  7 Nov 2013 22:15:11 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 9CBB440146F;
	Thu,  7 Nov 2013 22:15:10 +0000 (GMT)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu,  7 Nov 2013 22:15:09 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237436>


Noticed by sparse. ("symbol '...' was not declared. Should it be
static?")

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/pack-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 423e85a..161bfc2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -85,9 +85,9 @@ static uint32_t reused, reused_delta;
 /*
  * Indexed commits
  */
-struct commit **indexed_commits;
-unsigned int indexed_commits_nr;
-unsigned int indexed_commits_alloc;
+static struct commit **indexed_commits;
+static unsigned int indexed_commits_nr;
+static unsigned int indexed_commits_alloc;
 
 static void index_commit_for_bitmap(struct commit *commit)
 {
-- 
1.8.4
