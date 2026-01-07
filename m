Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0E13B293
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826976; cv=pass; b=lyG5rUpR0Fp3b9ercodCG7su3v6nnuhyROWRVJQnICXCI7g+/mBTPLKVwCZaHBg2jjgVoFJ9XjJsUAmI2yax3qKsyu4c2w1GfTHJ0XJO+SdKo1sfaOS/EWBPxhentspn+Yqz3k+NGYNkk0T8AdxsRl7u1jI9iQxiMF7gs/a8Stg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826976; c=relaxed/simple;
	bh=IBjzUuUW34DVqM5QNnl1PSZy7HKhBt2jE57IhsS7ChM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cttRaXK7nAVhwnONbyL9OpjxUPddxJRsx/X/EjRxsqj2anRX/GnNSZ6954vP1QiL4aX7dx/lWv42GC7ZPzdoJBo1QEsNjX1kvC+g437krKmNXIhd3Wkm7mVDVDVQZ1p07Wi3IZVfOeO43T14O407k9ooStCQjULs4A08kO9jwFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=VDCYUf0R; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="VDCYUf0R"
ARC-Seal: i=1; a=rsa-sha256; t=1767826960; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OBSrb95XkO5wIgg9VvB+MrF4In35o13/HmZBl+bh/IJziatGM9M8L/vw0UNK5GPgAo5YBUNfkXQrmRnkKQvOCaMopd1fL9GfuYlNMkHhJ7WoYqM56K8GJdqoqX6Bz4+WMiGHoFMRziKcSE7F0iYTuxXP0xWjHcPDVRrnxB+a4oY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826960; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SgZWBrtQHKRkCIJoThNbYBBaGTg4fMx2LXUmMnlYfTw=; 
	b=csOqZXalcuBDc5UGNAnTB86fX+qCN+2eCdASNbGL/iymRqyrvvvgCLGknr3gbvAkPw1mvzXFj7mE2Gmxg/flIphONy7bpyaT693si7PbySC4J3VNuPs5yHkZSutZAelN+eEB3zVURAk83jdC/PDULeRaHmld+YmXwXB3aRxYSRw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826960;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SgZWBrtQHKRkCIJoThNbYBBaGTg4fMx2LXUmMnlYfTw=;
	b=VDCYUf0RpET1vIgCT2iyjGUX2iki5OICeDi4a9667ofEcXO0ZhPTh6j1yNTDr7kx
	9lbTMQON8+rCHwqJUAX7lWdeyu8MpJh5H8gfuhD64MxLuyHUtYJUcyKqKcTxfq3E1t8
	Yw0KzDlRFI4fS2ywiPbe2HOrQAehW+s4/zasZymQ=
Received: by mx.zohomail.com with SMTPS id 1767826958048609.9800312739088;
	Wed, 7 Jan 2026 15:02:38 -0800 (PST)
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
Subject: [PATCH v8 01/11] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Thu,  8 Jan 2026 01:01:35 +0200
Message-ID: <20260107230145.517562-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107230145.517562-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
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
index d537ab087a..6686714e56 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3190,13 +3190,13 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 
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
@@ -3210,10 +3210,11 @@ static int add_submodule(const struct add_data *add_data)
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
@@ -3222,8 +3223,8 @@ static int add_submodule(const struct add_data *add_data)
 						    "locally with remote(s):\n"),
 					    add_data->sm_name);
 
-				append_fetch_remotes(&msg, submod_gitdir_path);
-				free(submod_gitdir_path);
+				append_fetch_remotes(&msg, submod_gitdir.buf);
+				strbuf_release(&submod_gitdir);
 
 				strbuf_addf(&msg, _("If you want to reuse this local git "
 						    "directory instead of cloning again from\n"
@@ -3241,7 +3242,7 @@ static int add_submodule(const struct add_data *add_data)
 					 "submodule '%s'\n"), add_data->sm_name);
 			}
 		}
-		free(submod_gitdir_path);
+		strbuf_release(&submod_gitdir);
 
 		clone_data.prefix = add_data->prefix;
 		clone_data.path = add_data->sm_path;
-- 
2.51.2

