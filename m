Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D811EB5DB
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743891390; cv=none; b=GMweFfsAi4QxiXJxS2TalJUzuvDpu0ey20OFkdCauPOScN0l7wkEP+0SczmKXEW18PFDjMlGnwVzqKEmCo7DcsoWOpsp4l/7QE0oBJHQJAwXpOwHD7F/jbYrIrv4FNz1DZGkJnsFEha0K0yhdbltOAv3H3KHGFrr64gSSecAO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743891390; c=relaxed/simple;
	bh=2e7Fmrgi9w888kvnkw1mQ7NK+Dqk5n1X0aBoJiIAnns=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PvSyu6g+47BFP9nfRcrGDD8nuGSYLXavecKlADWmoeqvRZfgSoEt9XShWKFlgHmIN0C8Pp1SrprG0bF4yMyoxBJo6sUqlaDB+kb7Y9y7/BeICoV60m8TaVUNIqpd6V3PyGMzqcDpD5lqHTzQZ9TrvVLgFiNyjFBUD2rzEXjJ/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTKuv7wR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTKuv7wR"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edb40f357so10597635e9.0
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743891386; x=1744496186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzmSmZ57MV4r6wpQeyXj8ka6HvD+XlngCNgdKlo5+s0=;
        b=ZTKuv7wRnkBLh+hnis3bTqZoKvUZbyIDa9Qcyl1XulUwbJg0950K35i8UkNmw6qDV7
         pihNsLVkgYvRkxH0IG0AGfPD5PeYGvqQyN2N1sBrYWMeNIbHMVc049Ds+0biKLz7Wsyb
         Lcox0AzHlwT5DMm6YTB0y3PNkkmHVRxyIqy2p9gPt5tj/tBgWXzmqjLr/a6MIhoUTojk
         fgAcI6XxNxDPnGX/75VPSCZW0KQ2o/6PHWVTHMDbH2DpPIa1c/FCgt1wb31zutF6rAzC
         1U/f42xgPo74TF6swKiCbdlvJRfkjyGyW/o9JcP2R2uTQHJQb5urcwCNl11PrOhyMNwf
         s8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743891387; x=1744496187;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzmSmZ57MV4r6wpQeyXj8ka6HvD+XlngCNgdKlo5+s0=;
        b=reLYyYlaxYrgR/OUCJpLXC22O5ifVkr8HaLYzDWEsl8HSCnUoB8bXTJJU9eo8fU9c/
         ixYDUsECT4prYH+cfhOpllIDKk/dC3/4NAAkXm1FQDG7KAqgJjKKRM4ndwTlpqTAxCf1
         RHfPe6azrufxq/G23ikuxQm/xsIPME+fuS8NGZv71IZFl7VLN/NNvmk/LI19qExv+979
         UY41QUG9sQta26N8whJP3ysClDgaiEG9Lh5VCzDiAtKA533P081aYT0euOH9K1HAwxrm
         DtWP0Jgm+sxJ6Iq8za7UJVJGFp1h6zICjmrpr9wctcPZN9P2dq4lraMJCQQAl+XhKn3M
         RmTg==
X-Gm-Message-State: AOJu0YxTLDH2bGrZ5kptBIglHpLh0ScZMDkGZn/tl9ZRshHjiAlVnTep
	sTgKvjxowqrf6TymbIMud64YHytIB4Kwe817n+binib2IKJ3Pz1N6zAZyg==
X-Gm-Gg: ASbGncsYnH609FbQs0w5pqEGTfTNrTk4Y1MG1TXumOHEwFZkGsqw6WwVz8w12Ditd6V
	3mIkUVDXUQHtPiGncKEgNfEhwRbDYgMXb5ccd6bVKx+zUnTtygYTjebKxKLS6luuXYEK2WrNrNB
	/HIcQDkWhdGk12JCDdklq8qJEF4oocEzXOCJLSvOh18+ZCo1Bj146RXa6o6+wIdCWWzP3YEGjJr
	RX5F3VG7Fd+wBnHFr2Ktq+LdoEly7ByV6zSaVJaMgTSs2waVsz4etg8lAlWjHQzCmS7zqos/RLT
	h4nrU2O/4cGeucD7oiqrKtVDGCnH5fgorrIyYKIyhSXCeQ==
X-Google-Smtp-Source: AGHT+IGQElJQMFXJfjLG4MtCpAXLgmqPfe2PJGsRTmxN27wi23h6ZGuNVRM+X5HzsgDb0n+YTs7+FA==
X-Received: by 2002:a5d:5f43:0:b0:391:22e2:cd21 with SMTP id ffacd0b85a97d-39d6fce11f5mr3038622f8f.36.1743891386543;
        Sat, 05 Apr 2025 15:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16a3aefsm87593485e9.21.2025.04.05.15.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 15:16:26 -0700 (PDT)
Message-Id: <d1dea986646eb826409e0b7cc33889e62456a815.1743891375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
	<pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Apr 2025 22:16:14 +0000
Subject: [PATCH v2 8/8] builtin/{merge,rebase,revert}: remove
 GIT_TEST_MERGE_ALGORITHM
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

This environment variable existed to allow the testsuite to reuse all
the merge-related tests in the testsuite while easily flipping between
the 'recursive' and the 'ort' backends.  Now that we have removed
merge-recursive and remapped 'recursive' to mean 'ort', we don't need
this scaffolding anymore.  Remove it from these three builtins.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c  | 14 +-------------
 builtin/rebase.c |  5 -----
 builtin/revert.c |  2 --
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c0bbdab7104..9efd585842f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -170,7 +170,7 @@ static struct strategy *get_strategy(const char *name)
 	struct strategy *ret;
 	static struct cmdnames main_cmds = {0}, other_cmds = {0};
 	static int loaded;
-	char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
+	char *default_strategy = NULL;
 
 	if (!name)
 		return NULL;
@@ -1311,12 +1311,6 @@ int cmd_merge(int argc,
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
 
-	if (!pull_twohead) {
-		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
-		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead = xstrdup("ort");
-	}
-
 	init_diff_ui_defaults();
 	git_config(git_merge_config, NULL);
 
@@ -1517,12 +1511,6 @@ int cmd_merge(int argc,
 			fast_forward = FF_NO;
 	}
 
-	if (!use_strategies && !pull_twohead &&
-	    remoteheads && !remoteheads->next) {
-		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
-		if (default_strategy)
-			append_strategy(get_strategy(default_strategy));
-	}
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d7..e83193ac73e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1575,11 +1575,6 @@ int cmd_rebase(int argc,
 			    options.default_backend);
 	}
 
-	if (options.type == REBASE_MERGE &&
-	    !options.strategy &&
-	    getenv("GIT_TEST_MERGE_ALGORITHM"))
-		options.strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
-
 	switch (options.type) {
 	case REBASE_MERGE:
 		options.state_dir = merge_dir();
diff --git a/builtin/revert.c b/builtin/revert.c
index aca6c293cdf..2654f769a88 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -252,8 +252,6 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		free(opts->strategy);
 		opts->strategy = xstrdup_or_null(strategy);
 	}
-	if (!opts->strategy && getenv("GIT_TEST_MERGE_ALGORITHM"))
-		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 	free(options);
 
 	if (cmd == 'q') {
-- 
gitgitgadget
