Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC716A95B
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220981; cv=none; b=NG0oeF6KjihPjQRFPDXrJfk1BnUXqZTgi7xUA8Awd80rSO5C+Ew5jOf9s2Lx38mNeXwA+xzQvLJ/Z7/CoIhM46CB1Py+R4BZia3B7C2HTpxIWPA2cbM+8gskITF0sHxsq/dH8d3ewHQEV5HTvFcb0tDCt9VqTh1QuDio7iYKddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220981; c=relaxed/simple;
	bh=7LhW7IL0Rk6knwHKgm4P4zyYErUExSfKGKuvkVqLpLY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I1bACns2+lWLQLfKFbs6KIt0AOPc/9ehT8oDEkzDQKweJ3AYsmwEcKhPlBxKovmNpizgaq2XeU41pqVjbFerWIEAVaD8HLeJVNilaA/U1ZCsMZW3Gg70CNcjtaqIKor1uDNrq61YPIVrXxasr53QrQOcy20sVj4tWcrbaNVTao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnIi4ypu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnIi4ypu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9170db547so1119246f8f.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220976; x=1755825776; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly/UOtjUe0NN6NxVCM9LEbf9eOK2U9enz0slyWvMWyc=;
        b=LnIi4ypu6B/qQidfcFc5sWRRmnagCTjm5IRORlObNth0JNRe4kP7G1aovVKpGukALA
         BtXuZ8/oLUe6I3AlYiIJkfp3VY4irAiVg9dhqaUsjuHfZwTcMMLrZdvMMQwbEVBxZ/hL
         PSVe5X5U4Jm1vsbViD6kujrfnpWLmmeR4FlbJCZpy+QweuPLxExtB+w7e+gJyDi41LnG
         gUFcxraBVT5VRXGFPYuq8ZLatxBQx7dk6JNTkcP8qqmrqGjxx3bGJ4Um+BzBsBzuUQLe
         aB06URYQAk1eoi43nssZeYXY1aMCkozmGgoB7V0MWdku2PJN+ey2hIzgqB+57BcHTdv6
         XM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220976; x=1755825776;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ly/UOtjUe0NN6NxVCM9LEbf9eOK2U9enz0slyWvMWyc=;
        b=XaXSzCwx465Gg/VuUe+QhOSrGY8YL4dsJVXwG+9s5wAzCkMhfhltF6AwRl1le/ADW+
         erYsHpwLEKBhmWEppLE/wIaBGus0CMgcvQA6eMmduVVw250r+HR23NLzhRHs5kWT9iZv
         4U1+rldbRaGXU9O8x6gN59cIoPFQh4XNIlxXAI/dtV+6i4wlW/jbrTJSysaE3FD+PUT/
         9+++5ofVow/jYKpDo8gpMY77h1rSgz/HqKjbjOw1xQ7clgBa2NaEKNcbzzCbJLd4m0hc
         evInYq7TdboBqRdPfmi27hZ0+LHQbk/CqWf3q14Mh7tCjui9ZmrTmUKn/uX/YB204jo7
         jOjA==
X-Gm-Message-State: AOJu0YycNPPW/6ohMPVTWY4ZYK6J2Dja4tMX/dVVLPLB+qXcVnnKZsWw
	hqM8dVM5BwF6JZEpg2e1iSgqSoHnXHN/LTHVIr3XPcgD/K9LQGB1OplTc0J3SQ==
X-Gm-Gg: ASbGncuGQZnF3ZnMosvg5EtgQjJsavdS79J1N3G+3qHgdnLJ9S+5a+5IwuSc/hcx8d1
	XWCrKUswRjb4Bd2KSrLaT9MmeD6LWDyfT+jOmUAMuZR1A5pNabUU7ndp4tCPADGRyX3xFGzn4S1
	xzUwj3hhNp1h0QXO4U0u+kEV2Sdv6uhLRj1RxxIFsyoNVe/jgiK4P9EpXpMDAd7zQetNH7tsd+9
	isVv8P0M81XIRK+Ydui68pNqltr6rIYA/I/zWFt8IGeLBxgyIKWwHZm3lagh+EMVWzh/fiVPlF2
	RCgw9PETrGmrVZujZBjIJdvnLC8dEY/I8FiUsO6oeUI623BxxkVeoXbr69SvTfz5jCSX17w7rDr
	Qz1RFVKB/CSQpqY+deDZRAM+A3uTZZgY9lw==
