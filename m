Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2A2BD59C
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499182; cv=none; b=Zs9nTj2Z92FDJ6uIKOhepnjgAM8u/7n0T/z4Hbj/Yk6cCLGfgxbnal4GPypyhIB/6I0SwfrrHe6VYiYYCxb9uqytbWxPNvjrOeUX1ERXt+RP7gfGZ1Bm2ikgeOFWfVXte0FA2v3BhTiqL1iTBx1w/H3qUngEcwSfjzEap5uiTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499182; c=relaxed/simple;
	bh=Ar0xMPrci5M0M3j3zUc5uNgVXTwJhZFlYEFvwn+0wFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHgF7yDDP5ywxRJ/rLQLgSNyGJ01qRHRZagV2+Oe3sB+qt9ZGsmAOcGNFDpevIBFd1JPn6lHy8D+vBRQkCi1BRN36wzyeDEsK5focYeL1M7V40YzOqByUM1CVjtX9QRn+Hbn9mAmspmK57ryKgKznABppQwvoajViZ0+VQLVo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnV4ZNEl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnV4ZNEl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c35980fdso30024825ad.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781499181; x=1782103981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceZ7PCxwVYDSZomYZDPjVRtMkn1K1jN1cRa6GlcfuLk=;
        b=KnV4ZNEl0nnpmf4UPvuwbYeRYDU33NcJH8c/nkoGMwSLlTFIg3mFQn36M/EAMo7KEu
         1yL/00YRAKBgguZfFP3qhNaKWrA4urdlKQ3Ql8albtbiQv9oW11YZTs0Ekguw47id8BT
         K6a7inLZ3qlaydXYFmHEfQK+SN6NuNxZbS1oWfhPNaQShVhQ5KgfmwDkR9sadEpCr32P
         aMp5R9XBx0v+E74osVdgXRQr0tDk+IYfFWJW1p7TDK5luF+fIbtPlgzkETAG940n5uoF
         K7xpoadMrPSgNFpyaeOv510hhHWQfDPNSilRpSIDwmqco7edPMRJS7ydZMB/ovx5SdpG
         RRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499181; x=1782103981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ceZ7PCxwVYDSZomYZDPjVRtMkn1K1jN1cRa6GlcfuLk=;
        b=XlaytfgWGkNIw31zT6jxfQFWmuUpbyhPcjN3e421NOwwOpW7rVo0SBGJZVifGM/+dg
         +AL2kqDktYsVyQaLLMtr47kg8Kor+xlroH1ZT1kDhhH8yLZycAQtvaCddXDgBLw8we6X
         y148jKFkwQw2M5oG9q0j+sJ/UCRl6UlQAQBQ3dzazQ/YybOPjNMVgZspwxVfsO7a1vJI
         oinpJjgV/aYNaUwR2oo1gjgKgiPnWBNBMYcawVdboXQAkOSR3FpE4R1s+IR8/V+5RuVS
         oDi+XnyXopm7iCaI6PGxIgPBT5tYAawTcL8f8csgRnU6cC9+wa9pOfLIL+GHORMSM6Fe
         UP7g==
X-Gm-Message-State: AOJu0YyAqXfAaJS1v+QkuaFW5AGyA7plKI50fx0Y3SKPxHiqbp1w7VO2
	0GjIvbqznIYau/Rf0RgN8zZF6ADDliWUUr4mNVaVnz3VDjUx3xeLzzs2c5onUA==
X-Gm-Gg: Acq92OG0/HGH1Rtgs409H9HsEJ2oKE0Iq5FtOY5LnRBVKWxK4z9HtpnNWnECM6Uy25P
	D/9xLDEbf4n75O5XK9WmVKYOgeIteLYZt/0xMryFBn9IE41VWDOYlCUIq49lMp1JX3xAXoz9X8U
	vARnp2s4AtXZJOOQ5yAkyOjXHECn6L1EL8HIU2M6olSLvEd5ryA5ee+gXraqzMYAuEcXzJEBtSa
	S079znz73JamCXivCDdFckPbRtynDJA8GwPD9GlviMm85k79CXaDk2j0YiHzWI2EonzUtd5VdCe
	zBvXHU/t36X3FIksoIkEVZfOMwNNwIJc7I3Jaw5J4dDk5m11FbHtZFvP1EVwwfMg+ahXkcJeBhl
	YlH8CoNuW4WeFEGevdGCBJdL0MZV5dUGatBt2BQhhvmQRoVrqVW0dYpsZhejA7t5zt5zlgZGLub
	PkAU011/ICUl8iUIKsbw/87VeL8Jy2x7VNcY10TewBJ8jXZXWlXU46+0cu9FJ+FRCHWgRltynEF
	Q1YF7bcR8MTXmQVz6NhJbbo5XBdJf0IyQ==
X-Received: by 2002:a17:903:2ec5:b0:2bf:82c:6322 with SMTP id d9443c01a7336-2c4109ed471mr123672795ad.3.1781499180569;
        Sun, 14 Jun 2026 21:53:00 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c1fsm85528075ad.53.2026.06.14.21.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:53:00 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v4 4/4] repo: add path.gitdir with absolute and relative suffix formatting
Date: Mon, 15 Jun 2026 10:21:12 +0530
Message-ID: <20260615045112.50686-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts need a stable way to locate the git directory without
parsing rev-parse output or relying on its flag-driven path format
selection. There is no way to retrieve this path from git repo info
today.

Introduce path.gitdir.absolute and path.gitdir.relative keys,
consistent with the path.commondir keys added in the previous patch.
Reuse the test_repo_info_path helper introduced there to validate
both variants.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  6 ++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  7 +++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 890c34051d..ed7d80c690 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,12 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.gitdir.absolute`::
+	The canonical absolute path to the Git repository directory (the `.git` directory).
+
+`path.gitdir.relative`::
+	The path to the Git repository directory relative to the current working directory.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index c4cc3bf3fc..9a312d127a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -99,6 +99,28 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	append_formatted_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -113,6 +135,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.gitdir.absolute", get_path_gitdir_absolute },
+	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 0c0228687f..45741fc9f1 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -216,4 +216,11 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'commondir-only-gitdir' '.git' '../.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'gitdir standard' 'gitdir' 'gitdir-std' \
+	'.git' '../.git'
+
+test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
+	'gitdir-env' '.git' '../.git' \
+	'GIT_DIR="../.git" && export GIT_DIR'
+
 test_done
-- 
2.54.0

