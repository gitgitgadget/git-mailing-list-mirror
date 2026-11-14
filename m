Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674294;
	b=hOFkNcv1Bb62ehrzuus8OmPiV8/JgINoFFILWeIHSz4f3+KBO32aVsnB++rC7fj8SB09
	 57UxtDdvz7lslSvpwmU77qyz7urTWp+F4zJkeoV+WdA9+M+g8KRoUmrDvcwJJDhtt6wRL
	 32C06FisSWOSzkJIi/y1hMeuZJH7S57S7EhC34ZD50g5s78Pvk11+8sMpJhLlPq8z2KbL
	 4NdUjiMp7CsqjhPgX8RvKw81i2mMHa90RhrdhqsH2l1Bh3VesUbXpGjvHLox7IVM/aRoF
	 PQMSeQVskwqJnjS1u1mJ0meNyCXKC2fNGB/Q7+EQQ/HAphRWChA6onY4pSLY37xEkDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fEMbYxerSEurGLTd07nUesnyH9LDtbvpW3haxy5h8+g=;
	b=4Fg+zpHD3OZC24OFMISEXf2HIfYnH8oOoB+x15qZBMSR3vV9n2pR3XsKkCZdQsMc2RPx
	 usNIEidWT8nd4o4wBWfheJmvF2pGEJGyhxiJ5JCSclBv5Cott5SV7dYBT0Th4Hm2ijvh3
	 j2cSZ1VU5KCQZJqgfv5LHLBRpBgAeWNbdtIdKQXMLWzkbriSpJPSxq6E27vktT3snqUAh
	 8Nrh/0pcitzYX+pvJDM1rlfAn40sgd0v8htPixIWuqIa17qLTTMmZHxyLPQyuMEPmlwwB
	 Grf/SSUBikTu2WClIzbbYEdvmaY9S1ggBuSTdGbMp09iPqwsDOhWxHINRfqxG9VpPBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xm4UbrQM;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13C606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C13C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xm4UbrQM
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3acec6677so2702135c88.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674294; x=1795279094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fEMbYxerSEurGLTd07nUesnyH9LDtbvpW3haxy5h8+g=;
        b=Xm4UbrQM0BKAOKHYjzG7dFOEKx923uTWYJU++VeyKW9qkUN7aHfreVW2Zt3X/NGpdA
         +1bP+EWVIs/TiF8gzv/CQdz99blZTaDn3E5I8WFs1Gns+PFgGK9nCr31ElPN9FrACDpE
         QbxUfhhWRyisqoPSjYlRayDEi2snhVkyY9PMeuNpPl2J3C/r8DfBJCcrEhnN6EvPAYvk
         InofSNsfrJDFdxHQ8izVXhP8IyoKmReRUH20FnNPfeLRXXgL3UFA1vaNejzd7NHdMBxW
         is+ABVadqm+XSFkpcUxQR3lblnFpgrX7i186viCHv7fK/vf79Ehbg2u3iWQB8pVU5PGy
         8EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674294; x=1795279094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fEMbYxerSEurGLTd07nUesnyH9LDtbvpW3haxy5h8+g=;
        b=xRZDbvsyPAnE1mYcw7ID1zUcYMCCjSNZKhqFqJKtz0kg/XfjlsKqvngnfEiZjqGu8m
         CbZ6FxMRUw7wBajZ4ywVX45Er3uLq1sTEcVTLwBIoc5dHyDupuZz2u9iJgvTUhwPQGN3
         JAs5GakC8rbb3rToYe1zTJhOXo9zvD5rHrTZW+GYNLY7j/tP21yiVgcci4URXAupVpdG
         kkN8JA5Evh+A7noXaIZlOXDY7zF2RAvT+V8fR1DRH1qZpoecb3/BO5Bny7y1A+LLDVnh
         x9F7QSn2t4H9ykVtLx0ScX7F4j0eYkeAQZ9MD3d31IFem6Prs2/l8e196zSZVoVKGjIP
         y0jg==
