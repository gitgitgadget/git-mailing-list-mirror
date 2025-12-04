Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128132AAB4
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882584; cv=none; b=orHf80pLCmx7i9m5gEc4eBadtIzsBunsZi1PpoNeIIUyucALzz6hsHSIR0w+FHqB/bb3/wniH3g0e3Jh+qVwsWiU/XpsSk3t6N9SXF1dOwyFlDLxks8Q73UoZw/YzM1sdZu8G1ZZbGKxteF9d9N2jCfE8KoP8VyHUxncC3EcoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882584; c=relaxed/simple;
	bh=sv1pd3Hhi7F+N258jwhCEA9Gitu0nTLF2BlFpJXSzZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHt5YQjwLkfTZeh5+J5/MErVm2NZPYToCmZQfRd3n7oeqSZ9OZu4HjxzvvjORfh9JAFr7T04ZYEYvMVT2LKbg46Mh5PvQQ+mVIZkNPIsNKxvq9jS+bCl47ieW1EJ3kN2WwHsbc3IMdfVF2s3V9ubWoJLR7IPkKfiG8FQvHU5dYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJMed4Vo; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJMed4Vo"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b98983bae8eso1121354a12.0
        for <git@vger.kernel.org>; Thu, 04 Dec 2025 13:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764882582; x=1765487382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FKtuxG2jcrvD++HA5kPFzJA4naQYx2BxUrXnerXN/g=;
        b=LJMed4VoOvD2BnD02oAd99sE4duFWMnHCrmVez3cvWINHwgbMPZAnWWu5OeIyMqpO0
         j3Iaod1d79Jgds8qLV+Ff/FA9HMfppCg65X3DC/OaT34crCDZ6bSPV6wuPOIBQt0shpa
         AitX7x/zS/DctVyZjX84zKXU/Ydx/+kYXQ3Z5GKakCT+rjKWr5eJ1WYDLazvHPAa+zly
         mtZOdGx6wdd3gzvcASwjnWaDCitFRNbPKiAPSYA8CXjMEbzjgTf/ygInX9cNyzMT1n9G
         YAI01uQv9YWtANMR/FrXyai54v1g50JbgWRlJ1Vi8VpHb+6aWYCz/knWHqIUDl11RGZ8
         T20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882582; x=1765487382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9FKtuxG2jcrvD++HA5kPFzJA4naQYx2BxUrXnerXN/g=;
        b=C/lDmMp6NvE/p3MD49aL0mxLpLFTCVY0YqiHYUyWrV5EmbT4cg+RWRPrfh8dnEGFt6
         T7R/EWbV3TrHQD5/tYE0nWcZDWKno5sC4c8QWZaa4C9CKQEz3E3gJb7HlYUAA/knag4P
         PANmvNKeBjTc5sDj6BDpDbgPiNetB82RMQjd9lB2MNWXB/YMUrqEIsgQUNtg5M6Gy+Y+
         diXLb2q06N2oqSmx+/ei9ClYjapujvJfNS7x/ne/4cLBf7tFCeKoN0pAjcV+jMI8lheM
         Unr/CXAHMPFyrzK+I84yP54oblTxfLx46O7TQGBpg2CEikTfpQ23QQBqZHxrLaAC27jO
         7P4A==
X-Gm-Message-State: AOJu0Yz/xdAyHKto6QrL8ACUJES2kWF+ZzyIa1TrV8XUFpHbKX9LM1QI
	Lf9T5cYFK9RUcIDwuPgDP2oRscs7XzGkj+w2nTUcyU1rGOk5k7ZdAbgzJiyRWg==
