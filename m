From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/2] log-tree: show_log() should respect the setting of diffopt->line_termination
Date: Mon,  7 Aug 2006 05:11:23 -0700
Message-ID: <1154952684908-git-send-email-ryan@michonline.com>
References: <20060807115000.GC15477@h4x0r5.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Aug 07 14:13:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA3zD-0000x8-Nq
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 14:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWHGMNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 08:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWHGMNc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 08:13:32 -0400
Received: from h4x0r5.com ([70.85.31.202]:45065 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932077AbWHGMNc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 08:13:32 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythryan.michonline.com)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GA3xn-0003Y5-Hz; Mon, 07 Aug 2006 05:12:08 -0700
Received: from ryan by mythryan.michonline.com with local (Exim 4.62)
	(envelope-from <ryan@mythryan.michonline.com>)
	id 1GA3x6-0007VW-KG; Mon, 07 Aug 2006 05:11:24 -0700
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2.rc3.g6487-dirty
In-Reply-To: <20060807115000.GC15477@h4x0r5.com>
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25009>

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---
 log-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index b67b8dd..05ede0c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -59,7 +59,7 @@ void show_log(struct rev_info *opt, cons
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->parents)
 			show_parents(commit, abbrev_commit);
-		putchar('\n');
+		putchar(opt->diffopt.line_termination);
 		return;
 	}
 
-- 
1.4.2.rc3.g6487-dirty
