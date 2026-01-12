Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA163876CB
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244078; cv=pass; b=N2AFaPTUe4jKn/tGWTIFOw/lpTUxCrUEZAWSy1AFKKBu8EFQWdN9lWh1GbjRHporasebpzPOsDj3wamyaT5Mv/Pbf1QKLQtaNNlOA2xGDPwE+shsBJ3AlEb5s2UNyEz7RH+q/BIMs28gLFsRJylbwhnPGlHm/hpj+tENugt4DLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244078; c=relaxed/simple;
	bh=rU10gzn4cTJXzKsryQNyhdVV36t8MTb3PNW/lF2eNgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6i8S+6smWImysmwja69Hnb0ekNgb+vslbJWpaVVa2hlmZCdo58qi1SV3fd7vhk7WiCNyH/yJXQz24OcdTt42MbRpyy3EkeiCD8vy5szD4i5Z4x/E9px1xsCNLs6d2b2UhSAQqbpomqmLw3SnlDUuO8tEY4v9eVUbzYDvKl3A4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ZzHkXQz2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ZzHkXQz2"
ARC-Seal: i=1; a=rsa-sha256; t=1768244058; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AcoExP/FuGeQeGyMXZCxKCCXoSFQZAKzYZ7yWfHcVAIhK4INJunDGi6Rh7uMxQnD9PbUXGKADjEhhcHQbJe2jQEWAUA2/ti2RQyqokOCFvnvy5yKW5NcICDJ35pyoO/GytyXNtAWSzEB2czqweinPACV8HzNV9fi6rbhpMrX/UA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768244058; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SWfmBjk8sj9o72gP1d21Rr01XH+qA2t4NUi1X1XKVQk=; 
	b=YJ0McFKy+FVzV8kAK70MJLZcGzVjIwp6+cf8tHJTyBLhemMdokG2QCLa/VgHOuBQRmfK4mFsRsW/ENWwdrl2+Bp9txEKiYp7Q8+YxcEWU/G5Fe70zAIHDpKtJBJSkrjJdeCPsgcMkhi9oXK2X9cJDtizb+8tmFBfEONsBIXRGMo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768244057;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SWfmBjk8sj9o72gP1d21Rr01XH+qA2t4NUi1X1XKVQk=;
	b=ZzHkXQz2CcpttsRVD2ZhZe70y7C+PUzUjNHoDQ3lOepEXJenjtTQc4Btvt/prKZl
	mnal5S7AkRRcHsVWINu62NMWJ2TaRS8UsbxZpv7mYkEzsSSw40u+9hkf4ajnACvSQN4
	waj7VrnLagJYLvSpjD4v4AFmftFCf03gxx/ejSnI=
Received: by mx.zohomail.com with SMTPS id 1768244056432662.0374903658025;
	Mon, 12 Jan 2026 10:54:16 -0800 (PST)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH v9 03/11] builtin/submodule--helper: add gitdir command
Date: Mon, 12 Jan 2026 20:46:24 +0200
Message-ID: <20260112184632.1334495-4-adrian.ratiu@collabora.com>
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

This exposes the gitdir name computed by submodule_name_to_gitdir()
internally, to make it easier for users and tests to interact with it.

Next commit will add a gitdir configuration, so this helper can also be
used to easily query that config or validate any gitdir path the user
sets (submodule_name_to_git_dir now runs the validation logic, since
our previous commit).

Based-on-patch-by: Brandon Williams <bwilliams.eng@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index aff3f9135e..901213ee71 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1204,6 +1204,22 @@ static int module_summary(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int module_gitdir(int argc, const char **argv, const char *prefix UNUSED,
+			 struct repository *repo)
+{
+	struct strbuf gitdir = STRBUF_INIT;
+
+	if (argc != 2)
+		usage(_("git submodule--helper gitdir <name>"));
+
+	submodule_name_to_gitdir(&gitdir, repo, argv[1]);
+
+	printf("%s\n", gitdir.buf);
+
+	strbuf_release(&gitdir);
+	return 0;
+}
+
 struct sync_cb {
 	const char *prefix;
 	const char *super_prefix;
@@ -3591,6 +3607,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
-- 
2.52.0

