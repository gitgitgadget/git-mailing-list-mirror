Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556DC1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeDCQ2m (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:33321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbeDCQ2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:39 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M9b4B-1fEdBx0vst-00D3Hu; Tue, 03 Apr 2018 18:28:30 +0200
Date:   Tue, 3 Apr 2018 18:28:29 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 08/15] config: introduce an optional event stream while
 parsing
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <a38025bcbc07b83b578ff2f1cde786bdca0c918c.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eKIi8Q4vZcnYbt0bJ9Ilw0PyEmwihb0X+XVy2fl1SNdj5vCdULk
 iF9MFoVojvJe2ZAtYT0El9ysjtMLfXitkZIZz7bY/fLwHVMn9nTiVktvJIXTYbc5Wr4G5PV
 PaHzook5HUG6we4OWcFwqW4yWUP0BFGopGByRJXLAyMTBuoSMpZFnzeL7FQG1PdMioM11qt
 4/9FSDfVCbKswyKHZYsUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:68vccKoalgU=:AKpOcPMC7a8bh3S6yHKB2A
 jOO6UhxAucnM/ttwSV+/1IyDwjMNfrjUHjn9+b6Ph+BisySdmVkMllf8/j61/NlJWBKfzlK4r
 oNpS+1xnswfNk7Nb8d7f0iqwCU6l604yWJQtXB0aIKBN6dMAjbtjZC/EFwR4rEKiStDYScyxR
 VTOUJLI9e661MNaNeK5PFabiawaoG2+krspiL/zxixYkaziAv3L/Mb+wFft2PQdwfiQPESYnm
 KwGn++Jr7DyVm+b2FadXKfD4cbF/WSVjPyUdCKlpbwHHakqfJ0/W++kU4/oVkJwif6xAAGN/9
 /z0Zg2e7P4pCvymmELV3hzMIw/i0lDvNC+cAEZ662/BrqVueg8APjVbKeQOcU5srcBeqeK5fp
 mqH/xiBRHPC3PK/ocSq7Fxr9TQCo5Fl5YdqH10LLfCFEKE7zfihIvRixUP/1H3n4Uf4nOWAeq
 arG0hUapMxA53mRQKN42Uqk8RIG+RhBCax4rQgXNmxhvWSccLT3DgEX9BxzEL7hE+yfrWTF90
 fRsK7VKFiIsQnzi4KP01ePPwHCnOt4PgCmBz9aEve1PAqNDffNQqi/KH/S8jjme4Yt8y+kEIe
 byWuLyd+KvbooiC6nDVer2sVmLpbvVPN0Giml1FmsKVu9e8RQoaKyVZAyX3QH3IM5lxXYJXVU
 vTIZHEGRGeFsNQ/pfoEr6hdVXTEZWirss7t10UCtpTHpcG1qTdMiyWMkbc3LVlrg+AmxciMC5
 eQmJ+LgRSVM9Xl4pmS/JukfQrAgcvTJ3g17fVBvXdwidKZ1uLWhikHl7t2/oPOfh/QTf5kjGB
 mmWiiRJ+4cvi4ddTUGSQ9+Y3ywPvafKnmegt8YwJImi31oeDwtNHFlOY2OeeTkJBfIJpxXJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This extends our config parser so that it can optionally produce an event
stream via callback function, where it reports e.g. when a comment was
parsed, or a section header, etc.

This parser will be used subsequently to handle the scenarios better where
removing config entries would make sections empty, or where a new entry
could be added to an already-existing, empty section.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 config.h |  25 ++++++++++++++++
 2 files changed, 115 insertions(+), 12 deletions(-)

diff --git a/config.c b/config.c
index f10f8c6f52f..4cd745f6628 100644
--- a/config.c
+++ b/config.c
@@ -653,7 +653,46 @@ static int get_base_var(struct strbuf *name)
 	}
 }
 
