Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160093DB635
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489510; cv=none; b=Yut6DOyPrPQsmeCpWO5uBQugyv7oEnkcR/4kFC8cwUZtsLGwLEMgHQbPHFba+J5gBIchXL9xgYJj0xUwL4OnVFY0KlyFKVeLyz/u9b7dHAfy4FL0aSxjafH5EyIv+5yAHwntq/0reRlc8+mYLhS7WOgUZtljSJqRVOm3gY5dW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489510; c=relaxed/simple;
	bh=hHz8GQWHitq9jP4y47WIquhO+HK262GOAtc2bkpzqR4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fTmmZgIPhe+Iw7VXINkFL07WmGMq/E2eYpJmwCcZ7iuQ4vObqsKFmZWNuSsKAw/sA0UXouStKW2dPodl8GmJBWjBRKWKuye+14b3H9/pO8qWCNT4/2eFO7BBbO9d56oKYqqlonExLUKV24nYTZE2YNx6ynH92aU3V4COcCoINyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUjFFxYG; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUjFFxYG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304f590dd91so1515074eec.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782489508; x=1783094308; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zot2AM7L/lplJhtxdwDrIR1ipyOzA3ntLAPT/zTPrWA=;
        b=IUjFFxYGmcmZazp8t9CexAeHB7KfnLPsiMwbgWEfirHrQVoUJT67az78GbVgm7TFHZ
         bNUFGIrT3d3cBkXE8ENhVM+pbQdUTyZzDuylty4dBI1Bff4hvOoii9Wm2ZwkixXTOYdd
         jzr1oEaRhEKFxLQ6kN4tRzvwDAozaf0e3eJRGc0ZWOF8hg3TwGkHeloH1rWLAYdY8ewW
         O7qY4znWQ4i2iLFjQc9L0w/GKNp+Cp10n9NWE0dNbDRL4v5NRNI+mP3Vp/EW8VSpH/w+
         rlqjLsMNxN2yIgabfnSmflx2kPNPNDmRtZUuydA846vhHt1aGuiDFgzgsTm2o9jp5E2D
         2MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782489508; x=1783094308;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zot2AM7L/lplJhtxdwDrIR1ipyOzA3ntLAPT/zTPrWA=;
        b=aQGY1f1dGDLE+qqvWGskUe2Xv+XKRvHLH7wkUcVA8zSqnJQGs3BXayWHb8mSI/B3uX
         AbmIe/o31uYbRBwSn1YOPMpYKYYSlp1xgUoRLJRfZPZlEp65sHb/D0vJTf+mG1T8jjlg
         HtE7N/Yt6qxQZ48gxTeWZ3eCpjwL04GPIP9zuy4K8BL2koOEjdFS2hoNBywNEh/p0Zvo
         ylyPEV3dLoGMHVEnUy9ipaY7EjBdk7nsNnapuNucGh1xelfujFqRcaccfyHCHfErrdIM
         Wq6HYJ/SZBGqpP8Ttl1n5+hxClkXEpNcBjOV9yeY/tLz6GrUJhVUkQCL41zQ1avrhMev
         fwfQ==
X-Gm-Message-State: AOJu0Yw1BQtCnHlJvZXUHtMvoRT/cBwig2xFnIUqQrT0H5gUQIBN29FI
	EAQp+8Z+psn0a58ZduHh9zUhGLlTcuPz0Ho2HinOLeBlZMfEKczBA7FUkL9/Yw==
X-Gm-Gg: AfdE7cnuYyFYRE208ld3T1Cw6uqsF53hovJhUZGuEeK9DSs9rudiaSVu+OzgJG44AMy
	pmLbbuAahF6lbuUYWzMR/Mm6DPzCNe6k0m7VlWnz9gLgqlipl0rvfFIdAvEcIJQ6ZUvktW1OkEK
	j0Q8Bq+Lu4rS8NGPsoFUMpHRfQP2HvPEwlV3IE+IUegkN7VN2Au2VbzfnyOKUBsXmtvrP+9XOgP
	ppTLkk1/KYkcT/hXhJYiIEfUAjGiCHVdsgYlUVC30KmXY6u4rmN0wiEpGNT0xS8ZGpU1DXnA3ba
	EU80nDoqQk3ltc6uoroc+e31O3r80wmH9wjeTF1JLeHXEy03YNXslTWw8qQZ9/0Mwwoz/5bOu46
	XhioAWn16NReXsNsRyntb8Af8QM1rSq8hp4cWNDnNlpjuCP8V1R5H6b3PnspWD2/pNqU4dUJ5M7
	5+WXIpAvDcrAAA36s=
