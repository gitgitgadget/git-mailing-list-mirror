From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/log.c: Fix an "Using plain integer as NULL pointer"
 warning
Date: Sat, 08 Oct 2011 17:18:00 +0100
Message-ID: <4E9077B8.7080202@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:29:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCaiT-0001qi-6c
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab1JHR3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:29:35 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:55431 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753023Ab1JHR3f (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2011 13:29:35 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RCaiL-0002h4-p6; Sat, 08 Oct 2011 17:29:34 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183156>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I wanted to request that you squash this into commit 739453a3
(format-patch: use branch description in cover letter, 21-09-2011).
But, since that's in next ...

Hmm, I should probably start at least building the pu branch so that
I could catch these things earlier ...

ATB,
Ramsay Jones

 builtin/log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e80a925..4395f3e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1040,7 +1040,7 @@ static char *find_branch_name(struct rev_info *rev)
 	if (positive < 0)
 		return NULL;
 	strbuf_addf(&buf, "refs/heads/%s", rev->cmdline.rev[positive].name);
-	branch = resolve_ref(buf.buf, branch_sha1, 1, 0);
+	branch = resolve_ref(buf.buf, branch_sha1, 1, NULL);
 	if (!branch ||
 	    prefixcmp(branch, "refs/heads/") ||
 	    hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
-- 
1.7.7
