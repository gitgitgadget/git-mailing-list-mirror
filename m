From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: [PATCH] log-tree.c: Make log_tree_diff_flush() honor line_termination.
Date: Mon, 21 Apr 2008 21:18:48 -0500
Message-ID: <5d46db230804211918u1444a80cwe1e977d37c2eb257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 04:19:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo86b-0002PY-HU
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 04:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256AbYDVCSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 22:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbYDVCSu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 22:18:50 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:18538 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbYDVCSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 22:18:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1154712ywb.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 19:18:49 -0700 (PDT)
Received: by 10.150.158.8 with SMTP id g8mr7838021ybe.25.1208830729016;
        Mon, 21 Apr 2008 19:18:49 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Mon, 21 Apr 2008 19:18:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80052>

Signed-off-by: Govind Salinas <blix@sophiasuchtig.com>
---
I sent this in a few weeks ago, but it was not eligible for inclusion on 1.5.5.
There was some discussion but I was never sure if the patch was acceptable
to everyone.  I would like to know if this could be done for the next version?


 log-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5b29639..374b277 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -347,7 +347,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
 				printf("---");
-			putchar('\n');
+			putchar(opt->diffopt.line_termination);
 		}
 	}
 	diff_flush(&opt->diffopt);
-- 
1.5.5.rc2.131.g3d2f
