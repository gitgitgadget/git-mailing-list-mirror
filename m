Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBD10957
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340150; cv=pass; b=QqbuV1P0gGUeby6uVaM3VlOzmCB5YH/N8IOyL2dHPoIsMaYYmbUc1K4aY6TVQKBBm0Fl58BnTcYtcCwp4tSuSXe4YxYEmfbz4WX00ufYEOkjn0JGedBkFgmuv7tp2m8h4smQu7rkSiGBz/Q/4QfrCCQFUrf+K1YdXNV3GQ6PkKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340150; c=relaxed/simple;
	bh=4rvco3dJFN4kHHTwJEFVeZs4roLOHpKt35s3SNX4cSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaK8x0CF2JHyhNsrtkGZuM+wHoZg2DAUAVVq9rUmkFyqg7tsoSo1kmQwI3psTsflSaceuEQpLbW0XGNDPiyydtwLCXfPWuc4uVd5DIHBLQCeFOYIZml84GS0n+VA0381rM/eX3nAzHp4DV/W+JHKzTb/YJrzLInpNlrVWVKhJSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Mg0yUA89; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Mg0yUA89"
ARC-Seal: i=1; a=rsa-sha256; t=1757340125; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hiec+FbUTpiUSgadBC2mN5H1Oi4RCvmF4rdzqRMekNn0wL9c4uSY9ynQBj0z26ktuDrrq7D9He/50ITQ2KNU7JlR+msVRv0D4i2sne20N3c/YZ3z4TOHX+gP6h4V7k0TIuJ0GC1YfSxaqpm9o1NqtPvD8NvTJ6T2PLzTe4YjoSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340125; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+9yvzFwhbzRtXybKeIvqTmhfCOm2Zhg0DfpRglru9Bg=; 
	b=WryOoFAK2aDuvCddQVxrUxUMxg0asXrP9RRtpQHF5D5dwMZjhGsmEHVh8b7uz1ng19UtbZhryg2IHnOu6Qwc6vpk415A2PtteQqTvA9zO0KT8oor0xzU5/Pmnz6a12hVV2CIlOtah7pRN6ekcsTH5fms+bZAS293tz4g6L47lQU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340125;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+9yvzFwhbzRtXybKeIvqTmhfCOm2Zhg0DfpRglru9Bg=;
	b=Mg0yUA89pritJ++IdciKBXEtfZI0ab+oK7aKtbr9+4YlRN1xHBy9aDKudxcarHPY
	1YxLPqTn93L+rcr1ib4JPwer7l6fDRTU6grKAF9NrSZnA+N/YPbUqJfeM1xMiTv+cop
	4T0Vgb8MTp99wG8VI/A3ZfAjqnTjvcREKb6wvfco=
Received: by mx.zohomail.com with SMTPS id 1757340117043741.6590426246123;
	Mon, 8 Sep 2025 07:01:57 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 01/10] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Mon,  8 Sep 2025 17:01:08 +0300
Message-ID: <20250908140117.262205-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

While testing submodule gitdir path encoding, I noticed submodule--helper
is still using a hardcoded name-based path leading to test failures, so
convert it to the common helper function introduced by commit ce125d431a
(submodule: extract path to submodule gitdir func, 2021-09-15)  and used
in other locations accross the source tree.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..d06e2fe265 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3193,13 +3193,13 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 
 static int add_submodule(const struct add_data *add_data)
 {
-	char *submod_gitdir_path;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	int ret = -1;
 
 	/* perhaps the path already exists and is already a git repo, else clone it */
 	if (is_directory(add_data->sm_path)) {
+		char *submod_gitdir_path;
 		struct strbuf sm_path = STRBUF_INIT;
 		strbuf_addstr(&sm_path, add_data->sm_path);
 		submod_gitdir_path = xstrfmt("%s/.git", add_data->sm_path);
@@ -3213,10 +3213,11 @@ static int add_submodule(const struct add_data *add_data)
 		free(submod_gitdir_path);
 	} else {
 		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf submod_gitdir = STRBUF_INIT;
 
-		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
+		submodule_name_to_gitdir(&submod_gitdir, the_repository, add_data->sm_name);
 
-		if (is_directory(submod_gitdir_path)) {
+		if (is_directory(submod_gitdir.buf)) {
 			if (!add_data->force) {
 				struct strbuf msg = STRBUF_INIT;
 				char *die_msg;
@@ -3225,8 +3226,8 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, submod_gitdir_path);
-				free(submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir.buf);
+				strbuf_release(&submod_gitdir);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
 						    "directory instead of cloning again from\n"
@@ -3244,7 +3245,7 @@ static int add_submodule(const struct add_data *add_data)
 					 "submodule '%s'\n"), add_data->sm_name);
 			}
 		}
-		free(submod_gitdir_path);
+		strbuf_release(&submod_gitdir);
 
 		clone_data.prefix = add_data->prefix;
 		clone_data.path = add_data->sm_path;
-- 
2.51.GIT

