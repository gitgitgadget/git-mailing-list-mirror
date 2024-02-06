Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784678695
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196357; cv=none; b=WutqplBSa8nceUVQcozgS4T/U1ZEBvJB2MjWnBZHpTZ8FsIleywQFCLfbu6Dm9sYqyu+PCx9+vwhnh+EKn4rH3KYx/8+qHmomIR0wyYHV8eODQ/p3PwJ6BJW1L/8d5B1Rx0jo/P6ZhVolLm+jiRqjmTbWfyASp3s7vVmBjjgK8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196357; c=relaxed/simple;
	bh=avfyyuClJLJU2yE+T/eicbZ3hY9bhE4GunGon0T+5KA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k5UGOxJKZFNSSfhaK+26ti2utF/tGn79fYy+OmbV0Rx8vxqFaupt0rp+T4zGIneQK3N7dPdhHEereHGT8M8KYBjw/VeCD95IUYVImH8nX29wpGdAKT2pY5u4AXa5ZObIbCZwARUtZ2kstuxyz6Kur/Os9nmObZR74HkUuezefaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WROVa1xj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WROVa1xj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fe2e746bdso1728785e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196353; x=1707801153; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RlPQ7lvsukyjl8KrER6rCMtmPCthZw0L1uxO7Jp9gM=;
        b=WROVa1xjCdjf7iJ5vnQuBasVl9BndTNHNrvEqwP1Spg2TVwINYxrdSrloGCr5LeRhV
         bz7i7DWBHjP6K1hhF2AOdf1/d5GM0r+YfjMPMfRTnLM3HWQQ0OsVDWUATeY3X9kzc/EL
         7auSFuDn8ZwQh1hrafYUudp8ZLk06hNDI3+kQwDrUx3vAFyWjB4uwdNWrtvCTLYVPc0L
         HZkPUYl8IeMBEceTT/Jnll4JpaaYWQD1lKBOxHzoIriwXtyOEBRkiPE2P2KgL2PSIObG
         4cAI8LUidlPF41JfTyRKnbdhsJ7P7BPrSQlRhb2GaOMfcvG7Z9EZoaXqCMJbLo/Turct
         d1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196353; x=1707801153;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RlPQ7lvsukyjl8KrER6rCMtmPCthZw0L1uxO7Jp9gM=;
        b=KW0wHWZW5UaS85LJTerfD1ipFeG7z6zfefR7JEjRlZUm3NmSzKd/8Vx6HyyJbVFfAY
         0FJ9Jj+uG1Q0vw9Vp5YTozaiLKxZIGX/BqyT8l/JI8I94fKJOX1dG4M59YgZNcItcdQe
         vMp7AE2Dsl3tU3D/qmj7RlV43qpRmNoYvnCQHvSFHpbutEQhYAhuKmxVtIYl24SKD5B2
         teng+8HS+wOe73XmTMHy6KTKKbBkHzzps8++/JC8cfM1HDGPr4lMlgMs9aIcFI7YCMHf
         ZLCQYjo7F1+G8pkPuhC/wuazV2MRlWloWcMYIV15xrgEj54VOifNm1tBm1vOQ0PWBC1Z
         GB6A==
X-Gm-Message-State: AOJu0Yxs5pi8cI2iDUXUCD65s9pCqQISCVgqPzXGmbVDjsjuFTQ4pJqW
	6Rumo4iq1+Q4jKkxqRJD79ORjucCiBDhq6NQ+0uxCDj8loqrIe6w7RPyq8pL
X-Google-Smtp-Source: AGHT+IGzKATZlDMdCkVdW1GiSJibQJtECI4cdhRl4N/kOLKwKwSK5FAf/vS2hQl9ZNbUjxyokdOcqw==
X-Received: by 2002:a05:600c:46ce:b0:40f:e506:cc6d with SMTP id q14-20020a05600c46ce00b0040fe506cc6dmr182652wmo.14.1707196353428;
        Mon, 05 Feb 2024 21:12:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWF6/Nk9lczWslpFEg2g46oXnCoa/VYJOwkOkqCCBcKlFA37va7WC3WJIMb2BsiJStRMyup1vVUwBIYsKBtkVZBJPvJIPa1fSMEiH9RSAignfZgfax8gyiq2kj6eqCrnXyU9cGMPVs/LtPZv86hp3YkqCVovRvTAAyZQL6yuZiY9kZi2rwzIv9tZh8uDYN1wy5svF+64KUR/A==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0040e527602c8sm653898wmq.9.2024.02.05.21.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:31 -0800 (PST)
Message-ID: <4372af244f02b71cc70f3a8e1b5591b3b9fec93a.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:03 +0000
Subject: [PATCH v4 03/28] trailer: prepare to expose functions as part of API
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

