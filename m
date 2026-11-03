Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679697;
	b=iDJAhuC7JXO6p8FAW6TTugEAAfi0Yp1CV4BDVMBdhy0IJsd2Kw+GjYE4X2zYmxwTlZAI
	 vNpjdgySxGDOKmDaPBDQwReDCLOpacaQNZ4Q4qVHv1xy8SBZ2xw7yG3xX6ZVrg39kDtF5
	 UWQDuiqn2b+OpUTGZLBDVbaD3bspC7rpjOjhZXVXzh/qlEYQs1vo2J966Hnzm4S7t3Xab
	 gKnKEZg/cYx+Mc+3/wFcv2fKBJHXxsTK6WvIo36+oU+dbXh/KSVEb7pE4zIaXLvnmm4ze
	 U98sOl+dI3SM0ASs327jpGJuTXT+QahBuevizEwSVQSsv3og38RgTFDu4Y4OltUDF1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=s54Bun+Z6iCnsO9DLT29cu1c+g3mHonlMxfKkowbEcI=;
	b=bigkYZ7RO8DbfkKHtLslTcdmGPopGPnzX+6MVRekbArZXbXwSTmOl010WYl9+LEcqa4D
	 nk1pW49evRiMeKsrXIGZfho/3RCURKMyT9UcUlh6KTkcqjIaiqlZYK8y4tN8DlJskR01v
	 dvcyox/Px1Tj7SwPg7CtY9XtVQGNPTufNH8yRAsXMk753LllOOyNlt/ByGCvl6WQlyy2x
	 nQmUsEeP+sCuTD/cU7NT8a+Zhz0Qr+nGmo93I3DYFXjaU1W844JKRtnWG07UzsInCeY14
	 LxuOKCUgHDF4jjGYtfoV25fzTM1aQnjr92GV0NxfhRFve1UI8MiXCluU7LaB19cbeGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TkMqDe4n;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17695606A327
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 04:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17695606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TkMqDe4n
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20edd106so2843150f8f.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 20:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793679695; x=1794284495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s54Bun+Z6iCnsO9DLT29cu1c+g3mHonlMxfKkowbEcI=;
        b=TkMqDe4n/Ohg1FMRfOenkn5GdljBNYobmwvRmgbvbU0JV4dyWQoJrtBuI/AqKYXjqw
         KiMct8g76ptswedgOEOwtzxQ/7sj3Z8hBmooCiW30nWtYZ7PCPxKDbwtyXt73Aufiqt7
         B8H5p/wUeJ4GrMZBMb8xsEKRE2ICzvrE7qBoW2ayelrtYwECshbq+ZPymXeBUBu8Gu8Y
         X4Qheqbbx0cfycwYnSZjYnd5ZLG2yLonto2OzbyhegFW+o2KxEJKm+fWS8aZDGsXeAUm
         zetcA42TvSbC60ICVcKrwB0/WiJI+nEZoj48b1YCJbRMUwecfPVZPgfndl8WUgxf+Q7d
         blUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793679695; x=1794284495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s54Bun+Z6iCnsO9DLT29cu1c+g3mHonlMxfKkowbEcI=;
        b=Wo4LaakQ5kkSYcKwNZ8yep4llGTxxxw7WmL55UK44FrPMzu6rksoMzXyq0hoZaCNkV
         pQkNw9LdUmF0o3CzSdGYDlUc4iHNPhT0tudF89aJDUs5LiJppB6vFMxbLdYfK8PtO7fD
         NrOZbx1WQn6F3Mn7o/4/z6VW1H/dp7UTLXXMdBTbSmaxPwZMOOtCbKIOUujcikcAxp1N
         DmTt6vff85O1XmmSePYbKengku3UkPwpEmSlP2ax4R+OWLuzkxdIx0jk9IZlNRrDi/pI
         8vsyO+khfI/KUV723CUuBiJ4pv/rj8v4K0eyiX9Q1OFjralNQm54vMtqmTmVEEtHTKUd
         8l9g==
X-Gm-Message-State: APuU4Z8ww8BB9BQ3MBCs11EVM81vc+g1MkccmrykRaIYQ5fiIkvfVzvO
	SbgHEu6aTB7Bkg2ibNGSJp6N6nZch5lkMznnmoY98FPQXSM4zwZJZdoH/WQADCQ=
