From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 2/8] Docs: send-email usage text much sexier
Date: Sat, 27 Sep 2008 20:09:50 -0500
Message-ID: <1222564196-84202-2-git-send-email-mfwitten@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 03:11:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjkoy-000293-8w
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 03:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbYI1BK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 21:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYI1BK1
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 21:10:27 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48428 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183AbYI1BKY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Sep 2008 21:10:24 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8S1A4jk006868;
	Sat, 27 Sep 2008 21:10:04 -0400 (EDT)
Received: from localhost.localdomain (97-116-110-244.mpls.qwest.net [97.116.110.244])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8S19usD017501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Sep 2008 21:10:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.g577ee
In-Reply-To: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96927>

All of the descriptions are aligned, shorter,
better arranged, and no line is greater than
78 columns.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 git-send-email.perl |   94 ++++++++++++++-------------------------------------
 1 files changed, 26 insertions(+), 68 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9f56162..2c31a25 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -40,74 +40,32 @@ sub usage {
 	print <<EOT;
 git send-email [options] <file | directory>...
 Options:
-   --from         Specify the "From:" line of the email to be sent.
-
-   --to           Specify the primary "To:" line of the email.
-
-   --cc           Specify an initial "Cc:" list for the entire series
-                  of emails.
-
-   --cc-cmd       Specify a command to execute per file which adds
-                  per file specific cc address entries
-
-   --bcc          Specify a list of email addresses that should be Bcc:
-		  on all the emails.
-
-   --compose      Use \$GIT_EDITOR, core.editor, \$EDITOR, or \$VISUAL to edit
-		  an introductory message for the patch series.
-
-   --subject      Specify the initial "Subject:" line.
-                  Only necessary if --compose is also set.  If --compose
-		  is not set, this will be prompted for.
-
-   --in-reply-to  Specify the first "In-Reply-To:" header line.
-                  Only used if --compose is also set.  If --compose is not
-		  set, this will be prompted for.
-
-   --[no-]chain-reply-to If set, the replies will all be to the previous
-                  email sent, rather than to the first email sent.
-                  Defaults to on.
-
-   --[no-]signed-off-by-cc Automatically add email addresses that appear in
-                 Signed-off-by: or Cc: lines to the cc: list. Defaults to on.
-
-   --identity     The configuration identity, a subsection to prioritise over
-                  the default section.
-
-   --smtp-server  If set, specifies the outgoing SMTP server to use.
-                  Defaults to localhost.  Port number can be specified here with
-                  hostname:port format or by using --smtp-server-port option.
-
-   --smtp-server-port Specify a port on the outgoing SMTP server to connect to.
-
-   --smtp-user    The username for SMTP-AUTH.
-
-   --smtp-pass    The password for SMTP-AUTH.
-
-   --smtp-encryption Specify 'tls' for STARTTLS encryption, or 'ssl' for SSL.
-                  Any other value disables the feature.
-
-   --smtp-ssl     Synonym for '--smtp-encryption=ssl'.  Deprecated.
-
-   --suppress-cc  Suppress the specified category of auto-CC.  The category
-		  can be one of 'author' for the patch author, 'self' to
-		  avoid copying yourself, 'sob' for Signed-off-by lines,
-		  'cccmd' for the output of the cccmd, or 'all' to suppress
-		  all of these.
-
-   --[no-]suppress-from Suppress sending emails to yourself. Defaults to off.
-
-   --[no-]thread       Specify that the "In-Reply-To:" header should be set on all
-                  emails. Defaults to on.
-
-   --quiet	  Make git-send-email less verbose.  One line per email
-                  should be all that is output.
-
-   --dry-run	  Do everything except actually send the emails.
-
-   --envelope-sender	Specify the envelope sender used to send the emails.
-
-   --no-validate	Don't perform any sanity checks on patches.
+   --identity              <str>  * Use the sendemail.<id> options.
+   --from                  <str>  * Email From:
+   --envelope-sender       <str>  * Email envelope sender.
+   --to                    <str>  * Email To:
+   --cc                    <str>  * Email Cc:
+   --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
+   --bcc                   <str>  * Email Bcc:
+   --subject               <str>  * Email "Subject:" (only if --compose).
+   --compose                      * Open an editor for introduction.
+   --in-reply-to           <str>  * First "In-Reply-To:" (only if --compose).
+   --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
+   --[no-]thread                  * Use In-Reply-To: field. Default on.
+   --[no-]signed-off-by-cc        * Actually send to Cc: and Signed-off-by:
+                                    addresses. Default on.
+   --suppress-cc           <str>  * author, self, sob, cccmd, all.
+   --[no-]suppress-from           * Don't send email to self. Default off.
+   --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
+                                    is optional. Default 'localhost'.
+   --smtp-server-port      <int>  * Outgoing SMTP server port.
+   --smtp-user             <str>  * The username for SMTP-AUTH.
+   --smtp-pass             <str>  * The password for SMTP-AUTH; not necessary.
+   --smtp-encryption       <str>  * tls or ssl; anything else disables.
+   --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+   --quiet                        * Output one line of info per email.
+   --dry-run                      * Don't actually send the emails.
+   --no-validate                  * Don't perform sanity checks on patches.
 
 EOT
 	exit(1);
-- 
1.6.0.2.304.g577ee
