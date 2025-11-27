Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9B29BD91
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205844; cv=none; b=aXKmQySYKBnFOceUhFupkxtW0NVnTYVzI6VkU2pb6bQ4ZopBDx9ODYYlCpGcShCoPHBCgI8GyaaJAj3KS0gmpxO7O7FaSm9lyNMLdWMCcLI0om9Kj0sWeK1q3ZvSTcjTX0NVDWw7UPrWh83oQ/WA8A4Rok1Ee/uT/vCdndGg4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205844; c=relaxed/simple;
	bh=tOg1E15qV3tkd6HQk940FupJCoMJw9zMC6yFkXhzm68=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BQLZ3XM87hgBIWXui8DFJBZV2A16gS2BNq/gyMR+iSxsMWYGfpVRqPVLtFjyIcziw+lHFEh5vscvhVeLfrKqorJxgK7gSdkygLT2JXAk76aabRwyN4Gc1Xmf0LkZFWXsNKQ5IvzGmLiNd33x0LOVtXHkts1ZNJYMjNeLywf2cF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWkAebU6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWkAebU6"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-949031532f9so20635139f.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205842; x=1764810642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwPnNvEzjTHv7hvNu+05u60QS91n9rv0cTDawJxktmY=;
        b=eWkAebU60y4xjsAMDtHyscuR7DVSWnt8Ag1lhqrADPGs3ifATVZ586DarvRq4s8Cgm
         j36qXo9gTAYWNP5C/w24YeT3ZJTvg+mMBoclOXDMHE9MWH8w8yQ7DrimxSISy12xtVeP
         rwVstWXJ98P4zGFN/PXgO5QlJwh3IMbs7d/QZ+17F9R2t6BhPTcTbpWXgWaME6BTr/+9
         qj1awv1ocgcQQM0mGbp5FBEO9ps5+Ji223oYYSXXtBK/tOfhBb2beihfPQtOTSABUuAw
         eDjpswWV5rCiRzQ4rsVoyI2FIoIjk/vx1XT4S5kOUEoeSEX2oJq05Q4JaXQSIYF6lwaI
         GAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205842; x=1764810642;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwPnNvEzjTHv7hvNu+05u60QS91n9rv0cTDawJxktmY=;
        b=SUWBRI3iQkjpY0ovUSv7IeG5k6fMr1tMdeQLV5gMTnOhRe0nBSu8fnmi84JEogLvx7
         sb5RdgWXFrqcA8YySEU027z8BipNCcNta08NL4usCcFMwKB7uM1v++GkDDm7vFDhomKY
         M2hWL/9msxTvhaAXq3hf8mORPevDOLOZRohZ02qdtDkYBRITvTy3kZAxQgIDec6OPsrG
         rnaVjBkFrcVlwxoe2+Q8tOEAr5JYBRdH5wWQ3v9vFK2SurVIAzJak4GCray47qLsTmG1
         3FpxoeEwbc/B5VFhjRIZk7Yg0HqzbbGCP2IP/0NJUaGKVR+KNGZjwiGubZXPDzPNQ600
         6P5A==
X-Gm-Message-State: AOJu0YxlRBPZQ8aNiHQFNZDGUWU4JMUSgyWAB2w3c0GAXezf+NJSCYcF
	/sNgdMTaXbv7g7t/oEArliN8fIsqOzhmUxAsIfW/JvAy+r42i9PFQOH2B8l9XY2G
X-Gm-Gg: ASbGnct1yEjfxWDNc9oZOWalgqJ43cg0IqufuPm0y3W7YcSGpEd/iYfHaDsgBvPs/nT
	yM9IUjNidgru0Fe5wgyFqeiY7SHWZyE8ouAcizghBP2+tZhrlMgFVKbAswrOmbyxVqn0px9BBof
	x3NpUBAzKf/q25nFUHC7LfeO7kGrCcblL02ZbVpXX2VKTI46FnMDvK80NcV3kUzOmjdP2ygds32
	3r2yUwZrIpgTUsEvzRUL9d+vUxX9p/txmDWwwXdqraoaDQcpRbGdID0X+kO+ONMkvbeTLpYd7z3
	Am9Lu5/Siwsq0JxcHHbejKBYzyI8nF/TJphRN+HTBg+0LPsiDRe5pqPCdovbXk8S76iY9dvUJ18
	XbsRQLAmsOjfz1jRnesHz1fCEREnpCwGjNtW/h/TJx+8PUrRo8FTNaep3hY4klVeLazhCLFD9+S
	GNdoX6nacliam1iA==
X-Google-Smtp-Source: AGHT+IEB205MKH21AC6DABsyVU4EQz1kZg5MTe/Mq2pf1/xSLAQPwK15nlTUfIa+c3ieBjXeqHdKPg==
X-Received: by 2002:a05:6638:8721:b0:5b7:10ea:e2a7 with SMTP id 8926c6da1cb9f-5b965b1af7bmr18101303173.8.1764205842089;
        Wed, 26 Nov 2025 17:10:42 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b9594bd003sm8475178173.35.2025.11.26.17.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:41 -0800 (PST)
Message-Id: <e49ffba5c99ce40b67500bac52a36ae83d10647b.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:25 +0000
Subject: [PATCH 03/13] cargo: convert from a crate to a workspace
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Cargo.toml                          | 15 +++++----------
 rust/gitcore/Cargo.toml             | 10 ++++++++++
 {src => rust/gitcore/src}/lib.rs    |  0
 {src => rust/gitcore/src}/varint.rs |  0
 4 files changed, 15 insertions(+), 10 deletions(-)
 create mode 100644 rust/gitcore/Cargo.toml
 rename {src => rust/gitcore/src}/lib.rs (100%)
 rename {src => rust/gitcore/src}/varint.rs (100%)

diff --git a/Cargo.toml b/Cargo.toml
index 2f51bf5d5f..02273f5142 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -1,10 +1,5 @@
-[package]
-name = "gitcore"
-version = "0.1.0"
-edition = "2018"
-rust-version = "1.49.0"
-
-[lib]
-crate-type = ["staticlib"]
-
-[dependencies]
+[workspace]
+members = [
+    "rust/gitcore",
+]
+resolver = "2"
diff --git a/rust/gitcore/Cargo.toml b/rust/gitcore/Cargo.toml
new file mode 100644
index 0000000000..2f51bf5d5f
--- /dev/null
+++ b/rust/gitcore/Cargo.toml
@@ -0,0 +1,10 @@
+[package]
+name = "gitcore"
+version = "0.1.0"
+edition = "2018"
+rust-version = "1.49.0"
+
+[lib]
+crate-type = ["staticlib"]
+
+[dependencies]
diff --git a/src/lib.rs b/rust/gitcore/src/lib.rs
similarity index 100%
rename from src/lib.rs
rename to rust/gitcore/src/lib.rs
diff --git a/src/varint.rs b/rust/gitcore/src/varint.rs
similarity index 100%
rename from src/varint.rs
rename to rust/gitcore/src/varint.rs
-- 
gitgitgadget