X-Gm-Gg: AYBFou18dn6Pv94dFYoZpn130hhnPrZn1fBNx1mvXoWKdb702tZRAOkZwAeS22T957u
	8Ez6AO2q5b05ACeGD50oCAJjafQeW1Ca+Yg9vWiAcjY507dQXPbVa8CdIFsv7rB787QvRGkXppS
	i5X6Vg74RhHx1ERbQGRsN4w+mT6HX7P8Jo5zN9ca/hFAyX1ekzbYpLrFWFABKpXSk2r2lAowdUE
	O1OAymK3wONO7JpvOZr1B+wqD/l4QpCI3k4Vfst6HIctqVSJWhIe7ld/Wvw5OtnbO4fy6grmqfF
	LXG5I5+7CdaQ3PS88J5RU23ET7bAFTcVmLO9R6gySPpPCLzql/hgi2AqipQ9ug/LBhTD9KKYTp+
	LPDtSCTRPjNYFZ9MPGYibzQZnOzyzcfrwZIl2wWnHaa2Y4BTVQZcHnrFRwpajl/QAT1cOq7a/38
	u/wu9JiBit1DxZmJXCbP+fY8PkUyjYofhPk2EWP4xnpzlLxBDkO89TBsbif12r/LxvqzovjPj+w
	Mueco0egXIdQ7DJ6KI9OeN5zgBD2qH3TKmV5HKUlxfLmzBAMw8U2PAxkf1q9IaFnM1FFHfp4/sR
	Y3Bj2BXgNW6afH82o1Gc4hFJ8zEBYJdy6YK2n2hn89ESx3+9HH3d3Q==
X-Received: by 2002:a05:6000:1449:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-48e6e2ef786mr25134265f8f.23.1793679695191;
        Mon, 02 Nov 2026 20:21:35 -0800 (PST)
Received: from shrimech.1337.ma ([197.230.48.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm22638751f8f.46.2026.11.02.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:21:32 -0800 (PST)
From: shrimech <eddinen77@gmail.com>
To: git@vger.kernel.org
Cc: shrimech <eddinen77@gmail.com>
Subject: [PATCH v1] hash: handle invalid algorithms when formatting object IDs
Date: Tue,  3 Nov 2026 04:20:42 +0000
Message-ID: <20261103042042.39999-1-eddinen77@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ObjectID::algo is publicly mutable, so an ObjectID may contain an algorithm
identifier that is not recognized by HashAlgorithm. Display previously
unwrapped as_slice(), which returns an error for such identifiers, causing
formatting to panic.

Format the full hash storage for invalid identifiers and append an
invalid-hash-algo marker containing the unsupported identifier. Add a
regression test covering this case while preserving the existing output for
valid algorithms.

Signed-off-by: shrimech <eddinen77@gmail.com>
---

Notes:
    Base Ref: v2.56.0
    Web-Diff: https://github.com/larsxschneider/git/commit/c95530cf38
    Checkout: git fetch https://github.com/larsxschneider/git fix/objectid-display-invalid-algo-v1 && git checkout c95530cf38

 src/hash.rs | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/hash.rs b/src/hash.rs
index e1f2d31fc3..87242d58b1 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -78,13 +78,19 @@ impl ObjectID {
 }
 
 impl Display for ObjectID {
-    /// Format this object ID as a hex object ID.
+    /// Format this object ID as a hex object ID, or mark it if its algorithm is invalid.
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        let hash = self.as_slice().unwrap();
+        let hash = match self.as_slice() {
+            Ok(hash) => hash,
+            Err(_) => &self.hash,
+        };
         for x in hash {
             write!(f, "{:02x}", x)?;
         }
-        Ok(())
+        match self.algo() {
+            Ok(_) => Ok(()),
+            Err(e) => write!(f, ":invalid-hash-algo-{}", e.0),
+        }
     }
 }
 
@@ -366,7 +372,7 @@ pub mod c {
 
 #[cfg(test)]
 mod tests {
-    use super::{CryptoDigest, HashAlgorithm, ObjectID};
+    use super::{CryptoDigest, HashAlgorithm, ObjectID, GIT_MAX_RAWSZ};
     use std::io::Write;
 
     fn all_algos() -> &'static [HashAlgorithm] {
@@ -439,6 +445,19 @@ mod tests {
         }
     }
 
+    #[test]
+    fn invalid_object_ids_format_without_panicking() {
+        let oid = ObjectID {
+            hash: [0xab; GIT_MAX_RAWSZ],
+            algo: 0,
+        };
+
+        assert_eq!(
+            format!("{}", oid),
+            format!("{}:invalid-hash-algo-0", "ab".repeat(GIT_MAX_RAWSZ))
+        );
+    }
+
     #[test]
     fn hasher_works_correctly() {
         for algo in all_algos() {

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.47.3

