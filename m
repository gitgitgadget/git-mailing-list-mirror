From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Enable HAVE_DEV_TTY for Solaris
Date: Mon,  6 Aug 2012 23:07:42 -0400
Message-ID: <1344308862-24635-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <20120807003541.GA18219@sigill.intra.peff.net>
Cc: rctay89@gmail.com, schwab@linux-m68k.org,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Tue Aug 07 05:08:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sya9Q-0005IA-V6
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 05:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180Ab2HGDID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 23:08:03 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:54052 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab2HGDIB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 23:08:01 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54871 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Sya9I-0001PE-MK; Mon, 06 Aug 2012 23:08:00 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Sya9I-0006Pp-LF; Mon, 06 Aug 2012 23:08:00 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20120807003541.GA18219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203007>

Now that git_terminal_prompt can cleanly interact with /dev/tty on
Solaris, enable HAVE_DEV_TTY so that this code path is used for
credential reading instead of relying on the crippled getpass().

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---

This is a follow up to Jeff's patch that fixes git_terminal_prompt on
Solaris.  I don't have 5.6 or 5.7 for testing but I believe this
should be valid for both of those releases as well.


 Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 15d1319..6b0c961 100644
--- a/Makefile
+++ b/Makefile
@@ -1014,6 +1014,7 @@ ifeq ($(uname_S),SunOS)
 	NO_REGEX = YesPlease
 	NO_FNMATCH_CASEFOLD = YesPlease
 	NO_MSGFMT_EXTENDED_OPTIONS = YesPlease
+	HAVE_DEV_TTY = YesPlease
 	ifeq ($(uname_R),5.6)
 		SOCKLEN_T = int
 		NO_HSTRERROR = YesPlease
-- 
1.7.10.3
