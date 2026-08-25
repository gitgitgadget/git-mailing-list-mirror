Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08021A2C04
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680797; cv=none; b=Mw0ggpxHk1SPcL3SsvLw625Qtj8V1vHSkrgNgjfByKW0oz8SeAgG5svwkwMjf19m3D1wPmWbCfxzLAi/HMC4/CcXuhZtP/Z72Bnmqx5OUZ8+fChT3IQiHZirSCSb8SJVd9B36XxbdIL6+pgQ+c6zyPVR3NyW7cZPrmd3YGxvvdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680797; c=relaxed/simple;
	bh=9Z8elEmtt5EBQDZe4IA77t0WYmsm6fm3kHZhVMC1EX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrvZ/SSVwGUh3+38nuzBhrPWwyLIFDhsJ4zrRybcV2PtDm5ijQ95XsVYl2zDKxfyKEXQ2JLdfEIZRB5hILIhNGND5Zp7IXxv/c+NX/lnSiQHd+UvJXEyTbDGL1S0nQB/BR5V/uuHbBF/gxEMmsYrDi6eZXfvBAu7Z+twW0myxlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apMFHUkS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apMFHUkS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cca0c5799eso1975855ad.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680795; x=1788285595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zh3K0IvSMfY/YmIWtCencjbqRfBSdCcYyOG1+VSSBHA=;
        b=apMFHUkSF+JOspe+Y4FGEKQvhzCXzte5p2VyTAkvYzBWu/qPGbKdFR5zaCeIQGG60B
         PirEqfsnOvNDTxzNNSvrTeThHcaLEo3dE2pYSwFKipoosJxHoGIFpE08tNG0E4awgbcZ
         46CJT4o7bau9TM4LzN+U0qwmBdRGBjauWcHJVz2B2oZVsnc0IHorH2rlpkULjRHDyXpX
         HDsI9aNAAb1McEP6aMZ5PHjACI9yJvVvRBF2lJFJrsvuHychEo3/1tRDRfmrvKEzhgQJ
         6vPYrawnfjsqqyQXHUwsGhxEUjda9hI/byi7gEmEnZK27X4oR9ODoPBf5brU4IbkB5PZ
         7UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680795; x=1788285595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zh3K0IvSMfY/YmIWtCencjbqRfBSdCcYyOG1+VSSBHA=;
        b=LL4jwZ3PFBJegjVN7ZCZR4C/nMeRkSSZhn4KTN1eQjSh0j2NZ/B17DH7KrT4Xhjm60
         IUez1bdqJOZOJd9VH6cOEDVcq25l1k+NaDpKqeKXR6TD9fzmr52hlqjBr+ZYdPO8LzMD
         9tZ370eRrDfeFA9LYyb2XiPlIbsnG/N0bSMXmRZvg3/z66XjW4eFmXxprA3hYaxrYgUc
         qkzutlGWgbX0MqmqDTxiP1XqGBvtVkHxXuwkyHaoP3DpaBvhfoNV95PAs/GZRTEJcYnz
         GNG3ULaJODnxpOxvKTyo9Y5gGGM9k6Fhbg6oIaccpIu0/m87qZ9lg6uc2k9ckDV2t07v
         kD5g==
X-Gm-Message-State: AFuF++m49hfzu1IflyF7Cs+pf9Z6qRYBm2st0BVpXf/7NIcEK0fKowmH
	t1z9h5Wy5rgq8BJjY6fAvip2f5HQ31tOcQI+m9jIg/AGAiutSKrQJaPq
X-Gm-Gg: AR+sD134Zm9tzVaC9VpsIkK4trAk8EEKCfMaGxJoXaNsR4zcb+ZbQrrSa5RTLMa2pek
	r/eF2wZQOyudwwORudTqxLMHm4He8R7h8x56l4Mwp9VToeK4x0idJ9W2fv/cNxd4bEY6B9l7R6k
	k8sNo3hs9jRT1Mifbzcd3jx9VR12ruh5wqpVU2PbE8jRpW5rKYEHNkXFlAmmshCVJrXQhg3wipH
	kxkkwFr618+YZJA0M09vzY+86S7JTEyZiK+OULAmBoEWSYe0pJ3T03A3DoG59Ljf77Sad1J+dTn
	yF/xCGpR0bqzo/UjF8BfKWx497rzjapCgOxyvkUdnrkJR9ddT04wlqmk6S6o8PRza3yDazhUEEQ
	w2zVkgqifMIDvx7t0SDsD4ZZVoKym/2LaNMSBlb2OcxCVKK478Qr096AsrQrCekfrPWX5fO43WE
	ho8Drxitn53AbAaj/Vciih9BphujThptySfSk3KQTEcIL4bcQTlk2gcMIvWIeNL/KDYFyJwN2iO
	uCYmhZGrfUoLQ6N48pyVLi+nlDQiZf3kkdZ5oIAnQO1OUVhe8UMhECdy8DcML9vZclLZMw=
X-Received: by 2002:a17:90b:5543:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3966d13eb75mr1984597a91.3.1787680795152;
        Tue, 25 Aug 2026 10:59:55 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.10.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:59:54 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 5/7] repo: add path.grafts with absolute and relative suffixes
Date: Tue, 25 Aug 2026 23:28:16 +0530
Message-ID: <20260825175818.645579-6-jayatheerthkulkarni2005@gmail.com>
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

The repository grafts file specifies alternate parent relationships for
commits and may be used by repository tooling that needs to inspect or
manage grafts. Scripts currently retrieve its location by invoking
`git rev-parse --git-path info/grafts`.

Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
`git repo info`. This exposes the grafts file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 11 +++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        |  6 ++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 08ef47750c..868ab0ed9f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,17 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.grafts.absolute`::
+	The canonical absolute path to the repository's graft file.
+	Respects the `GIT_GRAFT_FILE` environment override. The path is
+	returned regardless of whether the file currently exists on disk.
+
+`path.grafts.relative`::
+	The path to the repository's graft file relative to the current
+	working directory. Respects the `GIT_GRAFT_FILE` environment
+	override. The path is returned regardless of whether the file
+	currently exists on disk.
+
 `path.hooks.absolute`::
 	The canonical absolute path to the repository's hooks directory.
 	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
diff --git a/builtin/repo.c b/builtin/repo.c
index 2a15327094..779240109d 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -122,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_grafts_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_grafts_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *graft_file = repo_get_graft_file(repo);
+
+	if (!graft_file)
+		return error(_("unable to get graft file"));
+
+	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf hooks_path = STRBUF_INIT;
@@ -230,6 +252,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.grafts.absolute", get_path_grafts_absolute },
+	{ "path.grafts.relative", get_path_grafts_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
 	{ "path.index.absolute", get_path_index_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 431a4842d4..adc4a92487 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -221,6 +221,12 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
+
+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
+	'custom-graft-file' \
+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
+
 test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
 
 test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
-- 
2.55.GIT