X-Received: by 2002:a05:7300:1821:b0:2ef:83d4:647f with SMTP id 5a478bee46e88-30c84f216d4mr6841149eec.25.1782489507783;
        Fri, 26 Jun 2026 08:58:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c8b1ae5sm21420778eec.16.2026.06.26.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 08:58:27 -0700 (PDT)
Message-Id: <pull.2350.git.git.1782489506255.gitgitgadget@gmail.com>
From: "Feng Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 15:58:26 +0000
Subject: [PATCH] rust: validate object map insert algorithms
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Feng Wu <wufengwufengwufeng@gmail.com>,
    Feng Wu <wufengwufengwufeng@gmail.com>

From: Feng Wu <wufengwufengwufeng@gmail.com>

The loose object map stores entries keyed by the repository's storage
hash and the compatible hash.  ObjectMap::insert() accepts its two object
IDs in either order, but it currently checks only whether oid1 uses the
compatible hash algorithm.  If it does not, oid2 is assumed to be the
compatible ID without validating oid2's algorithm.

That means callers can pass two IDs with the same algorithm, or an ID
using an unknown algorithm, and have one of them silently treated as the
storage ID.  This does not match the map invariant that each entry must
contain exactly one storage hash and one compatible hash.

Make the invariant explicit by decoding both object ID algorithms and
rejecting unknown or mismatched pairs before inserting anything.  Introduce
ObjectMapInsertError with InvalidHashAlgorithm and MismatchedAlgorithms
variants for clear error reporting.

Update the existing tests to unwrap successful insertions, and add tests
for same-algorithm and unknown-algorithm inputs.

Signed-off-by: Feng Wu <wufengwufengwufeng@gmail.com>
---
    rust: validate object map insert algorithms
    
    ObjectMap::insert() accepts a storage OID and a compatible OID in either
    order, but it currently checks whether oid1 uses the compatible
    algorithm, and if not, assumes oid2 is the compatible one without
    validating oid2.
    
    That means inputs with two OIDs using the same hash algorithm, or an OID
    using an unknown hash algorithm, are accepted and one of them is
    silently treated as the storage OID. This breaks the object map
    invariant that each entry must contain exactly one storage hash and one
    compatible hash.
    
    Teach ObjectMap::insert() to decode and validate both OID algorithms
    before inserting anything. The function now accepts only the two valid
    permutations: (storage, compat) and (compat, storage). Unknown
    algorithms and mismatched algorithm pairs are rejected via
    ObjectMapInsertError.
    
    The tests cover successful insertion in either order, same-algorithm
    input, and unknown-algorithm input.
    
    Tested with:
    
     * cargo fmt --all -- --check
     * git diff --check
     * cargo test

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2350%2Fwufengwind%2Fobject-map-insert-validation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2350/wufengwind/object-map-insert-validation-v1
Pull-Request: https://github.com/git/git/pull/2350

 src/loose.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/src/loose.rs b/src/loose.rs
index 24accf9c33..8f6c1fb40e 100644
--- a/src/loose.rs
+++ b/src/loose.rs
@@ -510,6 +510,17 @@ pub struct ObjectMap {
     batch: Option<ObjectMemoryMap>,
 }
 
