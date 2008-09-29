From: Michael Witten <mfwitten@MIT.EDU>
Subject: [RFC2 8/9] Docs: send-email: Create logical groupings for man text
Date: Mon, 29 Sep 2008 12:41:05 -0500
Message-ID: <1222710066-57768-1-git-send-email-mfwitten@mit.edu>
References: <20080929162935.GA2628@coredump.intra.peff.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 19:42:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkMlP-0000bk-Qq
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 19:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYI2RlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbYI2RlU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 13:41:20 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48386 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbYI2RlT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2008 13:41:19 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8THfBMT023776;
	Mon, 29 Sep 2008 13:41:11 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8THf69C009404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Sep 2008 13:41:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <20080929162935.GA2628@coredump.intra.peff.net>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97035>

The options are partitioned into more digestible groups.
Within these groups, the options are sorted alphabetically.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |  119 ++++++++++++++++++++++----------------
 1 files changed, 69 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0d6ac4a..d566c34 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -19,9 +19,12 @@ The header of the email is configurable by command line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
 enabled interface to provide the necessary information.
 
+
 OPTIONS
 -------
-The options available are:
+
+Composing
+~~~~~~~~~
 
 --bcc::
 	Specify a "Bcc:" value for each email. Default is the value of
@@ -34,46 +37,15 @@ The --bcc option must be repeated for each user you want on the bcc list.
 +
 The --cc option must be repeated for each user you want on the cc list.
 
---cc-cmd::
-	Specify a command to execute once per patch file which
-	should generate patch file specific "Cc:" entries.
-	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.cccmd' configuration value.
-
---[no-]chain-reply-to::
-	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
-	the first will be sent as replies to the first email sent.  When using
-	this, it is recommended that the first file given be an overview of the
-	entire patch series. Default is the value of the 'sendemail.chainreplyto'
-	configuration value; if that is unspecified, default to --chain-reply-to.
-
 --compose::
 	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
 	introductory message for the patch series.
 
---dry-run::
-	Do everything except actually send the emails.
-
---envelope-sender::
-	Specify the envelope sender used to send the emails.
-	This is useful if your default address is not the address that is
-	subscribed to a list. If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter. Default is the value of
-	the 'sendemail.envelopesender' configuration variable; if that is
-	unspecified, choosing the envelope sender is left to your MTA.
-
 --from::
 	Specify the sender of the emails.  This will default to
 	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
 	The user will still be prompted to confirm this entry.
 
---identity::
-	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
-	values in the 'sendemail' section. The default identity is
-	the value of 'sendemail.identity'.
-
 --in-reply-to::
 	Specify the contents of the first In-Reply-To header.
 	Subsequent emails will refer to the previous email
@@ -81,14 +53,30 @@ The --cc option must be repeated for each user you want on the cc list.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---quiet::
-	Make git-send-email less verbose.  One line per email should be
-	all that is output.
+--subject::
+	Specify the initial subject of the email thread.
+	Only necessary if --compose is also set.  If --compose
+	is not set, this will be prompted for.
 
---[no-]signed-off-by-cc::
-	If this is set, add emails found in Signed-off-by: or Cc: lines to the
-	cc list. Default is the value of 'sendemail.signedoffcc' configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+--to::
+	Specify the primary recipient of the emails generated. Generally, this
+	will be the upstream maintainer of the project involved. Default is the
+	value of the 'sendemail.to' configuration value; if that is unspecified,
+	this will be prompted for.
++
+The --to option must be repeated for each user you want on the to list.
+
+
+Sending
+~~~~~~~
+
+--envelope-sender::
+	Specify the envelope sender used to send the emails.
+	This is useful if your default address is not the address that is
+	subscribed to a list. If you use the sendmail binary, you must have
+	suitable privileges for the -f parameter. Default is the value of
+	the 'sendemail.envelopesender' configuration variable; if that is
+	unspecified, choosing the envelope sender is left to your MTA.
 
 --smtp-encryption::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
@@ -130,10 +118,34 @@ user is prompted for a password while the input is masked for privacy.
 	if a username is not specified (with '--smtp-user' or 'sendemail.smtpuser'),
 	then authentication is not attempted.
 
---subject::
-	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
-	is not set, this will be prompted for.
+
+Automating
+~~~~~~~~~~
+
+--cc-cmd::
+	Specify a command to execute once per patch file which
+	should generate patch file specific "Cc:" entries.
+	Output of this command must be single email address per line.
+	Default is the value of 'sendemail.cccmd' configuration value.
+
+--[no-]chain-reply-to::
+	If this is set, each email will be sent as a reply to the previous
+	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	the first will be sent as replies to the first email sent.  When using
+	this, it is recommended that the first file given be an overview of the
+	entire patch series. Default is the value of the 'sendemail.chainreplyto'
+	configuration value; if that is unspecified, default to --chain-reply-to.
+
+--identity::
+	A configuration identity. When given, causes values in the
+	'sendemail.<identity>' subsection to take precedence over
+	values in the 'sendemail' section. The default identity is
+	the value of 'sendemail.identity'.
+
+--[no-]signed-off-by-cc::
+	If this is set, add emails found in Signed-off-by: or Cc: lines to the
+	cc list. Default is the value of 'sendemail.signedoffcc' configuration
+	value; if that is unspecified, default to --signed-off-by-cc.
 
 --suppress-cc::
 	Specify an additional category of recipients to suppress the
@@ -157,13 +169,16 @@ user is prompted for a password while the input is masked for privacy.
 	header set. Default is the value of the 'sendemail.thread' configuration
 	value; if that is unspecified, default to --thread.
 
---to::
-	Specify the primary recipient of the emails generated. Generally, this
-	will be the upstream maintainer of the project involved. Default is the
-	value of the 'sendemail.to' configuration value; if that is unspecified,
-	this will be prompted for.
-+
-The --to option must be repeated for each user you want on the to list.
+
+Administering
+~~~~~~~~~~~~~
+
+--dry-run::
+	Do everything except actually send the emails.
+
+--quiet::
+	Make git-send-email less verbose.  One line per email should be
+	all that is output.
 
 --[no-]validate::
 	Perform sanity checks on patches.
@@ -180,6 +195,7 @@ default to '--validate'.
 
 CONFIGURATION
 -------------
+
 sendemail.aliasesfile::
 	To avoid typing long email addresses, point this to one or more
 	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
@@ -188,6 +204,7 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
@@ -195,10 +212,12 @@ Written by Ryan Anderson <ryan@michonline.com>
 git-send-email is originally based upon
 send_lots_of_email.pl by Greg Kroah-Hartman.
 
+
 Documentation
 --------------
 Documentation by Ryan Anderson
 
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.6.0.2.304.gdcf23.dirty
