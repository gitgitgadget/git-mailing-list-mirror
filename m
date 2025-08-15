Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607E1AB52D
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220987; cv=none; b=g/ZkKipbBSfQz6Cu4YaGsCgVgbG1XbC8NBUdCzcgQzMhPyooJerPlnMUEdcFAiTQ9WbYC7ZOmRsUDWd9tFuFQV6Au/GAtPrNczKF/cZ5HtH277RatiW9cdb2FWRCLeJSrSQCOo0JQNnrY48OACPwoPjTcbYGtXZbwZVT7FoUodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220987; c=relaxed/simple;
	bh=wYfOH9XoHvt4hkUcW7d4UDm0OpVGXBkpUVHpwr7uqsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RtGD4uH3LPsvA5exxBhFq7FaLjRUR3CBebjpy60wSXeDNwufXU7B8N2htvRNy61u2aoJFJfGEppHXaxnoAQGG70BV3ZEzroqHffFzrs5T5JEHxLjpVsWmgy3dQTlyEdBzqLVKc3hrACnpDA35Z8OJ7WaFhSEqrjB+WWetvNsicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqDs6Ydt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqDs6Ydt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso6663715e9.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220983; x=1755825783; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mPOxDZJbsjOWWJOD5GMOFvrPe2E7QpdzowDL1jMGMg=;
        b=fqDs6YdtgueW2PlvNQhEzr5Fv4g6/ETOJPkGYUy6ywp8eFDm+XqBSa8ltCtyZ+Qg3f
         2sV/NnczRO5V4cE1EliYr7nizr3Yjrl6EKKkshrwEeQ6uDZ9QW8DLeJhlwwvS3QbtKxB
         por04huCuah1Cr4qCxqiJENUgaFct5t96wurdi7pOKq6Xvpfhbu83ZcQjaWnMRv/K85X
         27r/DhwDaOLP4fzERX/cQwBX3HtO0QCZHQMa2AEpzWJnuqV1KmhXc8CDyFp27X6ECidy
         /UhwOGUeKcU37v2kk7G3UxhFs6+Z2Iq/guhiXDvQOdmBMlTs1yVgum/N9jrDvdZoHgjU
         L4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220983; x=1755825783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mPOxDZJbsjOWWJOD5GMOFvrPe2E7QpdzowDL1jMGMg=;
        b=XD1yjPCXk1Np/cjZsS56nwdGYZnnLhkNwTcy3sn2QPKJNsKaqFG/TJfjAxHcs9i1Cz
         dqYNV0z7Lj4I9jkq0QG2ExHepsgA2w2SZlswObRwzseMNmfBAvvz61av9P/t3F4+szMT
         g25JtdekQDDsyhte1wgvcV+JhGLhbbxeXb1SShxONmtN6u44EHSmUTUE1R7+bMer0I9c
         /Fa/G1SyFx10o2HmQ8TskgFHlTeULVe2ZDRCmyHrlwPcW795NmoWEfykOwn7PnS1Ef/M
         o7df75ZtsxEZq/TdYBTmtUKZlxYw4EqDei/JdSCMggVBcXtdQDF2GS43G2026wu/L3XG
         sOpw==
X-Gm-Message-State: AOJu0YxK5z3ZRx7m13ofWRteL+Lom1HUbOdE20FI1CM/wuShl5mUVdm8
	z2WFT/aYPqoLiU77LpC8e+HzK98YAHT4nCb+nFpbcQcHsTnRPhghIOYRmb5Mog==
X-Gm-Gg: ASbGncuWpyIYvi/P8cMrqxoydDBVJadGYdLPqbRzpJ8fjvWXWHl4B6nvqkq7e+ttebE
	jGBcVZ2nQbjowyNRQwasguUo6JmiJkw4lXfvi88yDBebS3+PD2UT5AfwFlquUMz+S1+Hf2IQZYj
	qPQrPuEYyUxWuvWymPWWJbC0Y01YfBLW2eE77DRealQoEDd9j9f1g8CKAhpItBVhRanvc/L4RIf
	F16+E9kNdEkDoSD1nsCrDk3Ek6quWklB54DE0mPMgNVSSKC4rcixtyxpOp4JPC+GGX4oObkrZmT
	834i+YzgXYqc0jmGizBjMa7ZNjewYgMD9xb8coe348zA2MML0NBucF43kI3FFuzbtWeWToO5Qlt
	q9V0GUiTSUvVaX9f0iaiAZKw=
X-Google-Smtp-Source: AGHT+IF62NXlqNxZpsOeLPYSK8Lky8bPrPqXdE0hWDH45911hnYL1SFF7Zgt+NPDgeZirDSNDTyHKQ==
X-Received: by 2002:a05:600c:138f:b0:456:8eb:a35c with SMTP id 5b1f17b1804b1-45a2186353dmr3076365e9.31.1755220983263;
        Thu, 14 Aug 2025 18:23:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a221445b2sm242635e9.23.2025.08.14.18.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:02 -0700 (PDT)
Message-Id: <96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:44 +0000
Subject: [PATCH v2 09/17] Do support Windows again after requiring Rust
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By default, Rust wants to build MS Visual C-compatible libraries on
Windows, because that is _the_ native C compiler.

Git is historically lacking in its MSVC support, and the official Git
for Windows versions are built using GCC instead. As a consequence, a
(subset of a) GCC toolchain is installed as part of the `windows-build`
job of every CI build.

Naturally, this requires adjustments in how Rust is called, most
importantly it requires installing support for a GCC-compatible build
target.

Let's make the necessary adjustment both in the CI-specific code that
installs Rust as well as in the Windows-specific configuration in
`config.mak.uname`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
[en: Moved lib userenv handling to a later patch]
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 ci/install-rust.sh | 3 +++
 config.mak.uname   | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/ci/install-rust.sh b/ci/install-rust.sh
index 141ceddb17cf..c22baa629ceb 100644
--- a/ci/install-rust.sh
+++ b/ci/install-rust.sh
@@ -28,6 +28,9 @@ if [ "$BITNESS" = "32" ]; then
   $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $?
 else
   $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
+  if [ "$CI_OS_NAME" = "windows" ]; then
+    $CARGO_HOME/bin/rustup target add x86_64-pc-windows-gnu || exit $?
+  fi
 fi
 
 . $CARGO_HOME/env
diff --git a/config.mak.uname b/config.mak.uname
index 3e26bb074a4b..a22703284b56 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -727,19 +727,26 @@ ifeq ($(uname_S),MINGW)
 		prefix = /mingw32
 		HOST_CPU = i686
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
+		CARGO_BUILD_TARGET = i686-pc-windows-gnu
         endif
         ifeq (MINGW64,$(MSYSTEM))
 		prefix = /mingw64
 		HOST_CPU = x86_64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		CARGO_BUILD_TARGET = x86_64-pc-windows-gnu
         else ifeq (CLANGARM64,$(MSYSTEM))
 		prefix = /clangarm64
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+		CARGO_BUILD_TARGET = aarch64-pc-windows-gnu
         else
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
+
+	export CARGO_BUILD_TARGET
+	RUST_TARGET_DIR = rust/target/$(CARGO_BUILD_TARGET)/$(RUST_BUILD_MODE)
+
 	CC = gcc
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 		-fstack-protector-strong
-- 
gitgitgadget

