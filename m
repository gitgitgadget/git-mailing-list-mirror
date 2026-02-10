Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4B32B9A9
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698590; cv=none; b=B38rcS6XT/1M9FU9miBIWGJvTp7uTzUUYtb+pzKKKGt99G1l2FMi3WmDOFr5LmFWfygD2ix9K6jpJy7bKeg4BCOSCIwbuDWcW0sOT2fce7rDbZlGUtQ7UArExjf7p3cwIJSwnKK/KtwDXcGMPZPjSdh03N/tCSZvtqLw2zLSPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698590; c=relaxed/simple;
	bh=E/hrD4XmDc7cC4aEnYNfaK9LZxwikvx7r+H0VMmPDCo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g3nw1dW1l1FaTvAW9WhaaQThbtQhMiV4sfMnUEEWADtinU5+npchXPQACdC+kZloxJGG6pWGzD9hxCUMaecOTP0KLn/DTvUwwEVTwA3WVy5j638gAodrvkngagMKiOgy6hxK//x0UNF+hRI/6iRbhyuqu1oX5JwR/w0OIWNgu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTsKlV5M; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTsKlV5M"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-66307e10d1dso2750209eaf.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698587; x=1771303387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmXQQSdIEcC6yeX6/IpciO21hXbUmixsRvc+YPtK7qM=;
        b=kTsKlV5MGcYVgV4ldBN/Jrecp0hb2mNjQXKVMFQND7Cd7sJmW1Jw32xS3A4z5sg6Ou
         oWfGl2qNAhC1xBpX6411Xl7mC+Dlk0m1Y83u6RWT069lLqVXr3FlbOvjJnV5rCut51tK
         5TgZHV1h1y1F7V7Bl7xYnqt9xSke/M1lmsO0Diw3+EwD8oKEHYx6WkiLa+gYSyvuwzKJ
         l+zZ01VZ5OCsJlUYLxMnKcvUG7lwIq1qA9Qoodno0I1MiLD3PqGnDNIkTtN0JUBZB2DS
         mWA9yfkRqgLu5J7SvHlUgy809hAJzh4AlJN1Q0c/F90mAxLBGULadC8WxaK8HHBJFZQj
         Zvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698587; x=1771303387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JmXQQSdIEcC6yeX6/IpciO21hXbUmixsRvc+YPtK7qM=;
        b=qvovm0jFNHuoHcGxyq4lAolm5Ojh/dXbDjR6NPC055B3UkF1wpeQI5pZ8l1PKLevBu
         BZX1EYU37NhcIXQSYZUxB3/tHnBzhimCUGaEEGq3gfLA9DBL9Q3+6/dlg+OZzjaJIkEO
         F33DCwin0dFdTPTmV/kzc/++7LOGDQNHEDTTyYJblLVeTv3MQ9SRot5f7vSx1wt8uhyH
         FVsbuZvd+vdsoyZQUY71SF8UVf0apvJccIJMhCLevm4WsgverSzW5tYIhlUvmjH6sbs6
         QhsR7N3Cp3xwnG0uEFuCtXcD0ychczCMiAJYDHvFl0YheYHDedxT5EBolZPUuV64HwbD
         xDrQ==
X-Gm-Message-State: AOJu0YyMbIOdfd2i7pL8G+LOAXVOU384DIFcYBk/3a1YT5EhEfKx4KKx
	q1V10ty1Rv1Oz8+b9IVq2c+K3SyYyvNqYAgtMCTeAq/fJTxJSJdlgjdnt5TOjbv3
