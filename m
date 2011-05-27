From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] docs: update status --porcelain format
Date: Thu, 26 May 2011 22:31:51 -0400
Message-ID: <20110527023151.GB25362@sigill.intra.peff.net>
References: <30543.1305828072@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Jason Dominus <mjd@plover.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 04:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPmqT-0002u7-65
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 04:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab1E0Cby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 22:31:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59476
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab1E0Cbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 22:31:53 -0400
Received: (qmail 20666 invoked by uid 107); 27 May 2011 02:31:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 22:31:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 22:31:51 -0400
Content-Disposition: inline
In-Reply-To: <30543.1305828072@plover.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174596>

The --porcelain format was originally identical to the
--short format, but designed to be stable as the short
format changed. Since this was written, the short format
picked up a few incompatible niceties, but this description
was never changed.

Let's mention the differences. While we're at it, let's add
some sub-section headings to make the "output" section a
little easier to navigate.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-status.txt |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7702727..edacf6b 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -32,9 +32,10 @@ OPTIONS
 	Show the branch and tracking info even in short-format.
 
 --porcelain::
-	Give the output in a stable, easy-to-parse format for scripts.
-	Currently this is identical to --short output, but is guaranteed
-	not to change in the future, making it safe for scripts.
+	Give the output in an easy-to-parse format for scripts.
+	This is similar to the short output, but will remain stable
+	across git versions and regardless of user configuration. See
+	below for details.
 
 -u[<mode>]::
 --untracked-files[=<mode>]::
@@ -86,6 +87,9 @@ made relative to the current directory if you are working in a
 subdirectory (this is on purpose, to help cutting and pasting). See
 the status.relativePaths config option below.
 
+Short Format
+~~~~~~~~~~~~
+
 In the short-format, the status of each path is shown as
 
 	XY PATH1 -> PATH2
@@ -144,7 +148,22 @@ If -b is used the short-format status is preceded by a line
 
 ## branchname tracking info
 
-There is an alternate -z format recommended for machine parsing.  In
+Porcelain Format
+~~~~~~~~~~~~~~~~
+
+The porcelain format is similar to the short format, but is guaranteed
+not to change in a backwards-incompatible way between git versions or
+based on user configuration. This makes it ideal for parsing by scripts.
+The description of the short format above also describes the porcelain
+format, with a few exceptions:
+
+1. The user's color.status configuration is not respected; color will
+   always be off.
+
+2. The user's status.relativePaths configuration is not respected; paths
+   shown will always be relative to the repository root.
+
+There is also an alternate -z format recommended for machine parsing. In
 that format, the status field is the same, but some other things
 change.  First, the '->' is omitted from rename entries and the field
 order is reversed (e.g 'from -> to' becomes 'to from'). Second, a NUL
-- 
1.7.4.5.26.g0c6a2
