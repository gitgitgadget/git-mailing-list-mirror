From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Make <identifier> lowercase in Documentation
Date: Thu, 17 Feb 2011 08:48:06 +0100
Message-ID: <d8246b3c2afe48505db13da63e01c0084346ade9.1297928789.git.git@drmicha.warpmail.net>
References: <7vbp2birzi.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 08:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppye1-0000ny-3c
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab1BQHvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 02:51:14 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42265 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840Ab1BQHvO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 02:51:14 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3ADC620978;
	Thu, 17 Feb 2011 02:51:13 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 17 Feb 2011 02:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=ovUEIbRBbOHfVoc2G+UIev1wcw8=; b=Mj0bqTwtALRTcmX70w7eGUdZl+OI1axAAe2Wj6BU4pocFVw1q299Gnkd0uJg8AleBrXCk5u61tRm+ZO7qKT+uL7sQqlUJ/9CdMOy5aZhj5gxBQrZTbc24/j23b6TUmrm6zzip0njAuuDS/0rBG8kTnjQ7/0aldONL/d4qnaYBUk=
X-Sasl-enc: uFZ8jBB9Ao94gbKCz6qwZ+t/aQt+2sKUiq11GiYMRrm9 1297929072
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8DAA14438AD;
	Thu, 17 Feb 2011 02:51:12 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <7vbp2birzi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167053>

Leaving uppercase abbreviations (e.g. URL) and an identifier named after
an upercase env variable (CVSROOT) in place, this adjusts the few
remaining cases and fixes an unidentified identifier along the way.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-remote-ext.txt     |   14 +++++++-------
 Documentation/git-remote-helpers.txt |    6 +++---
 Documentation/git-svn.txt            |    6 +++---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 2d65cfe..68263a6 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -7,17 +7,17 @@ git-remote-ext - Bridge smart transport to external command.
 
 SYNOPSIS
 --------
-git remote add nick "ext::<command>[ <arguments>...]"
+git remote add <nick> "ext::<command>[ <arguments>...]"
 
 DESCRIPTION
 -----------
-This remote helper uses the specified 'program' to connect
+This remote helper uses the specified '<command>' to connect
 to a remote git server.
 
-Data written to stdin of this specified 'program' is assumed
+Data written to stdin of the specified '<command>' is assumed
 to be sent to a git:// server, git-upload-pack, git-receive-pack
 or git-upload-archive (depending on situation), and data read
-from stdout of this program is assumed to be received from
+from stdout of <command> is assumed to be received from
 the same service.
 
 Command and arguments are separated by an unescaped space.
@@ -40,7 +40,7 @@ The following sequences have a special meaning:
 	git wants to invoke.
 
 '%G' (must be the first characters in an argument)::
-	This argument will not be passed to 'program'. Instead, it
+	This argument will not be passed to '<command>'. Instead, it
 	will cause the helper to start by sending git:// service requests to
 	the remote side with the service field set to an appropriate value and
 	the repository field set to rest of the argument. Default is not to send
@@ -50,7 +50,7 @@ This is useful if remote side is git:// server accessed over
 some tunnel.
 
 '%V' (must be first characters in argument)::
-	This argument will not be passed to 'program'. Instead it sets
+	This argument will not be passed to '<command>'. Instead it sets
 	the vhost field in the git:// service request (to rest of the argument).
 	Default is not to send vhost in such request (if sent).
 
@@ -76,7 +76,7 @@ EXAMPLES:
 ---------
 This remote helper is transparently used by git when
 you use commands such as "git fetch <URL>", "git clone <URL>",
-, "git push <URL>" or "git remote add nick <URL>", where <URL>
+, "git push <URL>" or "git remote add <nick> <URL>", where <URL>
 begins with `ext::`.  Examples:
 
 "ext::ssh -i /home/foo/.ssh/somekey user&#64;host.example %S 'foo/repo'"::
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 3a23477..51de895 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -201,12 +201,12 @@ REF LIST ATTRIBUTES
 
 OPTIONS
 -------
-'option verbosity' <N>::
+'option verbosity' <n>::
 	Changes the verbosity of messages displayed by the helper.
-	A value of 0 for N means that processes operate
+	A value of 0 for <n> means that processes operate
 	quietly, and the helper produces only error output.
 	1 is the default level of verbosity, and higher values
-	of N correspond to the number of -v flags passed on the
+	of <n> correspond to the number of -v flags passed on the
 	command line.
 
 'option progress' \{'true'|'false'\}::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 0ade2ce..e161a40 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -66,7 +66,7 @@ COMMANDS
 	Set the 'rewriteRoot' option in the [svn-remote] config.
 --rewrite-uuid=<UUID>;;
 	Set the 'rewriteUUID' option in the [svn-remote] config.
---username=<USER>;;
+--username=<user>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
 	transports (eg svn+ssh://), you must include the username in
@@ -443,8 +443,8 @@ OPTIONS
 	Only used with the 'init' command.
 	These are passed directly to 'git init'.
 
--r <ARG>::
---revision <ARG>::
+-r <arg>::
+--revision <arg>::
 	   Used with the 'fetch' command.
 +
 This allows revision ranges for partial/cauterized history
-- 
1.7.4.1.74.gf39475.dirty
