Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF83CCFC1
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242390; cv=none; b=lXI9LnJ5eihJB+EpjIMUCb6ap+WMZning/Ta49QzLgctH4LPinxUk/ekeU0qjn5VCR1oom9QcuYUnUO9/rcdTARA+Nnf8nqjCdkWwSVA+ev3gv7aEpsCeK2JGjRBuzg+9XgJjlgy44Z/L7iUhtDcoe2ZOa7qoeYILp4a2g4fVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242390; c=relaxed/simple;
	bh=3C5pw9r5hpb7l0B3EsV7s8y6itEmR2RPR5Sn+rLu1FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvDnLcnEzsNp1nww5jghM8zE51+No3zXsud5uXflPWpU+23X2NlkdulXwi1BIxp9hLe5C8Mx4i55+/o9SSa9fSk3ZItGRzuzMVs8tOkg5fbF81SBldjGSuGwPlPy9Yp3WW4m6y9Rjhn7ktcsjwzm0rVLshVZEcclv3+RVbZjrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFXgPAFk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFXgPAFk"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853aec185aso32404665e9.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242387; x=1773847187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iio4cl+OyEd/81nwvdw/7qGoFT8YEOteWN+/bhaNG+c=;
        b=eFXgPAFkGET5ntUYrKlcYF9ud1Um6qOwSPETtiy/gYiKI53RvFWm/37pumMtN/fE9F
         EofEvzGojrfzAxldIzNYSfRC9YmAFZQutH3XIA4SeUPLOZEtUoSOVtcXFrhuA2/ug4/8
         Y/22nVUpgNLSdxO5D6VLWjGbKAI3LslAox4gco3wfg1KWRB+yzHAtRT5aU9k3uj+5+Jt
         zQzBjt/DZ2bwOLbaepxKuwaF0mDw4bZCU6aZYTCqcIu6b3IefUF1+MQ9C8SunA4Pm5Pj
         VRuh2W8+62zktKBWpY3vWn74Aw6Q1Wxa+5/1cAK4Aza9wPyllpZR9yfe5kUsmPHGu5HG
         QB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242387; x=1773847187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iio4cl+OyEd/81nwvdw/7qGoFT8YEOteWN+/bhaNG+c=;
        b=TVRFMNrGJ454CsCSNZnGhSegrW6fffqHPfO1fOJk4qbc86HBTO8DodkXHA4tdZTgM2
         TRmxJtcJvzspl3WwR5o8avM1LaoIgQFDEDQEaqVHiK4ZX7eqabeD2uxI+qGDq5EBFkYV
         tdfIZVobdbFHSukxWVIwPXxCH9UwF4IdHC0VUXXWqqAM+fUCRENWy2WFeK/09xOFOcrY
         uZQaJATGCtZGbCoQxbIfZRckAEqr/QQIZVPClhh97n2qtqaKlRLAKLuaetIztwS3Xg6Z
         2ELt6EoBT8k1V+H1KDQq/tuZV3cQ9r2c/Hb4ItJeMwYR3FHgP7SHTsQpAs5oQHq38j/w
         mPTg==
X-Gm-Message-State: AOJu0Yzf98shPIjVjUI0hOsgZDOTc+xCw9UYjl/fOyrZ7jo5JM+O++yl
	eUFu5xBRusPpwQMgHZzSc3ySjwoKu54D9XFgudCRJdEyINa72k7Vb31gJSM+ODY6
X-Gm-Gg: ATEYQzyWu0Q5BSNOc029RhNUpTerqXVolmZuxMtKKbcHaGoM/p0EKXN3p6Zt9keoOUP
	oxRI6WTnJF9saHy5FZIkkHGdh0SUHyQY2I3vzNg0huMHyQlXJmAMDFnjwks9vF7L3bJKBcq5chP
	T65jF/qwzLlGSaC0IbaLw1y3ZnYqd6B52Axa5gL4dijHzBpHrDbwjYJzdZEJ98oMAwgXBNLSevY
	kFBBYdnVzWEmmHyTzJ0C32YgS1iaCWgVx3UK1uZuJtsTplbz7PN4fk7IZhji4YErbmDnBW9hO7z
	ToVD1Q0+3QyKvCWjWxneAQNO4STPXHTiqhRUPiMNXFf8qYfk9WciJDrEUOHlgFQF6kRjrjvTqgV
	4LFZyXpbuFAVTPuEoC1hnIL6yzlUkqYCknp24bqOr/FfJDGgXbZS2B85/i9KqtxQsKPDWBV1jsC
	qJo0D9kYNJ599xauqlxekgbxHAVg==
