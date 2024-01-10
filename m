Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15C364C0
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYGhsrZQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so42398985e9.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869490; x=1705474290; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yOekFhHVVrew6cuTGAq2PPlVC/kLbfWTfBwN4Z1f8g=;
        b=cYGhsrZQpMLV6FCi4paCYYLjP1QJsWbIJndfC9Va3aPqLvm1WjLwTCZuj6ZRKHVfGv
         4C6qVbWOT1Aqjwy7utfhP0MbulC3fKood9Ejnk7riXRDvgVOKzlKi2K2e8Dtrmxtm5C7
         eBp9qs7cIs3tsXVAscbYD7MhY6XH7376zVfSY8s/JGr2tjMrvCzJCQU+M5JQUv2XhrGl
         MoPOES2lusdOhcFr4T62vO+ByDcGmydWXWWqhCBD2858ieMAf6snrF8OkJyMmtTGhQtj
         puzJKdYa2mONO9JuHdVUxFJg8ehpD7bAZipwyCR0q604g38W3OI01SloJkSdEaDoMbF+
         LYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869490; x=1705474290;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yOekFhHVVrew6cuTGAq2PPlVC/kLbfWTfBwN4Z1f8g=;
        b=FSrxWAVBSrUtdSJHENXzvIvTH+NFtEZg8l0dYF8IVe4/+3TQeTc1MTSRB8o43JpSdw
         B7mS84avqY7u4b+bQEqGXO7QBf/fAwC75Hr5boxXn89Paywwx4ezIauaCeFMkx84plgA
         c8BEP4N7c2N3Mc9xHWwinaSm25mZndbORczFxBqNShfXx1o5uXRFXbcu95YWOq4iafGc
         gkTOnqFoqDImEX9j/Dul1sBtxq2y65yqoErihGDQ12qfwkgkajFESv+N4PYK1Bg7/jjS
         Xdm7avfVNJ9bkakPjzKQijFOtO+H5Xw0BmNipqBKPP6+Dwi1gFKqCZSbXSIVOvjDRbg2
         2NPQ==
X-Gm-Message-State: AOJu0Yx8uilQRjMvWFm6FXtI0aJCiYJHn0UI0bMaxrfBITIlViwAFRP+
	cAXM+BgbSlyi/8KPXq6rwI2d3g5DqLQ=
X-Google-Smtp-Source: AGHT+IFloJtW67+rOeg78LR4BOahuIioT10vmro2VOqz+zfIi++K6CHyW63sygeNIu3bFbO3Em1VAA==
X-Received: by 2002:a05:600c:4445:b0:40e:4386:11c6 with SMTP id v5-20020a05600c444500b0040e438611c6mr268696wmn.13.1704869490291;
        Tue, 09 Jan 2024 22:51:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b0040d62f97e3csm1006449wmq.10.2024.01.09.22.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:29 -0800 (PST)
Message-ID: <5f64718abfc2e61b4e259de700c137bc817fbb1c.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:18 +0000
Subject: [PATCH 02/10] trailer: include "trailer" term in API functions
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
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

These functions are exposed to clients and so they should include
"trailer" in their names for easier identification, just like all the
other functions already exposed by trailer.h.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  7 ++++---
 trailer.c                    | 10 +++++-----
 trailer.h                    | 10 +++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 444f8fb70c9..adb74276281 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -143,7 +143,7 @@ static void interpret_trailers(const char *file,
 	struct trailer_info info;
 	FILE *outfile = stdout;
 
-	ensure_configured();
+	trailer_config_init();
 
 	read_input_file(&sb, file);
 
@@ -169,9 +169,10 @@ static void interpret_trailers(const char *file,
 		process_trailers_lists(&head, &arg_head);
 	}
 
-	print_all(outfile, &head, opts);
+	/* Print trailer block. */
+	format_trailers(outfile, &head, opts);
 
-	free_all(&head);
+	free_trailers(&head);
 	trailer_info_release(&info);
 
 	/* Print the lines after the trailers as is */
diff --git a/trailer.c b/trailer.c
index 9d70c9946bd..0ce7e9079ca 100644
--- a/trailer.c
+++ b/trailer.c
@@ -162,8 +162,8 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-void print_all(FILE *outfile, struct list_head *head,
-	       const struct process_trailer_options *opts)
+void format_trailers(FILE *outfile, struct list_head *head,
+		     const struct process_trailer_options *opts)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -588,7 +588,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	return 0;
 }
 
-void ensure_configured(void)
+void trailer_config_init(void)
 {
 	if (configured)
 		return;
@@ -1023,7 +1023,7 @@ void parse_trailers(struct trailer_info *info,
 	}
 }
 
-void free_all(struct list_head *head)
+void free_trailers(struct list_head *head)
 {
 	struct list_head *pos, *p;
 	list_for_each_safe(pos, p, head) {
@@ -1041,7 +1041,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	size_t nr = 0, alloc = 0;
 	char **last = NULL;
 
-	ensure_configured();
+	trailer_config_init();
 
 	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
 	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
diff --git a/trailer.h b/trailer.h
index b3e4a5e127d..0e4f0ece9b3 100644
--- a/trailer.h
+++ b/trailer.h
@@ -99,11 +99,11 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 void trailer_info_release(struct trailer_info *info);
 
-void ensure_configured(void);
-void print_all(FILE *outfile, struct list_head *head,
-	       const struct process_trailer_options *opts);
-void free_all(struct list_head *head);
+void trailer_config_init(void);
+void free_trailers(struct list_head *trailers);
 
+void format_trailers(FILE *outfile, struct list_head *head,
+		     const struct process_trailer_options *opts);
 /*
  * Format the trailers from the commit msg "msg" into the strbuf "out".
  * Note two caveats about "opts":
@@ -111,7 +111,7 @@ void free_all(struct list_head *head);
  *   - this is primarily a helper for pretty.c, and not
  *     all of the flags are supported.
  *
- *   - this differs from process_trailers slightly in that we always format
+ *   - this differs from format_trailers slightly in that we always format
  *     only the trailer block itself, even if the "only_trailers" option is not
  *     set.
  */
-- 
gitgitgadget

