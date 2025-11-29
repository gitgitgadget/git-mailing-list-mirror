Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA8A26738D
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764423831; cv=none; b=knFSV5INOi9P5xNByOTKsuA4xn2HIBJUT86ZE1zGZoLdvNd8jZPiqC6+rnkcdT2j0elcgx0/Wm8uAkVIzfsFVzA31OB9vusk0ocG6He0zaeSgGTgzmT3TtfpJoeH4Q5aLs+kQO9K0rZT1PsSm4whV9bvBho/eT9YsKv3L0JGS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764423831; c=relaxed/simple;
	bh=7AtGK+uNJyaKnbvEoLRAd9TjR68oOtqzkPtSi84/Ozw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=csuKRh2cmziYqjS1F2KKThbacW08G7xaObCBUCVaEkI6234wVFFyRW6jkSghEbNABgNp1djmWNBkkepqU/cZtywDwg4hWAMmAz2Gp9rc0K+S9I+fT5JDGi8Lqcw43XNQvstBy58auC+VhtJibC6JWVCtxvEeryU9AlS9VuNVKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZFIl96U; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZFIl96U"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so1781367a12.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 05:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764423829; x=1765028629; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e4Po35fOBMhhKSQaF13AgPH9cXZYD/7NJfksfIK1MMI=;
        b=aZFIl96UWipTgRzWMwlbgtXFDzHyubLhpPmvfF6AqBrp8g4t63AZJmW/8ojaC3mEFL
         somRimuWhgDvSG24jXnVVKkPWno7bsqDvCmgdAMIfbul7nEc9Go9sZlrC/o9b9JGSF8E
         BPy7NxOk0aYpFOsDfO+RzRaeIb6MpaYhVn9YnV28pV/IAwa0p05tCRw6VpiLCgLpWpWN
         32omAOrF4qhp9hssQd7YK7ANdGCtR3oyvmENfkqDxI3jY2xgg63Xrj5CjZ705i7NsWF5
         /dLlrGFGRMsOfss5fc/6CnnYTFYWL6cCzkr9HEwy+MAlNZIe7NgdOonu1YztsnobgAiK
         LuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764423829; x=1765028629;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4Po35fOBMhhKSQaF13AgPH9cXZYD/7NJfksfIK1MMI=;
        b=OnoB5qSIa+HCH45WpDmqwdTjdFJtjvUNm7KljbF/MYXBxTQOL4/3kErdCg+x6DDbdE
         2K+hi6qPdudaJjQ7UYlHoLfHvGK52he8rc6JlHBSTF/ashQ83/ITYXWI6iYVaGiG3a8L
         B+Xlplx3SGEml/4TRHBcyG7rnRQeWQLftucTpmgDkvub+cLEFGjVGwWhqCHwdN45Cgkd
         oHEg529SGdh5av2k2ZyVhaTYss3GIHpuUuH8qq4nsCind7ZnL9lA/YwTEiO8Nn8CGdyC
         sU0OvFld0I8yJ9QfVAS1AOFUTAaiLMILfemfLTgb+xliq+FQ8MSlz04qqHolhNCxZ+X0
         beIg==
X-Gm-Message-State: AOJu0YwQgmV4WAk2dIx99SvGFVq+T8plcUC0WUpCRr8nV19VQLQbf38v
	I1MXMUt9P4EUzDJqf7VOfXdD+OES4aBj6cw6s401DfvxinOZVZZOqiDJgo89nQ==
X-Gm-Gg: ASbGnctW/1oiMw1Kng85csHdAaRq8Y9fW8gbkt1KC1S3L1ZtizlSvlnLcF/f1dFbyB9
	tyE7l6EnFg2ZZqU8WotzXdCaBlkRxblKYecHzdgT1xFII6g+YsMiR4LyCdvz7+ZbUgKmBP874wV
	QVzWklHaunaq/YbRgpZELrqzY4Rb1uKqEFlvzoeXB2vGm1qLJUWJsOoKjLIvN4GBTUT76z5lAd/
	1AJ/lf8oem70iiUrACY4M3qaw3LlRyU9bTc55VoS2HM7yF75srQkKtYiF8K6VKZyzOJp4BcatNQ
	VD8y2OgZRWCSa9+RT2AUNcBecYvDW2d2oyjw5iKFquq0gO68DBSMf0Wos6NwBD09qvgf1uMVwNN
	+EXfzS7P6uBiyWuHF8IoEzc1R90cRf6c/11xufefjn+b7TsRgxAMGV0r9Mo5FotjXTUO9eTdElq
	NywJxhIOHl63K/
X-Google-Smtp-Source: AGHT+IEZwD/q8k1L239Zv12ptMobnZBCkhj8AWxWLDbe0ts36S9FfC579ZB3CtFtnTZVSLzfQt0QAA==
X-Received: by 2002:a05:7300:1344:b0:2a4:3594:72e3 with SMTP id 5a478bee46e88-2a71927b67emr21715312eec.18.1764423828577;
        Sat, 29 Nov 2025 05:43:48 -0800 (PST)
Received: from [127.0.0.1] ([52.161.82.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9655ceb04sm24914464eec.1.2025.11.29.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 05:43:47 -0800 (PST)
Message-Id: <pull.2013.git.1764423826908.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 13:43:46 +0000
Subject: [PATCH] last-modified: support sparse checkouts
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
Cc: Toon Claes <toon@iotcl.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In a sparse checkout, a user might want to run `last-modified` on a
directory outside the worktree.

And even in non-sparse checkouts, a user might need to run that command
on a directory that does not exist in the worktree.

These use cases should be supported via the `--` separator between
revision and file arguments, which is even advertised in the
documentation. This patch fixes a tiny bug that prevents that from
working.

This fixes https://github.com/git-for-windows/git/issues/5978

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    last-modified: support sparse checkouts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2013%2Fdscho%2Flast-modified-vs-sparse-checkouts-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2013/dscho/last-modified-vs-sparse-checkouts-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2013

 builtin/last-modified.c  | 3 ++-
 t/t8020-last-modified.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index b0ecbdc540..dc1e229f4d 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -525,7 +525,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 
 	argc = parse_options(argc, argv, prefix, last_modified_options,
 			     last_modified_usage,
-			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_DASHDASH);
 
 	repo_config(repo, git_default_config, NULL);
 
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index a4c1114ee2..50f4312f71 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -78,6 +78,14 @@ test_expect_success 'last-modified subdir' '
 	EOF
 '
 
+test_expect_success 'last-modified in sparse checkout' '
+	test_when_finished "git sparse-checkout disable" &&
+	git sparse-checkout set b &&
+	check_last_modified -- a <<-\EOF
+	3 a
+	EOF
+'
+
 test_expect_success 'last-modified subdir recursive' '
 	check_last_modified -r a <<-\EOF
 	3 a/b/file

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
