Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBC27991C
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537171; cv=none; b=Ap76WS98nrf66vrOvtWcJJcccyivbwgMgDSHFhd0s6+HYA4CxV0jyf/L5fvS2FhlNeobvuBfRgmvUxw1HcBm9HqXwtV565XB7T0pMzAlTDNQhnPEJFFQPDxhHF1hr0gxOsTnV0dE7k3mUHCaI/aitJeC+FOKuw3WDV2lNv5ODc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537171; c=relaxed/simple;
	bh=Y+iIwyTeZuPMRkmuvUQAjzkBKSgQ0tv8mKbjpdew7lU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSyQ7+ypMUqLCc1Zuoan2B+NbCSlnDoYl+mKZh8V+aoFg3E/qU86plra8bTBAQsAXF2w1dy/+C4n1p3LAKDCZJ1T+YPTqGWlzbyDmSWHk50N7wckCFiTZpBc8nvnVqvfMAWIHghWWs279RZQRpHNpKJ49hDchZlBrTwTRB3mo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBWjthQI; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBWjthQI"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5346b405d1aso4591906e0c.2
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752537168; x=1753141968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx5/fJQLvGgPHox4b6yDbXlZhcHgGSXTRho1jjDS0C8=;
        b=WBWjthQIri0HocQ6PmOVyupg4l4IfIdBMcmOhpFvRGwDw7uwt1MNQ35kPmLRZt7K4V
         GervxkL8uus6BkY4TD8NSQqmhKyVWhu23IuhqprOMgo4SFnoiJGia1m1bfdLL8iOUsOd
         PnhIzRBh0yfdvj2w/HPlWTpMq8PUjRRmdNxl6+9SP5K0GwR9oeXSQtc3xQuAoga/0949
         mod3nGSb/qmQavpzfyk9fS9qd8tWWlyOKHqeciQEVcbkZnUzmk4hypBxAIL/WP4kO/tW
         n5+AFzN9+WS5dqpMIEax76vlOO1MwD1w+m6QI5+7sYBZ5dw1//i+bYz1To90FgKAYLGk
         4smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537168; x=1753141968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx5/fJQLvGgPHox4b6yDbXlZhcHgGSXTRho1jjDS0C8=;
        b=mPhk5Dx5VHUQ15uHfWDQh4oDLl5CqtBBqmpkp50xIQCrd0tQRMRP3uuZSRHKTpvVVz
         KCxNXdjFl+6uirkSofLt4xMmDS019hHDtu/m/9hBwmFQDIICzMhuynYJqUhWfC3fSHRZ
         51Fmzp9LA6RJ3T+F26Jsplzjy5lRsrmjbfEoLfWNgWWZygDmga4UdYzpWDRWNEZE7oVB
         +UcBVI7nJV6B+sqRlokTBtED5s5feKyYhHDZk9Rb8DwKBucnys176gYqQdeEcuzbTymo
         3HcKO/DdNsMs2PX0fwU/y4uN1DL4KanjCf7b96ALz5KOV9/jDIr2Af1YbEMU1M5UkAQ+
         Iw/Q==
X-Gm-Message-State: AOJu0YzSSwHJL45Jw4fpEvD5dHeWmMrvFZHxizai8AdfZOo6CrwGFFfc
	hhhlv3Ecw7lA04TKXmTgGOL3XKCKuqW6nxmqpJPGSVlpJZTKhKbuv5jhgDzdubOY
X-Gm-Gg: ASbGncu2ikEy21xcLSfUSn/TvVUiy7XB0wLUuC9/M+pRM6i5Dn3kFqPI0KeOEts2DAR
	4GLW7w76Rqa7Edto9ec/d9iVYG7gplAfBb20bc1CjZ53TfvsOd5e6roCPqudwN+VfwQo9g1T7Vz
	wlLnTW515WvpYawfEeG5sfbvK96nrr9Mg5DRybOyses/t11FaHhxyccpPWmz7yLyc3mfi0oRyR1
	Jfuk1BiJXQyWJA/7Ziq+05A6iLw8jxekTyreOLxhlRTxhhtL1NgmoyjKJg5Hc1o2+RRazvBJkGL
	SYwh5FXTitJLcu0MQCcDxgEGo3+CQUBolPyMVr6JLZ7qGNDPegchLWX9qcO7gHJBqmvPlyScjkP
	0QIbF505xALhWOapyx4Tl9BAGJVP74+EEiWX0MCXmX/dN50Qi76USrBo+AcyIirbmV1XHlto5GQ
	==
X-Google-Smtp-Source: AGHT+IFl4S81w9m35djSiAxeqQSFToOe4ZTsH13SEa9x+P6Rthq/BJWU0he00pZm3q71qFe/gzgmsQ==
X-Received: by 2002:a05:6122:1313:b0:535:caf8:1198 with SMTP id 71dfb90a1353d-535f46c469bmr9492401e0c.2.1752537168348;
        Mon, 14 Jul 2025 16:52:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:fc3:f915:3491:9732:5741])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e73de3c8sm1999201e0c.48.2025.07.14.16.52.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 16:52:47 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v4 3/4] repo: add field layout.bare
Date: Mon, 14 Jul 2025 20:52:30 -0300
Message-Id: <20250714235231.10137-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250714235231.10137-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
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
 Documentation/git-repo.adoc |  4 ++++
 builtin/repo.c              | 17 +++++++++++++++++
 t/t1900-repo.sh             |  6 ++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index b7af6f45a4..db185c5c91 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -49,6 +49,10 @@ categories:
 Reference-related data:
 * `format`: the reference storage format, either `files` or `reftable`.
 
+`layout`::
+Information about the how the current repository is represented:
+* `bare`: `true` if this is a bare repository, otherwise `false`.
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index dcda0d6d61..5eefe06918 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,7 +1,10 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "parse-options.h"
 #include "strbuf.h"
 #include "refs.h"
+#include "environment.h"
 
 typedef void add_field_fn(struct strbuf *buf, struct repository *repo);
 
@@ -16,6 +19,13 @@ static void add_string(struct strbuf *buf,
 	strbuf_addf(buf, "%s\n%s%c", key, value, '\0');
 }
 
+static void add_bool(struct strbuf *buf,
+		     const char *key, const int value)
+{
+	const char *output_value = value ? "true" : "false";
+	strbuf_addf(buf, "%s\n%s%c", key, output_value, '\0');
+}
+
 static void add_references_format(struct strbuf *buf,
 				  struct repository *repo)
 {
@@ -23,8 +33,15 @@ static void add_references_format(struct strbuf *buf,
 		   ref_storage_format_to_name(repo->ref_storage_format));
 }
 
+
+static void add_layout_bare(struct strbuf *buf, struct repository *repo UNUSED)
+{
+	add_bool(buf, "layout.bare", is_bare_repository());
+}
+
 // repo_info_fields keys should be in lexicographical order
 static const struct field repo_info_fields[] = {
+	{"layout.bare", add_layout_bare},
 	{"references.format", add_references_format},
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index b80fc6b78b..6155e275b5 100755
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
 	echo "references.format" > expected &&
 	git rev-parse --show-ref-format > ref-format &&
-- 
2.39.5 (Apple Git-154)

