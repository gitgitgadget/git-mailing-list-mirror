Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC43EA969
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295159; cv=none; b=MqfeOe9B1fL4wr5lox/PIHpo8fGFBF3iC9EJrGF2l4oSwuapTJWawBH2pHcybIyYxPwpp8uV6kakt+cS3zAp8qYIbLDzDmBCrTFL6SfXFNkkpKUDlByDh4kEZlT+sNYroPIevG4/k2zuYdOGV4DG9G41nawJFwm0HAfnGTrPZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295159; c=relaxed/simple;
	bh=gBxtLgBnRe2rTIgqqA2+IWzU+wP4Hwbj6sOoyBQRxk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZT4c6vgTDu5V0O5tDFa19xLEtO1IpAjPDdC06SciA+fqPTX9TxG/0XJamN6tRiC/k/9Yw8oSbUlxjjpPtIcmTFp8X/hcdIzooP7q4KPHiFkcBU2U5hylLv+/TaW4GA3X79x6jqbISY4UxVFrl2tU8XOJw8/mVdN21up1aPnNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvl4D2tK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvl4D2tK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1184988a91.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295157; x=1784899957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DrLJmQCDQj+bZw2nSj+aKcT6URRBo7QKSnOEGF4g0M=;
        b=kvl4D2tKtk/uX74ac6cKU9/7VSruaWncG63j+9XdwF8vdtasXrT8wfOobAhlHJ85p3
         ksQwp07id9SrbkwhfAqXKwwoR9vuOi/i58+BVJau/3LM/MMfSjUf9md41BkUNex9JJH7
         JcuBE2MZY06zqg72fysM7BHnrjxvLBpJHWD+hfxDk8NrNxUnb7ButH40cDSZ2V1YAccl
         yZm/uSDLffXzs5g0328KFJfAA9cukc+DxTShK9J4vqxCm3LSybLyruYXuyqb0a3hyZrm
         k1S3BocbohWSpYSQ+2wmZk/kZcyuuluAqP9TGrNRlUIpcDCIoHTm3lzTDxuBIM1mZGb2
         6hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295157; x=1784899957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DrLJmQCDQj+bZw2nSj+aKcT6URRBo7QKSnOEGF4g0M=;
        b=HWvfUPBQl0ClmsP75pNKXy/6yUv4WNkmosBkZgeMB2/VKSuiUeHXn9RnUggrwE7xNx
         zSBVPAvPyXqIsZmmOVC3/4yYGb4r3v5Wbp6kUCShGaS1xOw0Q+FarB0a+1BwNMQ1BDD6
         aac0EjLwA/tM8xsQLGsiiavvWObSPquiy/CnuK97uCO+B7jLfyiZDOEE4edRCuUkAI0h
         FsFNmLa1FwIQrsCocbGZO84eFfzNHuVu7jFYZ5wq8waJYnVGKkieWgDbBcj9YgElx1HU
         oCTPMxahEGHWnotRN8Ec0s4CzsH3hQI94Fa1F8rmN6hRBC6ZPrQOt+9IhB5WGiM+qGnn
         7dLg==
X-Gm-Message-State: AOJu0YzbwzQ91jBXo0jT2DTwlJRg1IJ2BWuLi76L51hWYsyQW81W5n/+
	PCVnNRRjvraSFgnVA9acY0yaCdjL1hsE6y+aVdFK7FO3giQaP/QTdY+iUF9HLA==
X-Gm-Gg: AfdE7clpEmwwU0+DY79gXhS+HtNMqjQ61JvS+uV7FpThd8WH0iG6WC3zmXElKrjz3CD
	Oa33FVQZgdyVV5TtrBc0u2pUPIH+BpRYgoXZTsNwEoBy4+eVlBENZ/l0Dxfo2InYQxt5S6AnIQ/
	5gYrrFl0R3yTriJPX22Z7eZue2haEYmy2b3EE0rcTpshaW8hFj8/eWN7bkosyKCg6DSlgGPyvRW
	x5lxsnd+BQRGsZ3pl6UGdUp3fjybnZ9qcxq07FtZClTHR6l+42escpIpJr3rYw1Al9Ukpq5FEgS
	ho5LdvMZCCB2P2ObfS24s9VxgUgiOMpx1y0QloetDpP7ge2V6p6SjbgS9JIe3wHC6hxTO7yv+y2
	3dLwdkOvP5PI45Pyqq2qdLV31n3KGOd+bKMRdQN1WEFFLYDe+agyYDVOR6Z0PsgopUXSjF4PhwJ
	sSE7Ch00Qt5F9i52kRo5IiJFkwwDHozTLB+wFYWSjcLsuF0RMl4EfYYVJ3gPbyrYbSRuLYCOToS
	QUFsqidm7ShS8R/6Xfgf1w=
X-Received: by 2002:a17:90a:c887:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-38e3d26a744mr7454410a91.14.1784295156849;
        Fri, 17 Jul 2026 06:32:36 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:32:36 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 2/7] repo: add path.superproject-working-tree with absolute and relative suffixes
Date: Fri, 17 Jul 2026 19:00:10 +0530
Message-ID: <20260717133015.32040-3-jayatheerthkulkarni2005@gmail.com>
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

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superproject-working-tree.absolute` and
`path.superproject-working-tree.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 33 +++++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e34abe5fea..03aa57942f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superproject-working-tree.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superproject-working-tree.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.toplevel.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index 194757eb18..82359473e9 100644
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
@@ -121,6 +122,36 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superproject_relative(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -163,6 +194,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
+	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
 	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index fbb9063ee5..220b3d4d3d 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,40 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superproject-working-tree absolute and relative' '
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
+		echo "path.superproject-working-tree.absolute=$ROOT" >expect.abs &&
+		git repo info path.superproject-working-tree.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-working-tree.relative=../" >expect.rel &&
+		git repo info path.superproject-working-tree.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superproject-working-tree returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.superproject-working-tree.absolute=" >expect &&
+		git repo info path.superproject-working-tree.absolute >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'path.toplevel absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.GIT

