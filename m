From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 18/23] Test cases for RefSpec to RemoteRefUpdate conversions
Date: Sat, 28 Jun 2008 00:06:42 +0200
Message-ID: <1214604407-30572-19-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-14-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-15-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-16-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-17-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-18-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:10:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM96-0001Lw-Tl
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762813AbYF0WIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762699AbYF0WIY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:08:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761845AbYF0WIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:08:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=AeRtnJRmBH49vkSHzBfoIudV5Cv2AG3V27WQo10p0RE=;
        b=n0VVFbUFFqOIv1aMU4o5JdBRZnyl+AG2glmHKhGsdqD+PwLVFTo9DJcm7+6CfHZXta
         azniOtRlN06+EcVJhRK3LT40zfwzbLqniS7baRXkscUFnPx4+hsPIeDlAmOckl0PD4IX
         3/WccvOX7tUQ3o1f21ew57e/jQiUfPEqy6VU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A8EB0nGspgidcpqJQvb7c7hX89j45+/fwRCYTJAvL1QhYYNvASbAIVZNObNUckU1Kk
         zseWmooA8EmKnm7qQRzAwEXey9hKzR7nelSKE0KU0iYYzG7Ne2pKXviq0HYqPgFF3biq
         AQ4gbGOzINPDvX08k9ggnrLModoRQSh+/69Js=
Received: by 10.210.54.15 with SMTP id c15mr1592867eba.128.1214604497508;
        Fri, 27 Jun 2008 15:08:17 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id y34sm2450816iky.10.2008.06.27.15.08.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:08:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-18-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86657>

Tests for method Transport#findRemoteRefUpdatesFor().

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../org/spearce/jgit/transport/TransportTest.java  |  181 ++++++++++++++++++++
 1 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
