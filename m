Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC3441612
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450500; cv=none; b=PLCMysx9BfOhG32FdpTY81LC0i9byXdrZ5GM96s4uw9tt7D6UoUsmzMaxcPxLynXhnTYxYh2ilbYOnM6Smuni3RWE+dav74pHxqkXfwjJN4TPsD9Vb5NmxltyStzQGBKrEJxdUa/cuI3Iqu24rNK66G7NyOCerzwOWREoE8/BYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450500; c=relaxed/simple;
	bh=J+jDwEemeLpVeY5wbqnfTOQ6eslGzypwJLb1mIXsSSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AM6sbsFXrWGkVoDF+aIBYC5Hd7eT6PpABlZjbHra3QrBaV1x/Wkdqguusird2vy9vIROPc2kvmTTAOMC6GYwaAh3K9hr+F3TG8oJ/UjcQU7/5IQKih5PrnIG9+pcBYEC9oNp8wKVkawcfvlMv/eNaHI8fqF8QTh4xU7F1Hxruyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSZ/OiGS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSZ/OiGS"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47de0093c42so2170420f8f.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786450497; x=1787055297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2tKAC7GtCOMpGQyLnNyJ6LiOBS1c1suC/XDv632/jU=;
        b=bSZ/OiGSO+yyzxFSMVh1OW280KD164aYMqgxFxB/uNZXe2J9bvDt/m1VmOcEE5IXbm
         K4MAc8BL0VRdrNaQYluGtgTj8T1jK9BvQP0uzrxunYnDCSDp5hfzWHuiS+NyXZSfL/FO
         +7F2Jr7hNteFwcoB+Gc9GIF57GuoWVXie5gogkmG2+d69PqrYM0MwZ/7RVNmjriD8dUq
         WKqxTQS32EzcZ2zUsWumFSGpNW8HBDQjCgEPEgarxksbxTfhqSCrc2wwd4zsdHlVi16H
         ao9LFIeR5z/guGguDl/m4c1/kp5c3dw0Ujo6TcjeIwZMaK7bBVbQGnOQRNQNRBnYGoRx
         q6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786450497; x=1787055297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2tKAC7GtCOMpGQyLnNyJ6LiOBS1c1suC/XDv632/jU=;
        b=eLLRpLuP+S7RbnKbt3nxALoupyVWxWs6XTDnH4XBdbp2CPL+TSGjePg4MC7JJ6sAb3
         jJwUfdM4JmkCBUtJWw0q/kGR2kgO75pfQNbB1iv2L66CjGMINhgCGe5X1LBYPwVHepeY
         hRYshJSmqtY4b9bNa1MfItnX3kqa9TqvYOBUVeCaA6RFJrSoce8q4U0Yfx2O98C5yP69
         Jza50vlBEoXjLlpQty52Q127cjx3O0TAcmZKhUY0b9VBR1AWjkncjKxD9A55UoLeG0zc
         fcfKAYz94aZua4FAN0qGRNUsUrpoYIIn27JQ/LeDzubWM7a9F8vhuW27ozzHV35C3SIh
         n1bA==
X-Gm-Message-State: AOJu0YwyYICoO3oS/2LtEi2k0TUF6oX51A/Yaif0NyXiU9KlflA3okQX
	Z/12pfHNt4FvuA2VwgqLRlivAlbeWpxfLzW5hh2LMrce4CCv40bBKTrjV3ibZA==
