Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB1233155
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749973; cv=pass; b=AsF5e++23ethZ8L78YGrb5WzglCrCnx1VhtcVPRYLevD2lkx48TgmErGkjPdv1JmlwI8KMCK2VSeBrd2lbP5XvdlswxykOu8TRBa2iE6QXNBONnOIwrFGXmkCc7Blo93IGh/1wPcVuIh/zCBm7oSXpt0cpw0P6JdqQExGNRAt58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749973; c=relaxed/simple;
	bh=liwz3ZjhuhFynnW8zOx3hejlYCHBOIXsAbinecwLkwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFyt0pGweA/WPvRdTnm5QZ2621ZYzWinLpUcUjWieaJGxpESiqOxoIQn0+A1/uyvdQFFr2z9Im9QsoqU4aS/lSo5WytnZ0rGBr7P6MkX3LQoTt5VSGYMuh38zAGlsDGFMqrWU9ZFLZ4RAGEtVP+xn2pYHfmK3zVLPUT1CTAC5V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=PY9AmQqN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="PY9AmQqN"
ARC-Seal: i=1; a=rsa-sha256; t=1759749948; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wx1h0GMRcw0qpfGt2rzR5u03A/bfpg1tzcSFeDTu4PDggfPxEGnrLRP2J5D67spWPY/5rPObl4FYbo2mEkjYrUsXIyL8KoD2pbvpxM8eYR1bxzb+g2nRZDixGWHyZNw4ICofoeYngSap7P44q3ssPMnlNtxpGrfBKRYy9liUhNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759749948; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZtS43lgPk3O10iJP83d9zBs5wEOm2ZEZQrLT8llvB5M=; 
	b=EnteFM3HPXCszoRvj1VRrUsIPIWogEF4phjRREZC3AMvlg6ueN/nI13q/RbfFdbj8C+GwTf7itZNiduXr/gYw8zBXiLaZoHbXDpyemTonGzGxyEmgFh14mgysW/MA/kkUBx5EpH6ehBG3CbIUjuRdp7PaLfEf1cD+dW56tZMe0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759749948;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZtS43lgPk3O10iJP83d9zBs5wEOm2ZEZQrLT8llvB5M=;
	b=PY9AmQqNkJfdNlwTd+FAiP0VYOH2XWs+iDTUBRUqFHlZGs3pZQXMcSIBH/S3rfwr
	SbwGzBfSZpoOjzepkY0+uglQkfr0Bm1i5Gbt2Ij0mxzGz5zYFX5jPAUtNmOKBzo29Ec
	tk3dkm5KU/IKjF7JKLexlZyusNlNMMm8bBLVKGjw=
Received: by mx.zohomail.com with SMTPS id 1759749945506778.1315960909252;
	Mon, 6 Oct 2025 04:25:45 -0700 (PDT)
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
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 1/5] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Mon,  6 Oct 2025 14:25:14 +0300
Message-ID: <20251006112518.3764240-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251006112518.3764240-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
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
in other locations across the source tree.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fcd73abe53..2873b2780e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3187,13 +3187,13 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 
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
@@ -3207,10 +3207,11 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3219,8 +3220,8 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, submod_gitdir_path);
-				free(submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir.buf);
+				strbuf_release(&submod_gitdir);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
 						    "directory instead of cloning again from\n"
@@ -3238,7 +3239,7 @@ static int add_submodule(const struct add_data *add_data)
 					 "submodule '%s'\n"), add_data->sm_name);
 			}
 		}
-		free(submod_gitdir_path);
+		strbuf_release(&submod_gitdir);
 
 		clone_data.prefix = add_data->prefix;
 		clone_data.path = add_data->sm_path;
-- 
2.49.1

