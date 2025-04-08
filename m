Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964B22C33A
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127336; cv=none; b=JCYrL1yjL7oz+QY+KmzBvGMRzoMAKOK82bxBrVBJ9MV6qFPRIy90RiUncMWXqO1IOjVVB4b0zxo4smH2WgLDZSF0xD4uEZI+Sx9c4jMa2wnKLdFCbNx4joEnqb9dACrs2INBTCqOJw/7doDJcMKpM+3cLuk28GtQ1i/qFLtOciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127336; c=relaxed/simple;
	bh=2e7Fmrgi9w888kvnkw1mQ7NK+Dqk5n1X0aBoJiIAnns=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c6jg29G8EPZVJmjVGfWLYGhg1G/9dcez3EdkYe1m1HglHdN2IqPfkp0O8iaRzOKuSWiQ1tMcGGZBCVFECFk6vK6XDASITjGG6lR31Es0Q+UogLTMDY1bn5ubSj1M5WuqDvzIuIjkVd6mWoYIGTx711rSlyXUxGX+GwjGO5tOmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZepYhnh5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZepYhnh5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so52246525e9.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127333; x=1744732133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzmSmZ57MV4r6wpQeyXj8ka6HvD+XlngCNgdKlo5+s0=;
        b=ZepYhnh5wlT/LugYP0HF15GaPcRxsgAFQV8PXQEust1RusvnfknjfiynQlHWWbC75F
         X7lZYBxTRaB1CYcCD/GDKV0xAu50XMdxeYlmQ8V7b4BgLaEqkrlqtj0UlLlMfQ+g3kyM
         K0Lonr8UwfeOSO+02X1/7Zjj4c/YR2bOmFWvGKCmt5KE5AJrzfAqdCRgXEWYT9jAWbKQ
         7A1ULdo6qZXxR8NDyC+QcI5ZRceeCaThAJ2peJB7EAd9xdG3K6giJFm3M7HIFKZrtSgs
         /+2fdp/lU8LS0KndhBVhIYUzY4NNYjw10UQbXfk+htPbh4fMktuhNcG+dK3kI+lQ2tLz
         sWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127333; x=1744732133;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzmSmZ57MV4r6wpQeyXj8ka6HvD+XlngCNgdKlo5+s0=;
        b=lVk5MF2wsSSvSY5XbgGesQTU39b35LNNPYtZS+FNbE5YOix36xFh/w4BcSaI4YHUuU
         PoQ467qbPMY5Pdl3mElx6zlY1y7PaYGb5Qa7S5lLSL9m+ucQ+eRHrCeUdW26EXJ83Lys
         c8BDB4nb3URwGxhADlGJiruP2mPzAC9IAlm4y/X8ynbRIY9DrU6+jNWiDwb/hKAcS1gD
         AVZMHKM5OxWVfCz6n2hacyDggs9U+tRwqNJfGY+h81DofPuP2HyhazMeoh7pMFPgw8cN
         sM15CHsLsrtffw8UNAE/1oW+WlbbJiqEqhj0Odf8ml4WxCwpaR6Vju9yMMFkDvwoByyh
         TCcw==
X-Gm-Message-State: AOJu0YzyhObigJXmQnvXg+x42bH/EnSMsGJgYax+7lAO4s0hvZVqVI51
	Dc3KY8u6SOx9KbFvB+C8VDeT0aRCX+YTuFO7BcZPgeUCd5tmNIoSBkdgxg==
X-Gm-Gg: ASbGncuNqMFJB6ZVX+04cLaVJXVF9/JGCxzlji8DP9C0l1STTW1rEGN+vcTbAxGhV05
	DjdqTsoZItf2gwmo7s+7DtOf+98NwXteHGaerhT0AvTTS2gq+5D3qGoJolM8f8/6lbCfxxcUfRp
	h9rEikvZeAMmiVZBlGzBky8JfCgzVVFwkbUgd8mdMm0PwVqB5TlkKCFx/0IVSMelATdNvH3d+bE
	UmO5pQWmkfqGK2x5uOaXrTU74pfAi2ifFie6Q/o4b4WW4KyYI630l2Wdf6t7xSmzOVeurTo3QvW
	SUr4EPq1czERh1NbX4uGdJ6uwCSWWKMjd0cdQvQWrKpOeA==
X-Google-Smtp-Source: AGHT+IEc2jubt/KJBaqmiq4svWFyFWwCp+KwCl1hBlCAlIigyeHUyH/VYg2pXo0G4kgMDU0L8c/vKg==
X-Received: by 2002:a05:600c:1e03:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-43ecf8ceb2dmr160386275e9.14.1744127332620;
        Tue, 08 Apr 2025 08:48:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b18easm167237995e9.38.2025.04.08.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:48:52 -0700 (PDT)
Message-Id: <bf2d462c4e5bbb1e44ebb1162d7204d205527208.1744127323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
References: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
	<pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Apr 2025 15:48:42 +0000
Subject: [PATCH v3 8/8] builtin/{merge,rebase,revert}: remove
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
