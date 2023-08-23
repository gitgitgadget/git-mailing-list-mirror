Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCED7C71145
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbjHWVy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjHWVyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 17:54:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B363FE52
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:54:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58caf216c55so5345287b3.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692827642; x=1693432442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdpUFXHMtz3T/14ZmNmJmJNkepsPmOz4YeC34yW6+sA=;
        b=FXtOshf9Elytu8fODhPbeHn1KOweLLiXcB2OOka38S45uW9Uq/hNmN8fd9ZAeXZ0WO
         m6WK6vlF2/W9F8rkEz0da0SSHZtVvdCILTh5C07IinmH7haLfuAEvw5BQ+PkGRQ1GTV2
         htXU3nc2SvVFtBj/CoegLXp/v8euqn547yyKwRqyKmbnqSEAE9ls4zJ5Jk3pzPKKGFNW
         d7TcCD29PwwzIfj8SUGNNxI+4UYzo9CPRBEtRRllxAKvgA7BHJ1hsDfMUBDKRj4FbY0w
         F9wTehrpWhYgAgqcYtSLRdxpcFKbKIr6k5ZKeLfX9eliJXvb21rDNGR8v3wmrDW4QecN
         XhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827642; x=1693432442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdpUFXHMtz3T/14ZmNmJmJNkepsPmOz4YeC34yW6+sA=;
        b=fdJJT0891kzpShBMfr3+d1zCpXEJrxMSHI+n89zbcLV5rgGHtx5qE88El9NZOuWg1H
         deEjLp6elxsgHU3wtulXBlKao1TFpzaMTawLv4theTlbfWALjsTrQh7MPcB0j8nb9cJU
         wlz//A25Rup2Bd3b8EzS62tLjbSF7et6YJZdvnvCTjA839wq9P9AHyNV6tF10EzyAZzg
         CedVxPpC8pBNZDlZcAsIKTlII4hECY+udKZcfdxg/l5fk7vsbxLY7qw6PBCErruI/r49
         P9ZIFYQDp/eA2SOV7zdlfrDmoVYaNt/Ba9eBNtPp62/AQwtxYcbG2TRCS0aZQKKXNxkE
         fC0Q==
X-Gm-Message-State: AOJu0YyDqI7TcjLj9B6GPKsZg0L+jHJTZwZgPupTKhK/LuY00UU9UWuB
        cQBgfC/5Fbxwh2MTZHfJkoYTq1qKSRSIHqv8TBL4flNQFKrcDFyZnoPo4b1hKN71WA4voOR1JIz
        S4GcpTGe5Bn0VxjXmRQvvNlNUH4IwEIW5RexpGBKtgukgUEgUp3d1znu/7IUZrAo=
X-Google-Smtp-Source: AGHT+IFtM5GuMZfiIo48krrl5BCwql+e8jeG2G525VcvmNhZHCwnTHBnx5KYITLh1qq6unCeZybCuOvQZ353ig==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:83ba:288:9608:d4be])
 (user=steadmon job=sendgmr) by 2002:a25:e78a:0:b0:d04:6d5e:4ded with SMTP id
 e132-20020a25e78a000000b00d046d5e4dedmr257532ybh.6.1692827641914; Wed, 23 Aug
 2023 14:54:01 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:53:51 -0700
In-Reply-To: <cover.1692827403.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1692827403.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <74c5dcd5a27fd5749a0b0bedfa58e806dc78d5f0.1692827403.git.steadmon@google.com>
Subject: [PATCH v2 4/4] config-parse: split library out of config.[c|h]
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

