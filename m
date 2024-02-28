Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA283715E
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113470; cv=none; b=MyxPhEzGrrlTTkMWBxxlK63bT30BwafAgSWzx4+M5AhS1hYDvHmAk9Jn2kuQ0jUJp4HVO0PUXCqcnJ7siIdkVS/0fxvesVU5qibnnJYJF7vqSUlK+MgPUnSz/UtWlDXuHreDl5DSD9ajG4rdW7kFVV65gKODLDYyxjJdwY+x5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113470; c=relaxed/simple;
	bh=xxTPOAubrM/wp9qyFuK3vFEIPUvWzFnD62bEAnM2No4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=g9J6aYSXhLWlckJ3UZS7fMck/14vdW69t4LFBrlmlytvI8R+OXLs9bbikFDtus1ifimnFRdOwlD1BrjTKvyI6h4gCbMdAWz9/SY6GusjhiH6sA1F9UF3hYsUE220rrtzd8POPeg+IwGbe+lUsTQtTr8NTRcKxU/3OtXwkg6V0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hD/UkoN6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hD/UkoN6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so3739115e9.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113467; x=1709718267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=We3Sgt4JHA6aTvCpGEBIN6pAwmTwAf7XFQoin0EiPGQ=;
        b=hD/UkoN6Cu6G9ms4LKxI8qDNRJyFgRCF1Zi+db3WCMoJT5imFm/nsXRH12oRd188T0
         8KzsksvQpsXZNgti0U/EPAimQ2vroJgsN8sALJlOsZyGLGGf5i5YO1df94C5F/cRtEo1
         RMaugnHmVmf9GSTGKe3hvf7Fd4f3ym2vZpSdODI6jVq2IzujqMv+geQeZAe5UD/lnVuu
         zT8dSEVsbK0Cl9NEmRoQK/LIr3oEankeFs9Vr+dxI1zGp34Z8Oa50sp2VD8FpS1yPEXL
         FNBEhXqKakahSj4eochfGZIxLByBiSwS3zOQakuip3QobinXlInA2gZjE82gNPkxk6vT
         2xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113467; x=1709718267;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=We3Sgt4JHA6aTvCpGEBIN6pAwmTwAf7XFQoin0EiPGQ=;
        b=b0nVr8Tz+L7/fxJ9zhxTnETg2NUkHE3KnllhhNYanwzFA8qNXW1BrHf7oPuggHoIMi
         kSoEzQGTa4vkZ5U6ZFP8T24AtHWiO0UzClNOssrHPcrQ5zmbYNbRTSWgEFNTEunazHn2
         UfBTHMbXwVqiR9pEwlEaQes/X/k+0mL4C4noSQtWJhSjtlBZ7TQ7iV4gg4T4iYS48Rbk
         cJSsVgJtKLcXaYMCs+34biMnlcscnsozF4Auww0lp3gn5sTMT/8YKZn9a7KEu21sI1BC
         BRP1UE3lCb6prB9ePw0e96lEdlaO7TGWpmMNvdnJlUrdwndgAJgQwpplk8Nj7wzHxN0k
         4p+g==
X-Gm-Message-State: AOJu0YwVnbYiRzfccudNbk4RvFopcnIlcN4KJqRDp7YzMWEjCw4gHHON
	1s1ZRgnP7C3nuwXucqWXq5jLM/2P/PBtTQ9+IQuY01OE+FYLyewLpo9pv+ja
X-Google-Smtp-Source: AGHT+IFdXnxOnMbGwzxaYd6I8d6T+hCcluTpMWLMx7ijmh6AP/hcRS0yi7MX2/uHjr0MJFi/fnC9RA==
X-Received: by 2002:a05:600c:524f:b0:412:9739:717a with SMTP id fc15-20020a05600c524f00b004129739717amr1711237wmb.12.1709113466698;
        Wed, 28 Feb 2024 01:44:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b004126e26f756sm1525546wmi.43.2024.02.28.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:26 -0800 (PST)
Message-ID: <0f1ce130ce6fa868ea35ee7e96fa00aa52cc1435.1709113458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:12 +0000
Subject: [PATCH v4 06/11] commit-reach(merge_bases_many): pass on "missing
 commits" errors
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Dirk Gouders <dirk@gouders.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `paint_down_to_common()` function was just taught to indicate
parsing errors, and now the `merge_bases_many()` function is aware of
that, too.

One tricky aspect is that `merge_bases_many()` parses commits of its
own, but wants to gracefully handle the scenario where NULL is passed as
a merge head, returning the empty list of merge bases. The way this was
handled involved calling `repo_parse_commit(NULL)` and relying on it to
return an error. This has to be done differently now so that we can
handle missing commits correctly by producing a fatal error.

Next step: adjust the caller of `merge_bases_many()`:
`get_merge_bases_many_0()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 9ad5f9db4f7..ddfec5289dd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -131,41 +131,49 @@ static int paint_down_to_common(struct repository *r,
 	return 0;
 }
 
-static struct commit_list *merge_bases_many(struct repository *r,
-					    struct commit *one, int n,
-					    struct commit **twos)
+static int merge_bases_many(struct repository *r,
+			    struct commit *one, int n,
+			    struct commit **twos,
+			    struct commit_list **result)
 {
 	struct commit_list *list = NULL;
-	struct commit_list *result = NULL;
 	int i;
 
 	for (i = 0; i < n; i++) {
-		if (one == twos[i])
+		if (one == twos[i]) {
 			/*
 			 * We do not mark this even with RESULT so we do not
 			 * have to clean it up.
 			 */
-			return commit_list_insert(one, &result);
+			*result = commit_list_insert(one, result);
+			return 0;
+		}
 	}
 
+	if (!one)
+		return 0;
 	if (repo_parse_commit(r, one))
-		return NULL;
+		return error(_("could not parse commit %s"),
+			     oid_to_hex(&one->object.oid));
 	for (i = 0; i < n; i++) {
+		if (!twos[i])
+			return 0;
 		if (repo_parse_commit(r, twos[i]))
-			return NULL;
+			return error(_("could not parse commit %s"),
+				     oid_to_hex(&twos[i]->object.oid));
 	}
 
 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
 		free_commit_list(list);
-		return NULL;
+		return -1;
 	}
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
 		if (!(commit->object.flags & STALE))
-			commit_list_insert_by_date(commit, &result);
+			commit_list_insert_by_date(commit, result);
 	}
-	return result;
+	return 0;
 }
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
@@ -410,10 +418,11 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 {
 	struct commit_list *list;
 	struct commit **rslt;
-	struct commit_list *result;
+	struct commit_list *result = NULL;
 	int cnt, i;
 
-	result = merge_bases_many(r, one, n, twos);
+	if (merge_bases_many(r, one, n, twos, &result) < 0)
+		return NULL;
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
-- 
gitgitgadget

