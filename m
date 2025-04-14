Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA021EF380
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665371; cv=none; b=dPb+A3/wjsZClhLMygbLqoj7xKrywPb7nKfk0fZM6jvMVMQs1p5TJUNR4JOfnBSXmxv14SFkXeMim6aWla2ZUwEaReIgBsAScHiQNjzrXtEYlFwbvH98l96mUmgj7r2+RQE1Q2d+xT62Ce42XTXtoi5G7ORgoErfrqrmIDFnSrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665371; c=relaxed/simple;
	bh=+OaZAGK6cC0yUsZGLT3fNK7Eu4cgJwDuFOvNLU6gPw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBMNfaBfaDn+lNBD1Vg+2trQE4SZ9SXAicn0tdda7R4tLpRG/5OrOYZ1y1phND2YpSBhnsE8+pZB2RAjqDAh0eY5ScA5GQq+BDvkDIOjfZdBlFLMxUvziDDPQyCgi4QsjtHIRGEm8qBItH0C+ItA3Q6Twr/SQVocbZynF7bwd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dApcpIzn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dApcpIzn"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso8900231a12.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744665368; x=1745270168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLqiSCgYiwVkB9D0K57VCKKFJTHD44AVnl05jYa28sI=;
        b=dApcpIzntebOtFECWEncAkBmSKqSKMzkJQexwn4XSxONXoUE2qu6JA6cFcXY7FYyjD
         N/1kkGCjyzRjAt++EfvxT6EgXJrB0peYtgjiUCSlshlNcxUEtNZJGx9NduZGi9D777tk
         xnBPltpcE7tiWePuVHfceSOkjmal54z3h0mgcH8tZI8Jvy17OAZt2++TuBDK3momPA3/
         DYo/WNgO9NYOPh9xkxVycm91hI9gajmbb8BTVVEx8McvGBdjSvNPIOLKiF9gqKSmszhO
         3nGmeDNQcG43bhDTjyRVDZT1AcfABxKd9Gflle/m4DuVV4RGeRiJYK04PAeglHU6TGqJ
         JaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665368; x=1745270168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLqiSCgYiwVkB9D0K57VCKKFJTHD44AVnl05jYa28sI=;
        b=MrvyBil+z4PoiBwXmZAH407MHmJpHMPwzRA2bJR6z2KZaEhtWFUXNi1TU+6QDQ0Ica
         sOwb16/qepWrkQWX9sKHr0xO2TeCLLdO++g34pqCDnkwoHDm1G7rKhgq2VdvVXTKJOaZ
         oDeitcereEmicCQUNBTu9rHGafXZPcegj2E9pN3VXrm9o+t1nbi+Ckik5SRMlCHYfgBr
         OURq/hrm3fARqbK0f9zi2SmexZoP6n62IZl/6uecg/GdSJmGr6IoQ7c+sMWJNz6QIO8k
         ffL51vILrNxP8CcTutzvzOvkroRIAXL2nIfqtRxSsNpX1mevjrRhXujHJV4KZ3ndI3QH
         FIVA==
X-Gm-Message-State: AOJu0Yx2BbRSJtkyK5q0EQy9H6m0InavjP1bV5VAgcyPntNfCLtvened
	GS9HWpldNrKA7qSa5paKqvBo3nZM3b0EAb24hMTiAk4cbjN9rZBt
X-Gm-Gg: ASbGncuX6v5ZKZghU0D4HpgTS+51YpYGJx7PZOCQ6JiR/RMqYr3VoTlj+6eRrOT8BJQ
	6P85TjUJSvbSjsxh3NgCNANjHz4I12HNGq40g08AVWJnpbIxrCD/s4YGqYkLdnFT6UzImuadfU1
	G2pEzql43PaGHpgecJUgIMjATmu3zFDQLx+STzU5oy3DOBAG5s+Mw5FVm7R2BlE0j7D71Cm+GG7
	lxEo7n/1wSWlj/x+8U0wqrc8UJPnRI8WZa94fRc4SDahKeE04XMpmGXxg8GzeB1y/8c60wIXJa6
	8vvX/4EdITvYuUQ0YuFNZFz8s7zre9hNwSA270znQTXflwM=
