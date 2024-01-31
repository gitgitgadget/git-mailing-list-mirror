Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD24C80
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664152; cv=none; b=Gynvxm6qB6PxuxwzGgyOIt71mfM0g+XY5obgnoEcQlaCN17prSjjfSkvZft6Wc7qXN6lBXfbJubFJyl4UZs0N+YjkY9hIh7frO/sW+YcmdZsPxc4tj2CbKTOr4c4WDhkG//gdsY4wwjC41FTz7M2+TnjdNRwemWE9xVsIAAmmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664152; c=relaxed/simple;
	bh=fMCXjUdyuhLJ4Gc+7eaxYHB0c9IDPxQolPg/NHgAE+U=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XTBrucfCHQK2MA/bHnly4RdMfRDjYd8gqXC17fw1rmOduMMFtREhbgspOG9PXSfGCUXvF1IpZBnCVwO8VsZCYOL52wNUaL0BdRosGpqC0Ar+D30glzVm1XFh179QIyllH9FvEtLZlw/TVHUNQ6QRtTI3RB0M6D0G3xHkFQxwADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2IPT1aG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2IPT1aG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ae3cc8a70so2626313f8f.0
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664148; x=1707268948; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpojQAaKlGmHiZEzjwkMhzKZt4+nX45Mkg/XBEC8eJM=;
        b=P2IPT1aGGV0j1fS0GOPLVAFpPZgWOnEPA2cmYhH/QAFsAZB1y3RYwkHdyOG6i7ofgf
         /9xRTUQk/BpexglG8FZBSgROZuaIyAzg0N7RJryXM6BAkW7Wul/BpQcn+ooSEUKjWrB0
         YAyd2CvL2MnKWnsJGq7yKEUPamXvSzQj7E/KTE9kqy67znmEcc6AVC1IVcLS4ZRyqR/4
         oQ+RI4U2WzkWo0TpUUGdk6DLUJzSfC8BPD/f1RqOh2RmA7lD1XUSfgXOLQ5Rl4dv7L3Z
         ZmJ91rPhID3QDRi89RG2z7tFtWgMT88Ln2ttkFqcsOpFieDwIWBPz4hW01J3U4YI3H3q
         aCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664148; x=1707268948;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpojQAaKlGmHiZEzjwkMhzKZt4+nX45Mkg/XBEC8eJM=;
        b=hTiJh/ufygTnHRdjUl5hh9GdiPZMDYZ6CPkxQafk8nE/ANpmHvkHLpgdQcvQbyna7y
         2ob5FTSybk6VX0An619+VYQdtsGhBcsxs/t5vrmerKqBeOU/bvT9TyiQ7DY3rIO+F/A2
         sLLHNIwaG9vmpgdoOvm3wvTRmjbSKHfKKT3hZAfmvqLQ0a2jpwLPwAvxFCqOKe5YQVqN
         e7lziq8xKwKnUeqPptgeitUXxJHYGE8G5jkWhccGmboWe/BxHyomFSzWCCVs7C8sai+V
         qvbL4LVZkzjHy0JiFtgoTrCclBugv/4cMlb+w52yY7WPYz7wlje/w6bNR7WmVcXu02C6
         0aVg==
X-Gm-Message-State: AOJu0Yy0xTYHuLIiiK5I5ocRPBMX8QVg4NAur8pidoQOY5GDCC9KRpOT
	Zqfl041jy1yketx74xUZlxH/PNJK+dNwDSnkGTMFvu5SYzJq1bXmBQdCBmf9
X-Google-Smtp-Source: AGHT+IEGDL1dHyJRcXB8SxQ1QM9KCZXO/lMmLhr9dzbr9w4FMnadkwL1ufZsmqU7tM+SCxZlnpcEBQ==
X-Received: by 2002:adf:ec82:0:b0:33a:f1e7:f193 with SMTP id z2-20020adfec82000000b0033af1e7f193mr110895wrn.56.1706664148250;
        Tue, 30 Jan 2024 17:22:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0560001f8300b0033b00fe6e96sm692929wrb.14.2024.01.30.17.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:27 -0800 (PST)
Message-ID: <cafa39d10489f90897227a244e012457989a7710.1706664145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:16 +0000
Subject: [PATCH v3 02/10] trailer: move interpret_trailers() to
 interpret-trailers.c
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

The interpret-trailers.c builtin is the only place we need to call
interpret_trailers(), so move its definition there.

