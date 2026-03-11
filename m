Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C532EFDA1
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256943; cv=none; b=HsizjowJS+dYtRoEbzUg6SoI5lwz5WJRIyJeLw3rB2zDuoLdQFbNMLj2mMNf3S+fhZDb/JWO4NTonf5OZ+QhssCpo9zRwK+nxn2oeqis97SIubiFMvDyDjSm1XCmLcyIetSraM/GVC2cBdVg6C4jLt7rH6cUk/iq0cfZ3vKXPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256943; c=relaxed/simple;
	bh=kK+IL0mmlIGUp/sUH1YF6wKYpXg6rEI956/8IsEUe54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioI0o4SSZ7+vhszcOuQKLBtOvmECNon2oYwSryb9adO7Zbqn8NsWxf5zG2zBTI7XkA23gpxew67PHUZXZnmLoH6t01Vq3dwDIjml7R92d+JLwOd1v4yl3ofea7GJ4ExdvDtnpYc86EJMN4EPwXXU+cJBwL+ByC8YB+yn4I42j3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb5gdlw+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb5gdlw+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad21f437eeso2616165ad.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256941; x=1773861741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZuaECEC45SMttxZakFEHmCVqB4gmf+Wy5UyAgerXFI=;
        b=Bb5gdlw+x+swQkEIxRdm9qWMJYdNUGpV11OCY+5qMX6xsgYFBsSfDLzZ1IIYYlmLVe
         Uay4GzKiKdzJfIG5jwi3rRoWYXP5d8Cc55gVGXMxFG5VGU5d+fRCJVoLDjrg8uQvQALX
         lk41EgnwFEusBpFFqOTDoCq7ZzJiptjjFG//yyshXh8CvHVbjkbd/b+ofsR6ADjsBEPc
         oBGP2HTvL2/EX6MljoRaYFo+KD2FBRsO7eZFEGlM9do/Nea0/gisp7svgBVp99Ri2oAk
         txkxuAT8JBaVekw41aRTI+zUOsOcOCV0M1GcO9f5Eju5sthzh3TdN3JLxz/fKQfGbb1U
         bhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256941; x=1773861741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZuaECEC45SMttxZakFEHmCVqB4gmf+Wy5UyAgerXFI=;
        b=BZiBH1Xc8otrwuxWmiL6/OqrKORvO3thdiVgVvlfoft6KHaAY5zaZ3opniBnbsBxAe
         4IYC8syz+wMHL/rdzcB0KlKm1LSIqWRvWFJvpC1aDf83Iu9IIL+1VKHqNQ/KM9+dBS+S
         txZOhopG20DixQVI8Jqo0ESz9N9vEyYmgOhhxlDJCSnBeutLgqdOJGgAw8KEalCwoZJl
         KggLF+y85WJEX+LcUjEcgKGrehWz7AjfUfBq2uQ7VHy81KRjzSQkRCq8RTv4LsbUSVPI
         2B13cTKMyENl+PdYWJn/YcXmr/sNS6K7pxhEuB9ndjgjXFUGwW6/nuo/CXJlg5Nz7dlM
         zseg==
X-Gm-Message-State: AOJu0YwBWZ5ycka5LWoEwNRdQ3t5eC8TbQRmFd/42g2VyxuMZQug+juY
	ndUpXOWE9f66DXwJGLMPbGB8WQHeyM56niv2Tp2ahl5golEmV5RZJA9/ZgQ97A==
