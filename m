Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5B1D6DA9
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073071; cv=none; b=apPctZGX6rM+8v9jjbXIL7KCSwGM5dgjqdcB0fR3vVV/oaaPyqv+d7aj7y57vw3+9jn+XbAsAJN1M8LI6+AS2dGZ6wDrNkNR+6gOY587uY2WSnpy54ArsAPZPIhhWR6utqTU0pcpo4OVBylXYqo9LL+pV6tqzmw8vjZ4KSl4sW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073071; c=relaxed/simple;
	bh=F6Zn1Js/q+BfZ1yyPj0IrYJWDokcn59GiejBehH50rk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=gUri9ORvhjreUzefwz/mW0YNAIiorr+qIZZ5UoBOa1KMEEPQA4ft56WmBQQ1pKzewUe+M1dsWDs5cPerLwztuej2WQiVg20TPm1bnYs6LDpn7sqBAKCfphUYomkoH2gWj1Zmlt+Mk6MJ7Q3m55RTN3vJrZCAX3USz9U4vsdy+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sh3LEvGn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCXbrs06; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sh3LEvGn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCXbrs06"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5412B1D00514;
	Fri,  5 Sep 2025 07:51:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 05 Sep 2025 07:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757073066;
	 x=1757159466; bh=GQ+TaBYnlTgybrVtPUeJryEL3ENd+erT0A2TIFauhp0=; b=
	Sh3LEvGnv18/Ohk1r6GRVpF2twjYvl8XJnXSIPSMCEzsVB74E+OIGYayhdTCtV7S
	7pyvR5dMW46JM0wYW3T+yiJB07cFDbfW87Ei7+n02myyUnOxznPIqannuUh6Wf1i
	kU2T91X5q43zDDBKYyR67r1g4wMDMv5OtCzwEdZnXTcWr4ovHIXrxkuj6scjBUL4
	lVmbZl9cuofGDfrexSqo+buHVvHIb6+KdHAmGeFGUTUoKoKXvCP/0uozbGuc3eef
	HmoiROXvAiL9GltKvnTxQNrxNh30Vb3L3zgHT4jEGfqzS2fIOSleZJITD65N7ptc
	YWVv1M8xcMvjcuBHsRT7EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757073066; x=
	1757159466; bh=GQ+TaBYnlTgybrVtPUeJryEL3ENd+erT0A2TIFauhp0=; b=i
	CXbrs06kCceVx5967w5DcjuB6utbjkX/HIH/L2UbJNP81PeoCxu0uReny61y7fp0
	waOyF0TXEck3n7//8uEMfFtqaX1wRbSI0Y4RMYgfc+oKBH8nH/aeycH9Q0ApgszD
	bLEkafWvhasFKvgU7c5N5l+6vIItAheNmr6IrgHOQsa71CduT5aAggw+HhcTHGEa
	kjDIIVm8UH4C9Cp8rYpJACug3Q5jnUtd9LCNFUDhTJ528FWMEvO8A0tiqJdLKomO
	4m+RnRceewBLPcYjE0wA5WtxlQjlBGyuFxh06pXlMnQOkO0jxC8dXdKk14QcMpG3
	ZGblwnVANsr1hzpcC03Ww==
X-ME-Sender: <xms:qc66aNFMRL-sf5wPQX5KoEWJKEobeBfdZyGee7iGqeCUKIvni5Uq8A>
    <xme:qc66aCcMgB61bs8iFv8WFbqUeCDlvE7EvGlUGwWrI1Oog7ZhetH_ED8w1NgD29obD
    LmnssPYT-yYegg6iA>
