Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33183B666
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504168; cv=none; b=OKAjPkRPOJW4j8Pz8PMWzTLmoy78zV9iXVQfLzO+IsKz/LaAon5bAARzikgXNRBf/FVEeiTZOFM3QsqVrgEjbiKF3D0x8qRGAiUh+3bALu0/vHcrJ+bZ+hIZqEofQ9YJIg8yhxpUVpjdeBFJ1HiUvcLVALE+BOo8LoCpOVTSE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504168; c=relaxed/simple;
	bh=yX6rb+UiEB1astWPY1iRzrTuD7QPl8KVlv1oC88H+4s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s1ZeoG1rGWc8e/+d3ArqB9bMuJN4hoH9Et2L80E8Y4IkNaQHI+SCDvhv9AZjXYpLsJqassLq8Ypzc781vATUY3bx0tXnnUwG2F1/tjKJ+iUZ5dAaJfQzMV+OTJ6qZZEAd8TdqXBsKlLsPS+pGjne+w15vuDIxSCxg6iu5+cVsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icc9x0qW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icc9x0qW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a555b203587so174395266b.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504165; x=1714108965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yELVRQ8ZDtDc4lZA2exN72FHqFJ0qjVHYEiiVMabbG4=;
        b=icc9x0qW0COGYoF/poeBMTfeV+Or1aWZQ1z/PD9O8Jela4is/ubOZ/tCCRVlfWjZl8
         wr+vVbI2OsR3mdy3QWcv/DSP3iGihCRyjznuNIN92dcdLaBn/JPWDjNrRmHHFGXm+8PR
         DfKwMRPmUZi/qO9ZT3JQm7K/kwizo3/o+P2d3CvnZPrVKD0xjxCeqNrC6cku4LqVSQP8
         ih5dsqoPKFVXaXmms0ROreTHf02YSZBkquilk8f96ufivCuWdL9Kv0bMHeX4fEHDac4E
         Vg6BkIIBjSbxnMtQA+1WcJG/Eu2UKCvfMV/+W43ti1SKEkfAPIjjwhRBxNeUi73EGtwI
         HHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504165; x=1714108965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yELVRQ8ZDtDc4lZA2exN72FHqFJ0qjVHYEiiVMabbG4=;
        b=e1Kn8b8koqiWJnZg8wv03l++gvquX1Vbpln4jf89NJYOjpKdd+Xi0YdXwl8teir/iY
         He9oqYiuT6WlKjQhEv0yi5Z+xVXW3rhzCxKrQ48AoG8jQXM0bXlWkj6YB1X4dC3fAs9M
         dH6HKMWA++2+Wm+TRleVZK0rz7hM3lwBqHaDuLb+0t3CDsU6y5XHqvxiYikNkACaFs5v
         jRW89+p2ppjU26x5k38XRHTUg8apLdW4xH6RDb9vWh0km7J85h5j2ZitU2I/KZwV6IJF
         x9Y96ikYU6nY9Tc0xe04mWOPFuU6ExrhR6I9YB1Dlhb/ae+sDIUAhK/qgYdn2aUpq7To
         QvHg==
X-Gm-Message-State: AOJu0Yxu7sTsgJ0JiIB8lawWOyQOt9DFUR9mEGN0SUvas+sf9Vr8zxll
	bL7p8qWzHZn4qw42KaZYoM4oYYyyqtaueQyu5anrFFRhXkWc8VMheSHhyA==
X-Google-Smtp-Source: AGHT+IHmBm4QYzJhJ2YQwLelzeTx0TjyyUQI9lyqBovy+P2qHpP4Ongl2+K6xrptEwL9HVvzBMGo2w==
X-Received: by 2002:a17:906:aad8:b0:a52:6e71:e770 with SMTP id kt24-20020a170906aad800b00a526e71e770mr852049ejb.11.1713504164788;
        Thu, 18 Apr 2024 22:22:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709064e9600b00a55865b2760sm328411eju.30.2024.04.18.22.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:43 -0700 (PDT)
Message-Id: <eca77a1a462a624f988fc50f7588d831678f34f4.1713504153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:33 +0000
Subject: [PATCH v2 8/8] trailer: retire trailer_info_get() from API
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

