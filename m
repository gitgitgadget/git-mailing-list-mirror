Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339A1D0495
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459409; cv=none; b=hRfyS3h0cByfoWWaqJr1kVq0kxtKJl2Ps+0wstzmAGA5NP4gxqSzTjWx9lbEgbNA/DYxmapJvQ9VAAzqx2rgUgeGXiKE/TQYsIq4Xf6p0cIjlowgOHo6oHkVbYtUgIDLdflzAyNbs+vZYnM6aWhHruYlqcEJn481ymqM1D5sjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459409; c=relaxed/simple;
	bh=j8kEzTppdiiXpK9lCHHLkN2dmjtGN42JOhma340ace4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDp+tKQmvoEvgSogbNAnnCoK6/j3nmA9qmUYSQs63etKI/dnhHudt1qrbupmdGySnwxHCmVfzzDz1vexJBD61E4mHIKIqIxMRf02uPHzeM/i/kDCp+KlxTZ6FwrSDPcvSVPVwGA0SFO4JaXTLCkkEsi17sgQtwJM94TmLe+YMuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZhtVCGdw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okJjPbh4; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZhtVCGdw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okJjPbh4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BC5D13801B8;
	Wed,  4 Sep 2024 10:16:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 10:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459407; x=1725545807; bh=a1k2E3+K3N
	BE0m6MXX68Mds2K8TMsBASIVrMl5cN9r8=; b=ZhtVCGdwqUYkKySwon9sFAb9X1
	4Yp58h3ARDBlvO4VD+YesoNcoJAVPU+NZg1bTB2BiiIluwVLlM7J4btX3UG7rr0A
	1IVqtUnodhGCHxBzCcQDPHC8V9WV2H8v57vevoS0TuumZ5z2iWZjqfJA4xX1Lmkm
	kj0x/6fF26Sbx2hPh2kXzDAH7jjMhx9+glXPyELPtkKEdohoAnmZhXofr121CCDl
	t0VUKgUNmKGoXh1zud8MzVm6NlQCSA0cEVaKK+rcAb2mudWJkbWSJ8IjKk1Sd0WG
	dA4XvUPusvzKUfC2junB9tJ93t6jRkhxUReAuhBycLV/MLRiqvgZV7tjPKfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459407; x=1725545807; bh=a1k2E3+K3NBE0m6MXX68Mds2K8TM
	sBASIVrMl5cN9r8=; b=okJjPbh4Hgw0Zo75AipL0DhSevCR2n1k0OdDRz/JeYwv
	B5svm5C8+0JhskWjpp4CaTQBZVuUOi3w4xvkPqPImOkCbUKnvO/dOLVJLA/ZcIJe
	jDs02W8HnyLmUVlyEsTt9bPp9VVpXqYTeCj/NoJI5BM1ZMpwK7vxVQ7DcZJe8Ycj
	aqXlCTPmk/oxWc3YFZKCmVgSWjv8a28cM7QlITJXg/0mIA/R9D60X8ohR6uc0TUC
	D4xZrl2aYaNf3jUo6wCcWxanVnu/Yhob0XyN+68O5r8qkuL+vIMv3DOLA5kbhovW
	+vP5Mjqj3io6j7l8qoiG37Lmm7PajKdHGBrz45V3cg==
X-ME-Sender: <xms:zmvYZn3L8Pl706W-1u0fxu2hI95K-zcosg8ue1cmwN87NnU4IZWRJQ>
    <xme:zmvYZmEOiweb_92Wyq0yX8ufrxuYFn7R9xDbmTk5acTYGc-VxcKsvuXA3zZgDhn2W
    3CJ7gNWjc-rguCNbQ>
