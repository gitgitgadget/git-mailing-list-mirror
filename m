From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PoC PATCH JGIT 2/2] PoC Freenet transport
Date: Mon,  9 Mar 2009 11:36:05 +0800
Message-ID: <1236569765-8882-3-git-send-email-j16sdiz+freenet@gmail.com>
References: <1236569765-8882-1-git-send-email-j16sdiz+freenet@gmail.com>
	<1236569765-8882-2-git-send-email-j16sdiz+freenet@gmail.com>
Reply-To: Discussion of development issues <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Daniel Cheng \(aka SDiZ\)" <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org,
	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org Mon Mar 09 04:38:05 2009
Return-path: <devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Envelope-to: gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from emu.freenetproject.org ([89.16.176.201] helo=freenetproject.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgWJY-0005lC-HL
	for gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Mar 2009 04:38:04 +0100
Received: by freenetproject.org (Postfix, from userid 108)
	id 2F60C47872B; Mon,  9 Mar 2009 03:36:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	emu.dh.bytemark.co.uk
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=5.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,SPF_PASS autolearn=unavailable version=3.1.7-deb3
Received: from emu.dh.bytemark.co.uk (localhost.localdomain [127.0.0.1])
	by freenetproject.org (Postfix) with ESMTP id 996FF47870D;
	Mon,  9 Mar 2009 03:36:38 +0000 (UTC)
X-Original-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Delivered-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Received: by freenetproject.org (Postfix, from userid 108)
	id 105FC478725; Mon,  9 Mar 2009 03:36:24 +0000 (UTC)
Received-SPF: pass (emu.dh.bytemark.co.uk: domain of j16sdiz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
	designates 209.85.198.236 as permitted sender)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by freenetproject.org (Postfix) with ESMTP id 33306478720
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Mon,  9 Mar 2009 03:36:17 +0000 (UTC)
Received: by rv-out-0506.google.com with SMTP id g9so1590623rvb.6
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Sun, 08 Mar 2009 20:36:16 -0700 (PDT)
Received: by 10.143.1.12 with SMTP id d12mr2320797wfi.203.1236569776071;
	Sun, 08 Mar 2009 20:36:16 -0700 (PDT)
Received: from localhost.localdomain (n058153086094.netvigator.com
	[58.153.86.94])
	by mx.google.com with ESMTPS id 29sm7732622wfg.53.2009.03.08.20.36.14
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Sun, 08 Mar 2009 20:36:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <1236569765-8882-2-git-send-email-j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-BeenThere: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussion of development issues <devl.freenetproject.org>
List-Unsubscribe: <http://emu.freenetproject.org/cgi-bin/mailman/listinfo/devl>, 
	<mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://emu.freenetproject.org/pipermail/devl>
List-Post: <mailto:devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
List-Help: <mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=help>
List-Subscribe: <http://emu.freenetproject.org/cgi-bin/mailman/listinfo/devl>, 
	<mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=subscribe>
Sender: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Errors-To: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112675>


Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../src/org/spearce/jgit/transport/Transport.java  |    3 +
 .../org/spearce/jgit/transport/TransportFcp2.java  |  436 ++++++++++++++++++++
 2 files changed, 439 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/TransportFcp2.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index a0a2575..3fc1735 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -206,6 +206,9 @@ else if (TransportGitAnon.canHandle(remote))
 		else if (TransportAmazonS3.canHandle(remote))
 			return new TransportAmazonS3(local, remote);
 
+		else if (TransportFcp2.canHandle(remote))
+			return new TransportFcp2(local, remote);
+		
 		else if (TransportBundleFile.canHandle(remote))
 			return new TransportBundleFile(local, remote);
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportFcp2.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportFcp2.java
new file mode 100644
index 0000000..ed12995
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportFcp2.java
@@ -0,0 +1,436 @@
+/*
+ * Copyright (C) 2009, CHENG Yuk-Pong, Daniel <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
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
+import java.io.BufferedReader;
+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.OutputStream;
+import java.net.URISyntaxException;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.Map;
+import java.util.TreeMap;
+
+import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.PackProtocolException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.NullProgressMonitor;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Ref.Storage;
+import org.spearce.jgit.transport.fcpv2.FCPConnection;
+
+/**
+ * Transport over Freenet Client Protocol 2.0
+ * <p>
+ * The Freenet transport is similar to HTTP Transport, but more restrictive. To
+ * workaround the freenet restrictions, path separator ('/') are replaced with
+ * dash ('-').
+ *<p>
+ * URI are in forms of <code>fcp://USK@PUBLIC_KEY/identifier</code> (read-only)
+ * or <code>fcp://USK@PUBLIC_KEY^PRIVATE_KEY/identifier</code>. The identifier
+ * must not contain any slash. The Freenet URI should begin with
+ * <code>SSK@</code>, all updatable component are converted to <code>USK@</code>
+ * internally.
+ * 
+ * @see WalkFetchConnection
+ */
+class TransportFcp2 extends WalkTransport {
+	static boolean canHandle(final URIish uri) {
+		if (!uri.isRemote())
+			return false;
+		final String s = uri.getScheme();
+		return "fcp".equals(s);
+	}
+
+	private final String publicKey;
+
+	private final String privateKey;
+
+	private final String identifier;
+
+	private FCPConnection fcp;
+
+	TransportFcp2(final Repository local, final URIish uri)
+			throws NotSupportedException {
+		super(local, uri);
+
+		String uriString = uri.toString();
+		if (!uriString.startsWith("fcp://SSK@"))
+			throw new NotSupportedException("URL not SSK@ " + uri);
+
+		String[] uriSegment = uriString.split("\\/");
+		if (uriSegment.length != 4)
+			throw new NotSupportedException("Invalid URL " + uri);
+
+		String[] keys = uriSegment[2].split("\\^");
+		if (keys.length > 2)
+			throw new NotSupportedException("Invalid URL " + uri);
+		publicKey = keys[0].substring(4); // Remove 'SSK@' prefix
+		privateKey = (keys.length == 2) ? keys[1] : null;
+		System.out.println(privateKey);
+		identifier = uriSegment[3];
+	}
+
+	@Override
+	public FetchConnection openFetch() throws TransportException {
+		try {
+			fcp = new FCPConnection();
+			fcp.connect();
+			fcp.hello("JGit-" + toString());
+
+			final Fcp2ObjectDB c = new Fcp2ObjectDB("/objects", false);
+			final WalkFetchConnection r = new WalkFetchConnection(this, c);
+			r.available(c.readAdvertisedRefs());
+			return r;
+		} catch (IOException e) {
+			throw new TransportException("IO Error" + e, e);
+		}
+	}
+
+	@Override
+	public PushConnection openPush() throws TransportException {
+		try {
+			fcp = new FCPConnection();
+			fcp.connect();
+			fcp.hello("JGit-" + toString());
+
+			final Fcp2ObjectDB c = new Fcp2ObjectDB("/objects", false);
+			final WalkPushConnection r = new WalkPushConnection(this, c);
+			r.available(c.readAdvertisedRefs());
+			return r;
+		} catch (IOException e) {
+			throw new TransportException("IO Error" + e, e);
+		}
+	}
+
+	@Override
+	public void close() {
+		try {
+			if (fcp != null)
+				fcp.close();
+		} catch (IOException e) {
+			// Fall through.
+		}
+		fcp = null;
+	}
+
+	class Fcp2ObjectDB extends WalkRemoteObjectDatabase {
+		private final String path;
+		private boolean useArchive;
+
+		@Override
+		void deleteFile(String path) throws IOException {
+			// TODO Auto-generated method stub
+			super.deleteFile(path);
+		}
+
+		@Override
+		OutputStream writeFile(String path, ProgressMonitor monitor,
+				String monitorTask) throws IOException {
+			System.err.println(" write -> " + path);
+			return new FcpOutputStream(path, monitor, monitorTask);
+		}
+
+		class FcpOutputStream extends OutputStream {
+			ByteArrayOutputStream os = new ByteArrayOutputStream();
+
+			private String path;
+
+			private ProgressMonitor monitor;
+
+			private String monitorTask;
+
+			public FcpOutputStream(String path, ProgressMonitor monitor,
+					String monitorTask) {
+				if (monitor == null)
+					monitor = NullProgressMonitor.INSTANCE;
+				if (monitorTask == null)
+					monitorTask = "Uploading " + path;
+
+				this.path = path;
+				this.monitor = monitor;
+				this.monitorTask = monitorTask;
+			}
+
+			@Override
+			public void write(int b) throws IOException {
+				os.write(b);
+			}
+
+			@Override
+			public void close() throws IOException {
+				byte[] b = os.toByteArray();
+				os = null;
+
+				fcp.simplePut(getFreenetURI(path, true), b, monitor,
+						monitorTask);
+			}
+		}
+
+		Fcp2ObjectDB(String path, boolean useArchive) {
+			if (path.endsWith("/"))
+				path = path.substring(0, path.length() - 1);
+			if (!path.startsWith("/"))
+				path = "/" + path;
+			this.path = path;
+			this.useArchive = useArchive;
+		}
+
+		private String resolveKey(String subpath) {
+			if (subpath.endsWith("/"))
+				subpath = subpath.substring(0, subpath.length() - 1);
+			String k = path;
+			while (subpath.startsWith(ROOT_DIR)) {
+				k = k.substring(0, k.lastIndexOf('/'));
+				subpath = subpath.substring(3);
+			}
+			return k + "/" + subpath;
+		}
+
+		@Override
+		URIish getURI() {
+			try {
+				// just a pseudo-URIish for logging, not really supported
+				return new URIish("fcp://SSK@" + publicKey + "/" + identifier
+						+ path);
+			} catch (URISyntaxException e) {
+				return null;
+			}
+		}
+
+		@Override
+		Collection<WalkRemoteObjectDatabase> getAlternates() throws IOException {
+			if (!useArchive)	// try to use archive
+				return java.util.Arrays.asList( 
+				 new WalkRemoteObjectDatabase[] { new  Fcp2ObjectDB(path, true) } );
+			return null;
+		}
+
+		@Override
+		WalkRemoteObjectDatabase openAlternate(final String location)
+				throws IOException {
+			return null;
+		}
+
+		@Override
+		Collection<String> getPackNames() throws IOException {
+			final Collection<String> packs = new ArrayList<String>();
+			try {
+				final BufferedReader br = openReader(INFO_PACKS);
+				try {
+					for (;;) {
+						final String s = br.readLine();
+						if (s == null || s.length() == 0)
+							break;
+						if (!s.startsWith("P pack-") || !s.endsWith(".pack"))
+							throw invalidAdvertisement(s);
+						packs.add(s.substring(2));
+					}
+					return packs;
+				} finally {
+					br.close();
+				}
+			} catch (FileNotFoundException err) {
+				return packs;
+			}
+		}
+
+		@Override
+		FileStream open(final String path) throws IOException {
+			System.err.println(" read -> " + path);
+			byte[] b = fcp.simpleGet(getFreenetURI(path, false));
+			if (b == null)
+				throw new FileNotFoundException();
+
+			ByteArrayInputStream is = new ByteArrayInputStream(b);
+			return new FileStream(is);
+		}
+
+		private String getFreenetURI(final String path, boolean push) {
+			String key = push ? privateKey : publicKey;
+			String fPath = resolveKey(path);
+			String ret;
+
+			if (useArchive)
+				ret = "USK@" + key + "/" + identifier + "/1/" + fPath;
+			else
+				ret = "USK@" + key + "/" + identifier + fPath.replaceAll("\\/", "-") + "/1/";
+
+			System.err.println(ret);
+			return ret;
+		}
+
+		Map<String, Ref> readAdvertisedRefs() throws TransportException {
+			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
+			try {
+				readPackedRefs(avail);
+			} catch (TransportException t) {}
+			try {
+				readInfoRefs(avail);
+			} catch (TransportException t) {}
+			try {
+				readRef(avail, Constants.HEAD);
+			} catch (TransportException t) {}
+
+			if (avail.isEmpty() && !useArchive) {
+				return  new Fcp2ObjectDB(path, true).readAdvertisedRefs();
+			}
+
+			return avail;
+		}
+
+		private Map<String, Ref> readInfoRefs(TreeMap<String, Ref> avail)
+				throws TransportException {
+			try {
+				final BufferedReader br = openReader(INFO_REFS);
+				for (;;) {
+					String line = br.readLine();
+					if (line == null)
+						break;
+
+					final int tab = line.indexOf('\t');
+					if (tab < 0)
+						throw invalidAdvertisement(line);
+
+					String name;
+					final ObjectId id;
+
+					name = line.substring(tab + 1);
+					id = ObjectId.fromString(line.substring(0, tab));
+					if (name.endsWith("^{}")) {
+						name = name.substring(0, name.length() - 3);
+						final Ref prior = avail.get(name);
+						if (prior == null)
+							throw outOfOrderAdvertisement(name);
+
+						if (prior.getPeeledObjectId() != null)
+							throw duplicateAdvertisement(name + "^{}");
+
+						avail.put(name, new Ref(Ref.Storage.NETWORK, name,
+								prior.getObjectId(), id, true));
+					} else {
+						final Ref prior = avail.put(name, new Ref(
+								Ref.Storage.NETWORK, name, id));
+						if (prior != null)
+							throw duplicateAdvertisement(name);
+					}
+				}
+				return avail;
+			} catch (IOException err) {
+				throw new TransportException(INFO_REFS
+						+ ": cannot read available refs", err);
+			}
+		}
+
+		private PackProtocolException outOfOrderAdvertisement(final String n) {
+			return new PackProtocolException("advertisement of " + n
+					+ "^{} came before " + n);
+		}
+
+		private PackProtocolException duplicateAdvertisement(final String n) {
+			return new PackProtocolException("duplicate advertisements of " + n);
+		}
+
+		private Ref readRef(final TreeMap<String, Ref> avail, final String rn)
+				throws TransportException {
+			final String s;
+			String ref = ROOT_DIR + rn;
+			try {
+				final BufferedReader br = openReader(ref);
+				try {
+					s = br.readLine();
+				} finally {
+					br.close();
+				}
+			} catch (FileNotFoundException noRef) {
+				return null;
+			} catch (IOException err) {
+				throw new TransportException(getURI(), "read " + ref, err);
+			}
+
+			if (s == null)
+				throw new TransportException(getURI(), "Empty ref: " + rn);
+
+			if (s.startsWith("ref: ")) {
+				final String target = s.substring("ref: ".length());
+				Ref r = avail.get(target);
+				if (r == null)
+					r = readRef(avail, target);
+				if (r == null)
+					return null;
+				r = new Ref(r.getStorage(), rn, r.getObjectId(), r
+						.getPeeledObjectId(), r.isPeeled());
+				avail.put(r.getName(), r);
+				return r;
+			}
+
+			if (ObjectId.isId(s)) {
+				// FIXME this does not really works
+				final Ref r = new Ref(loose(avail.get(rn)), rn, ObjectId
+						.fromString(s));
+				avail.put(r.getName(), r);
+				return r;
+			}
+
+			throw new TransportException(getURI(), "Bad ref: " + rn + ": " + s);
+		}
+
+		private Storage loose(final Ref r) {
+			if (r != null && r.getStorage() == Storage.PACKED)
+				return Storage.LOOSE_PACKED;
+			return Storage.LOOSE;
+		}
+
+		private PackProtocolException invalidAdvertisement(final String n) {
+			return new PackProtocolException("invalid advertisement of " + n);
+		}
+
+		@Override
+		void close() {
+			// We do not maintain persistent connections.
+		}
+	}
+}
-- 
1.6.2.rc2