X-Gm-Gg: ATEYQzwYd5tvDqzKBRSOGLjqY5LKb3HNXXWbf2Rc8e5QGytzxOH2nXOwxL9pcyUG1cT
	mr2oSTgZeUT8HMh0KiPe+iTn7hPLwq81pUptaLu3qoz5/Vwl3lqAG02dXZ90tKKcpGVi9dGfWLP
	6Q4K3f4ZSTJ0kQj9Jia3nveAlPrU7cSbj1nlibVeBdEUmXTGP/nOhB+Xa8N+UYW7eIPFub6svQ8
	fPo8073iXFeVbWNF8QQ25uUE+tLtxo8wGObIxtOX+wEffuJStkJGj2r59mD1RqOKPWVXJfi1tBr
	Tvfw1xneJT0Y80rRmWGTGT0nfav6BbBTAKX7q4zfFsBSez08hFaF2X4f7JMkxaMkklXUt/da8/9
	9kAZuWvEXl7hkzqRjpTuHn0pLNRvNLBNU166155eVXHpcyn1smSrRG6uFYfbtD08ARu235SeBcD
	xoahIcZfhkYO7lt8N5RSjQ9Y8Xo+Lo4R75lL+orkpBemmDJopeVa97Ru/ghdfp58ODlH/nqsPz4
	KAOEsA=
X-Received: by 2002:a17:903:1a70:b0:2a7:5f26:aaf9 with SMTP id d9443c01a7336-2aeba4eabfdmr5673845ad.14.1773256941174;
        Wed, 11 Mar 2026 12:22:21 -0700 (PDT)
