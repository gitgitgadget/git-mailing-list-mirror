From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Add a google-chrome option for web--browse
Date: Thu, 22 Jul 2010 11:58:20 -0500
Message-ID: <4c487a2a.4814e70a.2020.332e@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 22 19:04:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObzCW-0002dY-JH
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 19:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab0GVREp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 13:04:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59589 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab0GVREo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 13:04:44 -0400
Received: by iwn7 with SMTP id 7so8029778iwn.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:date:subject
         :to;
        bh=W5X1on0L6+q1QxwtlNdz2yuCdqtjmSyo29MotnmLpCY=;
        b=usyaJzYDY7tfVz6ralhp7vcMYaB/zjXt2Sw6GkBtgYwkGXXdAlKZTX66x14aaRDp/+
         vB17bCVNP3q8WgMtEG/ZrVcCeIey9GMjztgJ3NxBOliUtAgUZTToNv9+cigsIQybPK3e
         uli2OGDZOkrWJ+weO2SZNf5tnzeDrVFPospX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=LIdjr5CgPpHG/btog1wB8djwwZzlEjHV6CdpGgF+wHHjrNtWS7qIhfWihhnhoky7Yn
         MzytHKi5X10dFKzD2TnQ7T9n41vL1LNWqeXimyAqawzJ1FGPPmya27F/eokMEQL/RFSx
         spvSYn+X8Z84ys55DCzxGH0QDh2gVNxypwRCU=
Received: by 10.231.146.196 with SMTP id i4mr1800600ibv.110.1279818283594;
        Thu, 22 Jul 2010 10:04:43 -0700 (PDT)
Received: from localhost ([144.92.149.219])
        by mx.google.com with ESMTPS id e8sm30143411ibb.2.2010.07.22.10.04.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 10:04:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151463>

On some systems, the chrome browser is named google-chrome.  We add
support for this case.

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
I have been downloading the google-chrome-beta .deb package from Google, and
the binary is named google-chrome from that package.

 git-web--browse.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index dbded76..3fc4166 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
+		firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -103,7 +103,7 @@ fi
 
 if test -z "$browser" ; then
     if test -n "$DISPLAY"; then
-	browser_candidates="firefox iceweasel chrome chromium konqueror w3m links lynx dillo"
+	browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror w3m links lynx dillo"
 	if test "$KDE_FULL_SESSION" = "true"; then
 	    browser_candidates="konqueror $browser_candidates"
 	fi
@@ -146,7 +146,7 @@ case "$browser" in
 	test "$vers" -lt 2 && NEWTAB=''
 	"$browser_path" $NEWTAB "$@" &
 	;;
-    chrome|chromium)
+    google-chrome|chrome|chromium)
 	# Actual command for chromium is chromium-browser.
 	# No need to specify newTab. It's default in chromium
 	eval "$browser_path" "$@" &
-- 
1.7.2
