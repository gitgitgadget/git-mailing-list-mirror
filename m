From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Fri, 06 Sep 2013 22:10:18 +0200
Message-ID: <522A36AA.3050701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 22:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI2Ms-00065O-MO
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 22:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab3IFUKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 16:10:45 -0400
Received: from plane.gmane.org ([80.91.229.3]:47274 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab3IFUKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 16:10:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VI2Md-0005wc-Lu
	for git@vger.kernel.org; Fri, 06 Sep 2013 22:10:43 +0200
Received: from p5ddb323a.dip0.t-ipconnect.de ([93.219.50.58])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 22:10:43 +0200
Received: from sschuberth by p5ddb323a.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 22:10:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb323a.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234094>

For custom builds of Git it sometimes is inconvenient to annotate tags
because there simply is nothing to say, so do not require an annotation.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index b444c18..68b61e3 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -12,7 +12,7 @@ if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
 elif test -d ${GIT_DIR:-.git} -o -f .git &&
-	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
+	VN=$(git describe --tags --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
 	case "$VN" in
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
-- 
1.8.3.msysgit.1.3.g5b82b42.dirty
