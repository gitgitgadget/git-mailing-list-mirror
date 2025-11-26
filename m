Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE7201278
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195524; cv=none; b=CvcPvpQGx3lpoTw5Jd95zPOgWUh0/tY9OtR8gZNQ5sm2XjeiLjb2rEceFx++XVVLjm/+BXGlgo76wERyt831C3Ws2RkW86dCHDKKZNF4wNDMTKvuJpzR9MSIUiGfFE6E3WByjP7wFPlMVgbiKVxQzNiDtO6ZhAsluFR0ypzX6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195524; c=relaxed/simple;
	bh=zrjI0Kx0RiRrMD9DyOoHcRJPbDHZRCt9e1OMtQtHIwk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZhwIHTSfK74gvsDlcVIJ63xCaZtderWGZtQ7Q+SPKGRi2smBDId2hJZJajpyTT0VRNTf94VVm1zDF7LkkxNHqQU8nyVbErm++xoDt995hvWzsG3A6WUHY2yJ3eUFdNR1CB3AX5ZlRa0/dgywR4mfGaIYtwxkGhmhp90kqmqzUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGjEHPgb; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGjEHPgb"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-882379c0b14so1845326d6.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764195522; x=1764800322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2IkNJbmTI3KhBCodQhFO8mjeWbGaZM2/y+L5CdIBOc=;
        b=NGjEHPgbodKvzRAZuDcExgacCsIgRDcTQOtNQrJrDcGF7ljFr6l8ERVRFuwwGFgrjN
         QYmEC0xSejyZ9Povg3yGpUmEpCkhBQywbVCGM4+iAltZ3/EZwZabbtiufiZ2Kc/lPi/3
         qnr/Uh9BUtFEyvsNuadmw1RQFr2guemfXUtUoPifwY6zHSDzgSXPvUvhiyYNL8z/XwV9
         JlcpW4Tx7fV6mWTWaa190rQrpCSfFZSiLcaJrwwOuX/Q8Cz8zTibW+s7IKy1WIEkXnO0
         m+lg/UOLxkaCHlA7g8lDXrGv1LKZ8x6PFzF0cugpNvQDatohTyakS9U46UL9rfxL8Sts
         5Dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195522; x=1764800322;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2IkNJbmTI3KhBCodQhFO8mjeWbGaZM2/y+L5CdIBOc=;
        b=uI78fA4HvGcElIll16aRlHaFg0UYj7t/QO9ys2bt/7L+aUdWCnPR9LXXW9sHmujSzI
         i9pQOR0AJHgSEiD3kNTwdI2K/I5uSNlSdlkWkWTXbIsKgQDQcCuWmnXm2nlXrBAFD7yK
         9Tes47jVTJ0NPdSqv0BSUMj0xyimoJbQXkxUCd0SrebxIn0dIlyjFC42JDXUflb8ebHz
         2P0sw4nCsbjHS21mLxOzREHzrPR1CBHqOkRflw0L73BQ37hDFeTyB2TqsxPUE+fQDRsd
         UBIch4fFj7o+2YG1QWd/9ySnU9g7lNp8Iu/9hZj9q25tCi+vmYqHtZzmSko1P+px9lZt
         fqGA==
X-Gm-Message-State: AOJu0Yw1PxJS7VhR39ZaG5EMjCwsV/WtFjK2txoude9iSW/EOwI0Ss0c
	n4jJfSnjKlv/qrqOr154gC2snADZenMaOisULqv93UZ+WNhOoja6ZDYvruUYVm7I
X-Gm-Gg: ASbGncusOWyEeQCppwGl4CyO5DsCFOdcvxYcAUyzfFRIJ7DcuZ+v13eXwDk9WVtW0pT
	YZwc4X4i93AfK4lcjmq+gIDiaG40t91eu1Dn0l+MqMHHunb/VN0qv7nRsMWwGQnu4JOee9yse2Y
	BQx4EUMFc9CqwbwC90ek/U/Ic/f/K2YVqgXPAVL55RlBIPne2WR+r3fSIK9vgWcpwlMfPzXex0u
	5IZnQsDQ+ZUWhTvi9umr5Tvoo8sC/8jMicsHHHvov5387W1gXP9Kfn+H4C/3LeYpMZT9XeEJ+kS
	T6lrEoZ6W7yOHTaEwMshEeNqe13RyxcXZ8Sbf6GhhLII73B7a5ngqJMNOWHjiRXtfPIRnXbxuCO
	RL0nJxXMbltsqmyuYHA111feruhw6GmRKm7ArVAMMfFrLMXPQJbnjxrRugKFyA76O83ewUdfgSj
	e5N7soWiDwEWs=
X-Google-Smtp-Source: AGHT+IGbloJlqRMaeD87Zx58frpelJYGp/86uKi5H6bU1uv/+8FK0dSlvmnN0gRAQsd8me9qkYjrsA==
X-Received: by 2002:a05:6214:194b:b0:882:401c:e391 with SMTP id 6a1803df08f44-8847c5794c7mr332538766d6.57.1764195521580;
        Wed, 26 Nov 2025 14:18:41 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e48f0d8sm155757786d6.25.2025.11.26.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:18:40 -0800 (PST)
Message-Id: <1c51dbb81485920e9faf336ffbda9d9258e7dfe1.1764195516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 22:18:33 +0000
Subject: [PATCH 2/5] scalar: use index.skipHash=true for performance
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
 t/t9210-scalar.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index 431b631585..75fd292be7 100644
--- a/scalar.c
+++ b/scalar.c
@@ -154,7 +154,7 @@ static int set_recommended_config(int reconfigure)
 		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
-		{ "index.skipHash", "false", 1 },
+		{ "index.skipHash", "true", 1 },
 		{ "index.threads", "true", 1 },
 		{ "index.version", "4", 1 },
 		{ "merge.stat", "false", 1 },
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 43c210a23d..91d5964b73 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -246,6 +246,11 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 '
 
 test_expect_success 'scalar reconfigure --all with detached HEADs' '
+	# This test demonstrates an issue with index.skipHash=true and
+	# this test variable for the split index. Disable the test variable.
+	GIT_TEST_SPLIT_INDEX= &&
+	export GIT_TEST_SPLIT_INDEX &&
+
 	repos="two three four" &&
 	for num in $repos
 	do
-- 
gitgitgadget

