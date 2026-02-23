Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F16221726
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875821; cv=none; b=NQFGIRgfAly2Zjt+TbuHjllW0/vsfjaHDOECenIizcA3cNFCDS9UbhTh29Y9iV85JS5nZwvCMFtVrUXWgO/utdfpHmeLSpyeSyDwtpa7iHjRK+tZ44BnIqmXLX1ncSpCGgwKezkKhVfSd80bsflHyxV5j8hGqBW5Hp/40n5EbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875821; c=relaxed/simple;
	bh=0bUZXmla5UsacimDsqCATAe2H7uu1M9i9KT3JienMJA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XBQg1C2sve9KzCgS/s+CAQfpapc3aVZPj6ISHy2OAihtl7SXQEp2tFwKPAJc000JZUO1Zu6pUlR5EtwnMVyWz+yvxJdk1n5frmoBt8zaKOMcfpwAPqMQJlafkY25gtQxgAGjeqfMtSz9a05DgnInCuMZR/nK5Fc18/pZezu/9jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9SYiKJ7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9SYiKJ7"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3fd71badso448249885a.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875819; x=1772480619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VMgLadHKUC5Slj27qjnqYHkUgr6izYn0jYmmMwo+0k=;
        b=V9SYiKJ7u5sL+/gCjGp3qYmZoGXMsgnsZV5tBDyNX6EYeusAU8OV4ChJaeK5WJY12F
         BnInsF/oDrI9UX6DEJUoXgbUNQ2OdEaJJRgR6cR+pOpUEl/dtKOnICc4mMpWx5vkbUS1
         0Ow+4CgBVsEvRsWk/iI2IM5ep85GAvqlnY7fjSpGgCT9jIu9Zdz3XtUFmJf9Kti88ZwO
         g5k+lu+VSJiC9OZpQsuwipfsRf/cn9ooEx/GVgPcn1F3D6hpoqyzzfSyRgSg0/Gf0s7B
         eI1cjSNRuPp1jwkOHNcd6zdIh1T2YtPipIcOhWsqKplQc7fFm9hzjbeQ+tpP3gAu3naP
         n95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875819; x=1772480619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VMgLadHKUC5Slj27qjnqYHkUgr6izYn0jYmmMwo+0k=;
        b=opU8DJrtfNp2vTi/bu5/u4Mkcgqrs7vSVZZaWQpaAYeGewEmvQCP+r/55yknkVoY9r
         Q61HO1FK0pg1j9njVtaR5q05KHzzsicmGts/4FpKG6R19xeWFaKteESfKaSlJnG8uUfA
         OL4HOLmLj60wwe0e2L4KT6qpcyXYVeNEewSYMnYLksZL5sc5fYp7MjuwbTZlvesoK2VK
         m3TP44s1QFTtkjM2LJSXHXKdTJ5CUFhGRGWR+8SJvHW+Ea6ExltAIgBA2zUn1u9Qg5Ir
         v2VtP49ZtbzS9uihSdu5S3vwfzF5EludsB7mK1pDGJ5p/cNJxybtdsdtagLVlTiliE3m
         RROQ==
X-Gm-Message-State: AOJu0YxRRiOiep3ghFWNQgxYx1ZQyJ0kRCkxHXsRkgkV3oEitszw/PSB
	2Y5S+w7JQyial04hUHUBujlKnrMWCxcoE61p/s9qKwVMKTK2x6rxpbJU4mepFw==
X-Gm-Gg: AZuq6aKjj2IayjR+86SuhbNU+gNwcnNdWO2xAyux2Zhk2s2DguAW5Yz1soEMMAQ8ZIC
	IXT48kfTy4gSoJpKP0vtzROWLdPNalg+xNmqDP9Tod4jevR8peBSWPYbflxRD+26uMUiI2hx/b9
	pW876H/30oxDvsGrbuY8scuaN1lxtssxwLPxQIYd++CCF8SC5+BsuxLhBuSc/tuREjJR5fTETvT
	hsfw4ryuBwNJ3KABGK1aM89i0R2/9V6IvmQthpDOZFcKzP+kiP9c5XvJpNacKwtWF7Dbz/DOdkx
	aGZVqHVvRMRWgk/chqKiccGWjzbnvbMM76nElDkA8RVM0F8ZMQvy39OcPwyk3VarDiePYU02EtF
	lA9UDEoo4xwZdZG4U5pJa+wcJShzecUMGerjxLRa5H26qt64NOqF/DM0TeWrIQLSEGB++AeENAz
	JspccXI0LDLA8UYaWk4g58DLaIWuY=
X-Received: by 2002:a05:620a:45ab:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8cb8c9e62a4mr1109451285a.11.1771875819135;
        Mon, 23 Feb 2026 11:43:39 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d120e11sm783067685a.49.2026.02.23.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:43:38 -0800 (PST)
Message-Id: <93585ad0796245e57a3305598d13fdb3c72d7fdb.1771875812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
References: <pull.2208.v2.git.git.1771856469.gitgitgadget@gmail.com>
	<pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 19:43:30 +0000
Subject: [PATCH v3 3/5] repo: add --path-format for info path output
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Teach git repo info to accept --path-format=(absolute|relative)
so scripts can request stable path style explicitly.

This aligns path.* output behavior with existing rev-parse usage
patterns and reduces ad-hoc path conversion in callers.

The option is wired through repo_info context and used by
repo_info_add_path(), so path formatting remains centralized and
consistent across all path.* keys.

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 builtin/repo.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 35e1eaf7d7..e5078e5459 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -20,14 +20,20 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
+	"git repo info [--format=(keyvalue|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
 	"git repo structure [--format=(table|keyvalue|nul) | -z]",
 	NULL
 };
 
+enum path_format {
+	PATH_FORMAT_ABSOLUTE,
+	PATH_FORMAT_RELATIVE,
+};
+
 struct repo_info {
 	struct repository *repo;
 	const char *prefix;
+	enum path_format path_format;
 };
 
 typedef int get_value_fn(struct repo_info *info, struct strbuf *buf);
@@ -47,6 +53,16 @@ static void repo_info_add_path(struct repo_info *info,
 			      struct strbuf *buf,
 			      const char *path)
 {
+	if (info->path_format == PATH_FORMAT_RELATIVE) {
+		char *cwd = xgetcwd();
+		struct strbuf rel_path = STRBUF_INIT;
+
+		strbuf_addstr(buf, relative_path(path, cwd, &rel_path));
+		strbuf_release(&rel_path);
+		free(cwd);
+		return;
+	}
+
 	strbuf_add_absolute_path(buf, path);
 }
 
@@ -340,6 +356,21 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
+static int parse_path_format_cb(const struct option *opt,
+				const char *arg, int unset UNUSED)
+{
+	enum path_format *path_format = opt->value;
+
+	if (!strcmp(arg, "absolute"))
+		*path_format = PATH_FORMAT_ABSOLUTE;
+	else if (!strcmp(arg, "relative"))
+		*path_format = PATH_FORMAT_RELATIVE;
+	else
+		die(_("invalid path format '%s'"), arg);
+
+	return 0;
+}
+
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
@@ -347,6 +378,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	struct repo_info info = {
 		.repo = repo,
 		.prefix = prefix,
+		.path_format = PATH_FORMAT_ABSOLUTE,
 	};
 	int all_keys = 0;
 	struct option options[] = {
@@ -357,6 +389,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_CALLBACK_F(0, "path-format", &info.path_format,
+			       N_("format"), N_("path output format"),
+			       PARSE_OPT_NONEG, parse_path_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
 		OPT_END()
 	};
-- 
gitgitgadget

