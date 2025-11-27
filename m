Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881692C159E
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205849; cv=none; b=h1mIfIUUpvhfnc9glUGa2vHwlANMAOOKWkGei3Gcw/pAEN1K0qFFzWvx6R6zLncdhICYJxKBBm0Xp5Wy2K70gff2iT4NcFAo3ZNUs4eenaZpa7Kur2ZeoYrQBSNZJagNNxVvSHchYcfqJ/gUr8Mx3jNWCR8+DkVQS7weGxfcytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205849; c=relaxed/simple;
	bh=j0pC7d4slqUtDBJnTnOxnrvalf2kEH9H9Gqt1HOiaLc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gcJ+1QFvfbxJbDVk9mLFWGf7KKBvh9YO9SyuTpnEf98IGxRJfSuxIGsYNm6gPA8kmhHZZnZADy8Z+tDVciaPotWlREuL4pBcOTPgLdRVQLfKBRqbqAiPv7XAiANBnhS8hgdK9vH6RPXfcl4uuiAfb8UKrWn6Yno8LArZn0cOdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaaowNmF; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaaowNmF"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-948fbdbc79fso12321439f.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205846; x=1764810646; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD2s1UKdX4wh57lGXny83ibne6X9duzcx1bnceF8e80=;
        b=IaaowNmFafdNoRhVKCtPNFdLlwQfxWbyCZ/Q6bl7OntXXZHgOnC7Fjqi5QDJbNTfjQ
         wm8J90Uoj7A+UW+Xz4pWC0fiFlGkNAi/URhqH0Gww6/p5tXogqEb657sngPJTpKHFX5e
         3WzEUmnSDOn7WKVaHgGJ/E1NTaSDryKDPQVddDpHYhVJBmOItsTFrfzpjROEpqRL4K1Z
         lXf79D29xxxa2mvIE8Gzmz8o3F6RfTeiQLguV0xfOhc6vreJlPjjXWuu1DD+0J2jyUZO
         tPWdemLG3tHSKgKlVthnaKHhX+cS+zsx+2zmwscNWjhdjR4gtC+rIGrLEvK3ArB7zW7X
         oXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205846; x=1764810646;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TD2s1UKdX4wh57lGXny83ibne6X9duzcx1bnceF8e80=;
        b=QDFmKZvxL6LjYAajvDnIgp4J2Xkh4/DIdiVHa437hX/TwlIo7SN3ThUm3/u0DZ2/kg
         ZX8P+X0aIW9ThELLXvjBvFFfuQWkwJYOtapxCiThqrxZcZ0xHYa9OTisiOhUKOKNsOsv
         z+Vl6NHJi2MHSl8Nazy/qJuRzRhtDuJPsfICTzmoAHlB4aE3oMWdCUf15tgNb3HZ3KFq
         QimprorDJ/nZk3ZMcw7Vq6ap7og3xQTovqwgE6j8Vr0bbCEfiG5gu99zOrew/uzRtCBU
         SWVJ3y3q2kEn5pix1xIZL+Zp8arxS50CxCwPCuKWJBM1/Dw65JaMD7OimWDWy2zvdESX
         OP9w==
X-Gm-Message-State: AOJu0Yy58144f9RY5WHtS8aPgP9j7u/jZSVcnegzRh6PzAY9KK6K1F1N
	wxsek+DuhCE9LDOOyk9Xh4GzMFnz0odZCPaDiPnU7hlMWMcXZtrowrsZzq/sljQL
X-Gm-Gg: ASbGncvGcljDJgKUBuerZRt6BAfHsUJHSvWoOOS4ccUb+7Ry6b4qzRlK24XwLq5/KQe
	wXL/0PjfVjM9z0YueTUy8bjKRq9tH8W726uU/+vMEMQrdHdfFrat6MPCeoXtwbT1Q+NHQCJrdmM
	beoaiWUxNAt6LrLQR0GyUsa3LdHGf09X9U2oemJ2m4cu50T4xQMbNsgQnOYRX0KOs/J+ZQq/Jf/
	2NdOS5NlCh9/IYK+OrbJENOmh303gdnfByKjaIqk0WvZAUK6GgrkbP3Jfqndc0a4uKEOGymaNQE
	Nt94JPvcTmuoKnPUaTIOaPe9n/M3EAPWlgzZkGsEJIqotxsCDZ7HZ4v4t9tmVVeaXglerVtyHds
	3PIadGCEPv9pVWXIeUUdOXz30nvx0v/W8SG7EirbFRSs66+8FER/HLCZXP8CMD1644uaRANKL7K
	u1tZXoHSfM7ulR5A8ESh07STBq
