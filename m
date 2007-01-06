From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH] instaweb: Nicer error message when the http daemon isn't found
Date: Sat, 06 Jan 2007 11:40:06 +0100
Message-ID: <20070106104006.9359.33443.stgit@c165>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 11:48:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H395r-0008Em-EG
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbXAFKrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbXAFKrz
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:47:55 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:35594 "EHLO
	mxfep01.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbXAFKry (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:47:54 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 05:47:53 EST
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep04.bredband.com with ESMTP
          id <20070106104006.LSQ2732.mxfep04.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sat, 6 Jan 2007 11:40:06 +0100
Received: from c-eb66e455.09-360-6c6b701.cust.bredbandsbolaget.se (HELO c165) ([85.228.102.235])
  by ironport2.bredband.com with ESMTP; 06 Jan 2007 11:40:06 +0100
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1H38y6-0002R4-00; Sat, 06 Jan 2007 11:40:06 +0100
To: junkio@cox.net
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36086>




Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

---

 git-instaweb.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 08362f4..80adc83 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -53,6 +53,9 @@ start_httpd () {
 				return
 			fi
 		done
+		echo "$httpd_only not found. Install $httpd_only or use" \
+		     "--httpd to specify another http daemon."
+		exit 1
 	fi
 	if test $? != 0; then
 		echo "Could not execute http daemon $httpd."
