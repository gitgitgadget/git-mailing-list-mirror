Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF211E573F
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220993; cv=none; b=XYbdszinp4L4ablcwcGMg5PtsDGR2tEUJilItRQE8alBjqMAXJARjToqG+lfntxFDyzeiB0m5Jiumo54P+johv+Xn6fgtCAlRcjfAVGjc6GA39T3JewSFpgbKb74BV1PCSdsUsf7/OiSPtsLZVMxoxRbBRpbcfQnSuxZ3IGD5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220993; c=relaxed/simple;
	bh=Dz9Lu2x4+JmVdhWaVwl2E++oPx462UVn0wQo2cl/3BI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tRWjL0T6O2lVU9eaQ90uSZX1/0MMeaQ9/HYprvCA6FvA/bQmPms0i1Jjap59uP6y1i9Jiii8oUMo+Wqrop8Kqar9qAcfBiyeNtHAe/212o+21+0PcHzPYSQD9D9snKbre2uexrhCevsElOcGPeu8l/0xbiJ4rs4KF16ijw/kF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLkfTDi2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLkfTDi2"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so866108f8f.2
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220990; x=1755825790; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvThyprrTXkInV6p5greILZDk+3qe/Ea33PG6Jm7m4Y=;
        b=NLkfTDi2DmiWnfuBFX8DrLmPTjiAYhVSJIqhNBgETP/NzIJ5rYNvofyiOs/vTjjWO0
         e6q95T3IQM+jcj+F1fl1VMJYML8cmKU7YdSBywFX230HRAFpzqz3GsBzaJonuBPfow02
         Zgll0vfiOtDCSO25Ad4kv0ErTxeVQroXVGoR11o9Jok2N5LXzXL6YGWKlz1TLw8PH/K8
         M/n2EVu7kwqQfbPuUyA1eQTTSZTPOsI9D6OAI8+IdOfUpx1NBOCCVZ6F5JyJjB2slrsQ
         MS1TeZcKyXq/9DqA0pnugEp21F56Th7Ld5u+5w/n49dt9CxV6m5TYe0tklLEskpMYz2l
         o+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220990; x=1755825790;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvThyprrTXkInV6p5greILZDk+3qe/Ea33PG6Jm7m4Y=;
        b=B3/ewIP1zsm7tHTvNJYQSswJvjlEXZIaAMYguh09L5OR/Whtb2kxQP7D6+mpfa3Iyx
         EJ3nQF6Ja7XNk9/5X5lKVfYo4MxUkmYn0V/iuX3Ot5ok6Dl8hAWy+EwP+XwedoiMiHmU
         CkkecRHocBzGtfQ+O0vhqiLvT4oZtJULg1Ql7VKus6Pex6ReH5Dx3wGcp1Ij3FbEF3bM
         SpTnEEmHm8k1SeUueWPB9WRTNMdWdlrlfpabVdYKgQ+MGtRzHsvqwiBv7dzmN0Oq7DMK
         sh+ZdHXoHSucL3IamWL/73Zl8aNIVIhu0i+dnP05C8HvLaSTGSgq0zjv1st/HOxon5GJ
         gZ1Q==
X-Gm-Message-State: AOJu0YwjjVHtA+ed9T88vyw+mZA9YlA8oJA6e5vlOX7gk4sCA3sf/vay
	sHp6K/RIXPbX7MhpUxytcla8kuTn9wXrDeZz9AsKjEpydKpfrIbniL3GfHMhGg==
X-Gm-Gg: ASbGnctR++YaQd5itN6SDbmPV/sVk97rcedt15Lpy6F93GuqGxAm1oK5/qsBjaSW3z9
	ZclLGUD/QIO82pHjLk5igeKH91IUQtVGUv1PJ/BdtB6y0zc1vPW9WdR7VgMaziR87Ql1ss91VZk
	VXW0GXB5iWeAVMMmchLwDnYuUaHIfcfI7ltz9IwgN/HE6h8klpw8PgQ+v5ORuFa1x3fqTrpzGtw
	msOEi/7F7XNB6yY4Bg+XqJUcNPeSe3ZwWtspkUJCnaPtyUTVkpVRWJ5atHyIZ6qMV9swnVwnXJo
	NrWcOBViFIwxDCfdwPe8119lfPbyIhmND1kd5ylS2a3+IYzlN9lUWZUOz6mKXtFfRxYJgnBCqC3
	EueYQ6rEG2kywbRT2TAWro4p2cSQYCCsUvA==
