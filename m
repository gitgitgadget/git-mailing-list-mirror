From: arjen@yaph.org (Arjen Laarhoven)
Subject: [PATCH] Makefile: iconv() on Darwin has the old interface
Date: Sat, 7 Apr 2007 01:49:17 +0200
Message-ID: <20070406234917.GK3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZyBF-0003So-JB
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 01:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbXDFXtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 19:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933455AbXDFXtS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 19:49:18 -0400
Received: from regex.yaph.org ([193.202.115.201]:33936 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933454AbXDFXtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 19:49:18 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 30EA15B7CA; Sat,  7 Apr 2007 01:49:17 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43944>

The libiconv on Darwin uses the old iconv() interface (2nd argument is a
const char **, instead of a char **).  Add OLD_ICONV to the Darwin
variable definitions to handle this.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ad321b3..2146403 100644
--- a/Makefile
+++ b/Makefile
@@ -385,6 +385,7 @@ endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
+	OLD_ICONV = UnfortunatelyYes
 	NO_STRLCPY = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
-- 
1.5.1.rc3.29.gd8b6
