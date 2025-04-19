Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564C4502B
	for <git@vger.kernel.org>; Sat, 19 Apr 2025 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745088201; cv=none; b=V2Q0voH1tJxEhPD9/Rj9yTZ92LeXJ0VKQT1Bbt0BbLKM522IhObpL6h3pV+8lDZqj3Z4IlpgMCaQ1HE8JYHV4mzqtfm12OQcZ2WvItN0TcXAY+FahJxKUvM3cZetAwuAME0NJkSBIFTCnP5QCEKO0Dh5aqF0gqruOgEoMfPE+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745088201; c=relaxed/simple;
	bh=j6jShJ+IaNvfxv10VTA3ygcZBu2NllpIlvhxBvg4Q/g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=oHJCY46XvfHbjiMG4U97an/6nVhO/0Ypy25cFP3QF8YHWuBXlroKmxc45Pe0LK6/x6OXZZINZzxVtqzinKkjHnPYCJGwkrpjTJOppACKj0df/M+hkJ4BMUww28IhGa1I5FwC5SKpOmu1fh2y8n78RtltEntGIo+mrO2EYf/cTm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJIEIRe6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJIEIRe6"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39d83782ef6so2684841f8f.0
        for <git@vger.kernel.org>; Sat, 19 Apr 2025 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745088196; x=1745692996; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IHBTGpFj5OPi1fJCR8tVkmvTDmoe9nmFXpcnlWnAaQ8=;
        b=AJIEIRe6z8wWMXW5xylsZ3tgCM9cK6hqNc/hZH2/GtGRvXsgk6vBOrLCp/KqxtVcEH
         jKq97wUWuRRKhVMjJaL1EW+BNspy8i9KxEiqZH72R5Kz/DZeUjylo4kL3Ry+4oNE7by6
         f0UYosR/E0eD60WWE6nJNqhynffz+cJtbf0FgMAWfVnG0XHyq1i2uFyme0/uJUUvCMMe
         2rUts3KoGpXbi8Wsv/s54P23TOYOz4oU3ICnKzIxAjaCoBj5IWBLNFUAZQ0oBBK/EXhf
         aWoqK62+bISd7S1tjWCdbngp2kmDzgER1N/KMNporyE9FF4gleupaTxRr3aEr4LnGzUM
         ho8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745088196; x=1745692996;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHBTGpFj5OPi1fJCR8tVkmvTDmoe9nmFXpcnlWnAaQ8=;
        b=GoYGUl23aE7wrIpobJ35FRbJ1ZTrKpqQhPpl+Iagl1mvat3SKIvIwMaakiSCXUSfnw
         2iX7ReFjgELc5VwyatF5bI1kkWlmWL4/RyQWsPxipYtmu/kL0lVq4fWLwmNC9jzR0bXJ
         QhbuVnu7X/zYPSyCJa2V6zrxhI7BT3NH9gthOgNj/KREKZIeHZm0KTjTYXsgsA1Jb2v3
         iWqsw9P/nwN6+vqwzLUYsAG4mgPX6R4ANy9EaRBG1z1yqD5o8m/E9dg+UOYJ/MP463dz
         BddOYv6wLBgYbxIs+Ik030IJWmZmP768ytv9q+M2rk7t4+u6nPg/xdrn0GfHRvjHFBU4
         Mkug==
X-Gm-Message-State: AOJu0Ywgu9KsXlJ3gt/nNe4/AnKV1HeSX/d6UOVd35E7M3Wmea8t+YJT
	HJ7Ifm+tY5MhG72vS06Mzn+lv9SMY6Mpz3gjXsJ5kYYOfJ0y3iFJfFZ0oQ==
X-Gm-Gg: ASbGncvc+DQUz1Y/2+WKuhpy64T6I2rk7tKrjyLbakDkNyA2mb4ptZ6NqqmEBazkxdx
	KY2NjGrBuktG1ZBXhzD72f3nvQQn7Erec3oyqizw393ZNc1uxbdXtkB8/3esh4RW+Mxzl6IOYu3
	lmipk8q01Q2tWKwZkMJz+9mvnFweYXWcW6qvPVdQKMuQC7hn4U/cPFx1gALK2E4cFRO+H7FHc7z
	S0sRoItPdcm2rMZKEJerMGHgLd7tY29itIo9JZ1ZI9/wvpQ2YRUd+4vOs19v+zqwGVpT2houUD+
	GwQCApQCnuvZD0p/jSM8yAMZ1SJeywJvmw++gEh/UDXKHEzrj14C
