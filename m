Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3093028B4FD
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205840; cv=none; b=oePN5EpJpBMZBbnxr+++UL/RC5IVbVt/ZD1+4GG9XbTgslXO028ps1Xuzzj82Qr1l3kwdhvdO+ZbCQ90RLgYIbIJ8K/DQBAvsVKh4GWrg6asptNUrPtiLFIoVxq//Ld+x6EZrmhylMBlBwiErVfzGKlHfElJzg9eG/VP9aFPLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205840; c=relaxed/simple;
	bh=8rkfvec1jKUY/9aOMthknK/1lULU4JBk6UMHAQiwnos=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=X0LwnYSMFZXjcesixxm7ClfMJaGH4xSTWENpEh6lQEL3Q+p2UdVzK16gJLnvYVieMmxDbgvTwonHsKqzg+TP3cowImpcSiMLSDb6W4nob4PZ1vKI20TVUpJms67tlWQSdGnf/jrco9imr6FXZAss/n9AWNi6F0wYSVn5t3jNTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyYeIm4K; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyYeIm4K"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4330d78f935so1753945ab.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205837; x=1764810637; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oO/YRzHlZrnsPAOL5JVMMj2fW3ffkSVPUVdzEYk++a4=;
        b=MyYeIm4KATjMrl/g0spxpNgWzfM9UqKCEygt6KuPfOCpmrTulKdbqXq59r3YVGDYkn
         d6b9HxP20i77JxG1XKHXNjKHdgcoCrWh16CfLIKGngEUc4xpZpQB0NzLCbIzTCpNfxe+
         e7exUnokNjFZM1jUzjyJXCAwc3171kvPwzAzn37SMcJgb2xseo+UqcsT2vojEK/+9VPZ
         ffW3HqbowI853i9C7pTFndqjeA/fX06hI5kv/+yBNGxv8d1v8DvUjb6oLa56PNi9I/SC
         0x5UFF5zGV54C8ZRgRSGFBq85e0rETiVuGbTg9RC8mBeP4PFfIf+Lt3Zsc8StrzYyhmj
         v0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205837; x=1764810637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO/YRzHlZrnsPAOL5JVMMj2fW3ffkSVPUVdzEYk++a4=;
        b=mR7uqK9/yyVmQlBprXRgEawWzWPc/QAGNNTjmYs/i9Aw6txQcfj5R84Ff9yCoMMjzu
         xaXe4nRNFO/p705fxVScmi6F6DpO929YE7PIOPe4uNBukr5ClzO/oep0v4n7lNH4nkYh
         t34QWMSA31eQvp0w3y/axYSw3m6kItXnHcS/4dn+WTgTIjEZS33gDaAnQ0ceZcGdyfMp
         5frIcU1tBzmxl9kIyFNygHuR4YS4hSOtHVZJVyU6Bq+HZfOunJNt74vYc5xD0JTha8B3
         iznmRWpORAzgZq1YuChgPkvRNEy5nqys68Sd/62CnRkAzUcZH30tAQs6LCI1iFVbpAqv
         /T+w==
X-Gm-Message-State: AOJu0Yw0VdzOVKkz8ZKWe0wlHRnytygH9v3ObcRepH77kF2xsRE3op7a
	PAlavA2aT1BRtzN12kjBk7qfCZ+lKpxxssBn1EPmnTpnqWGRt8n3jmblMUCDwg==
X-Gm-Gg: ASbGncuQ7PjFPHp279qBF7G1BKT6kncdT3bWKiJafUXbR8LdGyWr+fqJPuwEaHowJ2S
	siNLVsa4J6Bj7OmjBmsAdEFwGzvPmT277KNy0N43WUY0bAOqBcko2+Irk0rQzv9K018vZhOjjzP
	i839KO7sxzpGXtn77+cpCI0/LKsDIn5V52LtQ8c3qnlSLMCMV2mGXyvPasbu6Gmuk6ZKo8dDZHv
	cpeZo86gWL+CdHLwyNlIwwQuEXui9v1ZZjMpSzvO5M/MYRDzwbzQKbgjVbdnxgNjNj7MkH/CZwB
	iDBfm3k4hEt6n+kvOiGXjtwpa0SLowKR5Sx98L0dhfm0h6ydgHieXnMvvklBbDVV7ebMRdlJ3k0
	LsnnKqCs3zFIu/c8vwgcgdM1Vo1UGXdGxBrXV0jcbsdlnT/ECOKqhgd75y5O5IzhbZRCVAjkyvw
	5MusK4qiUkEAGdUA==