The config parsing machinery (besides "include" directives) is usable by
programs other than Git - it works with any file written in Git config
syntax (IOW it doesn't rely on 'core' Git features like a repository),
and as of the series ending at 6e8e7981eb (config: pass source to
config_parser_event_fn_t, 2023-06-28), it no longer relies on global
state. Thus, we can and should start turning it into a library other
programs can use.

Begin this process by splitting the config parsing code out of
config.[c|h] and into config-parse.[c|h]. Do not change interfaces or
function bodies, but tweak visibility and includes where appropriate,
namely:

- git_config_from_stdin() is now non-static so that it can be seen by
  config.c.

- "struct config_source" is now defined in the .h file so that it can be
  seen by config.c. And as a result, config-lib.h needs to "#include
  strbuf.h".

In theory, this makes it possible for in-tree files to decide whether
they only need all of the config functionality or only config parsing,
and bring in the smallest bit of functionality needed. But for now,
there are no in-tree files that can swap "#include config.h" for
"#include config-parse.h". E.g. Bundle URIs would only need config
parsing to parse bundle lists, but bundle-uri.c uses other config.h
functionality like key parsing and reading repo settings.

The resulting library is usable, though it is unergonomic to do so,
e.g. the caller needs to "#include git-compat-util.h" and other
dependencies, and we don't have an easy way of linking in the required
objects. This isn't the end state we want for our libraries, but at
least we have _some_ library whose usability we can improve in future
series.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile       |   1 +
 config-parse.c | 561 +++++++++++++++++++++++++++++++++++++++++++++++
 config-parse.h | 155 +++++++++++++
 config.c       | 582 -------------------------------------------------
 config.h       | 119 +---------
 5 files changed, 718 insertions(+), 700 deletions(-)
 create mode 100644 config-parse.c
 create mode 100644 config-parse.h

diff --git a/Makefile b/Makefile
index fb541dedc9..67e05bcee5 100644
--- a/Makefile
+++ b/Makefile
@@ -992,6 +992,7 @@ LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compat/zlib-uncompress2.o
 LIB_OBJS += config.o
+LIB_OBJS += config-parse.o
 LIB_OBJS += connect.o
 LIB_OBJS += connected.o
 LIB_OBJS += convert.o
diff --git a/config-parse.c b/config-parse.c
new file mode 100644
index 0000000000..97ebd6d72b
--- /dev/null
+++ b/config-parse.c
@@ -0,0 +1,561 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "gettext.h"
+#include "hashmap.h"
+#include "utf8.h"
+#include "config-parse.h"
+
+static int config_file_fgetc(struct config_source *conf)
+{
+	return getc_unlocked(conf->u.file);
+}
+
+static int config_file_ungetc(int c, struct config_source *conf)
+{
+	return ungetc(c, conf->u.file);
+}
+
+static long config_file_ftell(struct config_source *conf)
+{
+	return ftell(conf->u.file);
+}
+
+
+static int config_buf_fgetc(struct config_source *conf)
+{
+	if (conf->u.buf.pos < conf->u.buf.len)
+		return conf->u.buf.buf[conf->u.buf.pos++];
+
+	return EOF;
+}
+
+static int config_buf_ungetc(int c, struct config_source *conf)
+{
+	if (conf->u.buf.pos > 0) {
+		conf->u.buf.pos--;
+		if (conf->u.buf.buf[conf->u.buf.pos] != c)
+			BUG("config_buf can only ungetc the same character");
+		return c;
+	}
+
+	return EOF;
+}
+
+static long config_buf_ftell(struct config_source *conf)
+{
+	return conf->u.buf.pos;
+}
+
+static inline int iskeychar(int c)
+{
+	return isalnum(c) || c == '-';
+}
+
+/*
+ * Auxiliary function to sanity-check and split the key into the section
+ * identifier and variable name.
+ *
+ * Returns 0 on success, -CONFIG_INVALID_KEY when there is an invalid character
+ * in the key and -CONFIG_NO_SECTION_OR_NAME if there is no section name in the
+ * key.
+ *
+ * store_key - pointer to char* which will hold a copy of the key with
+ *             lowercase section and variable name
+ * baselen - pointer to size_t which will hold the length of the
+ *           section + subsection part, can be NULL
+ */
+int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
+{
+	size_t i, baselen;
+	int dot;
+	const char *last_dot = strrchr(key, '.');
+
+	/*
+	 * Since "key" actually contains the section name and the real
+	 * key name separated by a dot, we have to know where the dot is.
+	 */
+
+	if (last_dot == NULL || last_dot == key) {
+		error(_("key does not contain a section: %s"), key);
+		return -CONFIG_NO_SECTION_OR_NAME;
+	}
+
+	if (!last_dot[1]) {
+		error(_("key does not contain variable name: %s"), key);
+		return -CONFIG_NO_SECTION_OR_NAME;
+	}
+
+	baselen = last_dot - key;
+	if (baselen_)
+		*baselen_ = baselen;
+
+	/*
+	 * Validate the key and while at it, lower case it for matching.
+	 */
+	*store_key = xmallocz(strlen(key));
+
+	dot = 0;
+	for (i = 0; key[i]; i++) {
+		unsigned char c = key[i];
+		if (c == '.')
+			dot = 1;
+		/* Leave the extended basename untouched.. */
+		if (!dot || i > baselen) {
+			if (!iskeychar(c) ||
+			    (i == baselen + 1 && !isalpha(c))) {
+				error(_("invalid key: %s"), key);
+				goto out_free_ret_1;
+			}
+			c = tolower(c);
+		} else if (c == '\n') {
+			error(_("invalid key (newline): %s"), key);
+			goto out_free_ret_1;
+		}
+		(*store_key)[i] = c;
+	}
+
+	return 0;
+
+out_free_ret_1:
+	FREE_AND_NULL(*store_key);
+	return -CONFIG_INVALID_KEY;
+}
+
+static int get_next_char(struct config_source *cs)
+{
+	int c = cs->do_fgetc(cs);
+
+	if (c == '\r') {
+		/* DOS like systems */
+		c = cs->do_fgetc(cs);
+		if (c != '\n') {
+			if (c != EOF)
+				cs->do_ungetc(c, cs);
+			c = '\r';
+		}
+	}
+
+	if (c != EOF && ++cs->total_len > INT_MAX) {
+		/*
+		 * This is an absurdly long config file; refuse to parse
+		 * further in order to protect downstream code from integer
+		 * overflows. Note that we can't return an error specifically,
+		 * but we can mark EOF and put trash in the return value,
+		 * which will trigger a parse error.
+		 */
+		cs->eof = 1;
+		return 0;
+	}
+
+	if (c == '\n')
+		cs->linenr++;
+	if (c == EOF) {
+		cs->eof = 1;
+		cs->linenr++;
+		c = '\n';
+	}
+	return c;
+}
+
+static char *parse_value(struct config_source *cs)
+{
+	int quote = 0, comment = 0, space = 0;
+
+	strbuf_reset(&cs->value);
+	for (;;) {
+		int c = get_next_char(cs);
+		if (c == '\n') {
+			if (quote) {
+				cs->linenr--;
+				return NULL;
+			}
+			return cs->value.buf;
+		}
+		if (comment)
+			continue;
+		if (isspace(c) && !quote) {
+			if (cs->value.len)
+				space++;
+			continue;
+		}
+		if (!quote) {
+			if (c == ';' || c == '#') {
+				comment = 1;
+				continue;
+			}
+		}
+		for (; space; space--)
+			strbuf_addch(&cs->value, ' ');
+		if (c == '\\') {
+			c = get_next_char(cs);
+			switch (c) {
+			case '\n':
+				continue;
+			case 't':
+				c = '\t';
+				break;
+			case 'b':
+				c = '\b';
+				break;
+			case 'n':
+				c = '\n';
+				break;
+			/* Some characters escape as themselves */
+			case '\\': case '"':
+				break;
+			/* Reject unknown escape sequences */
+			default:
+				return NULL;
+			}
+			strbuf_addch(&cs->value, c);
+			continue;
+		}
+		if (c == '"') {
+			quote = 1-quote;
+			continue;
+		}
+		strbuf_addch(&cs->value, c);
+	}
+}
+
+static int get_value(struct config_source *cs, struct key_value_info *kvi,
+		     config_fn_t fn, void *data, struct strbuf *name)
+{
+	int c;
+	char *value;
+	int ret;
+	struct config_context ctx = {
+		.kvi = kvi,
+	};
+
+	/* Get the full name */
+	for (;;) {
+		c = get_next_char(cs);
+		if (cs->eof)
+			break;
+		if (!iskeychar(c))
+			break;
+		strbuf_addch(name, tolower(c));
+	}
+
+	while (c == ' ' || c == '\t')
+		c = get_next_char(cs);
+
+	value = NULL;
+	if (c != '\n') {
+		if (c != '=')
+			return -1;
+		value = parse_value(cs);
+		if (!value)
+			return -1;
+	}
+	/*
+	 * We already consumed the \n, but we need linenr to point to
+	 * the line we just parsed during the call to fn to get
+	 * accurate line number in error messages.
+	 */
+	cs->linenr--;
+	kvi->linenr = cs->linenr;
+	ret = fn(name->buf, value, &ctx, data);
+	if (ret >= 0)
+		cs->linenr++;
+	return ret;
+}
+
+static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
+				 int c)
+{
+	cs->subsection_case_sensitive = 0;
+	do {
+		if (c == '\n')
+			goto error_incomplete_line;
+		c = get_next_char(cs);
+	} while (isspace(c));
+
+	/* We require the format to be '[base "extension"]' */
+	if (c != '"')
+		return -1;
+	strbuf_addch(name, '.');
+
+	for (;;) {
+		int c = get_next_char(cs);
+		if (c == '\n')
+			goto error_incomplete_line;
+		if (c == '"')
+			break;
+		if (c == '\\') {
+			c = get_next_char(cs);
+			if (c == '\n')
+				goto error_incomplete_line;
+		}
+		strbuf_addch(name, c);
+	}
+
+	/* Final ']' */
+	if (get_next_char(cs) != ']')
+		return -1;
+	return 0;
+error_incomplete_line:
+	cs->linenr--;
+	return -1;
+}
+
+static int get_base_var(struct config_source *cs, struct strbuf *name)
+{
+	cs->subsection_case_sensitive = 1;
+	for (;;) {
+		int c = get_next_char(cs);
+		if (cs->eof)
+			return -1;
+		if (c == ']')
+			return 0;
+		if (isspace(c))
+			return get_extended_base_var(cs, name, c);
+		if (!iskeychar(c) && c != '.')
+			return -1;
+		strbuf_addch(name, tolower(c));
+	}
+}
+
+struct parse_event_data {
+	enum config_event_t previous_type;
+	size_t previous_offset;
+	const struct config_parse_options *opts;
+};
+
+static int do_event(struct config_source *cs, enum config_event_t type,
+		    struct parse_event_data *data)
+{
+	size_t offset;
+
+	if (!data->opts || !data->opts->event_fn)
+		return 0;
+
+	if (type == CONFIG_EVENT_WHITESPACE &&
+	    data->previous_type == type)
+		return 0;
+
+	offset = cs->do_ftell(cs);
+	/*
+	 * At EOF, the parser always "inserts" an extra '\n', therefore
+	 * the end offset of the event is the current file position, otherwise
+	 * we will already have advanced to the next event.
+	 */
+	if (type != CONFIG_EVENT_EOF)
+		offset--;
+
+	if (data->previous_type != CONFIG_EVENT_EOF &&
+	    data->opts->event_fn(data->previous_type, data->previous_offset,
+				 offset, cs, data->opts->event_fn_data) < 0)
+		return -1;
+
+	data->previous_type = type;
+	data->previous_offset = offset;
+
+	return 0;
+}
+
+static void kvi_from_source(struct config_source *cs,
+			    enum config_scope scope,
+			    struct key_value_info *out)
+{
+	out->filename = strintern(cs->name);
+	out->origin_type = cs->origin_type;
+	out->linenr = cs->linenr;
+	out->scope = scope;
+	out->path = cs->path;
+}
+
+static int git_parse_source(struct config_source *cs, config_fn_t fn,
+			    struct key_value_info *kvi, void *data,
+			    const struct config_parse_options *opts)
+{
+	int comment = 0;
+	size_t baselen = 0;
+	struct strbuf *var = &cs->var;
+
+	/* U+FEFF Byte Order Mark in UTF8 */
+	const char *bomptr = utf8_bom;
+
+	/* For the parser event callback */
+	struct parse_event_data event_data = {
+		CONFIG_EVENT_EOF, 0, opts
+	};
+
+	for (;;) {
+		int c;
+
+		c = get_next_char(cs);
+		if (bomptr && *bomptr) {
+			/* We are at the file beginning; skip UTF8-encoded BOM
+			 * if present. Sane editors won't put this in on their
+			 * own, but e.g. Windows Notepad will do it happily. */
+			if (c == (*bomptr & 0377)) {
+				bomptr++;
+				continue;
+			} else {
+				/* Do not tolerate partial BOM. */
+				if (bomptr != utf8_bom)
+					break;
+				/* No BOM at file beginning. Cool. */
+				bomptr = NULL;
+			}
+		}
+		if (c == '\n') {
+			if (cs->eof) {
+				if (do_event(cs, CONFIG_EVENT_EOF, &event_data) < 0)
+					return -1;
+				return 0;
+			}
+			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+				return -1;
+			comment = 0;
+			continue;
+		}
+		if (comment)
+			continue;
+		if (isspace(c)) {
+			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+					return -1;
+			continue;
+		}
+		if (c == '#' || c == ';') {
+			if (do_event(cs, CONFIG_EVENT_COMMENT, &event_data) < 0)
+					return -1;
+			comment = 1;
+			continue;
+		}
+		if (c == '[') {
+			if (do_event(cs, CONFIG_EVENT_SECTION, &event_data) < 0)
+					return -1;
+
+			/* Reset prior to determining a new stem */
+			strbuf_reset(var);
+			if (get_base_var(cs, var) < 0 || var->len < 1)
+				break;
+			strbuf_addch(var, '.');
+			baselen = var->len;
+			continue;
+		}
+		if (!isalpha(c))
+			break;
+
+		if (do_event(cs, CONFIG_EVENT_ENTRY, &event_data) < 0)
+			return -1;
+
+		/*
+		 * Truncate the var name back to the section header
+		 * stem prior to grabbing the suffix part of the name
+		 * and the value.
+		 */
+		strbuf_setlen(var, baselen);
+		strbuf_addch(var, tolower(c));
+		if (get_value(cs, kvi, fn, data, var) < 0)
+			break;
+	}
+	/*
+	 * FIXME for whatever reason, do_event passes the _previous_ event, so
+	 * in order for our callback to receive the error event, we have to call
+	 * do_event twice
+	 */
+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
+	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
+	return -1;
+}
+
+/*
+ * All source specific fields in the union, die_on_error, name and the callbacks
+ * fgetc, ungetc, ftell of top need to be initialized before calling
+ * this function.
+ */
+static int do_config_from(struct config_source *top, config_fn_t fn,
+			  void *data, enum config_scope scope,
+			  const struct config_parse_options *opts)
+{
+	struct key_value_info kvi = KVI_INIT;
+	int ret;
+
+	/* push config-file parsing state stack */
+	top->linenr = 1;
+	top->eof = 0;
+	top->total_len = 0;
+	strbuf_init(&top->value, 1024);
+	strbuf_init(&top->var, 1024);
+	kvi_from_source(top, scope, &kvi);
+
+	ret = git_parse_source(top, fn, &kvi, data, opts);
+
+	strbuf_release(&top->value);
+	strbuf_release(&top->var);
+
+	return ret;
+}
+
+static int do_config_from_file(config_fn_t fn,
+			       const enum config_origin_type origin_type,
+			       const char *name, const char *path, FILE *f,
+			       void *data, enum config_scope scope,
+			       const struct config_parse_options *opts)
+{
+	struct config_source top = CONFIG_SOURCE_INIT;
+	int ret;
+
+	top.u.file = f;
+	top.origin_type = origin_type;
+	top.name = name;
+	top.path = path;
+	top.do_fgetc = config_file_fgetc;
+	top.do_ungetc = config_file_ungetc;
+	top.do_ftell = config_file_ftell;
+
+	flockfile(f);
+	ret = do_config_from(&top, fn, data, scope, opts);
+	funlockfile(f);
+	return ret;
+}
+
+int git_config_from_stdin(config_fn_t fn, void *data, enum config_scope scope,
+			  const struct config_parse_options *config_opts)
+{
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
+				   data, scope, config_opts);
+}
+
+int git_config_from_file_with_options(config_fn_t fn, const char *filename,
+				      void *data, enum config_scope scope,
+				      const struct config_parse_options *opts)
+{
+	int ret = -1;
+	FILE *f;
+
+	if (!filename)
+		BUG("filename cannot be NULL");
+	f = fopen_or_warn(filename, "r");
+	if (f) {
+		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
+					  filename, f, data, scope, opts);
+		fclose(f);
+	}
+	return ret;
+}
+
+int git_config_from_mem(config_fn_t fn,
+			const enum config_origin_type origin_type,
+			const char *name, const char *buf, size_t len,
+			void *data, enum config_scope scope,
+			const struct config_parse_options *opts)
+{
+	struct config_source top = CONFIG_SOURCE_INIT;
+
+	top.u.buf.buf = buf;
+	top.u.buf.len = len;
+	top.u.buf.pos = 0;
+	top.origin_type = origin_type;
+	top.name = name;
+	top.path = NULL;
+	top.do_fgetc = config_buf_fgetc;
+	top.do_ungetc = config_buf_ungetc;
+	top.do_ftell = config_buf_ftell;
+
+	return do_config_from(&top, fn, data, scope, opts);
+}
diff --git a/config-parse.h b/config-parse.h
new file mode 100644
index 0000000000..ac73a826d9
--- /dev/null
+++ b/config-parse.h
@@ -0,0 +1,155 @@
+/*
+ * Low level config parsing.
+ */
+#ifndef CONFIG_PARSE_H
+#define CONFIG_PARSE_H
+
+#include "strbuf.h"
+
+/* git_config_parse_key() returns these negated: */
+#define CONFIG_INVALID_KEY 1
+#define CONFIG_NO_SECTION_OR_NAME 2
+
+int git_config_parse_key(const char *, char **, size_t *);
+
+enum config_scope {
+	CONFIG_SCOPE_UNKNOWN = 0,
+	CONFIG_SCOPE_SYSTEM,
+	CONFIG_SCOPE_GLOBAL,
+	CONFIG_SCOPE_LOCAL,
+	CONFIG_SCOPE_WORKTREE,
+	CONFIG_SCOPE_COMMAND,
+	CONFIG_SCOPE_SUBMODULE,
+};
+const char *config_scope_name(enum config_scope scope);
+
+enum config_origin_type {
+	CONFIG_ORIGIN_UNKNOWN = 0,
+	CONFIG_ORIGIN_BLOB,
+	CONFIG_ORIGIN_FILE,
+	CONFIG_ORIGIN_STDIN,
+	CONFIG_ORIGIN_SUBMODULE_BLOB,
+	CONFIG_ORIGIN_CMDLINE
+};
+
+enum config_event_t {
+	CONFIG_EVENT_SECTION,
+	CONFIG_EVENT_ENTRY,
+	CONFIG_EVENT_WHITESPACE,
+	CONFIG_EVENT_COMMENT,
+	CONFIG_EVENT_EOF,
+	CONFIG_EVENT_ERROR
+};
+
+struct config_source;
+/*
+ * The parser event function (if not NULL) is called with the event type and
+ * the begin/end offsets of the parsed elements.
+ *
+ * Note: for CONFIG_EVENT_ENTRY (i.e. config variables), the trailing newline
+ * character is considered part of the element.
+ */
+typedef int (*config_parser_event_fn_t)(enum config_event_t type,
+					size_t begin_offset, size_t end_offset,
+					struct config_source *cs,
+					void *event_fn_data);
+
+struct config_parse_options {
+	/*
+	 * event_fn and event_fn_data are for internal use only. Handles events
+	 * emitted by the config parser.
+	 */
+	config_parser_event_fn_t event_fn;
+	void *event_fn_data;
+};
+
+struct config_source {
+	struct config_source *prev;
+	union {
+		FILE *file;
+		struct config_buf {
+			const char *buf;
+			size_t len;
+			size_t pos;
+		} buf;
+	} u;
+	enum config_origin_type origin_type;
+	const char *name;
+	const char *path;
+	int linenr;
+	int eof;
+	size_t total_len;
+	struct strbuf value;
+	struct strbuf var;
+	unsigned subsection_case_sensitive : 1;
+
+	int (*do_fgetc)(struct config_source *c);
+	int (*do_ungetc)(int c, struct config_source *conf);
+	long (*do_ftell)(struct config_source *c);
+};
+#define CONFIG_SOURCE_INIT { 0 }
+
+/* Config source metadata for a given config key-value pair */
+struct key_value_info {
+	const char *filename;
+	int linenr;
+	enum config_origin_type origin_type;
+	enum config_scope scope;
+	const char *path;
+};
+#define KVI_INIT { \
+	.filename = NULL, \
+	.linenr = -1, \
+	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
+	.scope = CONFIG_SCOPE_UNKNOWN, \
+	.path = NULL, \
+}
+
+/* Captures additional information that a config callback can use. */
+struct config_context {
+	/* Config source metadata for key and value. */
+	const struct key_value_info *kvi;
+};
+#define CONFIG_CONTEXT_INIT { 0 }
+
+/**
+ * A config callback function takes four parameters:
+ *
+ * - the name of the parsed variable. This is in canonical "flat" form: the
+ *   section, subsection, and variable segments will be separated by dots,
+ *   and the section and variable segments will be all lowercase. E.g.,
+ *   `core.ignorecase`, `diff.SomeType.textconv`.
+ *
+ * - the value of the found variable, as a string. If the variable had no
+ *   value specified, the value will be NULL (typically this means it
+ *   should be interpreted as boolean true).
+ *
+ * - the 'config context', that is, additional information about the config
+ *   iteration operation provided by the config machinery. For example, this
+ *   includes information about the config source being parsed (e.g. the
+ *   filename).
+ *
+ * - a void pointer passed in by the caller of the config API; this can
+ *   contain callback-specific data
+ *
+ * A config callback should return 0 for success, or -1 if the variable
+ * could not be parsed properly.
+ */
+typedef int (*config_fn_t)(const char *, const char *,
+			   const struct config_context *, void *);
+
+int git_config_from_file_with_options(config_fn_t fn, const char *,
+				      void *, enum config_scope,
+				      const struct config_parse_options *);
+
+int git_config_from_mem(config_fn_t fn,
+			const enum config_origin_type,
+			const char *name,
+			const char *buf, size_t len,
+			void *data, enum config_scope scope,
+			const struct config_parse_options *opts);
+
+int git_config_from_stdin(config_fn_t fn, void *data, enum config_scope scope,
+			  const struct config_parse_options *config_opts);
+
+#endif /* CONFIG_PARSE_H */
diff --git a/config.c b/config.c
index 40cc9dbc40..787b42c228 100644
--- a/config.c
+++ b/config.c
@@ -42,32 +42,6 @@
 #include "wrapper.h"
 #include "write-or-die.h"
 
