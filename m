Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12332B990
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698593; cv=none; b=HF4f7Wje818VPJrInxfrFOSieS8XYtCF5zLU+u8KW5wU+VQUOoqRLKRS2tqvM9oXxoPyWdTMlOpx0LB2VDYrxh2KV/I7WcKxI3etyf1kJXufK05qYLCOvejAaDns/w+2T1NRE0TTcmBKyIQqT9MiDDLtumRRKMln32SlIB6OaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698593; c=relaxed/simple;
	bh=6is+eQcfH7NN9TQMBxsfGWWBb+dlBV/hCp9r4NjxVy4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hbuz33od6dfXA+uhr5EI7Cugcu1k1no/IG9psRykQryayzL2kb2v9u3CspbXcsrK/ghmvXXHjtHgL5SbOGgqOAX33gFu5lGUJNaiZJXW55DcI0GYpeFWPACAiLhVMCusp12//75xMR8KoktnWgVfkjG+ClBB/OsS9C7Jsj5u2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrIaQF9c; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrIaQF9c"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4042cd2a336so311002fac.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698590; x=1771303390; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rl1zpugN7Qh6tRVNMnhyDXv0vyLTyZEbwOraoa50yM=;
        b=DrIaQF9cBjY1puqWoxi3NTUqhIn5L9VbDwY8Iq3lz4erAlSE3EPin0518iER/AxKNs
         ODXX9el37XDHGZb8jVkLNKZVxRs6Aw/uaK5jnekW2X+YsgHvw/558KB216LMU0xetUC+
         CGnFTmAYiwkjAkX1OfJn9cYU2bZRrO7AgSaBkUeuAZQpObU7nSOm5NIxoqbZZ0AC05K/
         XyjFcx2ACsgQ7BTQ9u2GK3mlGPBligHLaZxBxC0mGkWqQu9GP6MUOQ8Pd1F9WbyArFSN
         tKInl4C3okPTv8BZFa1xSi9monbBox6v6vnUrMg0iELRk9wgkXo04kg0tPQFIT5ndf+x
         WKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698590; x=1771303390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rl1zpugN7Qh6tRVNMnhyDXv0vyLTyZEbwOraoa50yM=;
        b=kl3smAd7MlbdrKvZu1ej8vPOWGuukeDwXz9PvdKGudA4M+8z9wnW7os4e9lOddMyYw
         MYIjRZjaQvPfGI01pLNgJauEJ59z+FPqO+hTvmvjhJm53VpJkKKAeXvP+cT3dV7LHYAB
         C1GIKiKOAkExXxDzGBVsBX3Zu2fQeSApVrs3tSzhyKYAdaLoA9P0JTAhPpAogSYGlwj2
         Gex2zvvEBJ07CR8K+ktVCQVFEBQVromtUAim6xcSVk+CfqsYA5g0vwJ4d54N/1zZo4lA
         yZ97TSeLPEKqpDAAvJ9C8+ZOOV9lL8b/xYTaBeYMq3izxB1DWmMQBRrIwjZg/lHhzg/C
         ChZQ==
X-Gm-Message-State: AOJu0Yxq1dePo4Ss+7ldIMxNL8BLBB+DXSzOj2/RWOsp5QiyDtOXnwZC
	sGEGhxl9X7oTTJPY/O+8V1jLTSlY8l0AsmJ1JSo3lxsjTfxO3DIimmajUu/fLZRS
X-Gm-Gg: AZuq6aJREYSPpF+fWEHxdF5n7Coe8HgCvdeIgPjTQqk94nCOu7+f+RIjYHocu+AYUYG
	YeaX3MyNBrwyKhIkbLS922ldTSnGHneOoD+KWBLV4q2hUAltadbIoOu79TG2Ae+hK/XL5NYKF4D
	d0eXjLFOw3Wyn5tqg8HlBv//QFuWvQcUmsKg4qep+c9vG/8FbLTuylvabOD24bdyL+p5UKjBnKQ
	I/CtWCMpcl4PgSoG//v85sDMhn5qnYcPge+9IyLBxsrfv+mAeQTDII6YdaISZl2sAsXlD4dGR7p
	+34hYDe5BUzJhFPe2jA7PEE5V78M5AxU7Mxu+tdS5uubDhoVrkwlc6QrzWAENZ1+EFkOAuq7isq
	LhBgOYsQejwQiE8GzYqMhnAbv+WB3YhasfRERKd2jdrl1rVMGx/CCuvLYisnw/oo0c9Jt7rnATa
	zG+sfpmJ4S7inM1aJBsDXFia7XSA==
X-Received: by 2002:a05:6871:cc89:b0:40b:da6:fd79 with SMTP id 586e51a60fabf-40b0da74fe7mr1092886fac.51.1770698590249;
        Mon, 09 Feb 2026 20:43:10 -0800 (PST)
Received: from [127.0.0.1] ([52.173.178.210])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a99359eb4sm9001497fac.9.2026.02.09.20.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:43:09 -0800 (PST)
Message-Id: <d9e04240100afb4188d32c5ce784f189f59348b4.1770698579.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 04:42:57 +0000
Subject: [PATCH 3/5] config: allow format_config() to filter
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The format_config() method in builtin/config.c currently only uses
git_config_*() methods for parsing. This allows parsing errors to result
in die() messages appropriate with keys in the error message.

In a future change we will want to use format_config() within 'git
config list' to help format the output, including when --type=<X>
arguments are provided. When the parsing fails in that case, that
key-value pair should be omitted instead of causing a failure across the
entire command.