X-Google-Smtp-Source: AGHT+IGuVrft1jINJVEZloloJIxJhOnL0AYAkhr7aGyilD6e5OCL3OeacMjrL7j/gD/MchCQtyiN4Q==
X-Received: by 2002:a05:6638:c0fb:b0:5ac:cd9a:4c4c with SMTP id 8926c6da1cb9f-5b999555c41mr7850756173.2.1764205845982;
        Wed, 26 Nov 2025 17:10:45 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a0ee6csm8895127173.8.2025.11.26.17.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:45 -0800 (PST)
Message-Id: <4a17edade9aa18eaa7a173bf2bd5eecda74508c3.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:28 +0000
Subject: [PATCH 06/13] cargo: create crate generate-headers
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
 Cargo.toml                        |  1 +
 rust/cbindgen-template.toml       | 13 +++++++++
 rust/generate-headers/Cargo.toml  | 12 +++++++++
 rust/generate-headers/src/main.rs | 44 +++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 rust/cbindgen-template.toml
 create mode 100644 rust/generate-headers/Cargo.toml
 create mode 100644 rust/generate-headers/src/main.rs

diff --git a/Cargo.toml b/Cargo.toml
index 02273f5142..b7b5890934 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -1,5 +1,6 @@
 [workspace]
 members = [
+    "rust/generate-headers",
     "rust/gitcore",
 ]
 resolver = "2"
diff --git a/rust/cbindgen-template.toml b/rust/cbindgen-template.toml
new file mode 100644
index 0000000000..13c192d60e
--- /dev/null
+++ b/rust/cbindgen-template.toml
@@ -0,0 +1,13 @@
+## don't include any system files, not even git-compat-util.h
+# sys_includes = []
+
+autogen_warning = "/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */"
+
+language = "C"
+no_includes = true
+usize_is_size_t = true
+style = "tag"
+tab_width = 8
+
+[parse]
+parse_deps = false
diff --git a/rust/generate-headers/Cargo.toml b/rust/generate-headers/Cargo.toml
new file mode 100644
index 0000000000..9216d83d75
--- /dev/null
+++ b/rust/generate-headers/Cargo.toml
@@ -0,0 +1,12 @@
+[package]
+name = "generate-headers"
+version = "0.1.0"
+edition = "2018"
+
+[dependencies]
+cbindgen = "0.24.0"
+textwrap = "=0.16.1"
+once_cell = "=1.20.3"
+unicode-width = "=0.1.13"
+quote = "=1.0.41"
+syn = "=2.0.106"
diff --git a/rust/generate-headers/src/main.rs b/rust/generate-headers/src/main.rs
new file mode 100644
index 0000000000..da68c8ae3d
--- /dev/null
+++ b/rust/generate-headers/src/main.rs
@@ -0,0 +1,44 @@
+use cbindgen;
+
+use std::io::Write;
+use std::path::PathBuf;
+use cbindgen::Config;
+
+fn generate_header<F>(crate_name: String, editor: F)
+where
+    F: Fn(&mut Config)
+{
+    let dir_workspace = PathBuf::default();
+    let dir_rust = dir_workspace.join("rust");
+    let dir_crate = dir_rust.join(crate_name.clone());
+    let dir_generated = dir_workspace.join("generated");
+    if !dir_generated.exists() {
+        std::fs::create_dir(dir_generated.clone()).unwrap();
+    }
+
+    let file_cbindgen = dir_rust.join("cbindgen-template.toml");
+    let file_out = dir_generated.join(format!("{}.h", crate_name.clone()));
+
+    let mut config = Config::from_file(file_cbindgen.display().to_string().as_str()).unwrap();
+    config.include_guard = Some(format!("{}_H", crate_name.to_uppercase()));
+
+    editor(&mut config);
+
+    let mut buffer = Vec::<u8>::new();
+    cbindgen::Builder::new()
+        .with_crate(dir_crate.clone())
+        .with_config(config)
+        .with_std_types(true)
+        .generate()
+        .expect("Unable to generate bindings")
+        .write(&mut buffer);
+
+    let mut fd = std::fs::File::create(file_out).unwrap();
+    fd.write(buffer.as_slice()).unwrap();
+}
+
+fn main() {
+    // cargo run -p generate-headers
+
+    generate_header(String::from("gitcore"), |_|{});
+}
-- 
gitgitgadget