-struct config_source {
-	struct config_source *prev;
-	union {
-		FILE *file;
-		struct config_buf {
-			const char *buf;
-			size_t len;
-			size_t pos;
-		} buf;
-	} u;
-	enum config_origin_type origin_type;
-	const char *name;
-	const char *path;
-	int linenr;
-	int eof;
-	size_t total_len;
-	struct strbuf value;
-	struct strbuf var;
-	unsigned subsection_case_sensitive : 1;
-
-	int (*do_fgetc)(struct config_source *c);
-	int (*do_ungetc)(int c, struct config_source *conf);
-	long (*do_ftell)(struct config_source *c);
-};
-#define CONFIG_SOURCE_INIT { 0 }
-
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -82,47 +56,6 @@ static int zlib_compression_seen;
  */
 static struct config_set protected_config;
 
-static int config_file_fgetc(struct config_source *conf)
-{
-	return getc_unlocked(conf->u.file);
-}
-
-static int config_file_ungetc(int c, struct config_source *conf)
-{
-	return ungetc(c, conf->u.file);
-}
-
-static long config_file_ftell(struct config_source *conf)
-{
-	return ftell(conf->u.file);
-}
-
-
-static int config_buf_fgetc(struct config_source *conf)
-{
-	if (conf->u.buf.pos < conf->u.buf.len)
-		return conf->u.buf.buf[conf->u.buf.pos++];
-
-	return EOF;
-}
-
-static int config_buf_ungetc(int c, struct config_source *conf)
-{
-	if (conf->u.buf.pos > 0) {
-		conf->u.buf.pos--;
-		if (conf->u.buf.buf[conf->u.buf.pos] != c)
-			BUG("config_buf can only ungetc the same character");
-		return c;
-	}
-
-	return EOF;
-}
-
-static long config_buf_ftell(struct config_source *conf)
-{
-	return conf->u.buf.pos;
-}
-
 struct config_include_data {
 	int depth;
 	config_fn_t fn;
@@ -528,80 +461,6 @@ void git_config_push_env(const char *spec)
 	free(key);
 }
 
