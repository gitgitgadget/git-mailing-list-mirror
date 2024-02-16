Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C41487C5
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124959; cv=none; b=XOGO0ugI2J7x4azsT8wEPdsuqT7kIEVthZIMGw/dUJG3E9YpJF6tqR5Gah+EwNpgF4F65yfVXwCtMk/11IJYtuOs0Re27MDWvZmlqhsLjhGH0+FyxCQzTz8QJuap709S3gwYP78hoA5pwOthkWUfe0U307id9xyauOjg1Bqfhdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124959; c=relaxed/simple;
	bh=avfyyuClJLJU2yE+T/eicbZ3hY9bhE4GunGon0T+5KA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X1pQYOJafIQdOOqqgSN+34KhDCGmT4Fe2yWD86OsQ12hzA3BkEHMF1PjPW9DMVhGPxdmDKfa3E3FqbPlU2V/PwHhVyPbnvsA8cLZnoAHemUhP+++JkRXZ2qx0Vf+ea4JSG/sQzbx3mCzcCiY/vpX5+V82j/lX8e+Ma3oV4BuAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqoxGQ3C; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqoxGQ3C"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so945825f8f.1
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124955; x=1708729755; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RlPQ7lvsukyjl8KrER6rCMtmPCthZw0L1uxO7Jp9gM=;
        b=IqoxGQ3C/61ryjKgb7jOH7MCr2kzH/XU/ZtGjc+Hon8s5pfpazQi54xC49VdfVZ6J4
         rD2hCL7jcso0yNzk1z5ykqR38qZ/iewkj+Wcu03xEdehV4VAfm1Jhm+WSBD71a0J3Tap
         sjexfiC//MTtKvhVa/RBIZW3d0AAHbKEH3VabOw8ahXI4nKQ6uIVWx0aozlxLZykoPN3
         jTlJIuvqw2BjhavKabtYXRMiQkrjXV90EZYTOF8jT5FoUdTcBGTDQDcfFFkn+m3XiaUB
         0Al/insdYGNiD9fm6zrCu90Gx6Ll8P3ILlsoHykWRxZdz3Bhr0SREJEYW0hRQqbh0fBM
         F8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124955; x=1708729755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RlPQ7lvsukyjl8KrER6rCMtmPCthZw0L1uxO7Jp9gM=;
        b=IiT7gOOP613P4xwB9oM0aHFv2TWKHnE/mimfupyJn4w4/sMNHA1ja8Miqk2QlvmVIx
         Bkjx4yg+06Dt2PYf38LzlFnGQTNmlKCNAuAjTi+LYaMtlCaKuFqQnkwsYN8JU2G51j58
         tU0exLlmwnyVVzD/4Omofy5PWx8TGznSw2+pWB34ImAz8CP3GArUq+TCSCtH5PRzLisf
         P064cO3KGQ9LjpfeDWzC+l8iCix13IrBwXTBtStOkHEDdMZv/25BOIv2fwB+Rfat6gPa
         mhjgifD1OZDqKR25ewI4xmQG/a7j3taAuhF89Xj9e0ODEFp2UuFnrTsWfd6advwxTRUK
         ZXqQ==
X-Gm-Message-State: AOJu0YyCWrwVNXGWBkF2RJ+09ktW+M4JqVSQar5wGIJLzeEqxnfkNrzB
	13PGledJN3I8qifa5sET13X8URAkuKIrb7FcMzadva0YA6tnj7mTDJzipvSm
X-Google-Smtp-Source: AGHT+IEpm0eARyutingpdSotzOBszoBWEGK5o8eE0tT16sbojViU/A7qSsjE4pfU4TlmFp96cf4fug==
X-Received: by 2002:a5d:5266:0:b0:33b:6585:9ab7 with SMTP id l6-20020a5d5266000000b0033b65859ab7mr4891545wrc.46.1708124955543;
        Fri, 16 Feb 2024 15:09:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600016c500b0033d200aff9asm2620473wrf.56.2024.02.16.15.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:14 -0800 (PST)
