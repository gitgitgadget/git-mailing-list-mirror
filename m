From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv6 1/6] Gitweb: add ignore and clean rules for minified files
Date: Fri, 02 Apr 2010 20:33:55 -0400
Message-ID: <4BB68CF3.1030803@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 02:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxrJR-00078l-TN
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 02:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab0DCAeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 20:34:05 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:54307 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752419Ab0DCAeC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 20:34:02 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o330XuJO016034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Apr 2010 20:33:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-UUID: 5661e0c1-d73b-408d-bffe-ca95667beac1
X-Miltered: at mailchk-m05 with ID 4BB68CF4.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 02 Apr 2010 20:33:58 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143869>

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

Changes since last revision:
	- Added a new line for minified gitweb files instead of
	  trying to use a glob to get all generated gitweb files


 .gitignore |    1 +
 Makefile   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7b3acb7..4c24152 100644
--- a/.gitignore
+++ b/.gitignore
@@ -156,6 +156,7 @@
 /git-core-*/?*
 /gitk-git/gitk-wish
 /gitweb/gitweb.cgi
+/gitweb/gitweb.min.*
 /test-chmtime
 /test-ctype
 /test-date
diff --git a/Makefile b/Makefile
index 3e816e1..0071e52 100644
--- a/Makefile
+++ b/Makefile
@@ -2092,6 +2092,7 @@ clean:
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
 	$(RM) gitweb/gitweb.cgi
+	$(RM) gitweb/gitweb.min*
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
-- 
1.7.0.3.519.g7e0613
