Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96FB640
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929946; cv=none; b=orRcYxwFenFkDQicOProSqIRtdQY/PKAem/911iIAr5O0zqBoT0dk2hVL6ODHoIXaqAkmQFrJWOg7p5jIgVknDdTgls7mzCu/urKrsJ1m+XO1MRqpBZodKVek66sOEzwVBv9Uy6vgCP0tjpbWh1h0SksC82ZWwtldRUbSYHNhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929946; c=relaxed/simple;
	bh=H9tDeeN652Xu7Cza580K6C8PnHs4HRD9oTxu+UWsxLo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Dx72AuYo0qQTyeAK0tn5jFeHY3ywT+BOsFgO4rn1MfuFpsp+bDZcjje0oOr+F2WGe52gmOqjxfNRaeVtuxTSDCgA3q46XGL/8PeYT3paLCdqOD6LTzgyy1Hihv9F9SlctrfQbNP2Hf38k743REglQNZ9UheXI4133wVT45dmoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJy/A2tP; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJy/A2tP"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88fe44cce7eso31409406d6.3
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 19:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767929943; x=1768534743; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8QzEy4OlSiWo/RgT0Nid1Lns/8d5vyuMWupwBwrhAYI=;
        b=HJy/A2tPP8GFX+8X8r9VpwAvtcrLp1QC+kQvxPD0/N9SgfC0k1QN50IsuCWIs6VGSK
         Djj7TBijEhfPS09rHkQFmBgBmAoWL4atrZjBmogFee41quXJtxIqziro8+3+U6gsf3aK
         +c0Qp7jIjlfUkNMeaqQEFRkpq458csDAX8ocpwmPjFAZ5n9w3jTrVZLnvVNbf8rTAv8s
         jtzM6zO55fcbclu9iv4eKbXHSu2fQvYcYsNRTopfjJnlFf8DCiwezXt+Q4DDZIVHhP05
         pjr/3GV6OUAC9xZVKqDVM7asrBERQPWXZG3/B/7UFa23uwny5soN9EkFWC4y+c3JFt7c
         IyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767929943; x=1768534743;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QzEy4OlSiWo/RgT0Nid1Lns/8d5vyuMWupwBwrhAYI=;
        b=bTAHieA6KPTvTt2YBHI92k61j3l1vv8vsUU9C/X9yQbQrJpGoKMm94CPF1RsXxhOTj
         HbUlG6JtmcCJyHk6Ga1y/+oHbxV11RVGC76NL+KAbU/85h799bk5E7ShKIIZE+Y0/dqR
         hNGahThm2OcJzCE+upjTZecDiF06qqHT1TzNL54CXn4+4xDx5s79ANXPjYfZu6x5zmaN
         4p5ddULKd/QOeOYnmpeaeIQE2GNfvZqAf6Wry24be1fUOZwU3Xtzs8l3FnOvStpjpbwx
         JZMZwYzpiaYU5pze9gxTYorE6i55bxwxBtWcVBTXVxcIF7quLKtwZIjDLjf1zP5Lj2r/
         MR9A==
X-Gm-Message-State: AOJu0YzL9l/EMb1flf5ejEMhalq25db2q9MeA152l7TCmUmSWPFiJNrv
	20zyMBCq7Jmx74oCotzaLeggr4wof9B3QUTOVTEjzexDQAcpw1h5y6xF8AVI87g/
X-Gm-Gg: AY/fxX63fK7zoNR+GTjZO/KqCwXSt49DAlRTifhiyLapjdLfvMouA9+uruBiSgW7ylA
	4D6efb7I/UMbZealMWj7cYFjkKYAhgV78UOUN8dsg2fezo7QqtTDI778eDfOSHdW8e62ac3LOUo
	bokAzy/wFFHDxrOMSdUctJPhJYF2NOsYioat72+nYRsVfzGvR9vGPSBjAcpj7+deFjLUYMAwXqk
	kYFs/MfTvPRrmp0Sdr1FXOLYLWoiTWROLOTQBfB9ey/xYWh+OwThZRYTqlp0zgwpXTavu2tbgaH
	6mP2lTUzigQvL5VCQGsw87pLK5IFhrW8EbK6nGLrgxKh2X8dLK6GOZvSTtOc/Syuur9u4bCSoby
	MwLKtCReMLIRef+y2btdtm8r1hpPiYt8ld261KMtfYjjCs43VvNGMZ9bmKoPUL/sAH5nRc5ewLr
	MCMH64KX0YHQVQpQ==