X-Google-Smtp-Source: AGHT+IF+qQ1vlOFeZSQbUevZ2D1+06/WbJgeYiPLieiCa3Ur6r9vEUGMXCYKLsWK5p0ViAXuF5Blzw==
X-Received: by 2002:a05:6000:24ca:b0:3b8:de54:6e64 with SMTP id ffacd0b85a97d-3bb4d23f605mr272258f8f.26.1755220975628;
        Thu, 14 Aug 2025 18:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64d33340sm124914f8f.21.2025.08.14.18.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:22:55 -0700 (PDT)
Message-Id: <75dfb40ead370e80dda423998f8220ac19c2ff46.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "brian m. carlson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:36 +0000
Subject: [PATCH v2 01/17] doc: add a policy for using Rust
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
    "brian m. carlson" <sandals@crustytoothpaste.net>

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Git has historically been written primarily in C, with some shell and
Perl.  However, C is not memory safe, which makes it more likely that
security vulnerabilities or other bugs will be introduced, and it is
also more verbose and less ergonomic than other, more modern languages.

One of the most common modern compiled languages which is easily
interoperable with C is Rust.  It is popular (the most admired language
on the 2024 Stack Overflow Developer Survey), efficient, portable, and
robust.

Introduce a document laying out the incremental introduction of Rust to
Git and provide a detailed rationale for doing so, including the points
above.  Propose a design for this approach that addresses the needs of
downstreams and distributors, as well as contributors.

Since we don't want to carry both a C and Rust version of code and want
to be able to add new features only in Rust, mention that Rust is a
required part of our platform support policy.

It should be noted that a recent discussion at the Berlin Git Merge
Contributor Summit found widespread support for the addition of Rust to
Git.  While of course not all contributors were represented, the
proposal appeared to have the support of a majority of active
contributors.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/platform-support.adoc |   2 +
 Documentation/technical/rust-support.adoc     | 119 ++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 Documentation/technical/rust-support.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b109d25e9c80..066b761c01b9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -127,6 +127,7 @@ TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/platform-support
 TECH_DOCS += technical/racy-git
+TECH_DOCS += technical/rust-support
 TECH_DOCS += technical/reftable
 TECH_DOCS += technical/scalar
 TECH_DOCS += technical/send-pack-pipeline
diff --git a/Documentation/technical/platform-support.adoc b/Documentation/technical/platform-support.adoc
index 0a2fb28d6277..42b04b186105 100644
--- a/Documentation/technical/platform-support.adoc
+++ b/Documentation/technical/platform-support.adoc
@@ -33,6 +33,8 @@ meet the following minimum requirements:
 
 * Has active security support (taking security releases of dependencies, etc)
 
+* Supports Rust and the toolchain version specified in link:rust-support.txt[].
+
 These requirements are a starting point, and not sufficient on their own for the
 Git community to be enthusiastic about supporting your platform. Maintainers of
 platforms which do meet these requirements can follow the steps below to make it
