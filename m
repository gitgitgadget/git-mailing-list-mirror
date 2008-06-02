From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 12/12] Add PackIndex specific tests, currently only iterators tests
Date: Mon,  2 Jun 2008 23:24:43 +0200
Message-ID: <1212441883-12990-13-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-8-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-9-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-10-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-11-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-12-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXu-0006g0-Aa
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbYFBVZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYFBVZc
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:32 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:45136 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbYFBVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:26 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1247612mue.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mVr/9UeI3M/K4Nk8uJNVJkU93sKootLL207iNkFb0kg=;
        b=lR2wshlFiwn9CXeYM7/yVg/VqAJPheaV9+iG3lxOz1eN1MLRZMK4bbyl1iGEChJqlF/iTigN0SnvrsDxRA+gGteUIcgBFTo1NQMd6VWdVj+hp3K88mBzcFpjePqfSj50eJVx6wdDw81kagvDLGtLCy2a4ZAj3D4yZuO0E83T+SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F1I28MehRZgE7PBKn/bxt7yDW0Ur/+H6PtmnBkmC0m4cw2tZWqPkHMF4T+5h/rLp2K6UOd76R+pmQjSHWW2JY7/D8gVDozzLVFAKeDI/uZOWZioylSvcTupKKf9XLWkLINAlYdokOOibDYf+jaiuFOTdIR/wMLLEQpOAqFwufAQ=
Received: by 10.103.18.19 with SMTP id v19mr5781807mui.113.1212441925040;
        Mon, 02 Jun 2008 14:25:25 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id e8sm21230486muf.0.2008.06.02.14.25.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:24 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-12-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83576>

Abstract PackIndexTest added, with specializations for v1 and v2
indexes. New dedicated indexes files for v2 tests created.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../tst/org/spearce/jgit/lib/PackIndexTest.java    |  152 ++++++++++++++++++++
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |   54 +++++++
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |   54 +++++++
 ...-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 |  Bin 0 -> 1296 bytes
 ...-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 |  Bin 0 -> 2976 bytes
 5 files changed, 260 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
 create mode 100644 org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
 create mode 100644 org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