X-Gm-Gg: AR+sD10ev2mSBIrgP52s/pe/TUXecGQglgUf7IVjhyTZThqvYZCQJV5//DVBY/Wrc5z
	algAMI5hT4HIJ5BMIlGAYcYPc5JWuSejrI/DfiF9cYbTfwe2U8e6M4nrzBroK33wd+UVyWo4q+k
	aeZ5b/iv5rDKvtlcJJPJoArC8go3bR0HDEJXN3v3Xdl5tC74lTy1HyXNMRyWf3rWEdV93qXmlj4
	OEqhHyJuaLpYyjBcWqkzym6HsCsig6CeFq/be2vw6swOWcuB2QgD5b0p0JlEAiSnO5wBUUPdGWc
	mSZvkR0JGwdnClQMpkTUrt+qpG6E2gW2UxCGz4E8XZg4EUTfzEHewt4kEHxX9p2s54eQVVoVMgs
	G7eixtOr8k3kJ6UGhZ6bLzZTi6jZIeFFpKR8RoPrVs2p1bq+paYtQPteDkZsYdWYgwHR25g0MBm
	4ErQQKoiwXQjPutCiYkEFT083VWkSus5uzZjE6mHz985nvMIf/ObfQ90fGdjAA8XULKmof5nINc
	w8OtSrK2qiPGFMHBx0LMZqdq9/Om8+11ouY5LsaxltI8jq5XeWKbLjYssxKLIIDsQSbCbXyBf7+
	AbN1qoJELH+u0Q==
X-Received: by 2002:a05:6000:401f:b0:47f:c648:e274 with SMTP id ffacd0b85a97d-4814ad82dd9mr4679594f8f.5.1786450496590;
        Tue, 11 Aug 2026 05:14:56 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:d4af:d54e:6668:f481:32d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cea1sm4553257f8f.37.2026.08.11.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 05:14:55 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] git: avoid segfault on "git --shallow-file" without a value
Date: Tue, 11 Aug 2026 14:14:46 +0200
Message-ID: <20260811121446.2080190-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.540.g010afd3166
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "git.c", the other `handle_options()` options that take their value
as a separate argument, like `--git-dir`, `--namespace` or `-C`, check
that such an argument actually exists before using it, and error out
with a message and the usage string otherwise.

The `--shallow-file` option doesn't perform that check. It blindly
advances past the option and then dereferences the next element of
`argv`, which is the NULL terminator when no value was given. So
`git --shallow-file` segfaults:

  $ git --shallow-file
  Segmentation fault (core dumped)

Let's fix that by checking that a value was given, in the same way and
with a message worded like the ones the other options use.

While at it, let's also set the environment variable before advancing
past the option, instead of advancing first and using `(*argv)[0]`, so
that this option looks like the other ones.

Note that all the in-tree callers passing `--shallow-file` to a `git`
subprocess always pass a value after it, so they are not affected. In
`upload-pack.c` that value is an empty string, which is still accepted.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---

While working on modernizing `git fast-import`, I noticed that
`--shallow-file` was handled differently than the other options that
take an argument in "git.c", and found this segfault.

I have started working on a better way to handle such options not only
in "git.c" but also in other files. For now though, I think a small
localized bugfix like this is the simplest solution.

Not sure if "t0041-usage.sh" is the best place for testing this, but I
couldn't find a dedicated one.

CI tests all pass, see:

https://github.com/chriscool/git/actions/runs/31478034826

 git.c            | 10 +++++++---
 t/t0041-usage.sh |  7 +++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index e5f1811b6b..96df15b5cd 100644
--- a/git.c
+++ b/git.c
@@ -304,11 +304,15 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--shallow-file")) {
-			(*argv)++;
-			(*argc)--;
-			setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], 1);
+			if (*argc < 2) {
+				fprintf(stderr, _("no file given for '%s' option\n" ), "--shallow-file");
+				usage(git_usage_string);
+			}
+			setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[1], 1);
 			if (envchanged)
 				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
 				fprintf(stderr, _("no directory given for '%s' option\n" ), "-C");
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 51af7cc030..2a9c5eafca 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -107,4 +107,11 @@ test_expect_success 'for-each-ref usage error' '
 	test_grep "usage" actual.err
 '
 
+test_expect_success 'git --shallow-file without a value' '
+	test_must_fail git --shallow-file >actual 2>actual.err &&
+	test_line_count = 0 actual &&
+	test_grep "no file given for " actual.err &&
+	test_grep "usage" actual.err
+'
+
 test_done
-- 
2.55.0.530.gdb3615d990.dirty

