Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA61199E89
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220992; cv=none; b=dShwBraowlCMaGlCODQ0ze+u9BnQWnSnmMSK39mdGdCuf+4DG2lpL2oXdL3NwUEgVbbdw/qil/2kYBRApjdccYrfxpND8Nc8oMai9w7w4cXhtuB51Jw1rh4FFy5MZzbSg/79jlxkuE1044TCatWfKVK9/aLD6UQphMboZlz5/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220992; c=relaxed/simple;
	bh=n/jPsDgmLxN2S6FK2v/KXqCTq9/KfaL+MdrOdTeJe0Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ClWwbbMfXNHxJfVPuFSMUvQ9jJXgYwWswRa2eWOS3q1GljYZ8tsqj3EtDAJBrBSL0r/sO3v97n+UIXp/GG1Bl5J5o/SiBkLktafVGhv8ek05qN58UHHAxg3AcWX47ke0oQpAsms7IF4WhIe46koa1z9vxpmC35HMBFDaEK5r/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bltf0byo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bltf0byo"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e411c820so815567f8f.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220988; x=1755825788; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFLWQrX/LolS+zwFqWLu+O1K3ykf+TN+Y7Suabqmqds=;
        b=bltf0byoP0qflQBYlJAX8fIHyjdR0iKmoonXrIcDhknBH2W7CAg/bp9w+I+kUxjTfV
         BtF1cTtz8Z0A8frf9HQWdv86ZMUeo07y7RUBvnZXJVKDEg8vagcoLMN140LhhnAHdWdO
         gEKZwl8S58w//TlSc8sU5/IeVsWFTveCAxoCyb6FmV9TAXWJefqM99W63tVm0hdnSit7
         dfDlnqS9A9nAMM3NEjY5ps1oIvOvYOf/8FpwTPNpaFwAb6of2zFmWtVAuQ35WFqjJGbF
         Oo8zyExSaPfmbApKY/7ClNP2Q1HvXRn+zSxSE8kKwrRThfqgthjNC+n8ZMwls6xvTyTk
         P7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220988; x=1755825788;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFLWQrX/LolS+zwFqWLu+O1K3ykf+TN+Y7Suabqmqds=;
        b=xGCUBOuEuC0b1CguBGP3R26OhakK71PJPVJSgIFrAHz0QKfDJ8lZoICBTlawFyrGCZ
         w4jGKVC/cMK0Vz0+eNdn4GWMgWW94yVaj9ZxVGArsYzfBwb0rpdxTyOJoXq99diNPmLV
         suUCwGcS+08PUVfKp+SlISbN/4FdKh+XqVmw/tvXCMJTCBBNq03fgJsZRUHXHj88SIK0
         fKKZUksZXhQuA+u7DwU90zGyvXHoonC6fs9OGBNGfr4Nw35fh+ZIEtLmb1HfLuxHkCnZ
         4sfnlm3TGRaoEGGuOuCN6PymI9btJgq9o+Tqb8MMuBvty8dMGaD1vmzESw86eF8cGLh+
         8tOg==
X-Gm-Message-State: AOJu0YwR5N/3+fOVsxxHVI4ro58YvX/bsZbaRxRN+2Wj00erM9cPFDI9
	kqzkZszu4PX+ZBPW9/Omxdy9bhJSbbsx5H0DD+IxnbsKP91DuW90g9Ep48InKQ==
X-Gm-Gg: ASbGncu/VNJlS/5aGw0/w8N7J/F6RbWz3GMgP/OPtCyOeD1lXgR+gBS41wddNkNNU/y
	ysz4FEw5iRFIeWD31NxfGKKnedcO7qOlCPbo9OeB7Zp0e51m3JCPJtEDUGENMF6QIPpxXrZUIkQ
	rTqHzQcBubu8Q31nVjhHcYRR4k41rR1XJpIJNnCxdC5O7kZMsCcE6AgE9KcyOl4d/pMXFpBl6D2
	smsK4cXxRD9KDxwzeTEFwNh2gDFF58BQvFZs+0U2fsbHQX6/dnvX0D/Bu8JyK+qoHFQ2We7PdFF
	wlD/l4wAQcRETE1gJ2dJDRInXQ7uA9u8goCJi3/U/uSLB4bfC3lHIOI0TbqRZkLvWRsWay7cfVH
	zabmssTZVpAKgXeTC+UK9tzE=
