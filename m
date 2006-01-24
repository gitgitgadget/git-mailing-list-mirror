From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] use "git <command>" instead of "git-<command>"
Date: Tue, 24 Jan 2006 11:52:24 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060124105224.GA6765@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 24 11:56:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1LnD-0001jt-Lv
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 11:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWAXKw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 05:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWAXKw0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 05:52:26 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:39409 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1030447AbWAXKwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 05:52:25 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F1Lmi-00018G-HO
	for git@vger.kernel.org; Tue, 24 Jan 2006 11:52:24 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0OAqOmY006879
	for <git@vger.kernel.org>; Tue, 24 Jan 2006 11:52:24 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0OAqO46006878
	for git@vger.kernel.org; Tue, 24 Jan 2006 11:52:24 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15099>

Hello,

Otherwise installations with gitexecdir != bindir are not able to determine the
right version.

---

 GIT-VERSION-GEN |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

9d9d610164ec140f3fee21475b976d3e4b998991
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index e3cd9fa..2085ad3 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -5,13 +5,13 @@ DEF_VER=v1.1.GIT
 
 # First try git-describe, then see if there is a version file
 # (included in release tarballs), then default
-VN=$(git-describe --abbrev=4 HEAD 2>/dev/null | sed -e 's/-/./g') ||
+VN=$(git describe --abbrev=4 HEAD 2>/dev/null | sed -e 's/-/./g') ||
 VN=$(cat version) ||
 VN="$DEF_VER"
 
 VN=$(expr "$VN" : v*'\(.*\)')
 
-dirty=$(sh -c 'git-diff-index --name-only HEAD' 2>/dev/null) || dirty=
+dirty=$(sh -c 'git diff-index --name-only HEAD' 2>/dev/null) || dirty=
 case "$dirty" in
 '')
 	;;
-- 
1.1.4.g2eaa

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=1+year+divided+by+3+in+seconds
