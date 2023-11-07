Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B4E20E8
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoNZOEaw"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E420D51
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:09 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40839807e82so31379925e9.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320367; x=1699925167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/ky/3AXZvzs39bJrJJY3vV8N3LWOoVZM5pazlpvi0g=;
        b=GoNZOEawLlBlEbtDj8QHBQDd+vUVQu160ApArh2MPZgmMePSL9wQGQQnKg5S/OBGcv
         QLLIipcJUCiHt5iyGTgLJ7aQ2o4bb7xLHOVJtx6qIxpy+4E1R+9l5FaFGScBZowEGW0E
         l8wUHvcWLAXgMFIYKnlfcwqZcZ/jd62QI2R+ftjDvlXVfzULCPxX07arEy+wQpxJvJog
         7KOXklthm2DC+rAK8EHMTTocf5SB61+xWi1xUgcBDij4Ob7dW6XldZLdTmxI917CJjsM
         L7LMfFmPsUjTeC3Z+2zL/VwhWTc0kEVE5Dn6zBgQK+0rkZCIYkfIWAr5wd33BYfu6/OQ
         TRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320367; x=1699925167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/ky/3AXZvzs39bJrJJY3vV8N3LWOoVZM5pazlpvi0g=;
        b=qEf6Wj4wOLxfrO9UmD9+FhbnuONC15wRuzeO/g5cfMnBjVFCeVusCC3yqqdUVsxInT
         ZlkrYPM9cereC95h4toqcQ9AO1/fgi/TRv4wWxF65KrdNdqaTu8tZa677k0JF04m6J5Q
         jlefNfBkugITV1N+iaoulMbHqKuJ3ngiKhmb7Kk0Dcugz2gvipVvvc4CnloXHY4uQyKI
         HoRxq0EAXsImgVKLjLzykxW/dF2yzmqHo5AnBvY2YaOu2CZH8O0QBLG34z4aVXrxH5iv
         Cn8V3rR7Rew3FsQsYK3v9ozAgc6KCJOGmOxu9xg8Ezwlq4KwCkUUmtnEr9J9VlUjaup5
         Wt0Q==
X-Gm-Message-State: AOJu0YxR1yXralL5yBIgzcz5XFOmZMMuLC2DzKjU8h/r6gdREfKzzDWZ
	YRvHY7tJJ/cnw5gzIKIZNsVEZtccTi4=
X-Google-Smtp-Source: AGHT+IGOEMzn3TVaJd56EJ5qzWyRbYM5R6Zhsl/WmcrznuV1GLu5F82/XoSZ8tM+XkHOIPdmw1ymyw==
X-Received: by 2002:a05:600c:3c97:b0:406:5a14:5c1e with SMTP id bg23-20020a05600c3c9700b004065a145c1emr1343783wmb.1.1699320366828;
        Mon, 06 Nov 2023 17:26:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c450a00b004064cd71aa8sm13907368wmo.34.2023.11.06.17.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:06 -0800 (PST)
Message-ID: <2e2f9738205f732c2e640fd9a7183d16d0bf7f00.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:55 +0000
Subject: [PATCH 3/9] ref-filter.h: add max_count and omit_empty to ref_format
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add an internal 'array_opts' struct to 'struct ref_format' containing
formatting options that pertain to the formatting of an entire ref array:
'max_count' and 'omit_empty'. These values are specified by the '--count'
and '--omit-empty' options, respectively, to 'for-each-ref'/'tag'/'branch'.
Storing these values in the 'ref_format' will simplify the consolidation of
ref array formatting logic across builtins in later patches.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/branch.c       |  5 ++---
 builtin/for-each-ref.c | 21 +++++++++++----------
 builtin/tag.c          |  5 ++---
 ref-filter.h           |  5 +++++
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d67738bbcaa..5a1ec1cd04f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -45,7 +45,6 @@ static const char *head;
 static struct object_id head_oid;
 static int recurse_submodules = 0;
 static int submodule_propagate_branches = 0;
