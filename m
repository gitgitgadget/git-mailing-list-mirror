Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680715;
	b=2jvIFGyfvHDhFEaH97GF0K8WX0+q+CGt5mNvvL1XI+T6YErZgsZhew02nArg/sGfk2cK
	 dC7XDIXq2ItDctYhyd06+QM68745lN4UF4alPYAkelE5rvHO0H58s1eeyK4iYs9F2STGd
	 LQotkmcudAqG/i8JwaJ3um/IhIi5gcFwboCrmtFNsuT60X7nFooasLhPSo9wTvDmXJwKl
	 NcDXS93K6dnGsfjey8BqO69Vo2fbxKJP9+/dXJEKV3JKDPrmxIBsJpOciq3XN7AiPdCzw
	 wKlUahlzY7TUN3d+LgaAZaWx1kP1q/weAi3AGCJfUGX1xd+BDIRpBgQAuWwYGs36ZiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0ekCuR1ZjnrGTTfblKFcSvakF6+6ZLwhGsD3Que8QCw=;
	b=qCHaLho7S95fkqsBuMXVuSXdjppj+zPnMa6NyO3GTCkA4+3/zoZv3dOmzHA6sKafwYda
	 93jqsBQf8HB2dWt+awoFBIbCkP4yEApO91wpqmYUQgnygsGfITqNECn94VGKm3qs4Jkky
	 BY3KpzftLXy7mFVy7CLmoHhwnZHHEEirt9kOoKQvZH28bwKoe+b9usMIKgGeU23r3ZRHi
	 xH6EOXZuJ3eaUNBPK+fTbLM1GlOqS4ISezSu2nZxqS4fdEzSIioHtvRu+azJTkot58MPC
	 u775YdELz1jwL3htnLpop4xF4p/PFQ4MLLvV4/PzrFsy+icvYoQlBqS+pDJKND7OLGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VeaDc9C7;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7A606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 04:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15F7A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VeaDc9C7
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so27839695e9.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 20:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793680713; x=1794285513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ekCuR1ZjnrGTTfblKFcSvakF6+6ZLwhGsD3Que8QCw=;
        b=VeaDc9C7+HK/l49Ws/R3NRkj0YwZsMRZbAfQkR8lgZp8iAUPhq6fR2YZcsyUJQyNmU
         uyQmSvhVo+1SBI3WoahLCQzTCRdBE1UX9MBl9QUYC85IaSOpilsyzTLzzHGAc/HMc2dA
         74KiS5TO4JlCHFp9i82cVp5WyOjYGLnPd0GIxbmrQc+RgXI3KUEsmLQZwqsDIkK1S1Yf
         vDP/EkMRCsNNtES7Xy6I9ryxQ0YMvJP0NrDu+qZPmwqXWMb8izTcO6o6OB5oWqh5SQFG
         ZX+bMkejW1nz3Q8j6lFIYZEQJwBOwul13ciNyyKs9fkh1I72a0q7qdY/x0C+weGFcxyO
         tpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680713; x=1794285513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ekCuR1ZjnrGTTfblKFcSvakF6+6ZLwhGsD3Que8QCw=;
        b=n8J9G4XIP9+omMGabtTvh1rXM7YdUgb5NKVzutcWcCnAsbOZHvFIOIjzIzhzkDm3Hm
         /id1ZU5aF57rq6qC+MQv91hL0JNC/meAy0Dkt6BsdxAyr3jUb1geLIqBkut365Lh00eh
         jPJeX2SE9xQX6pMMsDKPzZlhU0AmpTmxRTpc+NmDbxexzxw54nDxYGzOX9wkV/1+RAo6
         8qyO87dH+CMn+Uy69tbdWKPuv0Cfw8JQigLiWVUiN+bJvNFPaRQiMj1q3WvsEPpGBrPP
         Bt1Oxe9lWY5zjLk5FqRYWg2ISrQ54HVNgcGA0rlxOYUCFnSw++AEojW/cG1aA+mTF0SR
         C9pQ==
X-Gm-Message-State: AFq9FYJPqJ5/jsr3eNUqeavsrw2kZmThJm+R3H7MwJDSaMk35CIaDCHa
	JodTPQyeVO89vTx/0fDxivbp6M3PqPJgiRrkKTYr7J6baNmSymL25xvTLGbWYQQ=
X-Gm-Gg: AYBFou3/Ab5/hSBwJIRx1xkiu1zr4RL28o2KkEM/XSwKhPWR6YvwRs7wftKttRIlkqt
	+2f/Ue4u87jQUGNkuYdPuw1Ni8Bq41aFVOA7ZHK/rpuU0pTaUfh6TF8JkVOllSk+qlIF1CG4lB4
	MigxiKwctvg6N3epzhnpoIHEPbmAaBk/K+ucNulATaJhScGqk7YxFn5giBc7mvx2iDbdl3n0suf
	Fi+b0y9BkmLrSb1T78D3ufGTMZwD0hJJu3AGD+G1KY32ljf2Br66KPXv69ndjTe+iwGG7H40jiE
	pV2tiTLzU62zWKDHWSZIUA5RSLcfqppcCk6QC/1oZTISlG9mkydlk3ZfVjivfmxzIKnhco5wAyW
	eDKaf1qoAz+bd7bOACygwtUwVXYqOiKaVVh2H++JFWkjAKSPRMthDKCbOKqYYPy9S8fbe3On/QC
	sUpoAS+72nAys7XVLmgpIWG+Hev9+Cu/4A/UqaJtyI+i1heYYRdqGauYS9/VG1C4CERyEVswjpG
	phtVkHnjr3bAr+tuDHkE6qtFGyUBpD+4ZkeLrlSdqMlMrNWyjuyjyTH+MjDJTLdeyhP4CB+0etU
	mrwSH6Hm/5SkO1eFQmR1MK+YVBTF85SfDqvLrdwqB8aX0S/6ZMWjjg==
X-Received: by 2002:a05:600c:46d1:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4ac17b2cdc2mr271277795e9.27.1793680713369;
        Mon, 02 Nov 2026 20:38:33 -0800 (PST)
Received: from shrimech.1337.ma ([197.230.48.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a80e0fe6sm34571855e9.1.2026.11.02.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 20:38:32 -0800 (PST)
From: shrimech <eddinen77@gmail.com>
To: git@vger.kernel.org
Cc: shrimech <eddinen77@gmail.com>
Subject: [PATCH v1] hash: handle invalid algorithms when formatting object IDs
Date: Tue,  3 Nov 2026 04:37:56 +0000
Message-ID: <20261103043756.61627-1-eddinen77@gmail.com>
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
    Web-Diff: https://github.com/shrimech/git/commit/c95530cf38
    Checkout: git fetch https://github.com/shrimech/git fix/objectid-display-invalid-algo-v1 && git checkout c95530cf38

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

