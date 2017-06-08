Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149A31FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdFHXlQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:16 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35266 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFHXlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:15 -0400
Received: by mail-pg0-f45.google.com with SMTP id k71so20705567pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=suUn1UDkQak5qG78Msk7Bs3uDy6F3VeYvjmePgC2iD0=;
        b=Jgp+khicWFHHSmjUBMBeME4uELcx7BxiLOJ45jAyUtwHOr2wCJbjff0Zfcz/8Vd6o/
         gDPoRRw1Sqq4u8CIC9Cp6xORDzE/WtDihk6bU58m+mrB2WFy35adBGy0HgUeH9bu4d/q
         woUI4qpqMCNeKLxaRa0gnGK5+L7EuM0ubFof0MV3LO0j4eNbeeHRSyfFi7OzH7dnjWyJ
         76znO7sb2MDLq7FAsfE7ENo+Q5a2QcHsE4UurC3cbuzVNN/bn6oOFo7DqKH+DE0mqLCj
         lhSDu4ORTYG6kvfMKtQ7hCEYEiQJkWl0Tfa3iPuEdLxwVSqW8y3zgB8VACYfn+zGmzm6
         t9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=suUn1UDkQak5qG78Msk7Bs3uDy6F3VeYvjmePgC2iD0=;
        b=tsVtgGpR1WHyhmX7yJOWCx2ESNqZPInXAv3EFI+f2TtcCHo4aFOl46kbitFbYtJCIY
         loBfoiHlqfTVZ/Mu6RVytOZx6ntewO8k5dYhFj8mCpzp7ciE7uh5D5p4SKYwaJ7FO19/
         4AG+2red+/yiQVy8AiQnDVhlDL4WIzwEl+Bf9P0bc6QWoAxb3+ImCg4JDCA/QU6vxG/U
         OSePdrND1qXOizxy4oKIpW28YfoJz7+zIRvPWflye9Sh/KP6bthMWGmd3dyT41rf/Xlj
         y9tEhCsVjUvuItH6l0mybqF/Zo73C6OAswfd7wF2fsHLYEXZvE9t03p1SU/oj1ON6iRF
         dcvQ==
X-Gm-Message-State: AODbwcDSyUB0WSar/mq2w42MoLAyySaWOEsOKOyLhoRumJyijHX5mLqT
        0aU+/vjrCWSD8JKRqW+V5g==
X-Received: by 10.98.107.129 with SMTP id g123mr39215613pfc.219.1496965274129;
        Thu, 08 Jun 2017 16:41:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 01/32] config: create config.h
Date:   Thu,  8 Jun 2017 16:40:29 -0700
Message-Id: <20170608234100.188529-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all config related declarations from cache.h to a new config.h
header file.  This makes cache.h smaller and allows for the opportunity
in a following patch to only include config.h when needed.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 cache.h  | 190 +------------------------------------------------------------
 config.h | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 189 deletions(-)
 create mode 100644 config.h

diff --git a/cache.h b/cache.h
index ae4c45d37..a27fee458 100644
--- a/cache.h
+++ b/cache.h
@@ -11,6 +11,7 @@
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
+#include "config.h"
 
 #ifndef platform_SHA_CTX
 /*
@@ -1866,188 +1867,9 @@ extern int packed_object_info(struct packed_git *pack, off_t offset, struct obje
 /* Dumb servers support */
 extern int update_server_info(int);
 
