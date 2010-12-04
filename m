From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 11/14] cat-file.c: Initialise variable to suppress msvc warning
Date: Sat, 04 Dec 2010 19:10:05 +0000
Message-ID: <4CFA920D.2020303@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:14:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzQr-0005pC-2V
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab0LDVOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:14:06 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:43228 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755843Ab0LDVOF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:14:05 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1POyt6-0001vI-p2; Sat, 04 Dec 2010 20:39:21 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162916>


The msvc compiler thinks that a variable could be used while
uninitialised and issues the following warning:

    ...\git\builtin\cat-file.c(171) : warning C4700: uninitialized \
        local variable 'contents' used

In order to suppress the warning, we simply initialise the
contents pointer variable to NULL.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/cat-file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94632db..472f3ad 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -168,7 +168,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	unsigned char sha1[20];
 	enum object_type type = 0;
 	unsigned long size;
-	void *contents = contents;
+	void *contents = NULL;
 
 	if (!obj_name)
 	   return 1;
-- 
1.7.3
