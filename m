From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 4/7] web--browse: support opera, seamonkey and elinks
Date: Fri,  3 Dec 2010 17:47:38 +0100
Message-ID: <1291394861-11989-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 17:56:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POYve-0004Oq-EF
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 17:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0LCQ4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 11:56:08 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:46724 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0LCQ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 11:56:07 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 11:56:07 EST
Received: by ewy10 with SMTP id 10so5680463ewy.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 08:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qjglzPYQPYXo39l0nG9KawzveHT1OvBM5+z11pubsic=;
        b=WVr5/GwXMZSckuKw+ntcnAVey+5dvjXuWPtpvrh7J1ha+hmY2PczdSnpRIQwtadGAR
         4LuHfHcdXSVTeQCZhAvPysx7t0L7c41klaBVcs6HtN9NMnllDmPPaQnmUviH67atqK3c
         nurUfKGWUK91GrpwjYWLhsfV3Q6Flp2IhDVmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aKetm60eWm/Bh8JwJMdsh0dcgxWzvc+4+TB1QvNnythW6pF87CPV7wOHESQ4KIkHsy
         yFTbJtnS3Q8Jh9I9DcJi3dxIf4TNAST/BO3F8+pAC9ZeRAfq89xYZD1lycM9AXBFaZ8v
         H1Tvu1lKR81+p8Vl5Z+Qk/I3YN2UenPy+PK34=
Received: by 10.216.38.84 with SMTP id z62mr784171wea.70.1291394891953;
        Fri, 03 Dec 2010 08:48:11 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id x15sm976057weq.7.2010.12.03.08.48.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 08:48:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162813>

The list of supported browsers is also updated in the documentation.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-web--browse.txt |    6 ++++++
 git-web--browse.sh                |   14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 51e8e0a..5d3ae07 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -20,8 +20,14 @@ The following browsers (or commands) are currently supported:
 
 * firefox (this is the default under X Window when not using KDE)
 * iceweasel
+* seamonkey
+* iceape
+* chromium
+* google-chrome
 * konqueror (this is the default under KDE, see 'Note about konqueror' below)
+* opera
 * w3m (this is the default outside graphical environments)
+* elinks
 * links
 * lynx
 * dillo
diff --git a/git-web--browse.sh b/git-web--browse.sh
index e48e30d..48e5a28 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,8 +31,8 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-	firefox | iceweasel | chrome | google-chrome | chromium |\
-	konqueror | w3m | links | lynx | dillo | open | start)
+	firefox | iceweasel | seamonkey | iceape | chrome | google-chrome | chromium |\
+	konqueror | opera | w3m | elinks | links | lynx | dillo | open | start)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
@@ -104,12 +104,12 @@ fi
 
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
-		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror w3m links lynx dillo"
+		browser_candidates="firefox iceweasel google-chrome chrome chromium konqueror opera seamonkey iceape w3m elinks links lynx dillo"
 		if test "$KDE_FULL_SESSION" = "true"; then
 			browser_candidates="konqueror $browser_candidates"
 		fi
 	else
-		browser_candidates="w3m links lynx"
+		browser_candidates="w3m elinks links lynx"
 	fi
 	# SECURITYSESSIONID indicates an OS X GUI login session
 	if test -n "$SECURITYSESSIONID" \
@@ -140,7 +140,7 @@ else
 fi
 
 case "$browser" in
-firefox|iceweasel)
+firefox|iceweasel|seamonkey|iceape)
 	# Check version because firefox < 2.0 does not support "-new-tab".
 	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
@@ -168,13 +168,13 @@ konqueror)
 		;;
 	esac
 	;;
-w3m|links|lynx|open)
+w3m|elinks|links|lynx|open)
 	eval "$browser_path" "$@"
 	;;
 start)
 	exec "$browser_path" '"web-browse"' "$@"
 	;;
-dillo)
+opera|dillo)
 	"$browser_path" "$@" &
 	;;
 *)
-- 
1.7.3.2.664.g294b8.dirty
