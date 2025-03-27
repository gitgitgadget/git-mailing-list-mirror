Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971A214239
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076400; cv=none; b=D+TKaZGBCD9yQ3Wu/vvNjgJJbyX+GsqL0/RCwiqIwZk65BKiS2cQnVQ3D+ijTqosDtAH/dxBBbnWAlprwqlARhovze4G23924FhmYe+c5Idd1y7BElCfDR69oNdQbdBDjcLU6PUJGaxbtiGi4VboJBPf2Fddl56n6nfhlw4iiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076400; c=relaxed/simple;
	bh=FS6N9nlTE0VdhE9V/sQbqCREVLzYq0swCqsouYl2La4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MqUiXy7Lg0iPWLmXYZ02iN80dgYSHwf8E5DkD/yeAodC+DRKXN4EtFUgMrZf47FzXBYe5QT5kEg/C1Nh7W8AB/Wk1TYQyU/vQRNtg0YkdRTv8Okd7td3iIh9ZN5+HTQKf03pEAJRez8F4b/8AHpD5yedsPSEcscrAwre/vghXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+E6HH7Q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+E6HH7Q"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso8258125e9.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076396; x=1743681196; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDRTgWO2nKxrujT+CMP8TmQAlGo7QEjCGZZFteTbFGk=;
        b=W+E6HH7Qm2ku2GOpn/B4BApaDbSJHjkayOhxir3cMdMRz6yZE7TL2MVnTi25IdndZr
         gIUqxtKBZbGLRZ8gVGKZXwVR0+cx/j0kR0OjPK0JPC60pIVPo1koXW9kKt8y4d0F5CIS
         o8sHH1GYaBsIAsafU2GUYTikrhseRemtSM1Wayu3ffYtftFCaDT9KU1C1pvHOQDmQz0X
         BKGA1fo4QAuEdnm1DjZRFDQ3d67RcJllOhv773CguVWPBiiZMeCJWzeie3+Zpy/VZrpH
         /9SXvW9J1wYqqQdsjnykoEgS7Sii2zPZevKrC0RwiKJZfb6QYtwOT39VxrWk9K5IlSIw
         ZldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076396; x=1743681196;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDRTgWO2nKxrujT+CMP8TmQAlGo7QEjCGZZFteTbFGk=;
        b=htsLK9nXLPf/WOsjIt8SfgygnnI5sx8PzaJ+mCeFqcJ9M5LBzYSbRVNG7tEGMlMWtY
         Az0RmgcqHe+H+lFVq1oulcw/a8ggneRI5daAu+55cxgRRDMa5KCVjkMF14uhVcjVHs2i
         2pwM+tM/FBh0NdA3XR8JQ/z85g3VCOVOaNKkApDmt+TGfEoH5/luaV26NFRuhjsKBoiu
         j54Brcl+x/viHLwCtdheX8yzGzUcdBAYXes2Q3epz+3Xn6M1PlPtmsaS3jxgRAzmNB/y
         GpbFyY02lRBvqkvTU8s2HMOvLNOYRsEDvq6qnMQBib5nHJlc6NEhEXd/neTXqiJ9UgtS
         FGEQ==
X-Gm-Message-State: AOJu0YzBXstsWWoEC1wp3A96/ZVYlPqoQh2uKhhcnH26P0JqwQY9XD34
	X7+/9mThr4+9zOaU3V+Nuh3tvLehwGbWS4xYD744jRTSLstzetQS0vw3aQ==
X-Gm-Gg: ASbGnct5U9pdZXv3ygabc5XEknMh677sYs4V/2dUFk2Xr9ZD206MHnVvFi5Zd42gbfE
	l2nqnqXBG0cXGEgqN5GpAvMfmUX6gYzRzfcQyANqNkH8DYtNKDfGCj4BJgvipaWgc7FFZ87PAMX
	BnhdcxP0ja5H9zg2mA7KFTcOqcG6eF3v9LsuFnZzqiGxIh1RIfro7U93cqF0byt3YB9mET4WepH
	fRi84H2kk7XdPNM4kvrXdk3ONdGpZCcioPMRm+2yLM+oEMuABhJstpcY4an0/Ua/6xYibIHeVoO
	EI/iPuZjdfejOtaIY86aoZQK65sBCRn8gzr3QtspBX7P/Q==
X-Google-Smtp-Source: AGHT+IHK0Da+RwLzUYLRe/zYMB30sYMo0ANoNBMxERUexMVoKCLyebHi6sFpETqZMOaaF7cNqRh1nw==
X-Received: by 2002:a05:600c:1d9e:b0:43c:f75a:eb54 with SMTP id 5b1f17b1804b1-43d8582c4ddmr28581175e9.13.1743076395818;
        Thu, 27 Mar 2025 04:53:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f59d0sm34813335e9.28.2025.03.27.04.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:15 -0700 (PDT)
Message-Id: <6b6cd556465f21e43536706c88c49f8790a2dc5f.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:53:02 +0000
Subject: [PATCH v3 09/10] clang: warn when the comma operator is used
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When compiling Git using `clang`, the `-Wcomma` option can be used to
warn about code using the comma operator (because it is typically
unintentional and wants to use the semicolon instead).

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.dev | 4 ++++
 meson.build    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 0fd8cc4d355..31423638169 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -40,6 +40,10 @@ DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -Wwrite-strings
 DEVELOPER_CFLAGS += -fno-common
 
+ifneq ($(filter clang9,$(COMPILER_FEATURES)),)
+DEVELOPER_CFLAGS += -Wcomma
+endif
+
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
 endif
diff --git a/meson.build b/meson.build
index efe2871c9db..fd8c05dec91 100644
--- a/meson.build
+++ b/meson.build
@@ -715,6 +715,7 @@ libgit_dependencies = [ ]
 # Makefile.
 if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argument_syntax() == 'gcc'
   foreach cflag : [
+    '-Wcomma',
     '-Wdeclaration-after-statement',
     '-Wformat-security',
     '-Wold-style-definition',
-- 
gitgitgadget

