Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3AC2FF154
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935408; cv=none; b=ecuUPO7ERHJ2p5sngHW2NzuRsIWtAPyA1EUZzyB4HxrYOQltRgKytStYFajBabyOryfPxefPYwUJVLWgQSebxaBKNRdbIgpIQtwGU9ToawGGkeBYmgBmEVJ3i0R2w4a0CTVEMcE7l8hoxLWAgwWsteJ8qIbqnifIy3Eykgjllk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935408; c=relaxed/simple;
	bh=nESwVvQYefH+90+1ok52mTK09yPGEW38UaIB1h2eUqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDpDnHqTta/cwiLoSMbtz/boj5oKSMmljAoM/44eRSvNLuldqZcn5OafxnjRonCciBAoPsEtk224uHTsRTUa6O8M9ZwiKVv3wfVolzG8G7BuTItj5SBwdAgh4F25RvcJmHPCxHopl8DeiLUgcmToCpD3ea8c09k7ZdgjHKpatL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c+kfeUzP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRCIwbOd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c+kfeUzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRCIwbOd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A97B140021E;
	Mon, 15 Sep 2025 07:23:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 07:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757935406;
	 x=1758021806; bh=FMSnQ1c2bT847nD99TpvVrWZhI6yKVdcmpPlVHaLYdk=; b=
	c+kfeUzPGYnnLRxCkO+MLS74zgeORT+tJVc7z5yHhKSufZ9bME9WBQt3dxwZfXgO
	0TpGMYe2uD9WLZmByDdgtnygJE0GBZ2JspqTY1lejdxujaHp7NhDvWuPB1pcDu07
	pR/G0Iks6v5fYQTv2uyE/94dSMHDm/rxEKD8iXYY+pHdgYsjx/1p4r1ojf+IRO0h
	s8OcZHI09AoWJz+x40ewlpXo7EAys/SNXVyZNliTkTSydlCPgy6OonLVFgls1vih
	XAz4slVeOzfBV7ncxLuuYKiHQQZlax/WSNZKeKstJkuRv3CndqfLHxOwteL7k5Zi
	yGA1cTQ90Wq6Aig21wQCFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757935406; x=
	1758021806; bh=FMSnQ1c2bT847nD99TpvVrWZhI6yKVdcmpPlVHaLYdk=; b=N
	RCIwbOdvX5+BMWUNUaYGC7Y4wetEpKXkTMvk2SLVCfps6ot3xdSUzJFlONZlnafX
	RTIqZmaW1PXHj+St0AUw7AjVJRJO6+o4r1qIlNSFeeVefDybc/y1M0hLlP6ppmHE
	lGC9txpRxdzUI4Icxpu08BR02tXcsAKfXHPSQDBApN3IQlIckalMeMc47cX4N6N8
	Ly2PLg+fNVWnFfF52IDeMBWaNbsxoJvFEbz1MzXnf/TWsqflf9MCKvANVzk0D3FU
	HgEOch8EOZqItg8ETrIdjdG1wdPYxOgQhoibdwQcSiffkV+SH5nfFMqbW9Vstpfo
	x4qNRvVu5aEmvwMaaO8TA==
X-ME-Sender: <xms:LffHaC2TaS6W4gGhMhGQnJDuQ_xsPj9w6KQpJIU3rwJuFN8sT0Wk3A>
    <xme:LffHaFuIjbGtHvG3jBSUHfjRQ1yX0BXB4Ff2MdgLnlFlhqJ-Rk52krBthF1J9szGi
    xYOV0m844bpoOWjfg>
X-ME-Received: <xmr:LffHaGCgOrbJ4YE7fXgIB0-_D6Pkew9Bj3IMkgkEfwK5MeHcgIQinnojvDuo-ycBxustQMCbsvqazG5c7YFb9sLIvwGGyfOzGbTLnmNn2OM-hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheegjeelgfdugeellefflefhieeuteehfefhvedtfedvtdfhhfekgfehleeggfdtnecu
    ffhomhgrihhnpegrshgpmhhuthgpshhlihgtvgdrrghsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegviigvkhhivghlnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopehpih
    gvrhhrvgdqvghmmhgrnhhuvghlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggtthes
    hhgrtghkthhivhhishdrmhgv
X-ME-Proxy: <xmx:LffHaIaTN3aoV-K6OAwv8L2m7l3OLlK4nvdUuq_Nk2UZxvz5nkrv1g>
    <xmx:LffHaI-Tbyt0mgNmDezrQJvWemavWfMiwBokXlf_V2sgEgBkFCfbPw>
    <xmx:LffHaMjVOdvS-w20lJ8uqeZN1uMddXmAEux98ZnM80kCO-BCvaj5qg>
    <xmx:LffHaDj0l7FyyBS1jzcsI-YGusx4eEsUYNo9a1S2vvz34WwAMY8hLQ>
    <xmx:LvfHaPmHb2LP6j3G0p2zHGURb1kGsiCAJAXtknK2lWKVay0-nVQol9JX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:23:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5debf893 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 11:23:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 13:22:53 +0200
Subject: [PATCH v5 6/9] varint: reimplement as test balloon for Rust
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-rust-breaking-change-v5-6-dc3a32fbb216@pks.im>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Implement a trivial test balloon for our Rust build infrastructure by
reimplementing the "varint.c" subsystem in Rust. This subsystem is
chosen because it is trivial to convert and because it doesn't have any
dependencies to other components of Git.