X-Received: by 2002:a05:600c:8b8b:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-4854b0a5370mr45082145e9.6.1773242387111;
        Wed, 11 Mar 2026 08:19:47 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm62743975e9.10.2026.03.11.08.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:19:46 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH 2/4] run-command: use repo_start_command() in strict callers
Date: Wed, 11 Mar 2026 18:19:21 +0300
Message-ID: <20260311151923.4178655-3-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311151923.4178655-1-bkkaracay@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some callers have been freed from global state and they do not define
the 'USE_THE_REPOSITORY_VARIABLE' macro.

To complete the mitigation of 'start_command()', update these callers to
use repo_start_command() and pass their local 'struct repository' as an
argument, completely eliminating their hidden reliance on the global
state.

Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
---
 builtin/difftool.c | 4 ++--
 odb.c              | 2 +-
 pager.c            | 2 +-
 repack-promisor.c  | 2 +-
 send-pack.c        | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index e4bc1f8316..15ac552edf 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -257,7 +257,7 @@ static void changed_files(struct repository *repo,
 	diff_files.out = -1;
 	diff_files.dir = workdir;
 	strvec_pushf(&diff_files.env, "GIT_INDEX_FILE=%s", index_path);
-	if (start_command(&diff_files))
+	if (repo_start_command(repo, &diff_files))
 		die("could not obtain raw diff");
 	fp = xfdopen(diff_files.out, "r");
 	while (!strbuf_getline_nul(&buf, fp)) {
@@ -437,7 +437,7 @@ static int run_dir_diff(struct repository *repo,
 	child->clean_on_exit = 1;
 	child->dir = prefix;
 	child->out = -1;
-	if (start_command(child))
+	if (repo_start_command(repo, child))
 		die("could not obtain raw diff");
 	fp = xfdopen(child->out, "r");
 
diff --git a/odb.c b/odb.c
index 776de5356c..8ec279f84e 100644
--- a/odb.c
+++ b/odb.c
@@ -535,7 +535,7 @@ static void read_alternate_refs(struct repository *repo,
 
 	fill_alternate_refs_command(repo, &cmd, path);
 
-	if (start_command(&cmd))
+	if (repo_start_command(repo, &cmd))
 		return;
 
 	fh = xfdopen(cmd.out, "r");
diff --git a/pager.c b/pager.c
index 5531fff50e..9a23ed958d 100644
--- a/pager.c
+++ b/pager.c
@@ -169,7 +169,7 @@ void setup_pager(struct repository *r)
 	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;
 	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
-	if (start_command(&pager_process))
+	if (repo_start_command(r, &pager_process))
 		die("unable to execute pager '%s'", pager);
 
 	/* original process continues, but writes to the pipe */
diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..dba161a11a 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -125,7 +125,7 @@ void pack_geometry_repack_promisors(struct repository *repo,
 	prepare_pack_objects(&cmd, args, packtmp);
 	strvec_push(&cmd.args, "--stdin-packs");
 	cmd.in = -1;
-	if (start_command(&cmd))
+	if (repo_start_command(repo, &cmd))
 		die(_("could not start pack-objects to repack promisor packs"));
 
 	in = xfdopen(cmd.in, "w");
diff --git a/send-pack.c b/send-pack.c
index 67d6987b1c..c339c3d1ca 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -92,7 +92,7 @@ static int pack_objects(struct repository *r,
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
 	po.clean_on_exit = 1;
-	if (start_command(&po))
+	if (repo_start_command(r, &po))
 		die_errno("git pack-objects failed");
 
 	/*
@@ -459,7 +459,7 @@ static void get_commons_through_negotiation(struct repository *r,
 		return;
 	}
 
-	if (start_command(&child))
+	if (repo_start_command(r, &child))
 		die(_("send-pack: unable to fork off fetch subprocess"));
 
 	do {
-- 
2.53.0

