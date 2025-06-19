Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6C290D83
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750373902; cv=none; b=mzC4z2xQl9nzouZwFcvgYRQiKWhbhCcc0mBwt0eTY+jk7ZY7hh8deuzCNewXnAEepgCyznAj5WsbumJLrfJvzz5Qn/d3NNTfsJfz47Sg5SvDjJq7fbc4vSGqqQtsx6RC1Z0/BbaqrIB8BZINuAtQw0+vmri3PJ/Yj38Ms3Sq2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750373902; c=relaxed/simple;
	bh=QMoyB2Mnsvxd+K6MzQ8D9klrlNB6pXwLvkgEd8V/m9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Se+qHA6kpDTFPDGM3R2bOlfoom0NV8EsgGDf0LjAfIPtzWfAks5oJPL+/iu7lZW7+zl0qXhH9s3Y0xD3lmcMyAirtoJymjVOuO6SOOYlg7z8R+wjIRLsmnnS6DsaQevLbjB7PE3D3QvBZ41BWblA9bKLvSYydg2TQiBsyoutWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej5qAj/7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej5qAj/7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2363497cc4dso9676505ad.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750373899; x=1750978699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZTLXz6MOFQ0JeieSE4vf5gZVjbOt+rgO/iTg/9FHh4=;
        b=Ej5qAj/7/yOTsy5fmRTp/9JOna83209pXEy43Ncik45fyUm3fywLYgWRTlqPLsfnke
         c7aG08i3SA7Ygty9qKop81SudVwMqIhAIaXSj3H4Pwa0pYWN1slfj4ndUGqyxaoE1CfZ
         jC/iU4xYZaqtu3yjI7/tobO6dx5ll38E6XVt+OSW6Psf5I3oyYUpLTOQ1YEwu4cAcnr2
         EuhS4qV7E9tj7daQVJO6XRkKGU9Yw7jPODHGZMKMNpha3S3l135Bei9wePCMMnZspreH
         uSytEFWrgBryXvDQoT3lPBYilllZTtCmDk1mFxBr3gewNxPKP1N8LmSfYz7xbZPOdY/S
         iUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750373899; x=1750978699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZTLXz6MOFQ0JeieSE4vf5gZVjbOt+rgO/iTg/9FHh4=;
        b=oMDZmU2e/hMti4wDALrm/GhqWkefw46PNlpV3oNG1Q7303G2MHRbGkNAGLx0wdw07r
         UfTzZ3yxcN7I6eaRUz+qWL+GNOBv2W9LXJVviq36rxs0OqWmeA362tsLLzOB1kkwhvw6
         ONV1Nc6ZoBzGBblVm+dWBQA3/LwXwhYyHiJ9k432JJHhjXR9hzvOVCqygpjy8zq9ylBa
         kgiW4eVOH+DdlGzK/U4dHqVIYeMcVcQ2hBlPHGaB/Re7Nxox7jZfu6o/HGdye83N6/9L
         nVgPbiSqwSe9fOZPpm+R2B/kDiEXla5S9lhLnfWYKpq7gbm5W77EANWf1pEGCbDI4FuH
         mJJA==
X-Gm-Message-State: AOJu0Yy1j2nWLGxEJh8KyPlWt+1xvnzgnaQBXqrHIj2lkkcecFno7lbE
	0JPqDrgOsWLv6/zcNBCS057yV/JY+LMGmS6AWYX/V1FGwm7T2n8u9x3O4osGzg==
X-Gm-Gg: ASbGncvzT3XtijlnPpWUwisCKEgiHMg4VB0M9Jq+M0NEq8lJS0LB7nMX/kZdRrc6sBy
	vH5t+LDwkzaqc3jqas5r9S4W/S+cKkRKOiRV1zoqRopeN1x9Vl/htTJ17sPfL6Sx6Z5YJ2gxIkD
	H+RnBNKzj8uV3jF6sWo6iQwjaHBl42BQBa9ycOfGJ/n/CtnOGhf/7x4vH5Ufmpw4huCTetoH5dh
	WGsigOQn1iAGApzlG+Uz63rhr6dGYnUAFfnbHiuJGaDg/rw6NruAWonWW3jCC82QD4fR/Vd4iaW
	Ubp90U4ZPadFmot9XphGleUFshWsQYxJkXRmmrbLgNiF1q+TyHqzkAL9xM7mtMbJZVjVEtwM+Pj
	yk0Nw0pLVbBT6YmQV2Q==
X-Google-Smtp-Source: AGHT+IHJbVnve2L/baHhHvW6sxLAcN8fgJtYmpD5NI0KPXZjHI4XCW7N0+dqKsazw+Rh7524ycPV1A==
X-Received: by 2002:a17:903:166e:b0:223:7006:4db2 with SMTP id d9443c01a7336-237d9999a45mr7520645ad.31.1750373898664;
        Thu, 19 Jun 2025 15:58:18 -0700 (PDT)
