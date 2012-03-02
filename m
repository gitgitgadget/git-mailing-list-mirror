From: Thomas Rast <trast@student.ethz.ch>
Subject: [git wiki PATCH 3/3] "Improving the `git add -p` interface" project
Date: Fri, 2 Mar 2012 12:05:47 +0100
Message-ID: <544c3150818d928e14f40b362feb6dbabb348c9f.1330686331.git.trast@student.ethz.ch>
References: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:05:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3QJA-0001E5-42
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218Ab2CBLFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 06:05:53 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:18526 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab2CBLFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 06:05:51 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:05:44 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:05:47 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192023>

---
 SoC-2012-Ideas.md |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 59d1baf..b2cc475 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -140,3 +140,44 @@ The programming work will be in C, as it replaces a core part of git.
 
 Proposed by: Thomas Rast
 Possible mentor(s): Thomas Rast
+
+Improving the `git add -p` interface
+------------------------------------
+
+The interface behind `git {add|commit|stash|reset} {-p|-i}` is shared
+and called `git-add--interactive.perl`.    This project would mostly
+focus on the `--patch` side, as that seems to be much more widely
+used; however, improvements to `--interactive` would probably also be
+welcome.
+
+The `--patch` interface suffers from some design flaws caused largely
+by how the script grew:
+
+ * Application is not atomic: hitting Ctrl-C midway through patching
+   may still touch files.
+
+ * The terminal/line-based interface becomes a problem if diff hunks
+   are too long to fit in your terminal.
+
+ * Cannot go back and forth between files.
+
+ * Cannot reverse the direction of the patch.
+
+ * Cannot look at the diff in word-diff mode (and apply it normally).
+
+Due to the current design it is also pretty hard to add these features
+without adding to the mess.  Thus the project consists of:
+
+ * Come up with more ideas for features/improvements and discuss them
+   with users.
+
+ * Cleanly redesigning the main interface loop to allow for the above
+   features.
+
+ * Implement the new features.
+
+As the existing code is written in Perl, that is what you will use for
+this project.
+
+Proposed by: Thomas Rast
+Possible mentor(s): Thomas Rast
-- 
1.7.9.2.467.g7fee4
