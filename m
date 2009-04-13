From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a bit
Date: Mon, 13 Apr 2009 13:23:49 -0500
Message-ID: <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQwY-0001J2-9r
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbZDMS3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbZDMS3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:29:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:26792 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZDMS3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:29:24 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2200665rvb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HdBB3GoinGYJ2ayGdJxPUbkKjrG8V+V1/BJVBH4ySjY=;
        b=k+sY+S6YZv6wCB6ds0AHmbUIDp2hKlWz1dbGquQ/rM3tEjunfbwiPLkvDp2CYSmeyF
         gycy349FDgldMJjPjaaQ1v4df/IHN+rXcYuFMZnHodIs8Te1uRV9LJmbUD3FSw8yCEN/
         7vX+6ibMS9XM/909C2CIr5yBvNReyqtv0+OaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Di0ZzvvQ7ahc+ft70p0GyW1yciEdK9dzoyX49AUnvvTvtJ1txQtk9BpIDFA0PkqsbE
         +ToS4/jmzvy6dnhHQ75TliufDydrlt2uzQpD9/uazO0j4UBAuTXUh59AAuKrb3N6WnpC
         05wfss3HCqVbIndGdJAOKmdhZgU3vRN4uiJXs=
Received: by 10.114.131.1 with SMTP id e1mr3277396wad.222.1239647362944;
        Mon, 13 Apr 2009 11:29:22 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.29.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:29:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116466>

All usage text lines should be < 80 characters.

A port number in --smtp-server is no longer handled,
so the suggestion has been removed.

--chain-reply-to doesn't take an argument.

The here-document quotation that defines the usage
text is now a single-quote form, so that no interpolation
takes place.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   17 +++++++------
 git-send-email.perl              |   49 +++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index e8a385b..5f7d640 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -74,8 +74,9 @@ See the CONFIGURATION section for 'sendemail.multiedit'.
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
@@ -106,7 +107,7 @@ Sending
 	the 'sendemail.envelopesender' configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
---smtp-encryption=<encryption>::
+--smtp-encryption=<type>::
 	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
 	value reverts to plain SMTP.  Default is the value of
 	'sendemail.smtpencryption'.
@@ -158,7 +159,7 @@ Automating
 	Output of this command must be single email address per line.
 	Default is the value of 'sendemail.cccmd' configuration value.
 
---[no-]chain-reply-to=<identifier>::
+--[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -166,11 +167,11 @@ Automating
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
@@ -214,7 +215,7 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 Administering
 ~~~~~~~~~~~~~
 
---confirm=<mode>::
+--confirm=<when>::
 	Confirm just before sending:
 +
 --
diff --git a/git-send-email.perl b/git-send-email.perl
index 172b53c..5f01ad2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -42,46 +42,51 @@ package main;
 
 
 sub usage {
-	print <<EOT;
+
+	# All printed lines should be less than 80 characters.
+
+	print <<'EOT';
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
+    --smtp-server          <host>  * Outgoing SMTP server.
+    --smtp-server-port     <port>  * Outgoing SMTP server port; symbolic too.
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
+    --cc-cmd            <command>  * Email Cc: via `<command> $patch_path`
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