Make trailer_info_get() "static" to be file-scoped to trailer.c, because
no one outside of trailer.c uses it. Remove its declaration from
<trailer.h>.

We have to also reposition it to be above parse_trailers(), which
depends on it.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 92 +++++++++++++++++++++++++++----------------------------
 trailer.h |  2 --
 2 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6167b707ae0..33b6aa7e8bd 100644
--- a/trailer.c
+++ b/trailer.c
@@ -979,6 +979,52 @@ static struct trailer_info *trailer_info_new(void)
 	return info;
 }
 
+static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
+					     const char *str)
+{
+	struct trailer_info *info = trailer_info_new();
+	size_t end_of_log_message = 0, trailer_block_start = 0;
+	struct strbuf **trailer_lines, **ptr;
+	char **trailer_strings = NULL;
+	size_t nr = 0, alloc = 0;
+	char **last = NULL;
+
+	trailer_config_init();
+
+	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
+	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
+
+	trailer_lines = strbuf_split_buf(str + trailer_block_start,
+					 end_of_log_message - trailer_block_start,
+					 '\n',
+					 0);
+	for (ptr = trailer_lines; *ptr; ptr++) {
+		if (last && isspace((*ptr)->buf[0])) {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
+			strbuf_addbuf(&sb, *ptr);
+			*last = strbuf_detach(&sb, NULL);
+			continue;
+		}
+		ALLOC_GROW(trailer_strings, nr + 1, alloc);
+		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
+		last = find_separator(trailer_strings[nr], separators) >= 1
+			? &trailer_strings[nr]
+			: NULL;
+		nr++;
+	}
+	strbuf_list_free(trailer_lines);
+
+	info->blank_line_before_trailer = ends_with_blank_line(str,
+							       trailer_block_start);
+	info->trailer_block_start = trailer_block_start;
+	info->trailer_block_end = end_of_log_message;
+	info->trailers = trailer_strings;
+	info->trailer_nr = nr;
+
+	return info;
+}
+
 /*
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
@@ -1044,52 +1090,6 @@ int blank_line_before_trailer_block(struct trailer_info *info)
 	return info->blank_line_before_trailer;
 }
 
-struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
-				      const char *str)
-{
-	struct trailer_info *info = trailer_info_new();
-	size_t end_of_log_message = 0, trailer_block_start = 0;
-	struct strbuf **trailer_lines, **ptr;
-	char **trailer_strings = NULL;
-	size_t nr = 0, alloc = 0;
-	char **last = NULL;
-
-	trailer_config_init();
-
-	end_of_log_message = find_end_of_log_message(str, opts->no_divider);
-	trailer_block_start = find_trailer_block_start(str, end_of_log_message);
-
-	trailer_lines = strbuf_split_buf(str + trailer_block_start,
-					 end_of_log_message - trailer_block_start,
-					 '\n',
-					 0);
-	for (ptr = trailer_lines; *ptr; ptr++) {
-		if (last && isspace((*ptr)->buf[0])) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_attach(&sb, *last, strlen(*last), strlen(*last));
-			strbuf_addbuf(&sb, *ptr);
-			*last = strbuf_detach(&sb, NULL);
-			continue;
-		}
-		ALLOC_GROW(trailer_strings, nr + 1, alloc);
-		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
-		last = find_separator(trailer_strings[nr], separators) >= 1
-			? &trailer_strings[nr]
-			: NULL;
-		nr++;
-	}
-	strbuf_list_free(trailer_lines);
-
-	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
-
-	return info;
-}
-
 void trailer_info_release(struct trailer_info *info)
 {
 	size_t i;
diff --git a/trailer.h b/trailer.h
index a63e97a2663..1b7422fa2b0 100644
--- a/trailer.h
+++ b/trailer.h
@@ -73,8 +73,6 @@ void process_trailers_lists(struct list_head *head,
 struct trailer_info *parse_trailers(const struct process_trailer_options *,
 				    const char *str,
 				    struct list_head *head);
-struct trailer_info *trailer_info_get(const struct process_trailer_options *,
-				      const char *str);
 
 size_t trailer_block_start(struct trailer_info *);
 size_t trailer_block_end(struct trailer_info *);
-- 
gitgitgadget
