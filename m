Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0B1D89FD
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284651; cv=none; b=WjVpWrBRbQAYQuCWbz6huFD4sN9qFVofhCgvJKoaSor8Kxd44Bi0Fi+d6sN+RJRhPRO0irzA/VS89nKOd78yszVQpBOWt7ICXrsO1Dlbh07lISnjj/tN76ZDzxF6TQ8lAlmj70dfyVe5swNnjjpnrJcgTgvj6B3Bas1ALBVmdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284651; c=relaxed/simple;
	bh=FSLGsEEljLHC1P+F44RcGxbWSA63rxtzrHFxCEzmR4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPY8Gj+91YzAuVkiZQtVR0H9H64WUIlqmoHB8irpMuGq041arkAu/CEOtbuko9S28yhjI3dx0rGEmQAJgv+0JX5Sw4apTGRxHvnYiAi/3dGa8ehDkz4Yk4jDLcugzihC+Z8inRQI9M4uC+8jlD1uo02veyGi/sQK+gC0nxionT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxtohMAK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxtohMAK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25d2b2354so113615666b.1
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284647; x=1744889447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWBjpcq5440MKT/3sptL5pwqNdQuXpn6jP1Pj1AImww=;
        b=fxtohMAK7smZR2390VKLQruf5MqfqWi/ssqZmVrP/A1kEHlT9u5JW9WN/safOhRyuz
         C7gHTFFpPRh3D35aIVP25ORSX/0oK2jIK7YTamsg7qLKaH8pGhM1mRnXMDXrrmrcTgms
         BsJnx5LzgdUDCh4L1d8mwWC8jalqIgujCKqUZjXzdxm1RSo0gWplws2UDL2sZtpTM5VF
         blenL4NDV018S02oB7qRRXn/vPPi6V9AlGhYTLQLmR8YNsEA6c1W+Dezx/VUUIHqWKUg
         RRWzbZ7Imjdd85g/Vz/rSS1+MimdirjrywMrsmE69Cx7VIPkZuuG8v0pUtFjI5IN4RMI
         HEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284647; x=1744889447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWBjpcq5440MKT/3sptL5pwqNdQuXpn6jP1Pj1AImww=;
        b=igmQQmV4UuzEO3UnQQAXt18Lx7g8+j8QYkrewhirlxo33y5xFyEtuqVQmrMWXs0gJ+
         v4b8QE9pQDbfYAhHcI8efRKJROrvG9XZK9dZ79/EcQksWiw/LVO9c/RIUsfjwdhc5j8j
         YrpZUNCo7cwf4FK9iSlihW5anYFy6U2EAIe5EWJ4rOB66DHQ7MgQ7yQ2oU6X8xlZSoLK
         DXQABSSbjde/v3IHAvMYFU6jOshUf8c5MgPWK2YTjLzZ8mOt/kjjlxuvoO17RQf3vml8
         uRu1t/LPXZI2ojfSTrnmtH84lIfUWSFhY6kLtCFhOgr0nlg7lBmfHDTcwH3iopwCVp4t
         bPQQ==
X-Gm-Message-State: AOJu0YzauGY0RFb2DHvcd93X26N6c2hKzxkf7xUn023yfkbFzAV1BnsB
	32t0NNVYpa40q7eRjXWCz0L1DXS4xmv/HVlqNbOCeFhlrRWugQV1vYyGOQlu
X-Gm-Gg: ASbGnct3YkxTrutA/wy4cLxdZf8nxLE90B60R+mGxrFtbD8ytD9lgU9zhNU2L0PamKW
	vFQnnSuBbTSli9tC8B10j7qKXy3ly9+40IcWbAnup03Va90Qsx919DOsBUXeYmqzpOzByGOeOPb
	JdY66vc17VDs2l+t3UzDhAFTj3LpTr1Ct5BYEQv+isuu/nFS573ubX+PiPhxDb09YoXa/uEqpCW
	wEe7UYBnQTKvellELBsPkYFidoDIUAroXR4T5NIkeBBVFyogoVieUIobSY/V1d2T7BnSmXniNHy
	6LOzYu9JqHLnLy1bTnY6ZuYmwGWVDrodjByocjVU8PIFNg==