X-Google-Smtp-Source: AGHT+IH47o2OaK//Nq0261GUmCBK/3VbuKtY2dedTu/uAWpJ+yj0aTxx7jHb3gr6kEBTDdyJmridBA==
X-Received: by 2002:a05:6000:40cb:b0:3b8:d3cc:8dc with SMTP id ffacd0b85a97d-3bb68a16a53mr65151f8f.28.1755220989558;
        Thu, 14 Aug 2025 18:23:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64e27843sm124509f8f.19.2025.08.14.18.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:08 -0700 (PDT)
Message-Id: <f7829c558715022258486bc265e04bd093665e2d.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:51 +0000
Subject: [PATCH v2 16/17] xdiff: optimize case where --ignore-cr-at-eol is the
 only whitespace flag
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

Currently the whitespace iterator is slower than git's C implementation
so we skip using the whitespace iterator if there are no whitespace
flags. Special case the --ignore-cr-at-eol similarly to make it
performant. For the rest of the whitespace flags they will be slower
for now, but as more of Xdiff is translated into Rust it'll be easier
to revisit and optimize whitespace processing. Optimizing the other
whitespace flags now would be difficult because:

  * Xxhash uses chunk based processing.
  * The same iterator is used for hashing and equality, which means the
    iterator could be optimized for returning large chunks for fast
    hashing or could return each byte making equality testing faster.
    I opted for faster hashing. The data structures in C need to be
    cleaned up before they're interoperable with Rust. Once that's done
    I believe a faster method of whitespace processing will be possible.
  * Trying to make heavliy optimized code between 2 languages that aren't
    easily interoperable in their current state makes the code either
    fast or easy to maintain. But once enough of Xdiff is written in
    Rust I believe that a fast and maintainable method can be
    implemented.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/xdiff/src/xutils.rs | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/rust/xdiff/src/xutils.rs b/rust/xdiff/src/xutils.rs
index 796a5708b6bf..1ea9cfa02db5 100644
--- a/rust/xdiff/src/xutils.rs
+++ b/rust/xdiff/src/xutils.rs
@@ -33,6 +33,18 @@ impl<'a> Iterator for WhitespaceIter<'a> {
             return None;
         }
 
+        // optimize case where --ignore-cr-at-eol is the only whitespace flag
+        if (self.flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL {
+            if self.index == 0 && self.line.ends_with(b"\r\n") {
+                self.index = self.line.len() - 1;
+                return Some(&self.line[..self.line.len() - 2])
+            } else {
+                let off = self.index;
+                self.index = self.line.len();
+                return Some(&self.line[off..])
+            }
+        }
+
         loop {
             let start = self.index;
             if self.index == self.line.len() {
@@ -172,6 +184,28 @@ pub fn line_equal(lhs: &[u8], rhs: &[u8], flags: u64) -> bool {
         return lhs == rhs;
     }
 
+    // optimize case where --ignore-cr-at-eol is the only whitespace flag
+    if (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL {
+        let a = lhs.ends_with(b"\r\n");
+        let b = rhs.ends_with(b"\r\n");
+
+        if !(a ^ b) {
+            return lhs == rhs;
+        } else {
+            let lm = if a { 1 } else { 0 };
+            let rm = if b { 1 } else { 0 };
+
+            if lhs.len() - lm != rhs.len() - rm {
+                return false;
+            } else if &lhs[..lhs.len() - 1 - lm] != &rhs[..rhs.len() - 1 - rm] {
+                return false;
+            } else if lhs[lhs.len() - 1] != rhs[rhs.len() - 1] {
+                return false;
+            }
+            return true;
+        }
+    }
+
     let lhs_it = WhitespaceIter::new(lhs, flags);
     let rhs_it = WhitespaceIter::new(rhs, flags);
 
-- 
gitgitgadget

