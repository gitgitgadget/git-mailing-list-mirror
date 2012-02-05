From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Drop system includes from inet_pton/inet_ntop compatibility wrappers
Date: Sun,  5 Feb 2012 17:32:21 -0500
Message-ID: <1328481141-21037-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <7vr4y9ggij.fsf@alter.siamese.dyndns.org>
 <1328481141-21037-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 05 23:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuAex-0002eq-42
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2BEWeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:34:01 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:32976 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab2BEWeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:34:00 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:51390 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RuAel-0007mi-Ea; Sun, 05 Feb 2012 17:33:59 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RuAel-0005Zq-DZ; Sun, 05 Feb 2012 17:33:59 -0500
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1328481141-21037-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189980>

As both of these compatibility wrappers include git-compat-utils.h,
all of the system includes were redundant.

Dropping these system includes also makes git-compat-utils.h the first
include which avoids a compiler warning on Solaris due to the
redefinition of _FILE_OFFSET_BITS.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 compat/inet_ntop.c |    6 ------
 compat/inet_pton.c |    6 ------
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index 60b5a1d..90b7cc4 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -15,14 +15,8 @@
  * SOFTWARE.
  */
 
-#include <errno.h>
-#include <sys/types.h>
-
 #include "../git-compat-util.h"
 
-#include <stdio.h>
-#include <string.h>
-
 #ifndef NS_INADDRSZ
 #define NS_INADDRSZ	4
 #endif
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 2ec995e..2b9a0a4 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -15,14 +15,8 @@
  * WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
-#include <errno.h>
-#include <sys/types.h>
-
 #include "../git-compat-util.h"
 
-#include <stdio.h>
-#include <string.h>
-
 #ifndef NS_INT16SZ
 #define NS_INT16SZ       2
 #endif
-- 
1.7.5.4