X-Google-Smtp-Source: AGHT+IE1AhPDrH9DNv13LAP/H0v5a2mV3iLWwdfanK8Le96/+eEmuMdW2MeuTeZ6aZ0IU6NXvOFseg==
X-Received: by 2002:a05:6214:3bc2:b0:88a:2500:7d45 with SMTP id 6a1803df08f44-890842a20e4mr119563156d6.46.1767929942983;
        Thu, 08 Jan 2026 19:39:02 -0800 (PST)
Received: from [127.0.0.1] ([135.232.232.16])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772674fdsm73148766d6.47.2026.01.08.19.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:39:02 -0800 (PST)
Message-Id: <pull.2028.git.1767929941577.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 03:39:01 +0000
Subject: [PATCH] builtin.h: update documentation
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The documentation for the builtin API was moved from the technical
documentation and into a comment in builtin.h by ec14d4ecb5 (builtin.h: take
over documentation from api-builtin.txt, 2017-08-02). This documentation
wasn't updated as part of the major overhaul to include a repository struct
in 9b1cb5070f (builtin: add a repository parameter for builtin functions,
2024-09-13).

There was a brief update regarding the move from *.txt to *.adoc by
e8015223c7 (builtin.h: *.txt -> *.adoc fixes, 2025-03-03).

I noticed that there was quite a bit missing from the old documentation,
which is still visible on git-scm.com [1].

[1] https://github.com/git/git-scm.com/issues/2124

This change updates the documentation in the following ways:

 1. Updates the cmd_foo() prototype to include a repository.
 2. Adds some newlines to have uniformity in the list of flags.
 3. Adds a description of the NO_PARSEOPT flag.
 4. Describes the tests that perform checks on all builtins, which may trip
    up a contributor working on a new builtin.

I double-checked these instructions against a toy example in my local branch
to be sure that it was complete.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    builtin.h: update documentation
    
    This is motivated by curiosity and thinking about how to train a new
    contributor on how to create a new builtin. So I found the api-builtin
    docs on the web page and found them grossly out of date, but was glad to
    see some updates in this comment version.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2028%2Fderrickstolee%2Fapi-builtin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2028/derrickstolee/api-builtin-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2028

 builtin.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin.h b/builtin.h
index 1b35565fbd..e5e16ecaa6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -17,7 +17,8 @@
  * . Define the implementation of the built-in command `foo` with
  *   signature:
  *
- *	int cmd_foo(int argc, const char **argv, const char *prefix);
+ *	int cmd_foo(int argc, const char **argv,
+ *		    const char *prefix, struct repository *repo);
  *
  * . Add the external declaration for the function to `builtin.h`.
  *
@@ -29,12 +30,14 @@
  * where options is the bitwise-or of:
  *
  * `RUN_SETUP`:
+ *
  *	If there is not a Git directory to work on, abort.  If there
  *	is a work tree, chdir to the top of it if the command was
  *	invoked in a subdirectory.  If there is no work tree, no
  *	chdir() is done.
  *
  * `RUN_SETUP_GENTLY`:
+ *
  *	If there is a Git directory, chdir as per RUN_SETUP, otherwise,
  *	don't chdir anywhere.
  *
@@ -57,6 +60,12 @@
  *	more informed decision, e.g., by ignoring `pager.<cmd>` for
  *	certain subcommands.
  *
+ * `NO_PARSEOPT`:
+ *
+ *	Most Git builtins use the parseopt library for parsing options.
+ *	This flag indicates that a custom parser is used and thus the
+ *	builtin would not appear in 'git --list-cmds=parseopt'.
+ *
  * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
  *
  * Additionally, if `foo` is a new command, there are 4 more things to do:
@@ -69,6 +78,21 @@
  *
  * . Add an entry for `/git-foo` to `.gitignore`.
  *
+ * As you work on implementing your builtin, be mindful that the
+ * following tests will check different aspects of the builtin's
+ * readiness and adherence to matching the documentation:
+ *
+ * * t0012-help.sh checks that the builtin can handle -h, which comes
+ *   automatically with the parseopt API.
+ *
+ * * t0450-txt-doc-vs-help.sh checks that the -h help output matches the
+ *   SYNOPSIS in the documentation for the builtin.
+ *
+ * * t1517-outside-repo.sh checks that the builtin can handle -h when
+ *   run outside of the context of a repository. Note that this test
+ *   requires that the usage has a space after the builtin name, so some
+ *   minimum description of options is required.
+ *
  *
  * How a built-in is called
  * ------------------------

base-commit: d529f3a197364881746f558e5652f0236131eb86
-- 
gitgitgadget
