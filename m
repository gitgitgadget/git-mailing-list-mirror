Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA091F0E29
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826988; cv=pass; b=X17FLVAwfUXtRcZPQWIDbC320PMPaOXPwPLH8wD6YgXz4H4M2gMq/iz1xPDLERGa28K2lkqFIprrMJCe2dMukLEcwmR6rvgJcfL0nm+dZeYFz83/TD/x00FKlpoHJGRD6+sfGEaQWQ11vWASvuuhKLjgT0tBtAxGUJCZ6b8iZ30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826988; c=relaxed/simple;
	bh=s5XJCrHsNEH9uWvsrVfVOGG6bIj23LvuWDIZcXyze3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql/ic2SLmEjn5x41SHkoI17wnE1OMvyPd2NW3erRie+RE7o/cdteLW6xtaNIzpxICNDJ/Ts04AsgCNPUvJThh1vpqZ/w5VviXyQFVQPl+O6yc2DzzQgjQ/Ad55DMLAStM/ovdULlPGNWd8CJmT+MYoylBImRAVW9Tj+NlPQ+sd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=X0BRU3Xk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="X0BRU3Xk"
ARC-Seal: i=1; a=rsa-sha256; t=1767826968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ftQqwAy7ANS1G1u3oBgsV7ZnFGZ+r24eKM1VxOz6zndtJr61ELX5/13/B+Fa1tZwlpELcOe6ZZR3zmW4v7nN5iCqWrqqIeeACQv5ZAFXhArFFb5d8CbUU21l5v0lh+S+AAKCbXn442G79L+Kn05avriuCPqnN1QrIcGqhfQSAt4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826968; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KzLCd5uFRUQKY7VWt23VJ5U6VG615J57JNoIWQw0DKc=; 
	b=n6jYNM7jeJsmzL6RhRMD+yGyXk+4y4HMuQYe3uNAhu24/Jmo6tMNFnHYpSbuIQdMu0ns4vtG3tLWNKEns5/mZZWm1Jvh8stx/EaXV6/GNAgnEFbMaa//F+QpdL8LD/9GQvnfkBUP10xVmXGMPz1hIDglDKWc0ntGrDz54S/ow1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826968;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KzLCd5uFRUQKY7VWt23VJ5U6VG615J57JNoIWQw0DKc=;
	b=X0BRU3XkJG1LRkFM79wseQuCPHtE1PWKsERqvZLr8SrHvomCfHf5GuX+jAA9XB6S
	bbRd8ouN8vVtvPuI0nZkVv9yqHJql36VmBWVeVlLPnmmuxkAJwOohdn3ghvHx6JiyA4
	SZtS2derxR6J68p0SUb20C1P26IbE4z3KGUH/ZOg=
Received: by mx.zohomail.com with SMTPS id 176782696521714.603149950493844;
	Wed, 7 Jan 2026 15:02:45 -0800 (PST)
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
Subject: [PATCH v8 03/11] builtin/submodule--helper: add gitdir command
Date: Thu,  8 Jan 2026 01:01:37 +0200
Message-ID: <20260107230145.517562-4-adrian.ratiu@collabora.com>
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
2.51.2