X-Google-Smtp-Source: AGHT+IHsiP0dZNMzRNOm58U+JJ5mI5iu0APVz7wD1glprfAxMOVCF/56MNEEvzT9M4CjHd72V3muKA==
X-Received: by 2002:a05:6402:35cc:b0:5f0:48df:25ae with SMTP id 4fb4d7f45d1cf-5f36f773f20mr11936820a12.2.1744665368358;
        Mon, 14 Apr 2025 14:16:08 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f62e:e088:2c58:70de])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54fb5sm5527518a12.13.2025.04.14.14.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:16:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 14 Apr 2025 23:16:02 +0200
Subject: [PATCH v3 4/4] makefile/meson: add 'check-headers' as alias for
 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-505-wire-up-sparse-via-meson-v3-4-edc6e7f26745@gmail.com>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=+OaZAGK6cC0yUsZGLT3fNK7Eu4cgJwDuFOvNLU6gPw4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf9exPkHXwV1e5KMdUYG9c+gyLDpU0fNt52O
 t+ZfdHXq4z0nIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn/XsTAAoJED7VnySO
 Rox/oaQL/2XEdKDob+atqko1PWzxHZTGyJLy+es+zShemLm3vTw1yNp9mTYZ7AB+25sGz+LmL5I
 U7pnx+PDZoHHbSBbCgMpScUJGe9/1gSgyeyV/9wgAzFhrEwb4UTIx6AnILnJqaG5Ez4CHZVLHjq
 ILXL9O8lN+iGS8omwJMRvLRAXAcQA/2FSyEKk3nQY9yhSxwT6xS2tC/2D5fWx+84LSpLlD64292
 zJbz9EWhVibeuPusJ3Xb3uJX6abTU3H5kLXT6Hg6NsHmG95B6M6t1PR4ecM66weIjxWlJV8heLA
 5p+Ky9ApF7hz/n12P0z+ShqavLbAziBLHgBsrvSyacerB9SixDnD/cel4IeBWdAjmIxcyUqHLU7
 1EiLQ7n4xyKcTxx4WI/ZeK5WuSpthGSznY3eGlMxdGNTex3Wr6UWy06N5o8bmM8xP3eIZuDgGeN
 MDUDf+j4kTnpj1SLCdyIkTc3nBpKhzvyppAngkVjzrs5ci22q3HMSRMWpLTc9PGu5jMc1gaUSS8
 UM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'hdr-check' target in Meson and makefile is used to check if headers
can be compiled individually. The naming however isn't readable as 'hdr'
is not a common shortforme for 'header', neither is it an abbreviation.

Let's introduce 'check-headers' as an alternative target for 'hdr-check'
and add a `TODO` to deprecate the latter after 2 releases. Since this
is an internal tool, we can use a shorter deprecation cycle.

Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
also use 'check-headers'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile                  | 4 +++-
 ci/run-static-analysis.sh | 2 +-
 meson.build               | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ac32d2d0bd..961ee508be 100644
--- a/Makefile
+++ b/Makefile
@@ -3326,8 +3326,10 @@ HCC = $(HCO:hco=hcc)
 $(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
-.PHONY: hdr-check $(HCO)
+# TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
+.PHONY: hdr-check check-headers $(HCO)
 hdr-check: $(HCO)
+check-headers: hdr-check
 
 .PHONY: style
 style:
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 0d51e5ce0e..60c175a094 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,7 +26,7 @@ then
 	exit 1
 fi
 
-make hdr-check ||
+make check-headers ||
 exit 1
 
 make check-pot
diff --git a/meson.build b/meson.build
index b1be2b3cbb..745cb30165 100644
--- a/meson.build
+++ b/meson.build
@@ -2062,7 +2062,9 @@ if git.found() and compiler.get_argument_syntax() == 'gcc'
     hco_targets += hco
   endforeach
 
+  # TODO: deprecate 'hdr-check' in lieu of 'check-headers' in Git 2.51+
   alias_target('hdr-check', hco_targets)
+  alias_target('check-headers', hco_targets)
 endif
 
 foreach key, value : {

-- 
2.48.1

