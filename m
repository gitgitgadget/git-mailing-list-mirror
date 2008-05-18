From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/Makefile: update makefile to remove new spaceful
	trash directory
Date: Sun, 18 May 2008 01:01:27 -0400
Message-ID: <20080518050126.GB31609@sigill.intra.peff.net>
References: <3559937.1211083293079.JavaMail.teamon@b304.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Sun May 18 07:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxb2K-0003nH-9G
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 07:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYERFBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 01:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYERFBa
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 01:01:30 -0400
Received: from peff.net ([208.65.91.99]:1757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbYERFB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 01:01:29 -0400
Received: (qmail 9127 invoked by uid 111); 18 May 2008 05:01:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 May 2008 01:01:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 May 2008 01:01:27 -0400
Content-Disposition: inline
In-Reply-To: <3559937.1211083293079.JavaMail.teamon@b304.teamon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82376>

On Sat, May 17, 2008 at 11:03:03PM -0500, drafnel@gmail.com wrote:

>  clean:
> -	$(RM) -r trash
> +	$(RM) -r 'trash directory'

Probably these non-code references should be squashed in as well. This
is the result of scanning "git grep trash". There are still a few
references to "trash" in test script comments, but they are more of the
"this goes in the trash directory" context and not "the name of this
directory is 'trash'".

t5516 has a few insteadOf tests that look like they might be
problematic, but aren't.

---
diff --git a/t/README b/t/README
index 73ed11b..70841a4 100644
--- a/t/README
+++ b/t/README
@@ -123,7 +123,7 @@ This test harness library does the following things:
    (or -h), it shows the test_description and exits.
 
  - Creates an empty test directory with an empty .git/objects
-   database and chdir(2) into it.  This directory is 't/trash'
+   database and chdir(2) into it.  This directory is 't/trash directory'
    if you must know, but I do not think you care.
 
  - Defines standard test helper functions for your scripts to
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5002fb0..6ba569f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -368,7 +368,7 @@ test_done () {
 	case "$test_failure" in
 	0)
 		# We could:
-		# cd .. && rm -fr trash
+		# cd .. && rm -fr 'trash directory'
 		# but that means we forbid any tests that use their own
 		# subdirectory from calling test_done without coming back
 		# to where they started from.
