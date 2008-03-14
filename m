From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] Documention: web--browse: add info about
 "browser.<tool>.cmd" config var
Date: Fri, 14 Mar 2008 05:56:53 +0100
Message-ID: <20080314055653.0e84edbb.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Xavier Maillard <xma@gnu.org>
To: Junio Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1ti-0001Jd-Ct
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYCNEvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbYCNEvO
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:51:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:48030 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbYCNEvN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 00:51:13 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 09B301AB2C0;
	Fri, 14 Mar 2008 05:51:12 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id A0D781AB2B0;
	Fri, 14 Mar 2008 05:51:11 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77176>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt          |    5 +++++
 Documentation/git-web--browse.txt |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c72c2e6..2f1ca31 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -420,6 +420,11 @@ branch.<name>.rebase::
 	it unless you understand the implications (see linkgit:git-rebase[1]
 	for details).
 
+browser.<tool>.cmd::
+	Specify the command to invoke the specified browser. The
+	specified command is evaluated in shell with the URLs passed
+	as arguments. (See linkgit:git-web--browse[1].)
+
 browser.<tool>.path::
 	Override the path for the given tool that may be used to
 	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index df57d01..ddbae5b 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -27,6 +27,8 @@ The following browsers (or commands) are currently supported:
 * dillo
 * open (this is the default under Mac OS X GUI)
 
+Custom commands may also be specified.
+
 OPTIONS
 -------
 -b BROWSER|--browser=BROWSER::
@@ -43,16 +45,35 @@ OPTIONS
 CONFIGURATION VARIABLES
 -----------------------
 
+CONF.VAR (from -c option) and web.browser
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 The web browser can be specified using a configuration variable passed
 with the -c (or --config) command line option, or the 'web.browser'
 configuration variable if the former is not used.
 
+browser.<tool>.path
+~~~~~~~~~~~~~~~~~~~
+
 You can explicitly provide a full path to your preferred browser by
 setting the configuration variable 'browser.<tool>.path'. For example,
 you can configure the absolute path to firefox by setting
 'browser.firefox.path'. Otherwise, 'git-web--browse' assumes the tool
 is available in PATH.
 
+browser.<tool>.cmd
+~~~~~~~~~~~~~~~~~~
+
+When the browser, specified by options or configuration variables, is
+not among the supported ones, then the corresponding
+'browser.<tool>.cmd' configuration variable will be looked up. If this
+variable exists then "git web--browse" will treat the specified tool
+as a custom command and will use a shell eval to run the command with
+the URLs passed as arguments.
+
+Note about git config --global
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 Note that these configuration variables should probably be set using
 the '--global' flag, for example like this:
 
-- 
1.5.4.4.598.gcdb00b
