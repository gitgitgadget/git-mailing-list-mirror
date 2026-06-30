Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD69410D01
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823757; cv=none; b=KqWjIAGj/tQFSo9X9blJKiWQlfwndnSCZ+xXFznZYXKsEduwdla9nqPTbUCIQMS5dff1bQ6wkpPXMm9aeOJsLEui6LkikZVyjgnVJCT5i9WIZE7GxIh9osAqE1kP86HigHyNEINDFCKl3AUnH0urXAy5BoYhDV056WL/LfXK1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823757; c=relaxed/simple;
	bh=JbqeuGLiVpInLkKbLgaOV2jewZ3VLb5LOtw8zTYL8DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRa6lMWqAQ2o6fkpHi5j/eqWzaNCFKdLV9YzuG7HMPo7xVYZxfF11Tf6ffJBpcEJgs4361kXOoUQ/AboNdFVUilyHHAfEI84qwS1LINaNU9ODUXBkIfG2d9+Fioo3a3H5oxHOtTR4hZe144FK9xaVOHpMESt/02kd4mW4FDSnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt+J7Hle; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt+J7Hle"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1390f75d8bbso8991917c88.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782823755; x=1783428555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=soDB7AvW/ucFk1vqssNKLfOr42NVdiIANOj9hexftGw=;
        b=Kt+J7HleO9BbrfTQwxwyH3HLgoRPHpqPHcT4GitC0QhCM2oVg09zXlpFXkyYuuUnYn
         3m/FljLGBLSfwv4aWd/sPRuwP06EnBhfZ6wMfpzU62zDSbyIxdkrg4/jMBPhN9Mbavcw
         oUIFPIYL0c5a+04hb74JmSS6FYOpx0JD2D+zsUJfnxjcksJir5qyUZpd+IfB35PvnbpA
         GC+QchGryDs7rxVH3OO75OecpRo9npJLc5AZs/P+9nxmiUqgH7cXgXAJ+Z8XHxV1wJju
         j0E9vYz+tG/4sD8RXaNFbIFLxi7/W6i8kVIDb1Fshah765bB0W9scMcT/aC40Vxaqfgm
         FC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823755; x=1783428555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soDB7AvW/ucFk1vqssNKLfOr42NVdiIANOj9hexftGw=;
        b=LfdGCUJZcAdvjbk3ZD+g6yB7ddm4KYGIqwvPMB2+SDrYPz7uEI9tiP51bZ5obkCGBF
         e/j3zMPCnrbpBnWdCODMOkCQqF6d1DG9aE8EILdRaDrECETNC7X1kAOG/UX3XvXxaG4o
         mjJbNee6lghSn/Z2hSeM/NQu6wvzz7G3LJ5IA13ngr2t5HZ561LBqReognbSRATokepp
         qur0jZVtzcbFjzwxueusLGp7qbe//989wJKWgS8pw/5CPFyPxX+QAZfgBVEtQg8MA1aX
         M1mSh50RjerOiJMvppLadBxjQBqtR2wphC/2WeFzFJOITYaUKRL5dpGTTBIAxG4vZ/Dl
         7+Gg==
X-Gm-Message-State: AOJu0YxV6DtSKS++NKrPM9QV2x7CqqCBVuEwLQ2DKxsg7QlG6a25Anbv
	5jZx6avthGdpOo+QE7vR+onRQ8xiH/JsiUVTE/6vGUlByhYgKd4nNhd0lWI8EY+A
X-Gm-Gg: AfdE7cmdrzYGR3qmPc0fIhc7eBraYs1YdfnzIIx3NCgB7Gqja+Swp0aDBTgB6R4Aqz+
	5mJIjv5mj07bbqBRZWB+zXEWGzOmOxWrGHUybzUkA3QUwdGKo6GdGiWSPUi+1az85Gy3iJy01JT
	l5cZusQQAb+I1RIv8BaC809BhS7jvO13acH6y4DCkkzHMVgTZQUIqeOiq7a6S9y9VSGhknzDiwJ
	ZaB2FVV1zywpU5uiPjDVhqBdrFbY4Zzprj9D6lQRD4LonA6NDlia1zZPXWG/DMml0gqxIcvDlUx
	NOpS7gmgsAvvBodXcrHGcRR3N8PSo4lcH9C5M5ked7iPI8PQraXNUN07Hyfro98CuN2TJ0JQVKO
	P0Ov2R1EAZiWOoOyh5tudvAB2Fffe5hIOADq/ghz/B4dUzri47Tqc9Ri0Tn/x5Nxk8siQSsfP6c
	zbqCcAyVnS9XTbuTwdVmHyueO3oFx3v35iTYzarqUzJw+rNw==
X-Received: by 2002:a05:7022:68a6:b0:139:fb1a:7717 with SMTP id a92af1059eb24-13b2a1d333amr2229846c88.47.1782823754525;
        Tue, 30 Jun 2026 05:49:14 -0700 (PDT)
