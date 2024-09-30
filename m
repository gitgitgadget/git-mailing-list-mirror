Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1618FDC5
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718036; cv=none; b=sdihkn7RD7SV9iHT4EWxwU4et2eTsbb1rHaYfrANVF2Tfo0+Kgp45Nz0c45vcwhcbYoib6CrQD4vMScPdQc/iZu0Eun8MIfWGCCKwiKWKoW2jkoAO/nOadxZOks9IKNnEv52zP90/iFT35hevW31phT/ckgz8mos+m3r63fE9yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718036; c=relaxed/simple;
	bh=S6N1yg2cO5mWw6rdGwvAlb05NAInW1Z0B2rZhz2W51o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iQS980l/ftkEgrwKqP0A0hEnCTva2SiTfIZ07hIc68+JBtzWJnwdcy1h21KvTQ3djhmO6bmc3iIFTFaAOiUjIzUOVmhCrqH0+7nNDSzNnOfiaYKIQqPiwURiaRx0TXbq4/EHHRN3Ml7jY6uleiw0IGUazVPS1b+zW/tTsGBmNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dze5uSZb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dze5uSZb"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so457600266b.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727718033; x=1728322833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oXg8mgs7dTAdfaN7mPgo20jGqeLbHnF7nqFkBF4t8w=;
        b=Dze5uSZbpTwKAupGEJdiRJc86j1MT6X0iUAi8LswJidSABHcxsPOEkugS8AeYlJcjE
         +8n7DhwmE3rudkEieepWqo7H9/xHRLq2FyA0QEl+wqTiSjXnp8vXJmC+Y+AwYOyVDUrF
         u81v68+pNvYbNmOXkN6jV+nPiEFyq/bq8hzrYq7uLi+jSqv56P4t4QGlYLVNLxIdN4mZ
         0MSrVrPKx6ojnLtX6mKGp7XICnYxNvsJzINHugr2s6BvrGEkn06rD2fwPRYBRYIFHdCU
         Om1edt0VLnbChWGPrDfmGyk4di2FJ7uYSKsjpjUtMoGtKOjaXjvm/eVNPjeuV0P3qCWK
         Syeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718033; x=1728322833;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oXg8mgs7dTAdfaN7mPgo20jGqeLbHnF7nqFkBF4t8w=;
        b=EaJ2ZuE51lx3xs+JWzPXK5aVLPFQ+1PDNgvU7AVa81FgVtod9e1N+8tA8+SDFax/yf
         zyeSauRW0fFvbLVltXYBCaqXqZ1IoCZG3UM7xqa7vk9sl8biQtJgIbGqZABWCw4FEutQ
         P2cDiVX86RxMQE7b1mdowqXQahXE6W5qMRmRwM/6+aBK3VbTgJlVaAFO0JMGGGoWwtcC
         HAyMSAWgenoUZa1lUP364Yxeytmpw6K6l7vxlR5gJE8NK4ObiJXFvns+yd5dUfjNCAR3
         4tAvicEafmM3y1S6Qa7uOleQt9zNmJvh0KVLYax1cTUPWq6kaHx5O8rT2+tDQ/kXqoD/
         638Q==
X-Gm-Message-State: AOJu0YxQMUxB1AVnkCqzACtYjFYyrR1XeNVE8dXFbOuuZk4szxh5LG5/
	M1SXCQ+e0zvjM+/yaBoceZLZYxuYygXSKsgM/fvqqnIfgDd0GFMXFyWxfw==
X-Google-Smtp-Source: AGHT+IFyfbqQjN4hZsttYufkRVd9DfuLwqB5BKvFvJJoq/HdzS96zAVgjy+jlepHccu2sjgzQqXxbQ==
X-Received: by 2002:a17:906:dac8:b0:a8d:4b02:334c with SMTP id a640c23a62f3a-a93c4c284b7mr1557420966b.64.1727718032564;
        Mon, 30 Sep 2024 10:40:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bb76sm572447066b.170.2024.09.30.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:40:32 -0700 (PDT)
Message-Id: <5d72c31c6f3b97b7f5f7d3b4fa9a8b1587597670.1727718030.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 17:40:27 +0000
Subject: [PATCH v2 1/4] git: pass in repo for RUN_SETUP_GENTLY
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

commands that have RUN_SETUP_GENTLY potentially need a repository.
Modify the logic in run_builtin() to pass the repository to the builtin
if a builtin has the RUN_SETUP_GENTLY property.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 git.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 2fbea24ec92..f58f169f3c7 100644
--- a/git.c
+++ b/git.c
@@ -443,7 +443,7 @@ static int handle_alias(int *argcp, const char ***argv)
 
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
 {
-	int status, help;
+	int status, help, repo_exists;
 	struct stat st;
 	const char *prefix;
 	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
@@ -455,9 +455,13 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 
 	if (run_setup & RUN_SETUP) {
 		prefix = setup_git_directory();
+		repo_exists = 1;
 	} else if (run_setup & RUN_SETUP_GENTLY) {
 		int nongit_ok;
 		prefix = setup_git_directory_gently(&nongit_ok);
+
+		if (!nongit_ok)
+			repo_exists = 1;
 	} else {
 		prefix = NULL;
 	}
@@ -480,7 +484,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	trace2_cmd_name(p->cmd);
 
 	validate_cache_entries(repo->index);
-	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
+	status = p->fn(argc,
+		       argv,
+		       prefix,
+		       repo_exists ? repo : NULL);
 	validate_cache_entries(repo->index);
 
 	if (status)
-- 
gitgitgadget

