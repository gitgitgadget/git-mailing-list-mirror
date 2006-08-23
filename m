From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 6/7] use name[len] in switch directly, instead of creating a shadowed variable.
Date: Wed, 23 Aug 2006 12:39:15 +0200
Message-ID: <1156329557424-git-send-email-madcoder@debian.org>
References: 200608231238.10963.madcoder@debian.org <11563295562072-git-send-email-madcoder@debian.org> <11563295562422-git-send-email-madcoder@debian.org> <1156329556788-git-send-email-madcoder@debian.org> <11563295573215-git-send-email-madcoder@debian.org> <11563295573035-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 12:41:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq9B-0007TY-6C
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWHWKjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWHWKjX
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:39:23 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:37797 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S964833AbWHWKjV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:39:21 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 728D5D8293;
	Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id 1C9D8409C1; Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
In-Reply-To: <11563295573035-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25914>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 5991737..f8f5eeb 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -606,9 +606,7 @@ static char *git_header_name(char *line,
 	 * form.
 	 */
 	for (len = 0 ; ; len++) {
-		char c = name[len];
-
-		switch (c) {
+		switch (name[len]) {
 		default:
 			continue;
 		case '\n':
-- 
1.4.1.1
