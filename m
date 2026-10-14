Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2348A8CD
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012844; cv=none; b=XwJqQe/qwcoEiTJyURvp9jfMmdXFEdCy1fIyk4+GSjOyrInPK+gQD17cKSPPkDQxMyhB3XSfSKklkIx1NjBgiB6FvkxeIFo0ITV6zXdUC+g3CUcpVluzSp+LXNp1oyNdsC1uaXvJ/4BWnUJoe9ZvCdChmnvbF8/a9e3DCyZTaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012844; c=relaxed/simple;
	bh=E78TnRh6hbhA0X+tMYZk0nJXASu50/cQBr2O8ufP9xc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VwFS+iX4bM2w7J+upSXAIgroGrOrykS0RHDRClbaB12QU//3ZUpmxWa4ddamCQEwmhBKoeB7a2+XcHc956/YnFU4i837hhl1+9UfNGgLmA/5HdeUosfBgj48WJIZFGGTziqoxOfK5xnntkpA2K3+82sAOXUA4FNmq+4MIRQyKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOAQ9xYf; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOAQ9xYf"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53391022dc0so51829371cf.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012842; x=1792617642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/wQIzeQWuKfP0hKSVDa0vmQNyqzLF/FHbJ8rAUWqtY4=;
        b=mOAQ9xYfVLVaw09wjo5AowcMK05MTvA8O4YOo9yK6ynwkJxs8jdUloor4rgZYyLUEm
         sU6v4A3aPHRkpRb725EUkLWgQKrMV8Wn4yeMLejd7lehEkVeRccTqU0of8wp200SRZ2d
         92Ntf5wCT1m2pwbtPS0HcnXpbNJcThtNxKlr1sD0ZUGbPuWRCNn3TYlC5L4vwmA7q7Wb
         /2152Z9sRm28rJnRe0wCQSKn60hhR7gyHkUJtYFzJLvKFoCO0Hq/ufUj73YwLEhNoRoL
         /sHnN+aZd47dT91MOcoUz3pMa7O4jNIywr5CrR77ije0UF307beuFT0ieyhUxaq9NiZP
         W5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012842; x=1792617642;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wQIzeQWuKfP0hKSVDa0vmQNyqzLF/FHbJ8rAUWqtY4=;
        b=uj9XzILMO+RMPjNLpmrgWZFs1xiAswfwj+GvV+OLDu4cIsMmyl+4ounetl8zG+Edaw
         oONFPbqZhoAmBnwZb6O1lLEVPPTDMB5/FYEJIy2WCyCNdSq2JGFX5Wa3bXyfhzlcjvR8
         DpoQhXl4shjJA6o6ExH2+O2kle0agNHnKvFqEyY4RzoBM1b9GtV8s18ra/h79U5el4Ol
         EqDcd15o+VhTAPTxAAJfcP1PZkRYQzQCoZJtiiRhRjqY7K6fS6VFuClW9QRiIZj3PVmc
         HTFsJlO+DadYy1sKBYSjGj2QrPcPPvfQepI51DEzXHy6eCrN+sQzaoYuboogVbuK9YwZ
         oRRQ==
X-Gm-Message-State: AFq9FYLaPk4fNGwZV3icCnTebEegtT7ntpTVgnJ1vo0yDDzd2iHS7wq3
	016JswAg8KkJHR0DD12NFCb9fW2vgFaTgXw/QFrzYKsgi7ZED/QqaNR4gMeQ4zLb3rw=
X-Gm-Gg: AYBFou13ppNpXPSm9l+MrRGVcr23ga/fZmLWo18nVBcRikfaweTxA6jDcPoazV/ZVpN
	JqXpqhRKKopJ+O93XOJoMeg0/Jf75ylwQGtCSdzJh6wY90/XhpL6I9tQ7ricK1b0x8kTnJxd0ZO
	Lc9aCFbxcEqhpNtvLnkg4Z3HoTlZtzEOFGunvmH+iTsu3U2JEGGhW7kgNr9xhuaI+FTiCtRSM3o
	l/Pf8mYTUSClnpWR21su0aI/QS2FfgvLLsOKn06H/QuSZjJYvavi7gaRaOeyTF4hhpbIURwulif
	iHASKPU1srvVIpz+mWOTImZ/8qW4LAYbA/miIPUVReJsyFdyYyXbTXA0puzoRE7rX4TWlkWF2pt
	hYiqOanH0jkZZqyyLcZmQw3lbr+GAQqXugV2Dtg00C2IPPKVQK5sGAx6lvrBnHkoToKuEwbpREa
	KVH2Gg5voa4bhIxJY8bvS9uczCsvGLk9tOv6aNXPtDtjUVOfYy/MXtUxYBy63Ly7EJnCpjf6nJj
	NFXsL8mG6kU
X-Received: by 2002:ac8:6904:0:b0:535:f182:7826 with SMTP id d75a77b69052e-535f1829cfbmr81217391cf.76.1792012842413;
        Wed, 14 Oct 2026 14:20:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.220.125.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53612840286sm7148791cf.29.2026.10.14.14.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:20:41 -0700 (PDT)
Message-Id: <2cc7b817ee4105b57450ed80d80cfa224f2ed431.1792012836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 21:20:34 +0000
Subject: [PATCH v2 3/5] worktree repair: use read_gitfile_raw() in
 infer_backlink()
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
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Use read_gitfile_raw() in infer_backlink() to parse .git files
consistently with repair_gitfile(). Unlike strbuf_trim(),
read_gitfile_raw() does not silently discard trailing whitespace. Such
whitespace is treated as part of the path and may cause the path to be
treated as not referencing a repository.

Extract get_worktree_id() for use in a subsequent commit.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 worktree.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index f8e9850f6f..3627dbc044 100644
--- a/worktree.c
+++ b/worktree.c
@@ -637,6 +637,14 @@ int other_head_refs(struct repository *repo,
 	return ret;
 }
 
+static const char *get_worktree_id(const char *dotgit_contents)
+{
+	const char *slash = find_last_dir_sep(dotgit_contents);
+	if (!slash)
+		return "";
+	return slash + 1;
+}
+
 /*
  * Repair worktree's /path/to/worktree/.git file if missing, corrupt, or not
  * pointing at <repo>/worktrees/<id>.
@@ -801,27 +809,24 @@ static ssize_t infer_backlink(struct repository *repo,
 			      const char *gitfile,
 			      struct strbuf *inferred)
 {
-	struct strbuf actual = STRBUF_INIT;
+	struct strbuf contents = STRBUF_INIT;
 	const char *id;
+	int err;
 
-	if (strbuf_read_file(&actual, gitfile, 0) < 0)
+	err = read_gitfile_raw(&contents, gitfile);
+	if (err)
 		goto error;
-	if (!starts_with(actual.buf, "gitdir:"))
-		goto error;
-	if (!(id = find_last_dir_sep(actual.buf)))
-		goto error;
-	strbuf_trim(&actual);
-	id++; /* advance past '/' to point at <id> */
+	id = get_worktree_id(contents.buf);
 	if (!*id)
 		goto error;
 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
 	if (!is_directory(inferred->buf))
 		goto error;
 
-	strbuf_release(&actual);
+	strbuf_release(&contents);
 	return inferred->len;
 error:
-	strbuf_release(&actual);
+	strbuf_release(&contents);
 	strbuf_reset(inferred); /* clear invalid path */
 	return -1;
 }
-- 
gitgitgadget

