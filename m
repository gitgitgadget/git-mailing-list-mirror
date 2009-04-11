From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 03/10] send-email: Cleanup the usage text and docs a bit
Date: Sat, 11 Apr 2009 14:08:21 -0500
Message-ID: <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsics-0001sP-F7
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758733AbZDKTKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758458AbZDKTKy
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:10:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:39785 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719AbZDKTKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:10:53 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1609508ywb.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pxNgIso0oBGfcVXVOFX3ZITTQYnX2/cl+pPDTLpUcAI=;
        b=OsaYTDH5xejLhR7dq14+Uov/tDrEimbIYwwri26rUNomuQDh8rMe2gBaLo9WDlOpDM
         D3TOxR5upRwPYjGywGj5tlkkkhIx4oCZAxqnc4UxthGpFkN7/MiWi10b8V2T901TAYm7
         ftkSEDDw2VmCjWGpMDLLWWP9vknGbwATAyUTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pwOKOoD5+ME2HUtDCK/8SSBODj+o6E3SlIb/d5/8O8WhmN8mCS6F9iQ1Kr+NFM6Cy3
         5vrExUHljIWYdlliREKFXHEXK3i0IWQk9dJeQufWZG0o+IG1k2jS+1ixIDODUGbuALNv
         p4AuBHJASerhJwOHpmT4CrUbKk4nHSDZSxzIw=
Received: by 10.100.138.10 with SMTP id l10mr4466682and.136.1239477050565;
        Sat, 11 Apr 2009 12:10:50 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.10.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:10:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116312>

All usage text lines should be < 80 characters.

A port number in --smtp-server is no longer handled,
so the suggestion has been removed.

--chain-reply-to doesn't take an argument.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   17 +++++++------
 git-send-email.perl              |   47 +++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 7cdbdd6..12845d6 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -77,8 +77,9 @@ Missing From or In-Reply-To headers will be prompted for.
 	the value GIT_COMMITTER_IDENT, as returned by "git var -l".
 	The user will still be prompted to confirm this entry.
 
---in-reply-to=<identifier>::
-	Specify the contents of the first In-Reply-To header.
+--in-reply-to=<message-id>::
+	Specify the contents of the first In-Reply-To header;
+	include the angle brackets '<' and '>'.
 	Subsequent emails will refer to the previous email
 	instead of this if --chain-reply-to is set (the default)
 	Only necessary if --compose is also set.  If --compose
@@ -109,7 +110,7 @@ Sending
 	the 'sendemail.envelopesender' configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
---smtp-encryption=<encryption>::
+--smtp-encryption=<type>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
 	'sendemail.smtpencryption'.
@@ -159,7 +160,7 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to=<identifier>::
+--[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -167,11 +168,11 @@ Automating
 	entire patch series. Default is the value of the 'sendemail.chainreplyto'
 	configuration value; if that is unspecified, default to --chain-reply-to.
 
---identity=<identity>::
+--identity=<id>::
 	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
+	'sendemail.<id>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
-	the value of 'sendemail.identity'.
+	the value of the 'sendemail.identity' configuration variable.
 
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in Signed-off-by: or Cc: lines to the
@@ -215,7 +216,7 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 Administering
 ~~~~~~~~~~~~~
 
---confirm=<mode>::
+--confirm=<when>::
 	Confirm just before sending:
 +
 --
diff --git a/git-send-email.perl b/git-send-email.perl
index 172b53c..fb3e712 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -42,46 +42,51 @@ package main;
 
 
 sub usage {
+
+	# All printed lines should be less than 80 characters.
+
 	print <<EOT;
 git send-email [options] <file | directory | rev-list options >
 
   Composing:
-    --from                  <str>  * Email From:
-    --to                    <str>  * Email To:
-    --cc                    <str>  * Email Cc:
-    --bcc                   <str>  * Email Bcc:
-    --subject               <str>  * Email "Subject:"
-    --in-reply-to           <str>  * Email "In-Reply-To:"
-    --annotate                     * Review each patch that will be sent in an editor.
+    --from              <address>  * Email From:
+    --to                <address>  * Email To:
+    --cc                <address>  * Email Cc:
+    --bcc               <address>  * Email Bcc:
+    --subject            <string>  * Email "Subject:"
+    --in-reply-to    <message-id>  * Email "In-Reply-To:"; include '<' and '>'.
+    --annotate                     * Review each patch that will be sent in
+                                     an editor.
     --compose                      * Open an editor for introduction.
 
   Sending:
-    --envelope-sender       <str>  * Email envelope sender.
-    --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
-                                     is optional. Default 'localhost'.
-    --smtp-server-port      <int>  * Outgoing SMTP server port.
-    --smtp-user             <str>  * Username for SMTP-AUTH.
-    --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
-    --smtp-encryption       <str>  * tls or ssl; anything else disables.
+    --envelope-sender   <address>  * Email envelope sender.
+    --smtp-server          <host>  * Outgoing SMTP server to use.
+    --smtp-server-port     <port>  * Outgoing SMTP server port.
+    --smtp-user        <username>  * Username for SMTP-AUTH.
+    --smtp-pass       [<password>] * Password for SMTP-AUTH; not necessary.
+    --smtp-encryption      <type>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
 
   Automating:
-    --identity              <str>  * Use the sendemail.<id> options.
-    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
-    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
+    --identity               <id>  * Use the sendemail.<id> options.
+    --cc-cmd            <command>  * Email Cc: via `<command> \$patch_path`
+    --suppress-cc      <category>  * author, self, sob, cc, cccmd, body,
+                                     bodycc, all.
+    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses.
+                                     Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
     --[no-]thread                  * Use In-Reply-To: field. Default on.
 
   Administering:
-    --confirm               <str>  * Confirm recipients before sending;
+    --confirm              <when>  * Confirm recipients before sending;
                                      auto, cc, compose, always, or never.
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Default on.
-    --[no-]format-patch            * understand any non optional arguments as
-                                     `git format-patch` ones.
+    --[no-]format-patch            * Understand any non-optional arguments as
+                                     `git format-patch' arguments.
 
 EOT
 	exit(1);
-- 
1.6.2.2.479.g2aec
