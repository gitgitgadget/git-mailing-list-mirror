Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAD298CB7
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613357; cv=pass; b=Dv2P0rJALHX9cAawXutipbejhsIcIHuLDQaRB3EcWqxo0EGyz+GlLd1DGu6lyqUnCi9sjh5B9JoCqluTrwyi28iVfVP3vyQC87B8FSn7fLv3OvkeNITi0ZnA6X6Q+3MTNNJHhmzX97BcMp3oiFujOli2blwA0sjCFsTz5cIXlKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613357; c=relaxed/simple;
	bh=fnev7uCKVZtoqga0Z1ssjQ//SvS0zkR6SreYSXRF46U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCDkNBfbacj97/ny6rOe5Vzr3oiFTwfqPg4EL7PH+Fz8qlRrWQXrGqoc/l+EO1sYxYebxiD8SHB62J2fq+jo2u1P0yZgEWTPiNn+hY1HsoMF2YIBCZ6Grw3ReNk5Ldme3vispln/QdyevvIATgzbsBt/xjwZBxRB0k1GwfVBvpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=SU7hwDUl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="SU7hwDUl"
ARC-Seal: i=1; a=rsa-sha256; t=1765613341; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dhFghmHaYDGg/xiV/OfS6USA9EttdqcZegaNVtkCeli3lwLOlr4cTbuB8IbScQs0tfvzaYMqEAwZ8ZvBJm0bd36XyPohE96lmflPiXgEJ9j2Jc+Qrm2y+5jM6CqhW1kczKqGUS7Oi4SxTMatQJ3ClAdKPNcMGAy0lyNSPt2ej9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765613341; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L+uf1to0k3f0n9BBWfRxf44sm544fNws/V4SB2hBxWY=; 
	b=H3JGJHtYLfxhP1WORHf3Yc72sp2QJu7ISPbR2r9yIwW41xVdezKq194odQKu+aJaP+H3Ylx4AOIQTOdPdm4txNHw1OhDikQ01emGA1ZLAsNwOc+dLN2qtAMcnST8tRST17sRUu8atUWL+cha5UXk3FIo5P3CRgReuT+Rci9Tzzk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765613341;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=L+uf1to0k3f0n9BBWfRxf44sm544fNws/V4SB2hBxWY=;
	b=SU7hwDUl8ETQxp2dMjnYVeJyuo8U4NOHxZibAot8yJekaE1fM9h87bITB4P6hGGY
	dWYBoFhi3l8xwPTHEb8qx9rhTu0z01PR71Uyrjb02wOFmxU+TXsZ8QH3qzydsW6hEFu
	ORAy93DnxF+M7VBdrICevMwLrPg5zud1L+V6rPVw=
Received: by mx.zohomail.com with SMTPS id 1765613339385188.72851883364297;
	Sat, 13 Dec 2025 00:08:59 -0800 (PST)
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
Subject: [PATCH v6 03/10] builtin/submodule--helper: add gitdir command
Date: Sat, 13 Dec 2025 10:08:09 +0200
Message-ID: <20251213080817.347922-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251213080817.347922-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251213080817.347922-1-adrian.ratiu@collabora.com>
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
index f1fc098614..3bc139ff9c 100644
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
@@ -3583,6 +3599,7 @@ int cmd_submodule__helper(int argc,
 		NULL
 	};
 	struct option options[] = {
+		OPT_SUBCOMMAND("gitdir", &fn, module_gitdir),
 		OPT_SUBCOMMAND("clone", &fn, module_clone),
 		OPT_SUBCOMMAND("add", &fn, module_add),
 		OPT_SUBCOMMAND("update", &fn, module_update),
-- 
2.51.2

