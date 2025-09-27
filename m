Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160027450
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931670; cv=none; b=j5bSJr8vHwcTMR9NtIpWR9mcRbd91jPY5tduHIl8DJdOG6nBqhXE/LgwIu0tUzUFaJu9+qDEw4e8ksCF9h3eA6qEeTthCXxnuEwBI4DYwq2vd1Ifv2BbyGv+hgLhjjz1Fa/oAAxvqOO/COEfmthS94lCSmfsR990Wxn9xFSPWtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931670; c=relaxed/simple;
	bh=Vm/rVxpmy0cmZ7gmBDVeBfsVMEqjU7TGas2EzOtC+qs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mc1NPc9o+iiRJRu1lD4PTuApuiXpVUIRDDJdWDb+d0VnmTGP53aJXd+Dr0qC4XY/imtMk/CG+fvvG/XGaVkyr1lEX5l4YWU6QqtL+Icq1CX/Ekt3tYZbaorb2q4O2GcyNhQUjnFbUQt6IfDON0KyPge9L+0/gcHAZzlZydnNMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRphNJ5F; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRphNJ5F"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-854fcb187b2so303469285a.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758931667; x=1759536467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoowTXkBJcEmZPY4llr7ch/RHORltqdssQwef+UEu3s=;
        b=NRphNJ5F980jfhIBP9aT1gCiG1tYkd4RdxRDzOdho831gnG+mjoppJg44uRcduCUaB
         MA8CwISfA2l8L9pfFkk+Qxxw0zTXnOxgDbOF7RDCjvglwsx+ormCAXVp5G4q6/dZ9CXM
         JOVW6xgZugxZ2X1SAK6ilsDgYQ8wXXcJHzRd8O/dg5lTpWi+zg7iPcYFEXH6D5FIh2RA
         vGeIzxlV9tyhbKtErhvo8rPUzcEOpMNVhHbeRNTwW30jzCVuD3XM21M2Fb63mTVUqimR
         OofzI+gWgxCAduR52aIjxf6cKN6GUi+wE0yadCyzjhKT809kC4KErsAS9i31sFhcD09V
         wBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931667; x=1759536467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoowTXkBJcEmZPY4llr7ch/RHORltqdssQwef+UEu3s=;
        b=uniWBaxmGmXG3mswXQuMkObM7BSscOESsXRFXz+bZoLriX0yVhZJMr10ulzYJUE0nx
         HxtlEq0RqrF1rOCmbVPMt5PoE1qWd+1Hy21ajv8VcNh+B5KwuHr6skK5ig9/zzqwgA8+
         RKW/s1XxQlTT/o5MC31UXvh4d9nAH5mAjf7fZ/ONZ1pBY9nr+ja8ei9Nhb042XRUoKoH
         26Bu0M7sHHZJKfiqDjja1dlbyN0dtJXEwSsANUR+uSKepUPdBCzs7eJ5u2UiCcdwAX7x
         jsF0OZG/XIq3NR/2B6q2EhDrnyTUY+vFlImHB34qw8MQ7VHxoFiarnAX73lWRv+hFIm5
         daLA==
X-Gm-Message-State: AOJu0YyLldrGWSIRfk96riIwjUu8cME7GTAYio9DvMsxL+QU6db47cuw
	aZmW/SofLmenUJcFQ2kE7JcIQs3SqDd04ZNn4oLfehhv5Qo44WgCG6WohHbyM/Ky
X-Gm-Gg: ASbGncvf6Gu7FEyZcWe6lid315/4HKcmH1j5kGuIFigHmqb8nljuSOsEBkQRzOWchAD
	jsbXSTtc3/fPK4RjbqBRLY4kPX2foc+NWRCwMBFGmV46exiRG6Lyk4CVy41QplfUhiR7gCWp0VP
	+ohnc60bTIZk9qkplMrQndwB/Fg2cBWSrcwsscTfY6zNSf/PP6iFA0vFqbgR6JuI0+MBn1fTCPy
	CuJ+E71IleMocSlwrXXR0tEtAa5p7IjKQ6Nn5ove9RoPsuG4ieUyVj39Ro+keYbWhsgz/VG5GyV
	ktjmZ6sCV6hrFzfX4s3/ti2+hsmHWwlV/42Ce/lTTs7Gp85eO2uj1km2j6ES5N6BLAugs6VQJpF
	Jldf2fpOlFrDf+lyYGsmxPWC/aedfJc1Q8KNo
X-Google-Smtp-Source: AGHT+IFngnXDSn+8he3uZVPOOCvlsIL3e3BIwT6dlhHsGEkNhGRlRh+62LJH1lL/E14iHhu7Dlv1fQ==
X-Received: by 2002:ac8:7d8e:0:b0:4b7:a8a1:3f2b with SMTP id d75a77b69052e-4da4c39dc42mr127883241cf.64.1758931667362;
        Fri, 26 Sep 2025 17:07:47 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11fc7bd1sm33558881cf.52.2025.09.26.17.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:07:46 -0700 (PDT)
Message-Id: <a5904a2ac00ea6de142344272b45f6b4697b4f98.1758931659.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
	<pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 00:07:38 +0000
Subject: [PATCH v2 2/3] libgit-rs: add get_bool() method to ConfigSet
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
Cc: Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Add support for parsing boolean configuration values in the Rust
ConfigSet API. The method follows Git's standard boolean parsing
rules, accepting true/yes/on/1 as true and false/no/off/0 as false.

The implementation reuses the existing get_string() infrastructure
and adds case-insensitive boolean parsing logic.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 contrib/libgit-rs/src/config.rs    | 24 ++++++++++++++++++++++++
 contrib/libgit-rs/testdata/config3 |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/contrib/libgit-rs/src/config.rs b/contrib/libgit-rs/src/config.rs
index 6bf04845c8..3f4a32c72d 100644
--- a/contrib/libgit-rs/src/config.rs
+++ b/contrib/libgit-rs/src/config.rs
@@ -68,6 +68,26 @@ impl ConfigSet {
             Some(owned_str)
         }
     }
+
+    pub fn get_bool(&mut self, key: &str) -> Option<bool> {
+        let key = CString::new(key).expect("Couldn't convert key to CString");
+        let mut val: *mut c_char = std::ptr::null_mut();
+        unsafe {
+            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
+            {
+                return None;
+            }
+            let borrowed_str = CStr::from_ptr(val);
+            let owned_str =
+                String::from(borrowed_str.to_str().expect("Couldn't convert val to str"));
+            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
+            match owned_str.to_lowercase().as_str() {
+                "true" | "yes" | "on" | "1" => Some(true),
+                "false" | "no" | "off" | "0" => Some(false),
+                _ => None,
+            }
+        }
+    }
 }
 
 impl Default for ConfigSet {
@@ -102,5 +122,9 @@ mod tests {
         assert_eq!(cs.get_int("trace2.eventNesting"), Some(3));
         // ConfigSet returns None for missing key
         assert_eq!(cs.get_string("foo.bar"), None);
+        // Test boolean parsing
+        assert_eq!(cs.get_bool("test.booleanValue"), Some(true));
+        // Test missing boolean key
+        assert_eq!(cs.get_bool("missing.boolean"), None);
     }
 }
diff --git a/contrib/libgit-rs/testdata/config3 b/contrib/libgit-rs/testdata/config3
index ca7b9a7c38..83a474ccef 100644
--- a/contrib/libgit-rs/testdata/config3
+++ b/contrib/libgit-rs/testdata/config3
@@ -1,2 +1,4 @@
 [trace2]
 	eventNesting = 3
+[test]
+	booleanValue = true
-- 
gitgitgadget

