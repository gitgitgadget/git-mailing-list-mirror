From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] fetch/pull doc: untangle meaning of bare <ref>
Date: Sat, 11 May 2013 18:14:25 +0200
Message-ID: <20130511161425.GB3270@sigill.intra.peff.net>
References: <20130511161320.GA14990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:14:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCRN-000207-7f
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab3EKQO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:14:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:58749 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab3EKQO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:14:29 -0400
Received: (qmail 9245 invoked by uid 102); 11 May 2013 16:14:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 11:14:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 18:14:25 +0200
Content-Disposition: inline
In-Reply-To: <20130511161320.GA14990@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223978>

From: Thomas Rast <trast@inf.ethz.ch>

The documentation erroneously used the same wording for both fetch and
pull, stating that something will be merged even in git-fetch(1).

In addition, saying that "<ref> is equivalent to <ref>:" doesn't
really help anyone who still needs to read manpages.  Clarify what is
actually going on.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pull-fetch-param.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 94a9d32..6f5ca21 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -68,6 +68,11 @@ Some short-cut notations are also supported.
 +
 * `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
   it requests fetching everything up to the given tag.
-* A parameter <ref> without a colon is equivalent to
-  <ref>: when pulling/fetching, so it merges <ref> into the current
-  branch without storing the remote branch anywhere locally
+ifndef::git-pull[]
+* A parameter <ref> without a colon fetches that ref into FETCH_HEAD,
+endif::git-pull[]
+ifdef::git-pull[]
+* A parameter <ref> without a colon merges <ref> into the current
+  branch,
+endif::git-pull[]
+  while not storing the branch anywhere locally.
-- 
1.8.3.rc1.2.g12db477