-/* git_config_parse_key() returns these negated: */
-#define CONFIG_INVALID_KEY 1
-#define CONFIG_NO_SECTION_OR_NAME 2
-/* git_config_set_gently(), git_config_set_multivar_gently() return the above or these: */
-#define CONFIG_NO_LOCK -1
-#define CONFIG_INVALID_FILE 3
-#define CONFIG_NO_WRITE 4
-#define CONFIG_NOTHING_SET 5
-#define CONFIG_INVALID_PATTERN 6
-#define CONFIG_GENERIC_ERROR 7
-
-#define CONFIG_REGEX_NONE ((void *)1)
-
-struct git_config_source {
-	unsigned int use_stdin:1;
-	const char *file;
-	const char *blob;
-};
-
-enum config_origin_type {
-	CONFIG_ORIGIN_BLOB,
-	CONFIG_ORIGIN_FILE,
-	CONFIG_ORIGIN_STDIN,
-	CONFIG_ORIGIN_SUBMODULE_BLOB,
-	CONFIG_ORIGIN_CMDLINE
-};
-
-struct config_options {
-	unsigned int respect_includes : 1;
-	const char *git_dir;
-};
-
-typedef int (*config_fn_t)(const char *, const char *, void *);
-extern int git_default_config(const char *, const char *, void *);
-extern int git_config_from_file(config_fn_t fn, const char *, void *);
-extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
-					const char *name, const char *buf, size_t len, void *data);
-extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
-				     const unsigned char *sha1, void *data);
-extern void git_config_push_parameter(const char *text);
-extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern void read_early_config(config_fn_t cb, void *data);
-extern void git_config(config_fn_t fn, void *);
-extern int git_config_with_options(config_fn_t fn, void *,
-				   struct git_config_source *config_source,
-				   const struct config_options *opts);
-extern int git_parse_ulong(const char *, unsigned long *);
-extern int git_parse_maybe_bool(const char *);
-extern int git_config_int(const char *, const char *);
-extern int64_t git_config_int64(const char *, const char *);
-extern unsigned long git_config_ulong(const char *, const char *);
-extern ssize_t git_config_ssize_t(const char *, const char *);
-extern int git_config_bool_or_int(const char *, const char *, int *);
-extern int git_config_bool(const char *, const char *);
-extern int git_config_maybe_bool(const char *, const char *);
-extern int git_config_string(const char **, const char *, const char *);
-extern int git_config_pathname(const char **, const char *, const char *);
-extern int git_config_set_in_file_gently(const char *, const char *, const char *);
-extern void git_config_set_in_file(const char *, const char *, const char *);
-extern int git_config_set_gently(const char *, const char *);
-extern void git_config_set(const char *, const char *);
-extern int git_config_parse_key(const char *, char **, int *);
-extern int git_config_key_is_valid(const char *key);
-extern int git_config_set_multivar_gently(const char *, const char *, const char *, int);
-extern void git_config_set_multivar(const char *, const char *, const char *, int);
-extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
-extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
-extern int git_config_rename_section(const char *, const char *);
-extern int git_config_rename_section_in_file(const char *, const char *, const char *);
-extern const char *git_etc_gitconfig(void);
-extern int git_env_bool(const char *, int);
-extern unsigned long git_env_ulong(const char *, unsigned long);
-extern int git_config_system(void);
-extern int config_error_nonbool(const char *);
-#if defined(__GNUC__)
-#define config_error_nonbool(s) (config_error_nonbool(s), const_error())
-#endif
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
-extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
-
-enum config_scope {
-	CONFIG_SCOPE_UNKNOWN = 0,
-	CONFIG_SCOPE_SYSTEM,
-	CONFIG_SCOPE_GLOBAL,
-	CONFIG_SCOPE_REPO,
-	CONFIG_SCOPE_CMDLINE,
-};
-
-extern enum config_scope current_config_scope(void);
-extern const char *current_config_origin_type(void);
-extern const char *current_config_name(void);
-
-struct config_include_data {
-	int depth;
-	config_fn_t fn;
-	void *data;
-	const struct config_options *opts;
-};
-#define CONFIG_INCLUDE_INIT { 0 }
-extern int git_config_include(const char *name, const char *value, void *data);
-
-/*
- * Match and parse a config key of the form:
- *
- *   section.(subsection.)?key
- *
- * (i.e., what gets handed to a config_fn_t). The caller provides the section;
- * we return -1 if it does not match, 0 otherwise. The subsection and key
- * out-parameters are filled by the function (and *subsection is NULL if it is
- * missing).
- *
- * If the subsection pointer-to-pointer passed in is NULL, returns 0 only if
- * there is no subsection at all.
- */
-extern int parse_config_key(const char *var,
-			    const char *section,
-			    const char **subsection, int *subsection_len,
-			    const char **key);
-
-struct config_set_element {
-	struct hashmap_entry ent;
-	char *key;
-	struct string_list value_list;
-};
-
-struct configset_list_item {
-	struct config_set_element *e;
-	int value_index;
-};
-
-/*
- * the contents of the list are ordered according to their
- * position in the config files and order of parsing the files.
- * (i.e. key-value pair at the last position of .git/config will
- * be at the last item of the list)
- */
-struct configset_list {
-	struct configset_list_item *items;
-	unsigned int nr, alloc;
-};
-
-struct config_set {
-	struct hashmap config_hash;
-	int hash_initialized;
-	struct configset_list list;
-};
-
-extern void git_configset_init(struct config_set *cs);
-extern int git_configset_add_file(struct config_set *cs, const char *filename);
-extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
-extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
-extern void git_configset_clear(struct config_set *cs);
-extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
-extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
-extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
-extern int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
-extern int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
-extern int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
-extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
-extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
-
-extern int git_config_get_value(const char *key, const char **value);
-extern const struct string_list *git_config_get_value_multi(const char *key);
-extern void git_config_clear(void);
-extern void git_config_iter(config_fn_t fn, void *data);
-extern int git_config_get_string_const(const char *key, const char **dest);
-extern int git_config_get_string(const char *key, char **dest);
-extern int git_config_get_int(const char *key, int *dest);
-extern int git_config_get_ulong(const char *key, unsigned long *dest);
-extern int git_config_get_bool(const char *key, int *dest);
-extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
-extern int git_config_get_maybe_bool(const char *key, int *dest);
-extern int git_config_get_pathname(const char *key, const char **dest);
-extern int git_config_get_untracked_cache(void);
-extern int git_config_get_split_index(void);
-extern int git_config_get_max_percent_split_change(void);
-
-/* This dies if the configured or default date is in the future */
-extern int git_config_get_expiry(const char *key, const char **output);
-
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
@@ -2055,16 +1877,6 @@ extern int git_config_get_expiry(const char *key, const char **output);
  */
 extern int ignore_untracked_cache_config;
 
