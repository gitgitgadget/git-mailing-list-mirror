Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9622A4EA
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071822; cv=none; b=ScOxnpI4NBsVP46WjaHavF3RxgaUEjrYge54W4R119Uy8Z9+6criYSBsghHmzPs3XjggPFuigkDE9VUMFRLY0eeik91XUcvdk8bDvnjYcX72DvcE85ckhIBv3VUsXms0/A9cx7W2oiEdCVxFBGNR+OOuk854vVQ8cCkoKkjzstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071822; c=relaxed/simple;
	bh=1MF2PgxXe5ZPBopC5kJmnumEZOkmJH9MVh/aUvt9rgA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gwh9Uofz6MDgQvtzndTMSQfkmYOeC6I5K/m6woPCXZf1xnI+GUSxi7pWK0L6wXIao/VotHOOjayLvk0GUqQQMtHMJvvzvuUuvljz4egaKbUUUiSfO6yHgt24gDB5OD7d3+sGglmdBZk+EJJEtkqwf/d3iIDMR0IhpQ73PDC4n2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5yG7WLl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5yG7WLl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24458272c00so64948065ad.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071820; x=1758676620; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxgxpEM5kNtA3TbOSXQgIhozRl8rPJbcgHHmwSy6b8A=;
        b=g5yG7WLly5k7EuQu5PsWy5K/3738hsJ0R7wMIabK+TNJu+lN0HVsfWQ415sjtH4iko
         PGXzLOguvufpaENnEYowqQfMxjCjAd+r09OEl6cVbTWgqh5qDK8pJYYtsvHnZxMxQLxE
         D/dwz/gM1IFlPI63AqUdYWMWVyFIxx79mUESee+K7GhsnOPtC4bgH5j5etThjcBnyR8p
         JdbiPlSPK42D4awC8Df93p+3w0alKuGQO655fm0CDMhVx0BIOQ3eNGhYFxeMbnW5PlSZ
         nIKA6I1WjoHQI1yA6Ja4+fSLarpunKEIiokagSaBVQTnBJeBJ4h7GZDydDFnCIROvk3l
         dkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071820; x=1758676620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxgxpEM5kNtA3TbOSXQgIhozRl8rPJbcgHHmwSy6b8A=;
        b=QDD+WobAHqLRxkIhlHOJz+TfbrIhgYGC72lhXXNF4obRywoe6BAqSg9u5jjUnCn8Ee
         wXg1RHVhdJkWhPMsXrcpFkM4OTyhqG6tTPAoix3YZnDGkHQ/DBEFH1qfB7kthgs5Etnd
         GCIPB9Tk2TM4NYEh/66cXF/fuLZUwWoLyYeIHCjJrUhiSXockd5CEHAcUm3M48omasD2
         KQVVqQlM0Obb3qlePdgQcPtOvsaJghXPEC7fuC+dMIuG7s4iYGHzA0aWID1IsPs4gDgZ
         qJvjD5LyHDkghxHb/oC4aQnXgNmrTOy30b5s65XNdE4b+IIOA7dKRNSD9xFcMRNgi/b2
         25UA==
X-Gm-Message-State: AOJu0YxIRd4tu4TUKMluIXMI7w0nq6bauF57k4SHI6Gf2L5E9JBqh7KV
	VM52TASsfjuei3vqn4Sa4yi37yMzkUO8kVOjS9ul7nDtmuZtokcKDjsdb73goQ==
X-Gm-Gg: ASbGncs3Kg7orKWkmwsWahwIpKEhTPIWG1Ms9u4MpjK2y+D/2xMfWzqiv7qYwUumFZH
	h72sMlX9uOWUWFimhQ2mXBAgba+LAWXm/yUs2Ax5yACdogDgzOgF1iiwG+1vDGkbmScRb9pkspJ
	1ZvSSavhV8pGGqxzlSHRNwuWYu46AGYRCG8FwqlVAP2fYi9Nf7AxOL78tNxSFTuGTV2/3quee/O
	RpezczW4V0eV4t8Dn0fMsO1uyP85YPOJb3QYkQFx+T4fw7MHDFBOh5TSP5YG2vMkSsU0tWKdeQ6
	V5YkPN4yTG44gsyyGUfCYMXT+394xfJfZzWWu3t/rA8HnyHqU8WWK9Eh4cgRAreaSPyXF+KR58H
	IPa8hDf/aRC7H930fBkMaJo2r5OM=
X-Google-Smtp-Source: AGHT+IELglyH4ghVjG36GNG3bRyGvmwP6UnIztzF05sVKOtSSv/Wiu8FDaA3f+UZOvO4P6Pv5Wazfw==
X-Received: by 2002:a17:902:c404:b0:248:9e56:e806 with SMTP id d9443c01a7336-268118b3e83mr4082105ad.12.1758071820123;
        Tue, 16 Sep 2025 18:17:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26310ead07dsm100970095ad.29.2025.09.16.18.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:59 -0700 (PDT)
Message-Id: <17143ced6feea5927b66c0578f1c2fbb07378504.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:36 +0000
Subject: [PATCH v2 16/18] build: new crate, misc
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
 Makefile             |  2 +-
 meson.build          |  2 +-
 rust/Cargo.toml      |  1 +
 rust/misc/Cargo.toml | 14 ++++++++++++++
 rust/misc/src/lib.rs |  0
 5 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 rust/misc/Cargo.toml
 create mode 100644 rust/misc/src/lib.rs

diff --git a/Makefile b/Makefile
index ef55a8183c..c363a6365d 100644
--- a/Makefile
+++ b/Makefile
@@ -929,7 +929,7 @@ EXTLIBS =
 GIT_BUILD_DIR := $(CURDIR)
 export GIT_BUILD_DIR
 
-RUST_CRATES :=
+RUST_CRATES := misc
 .PHONY: compile_rust rustclean
 
 WITH_RUST ?= true
diff --git a/meson.build b/meson.build
index cbe1afac83..6911625f3b 100644
--- a/meson.build
+++ b/meson.build
@@ -267,7 +267,7 @@ version_gen_environment.set('GIT_DATE', get_option('build_date'))
 version_gen_environment.set('GIT_USER_AGENT', get_option('user_agent'))
 version_gen_environment.set('GIT_VERSION', get_option('version'))
 
-rust_crates = []
+rust_crates = ['misc']
 
 rust_builds = []
 with_rust = get_option('with_rust')
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index aaf008b5ee..010effef4c 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -1,5 +1,6 @@
 [workspace]
 members = [
     "build-helper",
+    "misc",
 ]
 resolver = "2"
diff --git a/rust/misc/Cargo.toml b/rust/misc/Cargo.toml
new file mode 100644
index 0000000000..7195d7894d
--- /dev/null
+++ b/rust/misc/Cargo.toml
@@ -0,0 +1,14 @@
+[package]
+name = "misc"
+version = "0.1.0"
+edition = "2021"
+
+[lib]
+name = "misc"
+path = "src/lib.rs"
+## staticlib to generate xdiff.a for use by gcc
+## cdylib (optional) to generate xdiff.so for use by gcc
+## rlib is required by the rust unit tests
+crate-type = ["staticlib", "rlib"]
+
+[dependencies]
diff --git a/rust/misc/src/lib.rs b/rust/misc/src/lib.rs
new file mode 100644
index 0000000000..e69de29bb2
-- 
gitgitgadget

