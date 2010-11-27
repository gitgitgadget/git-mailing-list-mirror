From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-web--browse: Add support for opera
Date: Sat, 27 Nov 2010 12:15:58 +0100
Message-ID: <1290856558-6122-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 27 12:16:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMIlL-0005GT-3X
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 12:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab0K0LQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 06:16:07 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61651 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab0K0LQG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 06:16:06 -0500
Received: by wwb17 with SMTP id 17so35205wwb.1
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 03:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fWyXzVllzFv+yvFgftoQMpI7RkZiVNC/+n5hgFUkFkU=;
        b=R9B6N1qgeZpBsGtPzLZykSuFwO7lc0VKmDYdcI+iWbizMqHD0zXmttW8+YskZO0kDi
         GD3dls3XMeI/nuvh6ixxbmOLsbcZ4yJAmfwcPkHob6GpjNNuMtlsl/u0GVqCJbYHgKby
         VOFAx7MFqwsU/o/ELeENelO8ltDaXgDTbwejE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NcWmbWVtObUdur/efkLO0HPW55tiNvczcHbPGLSk8HSQShXEhW/PKp8DlGILUeE5g/
         43fSukqRS5ht8FcV7A5FjQH/PauuPr10CLJK18mw30JxGfDA1X42pIWWJHZgmiUP0Rll
         q86znKIsyVEll9p8C1n/6Wh55SraDIjlGBduE=
Received: by 10.227.156.69 with SMTP id v5mr3491296wbw.189.1290856563743;
        Sat, 27 Nov 2010 03:16:03 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id q18sm1829535wbe.11.2010.11.27.03.16.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 03:16:02 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.184.gecaee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162307>

It's probably not the most widespread browser, it's free as in gratis
but not as in libre, but it's worth supporting regardless, especially
since it's a trivial addition.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-web--browse.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 3fc4166..eb70375 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
+		firefox | iceweasel | chrome | google-chrome | chromium | konqueror | opera | w3m | links | lynx | dillo | open | start)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -103,7 +103,7 @@ fi
 
 if test -z "$browser" ; then
     if test -n "$DISPLAY"; then
-	browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror w3m links lynx dillo"
+	browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror opera w3m links lynx dillo"
 	if test "$KDE_FULL_SESSION" = "true"; then
 	    browser_candidates="konqueror $browser_candidates"
 	fi
@@ -173,7 +173,7 @@ case "$browser" in
     start)
         exec "$browser_path" '"web-browse"' "$@"
         ;;
-    dillo)
+    opera|dillo)
 	"$browser_path" "$@" &
 	;;
     *)
-- 
1.7.3.2.184.gecaee
