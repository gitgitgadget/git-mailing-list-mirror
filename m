Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB4175A83
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062822; cv=none; b=CAGBIWKLZH20a+o40zDnzUsEDgd+QR+770EbXsOmSOkoFRP0cQRX3uI7yXfBEd9fAVLbM1LHNBmUILO2HVygf3BgB0RShp5O5ts6kO+5HmcX0V8jPkbpW5CAAiIYc0p5e2t3TP1BuH6hM5WhZcYRAmJzPe78c97F1pumIUpZJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062822; c=relaxed/simple;
	bh=D0UzlKS8KNciqFkG/qLNPAwNkJ3q5dFcRzV5tqakWDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs3pfBX5a0M9pLE6fzCzgThzzIlEDDtrZztLIo1M+QftJP0ehMQC4ES0ZXHCY2HOUH0KPPHmz1oh8nKfV0aBr8k40ginDY0CIJg4Wjazyru/AjCM/YvL8IWWX8JH93cRRi34NFBa4B8qnT38RMbzz/GKlKR+6Rfuksd343x1hxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TerqrqgY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TerqrqgY"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cca0c5799eso16479465ad.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062820; x=1785667620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zay3cx5eKZG9Q9J+UQQRGifWu10M72QE9f/xrYkNXBM=;
        b=TerqrqgY5vjAHV/9JKSWf8+qinB6rpi+nCG9Yt7m4HgTOYz9YPb8Bau0PyVyCuHzy9
         TlYEwnGesljjTFeE0QtDROea3MLrIa8nreI6vXwB1FEFd/BDHtYmGi9k8FkF9TWPnVNq
         3wabCZPujByz0L/lK4CX0XVgkd88pv/ihwIQfc/ajTeUTkYR5Wakr6meHv0Fx8aGvqMJ
         UQi1cvM0vWufmb0Odi35EOgxRZEpeR7+WwpaY9MOHmcv55uZtba6mpBa1F6ZbZGAUDle
         bnwpKzTynv9LzdqECdQScMAUUh0iRMGbX4qBoPuIP8h+Wqqfl4vmCOhcx1r3zw9CahHT
         qH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062820; x=1785667620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zay3cx5eKZG9Q9J+UQQRGifWu10M72QE9f/xrYkNXBM=;
        b=gHBLtjyI8wCZBCtjqfxYaFDVPMdMFR4dfUvfkjv8/T0e4eMJdCjyQ7ZqjbdtBZNAAS
         xiqpFm+x+0dpKNZp7Nu92YN6y3rp4acR4T6CeKSYuLjDqM1Yeufk/T95BCaoBb2e0l6M
         x+HLY5uR4Jy1lVg1pX0PTfRLkfuD+sN7C4fe+A0Zl0qKzThvVZc1kuG/sm3VT6MSk/gM
         2Tr6GVk2PqQ0a3RaUD8OzsPD/4+3Fq7v+qJsYKsaW/i9FIfNIkba6fHIQxI5CtQ8lsy9
         oLL54t7SrRFsnD5/B5FS1bvXkL1pUllpT+lpuLa6RZ9gH0cuD7DoPA1EvcpUKUJt+IQH
         FSCQ==
X-Gm-Message-State: AOJu0YxoMVgvXkiYoEq5mCMskZP7QSr0e7kJ85hbq7to1zQDhUn+m1XH
	yfLRFR97ZyKwtOU1mn/rEHyvkZOsU3SVnpxIk7+NGMfRSDIpV/MpRWGAELYuaA==
X-Gm-Gg: AR+sD10z0ue0wyarO8PBHmTvbfzAdai1NVEc+KLqGiJbEk842NlU86yX/c43DPoOcVm
	17UeDCUbv3NBmIO4KHtrHFFQPzG/+P8/b3ZGomrYG2cIcTyd5MaqH2kDKor8ZutHHLgF2kpOF2z
	fuSjdbMaW93cWulm+xbxe50O04/yNTnDcdfj8NoxRbHFRQkD6zZLZgJWnsNonxst5jDQ5D6UOQH
	O/ibImuzhdhgAtg0xMg3oWBz2vR2EJ9+3gpa2ktPGI+Dg2Hl9qByri7KNL7Jz8vAZlfmB/nTjwV
	SAjVc/3DSkA40lF/PkEqEqMN4sjYTA13mIYYivui3CoyZqRGQcMoc03bg3ACQdroT8Q42YOTsPr
	svqj7zVxaZ3QwloZm3vMx1yBS2tg8Sjh3469XLllduPVIHthatXBgj6O2t9knXbiyyXqSpxZ5NF
	RzJ++KedhZ1Wikj9OkxlSPc1/Zr5HTXYVw5xckQaS78g09V+oXFX2EmUSzb3+u/hnLu8Qsf20o2
	jA1nJEPbzAu
X-Received: by 2002:a17:90b:5888:b0:387:e0db:bc30 with SMTP id 98e67ed59e1d1-38f29784481mr4463257a91.38.1785062820152;
        Sun, 26 Jul 2026 03:47:00 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:46:59 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [PATCH v3 3/7] repo: add path.objects with absolute and relative suffix formatting
Date: Sun, 26 Jul 2026 16:13:39 +0530
Message-ID: <20260726104343.16933-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tools and deployment hooks frequently query the location of the object
database directory. Currently, this relies on legacy parsing methods or
manually inspecting `git rev-parse --git-path objects`.

Introduce `path.objects.absolute` and `path.objects.relative` keys to
`git repo info`. This allows tools to discover the object database
location safely while natively adhering to active `GIT_OBJECT_DIRECTORY`
environment variable overrides.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  9 +++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 03aa57942f..8429a44b43 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,15 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.objects.absolute`::
+	The canonical absolute path to the repository's object database directory.
+	Respects the `GIT_OBJECT_DIRECTORY` environment override.
+
+`path.objects.relative`::
+	The path to the repository's object database directory relative to the
+	current working directory. Respects the `GIT_OBJECT_DIRECTORY`
+	environment override.
+
 `path.superproject-working-tree.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index 82359473e9..d6bdd5bcfa 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *obj_dir = repo_get_object_directory(repo);
+
+	if (!obj_dir)
+		return error(_("unable to get object directory"));
+
+	format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_objects_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *obj_dir = repo_get_object_directory(repo);
+
+	if (!obj_dir)
+		return error(_("unable to get object directory"));
+
+	format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -194,6 +216,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.objects.absolute", get_path_objects_absolute },
+	{ "path.objects.relative", get_path_objects_relative },
 	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
 	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 220b3d4d3d..260f4fde43 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,13 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'objects standard' 'objects' '.git/objects'
+
+test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
+	'custom-objects' \
+	'GIT_OBJECT_DIRECTORY="$ROOT/custom-objects" && export GIT_OBJECT_DIRECTORY &&
+	 mkdir -p "$ROOT/custom-objects"'
+
 test_expect_success 'path.superproject-working-tree absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.55.GIT