If support for Rust is enabled, we stop compiling "varint.c" and instead
compile and use "src/varint.rs".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile        |  3 ++
 meson.build     |  5 +++-
 src/lib.rs      |  1 +
 src/meson.build |  1 +
 src/varint.rs   | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8518198fcb..d7d6f6eefcb 100644
--- a/Makefile
+++ b/Makefile
@@ -1307,7 +1307,9 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
+ifndef WITH_RUST
 LIB_OBJS += varint.o
+endif
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
@@ -1499,6 +1501,7 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
 RUST_SOURCES += src/lib.rs
+RUST_SOURCES += src/varint.rs
 
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
diff --git a/meson.build b/meson.build
index 234a9e9d6fd..37dfa286017 100644
--- a/meson.build
+++ b/meson.build
@@ -522,7 +522,6 @@ libgit_sources = [
   'usage.c',
   'userdiff.c',
   'utf8.c',
-  'varint.c',
   'version.c',
   'versioncmp.c',
   'walker.c',
@@ -1707,6 +1706,10 @@ rust_option = get_option('rust').disable_auto_if(not cargo.found())
 if rust_option.allowed()
   subdir('src')
   libgit_c_args += '-DWITH_RUST'
+else
+  libgit_sources += [
+    'varint.c',
+  ]
 endif
 
 libgit = declare_dependency(
diff --git a/src/lib.rs b/src/lib.rs
index e69de29bb2d..9da70d8b57d 100644
--- a/src/lib.rs
+++ b/src/lib.rs
@@ -0,0 +1 @@
+pub mod varint;
diff --git a/src/meson.build b/src/meson.build
index 734de0b4fa9..b19ef4c0b51 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,5 +1,6 @@
 libgit_rs_sources = [
   'lib.rs',
+  'varint.rs',
 ]
 
 # Unfortunately we must use a wrapper command to move the output file into the
diff --git a/src/varint.rs b/src/varint.rs
new file mode 100644
index 00000000000..10c83e1f439
--- /dev/null
+++ b/src/varint.rs
@@ -0,0 +1,92 @@
+#[no_mangle]
+pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> usize {
+    let mut buf = *bufp;
+    let mut c = *buf;
+    let mut val = usize::from(c & 127);
+
+    buf = buf.add(1);
+
+    while (c & 128) != 0 {
+        val = val.wrapping_add(1);
+        if val == 0 || val.leading_zeros() < 7 {
+            return 0; // overflow
+        }
+
+        c = *buf;
+        buf = buf.add(1);
+
+        val = (val << 7) + usize::from(c & 127);
+    }
+
+    *bufp = buf;
+    val
+}
+
+#[no_mangle]
+pub unsafe extern "C" fn encode_varint(value: usize, buf: *mut u8) -> u8 {
+    let mut varint: [u8; 16] = [0; 16];
+    let mut pos = varint.len() - 1;
+
+    varint[pos] = (value & 127) as u8;
+
+    let mut value = value >> 7;
+    while value != 0 {
+        pos -= 1;
+        value -= 1;
+        varint[pos] = 128 | (value & 127) as u8;
+        value >>= 7;
+    }
+
+    if !buf.is_null() {
+        std::ptr::copy_nonoverlapping(varint.as_ptr().add(pos), buf, varint.len() - pos);
+    }
+
+    (varint.len() - pos) as u8
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_decode_varint() {
+        unsafe {
+            assert_eq!(decode_varint(&mut [0x00].as_slice().as_ptr()), 0);
+            assert_eq!(decode_varint(&mut [0x01].as_slice().as_ptr()), 1);
+            assert_eq!(decode_varint(&mut [0x7f].as_slice().as_ptr()), 127);
+            assert_eq!(decode_varint(&mut [0x80, 0x00].as_slice().as_ptr()), 128);
+            assert_eq!(decode_varint(&mut [0x80, 0x01].as_slice().as_ptr()), 129);
+            assert_eq!(decode_varint(&mut [0x80, 0x7f].as_slice().as_ptr()), 255);
+
+            // Overflows are expected to return 0.
+            assert_eq!(decode_varint(&mut [0x88; 16].as_slice().as_ptr()), 0);
+        }
+    }
+
+    #[test]
+    fn test_encode_varint() {
+        unsafe {
+            let mut varint: [u8; 16] = [0; 16];
+
+            assert_eq!(encode_varint(0, std::ptr::null_mut()), 1);
+
+            assert_eq!(encode_varint(0, varint.as_mut_slice().as_mut_ptr()), 1);
+            assert_eq!(varint, [0; 16]);
+
+            assert_eq!(encode_varint(10, varint.as_mut_slice().as_mut_ptr()), 1);
+            assert_eq!(varint, [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(127, varint.as_mut_slice().as_mut_ptr()), 1);
+            assert_eq!(varint, [127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(128, varint.as_mut_slice().as_mut_ptr()), 2);
+            assert_eq!(varint, [128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(129, varint.as_mut_slice().as_mut_ptr()), 2);
+            assert_eq!(varint, [128, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+
+            assert_eq!(encode_varint(255, varint.as_mut_slice().as_mut_ptr()), 2);
+            assert_eq!(varint, [128, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
+        }
+    }
+}

-- 
2.51.0.450.g87641ccf93.dirty