X-Gm-Gg: ASbGncvntInCKrd1dT1znTD7AqF4fVCnV8S5VBSJoXUlhLwr2fFNJ9ikTVfRKa4LeGl
	2auOAv7kNRs9+0G4mKh3lw/cUtcaU+XapmM5GION/jZcLXbYpVWg21K/DaYs1PTBwWr/MhGZsyN
	lOeLivmtR61+jrHH7h8rDp0lSM45gZ6YghFF+RBZV1UUNwNH8+Iaj8FR9LqNQt4pveCwMBPL/sa
	FxpCCnVVCh1gJ0vprXknAvRLMZc8LLZMlaxg3g9tlZAzvF+ynGolKybcGGpjRFyMfcuJEc/7WjA
	1vdkJCjexYslr0eS8IwrKlw5FzY8+LFC+egYIbkA9PMGbE7SBPcdkriZyfwobNv1T5c9aB5FXK4
	+izfIO5SPla2DYoR5ivnFWQ9s14ONK5UBvQZgm8XhGSToBn6EuZ8Xm2beHkr4cTaDh26LnoHZsh
	4vOkUWhOWldf1hitL01wyxlQ82ZNWBV8MchlHLxSZifgdUfA4grWLuww==
X-Google-Smtp-Source: AGHT+IH/kJmpi807wKgX5VhnOOv46yGQmpopovgM82gY5fMpUpgr20R68l71r666FmEvqfHqUir0IA==
X-Received: by 2002:a05:7300:d518:b0:2a4:3592:cf73 with SMTP id 5a478bee46e88-2aba42fe06amr3249750eec.23.1764882582141;
        Thu, 04 Dec 2025 13:09:42 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:32:8e1d:1817:8b3:9658:8ab6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba822b615sm7882624eec.0.2025.12.04.13.09.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Dec 2025 13:09:41 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jltobler@gmail.com,
	ps@pks.im,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 3/3] repo: add -z as an alias for --format=nul to git-repo-structure
Date: Thu,  4 Dec 2025 17:10:12 -0300
Message-ID: <20251204210843.79411-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204210843.79411-1-lucasseikioshiro@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <20251204210843.79411-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other Git commands that have nul-terminated output, such as git-config,
git-status, git-ls-files, and git-repo-info have a flag `-z` for using
the null character as the record separator.

Add the `-z` flag to git-repo-structure as an alias for `--format=nul`,
making it consistent with the behavior of the other commands.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 6 ++++--
 builtin/repo.c              | 6 +++++-
 t/t1901-repo-structure.sh   | 7 +++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index f24514deaa..c4a78277df 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
-git repo structure [--format=(table|keyvalue|nul)]
+git repo structure [--format=(table|keyvalue|nul) | -z]
 
 DESCRIPTION
 -----------
@@ -44,7 +44,7 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
-`structure [--format=(table|keyvalue|nul)]`::
+`structure [--format=(table|keyvalue|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -71,6 +71,8 @@ supported:
 	the delimiter between the key and value instead of '='. Unlike the
 	`keyvalue` format, values containing "unusual" characters are never
 	quoted.
++
+`-z` is an alias for `--format=nul`.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index cc97dd1836..0dd41b1778 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -16,7 +16,7 @@
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
-	"git repo structure [--format=(table|keyvalue|nul)]",
+	"git repo structure [--format=(table|keyvalue|nul) | -z]",
 	NULL
 };
 
@@ -529,6 +529,10 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
 			       PARSE_OPT_NONEG, parse_format_cb),
+		OPT_CALLBACK_F('z', NULL, &format, NULL,
+			       N_("synonym for --format=nul"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       parse_format_cb),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 		OPT_END()
 	};
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 36a71a144e..df7d4ea524 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -101,6 +101,13 @@ test_expect_success 'keyvalue and nul format' '
 		tr "\n=" "\0\n" <expect >expect_nul &&
 		git repo structure --format=nul >out 2>err &&
 
+		test_cmp expect_nul out &&
+		test_line_count = 0 err &&
+
+		# "-z", as a synonym to "--format=nul", participates in the
+		# usual "last one wins" rule.
+		git repo structure --format=table -z >out 2>err &&
+
 		test_cmp expect_nul out &&
 		test_line_count = 0 err
 	)
-- 
2.50.1 (Apple Git-155)