-static inline int iskeychar(int c)
-{
-	return isalnum(c) || c == '-';
-}
-
-/*
- * Auxiliary function to sanity-check and split the key into the section
- * identifier and variable name.
- *
- * Returns 0 on success, -1 when there is an invalid character in the key and
- * -2 if there is no section name in the key.
- *
- * store_key - pointer to char* which will hold a copy of the key with
- *             lowercase section and variable name
- * baselen - pointer to size_t which will hold the length of the
- *           section + subsection part, can be NULL
- */
-int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
-{
-	size_t i, baselen;
-	int dot;
-	const char *last_dot = strrchr(key, '.');
-
-	/*
-	 * Since "key" actually contains the section name and the real
-	 * key name separated by a dot, we have to know where the dot is.
-	 */
-
-	if (last_dot == NULL || last_dot == key) {
-		error(_("key does not contain a section: %s"), key);
-		return -CONFIG_NO_SECTION_OR_NAME;
-	}
-
-	if (!last_dot[1]) {
-		error(_("key does not contain variable name: %s"), key);
-		return -CONFIG_NO_SECTION_OR_NAME;
-	}
-
-	baselen = last_dot - key;
-	if (baselen_)
-		*baselen_ = baselen;
-
-	/*
-	 * Validate the key and while at it, lower case it for matching.
-	 */
-	*store_key = xmallocz(strlen(key));
-
-	dot = 0;
-	for (i = 0; key[i]; i++) {
-		unsigned char c = key[i];
-		if (c == '.')
-			dot = 1;
-		/* Leave the extended basename untouched.. */
-		if (!dot || i > baselen) {
-			if (!iskeychar(c) ||
-			    (i == baselen + 1 && !isalpha(c))) {
-				error(_("invalid key: %s"), key);
-				goto out_free_ret_1;
-			}
-			c = tolower(c);
-		} else if (c == '\n') {
-			error(_("invalid key (newline): %s"), key);
-			goto out_free_ret_1;
-		}
-		(*store_key)[i] = c;
-	}
-
-	return 0;
-
-out_free_ret_1:
-	FREE_AND_NULL(*store_key);
-	return -CONFIG_INVALID_KEY;
-}
-
 static int config_parse_pair(const char *key, const char *value,
 			     struct key_value_info *kvi,
 			     config_fn_t fn, void *data)