diff --git a/Documentation/technical/rust-support.adoc b/Documentation/technical/rust-support.adoc
new file mode 100644
index 000000000000..a63327ebc575
--- /dev/null
+++ b/Documentation/technical/rust-support.adoc
@@ -0,0 +1,119 @@
+Usage of Rust in Git
+====================
+
+Objective
+---------
+Introduce Rust into Git incrementally to improve security and maintainability.
+
+Background
+----------
+Git has historically been written primarily in C, with some portions in shell,
+Perl, or other languages.  At the time it was originally written, this was
+important for portability and was a logical choice for software development.
+
+:0: link:https://security.googleblog.com/2024/09/eliminating-memory-safety-vulnerabilities-Android.html
+:1: link:https://www.cisa.gov/resources-tools/resources/product-security-bad-practices
+
+However, as time has progressed, we've seen an increased concern with memory
+safety vulnerabilities and the development of newer languages, such as Rust,
+that substantially limit or eliminate this class of vulnerabilities.
+Development in a variety of projects has found that memory safety
+vulnerabilities constitute about 70% of vulnerabilities of software in
+languages that are not memory safe.  For instance, {0}[one survey of Android]
+found that memory safety vulnerabilities decreased from 76% to 24% over six
+years due to an increase in memory safe code.  Similarly, the U.S. government
+is {1}[proposing to classify development in memory unsafe languages as a
+Product Security Bad Practice"].
+
+These risks are even more substantial when we consider the fact that Git is a
+network-facing service.  Many organizations run Git servers internally or use a
+cloud-based forge, and the risk of accidental exposure or compromise of user
+data is substantial.  It's important to ensure that Git, whether it's used
+locally or remotely, is robustly secure.
+
+In addition, C is a difficult language to write well and concisely.  While it
+is of course possible to do anything with C, it lacks built-in support for
+niceties found in modern languages, such as hash tables, generics, typed
+errors, and automatic destruction, and most modern language offer shorter, more
+ergonomic syntax for expressing code.  This is valuable functionality that can
+allow Git to be developed more rapidly, more easily, by more developers of a
+variety of levels, and with more confidence in the correctness of the code.
+
+For these reasons, adding Rust to Git is a sensible and prudent move that will
+allow us to improve the quality of the code and potentially attract new developers.
+
+Goals
+-----
+1. Git continues to build, run, and pass tests on a wide variety of operating
+   systems and architectures.
+2. Transition from C to Rust is incremental; that is, code can be ported as it
+   is convenient and Git does not need to transition all at once.
+3. Git continues to support older operating systems in conformance with the
+   platform support policy.
+
+Non-Goals
+---------
+1. Support for every possible operating system and architecture.  Git already
+   has a platform support policy which defines what is supported and we already
+   exclude some operating systems for various reasons (e.g., lacking enough POSIX
+   tools to pass the test suite).
+2. Implementing C-only versions of Rust code or compiling a C-only Git.  This
+   would be difficult to maintain and would not offer the ergonomic benefits we
+   desire.
+
+Design
+------
+Git will adopt Rust incrementally.  This transition will start with the
+creation of a static library that can be linked into the existing Git binaries.
+At some point, we may wish to expose a dynamic library and compile the Git
+binaries themselves using Rust.  Using an incremental approach allows us to
+determine as we go along how to structure our code in the best way for the
+project and avoids the need to make hard, potentially disruptive, transitions
+caused by porting a binary wholesale from one language to another that might
+introduce bugs.
+
+We will use the `bindgen` and `cbindgen` crates for handling C-compatible
+bindings and the `rustix` crate for POSIX-compatible interfaces.  The `libc`
+crate, which is used by `rustix`, does not expose safe interfaces and does not
+handle differences between platforms, such as differing 64-bit `stat` call
+names, and so is less desirable as a target than `rustix`.  We may still choose
+to use it in some cases if `rustix` does not offer suitable interfaces.
+
+Rust upstream releases every six weeks and only supports the latest stable
+release.  While it is nice that upstream is active, we would like our software
+releases to have a lifespan exceeding six weeks.  To allow compiling our code
+on a variety of systems, we will support the version of Rust in Debian stable,
+plus, for a year after a new Debian stable is released, the version in Debian
+oldstable.
+
+This provides an approximately three-year lifespan of support for a Rust
+release and allows us to support a variety of operating systems and
+architectures, including those for which Rust upstream does not build binaries.
+Debian stable is the benchmark distribution used by many Rust projects when
+determining supported Rust versions, and it is an extremely portable and
+popular free software operating system that is available to the public at no
+charge, which makes it a sensible choice for us as well.
+
+We may change this policy if the Rust project issues long-term support releases
+or the Rust community and distributors agree on releases to target as if they
+were long-term support releases.
+
+This version support policy necessitates that we be very careful about the
+dependencies we include, since many Rust projects support only the latest
+stable version.  However, we typically have been careful about dependencies in
+the first place, so this should not be a major departure from existing policy,
+although it may be a change for some existing Rust developers.
+
+We will avoid including the `Cargo.lock` file in the repository and instead
+specify minimum dependency versions in the `Cargo.toml` file.  We want to allow
+people to use newer versions of dependencies if necessary to support newer
+platforms without needing to force upgrades of dependencies on all users, and
+it provides additional flexibility for distribution maintainers.
+
+We do not plan to support beta or nightly versions of the Rust compiler.  These
+versions may change rapidly and especially parts of the toolchain such as
+Clippy, the lint tool, can have false positives or add additional warnings with
+too great of a frequency to be supportable by the project.  However, we do plan
+to support alternate compilers, such as the rust_codegen_gcc backend and gccrs
+when they are stable and support our desired release versions.  This will
+provide greater support for more operating systems and architectures.
-- 
gitgitgadget

