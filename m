From: Evan Farrer <evan.farrer@gmail.com>
Subject: [PATCH/RFC] Add support for the google-chrome web browser
Date: Mon, 4 Jan 2010 22:19:06 -0700
Message-ID: <20100105051906.GA22799@efarrerlx.appsig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 06:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS1p6-0002Gq-H5
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 06:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab0AEFTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 00:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255Ab0AEFTM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 00:19:12 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:64360 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab0AEFTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 00:19:11 -0500
Received: by yxe26 with SMTP id 26so15310595yxe.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 21:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=sSlDOOpfkW9rsnA0mcWvUL55jMXQAQWX7D0NLnGvQ/E=;
        b=C0wADxBWvEHwL1AE4c2aNGEnM1tbkVDJV1XvMAzoxdeJvxb4HSI60pyrHArB4sxOP/
         mbgVtdDHU6KaJWkBdgedmk8kHpXXTWQkW+SvFxnqGzWHQRC2Y4jg1b9OdOvO3C0077Mq
         TBwYHRlMxhjT4XAgbRpkJG+HGzYqxWCKvcr/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=UZz9cjhdyXEFLoVBf5uwBMWKVkxb2OoH5L5cQOzY5J+GgG2NkFRuUFQ+qpxQMVJ6Wo
         1gCyay10hinuK+rhLpYVBZ9+eNwE18NJRzkOC3xlb4ydB4AcVxAt4/FU3m1LI+wKhncT
         Hu4JbXFTeCevUrN0SFZsqaHCzUd6wF7+Ao4og=
Received: by 10.150.254.7 with SMTP id b7mr9156627ybi.137.1262668750386;
        Mon, 04 Jan 2010 21:19:10 -0800 (PST)
Received: from localhost (173-127-235-168.pools.spcsdns.net [173.127.235.168])
        by mx.google.com with ESMTPS id 5sm7596776yxg.64.2010.01.04.21.19.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 21:19:09 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136162>

Signed-off-by: Evan Farrer <Evan.Farrer@gmail.com>
---
 Documentation/git-web--browse.txt |    1 +
 git-web--browse.sh                |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 278cf73..0994139 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -25,6 +25,7 @@ The following browsers (or commands) are currently supported:
 * links
 * lynx
 * dillo
+* google-chrome
 * open (this is the default under Mac OS X GUI)
 * start (this is the default under MinGW)
 
diff --git a/git-web--browse.sh b/git-web--browse.sh
index a578c3a..0664b9e 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open | start)
+		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | google-chrome | open | start)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -103,7 +103,7 @@ fi
 
 if test -z "$browser" ; then
     if test -n "$DISPLAY"; then
-	browser_candidates="firefox iceweasel konqueror w3m links lynx dillo"
+	browser_candidates="firefox iceweasel konqueror w3m links lynx dillo google-chrome"
 	if test "$KDE_FULL_SESSION" = "true"; then
 	    browser_candidates="konqueror $browser_candidates"
 	fi
@@ -162,7 +162,7 @@ case "$browser" in
 		;;
 	esac
 	;;
-    w3m|links|lynx|open)
+    w3m|links|lynx|google-chrome|open)
 	eval "$browser_path" "$@"
 	;;
     start)
-- 
1.6.6.78.gbd757c
