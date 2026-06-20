Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E180B640
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925519; cv=none; b=RtVfprLy289muhhlxrEiwSJVmfQ52FtCV6mG/cy5H0+aZx9nxt2BJ4klo3mXKOp8LYxnNgQmUhNQTiJ+RwmiT2KHYCVFDIw2gKfyFItwfIp9xl1/g8/WNapTEFfMTOnuNpnlzBzkVO3U7ZKVMnButmz/USdSzOji/PvIBXeLJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925519; c=relaxed/simple;
	bh=DU9Cprwmd2+xSbtmXpWEYm53nUuTm9NjCfbmh8HLy40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok3QGC9+YQenXktTvP+AEpbJv44Gjro9DSe58jBUDPrlyUV0FH5Rj5DP8MbM49loqB5FnJTcIqtCWO9lKwFFFGP7WCctKOcQbCB5/++ZWjJRj5jaVrdrosvSM9cttI0sfPaQBvBJSm11JGiH4tiT6D/1Juz+VJ4wdL/OnNC7qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPR6ilaj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPR6ilaj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso29061905ad.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 20:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925518; x=1782530318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SobQWarWo/c7K+PsEC486yIhVGr3/v/fBon73Us0Hy0=;
        b=SPR6ilajcOR5HmmLwCiiLKJ1F6G1AYlMHdGTGTPlDF5nziaQ8OorkFNehu8u6BJYv5
         BDC/EYboxCpFE3oKw7TfovpafeMHxRZZnVDzLkPsTAqfSHzl2Okbx4nrpVvie4J/V+Gr
         6/KVS3wx0Kp4S1JU3+GKCj24ucwfjWT0cNOe054wbAu5TUOXfcXBiBLEcyE3psvr69lw
         dqI1PnxQb/6YFZHkg0lZ51OgS2kCBQC5fmYDRBrVyqN1cMFVfCdiDokfYlVJOxQNmq1f
         zozuBIdqyWA1C46ntd3O/x7SH3Uu/1tiH+zOg8F6jmrzmHvrlfgu/b6sM5KX7QMUe/Uq
         xAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925518; x=1782530318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SobQWarWo/c7K+PsEC486yIhVGr3/v/fBon73Us0Hy0=;
        b=a5AneVWqWJ1CCWKDulmbks5G6PCpmVXnDOkX7EwrY/lScDWmnJhQOZRLjxY4Umj3a5
         JNEhoSGYZVjRNwIfW4mbdsxO7K5UvINPREmSx6Y+Vk7p+VPmT0y0ZcRmS0kUoP0pmFbY
         jE9iIg5kFFYI0zURTDXZsA5F+1AbrHsrgxJTmnBYW8tLfwgq/krc3hkH1Q5JJfGl8WBf
         S3fS+t48m+d9rB56cpTJIe/PJTwGHabnt7m4s9DGyBR2ZV3q4aTE3mT3P66/51daAZqc
         dKzqt35Yya0qgOSd9CdbRxJCjsJRdgd/gYqNYnFtWAcKgAYES8zPzlpWq3V/LVExAJe6
         rRKw==
X-Gm-Message-State: AOJu0YzOswptdLqSLigLd6HpAQIX2Orjl0gXE6j4hdCNPdNDYP+rWFJO
	Wk3y6v8wdm4mB1/Y5+FgG/pDPi7Zmk0gesNuxtFPTmFQ6kbnG46M0ZONYj1EpQ==
X-Gm-Gg: AfdE7cn3mH3Q7k+8Ameeh0OnbeUmu3ORwu2h+KjDyw7Fg+40zQ6MGGUyKddty4HRSDz
	aEJ7kiDP5okxMQcil3HZCKdstBj9c44XGsLbZoZLPjjyWmIGHW0eJS9H6xGoYxmEaoRp6vmUJuo
	qptqXxMAHZSvTZdYTr4H7YJV8orFl2/Ygjt84R2rCv6IrE5QmZxSeqE31LhhV0wUkSVtn/3WevM
	XPiBB5KSvsLHtkk2OrAhYy7EIAtfJej3/QepLcw9CfYcPrEBOvb7RbG5WwZQKp8TPBWNzHevfs5
	ECQfFS+1aqLpvCRq44UU7RLhlSg/bW1uoGAgNaR/mEuP24RbhEzLKH7IhK0rtdvt/0BSB4Ajk0C
	RyFLyhB5i1/Rj+4nNxz9IAyaxF/9MqRKlUsN/IRQAa6w7BaDPN9NIBaInSGZj9vV0wEsETE9jWN
	LzSKpAtoxVGropI3yDjvbC2f08aHGFh7LefNJ5KE2CEEndGoKXrTDREvty395beDDMsD/Vxu1uR
	umSULAZPOHFMyVuBxA=
X-Received: by 2002:a17:902:ebc7:b0:2c6:ad70:d870 with SMTP id d9443c01a7336-2c725bf1e7fmr57421285ad.13.1781925517705;
        Fri, 19 Jun 2026 20:18:37 -0700 (PDT)
Received: from jayatheerth ([2409:40f0:f:5924:9ce6:f181:f81b:c57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af590sm9581675ad.17.2026.06.19.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:18:37 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v6 4/4] repo: add path.gitdir with absolute and relative suffix formatting
Date: Sat, 20 Jun 2026 08:46:44 +0530
Message-ID: <20260620031644.353772-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
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
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 36 insertions(+)

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
index 09158d29f9..ae8c22c817 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,4 +207,10 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'gitdir standard' 'gitdir' '.git'
+
+test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
+	'.git' \
+	'GIT_DIR="../.git" && export GIT_DIR'
+
 test_done
-- 
2.54.0

