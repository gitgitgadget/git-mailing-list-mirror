Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2923D0934
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538623; cv=none; b=aOjSKVeCVdx0dTVWSEMnr+iP/UT1ZACE1qRf6zkN3wIeRn2OegMJPCj30uCc1uPpvCHlyMMjVhPtC+pv2JqIZw+DqPRz18DkQSydhQVuiKPv+sy+YVSBKpaM+arFfeanW7ICzGk/ilT4rg5mn3RxuXGbnEA53zffSHyMUxPPpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538623; c=relaxed/simple;
	bh=ZR/+G69QIuLYroSZmyxyxF34jYGUI4QzxP/iw1UEOlQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uSvLDMnLB3gEYLNaMSYembh5aRlT4nV9SmbPsQ/LYNC9mzueSzgbRvebMJ4bjusO537UOOsQtUOk1V0I/37mcbgCukbCnwBabTpunHu4b12R6yfVhuIlJtOpPaVZBPizlyahbrOx6bCXeWEvo9HOo+Iu43uGZqbX9N5cs3jwwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK8BqivA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK8BqivA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92c7a0a701aso768168385a.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538621; x=1785143421; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tat1FE7QTOpLU7YDiYOk6TkrefodbgOy9N3nYwYqzPU=;
        b=bK8BqivAvC/G4y0CbZrhircgDs957y2Q27uFkL5PqqMvMyu83c+XMfjjVEBYE2CbfM
         atZ6V39sX4a78rUj3vY5b67tj9/QfHHE/WJncmnHvmew+G1aSJQYEphs475ABUCdHFNv
         T4+S3HcVrbXch9uXLHgM/YGT/o85cCgXCP+hf25kDls4AbvvyfIv+eVr9YJ/Aw3hnD3l
         rPzug2I7qPxdqTFKWMeT+E8qRsOMPWdx4AqwcwVEg9bbZ8mjf873hNTKfzW4QcuMa/XU
         UkFUZSpbhvsLEO5VZMqvm/R5i5aW4gycW2W+CvdJ2a5cP+GtbtP44ZukxxWiqQ93sIRa
         sBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538621; x=1785143421;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tat1FE7QTOpLU7YDiYOk6TkrefodbgOy9N3nYwYqzPU=;
        b=IW4r4N4DnmSxPzwITXDQzk1kGVTUwXEoLu6Xr3b1xrpHzYmOYfVG1XyhO+qBfQoXeR
         ldSlGMaeTbKpKBjDrDLpgjJzzJnShjQ2mRQc1X/unml++vJrK+OTUqZRcqFGX02CosAe
         EqVZicHpHDDOHK0atVv/it+5Pzi78v5jTYyEYQEV+XtX7lm+1cSkSh8DSKA9nNwrlyTr
         0DtCNBh7Tpm1Tak/f3kGAOZZodQjfC2Y+gi/gdNFl4PZHJFFCCXyOspAEk4aIgma8oea
         xQVa5r4TUIGEDu6odogPlo9aw9hTHYwLWco0bnwSDrLh00q69SqMxjszLI3i2vUIdNyb
         w2TQ==
X-Gm-Message-State: AOJu0YzmVUUPVojiqhxAMrQts2LFVtrM0sDgTLeK7RyTX/cMGhZYof2S
	bOevB1Gm+gcio+MCMvEHDWF3xGwLDFDAU/dCtUfQ34yO+NA946BMm5IylBCY3w==
X-Gm-Gg: AfdE7ck2uUCiyZKq9DLhLuWXPGzVq74BR2xCh5H4F/Ape1uHS8NA9WlZun256iRdJBz
	M8CuWQ/0ZX7lW9H1e+EXuDt2KW2cyzYa1WExdvTQ0pYtLwyrAY7bJydS5F2lUk23CxYyJE/34s2
	VgYzZSCmoqk7NGFm8qc7a6peBYWf+qe0LzAIPob99TCWf1tf5BnDEj1o37f6hxUZPeQ+madNAiz
	5lf7dTMEvrG45jHJXUTeErVrGxDwksFLKp3LxlluOrYt2ETDaJ6ezO8NOOUrckqGI0WZD2GJjVg
	d3KOHcsI9AcqSL7JyYirOU45sf7n2HXoRB7t9O9rDDn/uNpJKPCWfAnk66Hnj55HG7YT7Vpktbu
	fF9n4ySAf/d1hvJpY7Fmpuh0s51Jz0gZxnH9QVvQWcgD6SyKz8NnPy1TTfBqDzJijoELigjaCPi
	eFMjE=
X-Received: by 2002:a05:620a:4048:b0:915:afa5:754 with SMTP id af79cd13be357-930b3ec6b9emr1241522585a.2.1784538620898;
        Mon, 20 Jul 2026 02:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.37.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b549629dsm824413085a.47.2026.07.20.02.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:10:20 -0700 (PDT)
Message-Id: <fc70895732f406ecdbaea7a5b9a3fda4fb03df67.1784538618.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 09:10:17 +0000
Subject: [PATCH 1/2] remote: pass repository to push tracking helper
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The push tracking helper currently only needs the push remote. However,
resolving a URL-valued remote requires access to the repository's list
of configured remotes.

Pass the repository through the existing callers and mark the parameter
as unused for now. This prepares the helper for that lookup without
changing its behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index e6c52c850c..89d0f9e2d8 100644
--- a/remote.c
+++ b/remote.c
@@ -1887,7 +1887,8 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct remote *remote,
+static char *tracking_for_push_dest(struct repository *repo UNUSED,
+				    struct remote *remote,
 				    const char *refname,
 				    struct strbuf *err)
 {
@@ -1925,13 +1926,13 @@ static char *branch_get_push_1(struct repository *repo,
 					 _("push refspecs for '%s' do not include '%s'"),
 					 remote->name, branch->name);
 
-		ret = tracking_for_push_dest(remote, dst, err);
+		ret = tracking_for_push_dest(repo, remote, dst, err);
 		free(dst);
 		return ret;
 	}
 
 	if (remote->mirror)
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	switch (push_default) {
 	case PUSH_DEFAULT_NOTHING:
@@ -1939,7 +1940,7 @@ static char *branch_get_push_1(struct repository *repo,
 
 	case PUSH_DEFAULT_MATCHING:
 	case PUSH_DEFAULT_CURRENT:
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
 		return xstrdup_or_null(branch_get_upstream(branch, err));
@@ -1953,7 +1954,7 @@ static char *branch_get_push_1(struct repository *repo,
 			up = branch_get_upstream(branch, err);
 			if (!up)
 				return NULL;
-			cur = tracking_for_push_dest(remote, branch->refname, err);
+			cur = tracking_for_push_dest(repo, remote, branch->refname, err);
 			if (!cur)
 				return NULL;
 			if (strcmp(cur, up)) {
-- 
gitgitgadget