X-Gm-Message-State: APuU4Z/LWExpLny3pnhXIEwOJvP5aPxgRXbqVBoKOAVIP0VEx8I0qg/w
	ZDKBBtN7Doj8qur4j3zDffAJmigom6lRbfdtOl7anMCCNE2wJVd84wPg
X-Gm-Gg: AYBFou0nmLq6v8GMD/aYUDKsVRR4e43fv3Q8KzZ0qNYZCP+n/f8OJX+iZ3mrsXaRv2H
	JiSrHQgFC9xRJPUcXRgCanLrVrJ/xjN9cn+uO1oY3ZZ4aU44JDWJShI+xiVBtnE4VuSX0mPrUNB
	zUMK/7p6fWZh7/J7Gv9z0C5KTIVE92WxfiGQNMAJhn6GNdA7m4JF3kt/0uCtOi7ytrtGmkdM8Vh
	ASWDsUpp98YMJVoo2XRKJQFm4UOtEsG32hzIZe/AvPwGGlhZTiHaW3ifVfrAxN1RcD0uYHYe31Y
	GiMlUCw4YeJ3dDnkk9dlpw0DqDiqTGd2BhD0gj+3pfpMfd/SZmw1BYqGY+eKsycgQvDifjRVD/k
	XQBRGHymyITyk8Ng1AyOklKO0UTp9R5I2+V2egfG9gnuzdEnav8RhlRBAzwdGOhU1vcrvfpnmGU
	nAskNoDeNL0qqzpq3PHxTYMPXySZ1fEmt2ioz1oUkQBwI9Pc/r/pTvM9TlPRxUNJMYVRrCNQcI1
	erAfkhWEa7sb64r3g/kUXT8izlOgtB80P/LgNk6fh8kbIh7sd+g71ODwq95zzpN6aNYr4K8bQPd
	J8vGALF6xAOp6BFNPqC4eIqxCo/10mg8OyKd8pjjAPrctGHc33LziXK1x59/FoS9XXFxaEbxCTr
	Y3vxPKNwEj+QK7ThkZFKDvLYlGlNoHmuQua0=
X-Received: by 2002:a05:7022:371a:b0:144:fd7c:84fe with SMTP id a92af1059eb24-1b50313d82fmr5942003c88.35.1794674293541;
        Sat, 14 Nov 2026 08:38:13 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm18093657c88.14.2026.11.14.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:38:13 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [GSoC Patch v9 5/5] repo: add path.prefix
Date: Sat, 14 Nov 2026 22:07:15 +0530
Message-ID: <20261114163715.257705-6-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts sometimes need the path from the repository's working tree root
to the current working directory. While this information can be derived
through existing Git commands, `git repo info` does not currently expose
it as a scriptable key.

Introduce the `path.prefix` key to `git repo info`. The key returns
the path from the working tree root to the current working directory,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index c515e9372f..17992c7a67 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -131,6 +131,11 @@ values that they return:
 	Returns the configured index path even if the repository is bare or the
 	file does not exist.
 
+`path.prefix`::
+	The path from the root of the working tree to the current working
+	directory. Returns the empty string when the current working directory
+	is the root of the working tree.
+
 `path.superprojectworkingtree.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index eeaee98c75..87c5743246 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -100,6 +100,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_prefix(struct repository *repo, struct strbuf *buf)
+{
+	/*
+	 * repo->prefix is NULL when the current working directory is
+	 * the worktree root.
+	 */
+	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -200,6 +210,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.index.absolute", get_path_index_absolute },
 	{ "path.index.relative", get_path_index_relative },
+	{ "path.prefix", get_path_prefix },
 	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
 	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 46c92d4e43..d0631a8f3b 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -207,6 +207,29 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.prefix at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.prefix=" >expect &&
+		git repo info path.prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.prefix in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.prefix=sub/dir/" >expect &&
+		git repo info path.prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.56.0-rc2

