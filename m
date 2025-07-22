Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E797263D
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144163; cv=none; b=OBf0SmMADgbqC8hmEacVtX48Hxe2aWTDtnGXBko60XCjIcFrQ0uGo7TDQ3elauLq1FZ+c96oNJ2FJFybFZows6SQ7nhXS3PKOV9qDbV4J0+53P04rGVBnnaqGCxpDMJkRxamY9fQf7O5r/9nNhw8P7pNQC9WW9qCIWuTBtniEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144163; c=relaxed/simple;
	bh=6evOJuJFN1dt5yONJxxJJM3ds47AHQM4ZYkWwmkDU/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JB/eJ7ymYhaPX5dumGiX5C8WXph6Ws28E5g6FpAgH4Jn4YKd3NKjEZv/bAbCAC82Unp3FN2cpYDUWTZhwQe6ffmBZxF8ufnbsZTWJzk4PNxXYQCGUXVLCzgVvP4LEnIGdXHYEbqYN6LdRHGU8NaaLrLbg7v+0cIYkUb7mqNRfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAkRDysh; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAkRDysh"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-531a1fad7faso1261898e0c.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753144160; x=1753748960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2e7d8A9tL2GGdwf9GR41HI0pA0wh15lMfM3nmntf6A=;
        b=bAkRDyshDFX3G088pwbMMzv1kgXnKV48X+2Fs2jrnvdqdtUFoH54PfoLVUAoognx46
         dYKig8M/L7RPF8pxdUIw4lXKjeHkoEIR7CeSDgC7yXNurKNAQyyCc0d7q/vAKBKNb8Q6
         6B+G+fluGXTFla53vmnCYC+gj1GRtvaKNGHAs4Dr/JUbZ/7p2/1QouD0ICKh75kYoy4J
         U9K44xkdU+jlEQHdgfnZvqYdlKk8lqG37cyEdEErXWsmNu94B5EEYRkwRI/BlMXHSCHC
         gdlRwftkcvygQzfAmKOrq9psZ9tSnAMVNJUDeelMQfkSOrrbAfV3TNPEc7/kBsKNmE5k
         cSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144160; x=1753748960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2e7d8A9tL2GGdwf9GR41HI0pA0wh15lMfM3nmntf6A=;
        b=N6pVsm5Gdhl8F5JGWWufc8YbLktEBgQ0JS7v9DgqzRM7oVWmLnVoylfq039vqZ94V7
         XjO657l/Yvz9qLHFHZhHaLbUYYY11Z+xJ/VVjGrErprm/Dpt59UV9/1KvjepsNASdwY0
         0cpVm+jqUnLRvrGBKiq0ZL70YGj6oNwpeIiDijGUeoOc6PlzFF/SfBLO+AaUAzYFNPK7
         WBb+TkrgYq6192oPxvawHSO9jn0twwhlBkTgoyCFkWnqxG4qKeCC10BeiOknsKnPejif
         zwlx6i3iyT+wFqOm4Onb2UuyyIFcV9xEDaZRFZLq0e746CEzIcCP+MT4xHSwQbZrjiXl
         4iOQ==
X-Gm-Message-State: AOJu0YzrlLdeLeP193xgeplkgS87Yne8lvPC3XPy8A/q2QKejGxg7erj
	WwFJu+N8iUlRfgVphNDHtrLEs+tzz2X3er8TD8bymQAKpqZ7aYsTQMX7I6TMTg==
X-Gm-Gg: ASbGnctfV0UgP7UtpYzXGCdXdg3kcfHQ3mH50wPxSrMQJHYhs/xDFh1MQ+i8lMpTMYg
	GNR+svtcOcQDXbZt/BH553kLDyLMxSB4qMOZ3PnRmxSbaT0NEp/uZD50pq66Se2E0cC+bd9iNSr
	L44TmLu4mnj24BxHTPG0i9sGT25RCZnBpoptOJhLRKJdM4q8t0tvQQ7gKoEdaSScLbBrPh+LGMp
	gOEmev6lokOUFmr+TlGsSthw/V3tpLzV9re+TDuNUT0xzz3gdYC5y8FhNnk+9hCTAn5zrbhXE8v
	3EvJ28tlnN5Evpjd+QYHyF3xCf7e0KOEpZlAjQC5hn3FdpOXKh+OWStuOojbTYs1nkxQq7yuxks
	BIhqXlfqOxqs8y+Vp315YsOh6HjJx5BVxBcZWXgkrH2kPKt/6PsfVbGY=
X-Google-Smtp-Source: AGHT+IH7tLQJ0mnQT+W2qtB55A+ez94z1KqRWue/FMoHe0RvXIwdt9p4dGVDs8Zht3sfvtdOGa4syA==
X-Received: by 2002:a05:6102:3f01:b0:4e9:bae0:7f9a with SMTP id ada2fe7eead31-4f95f3ccfcfmr12259866137.12.1753144159932;
        Mon, 21 Jul 2025 17:29:19 -0700 (PDT)
Received: from localhost.localdomain ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0ad603easm3344169241.16.2025.07.21.17.29.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Jul 2025 17:29:19 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 3/5] repo: add field layout.bare
Date: Mon, 21 Jul 2025 21:28:33 -0300
Message-Id: <20250722002835.33428-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722002835.33428-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
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
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 4 ++++
 builtin/repo.c              | 9 +++++++++
 t/t1900-repo.sh             | 6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index cf8483ec49..7124487323 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -33,6 +33,10 @@ categories:
 Reference-related data:
 * `format`: the reference storage format
 
+`layout`::
+Information about the how the current repository is represented:
+* `bare`: `true` if this is a bare repository, otherwise `false`.
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 5beae0f781..b85bd10889 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,6 +1,9 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "environment.h"
 
 typedef const char *get_value_fn(struct repository *repo);
 
@@ -9,6 +12,11 @@ struct field {
 	get_value_fn *add_field_callback;
 };
 
+static const char *get_layout_bare(struct repository *repo UNUSED)
+{
+	return is_bare_repository() ? "true" : "false";
+}
+
 static const char *get_references_format(struct repository *repo)
 {
 	return ref_storage_format_to_name(repo->ref_storage_format);
@@ -16,6 +24,7 @@ static const char *get_references_format(struct repository *repo)
 
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
+	{ "layout.bare", get_layout_bare },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index f072c7c67b..03609ffff9 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -36,6 +36,12 @@ test_repo_info 'ref format files is retrieved correctly' '
 test_repo_info 'ref format reftable is retrieved correctly' '
 	git init --ref-format=reftable repo' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' '
+	git init repo' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' '
+	git init --bare repo' 'layout.bare' 'true'
+
 test_expect_success "only one value is returned if the same key is requested twice" '
 	test_when_finished "rm -f expected_key expected_value actual_key actual_value output" &&
 	echo "references.format" >expected_key &&
-- 
2.39.5 (Apple Git-154)

