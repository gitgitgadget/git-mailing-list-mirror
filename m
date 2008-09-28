From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 3/8] Docs: send-email: Man page option ordering
Date: Sat, 27 Sep 2008 20:09:51 -0500
Message-ID: <1222564196-84202-3-git-send-email-mfwitten@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-2-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 03:11:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjkov-000293-0w
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 03:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbYI1BKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 21:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYI1BKL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 21:10:11 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48376 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130AbYI1BKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Sep 2008 21:10:09 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8S1A5Em006887;
	Sat, 27 Sep 2008 21:10:05 -0400 (EDT)
Received: from localhost.localdomain (97-116-110-244.mpls.qwest.net [97.116.110.244])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8S19usE017501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Sep 2008 21:10:04 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.g577ee
In-Reply-To: <1222564196-84202-2-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96928>

Now the man page lists the options in alphabetical
order (in terms of the 'main' part of an option's
name).

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |  138 ++++++++++++++++++--------------------
 1 files changed, 66 insertions(+), 72 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9b31626..0c6dbf6 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -11,7 +11,6 @@ SYNOPSIS
 'git send-email' [options] <file|directory> [... file|directory]
 
 
-
 DESCRIPTION
 -----------
 Takes the patches given on the command line and emails them out.
@@ -45,19 +44,35 @@ The --cc option must be repeated for each user you want on the cc list.
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
-	entire patch series.
-	Default is the value of the 'sendemail.chainreplyto' configuration
-	value; if that is unspecified, default to --chain-reply-to.
+	entire patch series. Default is the value of the 'sendemail.chainreplyto'
+	configuration value; if that is unspecified, default to --chain-reply-to.
 
 --compose::
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
 
+--dry-run::
+	Do everything except actually send the emails.
+
+--envelope-sender::
+	Specify the envelope sender used to send the emails.
+	This is useful if your default address is not the address that is
+	subscribed to a list. If you use the sendmail binary, you must have
+	suitable privileges for the -f parameter. Default is the value of
+	the 'sendemail.envelopesender' configuration variable; if that is
+	unspecified, choosing the envelope sender is left to your MTA.
+
 --from::
 	Specify the sender of the emails.  This will default to
 	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
 	The user will still be prompted to confirm this entry.
 
+--identity::
+	A configuration identity. When given, causes values in the
+	'sendemail.<identity>' subsection to take precedence over
+	values in the 'sendemail' section. The default identity is
+	the value of 'sendemail.identity'.
+
 --in-reply-to::
 	Specify the contents of the first In-Reply-To header.
 	Subsequent emails will refer to the previous email
@@ -65,21 +80,40 @@ The --cc option must be repeated for each user you want on the cc list.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---[no-]signed-off-by-cc::
-        If this is set, add emails found in Signed-off-by: or Cc: lines to the
-        cc list.
-        Default is the value of 'sendemail.signedoffcc' configuration value;
-        if that is unspecified, default to --signed-off-by-cc.
-
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
 	all that is output.
 
---identity::
-	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
-	values in the 'sendemail' section. The default identity is
-	the value of 'sendemail.identity'.
+--[no-]signed-off-by-cc::
+        If this is set, add emails found in Signed-off-by: or Cc: lines to the
+        cc list. Default is the value of 'sendemail.signedoffcc' configuration
+        value; if that is unspecified, default to --signed-off-by-cc.
+
+--smtp-encryption::
+	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
+	value reverts to plain SMTP.  Default is the value of
+	'sendemail.smtpencryption'.
+
+--smtp-pass::
+	Password for SMTP-AUTH. The argument is optional: If no
+	argument is specified, then the empty string is used as
+	the password.
++
+In place of this option, the following configuration variables
+can be specified:
++
+--
+		* sendemail.smtppass
+		* sendemail.<identity>.smtppass (see sendemail.identity).
+--
++
+However, --smtp-pass always overrides these variables.
++
+Furthermore, passwords need not be specified in configuration files
+or on the command line. If a username has been specified (with
+--smtp-user or a configuration variable), but no password has been
+specified (with --smtp-pass or a configuration variable), then the
+user is prompted for a password while the input is masked for privacy.
 
 --smtp-server::
 	If set, specifies the outgoing SMTP server to use (e.g.
@@ -96,6 +130,9 @@ The --cc option must be repeated for each user you want on the cc list.
 	servers typically listen to smtp port 25 and ssmtp port
 	465).
 
+--smtp-ssl::
+	Legacy alias for '--smtp-encryption=ssl'.
+
 --smtp-user::
 	Username for SMTP-AUTH. In place of this option, the following
 	configuration variables can be specified:
@@ -110,45 +147,11 @@ However, --smtp-user always overrides these variables.
 If a username is not specified (with --smtp-user or a
 configuration variable), then authentication is not attempted.
 
---smtp-pass::
-	Password for SMTP-AUTH. The argument is optional: If no
-	argument is specified, then the empty string is used as
-	the password.
-+
-In place of this option, the following configuration variables
-can be specified:
-+
---
-		* sendemail.smtppass
-		* sendemail.<identity>.smtppass (see sendemail.identity).
---
-+
-However, --smtp-pass always overrides these variables.
-+
-Furthermore, passwords need not be specified in configuration files
-or on the command line. If a username has been specified (with
---smtp-user or a configuration variable), but no password has been
-specified (with --smtp-pass or a configuration variable), then the
-user is prompted for a password while the input is masked for privacy.
-
---smtp-encryption::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
-	value reverts to plain SMTP.  Default is the value of
-	'sendemail.smtpencryption'.
-
---smtp-ssl::
-	Legacy alias for '--smtp-encryption=ssl'.
-
 --subject::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---[no-]suppress-from::
-        If this is set, do not add the From: address to the cc: list.
-        Default is the value of 'sendemail.suppressfrom' configuration value;
-        if that is unspecified, default to --no-suppress-from.
-
 --suppress-cc::
 	Specify an additional category of recipients to suppress the
 	auto-cc of.  'self' will avoid including the sender, 'author' will
@@ -160,24 +163,24 @@ user is prompted for a password while the input is masked for privacy.
 	if that is unspecified, default to 'self' if --suppress-from is
 	specified, as well as 'sob' if --no-signed-off-cc is specified.
 
+--[no-]suppress-from::
+	If this is set, do not add the From: address to the cc: list.
+	Default is the value of 'sendemail.suppressfrom' configuration
+	value; if that is unspecified, default to --no-suppress-from.
+
 --[no-]thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
 	If disabled with "--no-thread", no emails will have the In-Reply-To
-	header set.
-	Default is the value of the 'sendemail.thread' configuration value;
-	if that is unspecified, default to --thread.
+	header set. Default is the value of the 'sendemail.thread' configuration
+	value; if that is unspecified, default to --thread.
 
---dry-run::
-	Do everything except actually send the emails.
-
---envelope-sender::
-	Specify the envelope sender used to send the emails.
-	This is useful if your default address is not the address that is
-	subscribed to a list. If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter.
-	Default is the value of the 'sendemail.envelopesender' configuration
-	variable; if that is unspecified, choosing the envelope sender is left
-	to your MTA.
+--to::
+	Specify the primary recipient of the emails generated. Generally, this
+	will be the upstream maintainer of the project involved. Default is the
+	value of the 'sendemail.to' configuration value; if that is unspecified,
+	this will be prompted for.
++
+The --to option must be repeated for each user you want on the to list.
 
 --no-validate::
 	Don't perform any sanity checks on patches.
@@ -188,15 +191,6 @@ user is prompted for a password while the input is masked for privacy.
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
1.6.0.2.304.g577ee
