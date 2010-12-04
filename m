From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 13/14] transport.c: Initialise variable to suppress msvc warning
Date: Sat, 04 Dec 2010 19:11:40 +0000
Message-ID: <4CFA926C.70501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzDp-0000KS-4J
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab0LDVAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:00:42 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:42439 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0LDVAm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:00:42 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1POytH-0001we-mq; Sat, 04 Dec 2010 20:39:32 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162913>


The msvc compiler thinks that a variable could be used while
uninitialised and issues the following warning:

    ...\git\transport.c(107) : warning C4700: uninitialized local \
        variable 'cmp' used

In order to suppress the warning, we simply initialise the
variable to zero.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 0078660..1dca6d4 100644
--- a/transport.c
+++ b/transport.c
@@ -104,7 +104,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		return;
 
 	for (;;) {
-		int cmp = cmp, len;
+		int cmp = 0, len;
 
 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
-- 
1.7.3
