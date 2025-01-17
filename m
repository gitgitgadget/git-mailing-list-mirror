Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3381F8ADA
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116980; cv=none; b=IdW3AsZ0p1hZuL8F85LSScaq+CBJ2KOsoGKBEFMEwNDyojdiABREvM9Ehzglo/xHF3eivwXrPa4b2hKGgw087hLt0JBhoOGhH9uJIHkOu+L61hOSVtUPnNBZAUzuOVs5FLllZCl3II+WPTsrXUUsW6CvEz0C4fbh1a20cY5qiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116980; c=relaxed/simple;
	bh=pWihh2kZK/QjDPcLPymouPcKhmxnxxsRRQdS/RaGvt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgXV+fzFTqyt1z169MPWnrQrPA6RWpddHPVzC8l1xTPqtoz39dBKFiZZW9CirqdGEnKlkCI2d+KBMSwzIQz5jxbC6Z2NoGl3IFqC0hTnJLt4+nOtxxpFbaeVrveGQeWglhGPs+J63XtRKRVWEH2JMYqg5dOJap4nSiJeXtROkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl4ibxJo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl4ibxJo"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf60d85238so349686366b.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 04:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737116977; x=1737721777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnJCATVCC9DaYJ4RBeUzqUHG1+Hg0wq1+OBGyCVtuyo=;
        b=Hl4ibxJo7D+g4yQoKCFGvde2WxWUt0xAOTAePpzx03zjPYr5XTS0vtdUKbAHHqcit3
         mqRmrZIRwd4hybAmQO6uMH1Kp0baNUQCTX+iAMm3Bm8pHdewmiNTQuzgCESgPgPdxIfZ
         iSyeVCXSwKoFWd+29yTx+emWCLtFy9fTAwD2on1/RhY+FEG/hgPM/xOp4ahrpZRrruiR
         9ZyGB2o9+Zu+fz8UFLAAukTZILuz1neQNK5ZJ0mXtvGvy3jW/5ZawTiM9WJ/o0HS0mEh
         vf242QO/N13O8zb4ivDetonp3ewZKOQjnBpKS5IBAeaI+7x1PqSv8QTOk7sxEeF8LZCQ
         MhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737116977; x=1737721777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnJCATVCC9DaYJ4RBeUzqUHG1+Hg0wq1+OBGyCVtuyo=;
        b=k1gmiMnFdQnAwrTzZeG94Ba7XHuXx5FZKO1NsAF+RmQEVjM2LtNMsa0uxVN3qHAlvP
         js15hFUkHQbkyMHzakZ+UUInMaEmrm9oM2VqWBITebV2gxWm4ybKFkMRNozSyMoK/Kme
         5+5heWq4CSFwpNzggp3/1RsIoRVTa7E9UO71gbb9o9vPbdo+EssLgva6I0BVoUYCQNJE
         p7PD8vIkbhfE13OAfTQ73wfsZiE5vTR0xzX7Wq6drgs+jtuyzUftjreHfVDgKeLqCDVn
         6KAuzX6O1yeEdGfLfTaScxTYDxqD8nFreyspQ6vRnf+ptLB/c9xcSKXD4W2xGYpxxndM
         kaKg==
X-Gm-Message-State: AOJu0YyXzU+LlXtzjKXwk1v0h1jh2+BOehHWhSGm84QmJSnJayvN26v7
	SXtlbv3RQYM1q7e05091gmrti078bsr5GxqAS9Jlpqmzo+6uLAE5xG3reQb7G1TrHg==
X-Gm-Gg: ASbGncuoSNxFn/WilUWHDqJQVezu1XW7tHP0bDuHaOabVgHdSPxeayLR8WR0tgZmYjL
	hsq083K2WOCdhRtsep8kYjXOIybOokAVyg8IkSB4esrpx8AKs1m0t+mI4rjs+HMS5PhvdKHc4i5
	5kTzWjY89qF/MHiOZoPw/tthFkLh4tSZwHlOVjbhMzB/u9rdUrx8uBYFeD2reNRgTrtEpkMlI40
	m5RgD2DLsOm2Bk4sB93uLFL1rZ+9OOC3t4viSJ/I05a4J9JQSm+ZewA864thRBV3+xlVQ==
X-Google-Smtp-Source: AGHT+IHEGkT9Hsr2L7XG0PAc5ryH4mcAsqZkLMjrsZGS4kMfIxkWx5lBFs/OwDoOZU/mHCufRdT3zQ==
X-Received: by 2002:a17:907:7b88:b0:ab3:61f5:13c7 with SMTP id a640c23a62f3a-ab38b4c9b89mr234455766b.53.1737116976857;
        Fri, 17 Jan 2025 04:29:36 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f23007sm164362166b.96.2025.01.17.04.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:29:36 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 1/4] t/unit-tests: handle dashes in test suite filenames
Date: Fri, 17 Jan 2025 13:29:23 +0100
Message-ID: <20250117122926.101749-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250117122926.101749-1-kuforiji98@gmail.com>
References: <20250116161559.91038-1-kuforiji98@gmail.com>
 <20250117122926.101749-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"generate-clar-decls.sh" script is designed to extract function
signatures that match a specific pattern derived from the unit test
file's name. The script does not know to massage file names with dashes,
which will make it search for functions that look like, for example,
`test_mem-pool_*`. Having dashes in function names is not allowed
though, so these patterns won't ever match a legal function name.

Adapt script to translate dashes (`-`) in test suite filenames to
underscores (`_`) to correctly extract the function signatures and run
the corresponding tests. This will be used by subsequent commits which
follows the same construct.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/unit-tests/generate-clar-decls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
index 3b315c64b3..abf6a2ea2a 100755
--- a/t/unit-tests/generate-clar-decls.sh
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -14,6 +14,7 @@ do
 	suite_name=$(basename "$suite")
 	suite_name=${suite_name%.c}
 	suite_name=${suite_name#u-}
+	suite_name=$(echo "$suite_name" | tr '-' '_')
 	sed -ne "s/^\(void test_${suite_name}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
 	exit 1
 done >"$OUTPUT"
-- 
2.34.1

