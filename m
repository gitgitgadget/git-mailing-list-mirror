Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F662323E
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749353266; cv=none; b=jh2p7NWNC6vpAc9DtS7mAavaJUShn8cR3vhUI+/eHlh9AeS5RphrFyA7t1whp+wrPlfIFK3fOMN+xWWbqpxovD2Jidpej6w6CeP3N+lrHl+m8l8WT5MgkjJ5cW6tZj3Z5Dnzl6z3C99qsHJAoEFpK/bG4JgnPR7OJCWHXwvXIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749353266; c=relaxed/simple;
	bh=q8Akl121jmS7kRg2XglobppyvbiAT8s3aasTDTjXw8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMjH4S/lkTs1Hv1LxGu7txj6r9UWbDaHVXnj2AYXUNweu6oChiy0hBY62oHnX5f9gv8diCZHWzfJTZUa55PMPYgt6FEL1D90G3jhaOH1vTDZVxtVTwZVl18tBDLImToK5bS8xqchAKcG+cjXTkCLbT/75U+0KzT9O6YyqVwr65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlyMD4Cf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlyMD4Cf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso2366541a91.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 20:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749353263; x=1749958063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn4c4PCmDJMUg85HGnleFtljhV+IX89IZGFP+BD/+28=;
        b=dlyMD4Cf4LtXSD9pC732AD2LbXDNcrOfl9uCW3UOxja3sWc/SlM+7HFZw8+LvElwY3
         /1qgo3sjVlbC1QyVZ7DvNdO09V+BnYE6mlQQ0xwcR2OzJ7OwG8DLWzbmzFYt0mlx3kcL
         3j8YiC8loS8zGWYH1BdlC0x1s6xu9qXSmWKf+JCIafDXPB92hgNQVAQOSg/Gt7y6fVse
         wFnku3xjlhncPd7+KuHggr9Iw3o/sRNlnIWfsv1ndGJ9n5jzb43xW3zFTb1bkixk2uY5
         gvsYS0jWkmyjvmskvmobQhga5Re9oB/Rrn0fnu71YmxiwwNjFgqAt+EoihxwfUAQds+1
         +XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749353263; x=1749958063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn4c4PCmDJMUg85HGnleFtljhV+IX89IZGFP+BD/+28=;
        b=ZJ81mIVj9E92x6+VttIuFCgljf1C/YQCmarHVYRslv177M2HuJm3hIVS1vldkLzxC2
         uVON+fx2OcovLdPLPPpHukfUMeFhIke9ITSSlC66klup/MfosrBr5z2DbdvUeF9z6oXQ
         2yvEo3Jmpe7FNfEqCXuu0wHndwoOfpAsAyg8dHczNCAxFBW65tNQDloS4CzL9rz4K3Ta
         FFAR8fq0j4tW+xa0p0DoTLP07i+y/eg29mWGVLlYd2hEiai/aCajD8fKx4t2hduy2TPV
         eiPp6HXI98IvhobDDK7jTcmIzICmfiRHk0I6Nqlai3T8xZTLMpRyPLAnhdDxkFjpaV5U
         WwqA==
X-Gm-Message-State: AOJu0YyC0jQnLgNqtp6uINuKgBHhbCvzZuJ4GSaobOLg0/+C8yZWTZkn
	0Cx8J41O7P6Bck7l5DG3zdVg/Ust3NhMlkbOfRusY6hgCfWiAy2qiQaKwy5betZG
X-Gm-Gg: ASbGncvxJeSQEw8MJr9ho+odzEDgatqwXttK4m7xb+7Cg8YOjkv4pdoTEJBZQ8MI8p4
	IM5879M/qcp7taM/jWI4s0Ku9u0CIkhpyiDG7j6FJgT5dRl1HQIFvMIkpoxEv9UdD+bgkDf4ylL
	A9UaXxwVaWnBOlJxScWgrcsOQ3jsRN3fILmxiXpEOARqSsOh87HyT/VZ+3z1jUf+id7bcfLbvJv
	ijwtW8/gbwJfrJtAxcUwsBg/c/NPF6Ug80f57SO8ebp5eqW+dAUM8vuFKbSOQw0IOTwWyX7mMLB
	hlejsWYKUMrySGvLH2M9KIUNkzMg5xphaJfLBP3E+FxjMZwGBe2a1KCdOFyzP9SRfgo=
X-Google-Smtp-Source: AGHT+IGKjNiwkoHEcGhBdnVTUqbOts43EsXOlo03ydcM0XAYDzkaYsn5RIycI8VTABDVtYeGCI9mJA==
X-Received: by 2002:a17:90b:5345:b0:311:ffe8:20e9 with SMTP id 98e67ed59e1d1-31347308c79mr14151425a91.17.1749353262512;
        Sat, 07 Jun 2025 20:27:42 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405189sm33442095ad.148.2025.06.07.20.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 20:27:42 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v8 1/2] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Sun,  8 Jun 2025 08:57:04 +0530
Message-ID: <20250608032705.11990-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
 <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a submodule at a path that previously hosted another submodule
(e.g., 'child') reuses the submodule name derived from the path. If the
original submodule was only moved (e.g., to 'child_old') and not renamed,
this silently overwrites its configuration in .gitmodules.

This behavior loses user configuration and causes confusion when the
original submodule is expected to remain intact. It assumes that the
path-derived name is always safe to reuse, even though the name might
still be in use elsewhere in the repository.

Teach `module_add()` to check if the computed submodule name already
exists in the repository's submodule config, and if so, refuse the
operation unless the user explicitly renames or uses force to auto increment.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..9f6df833f0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3444,6 +3444,10 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
+	const struct submodule *existing;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3561,6 +3588,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..f5514decab 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m init &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m init &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		# Now adding a *new* repo at the old name must fail
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m init &&
+		test_must_fail git submodule add ../child2-origin child
+	)
+'
+
+
 test_done
-- 
2.49.GIT