Received: from localhost.localdomain ([117.194.56.215])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2ab20921sm6060239c88.4.2026.06.30.05.49.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 05:49:09 -0700 (PDT)
From: RISHAV DEWAN <rishavdewan10@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	RISHAV DEWAN <rishavdewan10@gmail.com>
Subject: [PATCH v1] config: fix case-insensitive match for old-style [section.subsection]
Date: Tue, 30 Jun 2026 18:18:50 +0530
Message-ID: <20260630124850.2498-1-rishavdewan10@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing to an old-style "[section.subsection]" header, the
config file parser always folds the subsection to lower case
(get_base_var() lowercases unconditionally), while the key given on
the command line keeps whatever case the caller typed
(do_parse_config_key() deliberately leaves the subsection segment
untouched). matches() compared these two forms with a plain strcmp(),
so a caller passing an upper-cased subsection (e.g. 'git config
section.Subsection.key value2' against a file containing
'[section.subsection]') never matched the existing key and a
duplicate line was appended instead of replacing the value. This was
a known, documented limitation (see the now-removed BUGS section of
git-config.adoc).

Track whether the currently active section was parsed case-
insensitively (old-style) or case-sensitively (new-style, quoted) in
struct config_store_data, and have matches() use that information to
compare the subsection segment of the key accordingly, instead of an
unconditional case-sensitive strcmp().

Signed-off-by: RISHAV DEWAN <rishavdewan10@gmail.com>
---
 Documentation/git-config.adoc | 21 ---------------------
 config.c                      | 18 +++++++++++++++++-
 t/t1300-config.sh             |  2 --
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 57af010ade..11dfd802b4 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -634,27 +634,6 @@ http.sslverify false
 
 include::config.adoc[]
 
-BUGS
-----
-When using the deprecated `[section.subsection]` syntax, changing a value
-will result in adding a multi-line key instead of a change, if the subsection
-is given with at least one uppercase character. For example when the config
-looks like
-
---------
-  [section.subsection]
-    key = value1
---------
-
-and running `git config section.Subsection.key value2` will result in
-
---------
-  [section.subsection]
-    key = value1
-    key = value2
---------
-
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/config.c b/config.c
index 6a0de86e3a..7f086fcd75 100644
--- a/config.c
+++ b/config.c
@@ -2594,6 +2594,7 @@ struct config_store_data {
 	} *parsed;
 	unsigned int parsed_nr, parsed_alloc, *seen, seen_nr, seen_alloc;
 	unsigned int key_seen:1, section_seen:1, is_keys_section:1;
+	unsigned int subsection_case_sensitive:1;
 };
 #define CONFIG_STORE_INIT { 0 }
 
@@ -2613,7 +2614,21 @@ static void config_store_data_clear(struct config_store_data *store)
 static int matches(const char *key, const char *value,
 		   const struct config_store_data *store)
 {
-	if (strcmp(key, store->key))
+	/*
+	 * The subsection part of "key" (key[0..store->baselen)) was parsed
+	 * out of the config file using the case sensitivity of whichever
+	 * section header it came from (see store_aux_event()): old-style
+	 * "[section.subsection]" headers are folded to lower case while
+	 * parsing, so they must be compared case-insensitively against
+	 * store->key, which preserves whatever case the caller passed on
+	 * the command line. New-style "[section "Subsection"]" headers keep
+	 * their case, so they need an exact, case-sensitive comparison.
+	 */
+	int (*cmpfn)(const char *, const char *, size_t) =
+		store->subsection_case_sensitive ? strncasecmp : strncmp;
+
+	if (cmpfn(key, store->key, store->baselen) ||
+	    strcmp(key + store->baselen, store->key + store->baselen))
 		return 0; /* not ours */
 	if (store->fixed_value && value)
 		return !strcmp(store->fixed_value, value);
@@ -2654,6 +2669,7 @@ static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
 			!cmpfn(cs->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
+			store->subsection_case_sensitive = cs->subsection_case_sensitive;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
 				   store->seen_alloc);
 			store->seen[store->seen_nr] = store->parsed_nr;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 87ca11a127..eaa3b83990 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1499,7 +1499,6 @@ test_expect_success 'old-fashioned settings are case insensitive' '
 	EOF
 	q_to_tab >testConfig_expect <<-EOF &&
 	[V.A]
-	r = value1
 	Qr = value2
 	EOF
 	git config -f testConfig_actual "V.A.r" value2 &&
@@ -1511,7 +1510,6 @@ test_expect_success 'old-fashioned settings are case insensitive' '
 	EOF
 	q_to_tab >testConfig_expect <<-EOF &&
 	[V.A]
-	r = value1
 	Qr = value2
 	EOF
 	git config -f testConfig_actual "v.A.r" value2 &&
-- 
2.50.1 (Apple Git-155)

