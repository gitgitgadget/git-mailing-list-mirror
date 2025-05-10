Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED914901B
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902077; cv=none; b=f0/l8HPDNfVhV5kG4erobwTV7R22FjB3ZvA1PnKC+eenU+hOpIDk17L58/5pRJGsIZFKml6KHiQBRegV4+28Ba3jX1MctgzW/ruxnbi8TukoOV+WyyiXtnR+ocdnLVUuhA+VHjnH2RlldOsotEcGn0w6ZRcSU1M+JYMFkaLWQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902077; c=relaxed/simple;
	bh=NjyYOarFcqsFPantjLqPduuZ2mV0BIBV2RdTi6kF1ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k61U7XjLmLreNOI30Xm162iTTba4RGyV9r1k3L6rNiTcpy8kjFwfDG+P6LMqJd7z4oIE5vzJzpTx3PKQjmuXCAJyHXRL0hShmdAVoaVIOnxzwCWmCWk21skZLaQeNASxxd/TuBBgdxvGSZk36Os5hAgMd5kD5kPDe3L1sr2iVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkvT0ZVr; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkvT0ZVr"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e728cd7150dso2638458276.3
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902073; x=1747506873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkH4rbeTpV9KsoPcPR/OF7FU+ie1pZ66kjqUas/jPIE=;
        b=dkvT0ZVrIgUMr36l5vP1q7SD3YtJXHdsE2j/UPx+YZUnbLSebFE3ZWXzu6/zBto/6F
         DYF0qISlu/BIjW5aZ2Ieecjwil/VkdX1rhATgS6GlsD3xS3xa7oirp6Q159VvI40c2/s
         6VP0Zsc4bvqpBVhmh0SKnuGWKxPMfjy7bzpQjW0V1QvZv8eywPDk7RLMBdHzTwQkhTP1
         aBmRGbFhBaiSDUIOaq16BrInycwiLZXXgw3+rv+0AnucsWcZwGiwa/bhfBWWBP+LI+O0
         oywYmKq7Ico3cxinY7aV3mwIjy48AmxEIEKVj/HVGbfnYLBZfTqihHX5z8YZnVRr6D97
         +u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902073; x=1747506873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkH4rbeTpV9KsoPcPR/OF7FU+ie1pZ66kjqUas/jPIE=;
        b=LQ0pyiUz6tyhw3Px2REqnWAKWYCNrY77474MKnhOC8FFWdfy3AwLMgLf1p9ukU1Www
         EZJPkbbnVkbfLziQ/W37ItJOkOpgLRxUFnX8jo1NupjhfWMZzG2BPei50Z+AIduryeun
         JPt5xm8EKavu6eV+oE8Ks3fU1S1zh/IQEaS1FxU1PpIH2MDblSrU5N+MjX/MTxurqE47
         RdORQwHehs0RRarur8priUp01xvqt+ve+n7Vu8+jg4Mrp19ivL02VBJ934swmRhLTohO
         pTRnQt5ImU0KMWr+GpCJTAvIZc6Q7SOP231zQwho7c++gELMtzseNXPmK3K3C8QPkECz
         JoIQ==
X-Gm-Message-State: AOJu0Ywq0PnnxI5l2gIX3kBM4bimPUCev0f63NwS3/r5sTMU+AH1XszY
	SFhvyPGCTc+UXwGiYiz3pDupFvgH7Klc0OtxH1bsFauXsynpEGAZZ4TG7YF6
X-Gm-Gg: ASbGncuHDN9hJ/3yecn9oUX3k1zh7MGNO7H5E/zBzDRQdZT9TU4r/w6P0RNIiaU+QJn
	fM4/SolBJu617im4wvhmBiTT3ShwynDC5oSei9JXjvKl7YRT0lnO0/RtpkSPV/j42b4ryrd8Uzk
	NBdPT63GveCC64IEC8ilyMmLe05q04cUTghKb19ao4UG+wCgLTNhESmmVYxprbQKaetmIbeuYV5
	1Z43A4Z7gQ7X5coAG+0Mxnsg0f24arl4Bos592zzBObcyfIai+W/V5HEUGbyD53i8+VIEmbnioV
	KxaQLtuarIFpvDdqAPyYJFeSvrwkU9dgW2K0UM2cMpW0HK/sJN+5QsMF1u+3bXOkbsJ1u3Rt3KA
	YgKJsofZJC2NEA5TaWJYjMpp7
X-Google-Smtp-Source: AGHT+IEpezcVxm4z7RCRnFJSEP/4gB5Oasf1boK/JIgm7YC/LNJ2p9x7vAggngFv4pK+LKTFusesNg==
X-Received: by 2002:a05:6902:f07:b0:e78:eb00:baae with SMTP id 3f1490d57ef6-e78fdd46878mr7184615276.45.1746902073557;
        Sat, 10 May 2025 11:34:33 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:33 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Kyle Meyer <kyle@kyleam.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 4/9] stash: restore the index by default when breaking changes are enabled