new file mode 100644
index 0000000..47d738b
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/TransportTest.java
@@ -0,0 +1,181 @@
+/*
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.io.IOException;
+import java.util.Arrays;
+import java.util.Collection;
+import java.util.Collections;
+
+import org.spearce.jgit.lib.RepositoryConfig;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+public class TransportTest extends RepositoryTestCase {
+	private Transport transport;
+
+	private RemoteConfig remoteConfig;
+
+	@Override
+	public void setUp() throws Exception {
+		super.setUp();
+		final RepositoryConfig config = db.getConfig();
+		remoteConfig = new RemoteConfig(config, "test");
+		remoteConfig.addURI(new URIish("http://everyones.loves.git/u/2"));
+	}
+
+	/**
+	 * Test RefSpec to RemoteRefUpdate conversion with simple RefSpec - no
+	 * wildcard, no tracking ref in repo configuration.
+	 * 
+	 * @throws IOException
+	 */
+	public void testFindRemoteRefUpdatesNoWildcardNoTracking()
+			throws IOException {
+		transport = Transport.open(db, remoteConfig);
+		final Collection<RemoteRefUpdate> result = transport
+				.findRemoteRefUpdatesFor(Collections.nCopies(1, new RefSpec(
+						"refs/heads/master:refs/heads/x")));
+
+		assertEquals(1, result.size());
+		final RemoteRefUpdate rru = result.iterator().next();
+		assertNull(rru.getExpectedOldObjectId());
+		assertFalse(rru.isForceUpdate());
+		assertEquals("refs/heads/master", rru.getSrcRef());
+		assertEquals(db.resolve("refs/heads/master"), rru.getNewObjectId());
+		assertEquals("refs/heads/x", rru.getRemoteName());
+	}
+
+	/**
+	 * Test RefSpec to RemoteRefUpdate conversion with no-destination RefSpec
+	 * (destination should be set up for the same name as source).
+	 * 
+	 * @throws IOException
+	 */
+	public void testFindRemoteRefUpdatesNoWildcardNoDestination()
+			throws IOException {
+		transport = Transport.open(db, remoteConfig);
+		final Collection<RemoteRefUpdate> result = transport
+				.findRemoteRefUpdatesFor(Collections.nCopies(1, new RefSpec(
+						"+refs/heads/master")));
+
+		assertEquals(1, result.size());
+		final RemoteRefUpdate rru = result.iterator().next();
+		assertNull(rru.getExpectedOldObjectId());
+		assertTrue(rru.isForceUpdate());
+		assertEquals("refs/heads/master", rru.getSrcRef());
+		assertEquals(db.resolve("refs/heads/master"), rru.getNewObjectId());
+		assertEquals("refs/heads/master", rru.getRemoteName());
+	}
+
+	/**
+	 * Test RefSpec to RemoteRefUpdate conversion with wildcard RefSpec.
+	 * 
+	 * @throws IOException
+	 */
+	public void testFindRemoteRefUpdatesWildcardNoTracking() throws IOException {
+		transport = Transport.open(db, remoteConfig);
+		final Collection<RemoteRefUpdate> result = transport
+				.findRemoteRefUpdatesFor(Collections.nCopies(1, new RefSpec(
+						"+refs/heads/*:refs/heads/test/*")));
+
+		assertEquals(7, result.size());
+		boolean foundA = false;
+		boolean foundB = false;
+		for (final RemoteRefUpdate rru : result) {
+			if ("refs/heads/a".equals(rru.getSrcRef())
+					&& "refs/heads/test/a".equals(rru.getRemoteName()))
+				foundA = true;
+			if ("refs/heads/b".equals(rru.getSrcRef())
+					&& "refs/heads/test/b".equals(rru.getRemoteName()))
+				foundB = true;
+		}
+		assertTrue(foundA);
+		assertTrue(foundB);
+	}
+
+	/**
+	 * Test RefSpec to RemoteRefUpdate conversion for more than one RefSpecs
+	 * handling.
+	 * 
+	 * @throws IOException
+	 */
+	public void testFindRemoteRefUpdatesTwoRefSpecs() throws IOException {
+		transport = Transport.open(db, remoteConfig);
+		final RefSpec specA = new RefSpec("+refs/heads/a:refs/heads/b");
+		final RefSpec specC = new RefSpec("+refs/heads/c:refs/heads/d");
+		final Collection<RefSpec> specs = Arrays.asList(specA, specC);
+		final Collection<RemoteRefUpdate> result = transport
+				.findRemoteRefUpdatesFor(specs);
+
+		assertEquals(2, result.size());
+		boolean foundA = false;
+		boolean foundC = false;
+		for (final RemoteRefUpdate rru : result) {
+			if ("refs/heads/a".equals(rru.getSrcRef())
+					&& "refs/heads/b".equals(rru.getRemoteName()))
+				foundA = true;
+			if ("refs/heads/c".equals(rru.getSrcRef())
+					&& "refs/heads/d".equals(rru.getRemoteName()))
+				foundC = true;
+		}
+		assertTrue(foundA);
+		assertTrue(foundC);
+	}
+
+	/**
+	 * Test RefSpec to RemoteRefUpdate conversion for tracking ref search.
+	 * 
+	 * @throws IOException
+	 */
+	public void testFindRemoteRefUpdatesTrackingRef() throws IOException {
+		remoteConfig.addFetchRefSpec(new RefSpec(
+				"refs/heads/*:refs/remotes/test/*"));
+		transport = Transport.open(db, remoteConfig);
+		final Collection<RemoteRefUpdate> result = transport
+				.findRemoteRefUpdatesFor(Collections.nCopies(1, new RefSpec(
+						"+refs/heads/a:refs/heads/a")));
+
+		assertEquals(1, result.size());
+		final TrackingRefUpdate tru = result.iterator().next()
+				.getTrackingRefUpdate();
+		assertEquals("refs/remotes/test/a", tru.getLocalName());
+		assertEquals("refs/heads/a", tru.getRemoteName());
+		assertEquals(db.resolve("refs/heads/a"), tru.getNewObjectId());
+		assertNull(tru.getOldObjectId());
+	}
+}
-- 
1.5.5.3
