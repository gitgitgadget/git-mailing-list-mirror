Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E106246764
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568920; cv=none; b=GwNf56+XN29SUgLNN9lX6o1kXQTOwA+zOIKomzAplvWe8EFOiepS4lvFxj1gmmvsNrukaF+H8LRw3fOkaVg+8pvF0JqLUuQAISG8NPq3N4o3pVapXdjOATqxYaxwufYLLifRXr59kzyXSjL508KJ7/6Hj0dSpA3OCX53S1NaO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568920; c=relaxed/simple;
	bh=Xjs2dXvDKyZIpIRFeF5x0AIHWZwREKtB0yuzxa5/q4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHAArDw4YCUp6DFX6xW2pMYjep+7zgDpilvT9FmbB2As9LCVdnNM3E0Jwg6WKG3DPs1jBLdl75bGrLfI1nyXrLUNFzvbagKZfkCgF/DsQP9PyTOK2izT7cInkPL4Osa9RJRMH5W265xraaiSSp+DUhA4mZPNFQUoEBy/W5XUBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJ2ar1u1; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ2ar1u1"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a44b3526e6so67960111cf.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568918; x=1750173718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5Q8LT3qhGCHmfK9nrFufi+1LiFQeq+5rvC3OIV9Oy0=;
        b=UJ2ar1u1YBKLZXQk20L4FqUjYf3aAcStNfP/M6BmvDhFpnf9nbJKkV17GjS7/wxsX6
         hSNIwX1w+fMmUtbpTLUKanVlfkFyNXrIbR3sNDHMoy2+gVJ2dbo8ewCI4ROXbDdskrTo
         B4MJF9iOYkM7v50CseFqHmcavj+FDNO7BLuGHzT2UskB0dEJupr2xcVGzGYqpXJVRiId
         N2LBg9m6XwrKi112q1Uc1pxXLj35NhVZKULWMmWlreca/bzIYNQzkJu6xJbw19WFbaVi
         AoSCfR9odeVKrsdgFjV8+Yx7G+320ewk+rFc2FxAmTj+Slee90bI6hzGlCUkmONVKaeF
         qEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568918; x=1750173718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5Q8LT3qhGCHmfK9nrFufi+1LiFQeq+5rvC3OIV9Oy0=;
        b=S0XWPKrrzcLd7g5/gvqR/Y3ej8TFGxIFOWol7EW5Et8LduoAOiMs5n4ZrbEUkwsctZ
         RjCj1VA7DNwzhrVZsbDD1JhKPzA4a6z6Nk32d/1ilKxPzy10/AvmmtdezDnfkn3RuVI2
         jVC4/bBRvfC3XnRRDGDaWj9Dtq7T8i/jrL+MYoy0xhSDrA2GJ/iR41khf9+fXOh3U0ql
         XirPOg5fN/fJPvM+sL2YqA/oF0BWCkgsvVUoDjKbBzGnWWt+VozP6yDgmm2FzQENF8Ut
         DI5ga2xbUr3ugilTo/g0IgpOS3b6KwN+2SvKi5W8fPaWwoMRSGhYiKkmDDOnAOPcLoHb
         jfDw==
X-Gm-Message-State: AOJu0YwoPV/Xi6V6Z8XQwf6rfuZZkr5fnbhVI+SZ4W4V4CENrx4/D0XA
	TKwPZPfcp7aQ9w/UAcgc+wfyyskQKJ5XynAkifjvf96Nb60LRuVCPHnvByvf0Q==
X-Gm-Gg: ASbGncvzD8qPyxGz7jwcmJ9gkS+UhVN5iAi+0+S3GE4BLhBAO7sUWdvlEfSqkoh6LOS
	ThxNILGygSNt7QTj6a8hBHq4Ot0wziPpY37atxgqlx3T6rJKGRseQSzcccd32b13l7XDh/0zJLw
	3RltMXVBrZWJzM0ZXyaaVtMe63tga00eCjsJR7WwMleTyUSidxCZtvtBhzIFqEBJAe2v3/blAHy
	z1eLSmVQVHPFtsj9I9BZRyNbKDuxqYC5iOqxtzzKufz0aECESuZdxWiuEfvCgE5A1ox6tfztjdw
	yP2gezoQE2THL/8atidKl11Xez5uksvf5QSp+0tygYx/TiqiP+PRn6ZYnYC80lEsX+dP7P/Q1zk
	ODcwnSTzZmzKR0WTrbnIkm7gL0g==
X-Google-Smtp-Source: AGHT+IER9mr++o/wD2oXY7mQ35P/FMXG50MQpcHpldW+M09LoTx4L20PjNK4a4BakWwm473WiXD/uA==
X-Received: by 2002:a05:622a:5813:b0:4a4:4101:ab1a with SMTP id d75a77b69052e-4a70abee4femr49761011cf.2.1749568917649;
        Tue, 10 Jun 2025 08:21:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:93bc:ecb0:85aa:3d44:2d04])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae4c86bsm1379180241.3.2025.06.10.08.21.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 08:21:57 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH 5/5] repo-info: add field layout.shallow