Delete the corresponding declaration from trailer.h, which then forces
us to expose the working innards of that function. This enriches
trailer.h with a more granular API, which can then be unit-tested in the
future (because interpret_trailers() by itself does too many things to
be able to be easily unit-tested).

Take this opportunity to demote some file-handling functions out of the
trailer API implementation, as these have nothing to do with trailers.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  94 +++++++++++++++++++++++++++
 trailer.c                    | 120 ++++-------------------------------
 trailer.h                    |  20 +++++-
 3 files changed, 124 insertions(+), 110 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 85a3413baf5..8556acde4aa 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -9,6 +9,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "tempfile.h"
 #include "trailer.h"
 #include "config.h"
 
@@ -91,6 +92,99 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static struct tempfile *trailers_tempfile;
+
+static FILE *create_in_place_tempfile(const char *file)
+{
+	struct stat st;
+	struct strbuf filename_template = STRBUF_INIT;
+	const char *tail;
+	FILE *outfile;
+
+	if (stat(file, &st))
+		die_errno(_("could not stat %s"), file);
+	if (!S_ISREG(st.st_mode))
+		die(_("file %s is not a regular file"), file);
+	if (!(st.st_mode & S_IWUSR))
+		die(_("file %s is not writable by user"), file);
+
+	/* Create temporary file in the same directory as the original */
+	tail = strrchr(file, '/');
+	if (tail)
+		strbuf_add(&filename_template, file, tail - file + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
+
+	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
+	strbuf_release(&filename_template);
+	outfile = fdopen_tempfile(trailers_tempfile, "w");
+	if (!outfile)
+		die_errno(_("could not open temporary file"));
+
+	return outfile;
+}
+
+static void read_input_file(struct strbuf *sb, const char *file)
+{
+	if (file) {
+		if (strbuf_read_file(sb, file, 0) < 0)
+			die_errno(_("could not read input file '%s'"), file);
+	} else {
+		if (strbuf_read(sb, fileno(stdin), 0) < 0)
+			die_errno(_("could not read from stdin"));
+	}
+}
+
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	LIST_HEAD(head);
+	struct strbuf sb = STRBUF_INIT;
+	struct trailer_info info;
+	FILE *outfile = stdout;
+
+	trailer_config_init();
+
+	read_input_file(&sb, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	parse_trailers(opts, &info, sb.buf, &head);
+
+	/* Print the lines before the trailers */
+	if (!opts->only_trailers)
+		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+
+	if (!opts->only_trailers && !info.blank_line_before_trailer)
+		fprintf(outfile, "\n");
+
+
+	if (!opts->only_input) {
+		LIST_HEAD(config_head);
+		LIST_HEAD(arg_head);
+		parse_trailers_from_config(&config_head);
+		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
+		list_splice(&config_head, &arg_head);
+		process_trailers_lists(&head, &arg_head);
+	}
+
+	format_trailers(opts, &head, outfile);
+
+	free_trailers(&head);
+	trailer_info_release(&info);
+
+	/* Print the lines after the trailers as is */
+	if (!opts->only_trailers)
+		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+
+	if (opts->in_place)
+		if (rename_tempfile(&trailers_tempfile, file))
+			die_errno(_("could not rename temporary file to %s"), file);
+
+	strbuf_release(&sb);
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
diff --git a/trailer.c b/trailer.c
index 66b6660f5a4..d3899195876 100644
--- a/trailer.c
+++ b/trailer.c
@@ -5,7 +5,6 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
-#include "tempfile.h"
 #include "trailer.h"
 #include "list.h"
 /*
@@ -163,8 +162,8 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void format_trailers(const struct process_trailer_options *opts,
-			    struct list_head *trailers, FILE *outfile)
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers, FILE *outfile)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -366,8 +365,8 @@ static int find_same_and_apply_arg(struct list_head *head,
 	return 0;
 }
 
-static void process_trailers_lists(struct list_head *head,
-				   struct list_head *arg_head)
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head)
 {
 	struct list_head *pos, *p;
 	struct arg_item *arg_tok;
@@ -589,7 +588,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	return 0;
 }
 
-static void trailer_config_init(void)
+void trailer_config_init(void)
 {
 	if (configured)
 		return;
@@ -719,7 +718,7 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 	list_add_tail(&new_item->list, arg_head);
 }
 
-static void parse_trailers_from_config(struct list_head *config_head)
+void parse_trailers_from_config(struct list_head *config_head)
 {
 	struct arg_item *item;
 	struct list_head *pos;
@@ -735,8 +734,8 @@ static void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-static void parse_trailers_from_command_line_args(struct list_head *arg_head,
-						  struct list_head *new_trailer_head)
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -775,17 +774,6 @@ static void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
-static void read_input_file(struct strbuf *sb, const char *file)
-{
-	if (file) {
-		if (strbuf_read_file(sb, file, 0) < 0)
-			die_errno(_("could not read input file '%s'"), file);
-	} else {
-		if (strbuf_read(sb, fileno(stdin), 0) < 0)
-			die_errno(_("could not read from stdin"));
-	}
-}
-
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
@@ -1000,10 +988,10 @@ static void unfold_value(struct strbuf *val)
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
  */
-static void parse_trailers(struct trailer_info *info,
-			     const char *str,
-			     struct list_head *head,
-			     const struct process_trailer_options *opts)
+void parse_trailers(const struct process_trailer_options *opts,
+		    struct trailer_info *info,
+		    const char *str,
+		    struct list_head *head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -1035,7 +1023,7 @@ static void parse_trailers(struct trailer_info *info,
 	}
 }
 
-static void free_trailers(struct list_head *trailers)
+void free_trailers(struct list_head *trailers)
 {
 	struct list_head *pos, *p;
 	list_for_each_safe(pos, p, trailers) {
@@ -1044,88 +1032,6 @@ static void free_trailers(struct list_head *trailers)
 	}
 }
 
-static struct tempfile *trailers_tempfile;
-
-static FILE *create_in_place_tempfile(const char *file)
-{
-	struct stat st;
-	struct strbuf filename_template = STRBUF_INIT;
-	const char *tail;
-	FILE *outfile;
-
-	if (stat(file, &st))
-		die_errno(_("could not stat %s"), file);
-	if (!S_ISREG(st.st_mode))
-		die(_("file %s is not a regular file"), file);
-	if (!(st.st_mode & S_IWUSR))
-		die(_("file %s is not writable by user"), file);
-
-	/* Create temporary file in the same directory as the original */
-	tail = strrchr(file, '/');
-	if (tail)
-		strbuf_add(&filename_template, file, tail - file + 1);
-	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
-
-	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
-	strbuf_release(&filename_template);
-	outfile = fdopen_tempfile(trailers_tempfile, "w");
-	if (!outfile)
-		die_errno(_("could not open temporary file"));
-
-	return outfile;
-}
-
-void interpret_trailers(const struct process_trailer_options *opts,
-			struct list_head *new_trailer_head,
-			const char *file)
-{
-	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct trailer_info info;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	parse_trailers(&info, sb.buf, &head, opts);
-
-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
-
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
-		fprintf(outfile, "\n");
-
-
-	if (!opts->only_input) {
-		LIST_HEAD(config_head);
-		LIST_HEAD(arg_head);
-		parse_trailers_from_config(&config_head);
-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
-		list_splice(&config_head, &arg_head);
-		process_trailers_lists(&head, &arg_head);
-	}
-
-	format_trailers(opts, &head, outfile);
-
-	free_trailers(&head);
-	trailer_info_release(&info);
-
-	/* Print the lines after the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-
-	if (opts->in_place)
-		if (rename_tempfile(&trailers_tempfile, file))
-			die_errno(_("could not rename temporary file to %s"), file);
-
-	strbuf_release(&sb);
-}
-
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
diff --git a/trailer.h b/trailer.h
index 37033e631a1..ca701c04f3b 100644
--- a/trailer.h
+++ b/trailer.h
@@ -81,15 +81,29 @@ struct process_trailer_options {
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
 
-void interpret_trailers(const struct process_trailer_options *opts,
-			struct list_head *new_trailer_head,
-			const char *file);
+void parse_trailers_from_config(struct list_head *config_head);
+
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head);
+
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head);
+
+void parse_trailers(const struct process_trailer_options *opts,
+		    struct trailer_info *info,
+		    const char *str,
+		    struct list_head *head);
 
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts);
 
 void trailer_info_release(struct trailer_info *info);
 
+void trailer_config_init(void);
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers, FILE *outfile);
+void free_trailers(struct list_head *);
+
 /*
  * Format the trailers from the commit msg "msg" into the strbuf "out".
  * Note two caveats about "opts":
-- 
gitgitgadget

