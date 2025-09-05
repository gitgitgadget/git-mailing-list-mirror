Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99E34A308
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073081; cv=none; b=lxdskXVLaQIiIkagEe4izZ3dkJ2ljbWNW5FN6YGg62kP/WTZ42lLo7EQlnZmb+IVC8LaOSEQUpXUlfGcbssSN5pEr1IsKgzttwNDVnCTyTxq6bbQqmF+FVKu25AbgAm9mPDhCT3xdEslzZyCW9ANHPxKGwQz4aTlFvWHKa8aE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073081; c=relaxed/simple;
	bh=0blK/EauS9o8acr4EYRFm8Ubjjvel9O8/LgrmSGslrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fX+OwuQsc/dE/kDVE5bNxuXbXxus5qH3o8H9fdeR4Ks2IF674AmwGV/0b3HSDiqmmypfzydKf7Sy023kvgrRDAZws69MsruXIlU8I0OcNiHv5vRdYPSV1nUQReuLgJ3GHO/Cyq9BxC2LUFWT+fngE7/lXCi0KEBxulPlOXAFBNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pdOJiq1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Io7pwzY9; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pdOJiq1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io7pwzY9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 488301D00049;
	Fri,  5 Sep 2025 07:51:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 07:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073078;
	 x=1757159478; bh=scaeyZbunamrc3PamDV7UtzrrWgjChqqHEh21rV8Dkk=; b=
	pdOJiq1K+v1dRpDTYv+CE+FvXgHhmY+ussbQj01gnDlgH8IRUHv+ZzcRemCLi349
	0GInuoMxZB0bO6S/ZOC5+3i+VlN36GO7HJNqiL+xPFRtPcmjEkCPQPknFNGHLqc3
	XybqLgU8TaX6lpNFXtrRmJ8YxZpivurybbNzfPsultn3IkwEyuvXCWXj5nmYNUaK
	9KwtpeYB5z4OYlqeJH8H2VsYwqEbQcQVs7HFf838hTNhhS6gGlXmMYE1zg0lTU2r
	sHw9BLvI1k8NhPSAuvI9iYNba89990llSITtqmpIhJH81U1uyIYjhe9pnq1zkWKb
	gPjoZUefr/PxvrEOd6hH5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073078; x=
	1757159478; bh=scaeyZbunamrc3PamDV7UtzrrWgjChqqHEh21rV8Dkk=; b=I
	o7pwzY9pqXfxYRCsG2V8cNjdi7VEpmeFWoQvdYErbaA+oaqXZTgy7EwKaSOJ3P27
	RS8NjQ0gInYYCjvSfrOsZz0cA2nW9iJBahcTg1ywvepZRo8NWbhBBxyGWyG17jjQ
	23vjvlSneDrA/WReWWYFCRY7i2D8/HJSdkjXzOdt2ChvAtH3i+WyqMF4mvIG3Pew
	SxoobBpi6O6X6CL61nzJYMxtRU8gHkduE760ftxTEr2moSFvtHYs6yoNGRW06gsY
	g2lmkF32F5zYr6cRVWNS71bZCppOSVgQIr7SvjcEotsPQp2yoPv4PhUyiYzOWf+H
	mVq6L+ZhqLZIu52bsv7Yg==
X-ME-Sender: <xms:ts66aDDO1bsZ-woZfBDgjrIUwgKTfOMlkVlbXkxwiBZjk8eYYtWp_w>
    <xme:ts66aJp7QwhlcsO817XIM9kDWNFAG2CiyAWRzP3A9siVboL1n5zMO0wBUme5PELa5
    U-U2RSfkTwa4jZ-Ig>
X-ME-Received: <xmr:ts66aGAR9SqHzBcI5qXyomTHci8YxMzQuaBOYaYxoO1sOYrQr1FYooMlbePbiNlNvqZEJPkTfW0Xocj5eolXVKmT_LI_D0NOkyovem8d0wB5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehgeejlefgudegleelffelhfeiueetheefhfevtdefvddthffhkefgheelgefgtdenucff
    ohhmrghinheprghspghmuhhtpghslhhitggvrdgrshenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegtsgesvdehiegsihhtrdhorh
    hgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdr
    ohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtph
    htthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:ts66aMVFO2keYQhMgdO74mAX-12Rd6hz2v9i2JMSM2v2PKV1Ygx_Lw>
    <xmx:ts66aADX7lHEA7reMSKSThHXbzxFWxyNzrlmhwdvCqEypfak4AtT1w>
    <xmx:ts66aBeQBkAB4fcIFE-qHW1aejyaaT22FdA3S-Xs0HRqH7OAcxeZ-g>
    <xmx:ts66aPp2HiNlxptImR9e6IR6MlyuI3Tz7D0ADqzmZugLprJEw8UAMA>
    <xmx:ts66aP3Bi2eMDNGXURBblNLwjFTMQUWQoOqOKcbGVCTnWj6nEtqZqZId>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8502887 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 13:51:00 +0200
Subject: [PATCH RFC v2 4/7] rust: implement a test balloon via the "varint"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-4-6939cbf4a0b8@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
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
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Implement a trivial test balloon for our Rust build infrastructure by
reimplementing the "varint.c" subsystem in Rust. This subsystem is
chosen because it is trivial to convert and because it doesn't have any
dependencies to other components of Git.

If support for Rust is enabled, we stop compiling "varint.c" and instead
compile and use "src/varint.rs".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile        |  2 ++
 meson.build     |  5 +++-
 src/lib.rs      |  1 +
 src/meson.build |  1 +
 src/varint.rs   | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e7b3c8e57bf..8fd13a36db9 100644
--- a/Makefile
+++ b/Makefile
@@ -1209,7 +1209,9 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
+ifndef WITH_RUST
 LIB_OBJS += varint.o
+endif
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
diff --git a/meson.build b/meson.build
index 5b2e9af1bf1..da9a8c8dea0 100644
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
@@ -1709,6 +1708,10 @@ rust_option = get_option('rust').disable_auto_if(not rust_available)
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
index eb752651d35..4fc793fb17d 100644
--- a/src/meson.build
+++ b/src/meson.build
@@ -1,6 +1,7 @@
 libgit_rs = static_library('git_rs',
   sources: [
     'lib.rs',
+    'varint.rs',
   ],
   rust_crate_type: 'staticlib',
 )
diff --git a/src/varint.rs b/src/varint.rs
new file mode 100644
index 00000000000..3d41760a555
--- /dev/null
+++ b/src/varint.rs
@@ -0,0 +1,92 @@
+use std::os::raw::c_int;
+use std::os::raw::c_uchar;
+
+#[no_mangle]
+pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usize {
+    let mut buf = *bufp;
+    let mut c = *buf;
+    let mut val = usize::from(c & 127);
+
+    buf = buf.add(1);
+
+    while (c & 128) != 0 {
+        val += 1;
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
+pub unsafe extern "C" fn encode_varint(value: usize, buf: *mut c_uchar) -> c_int {
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
+    (varint.len() - pos) as c_int
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
2.51.0.417.g1ba7204a04.dirty