-struct key_value_info {
-	const char *filename;
-	int linenr;
-	enum config_origin_type origin_type;
-	enum config_scope scope;
-};
-
-extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
-extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
-
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
 
diff --git a/config.h b/config.h
new file mode 100644
index 000000000..f7f8b66c5
--- /dev/null
+++ b/config.h
@@ -0,0 +1,194 @@
+#ifndef CONFIG_H
+#define CONFIG_H
+
+/* git_config_parse_key() returns these negated: */
+#define CONFIG_INVALID_KEY 1
+#define CONFIG_NO_SECTION_OR_NAME 2
+/* git_config_set_gently(), git_config_set_multivar_gently() return the above or these: */
+#define CONFIG_NO_LOCK -1
+#define CONFIG_INVALID_FILE 3
+#define CONFIG_NO_WRITE 4
+#define CONFIG_NOTHING_SET 5
+#define CONFIG_INVALID_PATTERN 6
+#define CONFIG_GENERIC_ERROR 7
+
+#define CONFIG_REGEX_NONE ((void *)1)
+
+struct git_config_source {
+	unsigned int use_stdin:1;
+	const char *file;
+	const char *blob;
+};
+
+enum config_origin_type {
+	CONFIG_ORIGIN_BLOB,
+	CONFIG_ORIGIN_FILE,
+	CONFIG_ORIGIN_STDIN,
+	CONFIG_ORIGIN_SUBMODULE_BLOB,
+	CONFIG_ORIGIN_CMDLINE
+};
+
+struct config_options {
+	unsigned int respect_includes : 1;
+	const char *git_dir;
+};
+
+typedef int (*config_fn_t)(const char *, const char *, void *);
+extern int git_default_config(const char *, const char *, void *);
+extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
+					const char *name, const char *buf, size_t len, void *data);
+extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
+				     const unsigned char *sha1, void *data);
+extern void git_config_push_parameter(const char *text);
+extern int git_config_from_parameters(config_fn_t fn, void *data);
+extern void read_early_config(config_fn_t cb, void *data);
+extern void git_config(config_fn_t fn, void *);
+extern int git_config_with_options(config_fn_t fn, void *,
+				   struct git_config_source *config_source,
+				   const struct config_options *opts);
+extern int git_parse_ulong(const char *, unsigned long *);
+extern int git_parse_maybe_bool(const char *);
+extern int git_config_int(const char *, const char *);
+extern int64_t git_config_int64(const char *, const char *);
+extern unsigned long git_config_ulong(const char *, const char *);
+extern ssize_t git_config_ssize_t(const char *, const char *);
+extern int git_config_bool_or_int(const char *, const char *, int *);
+extern int git_config_bool(const char *, const char *);
+extern int git_config_maybe_bool(const char *, const char *);
+extern int git_config_string(const char **, const char *, const char *);
+extern int git_config_pathname(const char **, const char *, const char *);
+extern int git_config_set_in_file_gently(const char *, const char *, const char *);
+extern void git_config_set_in_file(const char *, const char *, const char *);
+extern int git_config_set_gently(const char *, const char *);
+extern void git_config_set(const char *, const char *);
+extern int git_config_parse_key(const char *, char **, int *);
+extern int git_config_key_is_valid(const char *key);
+extern int git_config_set_multivar_gently(const char *, const char *, const char *, int);
+extern void git_config_set_multivar(const char *, const char *, const char *, int);
+extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
+extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+extern int git_config_rename_section(const char *, const char *);
+extern int git_config_rename_section_in_file(const char *, const char *, const char *);
+extern const char *git_etc_gitconfig(void);
+extern int git_env_bool(const char *, int);
+extern unsigned long git_env_ulong(const char *, unsigned long);
+extern int git_config_system(void);
+extern int config_error_nonbool(const char *);
+#if defined(__GNUC__)
+#define config_error_nonbool(s) (config_error_nonbool(s), const_error())
+#endif
+
+extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+
+enum config_scope {
+	CONFIG_SCOPE_UNKNOWN = 0,
+	CONFIG_SCOPE_SYSTEM,
+	CONFIG_SCOPE_GLOBAL,
+	CONFIG_SCOPE_REPO,
+	CONFIG_SCOPE_CMDLINE,
+};
+
+extern enum config_scope current_config_scope(void);
+extern const char *current_config_origin_type(void);
+extern const char *current_config_name(void);
+
+struct config_include_data {
+	int depth;
+	config_fn_t fn;
+	void *data;
+	const struct config_options *opts;
+};
+#define CONFIG_INCLUDE_INIT { 0 }
+extern int git_config_include(const char *name, const char *value, void *data);
+
+/*
+ * Match and parse a config key of the form:
+ *
+ *   section.(subsection.)?key
+ *
+ * (i.e., what gets handed to a config_fn_t). The caller provides the section;
+ * we return -1 if it does not match, 0 otherwise. The subsection and key
+ * out-parameters are filled by the function (and *subsection is NULL if it is
+ * missing).
+ *
+ * If the subsection pointer-to-pointer passed in is NULL, returns 0 only if
+ * there is no subsection at all.
+ */
+extern int parse_config_key(const char *var,
+			    const char *section,
+			    const char **subsection, int *subsection_len,
+			    const char **key);
+
+struct config_set_element {
+	struct hashmap_entry ent;
+	char *key;
+	struct string_list value_list;
+};
+
+struct configset_list_item {
+	struct config_set_element *e;
+	int value_index;
+};
+
+/*
+ * the contents of the list are ordered according to their
+ * position in the config files and order of parsing the files.
+ * (i.e. key-value pair at the last position of .git/config will
+ * be at the last item of the list)
+ */
+struct configset_list {
+	struct configset_list_item *items;
+	unsigned int nr, alloc;
+};
+
+struct config_set {
+	struct hashmap config_hash;
+	int hash_initialized;
+	struct configset_list list;
+};
+
+extern void git_configset_init(struct config_set *cs);
+extern int git_configset_add_file(struct config_set *cs, const char *filename);
+extern int git_configset_get_value(struct config_set *cs, const char *key, const char **value);
+extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
+extern void git_configset_clear(struct config_set *cs);
+extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
+extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
+extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
+extern int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
+extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
+extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
+
+extern int git_config_get_value(const char *key, const char **value);
+extern const struct string_list *git_config_get_value_multi(const char *key);
+extern void git_config_clear(void);
+extern void git_config_iter(config_fn_t fn, void *data);
+extern int git_config_get_string_const(const char *key, const char **dest);
+extern int git_config_get_string(const char *key, char **dest);
+extern int git_config_get_int(const char *key, int *dest);
+extern int git_config_get_ulong(const char *key, unsigned long *dest);
+extern int git_config_get_bool(const char *key, int *dest);
+extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
+extern int git_config_get_maybe_bool(const char *key, int *dest);
+extern int git_config_get_pathname(const char *key, const char **dest);
+extern int git_config_get_untracked_cache(void);
+extern int git_config_get_split_index(void);
+extern int git_config_get_max_percent_split_change(void);
+
+/* This dies if the configured or default date is in the future */
+extern int git_config_get_expiry(const char *key, const char **output);
+
+struct key_value_info {
+	const char *filename;
+	int linenr;
+	enum config_origin_type origin_type;
+	enum config_scope scope;
+};
+
+extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
+
+#endif /* CONFIG_H */
-- 
2.13.1.508.gb3defc5cc-goog

