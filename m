Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64D3815C5
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244072; cv=pass; b=oPntoF9hRLsizc7jWqQuAUnpRhsObqwc4ESPErlZgMyP/iHDr5G/AHgbKGINFF2VsKAvdvEaEjrhKhRHvtK9sp9795ZVBcRh54MLSXLsuX5NgpA8IeHFUTD3m0B7MfmDPDsM/u2cY/NZF7xznLNfmJf5qINfznz6IlMDAV8LZ7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244072; c=relaxed/simple;
	bh=YgA6KcTj/s0IEb/uxQZi0ZrCc0xZrdTW7zvJTaA9qk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT2RHDGWSHUjOrNEPQNc4TazjJMNHdcws3G4Ef0mlHXpsJA/waK/fNqbGG2ytTT+U/6uw9W8Gd6sPzXUdROslhmnLGKVJqtGKXU3NmpYrcZ9xHdPAKiSgeoTTMWhT4r0aPpoa/r2ieFUUKz1oszaG+dyTwDSLFagxSh9ecY8P/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=aX0xm+qb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="aX0xm+qb"
ARC-Seal: i=1; a=rsa-sha256; t=1768244051; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i5ZQAUADP8apnQGyTQQ4e5mNg07FzNLHE689jzp2frED9AdKeeBUXLV+uiU3GBZR4toYWHtS6OxclHraPRhtgD1tVoTXhHH2oGvmNHZNxlp2JoAWyQaeViKB5Z7930kTGeLa1wczu/KomheQyDrKHPKKDGutOYuOZyb/U+Yyttw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244051; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q6yEEcuI0d43rU1+AjkSGZ0D8OdEEuQFd+YVnzuhc+8=; 
	b=TWWDS1iqPh1tPnkLKHeOlxyISDg1MgOvxm57SimlDDERgrzNS/jxUMB7fflvl7DYFN5q3ch4cmQpJbldmSbgscordoHrRNefC6wQbVZ+s4yHBla/xZcMSAkqiMskg6tqFO/hwhjoqxajBdV1iB1hp25qs0QZjGYvYQuZnMchZKU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244051;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Q6yEEcuI0d43rU1+AjkSGZ0D8OdEEuQFd+YVnzuhc+8=;
	b=aX0xm+qbQUSxy+OxNdYG5THUWmWav0zq2HZ1M0aCOd0ixfu7+h5R0NcO9vKRLL73
	c0hBlxdWZV898TM8SWa1/992GK3gwuNEFRRqdQvWPIndKaYZB6urC1VB2yrHdSUqa50
	GSY9iea6mGurWXb8E8i44NSuG62noehxBfASGPSc=
Received: by mx.zohomail.com with SMTPS id 1768244050694646.6881108387115;
	Mon, 12 Jan 2026 10:54:10 -0800 (PST)
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
Subject: [PATCH v9 01/11] submodule--helper: use submodule_name_to_gitdir in add_submodule
Date: Mon, 12 Jan 2026 20:46:22 +0200
Message-ID: <20260112184632.1334495-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112184632.1334495-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260112184632.1334495-1-adrian.ratiu@collabora.com>
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
2.52.0

