Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E53FD13D
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465813; cv=none; b=D/X9ql+Jm4RYwYIJHJjvIBJgJvvECEG02+9nN2SV0Wmv8i0MZ2Jhr8R5PSoInWImItUJjQn73URHM3r9+rdI33tK25P9n77GGmvPPQy6LlCYh5SqI449GCSUBfc9frwB+VlCLhDfwPBGikZJQwl6qjeS6yHG15r9GZkx24StsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465813; c=relaxed/simple;
	bh=LgfXVftOj5v/Med6tRHFv1dUn5qbcFa8ci8Zqw6CGwA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VxgcX3Y7j49j5bYcYdiPjyhvRhPp3Tt+GKeHnhNTt/dVrjRp2Mq3gI/pM3JDD6kkWwr3cnujuhk/2pZGB8UTblijls+ADiSMhXmGwYMuI+Huxx+CVIaKKA81xyUjXmv2jnbgfBbW/qZ+CqehstmNQ7JqLD4E7dztOImhDFUT/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0eRoJzp; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0eRoJzp"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso1212091eec.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 07:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772465811; x=1773070611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S831OKF3GXM8iggqn8HyfLnVtTcPA1vltvfekaSaF28=;
        b=e0eRoJzpLaWwzOhOqOOK9C0swnScNsCUOsikIH0lXIjVONIdetPwZ9YzJA43QQ8gQW
         5pZm1dweikxxN1iufZgzgcARXTA7gef1BPRkTvxWWBBHW0FQ01g+x8w3v5qKd8vFJj9I
         iBa8lcaeooNjvzVo/PXsEjwfHZBFZhjVSC3UpDWcZdYE2U9xbYCeUfIO643ckMSWvAk/
         PHBjAd2GzDVi0LDh65VuNbHy7BGj5HOTi3q0AFRl5aFxN1k32dVrp2LHtLuZYJW0U3Xn
         GZJuZw7WxLJ7iozL/bPTsYLaR9FZgkfggQsR2/xtr4SRFF5a7Vt3TbtlZA/pCinnUj2e
         h/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465811; x=1773070611;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S831OKF3GXM8iggqn8HyfLnVtTcPA1vltvfekaSaF28=;
        b=j/ZJhZ5qfL+jMApX6ZTj9fIdnhkJRnxX0NNJBnzg0Ak4vqtZAk/EYDmcxG4/sNN6uG
         AEzDNObMUIzg4l/a4hDXH56s88+KNIJbn2IE+tS9YcEfU7KtTM8hyy+74YLvwKO/WE8d
         aoz9sf6rOc1XbFDPHDTK+jiVLnKzWdWBh5y15DrR7SXU/pz1ACbhZuQWnEOcx9un9SIA
         9Y2WLGUBFTxt7QsORe1o2L1fZ5+vF7+Hgu8Vq0/68b1423luaR7qbeAae09ttyYFEEo2
         SjN1dsQPVBlBgz8C7P/dNQcFnSf0F1i0cVBgi9sB2jrUdMRxD+Eneq6r0GQtwNsbuJ3x
         2bsg==
X-Gm-Message-State: AOJu0YzCNoRfjvUFY2wMYoEjE5KjbR5tjf+ZQhwScio/APdoD5r9gf3k
	JpLFss1YpY7rJ+urQcqZPZ6q7C4d2a64jUuCHeATfrlGkfLJNOao0WE/Ur7eCw==
X-Gm-Gg: ATEYQzxMxF5YBu9jCE8adI6IELZHOQmF9P6fI+/ovm2OaYihF7aVIQdGF/wkZg1tp4Q
	Jz7+BZIj7fhlF3Lbx7v6H90ToqmxKMx292o5kdyTllzeYwczAzWeQaYkAOtKfbm7xqrNYJO9tQL
	gEb7+rkcgAAjU1pYI1zvfJ9xnqJPHB+K0WqKa6HqckMFetEFo2HMC3DiS45p8QmXHqqYXF9ahfY
	DAsGRhbeK2lFNArNh/K5GwnFOTAsryDZaAn7eY7ZeQPDkGT8XbG6Zlszype0lHER9C4pGX1TgR8
	RqHypaHmjAoOPZzmFfZhOCEBMFQS5jNlL7jCsV0nRceEK9LHORLLp1sDMVb/BCi2fMJBrwRLiNQ
	trZB5pKMZPkj8Ui40dZBufnpWCWIx8YGvPPc4eBcahcTvw/RhlojHt52idxjvPYDMn5TBvSEiJ7
	Ip+sbIdF0hz/YVIIlpkaNgNud57J4=
X-Received: by 2002:a05:693c:2c97:b0:2ba:a465:3a20 with SMTP id 5a478bee46e88-2bde1d319b6mr5137090eec.24.1772465810620;
        Mon, 02 Mar 2026 07:36:50 -0800 (PST)
Received: from [127.0.0.1] ([172.184.214.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0c63482csm4004072eec.4.2026.03.02.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:36:50 -0800 (PST)
Message-Id: <13d783dbbdd77b14fed651f0508fa0e668d98c63.1772465805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 15:36:43 +0000
Subject: [PATCH v3 2/4] run-command: extract clear_local_repo_env helper
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
    fastcat@gmail.com,
    Eric Sunshine <sunshine@sunshineco.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The current prepare_other_repo_env() does two distinct things:

 1. Strip certain known environment variables that should be set by a
    child process based on a different repository.

 2. Set the GIT_DIR variable to avoid repository discovery.

The second item is valuable for child processes that operate on
submodules, where the repo discovery could be mistaken for the parent
repository.

In the next change, we will see an important case where only the first
item is required as the GIT_DIR discovery should happen naturally from
the '-C' parameter in the child process.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 run-command.c | 7 ++++++-
 run-command.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..7858a0ef0a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1847,7 +1847,7 @@ int run_auto_maintenance(int quiet)
 	return run_command(&maint);
 }
 
-void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
+void clear_local_repo_env(struct strvec *env)
 {
 	const char * const *var;
 
@@ -1856,6 +1856,11 @@ void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
 		    strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
 			strvec_push(env, *var);
 	}
+}
+
+void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
+{
+	clear_local_repo_env(env);
 	strvec_pushf(env, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
 }
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..76b29d4832 100644
--- a/run-command.h
+++ b/run-command.h
@@ -509,6 +509,13 @@ struct run_process_parallel_opts
  */
 void run_processes_parallel(const struct run_process_parallel_opts *opts);
 
+/**
+ * Unset all local-repo GIT_* variables in env; see local_repo_env in
+ * environment.h. GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT are preserved
+ * to pass -c and --config-env options from the parent process.
+ */
+void clear_local_repo_env(struct strvec *env);
+
 /**
  * Convenience function which prepares env for a command to be run in a
  * new repo. This adds all GIT_* environment variables to env with the
-- 
gitgitgadget