X-Google-Smtp-Source: AGHT+IEMcHH2RS2hFE2TrToVhPf7Zn1RWTBW5IppSeqn7wqQ23J1E6Ie+uWfo8jS6dUizSP5IbvYzg==
X-Received: by 2002:a05:6000:3111:b0:3b7:8832:fdd5 with SMTP id ffacd0b85a97d-3bb67007aa5mr77883f8f.16.1755220988453;
        Thu, 14 Aug 2025 18:23:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c790689sm41824235e9.28.2025.08.14.18.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:08 -0700 (PDT)
Message-Id: <c8d411732742d774d2ce6418369170b9d1e9c0fc.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:50 +0000
Subject: [PATCH v2 15/17] xdiff: create line_hash() and line_equal()
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
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

These functions use the whitespace iterator, when applicable, to hash,
and compare lines.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/xdiff/src/lib.rs    | 19 +++++++++++++++++++
 rust/xdiff/src/xutils.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index 9cf0462bcdb9..809c5573c6e7 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -1,3 +1,7 @@
+use std::hash::Hasher;
+use xxhash_rust::xxh3::Xxh3Default;
+use crate::xutils::*;
+
 pub mod xutils;
 
 pub const XDF_IGNORE_WHITESPACE: u64 = 1 << 1;
@@ -15,3 +19,18 @@ unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
     let slice = std::slice::from_raw_parts(ptr, size);
     xxhash_rust::xxh3::xxh3_64(slice)
 }
+
+#[no_mangle]
+unsafe extern "C" fn xdl_line_hash(ptr: *const u8, size: usize, flags: u64) -> u64 {
+    let line = std::slice::from_raw_parts(ptr, size);
+
+    line_hash(line, flags)
+}
+
+#[no_mangle]
+unsafe extern "C" fn xdl_line_equal(lhs: *const u8, lhs_len: usize, rhs: *const u8, rhs_len: usize, flags: u64) -> bool {
+    let lhs_line = std::slice::from_raw_parts(lhs, lhs_len);
+    let rhs_line = std::slice::from_raw_parts(rhs, rhs_len);
+
+    line_equal(lhs_line, rhs_line, flags)
+}
diff --git a/rust/xdiff/src/xutils.rs b/rust/xdiff/src/xutils.rs
index 38126b47292f..796a5708b6bf 100644
--- a/rust/xdiff/src/xutils.rs
+++ b/rust/xdiff/src/xutils.rs
@@ -1,4 +1,5 @@
 use crate::*;
+use xxhash_rust::xxh3::xxh3_64;
 
 pub(crate) fn xdl_isspace(v: u8) -> bool {
     match v {
@@ -151,6 +152,33 @@ where
     run_option0.is_none() && run_option1.is_none()
 }
 
+
+pub fn line_hash(line: &[u8], flags: u64) -> u64 {
+    if (flags & XDF_WHITESPACE_FLAGS) == 0 {
+        return xxh3_64(line);
+    }
+
+    let mut hasher = Xxh3Default::new();
+    for chunk in WhitespaceIter::new(line, flags) {
+        hasher.update(chunk);
+    }
+
+    hasher.finish()
+}
+
+
+pub fn line_equal(lhs: &[u8], rhs: &[u8], flags: u64) -> bool {
+    if (flags & XDF_WHITESPACE_FLAGS) == 0 {
+        return lhs == rhs;
+    }
+
+    let lhs_it = WhitespaceIter::new(lhs, flags);
+    let rhs_it = WhitespaceIter::new(rhs, flags);
+
+    chunked_iter_equal(lhs_it, rhs_it)
+}
+
+
 #[cfg(test)]
 mod tests {
     use crate::*;
-- 
gitgitgadget

