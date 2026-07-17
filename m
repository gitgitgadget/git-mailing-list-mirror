Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FD3A7F60
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295234; cv=none; b=YKciGvtoono2Z7jmoD+hRvn6daJe1mYxMkLal3ITOesfuRnWBl0FI3DgDBr73XSvv4vxqLw85ft4xss6ou31xDJOgC5ByhYswOFN3iomJa1xMM/WfWdke5qfZk7kKKIDxOngbck9PJD+JuobSppfJAVa88e3TOeTeGf7D1w20P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295234; c=relaxed/simple;
	bh=D0UzlKS8KNciqFkG/qLNPAwNkJ3q5dFcRzV5tqakWDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gW3zxTapx3+p0Q6I0llEw6AIsCHHKtfA9Ke0S/2g+3RgVrzSUFVVw1Z1agor9NUQrdxBry9/G6BJWWyiuVN+TEOwfAYm8hEruVFaGmQybVVtYQNtrZ34HqLQuOe5+zykH/rMqy9zlROUtQ11TE9eqTtCFFSLN3PNw2G6wSsaXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA4oqiEr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA4oqiEr"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so70571a12.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295233; x=1784900033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zay3cx5eKZG9Q9J+UQQRGifWu10M72QE9f/xrYkNXBM=;
        b=PA4oqiErAQcBjZWQU2Map3wtOst1w6B9D3sxLUB6asiMGmdOSUz+zYpSsa5ueiWiyC
         VGDWSEOxmdKQj06iK/uYweIWB8yL6ZAQ+Zpf8m0GhJRhx91WGedNEU/8XZq3uhaWpq6I
         gDpVrqvmYDWrGd72Wi2Azs3FRINQUYEjsLMhOrxALBfi0MdN3M5pOnyouJC8yj9GoJ7x
         DKPys/PbHapYm/6NhJ2Bdp/VU3Qo5LZm3RqVI5OzTld8SBPDgbTmPOjMh+ffM0N72J3K
         taE5SLxY4bYq5gVYxzIbxbPZB95FkkmdD/yNZ+piK+BoRfFQXBUf8imqoGuV/jMSphee
         1knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295233; x=1784900033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zay3cx5eKZG9Q9J+UQQRGifWu10M72QE9f/xrYkNXBM=;
        b=ZODf+aCNv4hTdoY1kk+B/yO0xbUdYjn6ta4RC2ofxO/WDchhkTOA+9pILBPYrKjbV7
         wLh9e6VCUFivMx4HW3OOoatVg2xXxz79o/b0kXl/z+W3SBX35ziA4xhu+/B4j0J21Qf5
         PkSizPoKPbTgboRDfGNR3NaHOW2YvqkpufF19lvjrajmgSC/xR8TGb1u/oiitBxX4llm
         TKMQ0Dialtfm/sALMbH0+W3CrXouEa4Wu+CnUGtijPZXHo0M8I6LYPNE7W9+ywVKx6MY
         bZeyj3KOY4kGpcTuI7kLxSnofL88ijLnFpQ2BpyHQqSDHGUwcf4wnKftjsyUGwDOUSwo
         PQ9Q==
X-Gm-Message-State: AOJu0Yx3QcgWBWylzCck44sFPCbVKgstuW0q9nxSk+MiyJSyki32Wvut
	E2X7lnRiuzxA05w/lfH+DVkrX/JyPopdzil8sizyDCw1TW9pkauwQMKJ
X-Gm-Gg: AfdE7cnv0aspMtGaqpnJZXD11TL9KNTrhx8A7TW8woQ77LA+TgvwJLYcWIsM+Yz4lBv
	kyClIcpmUMQmzta6QEJkFKiHOgKwehAKgX6n88MxVH0ae4CkpZsoyRUJ5Z4MV97JN/It3gAgW/M
	8SgKgjGoStj/dnZ6bVgHH28YR1MwLq2ppl0mWP4DCJjYfYExP80nC1iMSk58UvUDHwsblA1fu1j
	sdGYbpilikb8zLRa7TgvLo/XHa2gBZS0qfNihc+P1VOmQPG72X7WHHSGLP5mjzpAK4QW6Shax2M
	wUcp00GnKwShz13FZNZhHy0pSkkp2AZ2M6tZ0Ey/z/zF0+dO+VVT7il7AfdtqMFZsAF+A5gOBkC
	aa3+MeJcElZQLSZqFyiN7pYnoH5OgfXJEsqTQkgZzvDpdSBBGaUO2pSpkS84Al9yt8Z7lT9GvuA
	QimoRn7JRUjeGlMCg3won1Pw74Bdy4/n8piJKtZmrSW3t+yosNXXi0eCjWF3ekA3TOUBoQWS8Jl
	gnbhRGdrrYqfQZxayfuPcA=
X-Received: by 2002:a17:90a:f94c:b0:38e:4e62:f998 with SMTP id 98e67ed59e1d1-38e4e62fbfamr1392625a91.23.1784295232738;
        Fri, 17 Jul 2026 06:33:52 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:33:51 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 3/7] repo: add path.objects with absolute and relative suffix formatting
Date: Fri, 17 Jul 2026 19:00:11 +0530
Message-ID: <20260717133015.32040-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
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