X-ME-Received: <xmr:qc66aGlLmZS7xCfCXmRkhKkAO3e1d_LZb-GAJ4TMe-RYkPVwXRAhTXotIWQxT6CbIiiHDPqNclBI4WosKs2PSx4DbE2RUOw1KQ6O1vFcD3ge>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    etueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhr
    hiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:qc66aJoRmD5ZgCmbQa6YXMadRELAZWLptrdwud17-BYZz68mvjznNg>
    <xmx:qc66aLH-7ifRl623LCh2VYmUj1qBYnCKfZZGzpTN4vm-YUlC9PkIKw>
    <xmx:qc66aHR87JYNJbcOL-yNshf3rKCHXfroG9HMDcMu217HvBVBcBWPPA>
    <xmx:qc66aJOoG0HcHLHUHnDnkqo7ap_vCayQrmJs3JNOoZGdnFa1KzNOIQ>
    <xmx:qs66aDKT1Y9SpHCE-MEBlJedb26Ox5WemTYpIMFGKXCBKjYkB1mU6M5G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 07:51:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0908673f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 11:51:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v2 0/7] Introduce Rust and announce that it will become
 mandatorty
Date: Fri, 05 Sep 2025 13:50:56 +0200
Message-Id: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDOumgC/42NTQqDMBCFryKz7pT8aINdFQo9QLfFhTajDmKUx
 EqL5O4N0gN0+d77+N4GgTxTgHO2gaeVA08uBXXI4NnXriNkmzIooQpRihybHOchoH+FBRtP9cC
 uwx9q5MnY0mrSxkIyzJ5afu/2B9xvV6hS2XNYJv/ZH1e5T3/JV4kCdd1KqwoSDZWXhB55hCrG+
 AUfr89vyAAAAA==
X-Change-ID: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series introduces Rust into the core of Git. This patch
series is designed as a test balloon, similar to how we introduced test
balloons for C99 features in the past. The goal is threefold:

  - Give us some time to experiment with Rust and introduce proper build
    infrastructure.

  - Give distributors time to ease into the new toolchain requirements.
    Introducing Rust is impossible for some platforms and hard for
    others.

  - Announce that Git 3.0 will make Rust a mandatory part of our build
    infrastructure.

The test balloon itself is quite uninteresting: I've chosen to convert
the "varint.c" subsystem, mostly because it is trivial and does not have
any dependencies. But it does allow us to verify that C to Rust interop
works as expected, and to play around with tooling. All tests pass with
the "varint.rs" implementation.

For now, the series only contains support for Meson. If we agree to go
down this route I'll also introduce support for Rust into our Makefiles
at a later point in time.

Furthermore missing is additional tooling:

  - At least one CI job to verify that Rust builds and works as
    expected.

  - Tooling and CI jobs to ensure that we have consistent formatting via
    `cargo format`.

And probably lots more. As said, the entire goal is for us to have an
easy playground that we can experiment on and develop the infrastructure
incrementally without yet having to commit to anything.

I'm mostly splitting out the topic of introducing Rust from the larger
series that introduce it into xdiff so that we can focus more on the
actual process of introducing Rust into Git and less on the potential
features that we want to build on top of it.

Changes in v2:
  - Introduce support for building the Rust library via our Makefile.
  - Introduce a '-DWITH_RUST' define. This define is used to print
    whether or not Git is built with Rust via `git version
    --build-options`.
  - Adjust Meson to not depend on v1.9.0 and newer anymore.
  - Introduce a roadmap into our BreakingChanges document to explain how
    we'll iterate towards mandatory Rust support.
  - Rework the Fedora job to do a full compile-and-test run with Meson
    and breaking changes enabled.
  - Adapt our breaking-changes jobs to enable Rust support.
  - Link to v1: https://lore.kernel.org/r/20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      meson: add infrastructure to build internal Rust library
      Makefile: introduce infrastructure to build internal Rust library
      help: report on whether or not Rust is enabled
      rust: implement a test balloon via the "varint" subsystem
      BreakingChanges: announce Rust becoming mandatory
      ci: convert "pedantic" job into full build with breaking changes
      ci: enable Rust for breaking-changes jobs

 .github/workflows/main.yml         |  4 +-
 .gitignore                         |  2 +
 .gitlab-ci.yml                     |  4 +-
 Cargo.toml                         |  9 ++++
 Documentation/BreakingChanges.adoc | 36 +++++++++++++++
 Makefile                           | 47 ++++++++++++++++++-
 ci/install-dependencies.sh         |  4 +-
 ci/run-build-and-tests.sh          | 31 +++++--------
 help.c                             |  6 +++
 meson.build                        | 17 ++++++-
 meson_options.txt                  |  2 +
 src/lib.rs                         |  1 +
 src/meson.build                    | 16 +++++++
 src/varint.rs                      | 92 ++++++++++++++++++++++++++++++++++++++
 14 files changed, 240 insertions(+), 31 deletions(-)

