From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv2] Add ignore and clean rules for gitweb.min.js
Date: Fri, 19 Mar 2010 17:40:23 -0400
Message-ID: <4BA3EF47.7060905@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 22:41:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjwQ-0006iu-Nm
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 22:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab0CSVlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 17:41:09 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:50402 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751411Ab0CSVlI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 17:41:08 -0400
Received: from karakura.local (static-66-225-153-161.ptr.terago.net [66.225.153.161])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2JLeNJx021266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Mar 2010 17:40:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-UUID: 9446fd0f-d091-47fb-9cd2-8341c6a4f5bb
X-Miltered: at mailchk-m05 with ID 4BA3EF47.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 19 Mar 2010 17:40:25 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142652>

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

The instaweb patch from earlier was about making the instaweb
script aware that users can generate a minified version of 
gitweb.js. I think the stuff I am doing in this patch was just
forgotten when JSMIN support was first added for gitweb.

Junio, I went and changed the clean target changes according
to your comment.


 .gitignore |    1 +
 Makefile   |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

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
index f80b25e..aa1996d 100644
--- a/Makefile
+++ b/Makefile
@@ -2077,7 +2077,7 @@ clean:
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
-	$(RM) gitweb/gitweb.cgi
+	$(RM) gitweb/{gitweb.cgi,gitweb.min.js}
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
-- 
1.7.0.2.279.gf1ba1c