Received: from localhost.localdomain ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm3470515ad.185.2025.06.19.15.58.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Jun 2025 15:58:18 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v2 6/7] repo-info: add field layout.bare
Date: Thu, 19 Jun 2025 19:57:50 -0300
Message-Id: <20250619225751.99699-7-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250619225751.99699-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the field layout.bare to the repo-info command. The data
retrieved in this field is the same that currently is obtained by
running `git rev-parse --is-bare-repository`.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 t/t1900-repo-info.sh |  8 +++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 6ce3e6134f..1650d3595c 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,4 +1,8 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "environment.h"
+#include "hash.h"
 #include "json-writer.h"
 #include "parse-options.h"
 #include "quote.h"
@@ -10,17 +14,23 @@ enum output_format {
 };
 
 enum repo_info_category {
-	CATEGORY_REFERENCES = 1 << 0
+	CATEGORY_REFERENCES = 1 << 0,
+	CATEGORY_LAYOUT = 1 << 1
 };
 
 enum repo_info_references_field {
 	FIELD_REFERENCES_FORMAT = 1 << 0
 };
 
+enum repo_info_layout_field {
+	FIELD_LAYOUT_BARE = 1 << 0
+};
+
 struct repo_info_field {
 	enum repo_info_category category;
 	union {
 		enum repo_info_references_field references;
+		enum repo_info_layout_field layout;
 	} field;
 };
 
@@ -35,6 +45,10 @@ static struct repo_info_field default_fields[] = {
 	{
 		.category = CATEGORY_REFERENCES,
 		.field.references = FIELD_REFERENCES_FORMAT
+	},
+	{
+		.category = CATEGORY_LAYOUT,
+		.field.layout = FIELD_LAYOUT_BARE
 	}
 };
 
@@ -74,6 +88,9 @@ static void repo_info_init(struct repo_info *repo_info,
 			if (!strcmp(arg, "references.format")) {
 				field->category = CATEGORY_REFERENCES;
 				field->field.references = FIELD_REFERENCES_FORMAT;
+			} else if (!strcmp(arg, "layout.bare")) {
+				field->category = CATEGORY_LAYOUT;
+				field->field.layout = FIELD_LAYOUT_BARE;
 			} else {
 				die("invalid field '%s'", arg);
 			}
@@ -101,6 +118,15 @@ static void repo_info_print_plaintext(struct repo_info *repo_info) {
 				break;
 			}
 			break;
+		case CATEGORY_LAYOUT:
+			switch (field->field.layout) {
+			case FIELD_LAYOUT_BARE:
+				print_key_value("layout.bare",
+						is_bare_repository() ?
+							"true" : "false");
+				break;
+			}
+			break;
 		}
 	}
 }
@@ -111,6 +137,7 @@ static void repo_info_print_json(struct repo_info *repo_info)
 	int i;
 	unsigned int categories = 0;
 	unsigned int references_fields = 0;
+	unsigned int layout_fields = 0;
 	struct repository *repo = repo_info->repo;
 
 	for (i = 0; i < repo_info->n_fields; i++) {
@@ -120,6 +147,9 @@ static void repo_info_print_json(struct repo_info *repo_info)
 		case CATEGORY_REFERENCES:
 			references_fields |= field->field.references;
 			break;
+		case CATEGORY_LAYOUT:
+			layout_fields |= field->field.layout;
+			break;
 		}
 	}
 
@@ -136,6 +166,15 @@ static void repo_info_print_json(struct repo_info *repo_info)
 		}
 		jw_end(&jw);
 	}
+
+	if (categories & CATEGORY_LAYOUT) {
+		jw_object_inline_begin_object(&jw, "layout");
+		if (layout_fields & FIELD_LAYOUT_BARE) {
+			jw_object_bool(&jw, "bare",
+				       is_bare_repository());
+		}
+		jw_end(&jw);
+	}
 	jw_end(&jw);
 
 	puts(jw.json.buf);
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index d6e6f6ed1d..0d1096b40b 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -6,7 +6,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-DEFAULT_NUMBER_OF_FIELDS=1
+DEFAULT_NUMBER_OF_FIELDS=2
 
 parse_json () {
 	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
@@ -71,6 +71,12 @@ test_repo_info 'ref format files is retrieved correctly' '
 test_repo_info 'ref format reftable is retrieved correctly' '
 	git init --ref-format=reftable repo' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' '
+	git init repo' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' '
+	git init --bare repo' 'layout.bare' 'true'
+
 test_expect_success 'plaintext: output all default fields' "
 	git repo-info --format=plaintext >actual &&
 	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
-- 
2.39.5 (Apple Git-154)

