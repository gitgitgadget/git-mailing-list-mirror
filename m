Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A02CA6B
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664158; cv=none; b=k2MBMylzLJA84qFMlUcjp9c8XxrFBVNFspdXphidXsfcOrS9faRlJX2tlg8qoONq11fAtFP9A/5SUu2XLiAl9SWBSV58bUzXlPhwO9BBTCCLv4H/gvY+kJlq3Tugf2nOtMwU6onCimHak9ghTxpfbhuVP4pkj9zkdjolrLeboXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664158; c=relaxed/simple;
	bh=bheY8jwd4eNKrHEWKOvW6xsXh6q/pA3jECH3KqCcdVg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ogJ/P52xcXzUkzzbYGgfktUfq9IkjVDESpoeYt66Ofjt8RHQe2DUZk3y8dW5/1Y1qLnzhkxAr7nJnnq0bcQZSi9Iah812eAile7loIS2NEnnGnyt8VYF0NRsT9EB+zE2/EtCmrrElJabbSmQZ99GI/0YSwMdBJFrMCilvg/5fZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axX/0btG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axX/0btG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb44a9520so987775e9.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706664155; x=1707268955; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Auh6su970Zkwu/bwSWwLWungbSH25XCogQ+HE3bG+iI=;
        b=axX/0btGBG7VZA5oOxIWSKCpAqW9iW0if5/8xDQBnd/96W3nS6zA64Yn2qSDmusdux
         0yjI7h2t3T1r4eeRVD3Nc5+Ih7ckMWxXhjz8mMiR2tM4REYDcvK+0efYlob2O8zrap/5
         ktBP09mQAFygJknZNvSoEVIQsBzlIDCiADLhFd01Qw4oIcqOcymwCVVS8wLrFg4jVTng
         MzeK9iLoqsAVO9W+Lb+pjLjNBbtvaFmQ/tJoFeutNwXh/BWfhPeXc/tmSn1BqAD7QuV5
         XTd5lfIfS76ldsegtGMvjnqookrhQdq/NGwlOrw3xPSEu1NTlYLmEf5TN8vzOFzeUeUI
         n8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664155; x=1707268955;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Auh6su970Zkwu/bwSWwLWungbSH25XCogQ+HE3bG+iI=;
        b=mUE6SVVHfANhQ08WeUPdfr2XVWzQXsax3Dhly9MKlVp6czvX98+HTEHTk/wKo3IqfK
         kn0CgvObxJcyr491ZEnfhb49B2G8MJhAU87kEdS4rlO4ixH31VG/HYk1MNLwEq7AFOW/
         Bnr+15rdn9gen8PQwLGxKW/BfchiLtfImWZuTAxSJINdm/s/5vsFK8mKe/vdUppBi0jE
         dbitbaFM7UV89OVqjwPYQ65snDMEzzPfkGfmhKcxbFTMN9aisciBVqBIAWHHwqS0Kq7H
         sqgssX0jVMcwTbkk3f06lS/AiojSZ5KXMo+PUCeEuOf2jQ0yegI27bQQ0ChfHfdXLkdi
         6dPQ==
X-Gm-Message-State: AOJu0YzVty+7gvbKx7h7m+biFxN4HzGEvXLbHaFT5EXbQXEJ1LvHZCce
	SCIY4KMg4FK2AWulikPQFdN/l2fr3wFrAlBQ09jLmx/yw0M/wFgL7fd9blLG
X-Google-Smtp-Source: AGHT+IGYwUEyJ8jfZ5eo7+Zz5X7tvNg3zJ7yL0bFRD4SJD5Oaur9/N5giM/2lKJHFgiC0VhOSm2uPQ==
X-Received: by 2002:a05:600c:314f:b0:40e:4806:f436 with SMTP id h15-20020a05600c314f00b0040e4806f436mr132748wmo.3.1706664155119;
        Tue, 30 Jan 2024 17:22:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4b9100b0040e3bdff98asm50284wmp.23.2024.01.30.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:22:34 -0800 (PST)
Message-ID: <885ac87a5447e54139171fb3eda62055ffd517cd.1706664145.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 31 Jan 2024 01:22:23 +0000
Subject: [PATCH v3 09/10] trailer: delete obsolete argument handling code from
 API
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

This commit was not squashed with its parent in order to keep the diff
separate (to make the additive changes in the parent easier to read).

Note that we remove the "new_trailer_item" struct, because it has some
overlap with "arg_item" struct that also deals with trailers coming from
the command line. The latter will be renamed to "trailer_template" in
the next patch.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 39 ---------------------------------------
 trailer.h | 17 -----------------
 2 files changed, 56 deletions(-)

diff --git a/trailer.c b/trailer.c
index 19637ff295d..bf1d2eee550 100644
--- a/trailer.c
+++ b/trailer.c
@@ -744,45 +744,6 @@ void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-void parse_trailers_from_command_line_args(struct list_head *arg_head,
-					   struct list_head *new_trailer_head)
-{
-	struct strbuf tok = STRBUF_INIT;
-	struct strbuf val = STRBUF_INIT;
-	const struct trailer_conf *conf;
-	struct list_head *pos;
-
-	/*
-	 * In command-line arguments, '=' is accepted (in addition to the
-	 * separators that are defined).
-	 */
-	char *cl_separators = xstrfmt("=%s", separators);
-
-	/* Add an arg item for each trailer on the command line */
-	list_for_each(pos, new_trailer_head) {
-		struct new_trailer_item *tr =
-			list_entry(pos, struct new_trailer_item, list);
-		ssize_t separator_pos = find_separator(tr->text, cl_separators);
-
-		if (separator_pos == 0) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addstr(&sb, tr->text);
-			strbuf_trim(&sb);
-			error(_("empty trailer token in trailer '%.*s'"),
-			      (int) sb.len, sb.buf);
-			strbuf_release(&sb);
-		} else {
-			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
-			trailer_add_arg_item(strbuf_detach(&tok, NULL),
-					     strbuf_detach(&val, NULL),
-					     conf,
-					     arg_head);
-		}
-	}
-
-	free(cl_separators);
-}
-
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
diff --git a/trailer.h b/trailer.h
index 8fcf1969a3c..5d4bacd9931 100644
--- a/trailer.h
+++ b/trailer.h
@@ -32,20 +32,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
 
-/*
- * A list that represents newly-added trailers, such as those provided
- * with the --trailer command line option of git-interpret-trailers.
- */
-struct new_trailer_item {
-	struct list_head list;
-
-	const char *text;
-
-	enum trailer_where where;
-	enum trailer_if_exists if_exists;
-	enum trailer_if_missing if_missing;
-};
-
 void trailer_conf_set(enum trailer_where where,
 		      enum trailer_if_exists if_exists,
 		      enum trailer_if_missing if_missing,
@@ -79,9 +65,6 @@ struct process_trailer_options {
 
 void parse_trailers_from_config(struct list_head *config_head);
 
-void parse_trailers_from_command_line_args(struct list_head *arg_head,
-					   struct list_head *new_trailer_head);
-
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-- 
gitgitgadget

