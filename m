Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674286;
	b=A33/i7TH5EYS7F9WgqPuCbM78UYaStvrec+TkjpHSvwEH2ocJjXPKVqCqFG9ahDS0nid
	 IGoNPZN5M+EEvfw+E6tSLDFXhjoDsm4CKFK8ZZX1xKmCaz3i+ZZTrR3I9O8Xc274/F1yB
	 6Og9HdwXJ0nnbHHDA274Zo9qttz/jI5RItublaoCJRw6mslt5Opj9xOZTO1szZnLO/keW
	 1EzN7JV5SkzgdWsdG9FVRel+/4M/LoL8evOleTUw2V12X67gSfF3iOmIY0XazrbpZT2y4
	 X96kCA6gQegmFQbCiU2sUmNIqNbpm7KgcT5z5qCYDKztPC8pNj7DBmAQP8ZaNfGm0ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uOvbaFuXyyqHYZHTi3ibyrHbfyXj8q51t1nTpP4Bip4=;
	b=3IFLxoFhySqPGy2PEflVkbwiY7mzFR6u4WNfsEu0FAdCGE/6669jGDDd9Ked6Ir0V80Z
	 SCS0zOfvPQZnV66x5DRXc+5kyapa1AX2BDWVPTBBQUadp+hZ+T/vH4XTPf+/H5g7rq5u2
	 rdtaC273oSX61FDQ01aQJUWdtVDNhg2+MmYpb4+/FA9ixCFKuzT0q628NfvaGRjWCGjeh
	 l5vrg5EhvU1c3jIeJgLVVHzKkIGMogjJG7QFmWRRBbChaFzJVxr7dMt9tcysVjEYBTQCR
	 BsRTn5PvsVrYvH1d++ItOPu8TgY9eIM5XiOFFxWwpVsGtTAmknvYOc1krSxO3qiqVjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0n7BBBh;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BE606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76BE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x0n7BBBh
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-18818daa3e7so1196857c88.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674285; x=1795279085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOvbaFuXyyqHYZHTi3ibyrHbfyXj8q51t1nTpP4Bip4=;
        b=x0n7BBBhaFMR01a/X5G2pEg24w4b0rd5GqJOYTQ8h8MH5RuaiHprWg3duW6TRoqKyL
         6cdhvIglMpDJbaRcs3EnFcxrlOeUtHzo51cfuFB+1aQCwkMYYoj+5TcX7w01f+HXSOkQ
         +zjJfdnv0pV6U5g7uRsacf+fTH8zYv+hTgBfSKcNceCvwEt2rlPObg9xw7VHgdi+YYgC
         dfA0zEIE9BUP6WSotosrqrgubXhmnEyDFQY7WqYVVid1mjWQJWdVwAH0Lpdn/KoRnzbu
         PdKccPtWFu3VsHakE2r9OYsDm7VUbyN5kD1abIBED9YhZ9VbetNYgFT1eIeWx6DjCD+5
         ui/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674285; x=1795279085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOvbaFuXyyqHYZHTi3ibyrHbfyXj8q51t1nTpP4Bip4=;
        b=KofdD2f8f89zOcq+B9vigv2C4unpMkXrYIeXWMzylJRN7YzOr7jq/ycSQteJcxJL75
         QAUqxsr4XC2RjCoJVTcWvJSBKu46R+WPlIWAyp5NjIXS5JVCEYSjfDyewhTGml82VZWM
         mZjD+55d7x4oeJzY2gGZUT5akCSLQWvzWzFnQpe/zi7VcK9jA49OCNCMSsmEYCMvfd9F
         k+GOsvDPZMXNpOxEYlleAlRhI0TyftvhMfR9aGQcAYydPNsI2lEIweixVSbzxJcRi/Fz
         HFg5CyqPrClhjBr2q5EsOt2jC1pSICF1YyEZ0Gqr2gq+Xd52J0SEjnAquPOj2RsSqQhV
         rhcw==
