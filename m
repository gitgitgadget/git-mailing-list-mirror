Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C02C08AF
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510176; cv=none; b=CS+UK3QCwRUmd+HOAbtTClQd4fTw5W2JlEF1z6FLwaQHKG0V1gkC25su7hjiqvEFVQ4h6u50XNczKj2JSpUQZNJ8Y5vievPttyzt4nUZIx6+0/7CMko/+UVhWKXhEtQUQsxTs10tBvUWqjid+WnI02t2V/BvMF/gxRKxg0Abs6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510176; c=relaxed/simple;
	bh=/cKrYp5DLxfOlLFjXgq6i4Vr297uEvk0L9WK+iNpi2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIp0pvPSJ0JWAMJUPAmJYN0k7T1v1MIJbC9AL2STkHc+iNpLVFalS05l69QFnxRRa754kCVoWBeU4HvLEbffrz6BxL77Q4lsnDrVhG3/nK/R00LCaNzAn9mG0nRCq7NdcAcBaS9OFbVx5kiLHEAqFaNvlCF1a6g8GTH5+yfEJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDmc/8HU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDmc/8HU"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso293879b3a.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510174; x=1755114974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Hc5zdhcB70RgaxhcsC9EmUHw27fVFqJCqoWjI8pEz4=;
        b=eDmc/8HU4aeT7FWRKDT+vrmvZXMYviqHHBUKwnM3joTvEVsgDyU7+ckoiKRMvlwRcI
         QEIlknxD6hoZfss9xiUDZ7KlIYfb4DehBzxdEBPDvwXNth1Enloxnrz8Xi2VPg5en44x
         Xb53xHEawUB0kNDrEj7BLyn7Ly5IFu3pEbdE6HLeQ6rhgHIKG8McFd24YK0PbKtIqpeh
         MCcwEUOCeslEaZ17S1n2Gux437s3Ir5HJX6niZqxafPay6IlAQZaEuGgmOJ2dpj8NdZq
         cGmDW+XpIR/glstWtWpWteJsOXV7dmsScqd6sqy+FexkgS5R723ScOC7VC3qcN4JjODA
         O/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510174; x=1755114974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Hc5zdhcB70RgaxhcsC9EmUHw27fVFqJCqoWjI8pEz4=;
        b=a1ORGC6xlcJwmVxBWWMrXC2kxjQWh167RZgbFrX8CZ6Yr42S5P01p0JjNB53AJFCdy
         j6fEnKLrhQ2BOlI3NBBFubXLtWNcFlG8DiY+5Z3X34A8Ij4Us0cTiOYFeas+MdP95Y6P
         umoo3935VA0YaA/cA1QwoMRz0zJK+TEKiCxOF1BdlJ1l1f+nN9Phos09yRIBWYTBm5MD
         EBvo/l8OgBM1s6AojRp6WZAUIly8XwASJ+3EtMturyTtvpGZpbAbRNVklLKZ3JFm6F6U
         RBskgiNjMUvzNcKCiJAi89UDplVC6X33sbV2r92knpni6aNnDLGspHNB00p7IDgmwag+
         /Hwg==
X-Gm-Message-State: AOJu0YyuoeVrgRLHku5WYwsyGR1ZQ2XOWXCsLWrhzfs3BOipFHB4V74a
	qYyBg+/NPCCD4zd3kCL3/sSbW4AZ1JbDH5sqtv0GYSSnN558mtehpnbOxlHJ1tgp
X-Gm-Gg: ASbGncsYJR7sBWTNAeRzro37Zd+9TMy2+tgWkyzNWgmv3ZDEBlHLdiv/ZFflATTNPlu
	9Rr3UHePROSkHmOg6DZWqMNKIiRgwPfC2L1Y/swHrh7zwFEhVJ98gj9KLi97UQTxgoQ3cy3tfAX
	EborjWeitzCL+dx7FPOf3Wr4+ohVz+r5UU4LCfvc+Hm/QeYNgXJAk4eeQwpGLxDcLWwVjc2clul
	UqAYJKeXJ3h33i3PsPxR41BWh18CcXddcfj9oDNCor+t0bc2/bXoha8oW60X8OdNhqRKRR44YLl
	J6hSJoix4jMZQZlA1zkLHHe2ZdJVSOp+GNLHfjTjR0Vf65P5i7qEW7oqC0qs10qZrGMZ+oigfdo
	V+V1NMY+npdHJ7YobbD7jbp2Aqs4iBUJT4UZInVvj59Lbjw647S4ohMq+70he0aQ=
X-Google-Smtp-Source: AGHT+IHSyxSHiV31C+X2D5nbHdZJH4fgoklkmJhrLpqdV+TK9fK/2ilz3Rp9+volDeqKdGmSMnXyPw==
X-Received: by 2002:a05:6a20:a127:b0:23f:fec8:9ace with SMTP id adf61e73a8af0-24031443601mr7055362637.11.1754510173914;
        Wed, 06 Aug 2025 12:56:13 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm16212400b3a.95.2025.08.06.12.56.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 12:56:13 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v8 4/5] repo: add the field layout.shallow
Date: Wed,  6 Aug 2025 16:55:36 -0300
Message-Id: <20250806195537.93302-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250806195537.93302-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag `--is-shallow-repository` from git-rev-parse is used for
retrieving whether the repository is shallow. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Then, add a new field `layout.shallow` to the git-repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  3 +++
 builtin/repo.c              |  9 +++++++++
 t/t1900-repo.sh             | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 0ef851ee9c..1ae9c09fac 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -40,6 +40,9 @@ values that they return:
 `layout.bare`::
 `true` if this is a bare repository, otherwise `false`.
 
+`layout.shallow`::
+`true` if this is a shallow repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index abdc929e19..312fd08c34 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "shallow.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [<key>...]",
@@ -25,6 +26,13 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 	return 0;
 }
 
+static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf,
+		      is_repository_shallow(repo) ? "true" : "false");
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -35,6 +43,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
+	{ "layout.shallow", get_layout_shallow },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 32f64b635b..ef8205f7fd 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -41,6 +41,16 @@ test_repo_info 'bare repository = false is retrieved correctly' \
 test_repo_info 'bare repository = true is retrieved correctly' \
 	'git init --bare' 'bare' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' \
+	'git init' 'nonshallow' 'layout.shallow' 'false'
+
+test_repo_info 'shallow repository = true is retrieved correctly' \
+	'git init remote &&
+	echo x >remote/x &&
+	git -C remote add x &&
+	git -C remote commit -m x &&
+	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key '\'foo\'' not found" >expected_err &&
 	test_must_fail git repo info foo 2>actual_err &&
-- 
2.39.5 (Apple Git-154)