X-Google-Smtp-Source: AGHT+IGKxhCt9Vfp3onpoRbYKE6mvusYoFmv2QUSrXjkLZ3s4KgEOImjj1Urek4CbP49ZPBWJV9yZw==
X-Received: by 2002:a5d:64ac:0:b0:391:3207:2e68 with SMTP id ffacd0b85a97d-39ef8ba561dmr5692652f8f.9.1745088195865;
        Sat, 19 Apr 2025 11:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6dfe4esm69568595e9.33.2025.04.19.11.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 11:43:15 -0700 (PDT)
Message-Id: <pull.1947.git.git.1745088194384.gitgitgadget@gmail.com>
From: "jade via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Apr 2025 18:43:14 +0000
Subject: [PATCH] builtin/blame: ignore nonexistent ignore files
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
Cc: jade <software@lfcode.ca>,
    Jade Lovelace <software@lfcode.ca>

From: Jade Lovelace <software@lfcode.ca>

It's currently a problem to put blame.ignoreRevsFile in a global
gitconfig, for example, to use the GitHub (and other) supported filename
of .git-blame-ignore-revs by default if present in a repo, since the
current implementation exits the process if it fails to open the file.

If we change this to ignore nonexistent files when specified in the
config option (but NOT the command line, since the command line surely
means to actually assert the files exist), this remains API compatible
with old usages, while behaving properly when you want to ignore missing
ones.

Because of this idea of putting .git-blame-ignore-revs in there, it
doesn't seem to necessarily merit a warning, but maybe there should be
one to be slightly less confusing if you make a typo?

Signed-off-by: Jade Lovelace <software@lfcode.ca>
---
    blame: ignore nonexistent ignore files

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1947%2Flf-%2Fjade%2Fignore-revs-ignore-missing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1947/lf-/jade/ignore-revs-ignore-missing-v1
Pull-Request: https://github.com/git/git/pull/1947

 Documentation/config/blame.adoc |  3 +++
 builtin/blame.c                 | 27 +++++++++++++++++++++++++--
 oidset.c                        | 17 ++++++++++++++---
 oidset.h                        | 10 ++++++++++
 t/t8013-blame-ignore-revs.sh    | 16 +++++++++++++++-
 5 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/blame.adoc b/Documentation/config/blame.adoc
index 4d047c17908..6dedc48069f 100644
--- a/Documentation/config/blame.adoc
+++ b/Documentation/config/blame.adoc
@@ -26,6 +26,9 @@ blame.ignoreRevsFile::
 	`#` are ignored.  This option may be repeated multiple times.  Empty
 	file names will reset the list of ignored revisions.  This option will
 	be handled before the command line option `--ignore-revs-file`.
++
+If a file in this list does not exist, it is disregarded and the next files in
+the list are processed as normal.
 
 blame.markUnblamableLines::
 	Mark lines that were changed by an ignored revision that we could not
diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7ec..90fa8d4107a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -68,6 +68,9 @@ static int no_whole_file_rename;
 static int show_progress;
 static char repeated_meta_color[COLOR_MAXLEN];
 static int coloring_mode;
+/* Ignore-revs files specified in the config file. Processed separately to be
+ * able to ignore failing to open them. */
+static struct string_list ignore_revs_config_file_list = STRING_LIST_INIT_DUP;
 static struct string_list ignore_revs_file_list = STRING_LIST_INIT_DUP;
 static int mark_unblamable_lines;
 static int mark_ignored_lines;
@@ -731,7 +734,7 @@ static int git_blame_config(const char *var, const char *value,
 		ret = git_config_pathname(&str, var, value);
 		if (ret)
 			return ret;
-		string_list_insert(&ignore_revs_file_list, str);
+		string_list_insert(&ignore_revs_config_file_list, str);
 		free(str);
 		return 0;
 	}