X-Gm-Message-State: APuU4Z9G6unuQQOueZkKwWOTEUwnnTcakd3dIa6GwFm+rV1PrpIiwqYC
	CoJupi75Py2vNT/YZeSCHUICVD2Z6QWpVInxqsvzsjrQ4/ft5omEXYxh
X-Gm-Gg: AYBFou1idHS5LmvWw6x7EsRErVgnqljeSRpeDcuv2Xj+QjGvFvvNzadkE9mDknjRZp7
	qVJ2cKNPLt0fLgiyhMD7W1Q0ya+4Oxb6xhVseHKCtZTK1Hj/6n/iNP0XHePpHjZWtN+F7xcMLlb
	z/kObi4IRoiMH3Xlht55fLHnMG/9A6jIYwJa3MtZuCNyBwj0+XvoXk/DyOKDm7lWUjzF6Hpnm4h
	NfQ81VHO6buqUnE1yyZ3f0wioHlpqW65uh3sJ9flMLXQZmzWEdYygll61J/JkhMLOM0ueL8ysDS
	U4efN0R+2Ccx9hZNZ/+zsBb/imYLnlD8n7xiYuaL6EqSGCHQVKj4qQd6MrWRBwHYKJpBDNMuh/8
	8VnCvs3zFk+ylTO2CpnWi2Y6UyXEanPBVb0bpAx/uljXxvrxmZEc1CBIHeFlSsEj7ABmSw3ThcO
	ERRmXH5CmYi+o2CcOWgzWQt9yVmVJdyu4fYOSsej9JyGCTG6yLJ7Bocg0uDl01xFnG5oes+KG/X
	6Rr6KugOuvJ0ZSdfAv6bLleJA3J1lsJp1h/9A1WogNRDYTMrrAeQ3K/mNa72AbuH2pscotgV54W
	bGFhbRXMcJbCIn5I5D3YkJ1Ixhhp61wPEJKY0yFcwOhdyinrNbA7fTaLj4GvGvAWAOx6kEH7VyK
	/iml8Z67xQN3F6r3GonfXNcTqO6JjLJ7SoZE=
X-Received: by 2002:a05:701b:2402:b0:1b2:6d4d:9d8a with SMTP id a92af1059eb24-1b4f5ea832dmr6859904c88.2.1794674284615;
        Sat, 14 Nov 2026 08:38:04 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm18093657c88.14.2026.11.14.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:38:04 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [GSoC Patch v9 3/5] repo: add path.superprojectworkingtree with absolute and relative suffixes
Date: Sat, 14 Nov 2026 22:07:13 +0530
Message-ID: <20261114163715.257705-4-jayatheerthkulkarni2005@gmail.com>
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

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superprojectworkingtree.absolute` and
`path.superprojectworkingtree.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 25 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 82bcd8ad2e..8cb154513a 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superprojectworkingtree.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superprojectworkingtree.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.workingtree.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index 9ec8623a8e..8b461ea226 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "utf8.h"
@@ -121,6 +122,28 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superprojectworkingtree_absolute(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (get_superproject_working_tree(repo, &superproject))
+		format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
+
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superprojectworkingtree_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (get_superproject_working_tree(repo, &superproject))
+		format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_workingtree_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -159,6 +182,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
+	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
 	{ "path.workingtree.relative", get_path_workingtree_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 3225fc8583..582f643dd1 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,45 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superprojectworkingtree absolute and relative' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		cd sub &&
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.superprojectworkingtree.absolute=$ROOT" >expect.abs &&
+		git repo info path.superprojectworkingtree.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superprojectworkingtree.relative=../" >expect.rel &&
+		git repo info path.superprojectworkingtree.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superprojectworkingtree returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.superprojectworkingtree.absolute=" >expect.abs &&
+		git repo info path.superprojectworkingtree.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superprojectworkingtree.relative=" >expect.rel &&
+		git repo info path.superprojectworkingtree.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.workingtree absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.56.0-rc2

