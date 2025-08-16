Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3723F405
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384403; cv=none; b=ch9CT5UXPvzON9cWzAm4BMIlzD9dGBFvgY0JsjWX1/uENKeI9hB9mt1PXhULkAbunRLFraiC+N0GD1QJb+7xc3SW48T8v4yWyxgRxdmUszxmXSiM7qANzj8CyYV8ayIQKu55WT0Q2QA46AmcctjnYC4CVyjWwChqNYNYI/7VDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384403; c=relaxed/simple;
	bh=dxeDNu+nuu4rPweKsQxcYRgWLkYV/Pqy2vxwFnTVY+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dzLLZ/MmYdOO7ktbPQhRGtI+OK29mlIlOmRROGkfKB4XX0/DI+363Lr3M1KnZ/tktkeUtZ1p+qYzbxyfgb9EHJuniIVMZmzAacVRVgWsitmV/VFKebJ6oZeM6NP/CNASlbPlisNlivm2aWnQeL5KPzhCTOahO+PprOzHjZM4eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEGTUh57; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEGTUh57"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso2701108a91.1
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755384401; x=1755989201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8etdjZ14VGXsEDn3r0PiGIJ3sT7aO/fU0u43Y9cDMmE=;
        b=HEGTUh57hSaphLcscRz/UUYCb5ZNuWkZ44TBLJYvYFlAloThO/NHFZPpKgmUgCThdq
         6CQ7xaYSz1Yfno958RaVWaejgo8R72ePsVEkVxM5zAaKeb9hNrnTEplhjnQ4TvhQKazk
         7VDqcWeyDkDH/qDoRrrAElBhfW8+Y/u/UZ2cN4zwcgQs8NvAvEzjhyi2qQqo/jJZDKbr
         gJptMRaqu+N7Gle0KnUR+V89HqLbSXAHaior9+tfh0Z8swvmuGrx1ZWDyKpcBlAM2cPh
         uyl0uuqUZuNg8cDtdmgWSXLtsHUXX0/6VC9nGNC5ezFjeHYo9/tGSO9lZRy/rVvjiS6U
         2FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384401; x=1755989201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8etdjZ14VGXsEDn3r0PiGIJ3sT7aO/fU0u43Y9cDMmE=;
        b=sKrS9Tdp8M9kZ7MgSWD/3wlC7Y2I4iZ8h49yXUJAyWgUS3SrRR1BPXWXs8CUIvyoy/
         xG5DvWXv4nhovKYBURaQb+k8tn+qBg19DbEjCoYIljhpC9JWOABtgpMpnkhioeDZvFaf
         CgypwPQjazB7WAV6RGTWZZWDFxjWkKEhar8D8XRn/yZdu05Ae0/kLHLn4Iv+P9kUXca/
         6C0X4ydXk6qWTFhFqCpPWaAtxB0ofvm6H+9msWfMSOV5Mg/G4vAbg+b6mKwzSo6Z0raO
         cCNaZMGSG3YsglpEAOpqUDZAjWx+xD8lDZzNRKWV0hiBG44tSGV2SXwbC+8LbHj2Pm47
         6nwg==
X-Gm-Message-State: AOJu0Yxl/xX5tY+2dkNEvOzXA3W0OUck0o3RbLKlsyxhdzhgHZ4E8y+N
	A9AIDjJ3eY2OVRUxMAvgn1h2ObXFxNw+7uVYY0blN5Q0p5r+xyWemQD08UBO0g==
X-Gm-Gg: ASbGncsx2jFQZ1f+9BUN81pFJLcnmbF4aO4WrBIRbHoo0sd2KPruG9RTZd0Cd6i160S
	5KRmz3gkHlAkd6vdtICYK75LAANYtc3EDldYlR0vv5QmHcvWYzM3eAGhHaXoMsPQD4IvZcXu2+S
	MlSybr/Fs9PhmNT5tXV13YjOQvoCAylh1ThlBIkcCqqR8cgSLi2NgTe9c4fAe94vOSEF/VZM8m5
	jQk7xitzYVXiHiSUga+zAjBJjX5yNCC0yN6k3N2pSZ6zNomSsqMib4gbxiARU4xHIaXwzU3gGH4
	ueNRxFAtywlhiXfq2rxf/zZQqVhwaECmLI4NECENikv7LKDa0drI0IpGKd+iM4NuM2WFakKzw/S
	9MspkS/8wFdX/8F3S7hlwazOgSh/1XQ/VnHyEf0yFJLgQoCv5GzPNR5bwtzPfmYHwwNary6eI
X-Google-Smtp-Source: AGHT+IEboCBVT0MlomHynO2zOgwBUI+KO1sj7ba7nQfFJMQAmbZRWSzinnxxcrbvPswwzQkzNEoM5A==
X-Received: by 2002:a17:90b:390f:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-323407b701fmr9876231a91.13.1755384401322;
        Sat, 16 Aug 2025 15:46:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:e855:1cad:1392:e988])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5ad0f7sm4617280a12.2.2025.08.16.15.46.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Aug 2025 15:46:40 -0700 (PDT)
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
Subject: [GSoC PATCH v11 3/5] repo: add the field layout.bare
Date: Sat, 16 Aug 2025 19:46:01 -0300
Message-Id: <20250816224603.3307-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250816224603.3307-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250816224603.3307-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag --is-bare-repository from git-rev-parse is used for retrieving
whether the current repository is bare. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Then, add a new field layout.bare to the git-repo-info subcommand
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
 builtin/repo.c              | 10 ++++++++++
 t/t1900-repo.sh             | 17 +++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 2779a6d995..932b08c26f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -38,6 +38,9 @@ In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
+`layout.bare`::
+	`true` if this is a bare repository, otherwise `false`.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 73d4e27a16..aada476e1c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,4 +1,7 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "environment.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "refs.h"
@@ -16,6 +19,12 @@ struct field {
 	get_value_fn *get_value;
 };
 
+static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -25,6 +34,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 
 /* repo_info_fields keys must be in lexicographical order */
 static const struct field repo_info_fields[] = {
+	{ "layout.bare", get_layout_bare },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index be8a4b2499..b0438d276e 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -38,6 +38,23 @@ test_repo_info 'ref format files is retrieved correctly' \
 test_repo_info 'ref format reftable is retrieved correctly' \
 	'git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' \
+	'git init' 'nonbare' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' \
+	'git init --bare' 'bare' 'layout.bare' 'true'
+
+test_expect_success 'values returned in order requested' '
+	cat >expect <<-\EOF &&
+	layout.bare=false
+	references.format=files
+	layout.bare=false
+	EOF
+	git init --ref-format=files ordered &&
+	git -C ordered repo info layout.bare references.format layout.bare >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key ${SQ}foo${SQ} not found" >expect &&
 	test_must_fail git repo info foo 2>actual &&
-- 
2.39.5 (Apple Git-154)

