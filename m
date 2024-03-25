Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4555D8E4
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351678; cv=none; b=cFcR4RRRg+b+aYBqmGL9pqJaTrvfhyzDrkH4i1wLA86ZlTEnyif6BSrA1ge7mMs+kxdZKJz6HEDbtd89ZohlTQzyZad7fyZE/dolZyan5bJV6OmU2WFI6qh5zadIfnTn1LDseXWaVuX6i/PV84Se/mAP2xQt9Dc2zHmjgIzftQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351678; c=relaxed/simple;
	bh=qF/wG8Kh1L2vsFyTP2GfrAO0ESA4kppVqsf1AGjmFUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8ZC3vQTts8OFMPxhJ/OAp8iIDl52bGgnlT5No9KLqwCERHOqlYaOlKI5UQtyUzfxmQtxXWd6VeGFljCEhN6VHCPGnuJj83a/bQNRnSnPSvmN0rv9Sf/AYRGguqAmgPe+KmZXVhI2jr739Qlnd1R7eEfN5V5LInaArSuFNK8LF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z38XM966; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z38XM966"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4716cfbbcso2361945eaf.2
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711351675; x=1711956475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDNwE1YO4j66+XlREJav9dmB+lugCQkg9YH+FCoKoTU=;
        b=Z38XM9666Y1oBhbbuWeAtAT0cTdcPB6ZUvIJggIbCNgSlz7IBmNaCwbbCojHxcEAfj
         ZWmk7Cw9faC65N5rDVpIzGkuMXENg3Mov35sCZ3mubM0E0owbimRpRiLkeHrhQxHk7am
         rVoNHbYL7JuH2ru63bi68StBjzDw3gmMbMGb8BEEUZaJPup6fQANJT9omfZZpBYbyf82
         m2l0ne/kUtJd/VpU03zfaXavdN/jQYNS/0Mf5kVvP4jJ5eXK5SkATLDlD39xxLP/hm8k
         hYw+n5ufzISg8ffIpiOtxe9siJDN/pfzGKxddtxQPl+b+dHj1Ql7ZjLPB1RY4XzZ9ZuW
         /LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711351675; x=1711956475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDNwE1YO4j66+XlREJav9dmB+lugCQkg9YH+FCoKoTU=;
        b=VVXS4cZulJ/RUUEjFmbQs6IuWB9zbY2t+3xntW9Mom7C7jWI+b1QEmr7YJ3lVysmT8
         EuEiHMV8I3YbaH5RDhDcE+fUv7bpleRFGT2NlKVFp3Ri+MU41S7xyyn/4Cnc1a9siq9t
         qfNi1Se2M6Tb1od0yZ6vddXFW664hHbtgiJUPEx6npVjhD392d336K4hDM9Tzdut3TrR
         1kEeDKSRKddtIU7XLal7lF9REfn2WklRXgF8xkwPFgpmbKtTavE+6uBcepqdkxXIScvt
         SG84lamZh1Mwr9GCByLNOFZ6GMGB8vk/MZ0BAxAHuRbg/9DDuYCcA4auJrScR4DSuCu0
         FI0A==
X-Gm-Message-State: AOJu0YwdSxAtTHPXq1u1UcWoXwuOx08yGWXMo7I5Lr9ZezI6zgnV1SjN
	kMxidJP6/iyl6a/8ZpTdw67mQEzEhuLkZ3hGacxAaezsHFkeTr54/Y78n8Nv
X-Google-Smtp-Source: AGHT+IH4173/wbZQZ8Fr3V+gFMfbgLAjfrkewW/QMpVCirGF6EviheI2Zfu31n6Ie6z7pX650QIARQ==
X-Received: by 2002:a05:6820:20e:b0:5a5:24ad:b2ea with SMTP id bw14-20020a056820020e00b005a524adb2eamr6066167oob.1.1711351675053;
        Mon, 25 Mar 2024 00:27:55 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id bs27-20020a056820179b00b005a53376cf14sm918172oob.9.2024.03.25.00.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 00:27:54 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	peff@peff.net
Subject: [PATCH v2 1/2] pretty: update tests to use `test_config`
Date: Mon, 25 Mar 2024 02:25:12 -0500
Message-ID: <20240325072651.947505-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240324214316.917513-1-brianmlyles@gmail.com>
References: <20240324214316.917513-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests use raw `git config` calls, which is an older style that can
cause config to bleed between tests if not manually unset. `test_config`
ensures that config is unset at the end of each test automatically.

`test_config` is chosen over `git -c` since `test_config` still ends up
calling `git config` which seems slightly more realistic to how pretty
formats would be defined normally.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e3d655e6b8..20bba76c43 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -30,40 +30,38 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git config i18n.commitEncoding $test_encoding &&
+	test_config i18n.commitEncoding $test_encoding &&
 	commit_msg $test_encoding | git commit -F - &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar" &&
-	git config --unset i18n.commitEncoding
+	git commit -m "add bar"
 '
 
 test_expect_success 'alias builtin format' '
 	git log --pretty=oneline >expected &&
-	git config pretty.test-alias oneline &&
+	test_config pretty.test-alias oneline &&
 	git log --pretty=test-alias >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'alias masking builtin format' '
 	git log --pretty=oneline >expected &&
-	git config pretty.oneline "%H" &&
+	test_config pretty.oneline "%H" &&
 	git log --pretty=oneline >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'alias user-defined format' '
 	git log --pretty="format:%h" >expected &&
-	git config pretty.test-alias "format:%h" &&
+	test_config pretty.test-alias "format:%h" &&
 	git log --pretty=test-alias >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'alias user-defined tformat with %s (ISO8859-1 encoding)' '
-	git config i18n.logOutputEncoding $test_encoding &&
+	test_config i18n.logOutputEncoding $test_encoding &&
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
-	git config --unset i18n.logOutputEncoding &&
 	test_cmp expected-s actual-s
 '
 
@@ -75,34 +73,34 @@ test_expect_success 'alias user-defined tformat with %s (utf-8 encoding)' '
 
 test_expect_success 'alias user-defined tformat' '
 	git log --pretty="tformat:%h" >expected &&
-	git config pretty.test-alias "tformat:%h" &&
+	test_config pretty.test-alias "tformat:%h" &&
 	git log --pretty=test-alias >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'alias non-existent format' '
-	git config pretty.test-alias format-that-will-never-exist &&
+	test_config pretty.test-alias format-that-will-never-exist &&
 	test_must_fail git log --pretty=test-alias
 '
 
 test_expect_success 'alias of an alias' '
 	git log --pretty="tformat:%h" >expected &&
-	git config pretty.test-foo "tformat:%h" &&
-	git config pretty.test-bar test-foo &&
+	test_config pretty.test-foo "tformat:%h" &&
+	test_config pretty.test-bar test-foo &&
 	git log --pretty=test-bar >actual && test_cmp expected actual
 '
 
 test_expect_success 'alias masking an alias' '
 	git log --pretty=format:"Two %H" >expected &&
-	git config pretty.duplicate "format:One %H" &&
-	git config --add pretty.duplicate "format:Two %H" &&
+	test_config pretty.duplicate "format:One %H" &&
+	test_config pretty.duplicate "format:Two %H" --add &&
 	git log --pretty=duplicate >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'alias loop' '
-	git config pretty.test-foo test-bar &&
-	git config pretty.test-bar test-foo &&
+	test_config pretty.test-foo test-bar &&
+	test_config pretty.test-bar test-foo &&
 	test_must_fail git log --pretty=test-foo
 '
 
-- 
2.43.2

