From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] Sparse fix for builtin-diff
Date: Sun, 7 May 2006 16:50:47 +0200
Message-ID: <20060507145046.GA24882@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 16:51:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fckb3-0003hv-Sl
	for gcvg-git@gmane.org; Sun, 07 May 2006 16:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWEGOuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 10:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWEGOuw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 10:50:52 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:1672 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S932133AbWEGOuv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 10:50:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id B1C9A2C53;
	Sun,  7 May 2006 16:50:50 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 02260-01; Sun,  7 May 2006 16:50:47 +0200 (MEST)
Received: from peppar.cs.umu.se (peppar.cs.umu.se [130.239.40.13])
	by mail.cs.umu.se (Postfix) with ESMTP id 6EF552C1F;
	Sun,  7 May 2006 16:50:47 +0200 (MEST)
Received: by peppar.cs.umu.se (Postfix, from userid 12006)
	id 490D030CE; Sun,  7 May 2006 16:50:47 +0200 (MEST)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19703>

You gotta love sparse:

builtin-diff.c:88:4: error: Just how const do you want this type to be?

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
---

 builtin-diff.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 636edbf..d3ac581 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -84,8 +84,7 @@ static void stuff_change(struct diff_opt
 
 	if (opt->reverse_diff) {
 		unsigned tmp;
-		const
-			const unsigned char *tmp_u;
+		const unsigned char *tmp_u;
 		const char *tmp_c;
 		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
 		tmp_u = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_u;