-static int git_parse_source(config_fn_t fn, void *data)
+struct parse_event_data {
+	enum config_event_t previous_type;
+	size_t previous_offset;
+	const struct config_options *opts;
+};
+
+static inline int do_event(enum config_event_t type,
+			   struct parse_event_data *data)
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
+	offset = cf->do_ftell(cf);
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
+				 offset, data->opts->event_fn_data) < 0)
+		return -1;
+
+	data->previous_type = type;
+	data->previous_offset = offset;
+
+	return 0;
+}
+
+static int git_parse_source(config_fn_t fn, void *data,
+			    const struct config_options *opts)
 {
 	int comment = 0;
 	int baselen = 0;
@@ -664,8 +703,15 @@ static int git_parse_source(config_fn_t fn, void *data)
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
 
+	/* For the parser event callback */
+	struct parse_event_data event_data = {
+		CONFIG_EVENT_EOF, 0, opts
+	};
+
 	for (;;) {
-		int c = get_next_char();
+		int c;
+
+		c = get_next_char();
 		if (bomptr && *bomptr) {
 			/* We are at the file beginning; skip UTF8-encoded BOM
 			 * if present. Sane editors won't put this in on their
@@ -682,18 +728,33 @@ static int git_parse_source(config_fn_t fn, void *data)
 			}
 		}
 		if (c == '\n') {
-			if (cf->eof)
+			if (cf->eof) {
+				if (do_event(CONFIG_EVENT_EOF, &event_data) < 0)
+					return -1;
 				return 0;
+			}
+			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+				return -1;
 			comment = 0;
 			continue;
 		}
-		if (comment || isspace(c))
+		if (comment)
 			continue;
+		if (isspace(c)) {
+			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
+					return -1;
+			continue;
+		}
 		if (c == '#' || c == ';') {
+			if (do_event(CONFIG_EVENT_COMMENT, &event_data) < 0)
+					return -1;
 			comment = 1;
 			continue;
 		}
 		if (c == '[') {
+			if (do_event(CONFIG_EVENT_SECTION, &event_data) < 0)
+					return -1;
+
 			/* Reset prior to determining a new stem */
 			strbuf_reset(var);
 			if (get_base_var(var) < 0 || var->len < 1)
@@ -704,6 +765,10 @@ static int git_parse_source(config_fn_t fn, void *data)
 		}
 		if (!isalpha(c))
 			break;
+
+		if (do_event(CONFIG_EVENT_ENTRY, &event_data) < 0)
+			return -1;
+
 		/*
 		 * Truncate the var name back to the section header
 		 * stem prior to grabbing the suffix part of the name
@@ -715,6 +780,9 @@ static int git_parse_source(config_fn_t fn, void *data)
 			break;
 	}
 
+	if (do_event(CONFIG_EVENT_ERROR, &event_data) < 0)
+		return -1;
+
 	switch (cf->origin_type) {
 	case CONFIG_ORIGIN_BLOB:
 		error_msg = xstrfmt(_("bad config line %d in blob %s"),
@@ -1398,7 +1466,8 @@ int git_default_config(const char *var, const char *value, void *dummy)
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
+static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
+			  const struct config_options *opts)
 {
 	int ret;
 
@@ -1410,7 +1479,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 	strbuf_init(&top->var, 1024);
 	cf = top;
 
-	ret = git_parse_source(fn, data);
+	ret = git_parse_source(fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
@@ -1423,7 +1492,7 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 static int do_config_from_file(config_fn_t fn,
 		const enum config_origin_type origin_type,
 		const char *name, const char *path, FILE *f,
-		void *data)
+		void *data, const struct config_options *opts)
 {
 	struct config_source top;
 
@@ -1436,15 +1505,18 @@ static int do_config_from_file(config_fn_t fn,
 	top.do_ungetc = config_file_ungetc;
 	top.do_ftell = config_file_ftell;
 
-	return do_config_from(&top, fn, data);
+	return do_config_from(&top, fn, data, opts);
 }
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data);
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
+				   data, NULL);
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+int git_config_from_file_with_options(config_fn_t fn, const char *filename,
+				      void *data,
+				      const struct config_options *opts)
 {
 	int ret = -1;
 	FILE *f;
@@ -1452,13 +1524,19 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	f = fopen_or_warn(filename, "r");
 	if (f) {
 		flockfile(f);
-		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
+		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
+					  filename, f, data, opts);
 		funlockfile(f);
 		fclose(f);
 	}
 	return ret;
 }
 
+int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+{
+	return git_config_from_file_with_options(fn, filename, data, NULL);
+}
+
 int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_type,
 			const char *name, const char *buf, size_t len, void *data)
 {
@@ -1475,7 +1553,7 @@ int git_config_from_mem(config_fn_t fn, const enum config_origin_type origin_typ
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&top, fn, data);
+	return do_config_from(&top, fn, data, NULL);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
diff --git a/config.h b/config.h
index ef70a9cac1e..5a2394daae2 100644
--- a/config.h
+++ b/config.h
@@ -28,15 +28,40 @@ enum config_origin_type {
 	CONFIG_ORIGIN_CMDLINE
 };
 
+enum config_event_t {
+	CONFIG_EVENT_SECTION,
+	CONFIG_EVENT_ENTRY,
+	CONFIG_EVENT_WHITESPACE,
+	CONFIG_EVENT_COMMENT,
+	CONFIG_EVENT_EOF,
+	CONFIG_EVENT_ERROR
+};
+
+/*
+ * The parser event function (if not NULL) is called with the event type and
+ * the begin/end offsets of the parsed elements.
+ *
+ * Note: for CONFIG_EVENT_ENTRY (i.e. config variables), the trailing newline
+ * character is considered part of the element.
+ */
+typedef int (*config_parser_event_fn_t)(enum config_event_t type,
+					size_t begin_offset, size_t end_offset,
+					void *event_fn_data);
+
 struct config_options {
 	unsigned int respect_includes : 1;
 	const char *commondir;
 	const char *git_dir;
+	config_parser_event_fn_t event_fn;
+	void *event_fn_data;
 };
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_from_file_with_options(config_fn_t fn, const char *,
+					     void *,
+					     const struct config_options *);
 extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
 extern int git_config_from_blob_oid(config_fn_t fn, const char *name,
-- 
2.16.2.windows.1.26.g2cc3565eb4b


