From: Ariel Badichi <abadichi@bezeqint.net>
Subject: [PATCH] archive.c: format_subst - fixed bogus argument to memchr
Date: Wed, 23 Apr 2008 03:24:21 +0300
Message-ID: <87od81peog.fsf@sneeze.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 03:08:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoTTM-0001nf-Jr
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 03:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264AbYDWBHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 21:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933084AbYDWBHt
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 21:07:49 -0400
Received: from bzq-84-110-251-84.red.bezeqint.net ([84.110.251.84]:21693 "EHLO
	sneeze.site" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932857AbYDWBHt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 21:07:49 -0400
Received: by sneeze.site (Postfix, from userid 1000)
	id 3347E7A78F; Wed, 23 Apr 2008 04:01:35 +0300 (IDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80179>


Also removed a superfluous test.

Signed-off-by: Ariel Badichi <abadichi@bezeqint.net>
---
 archive.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index fb159fe..7a32c19 100644
--- a/archive.c
+++ b/archive.c
@@ -16,9 +16,9 @@ static void format_subst(const struct commit *commit,
 		const char *b, *c;
 
 		b = memmem(src, len, "$Format:", 8);
-		if (!b || src + len < b + 9)
+		if (!b)
 			break;
-		c = memchr(b + 8, '$', len - 8);
+		c = memchr(b + 8, '$', (src + len) - b - 8);
 		if (!c)
 			break;
 
-- 
1.5.5.1.57.g5909c