X-ME-Received: <xmr:zmvYZn6d7HuwdkfKJkvPtVVsyafUM5Cwun3dXNM68a7cXtF172Xm7GK1FrPSLmszH12GaEiVtNYo3WLCpBBRlbBA1cLGYuWDPGUPnBxGYUd8BZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtoh
    hmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpd
    hrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthho
    pehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:z2vYZs2uSRIFHfjK-XgWw5rqAum_GImd-gkXd28CZkhKVdvxY0rqVw>
    <xmx:z2vYZqFfqyOC4lVNM5oRcTE6Hvyae5Zfk78qfIdSh-jylP8Fjg7hEg>
    <xmx:z2vYZt_5NG_9epPtieZEcD4EL7zCDqbEvXfLn_BFAHwDUbCJm3Qi6A>
    <xmx:z2vYZnlPPiA7OpF9q2jOPhwRw-4dXoUAYrRbRrRjo9iWL4mMxMCYDg>
    <xmx:z2vYZtAcDGqoEJaBWXTQ8JgH2mxnW0_gCfUAF927a4BrpM_zFHjW-3WS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:16:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c638fd28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:16:35 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:16:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 00/14] Introduce clar testing framework
Message-ID: <cover.1725459142.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722415748.git.ps@pks.im>

Hi,

this is the 8th version of my patch series that introduces the clar
testing framework.

Changes compared to v7:

  - Properly wire up the "--immediate" flag.

  - Give a hint for the syntax to run only specific suites or tests for
    the "--run" and "--exclude" options.

Thanks!

Patrick

Johannes Schindelin (4):
  clar: avoid compile error with mingw-w64
  clar(win32): avoid compile error due to unused `fs_copy()`
  clar: stop including `shellapi.h` unnecessarily
  clar: add CMake support

Patrick Steinhardt (10):
  t: do not pass GIT_TEST_OPTS to unit tests with prove
  t: import the clar unit testing framework
  t/clar: fix compatibility with NonStop
  Makefile: fix sparse dependency on GENERATED_H
  Makefile: make hdr-check depend on generated headers
  Makefile: do not use sparse on third-party sources
  Makefile: wire up the clar unit testing framework
  t/unit-tests: implement test driver
  t/unit-tests: convert strvec tests to use clar
  t/unit-tests: convert ctype tests to use clar

 .gitignore                                 |   1 +
 Documentation/technical/unit-tests.txt     |   2 +
 Makefile                                   |  53 +-
 contrib/buildsystems/CMakeLists.txt        |  53 ++
 t/Makefile                                 |   4 +-
 t/run-test.sh                              |   2 +-
 t/unit-tests/.gitignore                    |   2 +
 t/unit-tests/clar-generate.awk             |  50 ++
 t/unit-tests/clar/.github/workflows/ci.yml |  23 +
 t/unit-tests/clar/COPYING                  |  15 +
 t/unit-tests/clar/README.md                | 329 ++++++++
 t/unit-tests/clar/clar.c                   | 842 +++++++++++++++++++++
 t/unit-tests/clar/clar.h                   | 173 +++++
 t/unit-tests/clar/clar/fixtures.h          |  50 ++
 t/unit-tests/clar/clar/fs.h                | 524 +++++++++++++
 t/unit-tests/clar/clar/print.h             | 211 ++++++
 t/unit-tests/clar/clar/sandbox.h           | 159 ++++
 t/unit-tests/clar/clar/summary.h           | 143 ++++
 t/unit-tests/clar/generate.py              | 266 +++++++
 t/unit-tests/clar/test/.gitignore          |   4 +
 t/unit-tests/clar/test/Makefile            |  39 +
 t/unit-tests/clar/test/clar_test.h         |  16 +
 t/unit-tests/clar/test/main.c              |  40 +
 t/unit-tests/clar/test/main.c.sample       |  27 +
 t/unit-tests/clar/test/resources/test/file |   1 +
 t/unit-tests/clar/test/sample.c            |  84 ++
 t/unit-tests/{t-ctype.c => ctype.c}        |  71 +-
 t/unit-tests/strvec.c                      | 241 ++++++
 t/unit-tests/t-strvec.c                    | 211 ------
 t/unit-tests/unit-test.c                   |  47 ++
 t/unit-tests/unit-test.h                   |  10 +
 31 files changed, 3459 insertions(+), 234 deletions(-)
 create mode 100644 t/unit-tests/clar-generate.awk
 create mode 100644 t/unit-tests/clar/.github/workflows/ci.yml
 create mode 100644 t/unit-tests/clar/COPYING
 create mode 100644 t/unit-tests/clar/README.md
 create mode 100644 t/unit-tests/clar/clar.c
 create mode 100644 t/unit-tests/clar/clar.h
 create mode 100644 t/unit-tests/clar/clar/fixtures.h
 create mode 100644 t/unit-tests/clar/clar/fs.h
 create mode 100644 t/unit-tests/clar/clar/print.h
 create mode 100644 t/unit-tests/clar/clar/sandbox.h
 create mode 100644 t/unit-tests/clar/clar/summary.h
 create mode 100755 t/unit-tests/clar/generate.py
 create mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/Makefile
 create mode 100644 t/unit-tests/clar/test/clar_test.h
 create mode 100644 t/unit-tests/clar/test/main.c
 create mode 100644 t/unit-tests/clar/test/main.c.sample
 create mode 100644 t/unit-tests/clar/test/resources/test/file
 create mode 100644 t/unit-tests/clar/test/sample.c
 rename t/unit-tests/{t-ctype.c => ctype.c} (68%)
 create mode 100644 t/unit-tests/strvec.c
 delete mode 100644 t/unit-tests/t-strvec.c
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