X-Google-Smtp-Source: AGHT+IEaiBPuHBVEH3T9FPSWVpC3vryKxOKS2dy9kP5z8NfWw2ECH1CwROesm557qSNxKoWxrCsxSg==
X-Received: by 2002:a05:6e02:19cc:b0:434:7cf6:6d20 with SMTP id e9e14a558f8ab-435b8c0991fmr186907185ab.11.1764205836688;
        Wed, 26 Nov 2025 17:10:36 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a0dbaasm9024491173.4.2025.11.26.17.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:36 -0800 (PST)
Message-Id: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:22 +0000
Subject: [PATCH 00/13] RFC: Convert to Cargo workspace
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>

The goal of this patch series is to get feedback on converting from a single
cargo crate to a cargo workspace. This series is incomplete, and as such, is
marked as RFC.

Why using a cargo workspace is better than a single crate:

 * Better modularity.
 * Since a crate is the smallest unit of compilation in Rust (not individual
   files), multiple crates avoid recompiling everything
 * A C header is created for each crate by cbindgen (if requested), avoiding
   a single monolithic C header from all Rust sources.
 * This separates the dependencies of each crate, which is important if
   we’re forced to take an old or new dependency for a non-library crate,
   for example, and don’t want those altered dependencies affecting other
   crates.

I am particularly interested in feedback on the known issues below:

 * github workflow rust-analysis: broken because I removed the rust-version
   statement in Cargo.toml. The minimum Rust version supported by Git should
   be documented, but we shouldn’t require building with that minimum
   version.
 * win+Meson build: failing because it can't find the static library
 * Rust unit testing: not implemented yet, Make and Meson need to call cargo
   test
 * Conflicts with Brian's "SHA-1/SHA-256 interoperability" patch series

Much of Patrick's earlier work needed to be removed because it assumed a
single-crate layout.

The Rust crates are located under rust/, but cargo build must be invoked
from the top-level Git directory. cbindgen is included as part of this
series, but nothing uses it yet. The generated/ directory is where cbindgen
places the generated C header files.

Ezekiel Newren (13):
  make: undo Patrick's changes concerning Rust
  meson: undo Patrick's changes concerning Rust
  cargo: convert from a crate to a workspace
  build: build Rust with Makefile and Meson
  .gitignore: ignore /generated/
  cargo: create crate generate-headers
  cargo: create crate link-with-c
  rust/gitcore: link with c
  varint.h: unsigned char -> uint8_t
  make: delete files in generated/
  github-workflows: unify with rust parameters in make and meson
  github workflows: install Rust
  rust/build-rust.sh: update dir_git_root variable instantiation

 .github/workflows/main.yml          |  62 ++++++++++++++-
 .gitignore                          |   1 +
 Cargo.toml                          |  17 ++--
 Makefile                            | 118 ++++++++++++++++------------
 ci/install-dependencies.sh          |  14 ++--
 ci/install-rust-toolchain.sh        |  30 +++++++
 ci/install-rustup.sh                |  25 ++++++
 ci/make-test-artifacts.sh           |   9 +++
 ci/run-build-and-tests.sh           |  17 +++-
 meson.build                         |  83 ++++++++++++++-----
 meson_options.txt                   |   4 +-
 rust/build-crate.sh                 |  63 +++++++++++++++
 rust/cbindgen-template.toml         |  13 +++
 rust/generate-headers/Cargo.toml    |  12 +++
 rust/generate-headers/src/main.rs   |  44 +++++++++++
 rust/gitcore/Cargo.toml             |  12 +++
 rust/gitcore/build.rs               |   7 ++
 {src => rust/gitcore/src}/lib.rs    |   0
 {src => rust/gitcore/src}/varint.rs |   0
 rust/link-with-c/Cargo.toml         |   9 +++
 rust/link-with-c/src/lib.rs         |  77 ++++++++++++++++++
 shared.mak                          |   1 -
 src/cargo-meson.sh                  |  39 ---------
 src/meson.build                     |  41 ----------
 varint.h                            |   4 +-
 25 files changed, 528 insertions(+), 174 deletions(-)
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh
 create mode 100755 rust/build-crate.sh
 create mode 100644 rust/cbindgen-template.toml
 create mode 100644 rust/generate-headers/Cargo.toml
 create mode 100644 rust/generate-headers/src/main.rs
 create mode 100644 rust/gitcore/Cargo.toml
 create mode 100644 rust/gitcore/build.rs
 rename {src => rust/gitcore/src}/lib.rs (100%)
 rename {src => rust/gitcore/src}/varint.rs (100%)
 create mode 100644 rust/link-with-c/Cargo.toml
 create mode 100644 rust/link-with-c/src/lib.rs
 delete mode 100755 src/cargo-meson.sh
 delete mode 100644 src/meson.build


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2110%2Fezekielnewren%2Fcargo-workspace-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2110/ezekielnewren/cargo-workspace-v1
Pull-Request: https://github.com/git/git/pull/2110
-- 
gitgitgadget
