Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCED3C464
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONUvcP6E"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368abe1093so3240312f8f.2
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869497; x=1705474297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJXVDZAV8/lEGcLz+j4d3giw9C8brSkT4KkN7KU9WGM=;
        b=ONUvcP6EYno0rm8Qb9+zdbGC9btUyF/9BMQfi4Nxlb00cvlcalg5V43FaNb9emaZmV
         ss22SKKxXS7VW/SlAOnNIhkq+j+Wbr5O7Mtr/8ufyikdiqjCkWN7RyPIhkqGYM/t6TUZ
         aFqcKTrZ+mvAArfD7Yz8zCu/e3nP4Fvxh+4Z3uq3mEX0PoAajzeo3eccvTGWgkxmSGGj
         modOTfUW/U3LtWT07PoyiN+IfX8FbpIdFxGhsUUZByjHUP/pLF7Q7Iem3fIrRVC6SUMw
         yKxO9BPlJDCdcpXa2IIew2x7wlmQ+AteIEpr/+EbizWvLnAZsoEHrCzA64IOO9onwUAr
         v6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869497; x=1705474297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJXVDZAV8/lEGcLz+j4d3giw9C8brSkT4KkN7KU9WGM=;
        b=wWNi+hFTu1zJajQkYcB7R/X2EA/jHSekrUmyADwBIVmbJ72XV/38A0va7cYSsh9/zB
         J8/xKCVczO5V1Ra++oNqbwUzxwEC5bsXuK2qnSPEjvOC7DkKdWjBwtz1yLzgt8B8FYul
         prGhO9VeUSgxwxNVzA3a9xtk37+/F/g/mKIf/cn4o4gCOGF/wvINLRtc9PvjlidxP2ou
         C2XbcEU+ua84GLNSk+iXGZR7b2MMOvMThxdXijaXeLkMpahn480sH5V0b5SZacsEokYN
         oV3zn34/B3XNrtP8QH1t97hqLmY9U4JEvm6yJFdlVba6dktGvMmqsxF764x4+ftqiC3j
         HDug==
X-Gm-Message-State: AOJu0YyjDDkrS2XxhtbMjDsVaY875/Bxf/CXf/Uyt7YO5bwgbbGlvEhZ
	DXOs7RCw6/eWKTTKLhr11e+1z8HfxII=
X-Google-Smtp-Source: AGHT+IFQfABBT/RjnKIzbhT+WOsNAMuBOSIBPMuQpFa9OOZmDldDW7NpJcMI8tAf9Bo7IBYmr6CgCA==
X-Received: by 2002:a05:6000:82:b0:337:68ab:617e with SMTP id m2-20020a056000008200b0033768ab617emr230234wrx.8.1704869497057;
        Tue, 09 Jan 2024 22:51:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15-20020adfb30f000000b003375c8f796bsm4177275wrd.0.2024.01.09.22.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:36 -0800 (PST)
Message-ID: <243eee730e4aae48fd53ba066c829a65cd5546f3.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:26 +0000
Subject: [PATCH 10/10] trailer: delete obsolete argument handling code from
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
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This commit was not squashed with its parent in order to keep the diff
separate (to make the additive changes in the parent easier to read).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 39 ---------------------------------------
 trailer.h | 17 -----------------
 2 files changed, 56 deletions(-)

diff --git a/trailer.c b/trailer.c
index 0a86e0d5afa..27bb2195f53 100644
--- a/trailer.c
+++ b/trailer.c
@@ -745,45 +745,6 @@ void parse_trailers_from_config(struct list_head *config_head)
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
-			add_arg_item(strbuf_detach(&tok, NULL),
-				     strbuf_detach(&val, NULL),
-				     conf,
-				     arg_head);
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
index 9b86acfe2d4..8a89e95c171 100644
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
