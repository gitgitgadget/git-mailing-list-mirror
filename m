Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED82144B4
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921369; cv=none; b=sSARH+b/GH2RXtGnzS4uYULHPHq94KnwbF9rqDDnVZ/DH+YPEdTlTa+5CH6oFyJk272FeNEs+eJXn7lQdlbn8QoU+MepFXEYANmwCrWTiYB9pZus8rHVTgLWdQCoHws9Wal5bbaDd3A7haxjPJwVZkqe/dzrgs7L5f4ggO0GUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921369; c=relaxed/simple;
	bh=J68JhD+9yx3jSVn9RX0MCjVkge4hr/N1jTXSqOD8zRE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d+EmWKCYWOJRWoXVAZpWIpdf4vmHTHeZDZp5zvcLB/RzG8mAuC1O194wV1k1PSYMQEmCo0cf+51Zgn0oPU4TD59Og6+A9byObKY2GwozMKSM0GIUEYD7oVo8AhcZT0sgB3o2jqttEJsUQQfcuQfcRkATJmGkI146J7/a1w2Refk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgdg39bm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgdg39bm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c6412336d4so641123f8f.2
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921365; x=1756526165; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IgyLMnD58ZL5L8ZXT3MDXagsS8nYcQG5+RUbSmGD5o=;
        b=Dgdg39bmL/C3M5Zx+YvbTksFFTixk3twxBR7aDdHjfNhxxwISCs4Yt3bdihQONo4oK
         rfIDSIa+yUpGcwWTL1HQn9njn1ic/I+7aT/hCDXAVuVlsAIgVEcfcqtv1bvEMBCCQ5sx
         RRRjMiutL3Qe3Lo0JdlX045uHWL+V8sjFGxFAPNd51XFk/0nV9qsjNE7IIjFq11lu6gy
         6GvJoLdJZHFNTjT7nr9/8gnxA73I+68vvKMmaQFgd3c5tJq0DFbbJChLKw+Bphy+9pqC
         WE8Tk8BNR13AZsNfvR2ynxCI2de4nVJZ1FprHlOpWoeZFySjcQWcWn+E1/BV59bw5Xia
         hG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921365; x=1756526165;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IgyLMnD58ZL5L8ZXT3MDXagsS8nYcQG5+RUbSmGD5o=;
        b=IYOucNCXI7jXf5xmiKlVVt/D3vtT6B2gocMWpMuxfwGdv9aOTvwJb4YK7ob8NZXV5h
         BdGaSooCifpOf127amvgHrynOOZTQDWDsnvGmAl1++OxB7MEnAMUVzu6TKre0u4cSeNV
         crtjqIN3yphLb5RQx7gUBPAkfQV7pQ/VVMZH4P15qSvnMhw0L+k8WQyNZz1JrzFIbiNh
         vaJoGAdBMakmeOdrmBlWgPvAAnoTfl26y050FqtGZzh319ZbVfju6effLQjz2hn8ZnJW
         Q1EPbkx96qS+LWtWQmeYSMHqxkceorWmYSHnazbgvA39CxZ14G88noshJggH2iwc51Kg
         J5ig==
X-Gm-Message-State: AOJu0Yxk9kbHPZ9QFdilpPGpK9XZOq9SQgI/XD7WnYIP0QxvUfNdNyTV
	X7Qalsd5jVSv6q4bnnWOCGS49ICh4gAz9rcv9MdVZuP7zNOdxxPPthIJwVqNjg==
X-Gm-Gg: ASbGncuilPYazBx1jawnA+5Jj3KlrIAXtIZd7LLy6Eqhv8MLgUEK8C+jh3/m05xBOai
	wOw8IvxT7tQskcdpOej13qCbVqg4irvQb5a3xMsdBW1FM0z2cm7cuOGbXg8biQ+cup53zkyGvxs
	KrfcDY3ognnMOJzAe2HzXyMwKunNjCKG9hCRxpmiutpgNVxzATR2BEy/GfGQn4mfgacoalSYLVz
	I7NPSB88dKV4db1gYJx+cgaR0KkkqMUVzlcSNFVJtMIGIkP7mJa61TYtdL3cC5IkZkUlIAdsvOi
	8uebMzkbwMr5z1ovIQ3dX/BFGOe4VEaeiDut+B1Ecaq9fzWU3+WsbIrhossTzvcSjF7cxG37ZA5
	Tfuu3OnkascCmMfbSAXvNAemjCYk5nfs0q/Y/bQ==
X-Google-Smtp-Source: AGHT+IEeoY3k8mrRVqKBjP9j0ZcpXNbhf2lz7sJVHwSetUULPgGrN3HLfMIV7xlVvnNIF0fst6Y2fw==
X-Received: by 2002:a05:6000:40de:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3c5dcefee22mr4026567f8f.59.1755921365359;
        Fri, 22 Aug 2025 20:56:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7113fdacfsm1858306f8f.35.2025.08.22.20.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:04 -0700 (PDT)
Message-Id: <e65488ab993f429174b1f90bc5d810d64347ee6b.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:46 +0000
Subject: [PATCH v3 05/15] github workflows: upload Cargo.lock
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
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Make each ci workflow upload its Cargo.lock file as a build artifact so
that we can audit build dependencies.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0f7396621df8..0f8785a676c3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -156,6 +156,11 @@ jobs:
       with:
         name: windows-artifacts
         path: artifacts
+    - name: upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows
+        path: rust/Cargo.lock
   windows-test:
     name: win test
     runs-on: windows-latest
@@ -317,6 +322,11 @@ jobs:
       with:
         name: windows-meson-artifacts
         path: build
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows-meson
+        path: rust/Cargo.lock
   windows-meson-test:
     name: win+Meson test
     runs-on: windows-latest
@@ -399,6 +409,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   fuzz-smoke-test:
     name: fuzz smoke test
     needs: ci-config
@@ -510,6 +525,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   static-analysis:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-- 
gitgitgadget

