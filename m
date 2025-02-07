Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209821A8F95
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926217; cv=none; b=CvwZ4TLZ8nTwHmC9pOLfAN+TsCl2c0jzsb5HNGq8ar2Vf+DZbkFHkRADaP3BJa9l1Z/gKp2wgUxm2Pvv/TsIlCY8dSHQ9AZdk8u7GYdazWaLB6NQzkC22h39aXbqbYyt0M/LNQFFKGXQ8j8MP95KPxgBMZ5frCgQ2iWM9yuu+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926217; c=relaxed/simple;
	bh=sYa3nIgsAf4GP56J5HRLtn5O2XHpN3o1UYlZJnFqLjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUx3gZqjsoKFztUMwb3rGqzQqEGJLLmHq3l9XrZoruejzuviSy3get5rrcnLf1eH4ASbCEw8zO12eNxxzv9ufBRthi7G0sGndXdnleVxzbI6KwngSXwUaPjuCXc2HYx7z3bZUMh4MbmYtw9uLtp42YsGY2ofdK4Eu5om5y/g4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=swtM++wp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UoGU2qNu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="swtM++wp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UoGU2qNu"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32BFE1140120;
	Fri,  7 Feb 2025 06:03:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 07 Feb 2025 06:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926214;
	 x=1739012614; bh=pYK7Bd1FS9gnA/ZUoQDPI7+8FtCkj0Q5dd5aZA/F2o8=; b=
	swtM++wp40LschpZuXKE/FTMB1nhdjGyxHKY0qMkxOKDC1m4YXt0RofJKGv+TJ5x
	zKGEbWvP6d+SpqQlZ2Mf7fLaZPwYU+jZ4X6qLyuEttPS6SOf7SWdM7D+QhwzT1Ee
	H2GY9Ipl0l863d3/IPa87c1FpzeUeK7MtBrZzDYKwlGz0pqoqbf4MreUcIHuxAGO
	sBwmNFUxqsCvq2wg8IA1+2tK1Mh8aACP7YLQlWuqgBk5KRx7k0wABHvboWMB3ZqA
	i6RcczLrmKa13/sk+wQPX/ARSYQ+WT4tH9njwiWBP8B6FXk1jXSqLT742KR3KSgi
	G+PZolmgIVbNzGMe96Nomg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926214; x=
	1739012614; bh=pYK7Bd1FS9gnA/ZUoQDPI7+8FtCkj0Q5dd5aZA/F2o8=; b=U
	oGU2qNujPcabFWe9m1t9m/UQoEyEStb2fekDLto/gxNs8eM+PyiGJ/qIgM4LnQuz
	oJaL3Hh1IOuA85HfGOsY0cuFZYYWmIPH1ADZ1mMr/QPb01usPZz2hxWgDUqc2Z13
	ZfqcIw0SobX+8brlOymBvEBe8DzHOzrAzHjLbnJq2Q4OOuoaMNzk62wrOhVG1Etk
	qDtz5TD4e7IwlpCFzWzaOcZKPFTjKzJql88RTRFG/QVJ4XEOaFdaQpUVu1o0TG6L
	j7UNIKP9FFtV5XGxCdBV8CIC6wEgQRb0xLwaQ3M05evKQTmqC8OWVhOkYnHdXXGu
	yhtR40ZZmak2xnFcsFhog==
X-ME-Sender: <xms:heilZ_OWkTM890flF9GxD0SsFUE9UiWo1zFH_MgkWkSVRlbxBkmKeA>
    <xme:heilZ5-zleyv-APtZgryOI4nGbYKdTFIlUyLmfX0Nk6rdlswB06VkFT1hT1r_0o9h
    uXvV0IrTxaRFcWT8Q>
X-ME-Received: <xmr:heilZ-SsEqt_KAtQDc47MgI7RssD0N490-yAhtOOCjbQs_Hu7zPpYcqNb_KFf1VhMHBi46HhG2PN9_ZxA46iSAz3_C-qmj28aNT_gqeGA7dY-jZ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:heilZzvhW_3Fc8ZTk4lQ46hPVW_ev5ui0kCA8ehURTgdRSa1jROLsQ>
    <xmx:huilZ3esIXUFtcVq3A1_DUUGQzqvc0KdziUPlKLf5lp7XHxjdf3OHA>
    <xmx:huilZ_3049C4wSEvg_pFAvFBitXSsCpRvjyPH5oyx3_7pwxuIo_M7Q>
    <xmx:huilZz8vBHF3PRyZfAMrPiJjOu4bWHoiV8b_vyWMDgawiyAawcMfbg>
    <xmx:huilZz4dxfPDuA2OVlkgc3JobbibmQXmi5flUQNyeHufRVL-ahsMqijO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b56dde74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:28 +0100
