Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE971B1504
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899885; cv=none; b=FGRiWRVjfFw8v3sdCwLeJJRHJrrH3pszdePVp9Dxt8KSo1dm7z8KYMpwIwg+mxBTqsdSnREUrnXgMaM+vITb/7FQjvzkd2qYmx28hwSvqP+7kHVR7+FQ/E/QzbLV6N4UT2MH6M/QNvtqL8H55oNPfaFQvWjRS2WNvSs9/tycjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899885; c=relaxed/simple;
	bh=07NigRt+xJMRU0aPtLAADx+e6Ez/EWmQhryI9FrwenU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gbFLJ3a5wSi4R/WGVZpoxn8Y7KTEpxFKugBbuQrK+vOb761TTRvFtMjIIAOBjYiSMw3lFa0TFChAl7oOyznrm72tfL2ygDo7qcxnqIxcmMXvO2bohDMTlkwPYiMsx8C6QZ+58jEBuNMKvzPdujk1PKNoD+K0zozSf4tbVyMWbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COo640Yt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COo640Yt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-424720e73e0so10847325e9.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899881; x=1719504681; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKX2JwFsPPiLvIMv/wmeUwRInuRMu/l+CQXu3Cj+z+o=;
        b=COo640YtdUt8qoZ2zzm0HcZAifOtzscL+NDD5UfttKmL9Ovurw+CESOtVjDmVCATXP
         KI1mD1bTww82fGHcibD6MKOIo8WzUdLbABF5Cq3dRC/8Nx1UiwhtzK58jrX0QeDEE0lK
         OKsIyEoqJmkHTyX+Y3HwloRrFyGkZ6hRO+dx/Evvey+5UgmZKApebxkjvq5LmRnzvrEc
         FP9Lq0M5uTuo414e/aBbic1lfFTg9miBSADU4kevLuRdby0VdBv35G8H4e/orOpEz+pu
         g6eKYTZZzOUTe1pNrDu5CqmNucSk4Ngf9i7Ditl+HriL3gKQK1XqLttP0U95/hLY/qUA
         lQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899881; x=1719504681;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKX2JwFsPPiLvIMv/wmeUwRInuRMu/l+CQXu3Cj+z+o=;
        b=QcD6kJwWdkdcBJHpItP4IHJ4jo4hW7Xpohtd0UPoFipY3yXkSRzw7JNIqrzbjx6IqP
         0Q5gL+TqY760Ivsb9o2c55h/lQ5BXOAd4f9RSFNdOHrjSigeAftufDNgblXSDtccriV+
         8uZe9YXmPp2eMJmrhjXcfGbJSXbipE/x3lV9OEPBQ6KQiv3hl1TsPmyKQ7zY7qD2l7jl
         VTN/O0RqBQRhYXDJmqpOx6qjTkoVW4NxBhP092ZoiP0jx/oFulYrjDyWp2KgsmjLvDJV
         YFzNcI6+LVIqCTmi3m32uzL/v5sCRZKafs+3+pIsdgAvI8QPZSd4XmigW2sA7MDKSOaa
         1hyA==
X-Gm-Message-State: AOJu0YwLXR7dPmXRhVta/6fgbZROFSrzAfiPLgRuZ7p+/1Bk0MxbQueC
	6e4v389rLcOv94rBvaDOdJ9ZFV4umaxFaKpnt+hY+y/DWrqFj0wO/6CXvA==
X-Google-Smtp-Source: AGHT+IGxLPy9YTa6XApqDH037Wl9tCkjxWvcD9pqG4mT2Are4uJFDSI8sWNDgVdneegZ8wXxHYdMJA==
X-Received: by 2002:a05:600c:3b87:b0:424:760d:75d3 with SMTP id 5b1f17b1804b1-424760d772cmr43243895e9.8.1718899880787;
        Thu, 20 Jun 2024 09:11:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-364dac4e70dsm1909605f8f.5.2024.06.20.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:11:20 -0700 (PDT)