X-Google-Smtp-Source: AGHT+IFFnLFg5duLaurlhPwPw8iYHnapNPKhPJnaKh87fp1rcY0fSvhoOAaGUi9LTR/GsiEQGJteAg==
X-Received: by 2002:a17:906:9fc4:b0:ac7:7d3e:7335 with SMTP id a640c23a62f3a-acac007129fmr219988966b.7.1744284647244;
        Thu, 10 Apr 2025 04:30:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9936:e3af:b877:72d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3553sm260230666b.29.2025.04.10.04.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:30:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 10 Apr 2025 13:30:34 +0200
Subject: [PATCH v2 4/4] makefile/meson: add 'headers-check' as alias for
 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-505-wire-up-sparse-via-meson-v2-4-acb45cc8a2e5@gmail.com>
References: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
In-Reply-To: <20250410-505-wire-up-sparse-via-meson-v2-0-acb45cc8a2e5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 toon@iotcl.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=FSLGsEEljLHC1P+F44RcGxbWSA63rxtzrHFxCEzmR4s=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf3q+KJgIDVn3io+wYxuLAfMfO18zMeU32BL
 +FNo2HTIQHSr4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn96viAAoJED7VnySO
 Rox/AYAMAJIJykhLYOj36g4Qw6JVMq59kikyjTZRCRehYmvmIHvdo81Via2q0oOrrub/Yn2BHDj
 btBpIWeJnzURvftCO+wrVP4Xxhzao7nhXaitLQ6APgUbElJmaWwKFi5sjCtMgHpVB8noBCtUuXI
 wWbqyXe6Lp6+/6LA1qsJUTWbhl0U8zFjJv0rkCmVqQXXvgptLNeLGBQFNJAVMIyIJ3ct6TXCh2i
 y1m/TSmJxx5mYk1dNQ72uh3RhnHliegfCit/Ahn/bGPdG1pT7pGIWajEg+//QTTkqBwzIuOpo3A
 aeo6rrfXp859zwEZ3y95ms1DUu3AB83kipGTLIpMWLOthue1m7OE+gGkYkwb6SLrZ60M0dvLXUT
 WSHmmJr4jZHpsmDlsuu7S1wMXD5BjfilC9aJQHKt2Sttyw+tZv8HXKjSHqTUSxlRM/Up056aLKn
 9xb9NXe107ShPd+zFwAXqOuFv/aguhHxP1jIeeewDUp/OC3HpeendmtaRRBAYLoE5RNzZwrNxh5
 mI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'hdr-check' target in meson and makefile is used to check if headers
can be compiled individually. The naming however isn't readable as 'hdr'
is not a common shortforme for 'header', neither is it an abbreviation.

Let's introduce 'headers-check' as an alternative target for 'hdr-check'
and add a `TODO` to deprecate the latter after 2 releases. Since this
is an internal tool, we can use a shorter deprecation cycle.

Change existing usage of 'hdr-check' in 'ci/run-static-analysis.sh' to
also use 'headers-check'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile                  | 4 +++-
 ci/run-static-analysis.sh | 2 +-
 meson.build               | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ac32d2d0bd..0ac91e0af1 100644
--- a/Makefile
+++ b/Makefile
@@ -3326,8 +3326,10 @@ HCC = $(HCO:hco=hcc)
 $(HCO): %.hco: %.hcc $(GENERATED_H) FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
 
-.PHONY: hdr-check $(HCO)
+# TODO: deprecate 'hdr-check' in lieu of 'headers-check' in Git 2.51+
+.PHONY: hdr-check headers-check $(HCO)
 hdr-check: $(HCO)
+headers-check: hdr-check
 
 .PHONY: style
 style:
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 0d51e5ce0e..2e51411d6e 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -26,7 +26,7 @@ then
 	exit 1
 fi
 
-make hdr-check ||
+make headers-check ||
 exit 1
 
 make check-pot
diff --git a/meson.build b/meson.build
index 6fce1aa618..74597283b9 100644
--- a/meson.build
+++ b/meson.build
@@ -2099,7 +2099,9 @@ if headers.length() != 0 and compiler.get_argument_syntax() == 'gcc'
     hco_targets += hco
   endforeach
 
+  # TODO: deprecate 'hdr-check' in lieu of 'headers-check' in Git 2.51+
   alias_target('hdr-check', hco_targets)
+  alias_target('headers-check', hco_targets)
 endif
 
 foreach key, value : {

-- 
2.48.1