@@ -786,251 +645,6 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	return ret;
 }
 
-static int get_next_char(struct config_source *cs)
-{
-	int c = cs->do_fgetc(cs);
-
-	if (c == '\r') {
-		/* DOS like systems */
-		c = cs->do_fgetc(cs);
-		if (c != '\n') {
-			if (c != EOF)
-				cs->do_ungetc(c, cs);
-			c = '\r';
-		}
-	}
-
-	if (c != EOF && ++cs->total_len > INT_MAX) {
-		/*
-		 * This is an absurdly long config file; refuse to parse
-		 * further in order to protect downstream code from integer
-		 * overflows. Note that we can't return an error specifically,
-		 * but we can mark EOF and put trash in the return value,
-		 * which will trigger a parse error.
-		 */
-		cs->eof = 1;
-		return 0;
-	}
-
-	if (c == '\n')
-		cs->linenr++;
-	if (c == EOF) {
-		cs->eof = 1;
-		cs->linenr++;
-		c = '\n';
-	}
-	return c;
-}
-
-static char *parse_value(struct config_source *cs)
-{
-	int quote = 0, comment = 0, space = 0;
-
-	strbuf_reset(&cs->value);
-	for (;;) {
-		int c = get_next_char(cs);
-		if (c == '\n') {
-			if (quote) {
-				cs->linenr--;
-				return NULL;
-			}
-			return cs->value.buf;
-		}
-		if (comment)
-			continue;
-		if (isspace(c) && !quote) {
-			if (cs->value.len)
-				space++;
-			continue;
-		}
-		if (!quote) {
-			if (c == ';' || c == '#') {
-				comment = 1;
-				continue;
-			}
-		}
-		for (; space; space--)
-			strbuf_addch(&cs->value, ' ');
-		if (c == '\\') {
-			c = get_next_char(cs);
-			switch (c) {
-			case '\n':
-				continue;
-			case 't':
-				c = '\t';
-				break;
-			case 'b':
-				c = '\b';
-				break;
-			case 'n':
-				c = '\n';
-				break;
-			/* Some characters escape as themselves */
-			case '\\': case '"':
-				break;
-			/* Reject unknown escape sequences */
-			default:
-				return NULL;
-			}
-			strbuf_addch(&cs->value, c);
-			continue;
-		}
-		if (c == '"') {
-			quote = 1-quote;
-			continue;
-		}
-		strbuf_addch(&cs->value, c);
-	}
-}
-
-static int get_value(struct config_source *cs, struct key_value_info *kvi,
-		     config_fn_t fn, void *data, struct strbuf *name)
-{
-	int c;
-	char *value;
-	int ret;
-	struct config_context ctx = {
-		.kvi = kvi,
-	};
-
-	/* Get the full name */
-	for (;;) {
-		c = get_next_char(cs);
-		if (cs->eof)
-			break;
-		if (!iskeychar(c))
-			break;
-		strbuf_addch(name, tolower(c));
-	}
-
-	while (c == ' ' || c == '\t')
-		c = get_next_char(cs);
-
-	value = NULL;
-	if (c != '\n') {
-		if (c != '=')
-			return -1;
-		value = parse_value(cs);
-		if (!value)
-			return -1;
-	}
-	/*
-	 * We already consumed the \n, but we need linenr to point to
-	 * the line we just parsed during the call to fn to get
-	 * accurate line number in error messages.
-	 */
-	cs->linenr--;
-	kvi->linenr = cs->linenr;
-	ret = fn(name->buf, value, &ctx, data);
-	if (ret >= 0)
-		cs->linenr++;
-	return ret;
-}
-
-static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
-				 int c)
-{
-	cs->subsection_case_sensitive = 0;
-	do {
-		if (c == '\n')
-			goto error_incomplete_line;
-		c = get_next_char(cs);
-	} while (isspace(c));
-
-	/* We require the format to be '[base "extension"]' */
-	if (c != '"')
-		return -1;
-	strbuf_addch(name, '.');
-
-	for (;;) {
-		int c = get_next_char(cs);
-		if (c == '\n')
-			goto error_incomplete_line;
-		if (c == '"')
-			break;
-		if (c == '\\') {
-			c = get_next_char(cs);
-			if (c == '\n')
-				goto error_incomplete_line;
-		}
-		strbuf_addch(name, c);
-	}
-
-	/* Final ']' */
-	if (get_next_char(cs) != ']')
-		return -1;
-	return 0;
-error_incomplete_line:
-	cs->linenr--;
-	return -1;
-}
-
-static int get_base_var(struct config_source *cs, struct strbuf *name)
-{
-	cs->subsection_case_sensitive = 1;
-	for (;;) {
-		int c = get_next_char(cs);
-		if (cs->eof)
-			return -1;
-		if (c == ']')
-			return 0;
-		if (isspace(c))
-			return get_extended_base_var(cs, name, c);
-		if (!iskeychar(c) && c != '.')
-			return -1;
-		strbuf_addch(name, tolower(c));
-	}
-}
-
-struct parse_event_data {
-	enum config_event_t previous_type;
-	size_t previous_offset;
-	const struct config_parse_options *opts;
-};
-
-static int do_event(struct config_source *cs, enum config_event_t type,
-		    struct parse_event_data *data)
-{
-	size_t offset;
-
-	if (!data->opts || !data->opts->event_fn)
-		return 0;
-
-	if (type == CONFIG_EVENT_WHITESPACE &&
-	    data->previous_type == type)
-		return 0;
-
-	offset = cs->do_ftell(cs);
-	/*
-	 * At EOF, the parser always "inserts" an extra '\n', therefore
-	 * the end offset of the event is the current file position, otherwise
-	 * we will already have advanced to the next event.
-	 */
-	if (type != CONFIG_EVENT_EOF)
-		offset--;
-
-	if (data->previous_type != CONFIG_EVENT_EOF &&
-	    data->opts->event_fn(data->previous_type, data->previous_offset,
-				 offset, cs, data->opts->event_fn_data) < 0)
-		return -1;
-
-	data->previous_type = type;
-	data->previous_offset = offset;
-
-	return 0;
-}
-
-static void kvi_from_source(struct config_source *cs,
-			    enum config_scope scope,
-			    struct key_value_info *out)
-{
-	out->filename = strintern(cs->name);
-	out->origin_type = cs->origin_type;
-	out->linenr = cs->linenr;
-	out->scope = scope;
-	out->path = cs->path;
-}
-
 int git_config_err_fn(enum config_event_t type, size_t begin_offset UNUSED,
 		      size_t end_offset UNUSED, struct config_source *cs,
 		      void *data)
