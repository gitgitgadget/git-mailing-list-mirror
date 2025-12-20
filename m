Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A324A049
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225771; cv=pass; b=M+EmEXfjD90Kfv8ec5FA7ZRMoByaCUr9R35o/CE2QVLqe0LijQMMDq20axRANghqbDDQcLifRtxSoTowkOBlFATeN0b3LB5BU/39jsrg6ndFbRzAL9BuLB7zBEqw7REWGXV5qe83y9kJpSFxHHvul5pWUI6+y5AC1kYHJykV/dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225771; c=relaxed/simple;
	bh=bmvdki1rQ9/OkPACJuHdtKQusffjMd/tuqu++6fpHus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9KQ2wnC7IRiQdZvfO97/G0YzF+m8vCQ7t57LfwomKAomN/StEg6KBmLEYwRQMtMctqFKXkAV5Myo6wEyOWHadXeIDhwtGD+15iX23G241g6Ua+S3gg+p4BG1C3Zjj7Zp+fqzqTXZ6QH6uSWIO1x7eMF97GfcrQszbDDcjv92UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=hCFlROri; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="hCFlROri"
ARC-Seal: i=1; a=rsa-sha256; t=1766225747; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mI2KY/Rt/4aC4j69xpPYlgRvsitp/PU9QbuPUQJI1Nh7LSG9uV//DfwIXttZQZirIpgJ6GWmAyXwgMjYuSxW1WKA4cn/XjfvreS0dNog8q3lj884VOEPIq/ovNO2EX6am+0ouoBGs3G0smnvwJ32FacPZ9f2sKoNBDrVePcp9pw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225747; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IUzLuzLooAAk0qUVuzzKtFNE3pmGN8i1DCpELBxgZ/c=; 
	b=LYwCvOvCaVO+NJ4yEz6ad2bCnmVfzh2z1FE1PGp5QZCfoCh45DN+MJjZyaE502A/WV3s35KoP22V6zJizB365JCAhloIXmnyf58cDnsVDAb04lPf355trKyJovzt0sLNpDwLe15d0aKdauftM8mKZEIT/SL3oL2lC+Q/LCY21HY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225747;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IUzLuzLooAAk0qUVuzzKtFNE3pmGN8i1DCpELBxgZ/c=;
	b=hCFlROriiF9Y/UCAAFrpLaXN/WEhov5WfCqAxZaHuMALWS5xG/um8su1mtwrWN6p
	9IhLPTBCl4kTVwHsWwG1S+GuChU1nQ3hkIyLd532AE+Xj+/cHwI0FtUPRoYxYWVI7C4
	F9IQK17rbsg+W6XliSdToHqvWkiWYwMt/XOSOUNU=
Received: by mx.zohomail.com with SMTPS id 1766225746207277.5045425508017;
	Sat, 20 Dec 2025 02:15:46 -0800 (PST)
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
Subject: [PATCH v7 01/11] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Sat, 20 Dec 2025 12:15:18 +0200
Message-ID: <20251220101528.1227487-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

While testing submodule gitdir path encoding, I noticed submodule--helper
is still using a hardcoded modules gitdir path leading to test failures.

Call the submodule_name_to_gitdir() helper instead, which was invented
exactly for this purpose and is already used by all the other locations
which work on gitdirs.

Also narrow the scope of the submod_gitdir_path variable which is not
used anymore in the updated "else" branch.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 35f6cf735e..13b5e4ed68 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3183,13 +3183,13 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 
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
@@ -3203,10 +3203,11 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3215,8 +3216,8 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, submod_gitdir_path);
-				free(submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir.buf);
+				strbuf_release(&submod_gitdir);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
 						    "directory instead of cloning again from\n"
@@ -3234,7 +3235,7 @@ static int add_submodule(const struct add_data *add_data)
 					 "submodule '%s'\n"), add_data->sm_name);
 			}
 		}
-		free(submod_gitdir_path);
+		strbuf_release(&submod_gitdir);
 
 		clone_data.prefix = add_data->prefix;
 		clone_data.path = add_data->sm_path;
-- 
2.51.2

