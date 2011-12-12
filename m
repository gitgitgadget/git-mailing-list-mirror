From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] docs: mention "-k" for both forms of "git mv"
Date: Mon, 12 Dec 2011 02:50:31 -0500
Message-ID: <20111212075031.GA17532@sigill.intra.peff.net>
References: <20111212074503.GB16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 08:50:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0ex-0007Lf-DM
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 08:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab1LLHug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 02:50:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48000
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173Ab1LLHud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 02:50:33 -0500
Received: (qmail 30137 invoked by uid 107); 12 Dec 2011 07:57:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 02:57:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 02:50:31 -0500
Content-Disposition: inline
In-Reply-To: <20111212074503.GB16511@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186880>

The "git mv" synopsis shows two forms: renaming a file, and
moving files into a directory. They can both make use of the
"-k" flag to ignore errors, so mention it in both places.

Signed-off-by: Jeff King <peff@peff.net>
---
I can kind of see the rationale for the original content. Using "-k" is
a lot more useful if you are actually doing multiple renames, so it
makes more sense in the second form. But it is still useful in the first
form as a shorthand for "git mv 2>/dev/null || true".

I actually would rather just see:

  git mv [options] <source> <destination>
  git mv [options] <source>... <destination>

but if we are going to go that route, we should probably decide on a
style and convert all of the descriptions at the same time.

 Documentation/git-mv.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index b8db373..4be7a71 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -15,7 +15,7 @@ DESCRIPTION
 -----------
 This script is used to move or rename a file, directory or symlink.
 
- git mv [-f] [-n] <source> <destination>
+ git mv [-f] [-n] [-k] <source> <destination>
  git mv [-f] [-n] [-k] <source> ... <destination directory>
 
 In the first form, it renames <source>, which must exist and be either
-- 
1.7.8.13.g74677
