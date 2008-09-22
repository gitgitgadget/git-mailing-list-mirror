From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH RFC 4/6] Docs: send-email: Option order the same in man page and usage text
Date: Mon, 22 Sep 2008 10:58:13 -0500
Message-ID: <1222099095-50360-4-git-send-email-mfwitten@mit.edu>
References: <1222099095-50360-1-git-send-email-mfwitten@mit.edu>
 <1222099095-50360-2-git-send-email-mfwitten@mit.edu>
 <1222099095-50360-3-git-send-email-mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 18:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khnq7-0004K2-Jg
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 18:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbYIVP7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbYIVP7e
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:59:34 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:33438 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753181AbYIVP7c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2008 11:59:32 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8MFwSVv013068;
	Mon, 22 Sep 2008 11:58:28 -0400 (EDT)
Received: from localhost.localdomain (97-116-112-224.mpls.qwest.net [97.116.112.224])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8MFwGo5024990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Sep 2008 11:58:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.302.ge6cbd1
In-Reply-To: <1222099095-50360-3-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96491>

The man page seems to have listed the options in alphabetical order,
while the usage text used what I would consider an `intuitive' order
that groups related items and presents them in the order peopl think
when writing an email.

The manual page has been updated to mirror this order.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |   77 +++++++++++++++++++-------------------
 1 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9b31626..6031eb7 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -24,10 +24,19 @@ OPTIONS
 -------
 The options available are:
 
---bcc::
-	Specify a "Bcc:" value for each email.
+--from::
+	Specify the sender of the emails.  This will default to
+	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
+	The user will still be prompted to confirm this entry.
+
+--to::
+	Specify the primary recipient of the emails generated.
+	Generally, this will be the upstream maintainer of the
+	project involved.
+	Default is the value of the 'sendemail.to' configuration value;
+	if that is unspecified, this will be prompted for.
 +
-The --bcc option must be repeated for each user you want on the bcc list.
+The --to option must be repeated for each user you want on the to list.
 
 --cc::
 	Specify a starting "Cc:" value for each email.
@@ -40,23 +49,19 @@ The --cc option must be repeated for each user you want on the cc list.
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to::
-	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
-	the first will be sent as replies to the first email sent.  When using
-	this, it is recommended that the first file given be an overview of the
-	entire patch series.
-	Default is the value of the 'sendemail.chainreplyto' configuration
-	value; if that is unspecified, default to --chain-reply-to.
+--bcc::
+	Specify a "Bcc:" value for each email.
++
+The --bcc option must be repeated for each user you want on the bcc list.
 
 --compose::
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
 
---from::
-	Specify the sender of the emails.  This will default to
-	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
-	The user will still be prompted to confirm this entry.
+--subject::
+	Specify the initial subject of the email thread.
+	Only necessary if --compose is also set.  If --compose
+	is not set, this will be prompted for.
 
 --in-reply-to::
 	Specify the contents of the first In-Reply-To header.
@@ -65,16 +70,21 @@ The --cc option must be repeated for each user you want on the cc list.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
+--[no-]chain-reply-to::
+	If this is set, each email will be sent as a reply to the previous
+	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	the first will be sent as replies to the first email sent.  When using
+	this, it is recommended that the first file given be an overview of the
+	entire patch series.
+	Default is the value of the 'sendemail.chainreplyto' configuration
+	value; if that is unspecified, default to --chain-reply-to.
+
 --[no-]signed-off-by-cc::
         If this is set, add emails found in Signed-off-by: or Cc: lines to the
         cc list.
         Default is the value of 'sendemail.signedoffcc' configuration value;
         if that is unspecified, default to --signed-off-by-cc.
 
---quiet::
-	Make git-send-email less verbose.  One line per email should be
-	all that is output.
-
 --identity::
 	A configuration identity. When given, causes values in the
 	'sendemail.<identity>' subsection to take precedence over
@@ -139,16 +149,6 @@ user is prompted for a password while the input is masked for privacy.
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption=ssl'.
 
---subject::
-	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
-	is not set, this will be prompted for.
-
---[no-]suppress-from::
-        If this is set, do not add the From: address to the cc: list.
-        Default is the value of 'sendemail.suppressfrom' configuration value;
-        if that is unspecified, default to --no-suppress-from.
-
 --suppress-cc::
 	Specify an additional category of recipients to suppress the
 	auto-cc of.  'self' will avoid including the sender, 'author' will
@@ -159,6 +159,12 @@ user is prompted for a password while the input is masked for privacy.
 	Default is the value of 'sendemail.suppresscc' configuration value;
 	if that is unspecified, default to 'self' if --suppress-from is
 	specified, as well as 'sob' if --no-signed-off-cc is specified.
+	(Note: Linus uses 'self' and 'sob' interchangeably).
+
+--[no-]suppress-from::
+    If this is set, do not add the From: address to the cc: list.
+    Default is the value of 'sendemail.suppressfrom' configuration value;
+    if that is unspecified, default to --no-suppress-from.
 
 --[no-]thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
@@ -167,6 +173,10 @@ user is prompted for a password while the input is masked for privacy.
 	Default is the value of the 'sendemail.thread' configuration value;
 	if that is unspecified, default to --thread.
 
+--quiet::
+	Make git-send-email less verbose.  One line per email should be
+	all that is output.
+
 --dry-run::
 	Do everything except actually send the emails.
 
@@ -188,15 +198,6 @@ user is prompted for a password while the input is masked for privacy.
 			is due to SMTP limits as described by http://www.ietf.org/rfc/rfc2821.txt.
 --
 
---to::
-	Specify the primary recipient of the emails generated.
-	Generally, this will be the upstream maintainer of the
-	project involved.
-	Default is the value of the 'sendemail.to' configuration value;
-	if that is unspecified, this will be prompted for.
-+
-The --to option must be repeated for each user you want on the to list.
-
 
 CONFIGURATION
 -------------
-- 
1.6.0.2.302.ge6cbd1
