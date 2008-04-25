From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] documentation: web--browse: add a note about konqueror
Date: Fri, 25 Apr 2008 08:25:41 +0200
Message-ID: <20080425082541.968266fd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Fri Apr 25 08:21:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpHJF-0001PZ-5i
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 08:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbYDYGUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 02:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755440AbYDYGUe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 02:20:34 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51595 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755401AbYDYGUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 02:20:33 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 81DA61AB2E6;
	Fri, 25 Apr 2008 08:20:32 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 317D61AB2D7;
	Fri, 25 Apr 2008 08:20:32 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80326>

This note explains how to work around the fact that we try to use
kfmclient to launch konqueror.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-web--browse.txt |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index ddbae5b..92ef574 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -20,7 +20,7 @@ The following browsers (or commands) are currently supported:
 
 * firefox (this is the default under X Window when not using KDE)
 * iceweasel
-* konqueror (this is the default under KDE)
+* konqueror (this is the default under KDE, see 'Note about konqueror' below)
 * w3m (this is the default outside graphical environments)
 * links
 * lynx
@@ -71,6 +71,28 @@ variable exists then "git web--browse" will treat the specified tool
 as a custom command and will use a shell eval to run the command with
 the URLs passed as arguments.
 
+Note about konqueror
+--------------------
+
+When 'konqueror' is specified by the a command line option or a
+configuration variable, we launch 'kfmclient' to try to open the HTML
+man page on an already opened konqueror in a new tab if possible.
+
+For consistency, we also try such a trick if 'brower.konqueror.path' is
+set to something like 'A_PATH_TO/konqueror'. That means we will try to
+launch 'A_PATH_TO/kfmclient' instead.
+
+If you really want to use 'konqueror', then you can use something like
+the following:
+
+------------------------------------------------
+	[web]
+		browser = konq
+
+	[browser "konq"]
+		cmd = A_PATH_TO/konqueror
+------------------------------------------------
+
 Note about git config --global
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.5.5.130.g3ab1e.dirty
