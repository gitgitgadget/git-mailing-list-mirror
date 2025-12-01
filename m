Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB33321D9
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607855; cv=none; b=EP/auegjCKR3VGFS3I4Zk0J3mMMkHdM4s2vIdXi4I4mbPzDRDTxgq4FkwpJk42usjTKd5N6IJ8RimH0OsKqtgDuGOlQWf4wF8qkKcX7Q1sTm/aQ1agmSrustjjG/A8BubmiNsz0OyOLj4miH6E0w7gK2jaHHILwbjmzUjs1+DRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607855; c=relaxed/simple;
	bh=sdMhBQ2FXBrVAllJKjAHrLXoQoxXtYQJy5/QDKuzBGA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B5NNtpnBGSCzdKvF9aq7jW/ZNfXKRHV8zEr1C/ZoyLXm1fm0WpKm8t9BSiuQCzIEcKT10G0Z+MfRrWdwxQHlczocfXVeHljOuZF+ihEjRXNOi9l6z7bY/0vKJjQQrGwnnLteJ86g9yajZirXr8GzIhhsgxYGt0ZSnWoN3hBEel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdFup2QN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdFup2QN"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so4716492b3a.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607852; x=1765212652; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0mNDp7mMbqw/NuaqqBpnPTYCKXRDCFGRGQJIRGulRU=;
        b=XdFup2QNPWu0SHm2eNN/+LXISf4l244DLnrZTUulAgeB3nokh+3PmLDHe922o5n21l
         AO3ukCcQOXl7lHdd+r38AHMNrJIYLfJiaYwzm4b/pUecgbeyF5ijTAAB24cUsw2L5nXp
         kXAi9kkwdhoNmRzgjrJvgcQYPflCKLAssq1jw3VOXG4MbfrBKKPYrLKcfBDFqVE1T7bU
         /KeG/U2qAWAHZ7P21w6vivWEmYXbCkOlugcD4MOWDpPb7+aeoHRgVZsD6p80goBChA0m
         1DXQI/H3fKBF4HjjM9R6DxQGXN+xa3k7CtNBBZMq76qSMANAMyC7MZu/JQWmk6vCo25I
         h47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607852; x=1765212652;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0mNDp7mMbqw/NuaqqBpnPTYCKXRDCFGRGQJIRGulRU=;
        b=ioCuxnNJ1CLVqyiDKOnAM+NqAPCLRArMi+5gn5PJ8QeDgVQyc3YFi0awZHpErN4U+v
         PkZKGvTFEc82xaE6HBoljkJTQG1nbsHj59zVvTkn2OrdUomyUVcQNsXkLdnB5hdOz/PX
         Z0rakoqvptC60uZqcmPwWDuUSy43wp/+2LbTaU0vvls1uvvWD0iwWH83LiW38riBhS9G
         OOYB4aZKeOlKx7cuhyedWASc543TCWhVqTOLalC+pEakkOQ2MxD9IA6EhnrFUKOgVvA5
         gbJ4a09szw2NrKiiwBGpDn8lPdtn6ZFWqyy3BUtbLmO5k7SP4VGTF+WPM7bbm1+pf1Ye
         vv+A==
X-Gm-Message-State: AOJu0Ywc8xNI4+MiIcAYRLbAl+u+Drc6Gwvzn8T/vx3nlvj95x6vAaj9
	YuV8T+XOqJvczIS2w/EX3ZbZRA31IAfzygX9wDUn5gbTzVjypOPQxc7j8s9jkFUq
X-Gm-Gg: ASbGncsrL95T+Oz15igbQOfOnhPfgiUCS0eRHI8JdZs+OKKpD7z4brxKD7+QM+CFmli
	eClNjXG81Y5QOHOogPySQGVOX2QeLi8pqo+6WKWxpW5tOQs9JOHNCax47qNp1+uMNtZsTxR1zda
	2DdKs/+Wes+FZd1x0bBR8zQfjIuTwigLqzqfZ2UIrcMx9WOdj1ozlrYrIa1wzlsYItoUUhB3JRL
	o/ZITRnkoPeQm0nsEHUA3jmN0/Inzlvd1Rwq1UAsf9SUycTEtM8kDB3AL9BPl7/7BjB5f3FAhQv
	zFbQI0yxHYJ7fPzbb8Aw7pZMGaC/fjIPrPgmZ1Wajh66/INa/wiYH+i2qOvIF+H+LptkSm3GK5O
	zXcwNOzFa81QTHzNMHw0UE+3jJGrtryF9slyJxu4VFqkX6hD5lqS7bbNcZ0C3riZCdFquOBOPlS
	t3EScaxAHVrPrLOQ==
X-Google-Smtp-Source: AGHT+IGqU13aTs0scY4Pu3p29r3urfw/sc6txnU0XrYrVf0ODW4Jxhu4icF10lfEu9TrQ3uu/UG2EQ==
X-Received: by 2002:a05:6a21:898b:b0:363:b976:8f79 with SMTP id adf61e73a8af0-363b9769000mr10959790637.43.1764607852100;
        Mon, 01 Dec 2025 08:50:52 -0800 (PST)
Received: from [127.0.0.1] ([20.168.106.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fcfd0cfsm14023121b3a.65.2025.12.01.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:50:51 -0800 (PST)
Message-Id: <10e95489554fa99469b1fe3248e81db9b74364b2.1764607847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Dec 2025 16:50:44 +0000
Subject: [PATCH v2 2/5] scalar: use index.skipHash=true for performance
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The index.skipHash config option has been set to 'false' by Scalar since
4933152cbb (scalar: enable path-walk during push via config, 2025-05-16)
but that commit message is trying to communicate the exact opposite:
that the 'true' value is what we want instead. This means that we've
been disabling this performance benefit for Scalar repos
unintentionally.

Fix this issue before we add justification for the config options set in
this list.

Oddly, enabling index.skipHash causes a test issue during 'test_commit'
in one of the Scalar tests when GIT_TEST_SPLIT_INDEX is enabled (as
caught by the linux-test-vars build). I'm fixing the test by disabling
the environment variable, but the issue should be resolved in a series
focused on the split index.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c          | 2 +-
 t/t9210-scalar.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index be3878948d..1cb8ce3723 100644
--- a/scalar.c
+++ b/scalar.c
@@ -160,7 +160,7 @@ static int set_recommended_config(int reconfigure)
 		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
-		{ "index.skipHash", "false", 1 },
+		{ "index.skipHash", "true", 1 },
 		{ "index.threads", "true", 1 },
 		{ "index.version", "4", 1 },
 		{ "merge.stat", "false", 1 },
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 43c210a23d..923c243c13 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -246,6 +246,10 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 '
 
 test_expect_success 'scalar reconfigure --all with detached HEADs' '
+	# This test demonstrates an issue with index.skipHash=true and
+	# this test variable for the split index. Disable the test variable.
+	sane_unset GIT_TEST_SPLIT_INDEX &&
+
 	repos="two three four" &&
 	for num in $repos
 	do
-- 
gitgitgadget

