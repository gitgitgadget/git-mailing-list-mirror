From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] Fix regex pattern in commit-msg
Date: Sun, 13 Aug 2006 00:34:37 -0700 (PDT)
Message-ID: <20060813073437.1889.qmail@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1520005510-1155454477=:1583"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Aug 13 09:34:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCAUh-0008I8-6A
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 09:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWHMHej (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 03:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWHMHej
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 03:34:39 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:44149 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750737AbWHMHei (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 03:34:38 -0400
Received: (qmail 1891 invoked by uid 60001); 13 Aug 2006 07:34:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=26C61prdW84dpBlNdIQLuZ/7T3FCu8fhhD5X+cAoPMgdVAK4QCJOsWDtcI25eGwkvJG7xEfxHLl7ydeF5coOUiQ4dFmfdaMTBWVX31VOV1yD56nmulBW6vdxDT5AJ3PsqwnxynPYU4miT5D2Zwm+Xcj+SEMHntnZR7k+lKkKoVI=  ;
Received: from [71.80.231.253] by web31805.mail.mud.yahoo.com via HTTP; Sun, 13 Aug 2006 00:34:37 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25276>

--0-1520005510-1155454477=:1583
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Between the count and the line output, some
uniq(1) versions put a TAB character, not a space.
Make sure both are handled.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 templates/hooks--commit-msg |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
--0-1520005510-1155454477=:1583
Content-Type: text/inline; name="p1.patch"
Content-Description: 2795696785-p1.patch
Content-Disposition: name="p1.patch"; filename="p1.patch"

diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
index 643822d..23617f3 100644
--- a/templates/hooks--commit-msg
+++ b/templates/hooks--commit-msg
@@ -11,4 +11,4 @@ # To enable this hook, make this file ex
 # This example catches duplicate Signed-off-by lines.
 
 test "" = "$(grep '^Signed-off-by: ' "$1" |
-	 sort | uniq -c | sed -e '/^[ 	]*1 /d')"
+	 sort | uniq -c | sed -e '/^[ 	]*1[ 	]/d')"
-- 
1.4.2.rc3.gb9227

--0-1520005510-1155454477=:1583--
