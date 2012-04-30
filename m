From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT] [PATCH] Testsuite: get rid of "Broken pipe" errors from yes.
Date: Mon, 30 Apr 2012 12:27:21 +0200
Message-ID: <87k40x346u.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 12:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOnpN-0003MQ-DT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 12:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab2D3K13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 06:27:29 -0400
Received: from smtp.opera.com ([213.236.208.81]:46443 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab2D3K12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 06:27:28 -0400
Received: from centurion.linkoping.osa (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q3UARMKd015256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 10:27:23 GMT
Received: by centurion.linkoping.osa (Postfix, from userid 1000)
	id 898B7B9A07F; Mon, 30 Apr 2012 12:27:21 +0200 (CEST)
CC: ceder@lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196548>


Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-029.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/regression/t-029.sh b/regression/t-029.sh
index 83e1d2b..09450c6 100755
--- a/regression/t-029.sh
+++ b/regression/t-029.sh
@@ -21,11 +21,11 @@ echo | shouldfail guilt repair --full
 
 cmd list_files
 
-yes n | shouldfail guilt repair --full
+yes n 2>/dev/null | shouldfail guilt repair --full
 
 cmd list_files
 
-yes y | cmd guilt repair --full
+yes y 2>/dev/null | cmd guilt repair --full
 
 cmd list_files
 
@@ -33,6 +33,6 @@ cmd guilt push -a
 
 cmd list_files
 
-yes Y | cmd guilt repair --full
+yes Y 2>/dev/null | cmd guilt repair --full
 
 cmd list_files
-- 
1.7.10