@@ -1081,104 +695,6 @@ int git_config_err_fn(enum config_event_t type, size_t begin_offset UNUSED,
 	return error_return;
 }
 
-static int git_parse_source(struct config_source *cs, config_fn_t fn,
-			    struct key_value_info *kvi, void *data,
-			    const struct config_parse_options *opts)
-{
-	int comment = 0;
-	size_t baselen = 0;
-	struct strbuf *var = &cs->var;
-
-	/* U+FEFF Byte Order Mark in UTF8 */
-	const char *bomptr = utf8_bom;
-
-	/* For the parser event callback */
-	struct parse_event_data event_data = {
-		CONFIG_EVENT_EOF, 0, opts
-	};
-
-	for (;;) {
-		int c;
-
-		c = get_next_char(cs);
-		if (bomptr && *bomptr) {
-			/* We are at the file beginning; skip UTF8-encoded BOM
-			 * if present. Sane editors won't put this in on their
-			 * own, but e.g. Windows Notepad will do it happily. */
-			if (c == (*bomptr & 0377)) {
-				bomptr++;
-				continue;
-			} else {
-				/* Do not tolerate partial BOM. */
-				if (bomptr != utf8_bom)
-					break;
-				/* No BOM at file beginning. Cool. */
-				bomptr = NULL;
-			}
-		}
-		if (c == '\n') {
-			if (cs->eof) {
-				if (do_event(cs, CONFIG_EVENT_EOF, &event_data) < 0)
-					return -1;
-				return 0;
-			}
-			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
-				return -1;
-			comment = 0;
-			continue;
-		}
-		if (comment)
-			continue;
-		if (isspace(c)) {
-			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
-					return -1;
-			continue;
-		}
-		if (c == '#' || c == ';') {
-			if (do_event(cs, CONFIG_EVENT_COMMENT, &event_data) < 0)
-					return -1;
-			comment = 1;
-			continue;
-		}
-		if (c == '[') {
-			if (do_event(cs, CONFIG_EVENT_SECTION, &event_data) < 0)
-					return -1;
-
-			/* Reset prior to determining a new stem */
-			strbuf_reset(var);
-			if (get_base_var(cs, var) < 0 || var->len < 1)
-				break;
-			strbuf_addch(var, '.');
-			baselen = var->len;
-			continue;
-		}
-		if (!isalpha(c))
-			break;
-
-		if (do_event(cs, CONFIG_EVENT_ENTRY, &event_data) < 0)
-			return -1;
-
-		/*
-		 * Truncate the var name back to the section header
-		 * stem prior to grabbing the suffix part of the name
-		 * and the value.
-		 */
-		strbuf_setlen(var, baselen);
-		strbuf_addch(var, tolower(c));
-		if (get_value(cs, kvi, fn, data, var) < 0)
-			break;
-	}
-
-	/*
-	 * FIXME for whatever reason, do_event passes the _previous_ event, so
-	 * in order for our callback to receive the error event, we have to call
-	 * do_event twice
-	 */
-	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
-	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
-	return -1;
-}
-
 static uintmax_t get_unit_factor(const char *end)
 {
 	if (!*end)
@@ -1972,83 +1488,6 @@ int git_default_config(const char *var, const char *value,
 	return 0;
 }
 
-/*
- * All source specific fields in the union, die_on_error, name and the callbacks
- * fgetc, ungetc, ftell of top need to be initialized before calling
- * this function.
- */
-static int do_config_from(struct config_source *top, config_fn_t fn,
-			  void *data, enum config_scope scope,
-			  const struct config_parse_options *opts)
-{
-	struct key_value_info kvi = KVI_INIT;
-	int ret;
-
-	/* push config-file parsing state stack */
-	top->linenr = 1;
-	top->eof = 0;
-	top->total_len = 0;
-	strbuf_init(&top->value, 1024);
-	strbuf_init(&top->var, 1024);
-	kvi_from_source(top, scope, &kvi);
-
-	ret = git_parse_source(top, fn, &kvi, data, opts);
-
-	strbuf_release(&top->value);
-	strbuf_release(&top->var);
-
-	return ret;
-}
-
-static int do_config_from_file(config_fn_t fn,
-			       const enum config_origin_type origin_type,
-			       const char *name, const char *path, FILE *f,
-			       void *data, enum config_scope scope,
-			       const struct config_parse_options *opts)
-{
-	struct config_source top = CONFIG_SOURCE_INIT;
-	int ret;
-
-	top.u.file = f;
-	top.origin_type = origin_type;
-	top.name = name;
-	top.path = path;
-	top.do_fgetc = config_file_fgetc;
-	top.do_ungetc = config_file_ungetc;
-	top.do_ftell = config_file_ftell;
-
-	flockfile(f);
-	ret = do_config_from(&top, fn, data, scope, opts);
-	funlockfile(f);
-	return ret;
-}
-
-static int git_config_from_stdin(config_fn_t fn, void *data,
-				 enum config_scope scope,
-				 const struct config_parse_options *config_opts)
-{
-	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
-				   data, scope, config_opts);
-}
-
-int git_config_from_file_with_options(config_fn_t fn, const char *filename,
-				      void *data, enum config_scope scope,
-				      const struct config_parse_options *opts)
-{
-	int ret = -1;
-	FILE *f;
-
-	if (!filename)
-		BUG("filename cannot be NULL");
-	f = fopen_or_warn(filename, "r");
-	if (f) {
-		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
-					  filename, f, data, scope, opts);
-		fclose(f);
-	}
-	return ret;
-}
-
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
@@ -2057,27 +1496,6 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 						 CONFIG_SCOPE_UNKNOWN, &config_opts);
 }
 