This change is formatted in such a way that the if/else-if structure
allows the default die_on_error version to appear first and then be
followed by the gentle parsing mode immediately afterwards.

The only callers right now have die_on_parse set to 1.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 75 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 237f7a934d..5146abcfa3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -3,6 +3,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "color.h"
+#include "date.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
@@ -245,7 +246,8 @@ struct strbuf_list {
  */
 static int format_config(const struct config_display_options *opts,
 			 struct strbuf *buf, const char *key_,
-			 const char *value_, const struct key_value_info *kvi)
+			 const char *value_, const struct key_value_info *kvi,
+			 int die_on_parse)
 {
 	if (opts->show_scope)
 		show_config_scope(opts, kvi, buf);
@@ -257,27 +259,55 @@ static int format_config(const struct config_display_options *opts,
 		if (opts->show_keys)
 			strbuf_addch(buf, opts->key_delim);
 
-		if (opts->type == TYPE_INT)
+		if (opts->type == TYPE_INT && die_on_parse) {
 			strbuf_addf(buf, "%"PRId64,
 				    git_config_int64(key_, value_ ? value_ : "", kvi));
-		else if (opts->type == TYPE_BOOL)
+		} else if (opts->type == TYPE_INT) {
+			int64_t v;
+			int ret = git_parse_int64(value_, &v);
+
+			if (ret)
+				return -1;
+
+			strbuf_addf(buf, "%"PRId64, v);
+		}
+		else if (opts->type == TYPE_BOOL && die_on_parse) {
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
-		else if (opts->type == TYPE_BOOL_OR_INT) {
-			int is_bool, v;
-			v = git_config_bool_or_int(key_, value_, kvi,
-						   &is_bool);
+		} else if (opts->type == TYPE_BOOL) {
+			int value = git_parse_maybe_bool(value_);
+
+			if (value < 0)
+				return -1;
+
+			strbuf_addstr(buf, value ? "true" : "false");
+		} else if (opts->type == TYPE_BOOL_OR_INT && die_on_parse) {
+			int is_bool = 0;
+			int v = git_config_bool_or_int(key_, value_, kvi,
+						       &is_bool);
+			if (is_bool)
+				strbuf_addstr(buf, v ? "true" : "false");
+			else
+				strbuf_addf(buf, "%d", v);
+		} else if (opts->type == TYPE_BOOL_OR_INT) {
+			int is_bool = 0;
+			int v = git_parse_maybe_bool_text(value_);
+
+			if (v < 0)
+				return -1;
+
 			if (is_bool)
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
 				strbuf_addf(buf, "%d", v);
 		} else if (opts->type == TYPE_BOOL_OR_STR) {
+			/* Note: this can't fail to parse! */
 			int v = git_parse_maybe_bool(value_);
 			if (v < 0)
 				strbuf_addstr(buf, value_);
 			else
 				strbuf_addstr(buf, v ? "true" : "false");
-		} else if (opts->type == TYPE_PATH) {
+		} else if (opts->type == TYPE_PATH && die_on_parse) {
 			char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
@@ -286,16 +316,35 @@ static int format_config(const struct config_display_options *opts,
 			else
 				return 1; /* :(optional)no-such-file */
 			free((char *)v);
-		} else if (opts->type == TYPE_EXPIRY_DATE) {
+		} else if (opts->type == TYPE_PATH) {
+			char *v;
+			if (git_parse_maybe_pathname(value_, &v) < 0)
+				return -1;
+			if (v)
+				strbuf_addstr(buf, v);
+			else
+				return 1; /* :(optional)no-such-file */
+			free((char *)v);
+		} else if (opts->type == TYPE_EXPIRY_DATE && die_on_parse) {
 			timestamp_t t;
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
 			strbuf_addf(buf, "%"PRItime, t);
-		} else if (opts->type == TYPE_COLOR) {
+		} else if (opts->type == TYPE_EXPIRY_DATE) {
+			timestamp_t t;
+			if (parse_expiry_date(value_, &t) < 0)
+				return -1;
+			strbuf_addf(buf, "%"PRItime, t);
+		} else if (opts->type == TYPE_COLOR && die_on_parse) {
 			char v[COLOR_MAXLEN];
 			if (git_config_color(v, key_, value_) < 0)
 				return -1;
 			strbuf_addstr(buf, v);
+		} else if (opts->type == TYPE_COLOR) {
+			char v[COLOR_MAXLEN];
+			if (color_parse(value_, v) < 0)
+				return -1;
+			strbuf_addstr(buf, v);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -372,7 +421,7 @@ static int collect_config(const char *key_, const char *value_,
 	strbuf_init(&values->items[values->nr], 0);
 
 	status = format_config(data->display_opts, &values->items[values->nr++],
-			       key_, value_, kvi);
+			       key_, value_, kvi, 1);
 	if (status < 0)
 		return status;
 	if (status) {
@@ -463,7 +512,7 @@ static int get_value(const struct config_location_options *opts,
 		strbuf_init(item, 0);
 
 		status = format_config(display_opts, item, key_,
-				       display_opts->default_value, &kvi);
+				       display_opts->default_value, &kvi, 1);
 		if (status < 0)
 			die(_("failed to format default config value: %s"),
 			    display_opts->default_value);
@@ -743,7 +792,7 @@ static int get_urlmatch(const struct config_location_options *opts,
 
 		status = format_config(&display_opts, &buf, item->string,
 				       matched->value_is_null ? NULL : matched->value.buf,
-				       &matched->kvi);
+				       &matched->kvi, 1);
 		if (!status)
 			fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
-- 
gitgitgadget