Date: Sat, 10 May 2025 14:33:39 -0400
Message-ID: <20250510183358.36806-5-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This footgun is described in the previous commit to
Documentation/BreakingChanges.adoc; without --index, stash apply and
stash pop confusingly drop stashed index changes.

When compiling with breaking changes, instead restore the index unless
asked not to. Adjust both argument parsing and handling, as well as help
synopses. Don't forget to adjust the error message when application
fails to point to --no-index instead.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    Tests will follow in separate patches, as some changes are rather complicated.

 Documentation/git-stash.adoc |  6 ++++++
 builtin/stash.c              | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 1a5177f498..3b01f494a3 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -11,8 +11,14 @@ SYNOPSIS
 'git stash' list [<log-options>]
 'git stash' show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 'git stash' drop [-q | --quiet] [<stash>]
+ifndef::with-breaking-changes[]
 'git stash' pop [--index] [-q | --quiet] [<stash>]
 'git stash' apply [--index] [-q | --quiet] [<stash>]
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+'git stash' pop [--no-index] [-q | --quiet] [<stash>]
+'git stash' apply [--no-index] [-q | --quiet] [<stash>]
+endif::with-breaking-changes[]
 'git stash' branch <branchname> [<stash>]
 'git stash' [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
diff --git a/builtin/stash.c b/builtin/stash.c
index cfbd92852a..4ffa586d07 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -38,10 +38,17 @@
 	N_("git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]")
 #define BUILTIN_STASH_DROP_USAGE \
 	N_("git stash drop [-q | --quiet] [<stash>]")
+#ifdef WITH_BREAKING_CHANGES
+#define BUILTIN_STASH_POP_USAGE \
+	N_("git stash pop [--no-index] [-q | --quiet] [<stash>]")
+#define BUILTIN_STASH_APPLY_USAGE \
+	N_("git stash apply [--no-index] [-q | --quiet] [<stash>]")
+#else
 #define BUILTIN_STASH_POP_USAGE \
 	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
 #define BUILTIN_STASH_APPLY_USAGE \
 	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
+#endif /* WITH_BREAKING_CHANGES */
 #define BUILTIN_STASH_BRANCH_USAGE \
 	N_("git stash branch <branchname> [<stash>]")
 #define BUILTIN_STASH_STORE_USAGE \
@@ -562,8 +569,13 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 			ret = apply_cached(&out);
 			strbuf_release(&out);
 			if (ret)
+#ifdef WITH_BREAKING_CHANGES
+				return error(_("conflicts in index. "
+					       "Try with --no-index."));
+#else
 				return error(_("conflicts in index. "
 					       "Try without --index."));
+#endif /* WITH_BREAKING_CHANGES */
 
 			discard_index(the_repository->index);
 			repo_read_index(the_repository);
@@ -658,12 +670,21 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 {
 	int ret = -1;
 	int quiet = 0;
+#ifdef WITH_BREAKING_CHANGES
+	int no_index = 0;
+#else
 	int index = 0;
+#endif /* WITH_BREAKING_CHANGES */
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+#ifdef WITH_BREAKING_CHANGES
+		OPT_BOOL(0, "no-index", &no_index,
+			 N_("do not attempt to recreate the index")),
+#else
 		OPT_BOOL(0, "index", &index,
 			 N_("attempt to recreate the index")),
+#endif /* WITH_BREAKING_CHANGES */
 		OPT_END()
 	};
 
@@ -673,7 +694,11 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info(&info, argc, argv))
 		goto cleanup;
 
+#ifdef WITH_BREAKING_CHANGES
+	ret = do_apply_stash(prefix, &info, !no_index, quiet);
+#else
 	ret = do_apply_stash(prefix, &info, index, quiet);
+#endif /* WITH_BREAKING_CHANGES */
 cleanup:
 	free_stash_info(&info);
 	return ret;
@@ -755,13 +780,22 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 		     struct repository *repo UNUSED)
 {
 	int ret = -1;
+#ifdef WITH_BREAKING_CHANGES
+	int no_index = 0;
+#else
 	int index = 0;
+#endif /* WITH_BREAKING_CHANGES */
 	int quiet = 0;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+#ifdef WITH_BREAKING_CHANGES
+		OPT_BOOL(0, "no-index", &no_index,
+			 N_("do not attempt to recreate the index")),
+#else
 		OPT_BOOL(0, "index", &index,
 			 N_("attempt to recreate the index")),
+#endif /* WITH_BREAKING_CHANGES */
 		OPT_END()
 	};
 
@@ -771,7 +805,11 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info_assert(&info, argc, argv))
 		goto cleanup;
 
+#ifdef WITH_BREAKING_CHANGES
+	if ((ret = do_apply_stash(prefix, &info, !no_index, quiet)))
+#else
 	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
+#endif /* WITH_BREAKING_CHANGES */
 		printf_ln(_("The stash entry is kept in case "
 			    "you need it again."));
 	else
-- 
2.48.1