-int git_config_from_mem(config_fn_t fn,
-			const enum config_origin_type origin_type,
-			const char *name, const char *buf, size_t len,
-			void *data, enum config_scope scope,
-			const struct config_parse_options *opts)
-{
-	struct config_source top = CONFIG_SOURCE_INIT;
-
-	top.u.buf.buf = buf;
-	top.u.buf.len = len;
-	top.u.buf.pos = 0;
-	top.origin_type = origin_type;
-	top.name = name;
-	top.path = NULL;
-	top.do_fgetc = config_buf_fgetc;
-	top.do_ungetc = config_buf_ungetc;
-	top.do_ftell = config_buf_ftell;
-
-	return do_config_from(&top, fn, data, scope, opts);
-}
-
 int git_config_from_blob_oid(config_fn_t fn,
 			      const char *name,
 			      struct repository *repo,
diff --git a/config.h b/config.h
index 8ad399580f..3bad5e1c32 100644
--- a/config.h
+++ b/config.h
@@ -4,7 +4,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "repository.h"
-
+#include "config-parse.h"
 
 /**
  * The config API gives callers a way to access Git configuration files
@@ -23,9 +23,6 @@
 
 struct object_id;
 
-/* git_config_parse_key() returns these negated: */
-#define CONFIG_INVALID_KEY 1
-#define CONFIG_NO_SECTION_OR_NAME 2
 /* git_config_set_gently(), git_config_set_multivar_gently() return the above or these: */
 #define CONFIG_NO_LOCK -1
 #define CONFIG_INVALID_FILE 3
@@ -36,17 +33,6 @@ struct object_id;
 
 #define CONFIG_REGEX_NONE ((void *)1)
 
-enum config_scope {
-	CONFIG_SCOPE_UNKNOWN = 0,
-	CONFIG_SCOPE_SYSTEM,
-	CONFIG_SCOPE_GLOBAL,
-	CONFIG_SCOPE_LOCAL,
-	CONFIG_SCOPE_WORKTREE,
-	CONFIG_SCOPE_COMMAND,
-	CONFIG_SCOPE_SUBMODULE,
-};
-const char *config_scope_name(enum config_scope scope);
-
 struct git_config_source {
 	unsigned int use_stdin:1;
 	const char *file;
@@ -54,46 +40,6 @@ struct git_config_source {
 	enum config_scope scope;
 };
 
-enum config_origin_type {
-	CONFIG_ORIGIN_UNKNOWN = 0,
-	CONFIG_ORIGIN_BLOB,
-	CONFIG_ORIGIN_FILE,
-	CONFIG_ORIGIN_STDIN,
-	CONFIG_ORIGIN_SUBMODULE_BLOB,
-	CONFIG_ORIGIN_CMDLINE
-};
-
-enum config_event_t {
-	CONFIG_EVENT_SECTION,
-	CONFIG_EVENT_ENTRY,
-	CONFIG_EVENT_WHITESPACE,
-	CONFIG_EVENT_COMMENT,
-	CONFIG_EVENT_EOF,
-	CONFIG_EVENT_ERROR
-};
-
-struct config_source;
-/*
- * The parser event function (if not NULL) is called with the event type and
- * the begin/end offsets of the parsed elements.
- *
- * Note: for CONFIG_EVENT_ENTRY (i.e. config variables), the trailing newline
- * character is considered part of the element.
- */
-typedef int (*config_parser_event_fn_t)(enum config_event_t type,
-					size_t begin_offset, size_t end_offset,
-					struct config_source *cs,
-					void *event_fn_data);
-
-struct config_parse_options {
-	/*
-	 * event_fn and event_fn_data are for internal use only. Handles events
-	 * emitted by the config parser.
-	 */
-	config_parser_event_fn_t event_fn;
-	void *event_fn_data;
-};
-
 #define CP_OPTS_INIT(error_action) { \
 	.event_fn = git_config_err_fn, \
 	.event_fn_data = (enum config_error_action []){(error_action)}, \
@@ -126,59 +72,8 @@ enum config_error_action {
 int git_config_err_fn(enum config_event_t type, size_t begin_offset,
 		      size_t end_offset, struct config_source *cs,
 		      void *event_fn_data);
-
-/* Config source metadata for a given config key-value pair */
-struct key_value_info {
-	const char *filename;
-	int linenr;
-	enum config_origin_type origin_type;
-	enum config_scope scope;
-	const char *path;
-};
-#define KVI_INIT { \
-	.filename = NULL, \
-	.linenr = -1, \
-	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
-	.scope = CONFIG_SCOPE_UNKNOWN, \
-	.path = NULL, \
-}
-
-/* Captures additional information that a config callback can use. */
-struct config_context {
-	/* Config source metadata for key and value. */
-	const struct key_value_info *kvi;
-};
-#define CONFIG_CONTEXT_INIT { 0 }
-
-/**
- * A config callback function takes four parameters:
- *
- * - the name of the parsed variable. This is in canonical "flat" form: the
- *   section, subsection, and variable segments will be separated by dots,
- *   and the section and variable segments will be all lowercase. E.g.,
- *   `core.ignorecase`, `diff.SomeType.textconv`.
- *
- * - the value of the found variable, as a string. If the variable had no
- *   value specified, the value will be NULL (typically this means it
- *   should be interpreted as boolean true).
- *
- * - the 'config context', that is, additional information about the config
- *   iteration operation provided by the config machinery. For example, this
- *   includes information about the config source being parsed (e.g. the
- *   filename).
- *
- * - a void pointer passed in by the caller of the config API; this can
- *   contain callback-specific data
- *
- * A config callback should return 0 for success, or -1 if the variable
- * could not be parsed properly.
- */
-typedef int (*config_fn_t)(const char *, const char *,
-			   const struct config_context *, void *);
-
 int git_default_config(const char *, const char *,
 		       const struct config_context *, void *);
-
 /**
  * Read a specific file in git-config format.
  * This function takes the same callback and data parameters as `git_config`.
@@ -186,16 +81,6 @@ int git_default_config(const char *, const char *,
  * Unlike git_config(), this function does not respect includes.
  */
 int git_config_from_file(config_fn_t fn, const char *, void *);
-
-int git_config_from_file_with_options(config_fn_t fn, const char *,
-				      void *, enum config_scope,
-				      const struct config_parse_options *);
-int git_config_from_mem(config_fn_t fn,
-			const enum config_origin_type,
-			const char *name,
-			const char *buf, size_t len,
-			void *data, enum config_scope scope,
-			const struct config_parse_options *opts);
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     struct repository *repo,
 			     const struct object_id *oid, void *data,
@@ -333,8 +218,6 @@ int repo_config_set_worktree_gently(struct repository *, const char *, const cha
  */
 void git_config_set(const char *, const char *);
 
-int git_config_parse_key(const char *, char **, size_t *);
-
 /*
  * The following macros specify flag bits that alter the behavior
  * of the git_config_set_multivar*() methods.
-- 
2.42.0.rc1.204.g551eb34607-goog

