Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EB1EA8F
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444790; cv=none; b=S7qomdat4tsGlYF39I3EIUwLxpFnHvKOFn179fAyHktjTQ/FnIeP2BzMTq6Y5aL0G+NgZd0ncjsCmXxIm7o4LN270325rFGipfkN5kuqbwx1GgGEKiCDqzkPHyiPqfyw8AhVe3VuDLmnJBjsrtvSBijULwDf/TBMeeb6YNw5nAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444790; c=relaxed/simple;
	bh=VsGHR8JtejI7RaY8DH3G2Y7dWmb8cTypEBG1Tg2oyrc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fnEF/4jx3P/Eo6dbHzWUUFwy3+uebm5yrG25K/M1G7MpAf8ZOSktdZkIdls1oloTl7X6lcpfO48N1AnSnMUNUjDayS3t8fGyQHXIsf+TDOyBfKUvKKxFJDZo44rsZGovEi0tiY1VkhZfVHgQ9MABg1fqjrZ6hJF2B4fCHOuDWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgrcOqoR; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgrcOqoR"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56fffd131a8so453005a12.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713444786; x=1714049586; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODihVaPj5F0eweDxdKUPKi7wdgyWNVhw2FmSRq2BG/s=;
        b=kgrcOqoRGue3ZCos2RSzNj928AYcNGC9qrMLN5STKl6JsRDk6OLuoL0zwiflNR8ljf
         ddulHQTSxkLVfzOUOtlwWdvChDXzDvfT7kc5N3B4q0/QSZaUwTjVtxdoIXalUJqLUbQl
         zt0Txac5j0/S9Xp1LhPU4aXKnLBwFHXeZXcFW3432PTiZzaRkV+6g1GzUXsg1y9mdDrm
         kbOT8HK2fB+9Nn9G2DkBjQlE6Ty2ggdml02APhmcGcl6taGBqhRRu7qQoS0TJTeB4Ge1
         NBKc2emSCgzjcMY97THxSgdhsH0NPMtZbmaJccqMosH5GCET9LMb2bzFvW64QzUEGJIw
         e94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444786; x=1714049586;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODihVaPj5F0eweDxdKUPKi7wdgyWNVhw2FmSRq2BG/s=;
        b=ST3whuNvgE2NUBKhDPI+Mep9vKpXPCWLxa3hZeV4U7L9cGWyicRgvebwddUIKlksc9
         DfJoFQO/7N3Qcn60Hq44y45zlAiE2e2x7Fo4yaa5f8odZgQ07+vOtg1X3fyHTzebwFwR
         QxUDSnrR/vH/IEv0v0l7P/BzN4akKgeGkkrLevgSSXONKhUxThmfWTGNnASGWUNHz82A
         Rm3X90azVukt6TpO0r5W5r/W4YzO8rU2w4/43LkHDTNmz/EBt2bLxzW0fYhReDTczjQH
         D8b5UKvCcjQ/VDvjWQ0VJQITI1NX38tuV19DByc9JmFb0aubN4dmTXBwhUJg7OYhedv1
         sajg==
X-Gm-Message-State: AOJu0Yxwr6VR3TbNdltkRwnGb2+PauzuU+hvdScATiAGkyNkj+m2eK9y
	eJnkKIZaeIYUKmAUAKeKQOFAoI79ubOny2IJ7KSdKXVOekgzDpvh4SRZ5g==
X-Google-Smtp-Source: AGHT+IFP266awjWlFTY4y1tg6Yya2pJlKW1PIe0KFVoVTCUaVxkj0xKzUIFMVWhC/WqijKuzVrtxIQ==
X-Received: by 2002:a50:bb08:0:b0:568:a655:49c6 with SMTP id y8-20020a50bb08000000b00568a65549c6mr2323984ede.8.1713444786239;
        Thu, 18 Apr 2024 05:53:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25-20020a056402049900b005700ef75274sm841046edv.33.2024.04.18.05.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:53:05 -0700 (PDT)
Message-Id: <abd796894c857fc9ad96b9942089474df01f0506.1713444783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
	<pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 12:53:02 +0000
Subject: [PATCH v2 1/2] for-each-repo: optionally keep going on an error
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/microsoft/git/issues/623, it was reported that
the regularly scheduled maintenance stops if one repo in the middle of
the list was found to be missing.

This is undesirable, and points out a gap in the design of `git
for-each-repo`: We need a mode where that command does not stop on an
error, but continues to try running the specified command with the other
repositories.

Imitating the `--keep-going` option of GNU make, this commit teaches
`for-each-repo` the same trick: to continue with the operation on all
the remaining repositories in case there was a problem with one
repository, still setting the exit code to indicate an error occurred.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-for-each-repo.txt |  4 ++++
 builtin/for-each-repo.c             |  8 ++++++--
 t/t0068-for-each-repo.sh            | 16 ++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
index 94bd19da263..8c18001d825 100644
--- a/Documentation/git-for-each-repo.txt
+++ b/Documentation/git-for-each-repo.txt
@@ -42,6 +42,10 @@ These config values are loaded from system, global, and local Git config,
 as available. If `git for-each-repo` is run in a directory that is not a
 Git repository, then only the system and global config is used.
 
+--keep-going::
+	Continue with the remaining repositories if the command failed
+	on a repository. The exit code will still indicate that the
+	overall operation was not successful.
 
 SUBPROCESS BEHAVIOR
 -------------------
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 28186b30f54..9bdf2b34f89 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -32,6 +32,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
+	int keep_going = 0;
 	int i, result = 0;
 	const struct string_list *values;
 	int err;
@@ -39,6 +40,8 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
 			   N_("config key storing a list of repository paths")),
+		OPT_BOOL(0, "keep-going", &keep_going,
+			 N_("keep going even if command fails in a repository")),
 		OPT_END()
 	};
 
@@ -55,8 +58,9 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	else if (err)
 		return 0;
 
-	for (i = 0; !result && i < values->nr; i++)
-		result = run_command_on_repo(values->items[i].string, argc, argv);
+	for (i = 0; (keep_going || !result) && i < values->nr; i++)
+		if (run_command_on_repo(values->items[i].string, argc, argv))
+			result = 1;
 
 	return result;
 }
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 4b90b74d5d5..95019e01ed3 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -59,4 +59,20 @@ test_expect_success 'error on NULL value for config keys' '
 	test_cmp expect actual
 '
 
+test_expect_success '--keep-going' '
+	git config keep.going non-existing &&
+	git config --add keep.going . &&
+
+	test_must_fail git for-each-repo --config=keep.going \
+		-- branch >out 2>err &&
+	test_grep "cannot change to .*non-existing" err &&
+	test_must_be_empty out &&
+
+	test_must_fail git for-each-repo --config=keep.going --keep-going \
+		-- branch >out 2>err &&
+	test_grep "cannot change to .*non-existing" err &&
+	git branch >expect &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget

