Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F11758B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579053; cv=none; b=cz8mIRPTSYQ9ukiapO6foAR7p92Q2LvFth71PbGlmY9h0zF2z9p0nq7cAnkvOWhSKvimIA51ohFxDi0nRYM3gAm8NhzWP2ZP1gzyOpu+HkgYlrCQGlZ2B8EcEXdjQU6iI/3wL7KQVFx+L8miqGWax1Lrbgj2bsPaCk9yuokwvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579053; c=relaxed/simple;
	bh=isciVhivojnRtS/OETLcj3sVbdfuFLrb5sOcTGjHPAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ftt6ohF9QE0aPQCajl9IgTMt64beAryIfh/Gc38mwv2expum4zcEu1aYhCxukeCk4bQJMJgzai67oCA2u++WzCXvVs0WcKybTZIJkbTwkg3N13c9WvRSHUPUEWdjtvWiajGQ8wTbGa686wcqTrdSpGntDVw4O/RPdC1jfJhi2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUPwm9Km; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUPwm9Km"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2402774851fso9977055ad.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754579051; x=1755183851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAtvFfRnnd1bmuKZck+UJvsvZ1Mhux+6yk8fajdNGhQ=;
        b=aUPwm9KmNRYNmd+kAwSPhNmGdcTYWj10S3w7Lq6B6koTrMafK+wmnYVv8i7YNHQs5x
         NVPBX88zmVxncYQkOi31qAponyuGefLQDmD+0/yCjBkWWkGjiygr1dp+WGaJxWzOSFAz
         zAMYoiuyLr8AsJx4bh95paK6kdFgTV1iYvTiaT+i/5W/CuH0SM4Iwvc8Ly5YhJ6wINYE
         xfqcpUXJ/ebm7d4uUEoipErWvZfxrwSvzl0lar9s39hRl8ysryxHqkQ0psPocir6jCBd
         wZ9yxRsffzZbnxYBICvgdCZBUZ/Uv3bvtkaMS9B+0IGgZPashZU5Yn0YsX44nHwSOOiu
         5/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579051; x=1755183851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAtvFfRnnd1bmuKZck+UJvsvZ1Mhux+6yk8fajdNGhQ=;
        b=A7kRCbhxPlDll+XYSWE9mmj0mQ7Fcsxyotak73X+pa6K5WWaKQlLepEmYUa48W/5mx
         zeH3YvznryD5g9v/h7jS8ZBomvM/wkihazvaH8YVWMzDgmS2VKGAL8atxo12FSd+uWep
         J1vwjAlX/0b7TBnfIwplQffGU9uZ/RF2kroRCuIalaCsQg0B4k3k8/+KTDAOiIYkqBKF
         jamlKJFsYc1tsN+7edH+e3nYIX71tHvVPTceTR8f+UGBq3NscIcN2DZZTlWcBU9dyfZR
         OiiBfXPHbBxEwpvrbYzbC6329YdfaPB/tEHRcGBt4BpT5totafO/7dH/mVECHft5M1QH
         RaTw==
X-Gm-Message-State: AOJu0YwTmak894ELZKRmt9m2jRPu83EmWJTzzeY3dngrNHfBYbb1hMtN
	ygYgLFniNz/6pzAiL9ujiSuQxNp5DysK77b3uNUrygxJmHeyG8mBH/iDMqX4lA==
X-Gm-Gg: ASbGncty9EQaREzQHfg3SM0oFB7TLzeTw9x55pS4PnFi6mj0zgjg1vPZXEPZkqAPDyI
	/+xOuVykHhI1UUl9Xb93ehSa3hcmqq8t2ZdD3Ad9uZZEs2786hb+vryEuQ0fFrNTIVTQ9AGKbv/
	AG6McOwuk3xmPdq3iZfdpI5GPhcfPk+LrxrLGRJXHCSTLlC5jWkqpcKQzzLA2sBjkISfObB7v5Z
	0mXIMBiJMcoT2Wo5QsbEi3bxpjxdm83+8Ro5SU3fNngAAG1LH6BjOHY6dvfdk1umHzcfg4l0VeF
	icIUxnFLQ9hwF5Ad+DFglWtM824B6J4aeJTAVax+a86LgFnG96LHR7gIwVgCsYqWondJy4E+NHq
	Hpu+P1TIy0aZP6GeJkZ6Lu5mp0427LiWxssJgUHBRlGWKTYh2AAd/tNZo7MlHkw==
X-Google-Smtp-Source: AGHT+IFMlbfnbJjt8HdqDb2XGiNlUrXC0lpWoYr0ZF3bE4J/JeJ5UGIGZ8UQVm1BO7EpvNPGaXxX1w==
X-Received: by 2002:a17:902:ebc4:b0:23f:df69:af50 with SMTP id d9443c01a7336-2429f4ae071mr121705615ad.34.1754579047386;
        Thu, 07 Aug 2025 08:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8359:45d5:14c8:c621:17ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm106617065ad.54.2025.08.07.08.04.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:04:07 -0700 (PDT)
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
Subject: [GSoC PATCH v9 3/5] repo: add the field layout.bare
Date: Thu,  7 Aug 2025 12:02:37 -0300
Message-Id: <20250807150239.6987-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
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
 t/t1900-repo.sh             | 16 ++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 0ee783abc2..0ef851ee9c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -37,6 +37,9 @@ In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
+`layout.bare`::
+`true` if this is a bare repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 2b7ab5875e..abdc929e19 100644
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
 
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
+	{ "layout.bare", get_layout_bare },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 2b2516dbae..e5a624ec71 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -35,6 +35,12 @@ test_repo_info 'ref format files is retrieved correctly' '
 test_repo_info 'ref format reftable is retrieved correctly' '
 	git init --ref-format=reftable' 'format-reftable' 'references.format' 'reftable'
 
+test_repo_info 'bare repository = false is retrieved correctly' \
+	'git init' 'nonbare' 'layout.bare' 'false'
+
+test_repo_info 'bare repository = true is retrieved correctly' \
+	'git init --bare' 'bare' 'layout.bare' 'true'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
 	test_must_fail git repo info foo 2>actual_err &&
@@ -54,4 +60,14 @@ test_expect_success 'only one value is returned if the same key is requested twi
 	test_cmp expect actual
 '
 
+test_expect_success 'output is returned correctly when two keys are requested' '
+	cat >expected <<-\EOF &&
+	layout.bare=false
+	references.format=files
+	EOF
+	git init --ref-format=files two-keys &&
+	git -C two-keys repo info layout.bare references.format >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

