Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993173B47C9
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889488; cv=none; b=mYbn2uGDUmXnUOk0oo1MCE8/XA75sEzBrniBRoP7GjmnZISuJbN7NEl2rNNEFK29CkKDP/LA028Zz/ZRPaflQudEJOn369TaCwxW8vriG3mnoS+E/gpLxvDEL9FnvyU3dowaac1xsPL8d16xNcX8J/K159LfMEOTn/+uwoHpFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889488; c=relaxed/simple;
	bh=jGPkwCqQGjxRjPsd5+M1f+j++FUAsFNEhJT5ikVxWII=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TVALlvz5i1WoIGt7mE3X3s5W1CLMEXgSlMV57Wy++nbhVcHkIcdTBw+Pjz64BNMKKVUCtzre3tkvzRGkAEDdrlEz3t5Qgy9wvQGNZcD5dpPMi4IX+JORj5V3W1SRZ7EUl3hwhU63qy+Pfmqa4qYJkzeXb8UEmpcF2XLkEXw3Kj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH0foP3+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH0foP3+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8eaa7b5e31eso11823406d6.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889486; x=1783494286; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q0byMjkUnp7g1b8QV/kwiUxNrmgprIqe3iFEw6ctvQ=;
        b=eH0foP3+iL+9Z7OVZNWIw6VYH4JJesU+CECXS1k5IXu9E2nksbO8Jlp/AY7cDq/Yth
         vWglP7DpQgNOQWKdUTo68aPvQn1zyVx3gW0GNXTwYKm5yBtlHL6ys3CJSHOAUHbaK8H5
         /kINsaLfHDfraW2k3Yz3k/x62cIr08ASNJMkQgSF2pfnWPSULlRVhpFyAO0jSBjJxXoP
         /WNKv79NhOXr17JIZvMJtSRx08M7uNkW93I/5VjZh4mSwiv5cFuhWtQyY4mM+Rf6MTpU
         gU4Q57q6MUCDO58ruNIgHxKAIC/ld0Cto/l8xSMC5DEHginmJiZdcm8BtahBxfpiNVUy
         LZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889486; x=1783494286;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Q0byMjkUnp7g1b8QV/kwiUxNrmgprIqe3iFEw6ctvQ=;
        b=OActyKbOlpxfbfxM/bcR5l+AkqylhGE6yGLdLCAW/DIUmshUf7eC3KW7wO4TjVzAj2
         wgLHudjF5Qca4AHx86ADrYP0N4wESY2H1wtWND+Ij8UBCwIAOhkaCMDKxf2SsMJRAT+5
         iWrI4mDgX4dWWo0hpdyjoClB3CjDaXkcwZPYsbqJ0WHGpzuRV0vmrBNTtP4CKZf76kma
         sBngbCpeDqq7eICVXhOz0+ru05tg5ExGZf2WP7JanYNdkJme5TpQxp2gWV81FkDmcj8M
         AvSrcZHWY/UAuToyM3hU6mOlv+HoVjw3Gtd3TIwRQS5KG4zX4B0Qpwrt4ije3lhNzUFf
         XAMg==
X-Gm-Message-State: AOJu0YzjQqyON14K5bfbz2kDzqm3WhVQesVXbko5fCmF6eFvHx8ANBSV
	calfdfCOxQlc8Or2Cg8K6uXC7/6L0kMZIxHWMXpU3tTZWZ4Lxgj3AXDBOb+m5g==
X-Gm-Gg: AfdE7cmv5AU+XfukjGPbTzlzmKcf2lw1hsfWajtyeWlxyZi9+in6Z3KCwt892AqUdDJ
	nUHp4THsO8jez2eIjfH6435hHvn2wOIFzo8dlodfdvSIFnZYxwJ/EK3BkEz/7JY8kuu1A6h0SDj
	ChOTr7XMitEai9p/9k37GNQYUPS3aQIbT4OoODYuczBh39Qgn66QA+Jn9yfrQhEnBksSMBMpGvb
	2ooEHBujvR3W7fZA1KGxq6vvgxj2Zeh2yxbld5TSh6rn0a3gbUAp8nt+V+/g5WE44gEmX1Xf6cT
	ukeceP1OpVJoaPkN/El7lX2NLCG04pOXUBtrSYRGFPeVVkr8TImK7WWfD64h0cVE6QOMbhgHdJ3
	l1hGrhuwwE299jEQtHdqpoVaIhtmNhSRyS/+iFmbKLqXptcV0/+8c+JxGqZLqZWKS5fe8qUsoT/
	v47cnHhM9dQckzoJIx
X-Received: by 2002:a05:6214:4e90:b0:8e5:8d7b:5188 with SMTP id 6a1803df08f44-8f2526fa04emr64202686d6.9.1782889486304;
        Wed, 01 Jul 2026 00:04:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35ee5b7c3sm14018906d6.14.2026.07.01.00.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:45 -0700 (PDT)
Message-Id: <e39e2f5aa4c7e380d51c95ca276afab393e71b5e.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:27 +0000
Subject: [PATCH 09/13] worktree: fix resource leaks when branch creation fails
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the "add" subcommand, when run_command() fails while creating
a new branch (line 948), the function returns -1 immediately
without freeing the allocations made earlier: path (from
prefix_filename at line 858), opt_track, branch_to_free, and
new_branch_to_free.

Redirect the error return through the existing cleanup block at
the end of the function so all four allocations are properly
freed.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/worktree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..4bc7b4f6e7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -945,14 +945,17 @@ static int add(int ac, const char **av, const char *prefix,
 		strvec_push(&cp.args, branch);
 		if (opt_track)
 			strvec_push(&cp.args, opt_track);
-		if (run_command(&cp))
-			return -1;
+		if (run_command(&cp)) {
+			ret = -1;
+			goto cleanup;
+		}
 		branch = new_branch;
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
 
 	ret = add_worktree(path, branch, &opts);
+cleanup:
 	free(path);
 	free(opt_track);
 	free(branch_to_free);
-- 
gitgitgadget

