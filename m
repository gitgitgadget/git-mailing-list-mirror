From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 08/18] git-compat-util.h: some platforms with mmap() lack MAP_FAILED definition
Date: Fri, 14 May 2010 09:31:39 +0000
Message-ID: <20100514093802.235245000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrLV-0001sM-VF
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758783Ab0ENJiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:08 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:52929 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758779Ab0ENJiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:03 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 8A0505CB7
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:54:54 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 8A0505CB7
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 61C17CD4;
	Fri, 14 May 2010 09:38:02 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 5714C11D4D1; Fri, 14 May 2010 09:38:02 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-MAP_FAILED.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147066>

Some platforms with mmap() lack MAP_FAILED definition.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 git-compat-util.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: b/git-compat-util.h
===================================================================
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -217,7 +217,6 @@ static inline const char *skip_prefix(co
 #define PROT_READ 1
 #define PROT_WRITE 2
 #define MAP_PRIVATE 1
-#define MAP_FAILED ((void*)-1)
 #endif
 
 #define mmap git_mmap
@@ -246,6 +245,10 @@ extern int git_munmap(void *start, size_
 
 #endif /* NO_MMAP */
 
+#ifndef MAP_FAILED
+#define MAP_FAILED ((void*)-1)
+#endif
+
 #ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 #define on_disk_bytes(st) ((st).st_size)
 #else

-- 
Gary V. Vaughan (gary@thewrittenword.com)
