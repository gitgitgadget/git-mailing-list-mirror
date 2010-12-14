From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 05/14] lib-git-svn.sh: Add check for mis-configured web server
 variables
Date: Tue, 14 Dec 2010 18:25:11 +0000
Message-ID: <4D07B687.7030709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, normalperson@yhbt.net,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:46:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZst-0004t2-9h
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027Ab0LNSpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:45:46 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:52566 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756880Ab0LNSpp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 13:45:45 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1PSZse-0006qD-Y9; Tue, 14 Dec 2010 18:45:45 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163667>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/lib-git-svn.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 154f3d3..5acc0ec 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -81,6 +81,11 @@ then
 			break
 		fi
 	done
+	if test -z "$SVN_HTTPD_PATH"
+	then
+		skip_all='skipping git svn tests, Apache not found'
+		test_done
+	fi
 	for d in \
 		"$SVN_HTTPD_MODULE_PATH" \
 		/usr/lib/apache2/modules \
@@ -92,6 +97,11 @@ then
 			break
 		fi
 	done
+	if test -z "$SVN_HTTPD_MODULE_PATH"
+	then
+		skip_all='skipping git svn tests, Apache module dir not found'
+		test_done
+	fi
 fi
 
 start_httpd () {
-- 
1.7.3
