From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 09/20] CRC32 PackIndex tests
Date: Sun, 15 Jun 2008 23:45:38 +0200
Message-ID: <1213566349-25395-10-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804o-0001nA-4S
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbYFOVqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbYFOVqe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:31828 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbYFOVqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:32 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958498ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dJBsYngx+F9ODvqV1Kx1Vwu2lo55md+/hqFgHEP1e1k=;
        b=qsUdFYpTziImsi1mZtUNVe3AF9icgWrHqGCbXMZAvNUugLuHU9ruWI4KkiNUvEnx/j
         DUK9JfxmXwZMw1vhyeVNxAZ2ThOWBGVE7YLbJoPMp5WTdZdMS0mm5mlbTn/aJPDURi0m
         cxzymjiJp9sfTXdW1A2b5jaALAPOMWi1w3iSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NdPRHxol/UpaO1lkcHNA9jyUrR1WCtdsLde5kbSoAfogHBnhhzVZUVFaV3FPNnpm5a
         nwJWnFnPgeSX1CoEtxEmE4ZW6brCKqYH5mBBGveng/3kg3k02ROZyJoLSC6gM3ymlC2v
         DtyqRp9toplTYID2JTVrdziM/iDt1ZwvLej70=
Received: by 10.151.101.20 with SMTP id d20mr9429683ybm.104.1213566391906;
        Sun, 15 Jun 2008 14:46:31 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id p6sm15749495qbp.17.2008.06.15.14.46.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-9-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85134>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../tst/org/spearce/jgit/lib/PackIndexTest.java    |   10 ++++++
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |   19 ++++++++++++
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |   30 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
index c682153..fd7b646 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
@@ -41,6 +41,7 @@ import java.io.File;
 import java.util.Iterator;
 import java.util.NoSuchElementException;
 
+import org.spearce.jgit.errors.MissingObjectException;
 import org.spearce.jgit.lib.PackIndex.MutableEntry;
 
 public abstract class PackIndexTest extends RepositoryTestCase {
@@ -70,6 +71,15 @@ public abstract class PackIndexTest extends RepositoryTestCase {
 	public abstract File getFileForPackdf2982f28();
 
 	/**
+	 * Verify CRC32 support.
+	 * 
+	 * @throws MissingObjectException
+	 * @throws UnsupportedOperationException
+	 */
+	public abstract void testCRC32() throws MissingObjectException,
+			UnsupportedOperationException;
+
+	/**
 	 * Test contracts of Iterator methods and this implementation remove()
 	 * limitations.
 	 */
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
index dda3ef4..bb9e83e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
@@ -39,6 +39,8 @@ package org.spearce.jgit.lib;
 
 import java.io.File;
 
+import org.spearce.jgit.errors.MissingObjectException;
+
 public class PackIndexV1Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
@@ -51,4 +53,21 @@ public class PackIndexV1Test extends PackIndexTest {
 		return new File(new File("tst"),
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
 	}
+
+	/**
+	 * Verify CRC32 - V1 should not index anything.
+	 * 
+	 * @throws MissingObjectException
+	 */
+	@Override
+	public void testCRC32() throws MissingObjectException {
+		assertFalse(smallIdx.hasCRC32Support());
+		try {
+			smallIdx.findCRC32(ObjectId
+					.fromString("4b825dc642cb6eb9a060e54bf8d69288fbee4904"));
+			fail("index V1 shouldn't support CRC");
+		} catch (UnsupportedOperationException x) {
+			// expected
+		}
+	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
index 8267e48..b21a7e9 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
@@ -39,6 +39,8 @@ package org.spearce.jgit.lib;
 
 import java.io.File;
 
+import org.spearce.jgit.errors.MissingObjectException;
+
 public class PackIndexV2Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
@@ -51,4 +53,32 @@ public class PackIndexV2Test extends PackIndexTest {
 		return new File(new File("tst"),
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2");
 	}
+
+	/**
+	 * Verify CRC32 indexing.
+	 * 
+	 * @throws UnsupportedOperationException
+	 * @throws MissingObjectException
+	 */
+	@Override
+	public void testCRC32() throws MissingObjectException,
+			UnsupportedOperationException {
+		assertTrue(smallIdx.hasCRC32Support());
+		assertEquals(0x00000000C2B64258l, smallIdx.findCRC32(ObjectId
+				.fromString("4b825dc642cb6eb9a060e54bf8d69288fbee4904")));
+		assertEquals(0x0000000072AD57C2l, smallIdx.findCRC32(ObjectId
+				.fromString("540a36d136cf413e4b064c2b0e0a4db60f77feab")));
+		assertEquals(0x00000000FF10A479l, smallIdx.findCRC32(ObjectId
+				.fromString("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259")));
+		assertEquals(0x0000000034B27DDCl, smallIdx.findCRC32(ObjectId
+				.fromString("6ff87c4664981e4397625791c8ea3bbb5f2279a3")));
+		assertEquals(0x000000004743F1E4l, smallIdx.findCRC32(ObjectId
+				.fromString("82c6b885ff600be425b4ea96dee75dca255b69e7")));
+		assertEquals(0x00000000640B358Bl, smallIdx.findCRC32(ObjectId
+				.fromString("902d5476fa249b7abc9d84c611577a81381f0327")));
+		assertEquals(0x000000002A17CB5El, smallIdx.findCRC32(ObjectId
+				.fromString("aabf2ffaec9b497f0950352b3e582d73035c2035")));
+		assertEquals(0x000000000B3B5BA6l, smallIdx.findCRC32(ObjectId
+				.fromString("c59759f143fb1fe21c197981df75a7ee00290799")));
+	}
 }
-- 
1.5.5.1