Message-Id: <7c3b545ee5ea3a0e6686594afe582fa1a19929f6.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 16:11:14 +0000
Subject: [PATCH 2/5] sparse-index: refactor path_found()
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
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In advance of changing the behavior of path_found(), take all of the
intermediate data values and group them into a single struct. This
simplifies the method prototype as well as the initialization. Future
changes can be made directly to the struct and method without changing
the callers with this approach.

Note that the clear_path_found_data() method is currently empty, as
there is nothing to free. However, this will change in the future, so
place the method and its callers for now.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e0457c87fff..de6e727f5c1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -439,8 +439,22 @@ void ensure_correct_sparsity(struct index_state *istate)
 		ensure_full_index(istate);
 }
 
-static int path_found(const char *path, const char **dirname, size_t *dir_len,
-		      int *dir_found)
+struct path_found_data {
+	const char *dirname;
+	size_t dir_len;
+	int dir_found;
+};
+
+#define PATH_FOUND_DATA_INIT { \
+	.dir_found = 1 \
+}
+
+static void clear_path_found_data(struct path_found_data *data)
+{
+	return;
+}
+
+static int path_found(const char *path, struct path_found_data *data)
 {
 	struct stat st;
 	char *newdir;
@@ -450,7 +464,7 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 	 * If dirname corresponds to a directory that doesn't exist, and this
 	 * path starts with dirname, then path can't exist.
 	 */
-	if (!*dir_found && !memcmp(path, *dirname, *dir_len))
+	if (!data->dir_found && !memcmp(path, data->dirname, data->dir_len))
 		return 0;
 
 	/*
@@ -472,15 +486,16 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 	 * If path starts with directory (which we already lstat'ed and found),
 	 * then no need to lstat parent directory again.
 	 */
-	if (*dir_found && *dirname && memcmp(path, *dirname, *dir_len))
+	if (data->dir_found && data->dirname &&
+	    memcmp(path, data->dirname, data->dir_len))
 		return 0;
 
 	/* Free previous dirname, and cache path's dirname */
-	*dirname = path;
-	*dir_len = newdir - path + 1;
+	data->dirname = path;
+	data->dir_len = newdir - path + 1;
 
-	tmp = xstrndup(path, *dir_len);
-	*dir_found = !lstat(tmp, &st);
+	tmp = xstrndup(path, data->dir_len);
+	data->dir_found = !lstat(tmp, &st);
 	free(tmp);
 
 	return 0;
@@ -488,9 +503,7 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 
 static int clear_skip_worktree_from_present_files_sparse(struct index_state *istate)
 {
-	const char *last_dirname = NULL;
-	size_t dir_len = 0;
-	int dir_found = 1;
+	struct path_found_data data = PATH_FOUND_DATA_INIT;
 
 	int path_count = 0;
 	int to_restart = 0;
@@ -502,7 +515,7 @@ static int clear_skip_worktree_from_present_files_sparse(struct index_state *ist
 
 		if (ce_skip_worktree(ce)) {
 			path_count++;
-			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+			if (path_found(ce->name, &data)) {
 				if (S_ISSPARSEDIR(ce->ce_mode)) {
 					to_restart = 1;
 					break;
@@ -516,14 +529,13 @@ static int clear_skip_worktree_from_present_files_sparse(struct index_state *ist
 			   "sparse_path_count", path_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_sparse",
 			    istate->repo);
+	clear_path_found_data(&data);
 	return to_restart;
 }
 
 static void clear_skip_worktree_from_present_files_full(struct index_state *istate)
 {
-	const char *last_dirname = NULL;
-	size_t dir_len = 0;
-	int dir_found = 1;
+	struct path_found_data data = PATH_FOUND_DATA_INIT;
 
 	int path_count = 0;
 
@@ -537,7 +549,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 		if (ce_skip_worktree(ce)) {
 			path_count++;
-			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found))
+			if (path_found(ce->name, &data))
 				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		}
 	}
@@ -546,6 +558,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 			   "full_path_count", path_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_full",
 			    istate->repo);
+	clear_path_found_data(&data);
 }
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
-- 
gitgitgadget