Date: Tue, 10 Jun 2025 12:21:17 -0300
Message-Id: <20250610152117.14826-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the field layout.shallow to the repo-info command. The data
retrieved in this field is the same that currently is obtained by
running `git rev-parse --is-shallow-repository`.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo-info.c  | 20 ++++++++++++++++--
 t/t1518-repo-info.sh | 48 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index bc25a0809f..d821292d78 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -6,6 +6,7 @@
 #include "json-writer.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "shallow.h"
 
 enum output_format {
 	FORMAT_PLAINTEXT,
@@ -21,7 +22,9 @@ enum repo_info_references_field {
 	FIELD_REFERENCES_FORMAT = 1
 };
 
-enum repo_info_layout_field { FIELD_LAYOUT_BARE = 1
+enum repo_info_layout_field {
+	FIELD_LAYOUT_BARE = 1,
+	FIELD_LAYOUT_SHALLOW = 1 << 1
 };
 
 struct repo_info_field {
@@ -41,7 +44,8 @@ struct repo_info {
 
 const char *default_fields[] = {
 	"references.format",
-	"layout.bare"
+	"layout.bare",
+	"layout.shallow"
 };
 
 static void repo_info_init(struct repo_info *repo_info,
@@ -81,6 +85,10 @@ static void repo_info_init(struct repo_info *repo_info,
 			field->category = CATEGORY_LAYOUT;
 			field->field.layout = FIELD_LAYOUT_BARE;
 		}
+		else if (!strcmp(arg, "layout.shallow")) {
+			field->category = CATEGORY_LAYOUT;
+			field->field.layout = FIELD_LAYOUT_SHALLOW;
+		}
 		else {
 			die("invalid field '%s'", arg);
 		}
@@ -110,6 +118,9 @@ static void repo_info_print_plaintext(struct repo_info *repo_info) {
 			case FIELD_LAYOUT_BARE:
 				puts(is_bare_repository() ? "true" : "false");
 				break;
+			case FIELD_LAYOUT_SHALLOW:
+				puts(is_repository_shallow(repo) ? "true" : "false");
+				break;
 			}
 			break;
 		}
@@ -158,6 +169,11 @@ static void repo_info_print_json(struct repo_info *repo_info)
 			jw_object_bool(&jw, "bare",
 				       is_bare_repository());
 		}
+
+		if (layout_fields & FIELD_LAYOUT_SHALLOW) {
+			jw_object_bool(&jw, "shallow",
+				       is_repository_shallow(repo));
+		}
 		jw_end(&jw);
 	}
 	jw_end(&jw);
diff --git a/t/t1518-repo-info.sh b/t/t1518-repo-info.sh
index 1831b74551..10de93219b 100755
--- a/t/t1518-repo-info.sh
+++ b/t/t1518-repo-info.sh
@@ -6,7 +6,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-DEFAULT_NUMBER_OF_FIELDS=2
+DEFAULT_NUMBER_OF_FIELDS=3
 
 parse_json () {
 	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
@@ -64,6 +64,51 @@ test_repo_info 'bare repository = true is retrieved correctly' \
 	'--bare' \
 	'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' \
+	'' \
+	'layout.shallow' 'false'
+
+test_expect_success 'json: shallow repository = true is retrieved correctly' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	echo x >x &&
+	git add x &&
+	git commit -m x &&
+	git clone --depth 1 "file://$PWD" cloned &&
+	cd cloned &&
+	echo 1 >expect &&
+	git repo-info "layout.shallow" | parse_json >output &&
+	grep -F "row[0].layout.shallow" output | cut -d " " -f 2 >actual &&
+	cat actual > /dev/ttys001 &&
+	test_cmp expect actual
+'
+
+test_expect_success 'plaintext: shallow repository = true is retrieved correctly' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	echo x >x &&
+	git add x &&
+	git commit -m x &&
+	test_commit "commit" &&
+	git clone --depth=1 "file://$PWD" cloned &&
+	cd cloned &&
+       	echo true >expect &&
+       	git repo-info --format=plaintext "layout.shallow" >actual &&
+       	test_cmp expect actual
+'
+
+test_expect_success 'plaintext: output all default fields' "
+	git repo-info --format=plaintext >actual &&
+	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
+"
+
+test_expect_success 'json: output all default fields' "
+	git repo-info --format=json | parse_json | grep '.*\..*\..*' >actual &&
+	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
+"
+
 test_expect_success 'plaintext: output all default fields' "
 	git repo-info --format=plaintext >actual &&
 	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
@@ -74,4 +119,5 @@ test_expect_success 'json: output all default fields' "
 	test_line_count = $DEFAULT_NUMBER_OF_FIELDS actual
 "
 
+
 test_done
-- 
2.39.5 (Apple Git-154)