Received: from localhost.localdomain ([115.98.233.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae22217dsm31688915ad.4.2026.03.11.12.22.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 12:22:20 -0700 (PDT)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	r.siddharth.shrimali@gmail.com,
	amishhhaaaa@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH v5] help: cleanup the contruction of keys_uniq
Date: Thu, 12 Mar 2026 00:51:51 +0530
Message-ID: <20260311192151.60489-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

construction of keys_uniq depends on sort operation
executed on keys before processing, which does not
gurantee that keys_uniq will be sorted.

refactor the code to shift the sort operation after
the processing to remove dependency on key's sort operation
and strictly maintain the sorted order of keys_uniq.

move strbuf init and release out of loop to reuse same buffer.

dedent sort -u and sed in tests and replace grep with sed, to
avoid piping grep's output to sed.

Suggested-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/help.c  | 91 ++++++++++++++++++++++++++++++-------------------
 t/t0012-help.sh | 39 ++++++++++++---------
 2 files changed, 78 insertions(+), 52 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index c09cbc8912..daadc61c70 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -111,6 +111,49 @@ struct slot_expansion {
 	int found;
 };
 
+static void set_config_vars(struct string_list *keys_uniq, struct string_list_item *var)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *str = var->string;
+	const char *wildcard = strchr(str, '*');
+	const char *tag = strchr(str, '<');
+	const char *cut;
+
+	if (wildcard && tag)
+		cut = wildcard < tag ? wildcard : tag;
+	else if (wildcard)
+		cut = wildcard;
+	else if (tag)
+		cut = tag;
+	else {
+		string_list_append(keys_uniq, str);
+		return;
+	}
+
+	strbuf_add(&sb, str, cut - str);
+	string_list_append(keys_uniq, sb.buf);
+	strbuf_release(&sb);
+}
+
+static void set_config_sections(struct string_list *keys_uniq, struct string_list_item *var)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *str = var->string;
+	const char *dot = strchr(str, '.');
+	const char *cut;
+
+	if (dot)
+		cut = dot;
+	else {
+		set_config_vars(keys_uniq, var);
+		return;
+	}
+
+	strbuf_add(&sb, str, cut - str);
+	string_list_append(keys_uniq, sb.buf);
+	strbuf_release(&sb);
+}
+
 static void list_config_help(enum show_config_type type)
 {
 	struct slot_expansion slot_expansions[] = {
@@ -131,13 +174,12 @@ static void list_config_help(enum show_config_type type)
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
+	struct strbuf sb = STRBUF_INIT;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
-		struct strbuf sb = STRBUF_INIT;
 
 		for (e = slot_expansions; e->prefix; e++) {
-
 			strbuf_reset(&sb);
 			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
 			if (!strcasecmp(var, sb.buf)) {
@@ -146,60 +188,39 @@ static void list_config_help(enum show_config_type type)
 				break;
 			}
 		}
-		strbuf_release(&sb);
+
 		if (!e->prefix)
 			string_list_append(&keys, var);
 	}
 
+	strbuf_release(&sb);
+
 	for (e = slot_expansions; e->prefix; e++)
 		if (!e->found)
 			BUG("slot_expansion %s.%s is not used",
 			    e->prefix, e->placeholder);
 
-	string_list_sort(&keys);
 	for (size_t i = 0; i < keys.nr; i++) {
-		const char *var = keys.items[i].string;
-		const char *wildcard, *tag, *cut;
-		const char *dot = NULL;
-		struct strbuf sb = STRBUF_INIT;
-
 		switch (type) {
 		case SHOW_CONFIG_HUMAN:
-			puts(var);
-			continue;
+			string_list_append(&keys_uniq, keys.items[i].string);
+			break;
 		case SHOW_CONFIG_SECTIONS:
-			dot = strchr(var, '.');
+			set_config_sections(&keys_uniq, &keys.items[i]);
 			break;
 		case SHOW_CONFIG_VARS:
+			set_config_vars(&keys_uniq, &keys.items[i]);
 			break;
+		default:
+			BUG("%d: unexpected type", type);
 		}
-		wildcard = strchr(var, '*');
-		tag = strchr(var, '<');
-
-		if (!dot && !wildcard && !tag) {
-			string_list_append(&keys_uniq, var);
-			continue;
-		}
-
-		if (dot)
-			cut = dot;
-		else if (wildcard && !tag)
-			cut = wildcard;
-		else if (!wildcard && tag)
-			cut = tag;
-		else
-			cut = wildcard < tag ? wildcard : tag;
-
-		strbuf_add(&sb, var, cut - var);
-		string_list_append(&keys_uniq, sb.buf);
-		strbuf_release(&sb);
-
 	}
-	string_list_clear(&keys, 0);
-	string_list_remove_duplicates(&keys_uniq, 0);
+
+	string_list_sort_u(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
 	string_list_clear(&keys_uniq, 0);
+	string_list_clear(&keys, 0);
 }
 
 static enum help_format parse_help_format(const char *format)
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index d3a0967e9d..40b2d656a5 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -141,20 +141,23 @@ test_expect_success 'git help -c' '
 
 	'\''git help config'\'' for more information
 	EOF
-	grep -v -E \
-		-e "^[^.]+\.[^.]+$" \
-		-e "^[^.]+\.[^.]+\.[^.]+$" \
-		help.output >actual &&
+	sed -E -e "
+		/^[^.]+\.[^.]+$/d
+		/^[^.]+\.[^.]+\.[^.]+$/d
+	" help.output >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git help --config-for-completion' '
 	git help -c >human &&
-	grep -E \
-	     -e "^[^.]+\.[^.]+$" \
-	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
-	     sed -e "s/\*.*//" -e "s/<.*//" |
-	     sort -u >human.munged &&
+	sed -E -e "
+		/^[^.]+\.[^.]+$/b out
+		/^[^.]+\.[^.]+\.[^.]+$/b out
+		d
+		: out
+		s/\*.*//
+		s/<.*//
+	" human | sort -u >human.munged &&
 
 	git help --config-for-completion >vars &&
 	test_cmp human.munged vars
@@ -162,14 +165,16 @@ test_expect_success 'git help --config-for-completion' '
 
 test_expect_success 'git help --config-sections-for-completion' '
 	git help -c >human &&
-	grep -E \
-	     -e "^[^.]+\.[^.]+$" \
-	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
-	     sed -e "s/\..*//" |
-	     sort -u >human.munged &&
-
-	git help --config-sections-for-completion >sections &&
-	test_cmp human.munged sections
+	sed -E -e "
+		/^[^.]+\.[^.]+$/b out
+		/^[^.]+\.[^.]+\.[^.]+$/b out
+		d
+		: out
+		s/\..*//
+	" human | sort -u >expect &&
+	
+	git help --config-sections-for-completion >actual &&
+	test_cmp expect actual
 '
 
 test_section_spacing () {
-- 
2.52.0

