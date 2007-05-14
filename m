From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] git-am: Clean up the asciidoc documentation
Date: Mon, 14 May 2007 16:44:53 +0200
Message-ID: <11791538941022-git-send-email-frank@lichtenheld.de>
References: <1179153893715-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 16:45:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnbnQ-0005Np-Qv
	for gcvg-git@gmane.org; Mon, 14 May 2007 16:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbXENOpD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 10:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbXENOpD
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 10:45:03 -0400
Received: from mail.lenk.info ([217.160.134.107]:1633 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636AbXENOo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 10:44:57 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hnblw-0001wy-4N; Mon, 14 May 2007 16:43:36 +0200
Received: from p54b0d0fd.dip.t-dialin.net ([84.176.208.253] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HnbnB-0000hZ-R0; Mon, 14 May 2007 16:44:54 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HnbnC-0005kB-6Q; Mon, 14 May 2007 16:44:54 +0200
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1179153893715-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47246>

Add --keep to synopsis.
The synopsys used a mix of tabs and spaces, unified
to use only spaces.

Shuffle options around in synopsys and description
for grouping them logically.

Add more gitlink references to other commands.

Various grammatical fixes and improvements.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-am.txt |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index f0405a3..0bc9123 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,9 +9,10 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git-am' [--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
-         [--interactive] [--whitespace=<option>] [-C<n>] [-p<n>]
-	 <mbox>...
+'git-am' [--signoff] [--dotest=<dir>] [--keep] [--utf8 | --no-utf8]
+         [--3way] [--interactive] [--binary]
+         [--whitespace=<option>] [-C<n>] [-p<n>]
+         <mbox>...
 'git-am' [--skip | --resolved]
 
 DESCRIPTION
@@ -40,7 +41,7 @@ OPTIONS
 -u, --utf8::
 	Pass `-u` flag to `git-mailinfo` (see gitlink:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
-	are re-coded into UTF-8 encoding (configuration variable
+	is re-coded into UTF-8 encoding (configuration variable
 	`i18n.commitencoding` can be used to specify project's
 	preferred encoding if it is not UTF-8).
 +
@@ -51,30 +52,32 @@ default.   You could use `--no-utf8` to override this.
 	Pass `-n` flag to `git-mailinfo` (see
 	gitlink:git-mailinfo[1]).
 
--b, --binary::
-	Pass `--allow-binary-replacement` flag to `git-apply`
-	(see gitlink:git-apply[1]).
-
 -3, --3way::
 	When the patch does not apply cleanly, fall back on
 	3-way merge, if the patch records the identity of blobs
 	it is supposed to apply to, and we have those blobs
-	locally.
+	available locally.
 
---skip::
-	Skip the current patch.  This is only meaningful when
-	restarting an aborted patch.
+-b, --binary::
+	Pass `--allow-binary-replacement` flag to `git-apply`
+	(see gitlink:git-apply[1]).
 
 --whitespace=<option>::
-	This flag is passed to the `git-apply` program that applies
+	This flag is passed to the `git-apply` (see gitlink:git-apply[1])
+	program that applies
 	the patch.
 
 -C<n>, -p<n>::
-	These flags are passed to the `git-apply` program that applies
+	These flags are passed to the `git-apply` (see gitlink:git-apply[1])
+	program that applies
 	the patch.
 
 -i, --interactive::
-	Run interactively, just like git-applymbox.
+	Run interactively, just like `git-applymbox` (see gitlink:git-applymbox[1]).
+
+--skip::
+	Skip the current patch.  This is only meaningful when
+	restarting an aborted patch.
 
 -r, --resolved::
 	After a patch failure (e.g. attempting to apply
@@ -99,7 +102,7 @@ message, and commit author time is taken from the "Date: " line
 of the message.  The "Subject: " line is used as the title of
 the commit, after stripping common prefix "[PATCH <anything>]".
 It is supposed to describe what the commit is about concisely as
-a one line text.
+an one line text.
 
 The body of the message (iow, after a blank line that terminates
 RFC2822 headers) can begin with "Subject: " and "From: " lines
@@ -126,7 +129,7 @@ to crunch.  Upon seeing the first patch that does not apply, it
 aborts in the middle, just like 'git-applymbox' does.  You can
 recover from this in one of two ways:
 
-. skip the current one by re-running the command with '--skip'
+. skip the current patch by re-running the command with '--skip'
   option.
 
 . hand resolve the conflict in the working directory, and update
-- 
1.5.1.4