X-Gm-Gg: AZuq6aLsuT3PYEewL6p+OiH2rvV9QTvHldWtZUkCd6uXkEbDGMfrK2HTOnyAwMa1ccy
	9r3LpaTvMN97xixK/WZFj92/vnfLkzofKFjeinCWS7eAd+U5++o0jGIc2mHsKqdquCcVCixwNfL
	Qq6hJ87nq3kyHxNAbgE+te1biB3rkcZKTxOq2dTnvYA4PoP0tQEP6m8zm82YGqqSDOB1IJMUWMH
	6PQBgsn1jyqHcU0z1UDJ3DAawunUIvlgY7YAxi+p5m6h4pbSFW4gmZuftV08hPy55fIJxeeo4yb
	mYSL3WYaKzLnN1W00+pvbh8Oux80fqy90IvNHyUJltop95sWhscXCxXihw2LzAvFX4TBGrTdtuq
	VzijahdgtF2Mf+j73OAOpRSYd1TbDTHYzYinVGXnjOHviRm88zQkU5KiU+6j1PlT8Vb7nlMKiTh
	T3m4K02m662QbuiLVNX5fd70asqA==
X-Received: by 2002:a4a:b688:0:b0:66e:53d:44e5 with SMTP id 006d021491bc7-66e053d4a19mr4035470eaf.12.1770698587492;
        Mon, 09 Feb 2026 20:43:07 -0800 (PST)
Received: from [127.0.0.1] ([52.173.178.210])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d3adcaa9csm7659724eaf.11.2026.02.09.20.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:43:06 -0800 (PST)
Message-Id: <8d3a6a8265714c5e4bae0f2e5a587ea46a6adddc.1770698579.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 04:42:56 +0000
Subject: [PATCH 2/5] parse: add git_parse_maybe_pathname()
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
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This extraction of logic from config.c's git_config_pathname() allows
for parsing a fully-qualified path from a relative path along with
validation of the existence of the path without failing with a die().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 config.c | 14 +-------------
 parse.c  | 24 ++++++++++++++++++++++++
 parse.h  |  2 ++
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index 7f6d53b473..83257b7a97 100644
--- a/config.c
+++ b/config.c
@@ -1278,24 +1278,12 @@ int git_config_string(char **dest, const char *var, const char *value)
 
 int git_config_pathname(char **dest, const char *var, const char *value)
 {
-	bool is_optional;
-	char *path;
-
 	if (!value)
 		return config_error_nonbool(var);
 
-	is_optional = skip_prefix(value, ":(optional)", &value);
-	path = interpolate_path(value, 0);
-	if (!path)
+	if (git_parse_maybe_pathname(value, dest) < 0)
 		die(_("failed to expand user dir in: '%s'"), value);
 
-	if (is_optional && is_missing_file(path)) {
-		free(path);
-		*dest = NULL;
-		return 0;
-	}
-
-	*dest = path;
 	return 0;
 }
 
diff --git a/parse.c b/parse.c
index 48313571aa..3f37f0b93a 100644
--- a/parse.c
+++ b/parse.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "parse.h"
+#include "path.h"
 
 static uintmax_t get_unit_factor(const char *end)
 {
@@ -209,3 +210,26 @@ unsigned long git_env_ulong(const char *k, unsigned long val)
 		die(_("failed to parse %s"), k);
 	return val;
 }
+
+int git_parse_maybe_pathname(const char *value, char **dest)
+{
+	bool is_optional;
+	char *path;
+
+	if (!value)
+		return -1;
+
+	is_optional = skip_prefix(value, ":(optional)", &value);
+	path = interpolate_path(value, 0);
+	if (!path)
+		return -1;
+
+	if (is_optional && is_missing_file(path)) {
+		free(path);
+		*dest = NULL;
+		return 0;
+	}
+
+	*dest = path;
+	return 0;
+}
diff --git a/parse.h b/parse.h
index ea32de9a91..4f97c3727a 100644
--- a/parse.h
+++ b/parse.h
@@ -19,4 +19,6 @@ int git_parse_maybe_bool_text(const char *value);
 int git_env_bool(const char *, int);
 unsigned long git_env_ulong(const char *, unsigned long);
 
+int git_parse_maybe_pathname(const char *value, char **dest);
+
 #endif /* PARSE_H */
-- 
gitgitgadget