new file mode 100644
index 0000000..c682153
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
@@ -0,0 +1,152 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.util.Iterator;
+import java.util.NoSuchElementException;
+
+import org.spearce.jgit.lib.PackIndex.MutableEntry;
+
+public abstract class PackIndexTest extends RepositoryTestCase {
+
+	PackIndex smallIdx;
+
+	PackIndex denseIdx;
+
+	public void setUp() throws Exception {
+		super.setUp();
+		smallIdx = PackIndex.open(getFileForPack34be9032());
+		denseIdx = PackIndex.open(getFileForPackdf2982f28());
+	}
+
+	/**
+	 * Return file with appropriate index version for prepared pack.
+	 * 
+	 * @return file with index
+	 */
+	public abstract File getFileForPack34be9032();
+
+	/**
+	 * Return file with appropriate index version for prepared pack.
+	 * 
+	 * @return file with index
+	 */
+	public abstract File getFileForPackdf2982f28();
+
+	/**
+	 * Test contracts of Iterator methods and this implementation remove()
+	 * limitations.
+	 */
+	public void testIteratorMethodsContract() {
+		Iterator<PackIndex.MutableEntry> iter = smallIdx.iterator();
+		while (iter.hasNext()) {
+			iter.next();
+		}
+
+		try {
+			iter.next();
+			fail("next() unexpectedly returned element");
+		} catch (NoSuchElementException x) {
+			// expected
+		}
+
+		try {
+			iter.remove();
+			fail("remove() shouldn't be implemented");
+		} catch (UnsupportedOperationException x) {
+			// expected
+		}
+	}
+
+	/**
+	 * Test results of iterator comparing to content of well-known (prepared)
+	 * small index.
+	 */
+	public void testIteratorReturnedValues1() {
+		Iterator<PackIndex.MutableEntry> iter = smallIdx.iterator();
+		assertEquals("4b825dc642cb6eb9a060e54bf8d69288fbee4904", iter.next()
+				.toString());
+		assertEquals("540a36d136cf413e4b064c2b0e0a4db60f77feab", iter.next()
+				.toString());
+		assertEquals("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259", iter.next()
+				.toString());
+		assertEquals("6ff87c4664981e4397625791c8ea3bbb5f2279a3", iter.next()
+				.toString());
+		assertEquals("82c6b885ff600be425b4ea96dee75dca255b69e7", iter.next()
+				.toString());
+		assertEquals("902d5476fa249b7abc9d84c611577a81381f0327", iter.next()
+				.toString());
+		assertEquals("aabf2ffaec9b497f0950352b3e582d73035c2035", iter.next()
+				.toString());
+		assertEquals("c59759f143fb1fe21c197981df75a7ee00290799", iter.next()
+				.toString());
+		assertFalse(iter.hasNext());
+	}
+
+	/**
+	 * Compare offset from iterator entries with output of findOffset() method.
+	 */
+	public void testCompareEntriesOffsetsWithFindOffsets() {
+		for (MutableEntry me : smallIdx) {
+			assertEquals(smallIdx.findOffset(me), me.getOffset());
+		}
+		for (MutableEntry me : denseIdx) {
+			assertEquals(denseIdx.findOffset(me), me.getOffset());
+		}
+	}
+
+	/**
+	 * Test partial results of iterator comparing to content of well-known
+	 * (prepared) dense index, that may need multi-level indexing.
+	 */
+	public void testIteratorReturnedValues2() {
+		Iterator<PackIndex.MutableEntry> iter = denseIdx.iterator();
+		while (!iter.next().toString().equals(
+				"0a3d7772488b6b106fb62813c4d6d627918d9181")) {
+			// just iterating
+		}
+		assertEquals("1004d0d7ac26fbf63050a234c9b88a46075719d3", iter.next()
+				.toString()); // same level-1
+		assertEquals("10da5895682013006950e7da534b705252b03be6", iter.next()
+				.toString()); // same level-1
+		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8", iter.next()
+				.toString());
+	}
+
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
new file mode 100644
index 0000000..dda3ef4
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
@@ -0,0 +1,54 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.File;
+
+public class PackIndexV1Test extends PackIndexTest {
+	@Override
+	public File getFileForPack34be9032() {
+		return new File(new File("tst"),
+				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
+	}
+
+	@Override
+	public File getFileForPackdf2982f28() {
+		return new File(new File("tst"),
+				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
new file mode 100644
index 0000000..8267e48
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
@@ -0,0 +1,54 @@
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
+package org.spearce.jgit.lib;
+
+import java.io.File;
+
+public class PackIndexV2Test extends PackIndexTest {
+	@Override
+	public File getFileForPack34be9032() {
+		return new File(new File("tst"),
+				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2");
+	}
+
+	@Override
+	public File getFileForPackdf2982f28() {
+		return new File(new File("tst"),
+				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2");
+	}
+}
diff --git a/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 b/org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
new file mode 100644
index 0000000000000000000000000000000000000000..1d45fa811a1855a9ac71e5237c8aa91e502e8224
GIT binary patch
literal 1296
zcmexg;-AdGz`z8=qk#AjU<4{9gh6473o`@dsEJvC=1~i?0?i@^vjO$d1G59|p%>-=
z+BG7ucT?;!r_*^m7bHCO{&8(m$M1KZEFoNG7tPK)+Ih42X!CLTZsRZiw>mnnChbt!
z^F&^+;^TY=7k)p;U=*4EqsA>|hMe>Cr0|I+URm#sSE^jxbZkfK{{-$Qs#{)7yZ1cy
zlxlS5^9i~kWxrHrSM8bGa!fG1s?kE8S$)-h{a<fpd)9LXm}=Wa=oT}_D3~6d9{JJv
zxBMd+$;!t2rOV$jXtK{dw9P4^Xl?kR{{l-YO*Yluad-asB!%0wTTA?O9Jh7!G6n{@
zG+>qt24*>6K48)T#v2b%%mOHO4anZ)^4)OqwtbqDxeqp+n<8~%>Q9^4X-{K**qkZ&
S;_1>JC~?!}g1(aBk0JolEO)B_

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 b/org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
new file mode 100644
index 0000000000000000000000000000000000000000..ccbf00e34fb8de324c5fe3f584b80bdb99e02df0
GIT binary patch
literal 2976
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
L#~L@=K-~WTG^vnn

literal 0
HcmV?d00001

-- 
1.5.5.1
