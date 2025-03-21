Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077721D3E9
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599238; cv=none; b=cdv6gmh5QHNtyv9xxDXvFhk3r1owP+bF1PyBZlzVAOn6mdz6EHc4PwI3XYmeCcyRxIfAXVxjP7WZWIh6iWVo7sWGta9bOltWueqjQkJdk6lhmSz1+v3dn8TmCyHg/7qsc/l6DKFMlznn1VhTKz9TWE5gB4I3DQzc/Q1zSlGETWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599238; c=relaxed/simple;
	bh=OhuuvLAzXfBUJtmzxuRYIifux1MuRkp64l+jJcffW0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+g++pEUN4MZFKakGmbQjy+LSd71XLJWhcGflxalzlum4MMX2yaeoW+aDnQUruWp7vnu86yVdo764IYGLBhj7M5OPvqcV9B6/vau2VjbGh/2RiLZtl/ybqB1nmAPjHmv37wE2WDmkpjK5/NviLI39iDedLRn+bQlqNFLJDIyq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtSOczuu; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtSOczuu"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c787506611so326150fac.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742599236; x=1743204036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd3oltE/uxbCecctEkRNByk8f5NSGLoeHxJ8n7hm3Ew=;
        b=WtSOczuu1Ci1XB8/DCVHULxCCAU8cKxJvQB4f4BwXEIIrout+nbIJJbW3wEvYwBNeX
         Y3KISAeJeIAoidzWHPgJCpaGo3UCXtVAWsztqpDmzWSMQoqsR1/BBYPmqG+U40ftUyQT
         zPQVPP4FuHGMKvh3mHnpWbTqK4/wBgiJJ8iF+Tez1WUM+udw/pvRnzptBWblVLuv3nv1
         ytr6OGx7YlIRdKXrTxgf9wUVo2AAQCwnNjoQpLArK4nylI1P0F2C0rPha+w8Rt64e7r1
         BP6q2YG5yt8ix3twM7ZywgUAeuIGbHD40LhRcqNwF4g5+dKfHvlK+45kpdI/m0ubkZak
         dEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599236; x=1743204036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd3oltE/uxbCecctEkRNByk8f5NSGLoeHxJ8n7hm3Ew=;
        b=FAdO1h/v8BGg7E9cuO6N8aTQ6FCPRZ9eQ0ExJaOcnPVySw8rVs/EXz8DjpOh7kZQD+
         gDG1RX6eHJ5tHrLjx4SwTgESsmGVp4w2OAK/aCPfcHYrCpHwnxz6kGj8jSvBlLv083Rc
         9Y5p+KApUaMnwsBqUkHK1EB39h0AT9gIRaztrpcwWUKgoZafblMf89GEEVnv/numo9p7
         sHg0NimZAOS1haV2gGrn4zlhG76sJlD7rgg2upjojtMxXEIVwCdFomxtdMTD0WRtcpTE
         WaJ6Wec9T58Sl3s4rx1isRSSfOjywNWkzk0pFiftJcmbgmdjKF7FsGTcNfuSfntaYRBA
         iBhA==
X-Gm-Message-State: AOJu0YzuqFUI5wHL4tTpzOpvWLL83vSSGfnaih/zDXyLuiwLM1ISJvBH
	crnxtimhuyBydQsvlWCDILj0adawI72uQU3FO56AArpFPFv7hSM+PxwkVw==
X-Gm-Gg: ASbGnct9uGpGcAKfag/F0lKwZ1mH85SDcDf3trDy9Xka9cNs9zOjkyxz7Hdti74Zqva
	f5l1Yvmpw8wm+Ar7ulJDtn9s7t1HgKFYcIx3Mj7nUk0HO4QpaqnObaFVZjKtyVMho9beHpEg+HU
	ONsATtuIc6G+qzcNVcdM2I8GcokjuLAtjx4eAs1jk+yF8lF/mWhhYGN71T9UWZQTYrmemgvUpyc
	p5Cqe1N5llB9WSdE/YlWD0Pzh+j3IOS9TfZhQO55aNbM/RfVCysXNB6k2ZfbHQyoAiYFXoafRl4
	gQQ9S1h1Y27Qxb0LAZ2n2w/4/tb/DCBdsMmH5kQKoVJkOwHh9kdBYoa//KzN+R0=
X-Google-Smtp-Source: AGHT+IFSen2tCOkB8vXpAtcfGk4kJUJFonun4IyCfc1BTQP5hWUmZq40ECiIlksP4pU7Hua4bBTsTg==
X-Received: by 2002:a05:6870:41ce:b0:29e:76d1:db3b with SMTP id 586e51a60fabf-2c78020229bmr3767570fac.5.1742599235709;
        Fri, 21 Mar 2025 16:20:35 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0ed8easm715097fac.46.2025.03.21.16.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 16:20:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/3] advice: allow disabling default branch name advice
Date: Fri, 21 Mar 2025 18:16:39 -0500
Message-ID: <20250321231639.180762-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321231639.180762-1-jltobler@gmail.com>
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default branch name advice message is displayed when
`repo_default_branch_name()` is invoked and the `init.defaultBranch`
config is not set. In this scenario, the advice message is always shown
even if the `--no-advice` option is used.

Adapt `repo_default_branch_name()` to allow the default branch name
advice message to be disabled with the `--no-advice` option and
corresponding configuration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 advice.c        | 1 +
 advice.h        | 1 +
 refs.c          | 3 ++-
 t/t0001-init.sh | 8 ++++++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 1df43b7536..e5f0ff8449 100644
--- a/advice.c
+++ b/advice.c
@@ -51,6 +51,7 @@ static struct {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
diff --git a/advice.h b/advice.h
index d233cfc693..727dcecf4a 100644
--- a/advice.h
+++ b/advice.h
@@ -18,6 +18,7 @@ enum advice_type {
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
+	ADVICE_DEFAULT_BRANCH_NAME,
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
 	ADVICE_FETCH_SET_HEAD_WARN,
diff --git a/refs.c b/refs.c
index 118465271d..bf9a40d6af 100644
--- a/refs.c
+++ b/refs.c
@@ -664,7 +664,8 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 	if (!ret) {
 		ret = xstrdup("master");
 		if (!quiet)
-			advise(_(default_branch_name_advice), ret);
+			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
+					  _(default_branch_name_advice), ret);
 	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c49d9e0d38..f11a40811f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -830,6 +830,14 @@ test_expect_success 'advice on unconfigured init.defaultBranch' '
 	test_grep "<YELLOW>hint: " decoded
 '
 
+test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
+	test_when_finished "rm -rf no-advice" &&
+
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+		git -c advice.defaultBranchName=false init no-advice 2>err &&
+	test_grep ! "hint: " err
+'
+
 test_expect_success 'overridden default main branch name (env)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
-- 
2.49.0