@@ -848,6 +851,9 @@ static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 }
 
 static void build_ignorelist(struct blame_scoreboard *sb,
+			     /* Ignore-revs files specified via the config,
+			      * which are allowed to fail to open. */
+			     struct string_list *ignore_revs_config_file_list,
 			     struct string_list *ignore_revs_file_list,
 			     struct string_list *ignore_rev_list)
 {
@@ -855,6 +861,23 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 	struct object_id oid;
 
 	oidset_init(&sb->ignore_list, 0);
+	for_each_string_list_item(i, ignore_revs_config_file_list) {
+		if (!strcmp(i->string, ""))
+			oidset_clear(&sb->ignore_list);
+		else {
+			FILE *fp = fopen(i->string, "r");
+			if (!fp) {
+				if (errno == ENOENT) continue;
+				die("could not open blame.ignoreRevsFile file at %s", i->string);
+			}
+
+			oidset_parse_filep_carefully(&sb->ignore_list, fp, i->string,
+						    the_repository->hash_algo,
+						    peel_to_commit_oid, sb);
+
+			fclose(fp);
+		}
+	}
 	for_each_string_list_item(i, ignore_revs_file_list) {
 		if (!strcmp(i->string, ""))
 			oidset_clear(&sb->ignore_list);
@@ -1119,7 +1142,7 @@ parse_done:
 	sb.reverse = reverse;
 	sb.repo = the_repository;
 	sb.path = path;
-	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
+	build_ignorelist(&sb, &ignore_revs_config_file_list, &ignore_revs_file_list, &ignore_rev_list);
 	string_list_clear(&ignore_revs_file_list, 0);
 	string_list_clear(&ignore_rev_list, 0);
 	setup_scoreboard(&sb, &o);
diff --git a/oidset.c b/oidset.c
index 8d36aef8dca..35958cbc3d6 100644
--- a/oidset.c
+++ b/oidset.c
@@ -59,12 +59,24 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 				 oidset_parse_tweak_fn fn, void *cbdata)
 {
 	FILE *fp;
-	struct strbuf sb = STRBUF_INIT;
-	struct object_id oid;
 
 	fp = fopen(path, "r");
 	if (!fp)
 		die("could not open object name list: %s", path);
+
+	oidset_parse_filep_carefully(set, fp, path, algop, fn, cbdata);
+
+	fclose(fp);
+}
+
+void oidset_parse_filep_carefully(struct oidset *set, FILE *fp,
+				 const char *path,
+				 const struct git_hash_algo *algop,
+				 oidset_parse_tweak_fn fn, void *cbdata)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct object_id oid;
+
 	while (!strbuf_getline(&sb, fp)) {
 		const char *p;
 		const char *name;
@@ -89,6 +101,5 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 	}
 	if (ferror(fp))
 		die_errno("Could not read '%s'", path);
-	fclose(fp);
 	strbuf_release(&sb);
 }
diff --git a/oidset.h b/oidset.h
index 0106b6f2787..f68aa8a3b0d 100644
--- a/oidset.h
+++ b/oidset.h
@@ -2,6 +2,7 @@
 #define OIDSET_H
 
 #include "khash.h"
+#include <stdio.h>
 
 /**
  * This API is similar to oid-array, in that it maintains a set of object ids
@@ -93,6 +94,15 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 				 const struct git_hash_algo *algop,
 				 oidset_parse_tweak_fn fn, void *cbdata);
 
+/*
+ * Same as oidset_parse_file_carefully, but is given a pre-opened file handle.
+ * The given path is only used for diagnostics.
+ */
+void oidset_parse_filep_carefully(struct oidset *set, FILE *fp,
+				 const char *path,
+				 const struct git_hash_algo *algop,
+				 oidset_parse_tweak_fn fn, void *cbdata);
+
 struct oidset_iter {
 	kh_oid_set_t *set;
 	khiter_t iter;
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 370b7681492..0456aaba9dd 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/nix/store/cvlbhhrvzfkjl2hrrzhq3vr5gzan1r60-bash-interactive-5.2p37/bin/sh
 
 test_description='ignore revisions when blaming'
 
@@ -116,6 +116,20 @@ test_expect_success ignore_revs_from_configs_and_files '
 	test_cmp expect actual
 '
 
+# Ignore-revs from the config tolerates the file not existing
+test_expect_success ignore_revs_config_file_nonexistent '
+	git config --add blame.ignoreRevsFile nonexistent_ignore_file &&
+	git blame --line-porcelain file --ignore-revs-file ignore_y >blame_raw &&
+
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 1/s/ .*//p" blame_raw >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse B >expect &&
+	test_cmp expect actual
+'
+
 # Override blame.ignoreRevsFile (ignore_x) with an empty string.  X should be
 # blamed now for lines 1 and 2, since we are no longer ignoring X.
 test_expect_success override_ignore_revs_file '

base-commit: c152ae3ef50dc7bbbf5089571df5bba404a96e0d
-- 
gitgitgadget
