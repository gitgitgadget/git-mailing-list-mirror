Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC573290B7
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680822; cv=none; b=I5O8WWEsbI8bOeMSynHE60K1FQtub/fNsjn5QwfC8MPz+Oh3XqBo+pjaSrhRxbleubPMPaLO41NyjLeKPCmBsTi4HlHn0tRYMrm8YDGQo1joZXHT4HE1t+3mYA5PArY4Brg9pOI4f6pt5BZGnaiQ/FaAjUsQ7IVnypmO40voZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680822; c=relaxed/simple;
	bh=a8aH//NpbQv0mogRkZRidaPsD+Ps1sqlkTx0wuRiFqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=layIM4Z8STVreS4ByFoUJvFua+FjfdVqS1G1Ear6Wwc/YF2qmG3XgUF9rnrI8/iPP17gvBbGbqtrdaZ6F5WzRcLl25hae1o2GxzW8+7FhOl/UMg+USB2Xqst2c1YLH9bHOpZ/qTd976Livo/qxMOm2eI8MV/fj/uhTPWdOuwbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkhr2DwF; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkhr2DwF"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso33275a12.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680820; x=1788285620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIEGHFrAgohB7I3M+D1RclifJ2/vv7mV9Iq8QzMVbsg=;
        b=qkhr2DwFmCVe/lQwMK7iM60QF1YL/DqjA+qO3h3B6rCjwXGGMn74x+jh/q+dg0kpJg
         700LkITGraZ03kad7OYngef3FUjM4mqA3o37sYnXqfOxJzHbQBFYEoGVf7KITKgNHdLl
         3BrHeNAl6a7dYIXgT0qeCasiko71/pIQlyp+Y+2J9IODFbbi669/4VtercA7RLob9G7F
         N864rph60L7kz3iF7iuVp/cywDUhPGMr+DpTWwULEJK7deyGu1evfaFpVqEujX7DZRo0
         wiX0R9hUY91e26oAEsuoS+alJWYkDOvaJnlYsdxK6B2PFNy8E7xjBVtMSFuLOJFV6E1n
         YE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680820; x=1788285620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIEGHFrAgohB7I3M+D1RclifJ2/vv7mV9Iq8QzMVbsg=;
        b=fG6BpI8dnwIlN6qrK2S/5YTIRjRZQO0Nq5TFAhIu2FFQCPxVUV71bMM0lvuwXvQldk
         hMvuIx9RzeyvmDP7zrOBjgyvUofD+0ayE1ywR4yelX2Z+9Rr37KcgAUGTs+1XjCnTw5c
         xxvZaDEyZVzbKeGxGE3r9Hm4R4RmjVF0QU9OKUI8aoKIkOrd/H2cgSBzsSXjHctdLKyP
         8UYHHsVnr0tSGTqB1As5GxKLgBjOGTKuT1F6J+v1odwprdKlRCMzgkEdVJY8GtVzZF/4
         JAJBcccSoaMiP5W06y4Xe1HI9SkEvwMJCLvM1dZBK6098gMUMKqK7qgVNMxbgVnapTEE
         sNrw==
X-Gm-Message-State: AFuF++kQJZWzwKrwBmYNjeNw+vB9RwHp+yUakcPxuAUSungzLcpI3bRt
	Rb7qrZ1i2KELvLrWBC7/dWu7rrARcRdtWrJ7CXGRUYsao9AX8wA2Ll3Z
X-Gm-Gg: AR+sD10ZMtoyK8L+RoxvS13bfaAc2+BA7w/u/LtbTLzOy7dYmKUHJFvUEcxHUpAb8+A
	s8D+xd9CVyA4RMvG8u15ue1+nnf20K/i+TWkzhDw3TDVbhSdA3wPh9/mH6O2BkckKK9imLHlrsQ
	pQTh4mcyndo8/vNTPwNhaSSRlI/ajcS82TyOlGtm+deZjEbfJjOheYbXBRZotNLxQVbff2CMLm+
	R2i5FzwsNsj59rw5JiV1wbErzO0wWMNT6kWXQr+fK5AxD/kdxpI6hOu/msLmff+k1vhGP9qJlb1
	DijqZbR9mSXgsaRgQntQpwGj9CbSzfttDtXdlXHt9+zoFsMzENcBvtTF8Zz+yCt0T3gxEw8D7Cx
	sAu7VBc0FM0mnfXmZFpkF8P7hkM1uDGAACdgr5R3B397ltQIeWqroPpPkF5KUHAL5pkdkqxYlOv
	US+GCY22eRqY9UAJjI7MUIU0q/vHtb0IbqJR17wFQ+IPYq6BDslDNzY6j+gQpf2qUa9FKiBjnpK
	fc5le7asCHgWC2ReftBVQ3ITOl8KYhru9uHlZ58viJ4IduEgAC7tw1cbITz5iHVNmj1z74=
X-Received: by 2002:a05:6a20:e212:b0:3c6:61b9:917c with SMTP id adf61e73a8af0-3cf83d22bbamr295031637.11.1787680820067;
        Tue, 25 Aug 2026 11:00:20 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:00:19 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 7/7] repo: add path.cdup
Date: Tue, 25 Aug 2026 23:28:18 +0530
Message-ID: <20260825175818.645579-8-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts sometimes need the relative path from the current working
directory to the repository's working tree root (cdup). While this
information can be retrieved through `git rev-parse --show-cdup`,
`git repo info` does not currently expose it as a scriptable key.

Introduce the `path.cdup` key to `git repo info`. The key returns the
path from the current working directory to the root of the working tree,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 15 +++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index fb5aceae8f..0a30c0d6ab 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,11 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.cdup`::
+	The path to the root of the working tree relative to the current
+	working directory. Returns the empty string when the current
+	working directory is the root of the working tree.
+
 `path.commondir.absolute`::
 	The canonical absolute path to the Git repository's common
 	directory (the shared `.git` directory containing objects,
diff --git a/builtin/repo.c b/builtin/repo.c
index c0f99b6869..2658e8be5c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -78,6 +78,20 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_cdup(struct repository *repo, struct strbuf *buf)
+{
+	const char *pfx = repo->prefix;
+
+	while (pfx) {
+		pfx = strchr(pfx, '/');
+		if (pfx) {
+			pfx++;
+			strbuf_addstr(buf, "../");
+		}
+	}
+	return 0;
+}
+
 static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *common_dir = repo_get_common_dir(repo);
@@ -258,6 +272,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.cdup", get_path_cdup },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.git-prefix", get_path_git_prefix },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index b689445b7a..aa8e59510f 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -215,6 +215,29 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.cdup at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.cdup=" >expect &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.cdup in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.cdup=../../" >expect &&
+		git repo info path.cdup >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'path.git-prefix at repository root' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.GIT

