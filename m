From: Max Horn <max@quendi.de>
Subject: [PATCH 6/6] git-remote-helpers.txt: clarify ref list attributes, link to subsections
Date: Wed, 28 Nov 2012 00:03:27 +0100
Message-ID: <1354057407-83151-8-git-send-email-max@quendi.de>
References: <1354057407-83151-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUCT-0005AE-At
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755765Ab2K0XDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:03:49 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53657 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755488Ab2K0XDr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 18:03:47 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdUBt-0001yU-Tl; Wed, 28 Nov 2012 00:03:46 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
In-Reply-To: <1354057407-83151-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354057427;a49318a8;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210616>

The documentation was misleading in that it gave the impression that
'for-push' could be used as a ref attribute in the output of the
'list' command. That is wrong.

Also, explicitly point out the connection between the commands
'list' and 'options' on the one hand, and the sections
'REF LIST ATTRIBUTES' and 'OPTIONS' on the other hand.

Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/git-remote-helpers.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 023dcca..e1df01d 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -227,6 +227,8 @@ Support for this command is mandatory.
 	the name; unrecognized attributes are ignored. The list ends
 	with a blank line.
 +
+See REF LIST ATTRIBUTES for a list of currently defined options.
++
 Supported if the helper has the "fetch" or "import" capability.
 
 'list for-push'::
@@ -248,6 +250,8 @@ Supported if the helper has the "push" or "export" capability.
 	for it).  Options should be set before other commands,
 	and may influence the behavior of those commands.
 +
+See OPTIONS for a list of currently defined options.
++
 Supported if the helper has the "option" capability.
 
 'fetch' <sha1> <name>::
@@ -256,7 +260,7 @@ Supported if the helper has the "option" capability.
 	per line, terminated with a blank line.
 	Outputs a single blank line when all fetch commands in the
 	same batch are complete. Only objects which were reported
-	in the ref list with a sha1 may be fetched this way.
+	in the output of 'list' with a sha1 may be fetched this way.
 +
 Optionally may output a 'lock <file>' line indicating a file under
 GIT_DIR/objects/pack which is keeping a pack until refs can be
@@ -360,10 +364,9 @@ capabilities reported by the helper.
 REF LIST ATTRIBUTES
 -------------------
 
-'for-push'::
-	The caller wants to use the ref list to prepare push
-	commands.  A helper might chose to acquire the ref list by
-	opening a different type of connection to the destination.
+The 'list' command produces a list of refs in which each ref
+may be followed by a list of attributes. The following ref list
+attributes are defined.
 
 'unchanged'::
 	This ref is unchanged since the last import or fetch, although
@@ -371,6 +374,10 @@ REF LIST ATTRIBUTES
 
 OPTIONS
 -------
+
+The following options are defined and (under suitable circumstances)
+set by git if the remote helper has the 'option' capability.
+
 'option verbosity' <n>::
 	Changes the verbosity of messages displayed by the helper.
 	A value of 0 for <n> means that processes operate
-- 
1.8.0.393.gcc9701d
