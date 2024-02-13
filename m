Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86D224C6
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813719; cv=none; b=Im5T/HJf8tjz3FbAsYqx16/MlnMgERkqewz2MPqo3yWOd75IIDy2W+mDfiADtpgT5v2SrwKC9juVeq/XTMysn9rIR2Ycx1Buuk38+NLAmtVgz/5aGqCodf1Yyt/PuYmdddnrpahXKaY9osEdIJfXgkm2m74fmWG6kLuZVovegR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813719; c=relaxed/simple;
	bh=JGK/3U+YVHbi42/87+8D4qb5BXiukQmXCkiwmW06+L0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y3Z3FyGZuyYODiCF8BSEkKCzxVUw4MfwXYSYdOkxp0pSGc7WGH8oMGOrX0rqVlQWjOv1S5/u0wX4WAcLI2KwkZ/+BIJe7Xqnootr/yn2fvpFv/MVgSrqGXRqCT0dXaQ5+l4pfWdlCG0zgq65pwgegw+hpMvRlZPLlfZ+/1qt5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hypQ5M9c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hypQ5M9c"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-411a6ceada8so8477985e9.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813715; x=1708418515; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAXaQat3fAdnCzzf/SoTPVQfaVFuwFz0Zd8u1TmWe1M=;
        b=hypQ5M9cv8AonhkgJJ65Pj20D9N9F2CI6kD/LF3OSkWNgSUXSB/nBCK3Xu6JLz5DpZ
         N1o7hCSDcWu1+Zxvj59qJx1E8w6w5X7ulZxWc0Wh84yeXYvPWd4edeyLVbjCjrXJqGa2
         5gEIi1wNVApu2s1zFw/G5alpQZADN4zDIYQ2u8HBB86QdeZyBQ9/jX3ZbaWdFbIToJ7k
         J9zLCivTV7AU665cQqUe06ozRkXRA8zgcMawlBAs831NBJIkCIaKuyR5mtkRPf6bxHz8
         psz1ZRmnm910bpRicbL1BgLF7vzYlf1yKG3Hk+ObwCuJZyKGLE+ZKAGBKZ6vj/qd+4S/
         gXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813715; x=1708418515;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAXaQat3fAdnCzzf/SoTPVQfaVFuwFz0Zd8u1TmWe1M=;
        b=SxB2C1q+vvJ/ZTYzB6lZRke5A57ZhPe3T4k6W/Pghu10k/IcKBhv7WLpGyoglcDREt
         xTtU7lBNVHmtBV4KxsLBdC+g6hheYAVu8JZN1yh6MQ3rXMbt53m2rQZ298/wkXg11pok
         0vvIsUX6EzV6mhx5OCzSWoSu7a1IvS/JHRm9uQy3qIwB1OYBx0AyEjKPuF9OKsJTG7GY
         JILR3SwuuDMVSPYxY+0YS8KniTYEdyzooEp2jUbip4KbR9PW/tKNvV7d8lvoXncen1W0
         iTPPuUJ5pBRzhT3C25dcR9bFu3CPG9/7BI3sNUiwrz7KIZiwGKYpuRhw22lZ0WN5IYKB
         qacA==
X-Gm-Message-State: AOJu0YyPVXfbtagDed86RwID/I3JocRkv+r2V+32L2dDJvd5Q+lVsLg/
	fMjGiMKAWZiO90FucAqU5JVVAtdqw5jJ1eSIiWLaQiFldudorPN6NwEmLwAL
X-Google-Smtp-Source: AGHT+IE71+mhXCmkFw5LD6aTVtL57RGkXyKtMqGig7sWIwDHjhxcI8SOfK9NJHfStzS2etHg4nwDtw==
X-Received: by 2002:a05:600c:474d:b0:40f:e40:b53d with SMTP id w13-20020a05600c474d00b0040f0e40b53dmr6611887wmo.1.1707813714970;
        Tue, 13 Feb 2024 00:41:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0033b60bad2fcsm8837068wrw.113.2024.02.13.00.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:54 -0800 (PST)
Message-ID: <0aca08a2cb5d679dc4d5dd9401f989d026c80b5b.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:42 +0000
Subject: [PATCH 06/12] merge_bases_many(): pass on errors from
 `paint_down_to_common()`
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
index dafe117036b..c9969da8c6c 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -129,39 +129,47 @@ static int paint_down_to_common(struct repository *r,
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
 
 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0)
-		return NULL;
+		return -1;
 
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
@@ -399,10 +407,11 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
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

