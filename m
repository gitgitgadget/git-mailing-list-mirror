Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B113DBA4
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040510; cv=none; b=Jj+Mw7bVYf29r7KrHydMxx2yt4gAtt8la1OHPL5jFFHgjdgb7+Nr96nAAE5XD22KXS5GAIPvHnThMgSPr8DPgF2YpAyasYKKtoFN5GibSuiC36lz8ZbTctBr0Z3gYw2OcNr25YUgjBf3FAZKF0uY/KqdK06bauHPPUzsL/qkiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040510; c=relaxed/simple;
	bh=PUvI8mflEWOq2BwZiRa/nQDGYx9iFMV5Pd34ga33pGg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GUTfNPbAETfxb4iMdpPihxEYDuFNVbMRQB4vINZ+CccMy9BVpu/G75v18WOkemiKDkctEDUU55/p/gwZarlcQiiHkOrefZbZ3wLdE1WZDmTjDZM5YI8lmLbCN/GT8MaFtVffozvyZmmjYsuQbyNadqYiREYLTP7RYW26XvyHC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE7U0P9l; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE7U0P9l"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412a9457b2eso9126625e9.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040506; x=1709645306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls2gfG7/KzRPf3br5sgCg2MiCtFeXyjXvkeYAyegKIQ=;
        b=VE7U0P9l7DB52gUl3oUAxzi7mh0VN4qaTYp+JQ3qldoMbim8CbzZwFuS1I06IlBF+R
         fIaSqgHUFvDRQpE/ZAZ889iEHcM9OvaCDfX8QB2ZcojGykoDTXeFYsPWNpDSg01GtZNy
         9gSWghwux3+sy4f1Hf3Ld8+cbdo77LY0LafP6FPre2ez9+Tx2aCQU4sCEvNEaTRq0+OO
         ydwLR7494Zh6sI+5Opkuu9d7Kwz9bdzCwN97Eo1W0xWSj3yBehqRzO2DGlBBa12ef1G7
         4CEOb4vDrHNxAM6S3hoiyL3k9DNLNtw5P4Zw5QJlENKPZFhRQGg+nxacHX0XeqNQwc0d
         BIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040506; x=1709645306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls2gfG7/KzRPf3br5sgCg2MiCtFeXyjXvkeYAyegKIQ=;
        b=DRbjjaQEnZNllAFnsurCBBAGSa8zxSTogIhoeRgwrGti1SB4N9ScMnPCumd1HDIf6/
         9WCwXAOeraOl2lW/AFuzys1WXKCrTd1xwQIh7CcphIEpgmxx+lL/DdqnPQSFMcHWSrDa
         qhuxdtANSNSAc9hmWEO26JUK8sz539mUwofoAvJgMjkRk9iIR9Il3HjtMdFKR5TfVh+n
         otg9OyHrUfHsrNFv5XrSasjn2WSBKOCVG96Z2MFSCThvUmQXbK+PdqBtyiKINNjNLLNW
         oci7cQVbXNsQM/7cIQQtSEWJ9kK9gj5Zd4hWpf3t5hL79Wz5sHMNqBazlsyerUFPwOPh
         e+lA==
X-Gm-Message-State: AOJu0YyGysFY17HnvGKuRqMg94ZNLmMjBKwSVNhLqcbpMx7xg0ke+06m
	bDY+49QgZcfDyfcoXBPmcSIge91APsytCcvjAykikeeoTustAx+rKk2mfHlv
X-Google-Smtp-Source: AGHT+IF+OX9B5Tgy0rNpllNmLyzkd+0Yb7HxTTNq16qM+FPyejsS5r2vPhgEq0DMD1GPuUpIQOnDow==
X-Received: by 2002:a05:600c:1c1c:b0:412:952f:ca35 with SMTP id j28-20020a05600c1c1c00b00412952fca35mr9176918wms.14.1709040506176;
        Tue, 27 Feb 2024 05:28:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c028a00b004122aba0008sm11159483wmk.11.2024.02.27.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:25 -0800 (PST)
Message-ID: <2ae6a54dd596c3192b5be32f0e4e2605f4aac6bd.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:12 +0000
Subject: [PATCH v3 06/11] merge_bases_many(): pass on errors from
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
Cc: Patrick Steinhardt <ps@pks.im>,
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
index 9148a7dcbc0..2c74583c8e0 100644
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
 
 	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
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

