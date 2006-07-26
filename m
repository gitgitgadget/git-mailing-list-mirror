From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/5] git-instaweb: store parameters in config
Date: Wed, 26 Jul 2006 16:33:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261633320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 16:34:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5kSK-0006KV-BZ
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 16:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWGZOdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 10:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWGZOdp
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 10:33:45 -0400
Received: from mail.gmx.net ([213.165.64.21]:15573 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751651AbWGZOdp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 10:33:45 -0400
Received: (qmail invoked by alias); 26 Jul 2006 14:33:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 26 Jul 2006 16:33:43 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24216>


It already reads the config for defaults, and now it also stores
the last passed parameters in the config.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-instaweb.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 9829c59..1d3ea73 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -78,6 +78,7 @@ do
 		;;
 	--local|-l)
 		local=true
+		git repo-config instaweb.local true
 		;;
 	-d|--httpd|--httpd=*)
 		case "$#,$1" in
@@ -89,6 +90,7 @@ do
 			httpd="$2"
 			shift ;;
 		esac
+		git-repo-config instaweb.httpd "$httpd"
 		;;
 	-b|--browser|--browser=*)
 		case "$#,$1" in
@@ -100,6 +102,7 @@ do
 			browser="$2"
 			shift ;;
 		esac
+		git-repo-config instaweb.browser "$browser"
 		;;
 	-p|--port|--port=*)
 		case "$#,$1" in
@@ -111,6 +114,7 @@ do
 			port="$2"
 			shift ;;
 		esac
+		git-repo-config instaweb.port "$port"
 		;;
 	-m|--module-path=*|--module-path)
 		case "$#,$1" in
@@ -122,6 +126,7 @@ do
 			module_path="$2"
 			shift ;;
 		esac
+		git-repo-config instaweb.modulepath "$module_path"
 		;;
 	*)
 		usage
-- 
1.4.2.rc2.g6a4e