-static int omit_empty = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -480,7 +479,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 			string_list_append(output, out.buf);
 		} else {
 			fwrite(out.buf, 1, out.len, stdout);
-			if (out.len || !omit_empty)
+			if (out.len || !format->array_opts.omit_empty)
 				putchar('\n');
 		}
 	}
@@ -737,7 +736,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
-		OPT_BOOL(0, "omit-empty",  &omit_empty,
+		OPT_BOOL(0, "omit-empty",  &format.array_opts.omit_empty,
 			N_("do not output a newline after empty formatted refs")),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 93b370f550b..881c3ee055f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -19,10 +19,10 @@ static char const * const for_each_ref_usage[] = {
 
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	int i, total;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
-	int maxcount = 0, icase = 0, omit_empty = 0;
+	int icase = 0;
 	struct ref_array array;
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -40,11 +40,11 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
 		OPT_BIT(0 , "tcl",  &format.quote_style,
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
-		OPT_BOOL(0, "omit-empty",  &omit_empty,
+		OPT_BOOL(0, "omit-empty",  &format.array_opts.omit_empty,
 			N_("do not output a newline after empty formatted refs")),
 
 		OPT_GROUP(""),
-		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
+		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
@@ -71,8 +71,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	string_list_append(&sorting_options, "refname");
 
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
-	if (maxcount < 0) {
-		error("invalid --count argument: `%d'", maxcount);
+	if (format.array_opts.max_count < 0) {
+		error("invalid --count argument: `%d'", format.array_opts.max_count);
 		usage_with_options(for_each_ref_usage, opts);
 	}
 	if (HAS_MULTI_BITS(format.quote_style)) {
@@ -109,15 +109,16 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	ref_array_sort(sorting, &array);
 
-	if (!maxcount || array.nr < maxcount)
-		maxcount = array.nr;
-	for (i = 0; i < maxcount; i++) {
+	total = format.array_opts.max_count;
+	if (!total || array.nr < total)
+		total = array.nr;
+	for (i = 0; i < total; i++) {
 		strbuf_reset(&err);
 		strbuf_reset(&output);
 		if (format_ref_array_item(array.items[i], &format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
-		if (output.len || !omit_empty)
+		if (output.len || !format.array_opts.omit_empty)
 			putchar('\n');
 	}
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 64f3196cd4c..2d599245d48 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -44,7 +44,6 @@ static const char * const git_tag_usage[] = {
 static unsigned int colopts;
 static int force_sign_annotate;
 static int config_sign_tag = -1; /* unspecified */
-static int omit_empty = 0;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
@@ -83,7 +82,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		if (format_ref_array_item(array.items[i], format, &output, &err))
 			die("%s", err.buf);
 		fwrite(output.buf, 1, output.len, stdout);
-		if (output.len || !omit_empty)
+		if (output.len || !format->array_opts.omit_empty)
 			putchar('\n');
 	}
 
@@ -481,7 +480,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_WITHOUT(&filter.no_commit, N_("print only tags that don't contain the commit")),
 		OPT_MERGED(&filter, N_("print only tags that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only tags that are not merged")),
-		OPT_BOOL(0, "omit-empty",  &omit_empty,
+		OPT_BOOL(0, "omit-empty",  &format.array_opts.omit_empty,
 			N_("do not output a newline after empty formatted refs")),
 		OPT_REF_SORT(&sorting_options),
 		{
diff --git a/ref-filter.h b/ref-filter.h
index 1524bc463a5..d87d61238b7 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -92,6 +92,11 @@ struct ref_format {
 
 	/* List of bases for ahead-behind counts. */
 	struct string_list bases;
+
+	struct {
+		int max_count;
+		int omit_empty;
+	} array_opts;
 };
 
 #define REF_FILTER_INIT { \
-- 
gitgitgadget