Range-diff versus v1:

1:  4df400823c ! 1:  8f6e89bc7d meson: add infrastructure to build internal Rust library
    @@ meson.build: version_def_h = custom_target(
      
     +libgit_libraries = [ ]
     +
    -+if meson.version().version_compare('>=1.9.0')
    -+  rust_available = add_languages('rust', native: false, required: get_option('rust'))
    -+else
    -+  rust_available = false
    -+endif
    ++rust_available = add_languages('rust', native: false, required: get_option('rust'))
     +rust_option = get_option('rust').disable_auto_if(not rust_available)
    -+
    -+if rust_option.allowed() and meson.version().version_compare('>=1.9.0')
    ++if rust_option.allowed()
     +  subdir('src')
    ++  libgit_c_args += '-DWITH_RUST'
     +endif
     +
      libgit = declare_dependency(
    @@ src/lib.rs (new)
     
      ## src/meson.build (new) ##
     @@
    -+rustmod = import('rust')
    -+
     +libgit_rs = static_library('git_rs',
     +  sources: [
     +    'lib.rs',
     +  ],
    -+  rust_abi: 'c',
    ++  rust_crate_type: 'staticlib',
     +)
    -+
    -+rustmod.test('git-rs', libgit_rs)
    -+
     +libgit_libraries += libgit_rs
    ++
    ++# The 'rust' module was only introduced in Meson 1.0. Furthermore, the module
    ++# does not seem to work on macOS as expected right now. As such, we only
    ++# conditionally enable tests.
    ++if meson.version().version_compare('>=1.0.0') and host_machine.system() != 'darwin'
    ++  rustmod = import('rust')
    ++  rustmod.test('rust', libgit_rs)
    ++endif
-:  ---------- > 2:  cd1d642d04 Makefile: introduce infrastructure to build internal Rust library
-:  ---------- > 3:  e60a8353a4 help: report on whether or not Rust is enabled
2:  575f6de44d ! 4:  b27811aea4 rust: implement a test balloon via the "varint" subsystem
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Makefile ##
    +@@ Makefile: LIB_OBJS += urlmatch.o
    + LIB_OBJS += usage.o
    + LIB_OBJS += userdiff.o
    + LIB_OBJS += utf8.o
    ++ifndef WITH_RUST
    + LIB_OBJS += varint.o
    ++endif
    + LIB_OBJS += version.o
    + LIB_OBJS += versioncmp.o
    + LIB_OBJS += walker.o
    +
      ## meson.build ##
     @@ meson.build: libgit_sources = [
        'usage.c',
    @@ meson.build: libgit_sources = [
        'versioncmp.c',
        'walker.c',
     @@ meson.build: rust_option = get_option('rust').disable_auto_if(not rust_available)
    - 
    - if rust_option.allowed() and meson.version().version_compare('>=1.9.0')
    + if rust_option.allowed()
        subdir('src')
    +   libgit_c_args += '-DWITH_RUST'
     +else
     +  libgit_sources += [
     +    'varint.c',
    @@ src/lib.rs
     +pub mod varint;
     
      ## src/meson.build ##
    -@@ src/meson.build: rustmod = import('rust')
    +@@
      libgit_rs = static_library('git_rs',
        sources: [
          'lib.rs',
     +    'varint.rs',
        ],
    -   rust_abi: 'c',
    +   rust_crate_type: 'staticlib',
      )
     
      ## src/varint.rs (new) ##
3:  e54393392a < -:  ---------- BreakingChanges: announce Rust becoming mandatory
-:  ---------- > 5:  d5946e0114 BreakingChanges: announce Rust becoming mandatory
-:  ---------- > 6:  0d367976de ci: convert "pedantic" job into full build with breaking changes
-:  ---------- > 7:  82086a5328 ci: enable Rust for breaking-changes jobs

---
base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
change-id: 20250904-b4-pks-rust-breaking-change-7167d9d3e37d