Subject: [PATCH v2 03/16] path: refactor `repo_worktree_path()` family of
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-3-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

As explained in an earlier commit, we're refactoring path-related
functions to provide a consistent interface for computing paths into the
commondir, gitdir and worktree. Refactor the "worktree" family of
functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c       | 28 ++++++++++++++++++++++------
 path.h       | 20 +++++++++-----------
 repository.c |  4 ++--
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/path.c b/path.c
index 779aa94b56..499116dd1e 100644
--- a/path.c
+++ b/path.c
@@ -519,28 +519,44 @@ char *repo_worktree_path(const struct repository *repo, const char *fmt, ...)
 	struct strbuf path = STRBUF_INIT;
 	va_list args;
 
+	va_start(args, fmt);
+	do_worktree_path(repo, &path, fmt, args);
+	va_end(args);
+
+	return strbuf_detach(&path, NULL);
+}
+
+const char *repo_worktree_path_append(const struct repository *repo,
+				      struct strbuf *sb,
+				      const char *fmt, ...)
+{
+	va_list args;
+
 	if (!repo->worktree)
 		return NULL;
 
 	va_start(args, fmt);
-	do_worktree_path(repo, &path, fmt, args);
+	do_worktree_path(repo, sb, fmt, args);
 	va_end(args);
 
-	return strbuf_detach(&path, NULL);
+	return sb->buf;
 }
 
-void strbuf_repo_worktree_path(struct strbuf *sb,
-			       const struct repository *repo,
-			       const char *fmt, ...)
+const char *repo_worktree_path_replace(const struct repository *repo,
+				       struct strbuf *sb,
+				       const char *fmt, ...)
 {
 	va_list args;
 
+	strbuf_reset(sb);
 	if (!repo->worktree)
-		return;
+		return NULL;
 
 	va_start(args, fmt);
 	do_worktree_path(repo, sb, fmt, args);
 	va_end(args);
+
+	return sb->buf;
 }
 
 /* Returns 0 on success, negative on failure. */
diff --git a/path.h b/path.h
index c45311b0a8..d3f85f0676 100644
--- a/path.h
+++ b/path.h
@@ -75,24 +75,22 @@ const char *worktree_git_path(struct repository *r,
 	__attribute__((format (printf, 3, 4)));
 
 /*
- * Return a path into the worktree of repository `repo`.
+ * The `repo_worktree_path` family of functions will construct a path into a
+ * repository's worktree.
  *
- * If the repository doesn't have a worktree NULL is returned.
+ * Returns a `NULL` pointer in case the repository has no worktree.
  */
 char *repo_worktree_path(const struct repository *repo,
 				const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
-
-/*
- * Construct a path into the worktree of repository `repo` and append it
- * to the provided buffer `sb`.
- *
- * If the repository doesn't have a worktree nothing will be appended to `sb`.
- */
-void strbuf_repo_worktree_path(struct strbuf *sb,
-				      const struct repository *repo,
+const char *repo_worktree_path_append(const struct repository *repo,
+				      struct strbuf *sb,
 				      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
+const char *repo_worktree_path_replace(const struct repository *repo,
+				       struct strbuf *sb,
+				       const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
 
 /*
  * Return a path into a submodule's git directory located at `path`.  `path`
diff --git a/repository.c b/repository.c
index 1a6a62bbd0..648cd88474 100644
--- a/repository.c
+++ b/repository.c
@@ -312,8 +312,8 @@ int repo_submodule_init(struct repository *subrepo,
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
-	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
+	repo_worktree_path_append(superproject, &gitdir, "%s/.git", path);
+	repo_worktree_path_append(superproject, &worktree, "%s", path);
 
 	if (repo_init(subrepo, gitdir.buf, worktree.buf)) {
 		/*

-- 
2.48.1.538.gc4cfc42d60.dirty

