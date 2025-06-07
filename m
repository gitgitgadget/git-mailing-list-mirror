Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00571FBEA4
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749289545; cv=none; b=dy/lVYP8CbFkY3nWGyD4PF5e4WltQ3lPHqfaGQn1I+mqC5Uf7Q7wiINTV2F5UPMBvPWstu+Bz+0DbDFD9dE5itnqzPpTgBRDJhMh62WHtAndeJx3eA5RVTh/kzWY0D9rMWn7YYef/E/kvV0ccki3G9DIhzvv5CPSeO/+pt2kH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749289545; c=relaxed/simple;
	bh=3/zTBx/wV71ICbp8uozNMR1L7F5zfOa8EW79aYv6LVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+5CRCZF0dog8Lgc+KjqiR9n6gcL4pXOz+voPSfzSB+3c1XpBDlM1fIRhRWkPHSaoS+jqp+cxs1Toa5R6d1EiraF11u9aaQ3w2a7R5szWg+Rt/7GUklYLtSIDS33pgAmalqMkRdF0xEC9ScKbNI0Qo31Ul6sDaYYAo+vtzIPfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd6iu2ym; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd6iu2ym"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so19476735e9.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749289540; x=1749894340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CFZm5iw+belZ0VJqb5KBpBIp+d4jF7wl7eNKvcKMYi8=;
        b=dd6iu2ymldtJn+f9ilvwel1KV+1echp45mylliuQ/jRccoNRq3UY6o9fn7S/S4gKU1
         WIn4OqcncsOdTDxDDzhUSg2Xsfc1K2Nu4p8MDsE1ZOmIV51YutaNE37uVsEy/K4G+H3S
         PebX5aP/7HgTDnPID4I2FCr0iV91+ZCtbWV+Oh9QbThE4Nrq7S46DucJH1RjB3vzhR3o
         qE3Z6gi/fJJPDGRXSLNvh/Je2au37wIYRyieCPWKgvSH3h82Ild4sNqTbFji6qVMEoD5
         rWtrJIB/sb6m+JMLX7mTyOiMPXBBVVMx1+x7y4g6mBFe9P5hC7yomOIYkqqC1CZ1q+GQ
         udQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749289540; x=1749894340;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFZm5iw+belZ0VJqb5KBpBIp+d4jF7wl7eNKvcKMYi8=;
        b=a2y4tHhVNG/8mVCuS1FCn2LYSlCtBtUFBRTVzKwZRDvaEXTo0JhE6EJiqxjHNWQrXf
         lPTi/tXud8eb9yNGm4Y8Ugv0hfBYFfgf5iFWO91/3ZTDN9/Tz/OIsFXAzxlKZNcIuyN6
         FVmyQx/dzT6OozVH7bYqnbcLJsJ+w2hESBIfAE8giwWmTDC3Y+9TvOoTlk/f6uMQvSAG
         piqT0U5J9eUfT1utvuNXAVUy5IBC724l3wZJKzZstLgJPGvtQVNuYOOCGpETphnxdhqw
         9/Bzsr/gBTdbHcBKiTTP3Uu++M8vlbSCeb6nQTKt2h2tJ+7/yekd8Sn6kmR+X2f9SeNL
         J8Hg==
X-Gm-Message-State: AOJu0YwdGU08FpA1eOOEhfRblfozGZtEv8Mk6iC9UQuOX3o2l3t+Zava
	pb4VNBohA10CEhtIw55hXRn66F8/I4V9VQ8shUy5Jeki4EWAGdanxa+VIo+1lw==
X-Gm-Gg: ASbGnctbGzA37JkShQrUg0sAqUEB7c9HovLgul60eKfpAV+xpz7hnnjiBH41xcdNhyB
	tRG13xpGb7VCljkXoUBzwMmRs8xF/VCsWeA3ys/LmTZ4FUmpHsyL+531oq3J7j6jLjfVqaJjBDu
	1bLH33gGRtuVwiUjGNSq/Cwg4Er1gEohqNcRP2BtvD2RcmuLoOwcV/cPCUHChCXn5YhKaMLRsq0
	swGDnTZqnfoinIQ5PyDCXT4Syh6x/d1OEg+4FuthpP7yMmbZNf5pox5BsNX/8MAYexBZ6WUFkG1
	yIajlTeo917X0ApG2/zXIa4Ojx2a3ivcDxs2+Y6/5Nq2lP0yDTtiX8g5dO4K1LF2I09cH1G9dCw
	XpQ==
X-Google-Smtp-Source: AGHT+IHCpi7KoqSkrbsFbIPm+4QuQF+3GUhtFqftrzPyLXr0Azjc+AgyGvi67uLT7dQU/8PLx2wKtA==
X-Received: by 2002:a05:600c:3849:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-452013ec612mr74168915e9.30.1749289540069;
        Sat, 07 Jun 2025 02:45:40 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c7761sm48351795e9.32.2025.06.07.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 02:45:39 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/2] stash: allow "git stash -p <pathspec>" to assume push again
Date: Sat,  7 Jun 2025 10:45:25 +0100
Message-ID: <c147eaf2eaec6ed4e46f3f34bc864cbf8ecb8e45.1749289514.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1749289514.git.phillip.wood@dunelm.org.uk>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk> <cover.1749289514.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c  |  2 +-
 t/t3903-stash.sh | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

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
index 74666ff3e4b..a99a746221e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1177,6 +1177,28 @@ test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	test_path_is_file bar
 '
 
+test_expect_success 'stash -p <pathspec> stash and restores the file' '
+	test_write_lines b c >file &&
+	git commit -m "add a few lines" file &&
+	test_write_lines a b c d >file &&
+	test_write_lines b c d >expect-file &&
+	echo changed-other-file >other-file &&
+	test_write_lines s y n | git stash -p file &&
+	test_cmp expect-file file &&
+	echo changed-other-file >expect &&
+	test_cmp expect other-file &&
+	git checkout HEAD -- file &&
+	git stash pop &&
+	test_cmp expect other-file &&
+	test_write_lines a b c >expect &&
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