+#[derive(Debug, Clone, Copy, Eq, PartialEq)]
+pub enum ObjectMapInsertError {
+    InvalidHashAlgorithm(u32),
+    MismatchedAlgorithms {
+        storage: HashAlgorithm,
+        compat: HashAlgorithm,
+        oid1: HashAlgorithm,
+        oid2: HashAlgorithm,
+    },
+}
+
 impl ObjectMap {
     /// Create a new `ObjectMap` with the given hash algorithms.
     ///
@@ -585,19 +596,39 @@ impl ObjectMap {
     ///
     /// If `write` is true and there is a batch started, write the object into the batch as well as
     /// into the memory map.
-    pub fn insert(&mut self, oid1: &ObjectID, oid2: &ObjectID, kind: MapType, write: bool) {
-        let (compat_oid, storage_oid) =
-            if HashAlgorithm::from_u32(oid1.algo) == Some(self.mem.compat) {
+    pub fn insert(
+        &mut self,
+        oid1: &ObjectID,
+        oid2: &ObjectID,
+        kind: MapType,
+        write: bool,
+    ) -> Result<(), ObjectMapInsertError> {
+        let oid1_algo = HashAlgorithm::from_u32(oid1.algo)
+            .ok_or(ObjectMapInsertError::InvalidHashAlgorithm(oid1.algo))?;
+        let oid2_algo = HashAlgorithm::from_u32(oid2.algo)
+            .ok_or(ObjectMapInsertError::InvalidHashAlgorithm(oid2.algo))?;
+
+        let (storage_oid, compat_oid) =
+            if oid1_algo == self.mem.storage && oid2_algo == self.mem.compat {
                 (oid1, oid2)
-            } else {
+            } else if oid1_algo == self.mem.compat && oid2_algo == self.mem.storage {
                 (oid2, oid1)
+            } else {
+                return Err(ObjectMapInsertError::MismatchedAlgorithms {
+                    storage: self.mem.storage,
+                    compat: self.mem.compat,
+                    oid1: oid1_algo,
+                    oid2: oid2_algo,
+                });
             };
+
         Self::insert_into(&mut self.mem, storage_oid, compat_oid, kind);
         if write {
             if let Some(ref mut batch) = self.batch {
                 Self::insert_into(batch, storage_oid, compat_oid, kind);
             }
         }
+        Ok(())
     }
 
     fn insert_into(
@@ -729,9 +760,9 @@ mod tests {
             if *swap {
                 // Insert the item into the batch arbitrarily based on the type.  This tests that
                 // we can specify either order and we'll do the right thing.
-                map.insert(&s256, &s1, *kind, write);
+                map.insert(&s256, &s1, *kind, write).unwrap();
             } else {
-                map.insert(&s1, &s256, *kind, write);
+                map.insert(&s1, &s256, *kind, write).unwrap();
             }
         }
 
@@ -873,6 +904,42 @@ mod tests {
         );
     }
 
+    #[test]
+    fn refuses_insert_with_mismatched_algorithms() {
+        let mut map = ObjectMap::new(HashAlgorithm::SHA256, HashAlgorithm::SHA1);
+        let entries = test_entries();
+        let s256 = sha256_oid(entries[0].2);
+        let s256_other = sha256_oid(entries[1].2);
+        let s1 = sha1_oid(entries[0].1);
+        let s1_other = sha1_oid(entries[1].1);
+
+        assert!(map.insert(&s256, &s1, MapType::LooseObject, false).is_ok());
+        assert!(matches!(
+            map.insert(&s256, &s256_other, MapType::LooseObject, false),
+            Err(super::ObjectMapInsertError::MismatchedAlgorithms { .. })
+        ));
+        assert!(matches!(
+            map.insert(&s1, &s1_other, MapType::LooseObject, false),
+            Err(super::ObjectMapInsertError::MismatchedAlgorithms { .. })
+        ));
+    }
+
+    #[test]
+    fn refuses_insert_with_unknown_algorithm() {
+        let mut map = ObjectMap::new(HashAlgorithm::SHA256, HashAlgorithm::SHA1);
+        let entries = test_entries();
+        let s1 = sha1_oid(entries[0].1);
+        let invalid_oid = ObjectID {
+            hash: [0xffu8; 32],
+            algo: 99,
+        };
+
+        assert_eq!(
+            map.insert(&invalid_oid, &s1, MapType::LooseObject, false),
+            Err(super::ObjectMapInsertError::InvalidHashAlgorithm(99))
+        );
+    }
+
     #[test]
     fn looks_up_known_oids_correctly() {
         let map = test_map(false);

base-commit: ab776a62a78576513ee121424adb19597fbb7613
-- 
gitgitgadget
