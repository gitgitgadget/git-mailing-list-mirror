Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBB217734
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733259; cv=none; b=fr8B9Z4vOUDetP7hNAT2VtLwaV/b5Zgmanp/9VU+SF9awdfBek1sKAuj5ieyJ0feoJQ3+7i0PfeC3MkhnbApJLpoX+egEsPhNy9tHW6l6WOA7J0nhrb6o7BwQURJLyUr8UA+c0/93Jth0WkSuw7KDjNKK/d6NH4SC4XuVtYQ4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733259; c=relaxed/simple;
	bh=LZ4faeMXE1Uv05Wj4y+iHSTNFl9mLnBHQAdctq/JmUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK5ZBaWPHRSEenB/P5wSmpUmr0lz01KlDhqYfj8JLzh+nkxjjBhEIbBf311Z60gcjE9KzkoH4OJC90OGkEmXa6BRt/CDBIrs/jSRsLyEFgPgtEa4jfvhe1IjlB7XlCAhrzWWyQvs5FTHtxEtC+oJpq5ObjA8EpNk8XYTTWxWODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8KCmQAg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8KCmQAg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so56138605e9.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747733256; x=1748338056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ybsWjFwcPaoy2zXd0JYngbHU8acrbHandGLaUiZ3XMA=;
        b=e8KCmQAg0WET5uvUgRrEpFxQwoHcgeH08LGcFmUFsLMLQFZT3X66cPsqzZxaZe22MH
         qw+k7oxA/IZXJT2VXe3MZHPJqS8tFX13OYC4ERXTPijLOaRVCFYX3/vGFiA4GLaqOlN1
         mRm4AQDEcN9/g/jAO03wJgJM22FMtTG4C7ok+bG7PZ0UEBU2FpS9lNJ0CsXu2VP574mY
         1QospvUjnDLZvRY3uWy69pXy2hUUfX3NQvFMb2LZjgNibRt4/7XFt0a6kv6els2ChGFi
         9exI1RdB6IhdzEe8yosj+kTIXpguZIodeR7lSEbQgGvsIiPVCQyLubdJTczq4n8r2ICC
         pEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733256; x=1748338056;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybsWjFwcPaoy2zXd0JYngbHU8acrbHandGLaUiZ3XMA=;
        b=oik0ryKCga0qR+yO5rW2jIrJ29FhLzb/maCudQz+UTK3gpVl7G8b2OreXxTwzcIQx9
         nFqGzLYdS0WLy9TO+/gcOftX7dDcaqhK/eCjPMK3h4cguvACQg7RjxyPxPs1arF79BX5
         EtVn5vFeUNKiB5As9ePDTjz58MKz7gZQRuBIXZXsBbfwNZTLMxjR1kJ3zNLrpIyizH08
         fliOApQZdPe4yHSDg4d/QrPpa6GSEHq1FLbBeMTa2wJBQmgX5/T2n5i8OBVxhEG9gvGw
         YuZpiN6zoIC8/C8k81KOWP3RbZ19umd5M9+rUMt2+tgTGkZKzKFpTVRZU7SKVM4U/FTR
         IwNg==
X-Gm-Message-State: AOJu0YzePa6vPzt0mH1MqnkndYM+sy6Urc0O3UxcPe4kavQTpn9BCSh2
	hD33IS8iqaY7WLBLMT81xlxQSuVqMueB6f41S0I78eTNIkZu6QBiXuXbienFJw==
X-Gm-Gg: ASbGncvZ1olURmta+cJHKR1tKWEAo57LB8IqplvQRNhmkv0R5Gk8Larb2aaoVqnPXhl
	KgH52A6IgXswJN/DmTCdJhbKLfUVLmbRH8TE6eiDbiOK8AlmWpmDSYd0jU86ahZKlXPmHXZR1QD
	R/y6XzlvFTGivIXpqlfjS6WDNUjVBmB+Zpfl/btWvxwJS00M037F27nvHFf6EWUXjclXQdS41D/
	41SaCkOovUiTlX1QmgKWWk9jICptq1zKetmoTx6bqVPtv+zXbEN3Y+iANcpatqr6hzYeKOFHsXw
	+Y6tY6/OeSSXRBjWearW7owQ0M4FUd6oCo2ufCqiAXiMhvr8h5mYDJm8WkgfEUPzF9Q=
X-Google-Smtp-Source: AGHT+IEF9MuOEGFwIN9QRBkPldEtO6jYxRhBXXO3/8eRjkkZWtikLsW2/JajQ5SaQI4OYxRv3hy8IA==
X-Received: by 2002:a05:600c:4687:b0:442:f98e:f37 with SMTP id 5b1f17b1804b1-442fd6607d4mr127548445e9.21.1747733255747;
        Tue, 20 May 2025 02:27:35 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062c7sm23544255e9.14.2025.05.20.02.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:27:35 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/2] stash: allow "git stash -p <pathspec>" to assume push again
Date: Tue, 20 May 2025 10:26:59 +0100
Message-ID: <2cd67f5cd85af03ae99a2760a76e9df5a7edfd95.1747733203.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747733203.git.phillip.wood@dunelm.org.uk>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk> <cover.1747733203.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Historically "git stash [<options>]" was assumed to mean "git stash save
[<options>]". Since 1ada5020b38 (stash: use stash_push for no verb form,
2017-02-28) it is assumed to mean "git stash push [<options>]". As the
push subcommand supports pathspecs, 9e140909f61 (stash: allow pathspecs
in the no verb form, 2017-02-28) allowed "git stash -p <pathspec>" to
mean "git stash push -p <pathspec>". This was broken in 8c3713cede7
(stash: eliminate crude option parsing, 2020-02-17) which failed to
account for "push" being added to the start of argv in cmd_stash()
before it calls push_stash() and kept looking in argv[0] for "-p" after
moving the code to push_stash().

Fix this by regression by checking argv[1] instead of argv[0] and add a
couple of tests to prevent future regressions.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c  |  2 +-
 t/t3903-stash.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a6..bc2c34fa048 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1789,7 +1789,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	if (argc) {
-		force_assume = !strcmp(argv[0], "-p");
+		force_assume = argc > 1 && !strcmp(argv[1], "-p");
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage,
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4b..d24559a328d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1177,6 +1177,25 @@ test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	test_path_is_file bar
 '
 
+test_expect_success 'stash -p <pathspec> stash and restores the file' '
+	cat file >expect-file &&
+	echo changed-file >file &&
+	echo changed-other-file >other-file &&
+	echo a | git stash -p file &&
+	test_cmp expect-file file &&
+	echo changed-other-file >expect &&
+	test_cmp expect other-file &&
+	git stash pop &&
+	test_cmp expect other-file &&
+	echo changed-file >expect &&
+	test_cmp expect file
+'
+
+test_expect_success 'stash <pathspec> -p is rejected' '
+	test_must_fail git stash file -p 2>err &&
+	test_grep "subcommand wasn${SQ}t specified; ${SQ}push${SQ} can${SQ}t be assumed due to unexpected token ${SQ}file${SQ}" err
+'
+
 test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
 	mkdir sub &&
 	>foo &&
-- 
2.49.0.897.gfad3eb7d210

