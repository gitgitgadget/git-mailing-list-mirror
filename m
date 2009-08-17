From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 06/11] Add miss git-compat-util.h at regex.c and fnmatch.c Add git-compat-util.h to enable build at MSVC environment
Date: Tue, 18 Aug 2009 00:04:57 +0800
Message-ID: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4i9-00057s-BS
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbZHQQFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbZHQQFT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:05:19 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:45112 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807AbZHQQFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:05:19 -0400
Received: by pxi34 with SMTP id 34so1252367pxi.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=lTuF9L7kBgt94FbXxH17s06M/XhNvekdA+qtQ4rf+Zw=;
        b=qAUi7HyHLd7DQ0mdc4UGDE8GDK0Sgw46HwsSkdL3Pco05qZJRuDsthqHeYxd4YAc8r
         UaXvk/E0dZZYpiIQJMih8pAm5LHTqFzPsvkWWDhk0uTgt4FZmYHcyHDJM5m5Sk8PO+3+
         LmEBrUgaa/bnI9L8t7yShZVdJMdf1hEP6feWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oSQGj5i2+rcHfSgtWvdf1+JvaV9O3d+3qaKOLzLRP8M5i2CJs2D4E7sBJwbLXy916w
         4nyk/AcnZerqRTaNbFj4MGvf/6z080KxpLmCuXSY1ifzY9zx7mTr15vTBl4t4i1WyDP2
         R6g2qWDiWk3quTxdak47YtUDNrmEZXnDLiJVQ=
Received: by 10.114.18.2 with SMTP id 2mr2411384war.192.1250525120391;
        Mon, 17 Aug 2009 09:05:20 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id d20sm10728850waa.12.2009.08.17.09.05.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:05:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126206>

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/fnmatch/fnmatch.c |    4 ++++
 compat/regex/regex.c     |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 14feac7..5cbd49c 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -16,6 +16,10 @@
    write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
    Boston, MA 02111-1307, USA.  */
 
+#ifdef _MSC_VER
+#include "git-compat-util.h"
+#endif
+
 #if HAVE_CONFIG_H
 # include <config.h>
 #endif
diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5728de1..2298a3a 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -20,6 +20,10 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */
 
 /* AIX requires this to be the first thing in the file. */
+#ifdef _MSC_VER
+#include "git-compat-util.h"
+#endif
+
 #if defined (_AIX) && !defined (REGEX_MALLOC)
   #pragma alloca
 #endif
-- 
1.6.4.msysgit.0
