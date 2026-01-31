Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451437B3E1
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769895813; cv=none; b=vCdVyndMLqg9Cvj30Jv3bav+532Jpv3pPfyi8cr0ZTT6HXT60nk7kkUCSyyqAk3rO7XOFKfJPSA/yoN2VEJyA8wfPpujeOChqf3Kp8QKSbDbyVe55EBWJxJ7SY+Qqsjxj5FSGHNu8SFjPgEoMhGZnXQXK/YoR7YvvJUs/RuuIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769895813; c=relaxed/simple;
	bh=BrIqx4hJ2KEN9TBWqu2c2A4A7y4Df0yEkqWneU4zycY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKaLcPyEZW+gByYni72/VbRPfz1ohOBt7cbssv9WPcu7IJ9r7/ciuV2FwcC4A2STq5L7yTmfGzmTp8WIXGYKBZW2xbdGQwVQODhjyuBJTbY/dWVOojFv+jvpXnBMD4WS0UYjqUAJdmrdmsr6Y7k5MO+XrP2EDPE6/UoQ6APFJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCjbPphx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCjbPphx"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014f383df6so23945761cf.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 13:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769895807; x=1770500607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/NAei6NiD8aGVM2HhNrNlPybTcB9fudMeF/F7WKPLk=;
        b=UCjbPphxb85gFvO9H4h8gfbSwG7Ig/650NR9i1leE5kYEIb+VS8yQq/xnAchCVahrF
         yuCAqB5p8BSQdWeV1MPpxAxObMg/kcd43AS7Dbn+Uo/TIelOW1WX8B0QI3hv2gAsXpFt
         vmLJmGFb10cib6rPOjui4bptIs9gw+3dRI5ydfMen9ct2t1YShkdFblvinapNc1mvwxf
         ICiRQUXHgsshiszonMpIFj+saeYLAKUZk8HuMM2j6JoiqDNbwTSq3ZdfU/ocNHiei8I2
         /v4axmj2S2ERcfji1mDOBN/fEXO652HiH5HVE8ECe6Bnb/ky3WVQYTu/rUXDrTSgAwM3
         3ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769895807; x=1770500607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/NAei6NiD8aGVM2HhNrNlPybTcB9fudMeF/F7WKPLk=;
        b=pNAR2gA94xcB/B8hVZqdORRqHijAkUtvqEe1O0sfJZajuoqt0wvVWaNkAUofwdkOzs
         wuwhrKiPcpeUICX/SjTBrWurcj7Wrv2J41jPVPsufqLkukEai1c0R2NCsfDurUKlIcTR
         SjDKzmOwbGd+iAwH+FIbell8Sen14TLKmBBMBYUNrWNYyQfDawG1AE/aOwhh41/YHtbS
         8zjPZolR0cet6X4P+9qSYjed22G8zJv6+gfScj4LBtziSLq48ARacNCs5qb9QRKmhtJe
         X32nfAa0kFtzexQHNorHjvE22ltX5g1zJpnB8ueu29SgvYcnHBo1EMA9UhNwAj51b/h8
         1cBg==
X-Gm-Message-State: AOJu0YysdvFdsXmmdmuHK9KWxNfW81JearwV3rwU+TP/9lVUbKu9aLyy
	//BZScxUkLFMLY6NDXWe9XydMhc+NpOerl3qKmTUfwZarqiLvU4ylpc2QG+wPmhv
X-Gm-Gg: AZuq6aJ1jezB01wuepeo3mY16DyfzOdPD/oTiyGYufE5hm6/ooW5bGObwr85OPjO4Db
	Zbz7CQ1sNO1aMT9OJjOS1Rf0tKynToWxUK373zTQEKDwDa6eIn8bCdpG309xjkp3OqlVvNhpvVW
	5Pk8AKmjiZk0Vw0+YpjdA+KqmjXL/8IG1AmyTo1D4ANdfYxs0WdcyZaK9XxXPgvZD+SX3YYJUZ2
	mly+R5WLGyRvjoxRaEJMEsyw3WlS7aiCj0qaUHgFWHzm4ZLqC1bjBfEeFs+gNOb8UNhg76jEEGy
	NSsrCzdboTsgdFEIZYQ+5jzuMsC3MCl2chwHh3lKIWkVuSbRUwFh3Yk7ZtTKszi2b8dTyCWPQqU
	Khyc7yPfFsvTu6m28DpKscLRPBD01FdYTuKHnbag2DRylJp/m3j8IvS1+e3z/LyL45CtVKTn/ip
	HRcCCApd08DSA=
