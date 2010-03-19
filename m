From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] Add ignore and clean rules for gitweb.min.js
Date: Fri, 19 Mar 2010 16:09:06 -0400
Message-ID: <4BA3D9E2.5070401@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 21:09:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsiVf-0000gO-76
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 21:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab0CSUJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 16:09:26 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:36645 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751219Ab0CSUJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 16:09:25 -0400
Received: from karakura.local (static-66-225-153-161.ptr.terago.net [66.225.153.161])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2JK96vK005576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Mar 2010 16:09:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-UUID: 49b18c0e-5910-4d0c-b2ab-3a69a49aceca
X-Miltered: at mailchk-m04 with ID 4BA3D9E2.003 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Fri, 19 Mar 2010 16:09:08 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142642>


Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---
 .gitignore |    1 +
 Makefile   |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7b3acb7..3558dd2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -156,6 +156,7 @@
 /git-core-*/?*
 /gitk-git/gitk-wish
 /gitweb/gitweb.cgi
+/gitweb/gitweb.min.js
 /test-chmtime
 /test-ctype
 /test-date
diff --git a/Makefile b/Makefile
index f80b25e..cdf16c2 100644
--- a/Makefile
+++ b/Makefile
@@ -2078,6 +2078,9 @@ clean:
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
 	$(RM) gitweb/gitweb.cgi
+ifdef JSMIN
+	$(RM) gitweb/gitweb.min.js
+endif #JSMIN
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
-- 
1.7.0.2.279.gf1ba1c
