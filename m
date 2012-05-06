From: Jeff King <peff@peff.net>
Subject: [PATCH] correct git-status Porcelain Format documentation
Date: Sun, 6 May 2012 09:29:59 -0400
Message-ID: <20120506132959.GA28214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 15:30:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR1Y2-0007ms-Sb
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 15:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab2EFNaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 09:30:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59654
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab2EFNaB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 09:30:01 -0400
Received: (qmail 10913 invoked by uid 107); 6 May 2012 13:30:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 May 2012 09:30:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2012 09:29:59 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197184>

From: Zak Johnson <zakj@nox.cx>

The existing documentation implies that "git status --porcelain" has a branch
line while "git status --porcelain -z" does not; in fact, neither includes a
branch line.

Signed-off-by: Zak Johnson <zakj@nox.cx>
---
This was forward to me by the original author, who had trouble posting
to the list. So I'm trying it (I didn't see anything from the taboo list
in the patch, but we'll see...).

The patch itself looks obviously correct and describes the current
behavior. But I have to wonder: the --short format will also not produce
the branch line unless you provide "-b". So why is it that the porcelain
format does not respect "-b", since anybody who asked for it would
obviously be expecting to find and parse it?

Should this bit of documentation be dropped in favor of just making "-b"
work properly?

 Documentation/git-status.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2883a28..3e12020 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -176,6 +176,8 @@ format, with a few exceptions:
 2. The user's status.relativePaths configuration is not respected; paths
    shown will always be relative to the repository root.
 
+3. There is no branch line.
+
 There is also an alternate -z format recommended for machine parsing. In
 that format, the status field is the same, but some other things
 change.  First, the '\->' is omitted from rename entries and the field
@@ -184,7 +186,7 @@ order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
-backslash-escaping is performed. Fourth, there is no branch line.
+backslash-escaping is performed.
 
 CONFIGURATION
 -------------
-- 
1.7.10.1.14.gb97aca1
