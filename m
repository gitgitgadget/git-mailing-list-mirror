From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] builtin/apply.c: remove impossible check
Date: Fri, 4 Mar 2011 20:43:58 +0100
Organization: -
Message-ID: <20110304204358.3f5618cf@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 20:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvawb-0002TS-71
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 20:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517Ab1CDTpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 14:45:17 -0500
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:48208 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932470Ab1CDTpO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 14:45:14 -0500
X-Greylist: delayed 806 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Mar 2011 14:45:13 EST
Received: from absol.kitzblitz (85-127-41-184.dynamic.xdsl-line.inode.at [85.127.41.184])
	(authenticated bits=0)
	by webhosting01.bon.m2soft.com (8.13.8/8.13.8) with ESMTP id p24JQ7rW027701;
	Fri, 4 Mar 2011 20:26:08 +0100
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Claws Mail (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168463>

'n1' and 'n2' are unsigned of type size_t, and can never
be negative.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
Testsuite did not regress at my place.

 builtin/apply.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14951da..6069377 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -248,9 +248,6 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
 	const char *last2 = s2 + n2 - 1;
 	int result = 0;
 
-	if (n1 < 0 || n2 < 0)
-		return 0;
-
 	/* ignore line endings */
 	while ((*last1 == '\r') || (*last1 == '\n'))
 		last1--;
-- 
1.7.3.4