Message-ID: <4372af244f02b71cc70f3a8e1b5591b3b9fec93a.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:04 +0000
Subject: [PATCH v5 3/9] trailer: prepare to expose functions as part of API
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
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In the next patch, we will move "process_trailers" from trailer.c to
builtin/interpret-trailers.c. That move will necessitate the growth of
the trailer.h API, forcing us to expose some additional functions in
trailer.h.

Rename relevant functions so that they include the term "trailer" in
their name, so that clients of the API will be able to easily identify
them by their "trailer" moniker, just like all the other functions
already exposed by trailer.h.

Take the opportunity to start putting trailer processing options (opts)
as the first parameter. This will be the pattern going forward in this
series.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  4 ++--
 trailer.c                    | 26 +++++++++++++-------------
 trailer.h                    |  6 +++---
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 033bd1556cf..85a3413baf5 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -132,11 +132,11 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], &opts, &trailers);
+			interpret_trailers(&opts, &trailers, argv[i]);
 	} else {
 		if (opts.in_place)
 			die(_("no input file given for in-place editing"));
-		process_trailers(NULL, &opts, &trailers);
+		interpret_trailers(&opts, &trailers, NULL);
 	}
 
 	new_trailers_clear(&trailers);
diff --git a/trailer.c b/trailer.c
index f74915bd8cd..916175707d8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -163,12 +163,12 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(FILE *outfile, struct list_head *head,
-		      const struct process_trailer_options *opts)
+static void format_trailers(const struct process_trailer_options *opts,
+			    struct list_head *trailers, FILE *outfile)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
-	list_for_each(pos, head) {
+	list_for_each(pos, trailers) {
 		item = list_entry(pos, struct trailer_item, list);
 		if ((!opts->trim_empty || strlen(item->value) > 0) &&
 		    (!opts->only_trailers || item->token))
@@ -589,7 +589,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	return 0;
 }
 
-static void ensure_configured(void)
+static void trailer_config_init(void)
 {
 	if (configured)
 		return;
@@ -1035,10 +1035,10 @@ static void parse_trailers(struct trailer_info *info,
 	}
 }
 
-static void free_all(struct list_head *head)
+static void free_trailers(struct list_head *trailers)
 {
 	struct list_head *pos, *p;
-	list_for_each_safe(pos, p, head) {
+	list_for_each_safe(pos, p, trailers) {
 		list_del(pos);
 		free_trailer_item(list_entry(pos, struct trailer_item, list));
 	}
@@ -1075,16 +1075,16 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file,
-		      const struct process_trailer_options *opts,
-		      struct list_head *new_trailer_head)
+void interpret_trailers(const struct process_trailer_options *opts,
+			struct list_head *new_trailer_head,
+			const char *file)
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct trailer_info info;
 	FILE *outfile = stdout;
 
-	ensure_configured();
+	trailer_config_init();
 
 	read_input_file(&sb, file);
 
@@ -1110,8 +1110,8 @@ void process_trailers(const char *file,
 		process_trailers_lists(&head, &arg_head);
 	}
 
-	print_all(outfile, &head, opts);
-	free_all(&head);
+	format_trailers(opts, &head, outfile);
+	free_trailers(&head);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
@@ -1134,7 +1134,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 	size_t nr = 0, alloc = 0;
 	char **last = NULL;
 
-	ensure_configured();
+	trailer_config_init();
 
 	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
 	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
diff --git a/trailer.h b/trailer.h
index 1644cd05f60..37033e631a1 100644
--- a/trailer.h
+++ b/trailer.h
@@ -81,9 +81,9 @@ struct process_trailer_options {
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
 
-void process_trailers(const char *file,
-		      const struct process_trailer_options *opts,
-		      struct list_head *new_trailer_head);
+void interpret_trailers(const struct process_trailer_options *opts,
+			struct list_head *new_trailer_head,
+			const char *file);
 
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts);
-- 
gitgitgadget