Range-diff against v7:
 1:  b67f10ec0b0 =  1:  b67f10ec0b0 t: do not pass GIT_TEST_OPTS to unit tests with prove
 2:  55a9b46e65f =  2:  55a9b46e65f t: import the clar unit testing framework
 3:  f24401f0a87 =  3:  f24401f0a87 t/clar: fix compatibility with NonStop
 4:  658a601c541 =  4:  658a601c541 clar: avoid compile error with mingw-w64
 5:  0b8a6ac5fed =  5:  0b8a6ac5fed clar(win32): avoid compile error due to unused `fs_copy()`
 6:  c50e7a0ea68 =  6:  c50e7a0ea68 clar: stop including `shellapi.h` unnecessarily
 7:  b8f3f16dd27 =  7:  b8f3f16dd27 Makefile: fix sparse dependency on GENERATED_H
 8:  3d3fe443b9a =  8:  3d3fe443b9a Makefile: make hdr-check depend on generated headers
 9:  7d0f494850a =  9:  7d0f494850a Makefile: do not use sparse on third-party sources
10:  9c74c5ae019 = 10:  9c74c5ae019 Makefile: wire up the clar unit testing framework
11:  8bd5b3e2b29 ! 11:  81d932bfa33 t/unit-tests: implement test driver
    @@ t/unit-tests/unit-test.c
     +	struct string_list exclude_args = STRING_LIST_INIT_NODUP;
     +	int immediate = 0;
     +	struct option options[] = {
    -+		OPT_BOOL('i', "--immediate", &immediate,
    ++		OPT_BOOL('i', "immediate", &immediate,
     +			 N_("immediately exit upon the first failed test")),
    -+		OPT_STRING_LIST('r', "run", &run_args, N_("name"),
    -+				N_("run only test suite or individual test <name>")),
    -+		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("name"),
    -+				N_("exclude test suite <name>")),
    ++		OPT_STRING_LIST('r', "run", &run_args, N_("suite[::test]"),
    ++				N_("run only test suite or individual test <suite[::test]>")),
    ++		OPT_STRING_LIST('x', "exclude", &exclude_args, N_("suite"),
    ++				N_("exclude test suite <suite>")),
     +		OPT_END(),
     +	};
     +	struct strvec args = STRVEC_INIT;
    @@ t/unit-tests/unit-test.c
     +
     +	strvec_push(&args, argv[0]);
     +	strvec_push(&args, "-t");
    ++	if (immediate)
    ++		strvec_push(&args, "-Q");
     +	for (size_t i = 0; i < run_args.nr; i++)
     +		strvec_pushf(&args, "-s%s", run_args.items[i].string);
     +	for (size_t i = 0; i < exclude_args.nr; i++)
12:  3c3b9eacdfb = 12:  604303e31aa t/unit-tests: convert strvec tests to use clar
13:  c8360db2f86 = 13:  ba05b9f1eef t/unit-tests: convert ctype tests to use clar
14:  d51c146cd9d = 14:  8441d29daa8 clar: add CMake support
-- 
2.46.0.519.g2e7b89e038.dirty

