From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/12] Correct name of fileRead member of Config class
Date: Tue, 21 Jul 2009 13:19:20 -0700
Message-ID: <1248207570-13880-3-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpt-0001jT-QU
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbZGUUTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756136AbZGUUTh
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:37 -0400
Received: from george.spearce.org ([209.20.77.23]:59242 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114AbZGUUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id CDC3838222; Tue, 21 Jul 2009 20:19:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A5C80381FD;
	Tue, 21 Jul 2009 20:19:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123696>

The setter method is called setFileRead() so the member should
have been called fileRead, not readFile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index c2d5c6e..a31796c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -60,8 +60,7 @@
  * file.
  */
 public abstract class Config {
-
-	private boolean readFile;
+	private boolean fileRead;
 
 	private List<Entry> entries;
 
@@ -96,7 +95,7 @@ protected Config(Config base) {
 	 *            true if file does not need loading
 	 */
 	protected void setFileRead(boolean ok) {
-		readFile = ok;
+		fileRead = ok;
 	}
 
 	/**
@@ -404,7 +403,7 @@ private String getRawString(final String section, final String subsection,
 	}
 
 	private void ensureLoaded() {
-		if (!readFile) {
+		if (!fileRead) {
 			try {
 				load();
 			} catch (FileNotFoundException err) {
@@ -703,7 +702,7 @@ protected void printConfig(final PrintWriter r) {
 	 */
 	public void load() throws IOException {
 		clear();
-		readFile = true;
+		fileRead = true;
 		final BufferedReader r = new BufferedReader(new InputStreamReader(
 				openInputStream(), Constants.CHARSET));
 		try {
-- 
1.6.4.rc1.186.g60aa0c