X-Received: by 2002:ac8:7d0e:0:b0:4ed:8ab:e7aa with SMTP id d75a77b69052e-505d212f811mr91427141cf.11.1769895806767;
        Sat, 31 Jan 2026 13:43:26 -0800 (PST)
Received: from development.internal ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b99fcbsm965368785a.18.2026.01.31.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 13:43:24 -0800 (PST)
From: William Hatfield <whatfield.git@gmail.com>
To: git@vger.kernel.org
Cc: glencbz@gmail.com,
	avarab@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	William Hatfield <whatfield.git@gmail.com>
Subject: [PATCH 4/5] submodule: introduce reversive shorthand mode
Date: Sat, 31 Jan 2026 16:43:08 -0500
Message-ID: <20260131214309.1899376-5-whatfield.git@gmail.com>
X-Mailer: git-send-email 2.53.0-rc0
In-Reply-To: <20260131214309.1899376-1-whatfield.git@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add --reversive as a convenience shorthand that combines:
 - --recursive: process all nested submodules
 - --reverse-traversal: visit children before parents (post-order)
 - --append-superproject: run command in superproject after all submodules

This enables a single flag to achieve full post-order traversal from
the deepest submodules up to the superproject, which is useful for
build systems, cleanup scripts, or any operation that needs to process
dependencies before dependents.

Signed-off-by: William Hatfield <whatfield.git@gmail.com>
---
 builtin/submodule--helper.c    | 11 ++++++++++-
 git-submodule.sh               |  5 +++++
 t/t7425-submodule-reversion.sh |  6 +++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f6cba87a05..26365b397b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -432,6 +432,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
+	int reversive = 0;
 	struct option module_foreach_options[] = {
 		OPT__SUPER_PREFIX(&info.super_prefix),
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
@@ -441,10 +442,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 			 N_("traverse submodules in reverse order (post-order)")),
 		OPT_BOOL(0, "append-superproject", &info.append_superproject,
 			 N_("also run command in superproject after submodules")),
+		OPT_BOOL(0, "reversive", &reversive,
+			 N_("shorthand for --recursive --reverse-traversal --append-superproject")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--append-superproject] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--reverse-traversal] [--append-superproject] [--reversive] [--] <command>"),
 		NULL
 	};
 	int ret = 1;
@@ -452,6 +455,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
 			     git_submodule_helper_usage, 0);
 
+	if (reversive) {
+		info.recursive = 1;
+		info.reverse_traversal = 1;
+		info.append_superproject = 1;
+	}
+
 	if (module_list_compute(NULL, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 58682a287d..e1b81344f6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -179,6 +179,11 @@ cmd_foreach()
 		--append-superproject)
 			append_superproject=$1
 			;;
+		--reversive)
+			recursive=--recursive
+			reverse_traversal=--reverse-traversal
+			append_superproject=--append-superproject
+			;;
 		-*)
 			usage
 			;;
diff --git a/t/t7425-submodule-reversion.sh b/t/t7425-submodule-reversion.sh
index 7a6a54de15..88f61b0f06 100755
--- a/t/t7425-submodule-reversion.sh
+++ b/t/t7425-submodule-reversion.sh
@@ -231,14 +231,14 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '--reversive parses' '
+test_expect_success '--reversive parses' '
 	(
 		cd reversive/top &&
 		git submodule foreach --reversive "true"
 	)
 '
 
-test_expect_failure '--reversive runs' '
+test_expect_success '--reversive runs' '
 	(
 		cd reversive/top &&
 		git submodule --quiet foreach --reversive "echo \$displaypath"
@@ -261,7 +261,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure '--reversive stops on command failure' '
+test_expect_success '--reversive stops on command failure' '
 	(
 		cd reversive/top &&
 		git submodule foreach --reversive "true" &&
-- 
2.53.0-rc0

