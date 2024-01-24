Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42C7A700
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105069; cv=none; b=cNpi8PdV9JWWN9kPkX41feO/VWeEY0efejiRO377uuAKzPIqtqzptvr3ImZCvtnq4hj7/SJqnFkOxT2jYkHaOzsXjzwkyhPqM0NVp0PWxqFIw0hpHN3wtC9jazO58OLFLFSGs19om494b1401yV9PV2Ywx/KqCNiyAq2QGFZZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105069; c=relaxed/simple;
	bh=NnjPseudsxuTpCa3rMBJtovpJKshzvPs2fQG9G4C/7o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r3FJbCv6j1gKJJ+BJfkv+tQ0z3s992kbYl6RppYjS0FqLqLLWFesVdbIDb5G5qrLxMUvD6N8pJ8MTkY0ts9HMjpVbpHTII+qDgh1u1T6QrkwlXvS60GiukmaZxLq+yleGI+t+m2p582chuTPmWT96Jf7lUcR45iEDsUbx6RW7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIczYO0N; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIczYO0N"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf2b218c62so5368631fa.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706105066; x=1706709866; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lvrQqRlkcHzr/7pyhs7C9kKChCUQLWAd/BPsEXvsgs=;
        b=GIczYO0NCjTKANN6OjFQ02XwZfYKw2ic5uLMspT1mr1qHFAUTcGhbtlNz4dy5BfnCp
         vDnqqQAuYyhjaWDfWU+ljUUai7bFwcEwbM4k00AW8wiY3r2/fVzwCLvzhwBjBMukEyU7
         vF7BRZ56n0bEAzor0hJoa2gwH/TH5gvU+nWZGZ4qppF/9pUDHfer46zhFS6hGTA8UzlR
         umJEdAj0AiNHXY/oGs8sAZi8XAUXoZvlv7jrDvitLQ2z/tseGcRP0g12xU1FlpBa8Ud1
         6i4RoAT7rsnqtBnVw2LwfJiyRkgss+cJMp2k8q56kYNJYaed1jZDEuiKq48B1KqIS8Fs
         gfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105066; x=1706709866;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lvrQqRlkcHzr/7pyhs7C9kKChCUQLWAd/BPsEXvsgs=;
        b=QQXGIs72ryVTIPU3Y0sAyLkVLdBE9F9cWbI06J7JJnWDSlkchCeFajangnaUElDlLM
         2rsQiG8E0+i6LgW68jspC4YP2dmubIQ64unkLdt1paqViFkToW1ZlagrHy0E6eankjsi
         GxLx0frnPHm/5xdYlRkacdstRpqRnT9FW3v+y00YteFjAF4SWJgcCqBnaHlUpsebsScw
         D/1LprcIjaO3oImBwbKEYnFlVtfhRQDdzQOgmz4N1GCqs439srDjsulpAhIWNOzy0E7L
         CEMKDD6JcvsOS67GchHfeCP+ELVg9FBgqDuTjlsmb1tpU28Ed6u4N6EPQ4gSdpbMxA/w
         k+zw==
X-Gm-Message-State: AOJu0Yxge547mDL+gYr/RMlKHxONUS7GDTc2Phueahz4fvp2CF8BNShN
	TrmOD4s8Xz+GB4NisOk7UNew3PGTFqRA62WOusXGcgOf7RUflII3fq7B7jAs
X-Google-Smtp-Source: AGHT+IGT0PPFKluropaOpo66wFyNWJwBR4t7D224FOZceQVxtgYiMakAMiAR4IP8vVUBv/Z7rwUVtg==
X-Received: by 2002:a05:651c:4d4:b0:2cf:1b65:bfc1 with SMTP id e20-20020a05651c04d400b002cf1b65bfc1mr591326lji.127.1706105065568;
        Wed, 24 Jan 2024 06:04:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm10324203wrr.1.2024.01.24.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:04:25 -0800 (PST)
Message-ID: <ac9338533c9096c090d1463c1b29505bde019731.1706105064.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
References: <pull.1653.git.git.1706105064.gitgitgadget@gmail.com>
From: "Md Isfarul Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 14:04:23 +0000
Subject: [PATCH 1/2] FIX: use utf8_strnwidth for line_prefix in diff.c
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
Cc: Md Isfarul Haque <isfarul.876@gmail.com>,
    Md Isfarul Haque <isfarul.876@gmail.com>

From: Md Isfarul Haque <isfarul.876@gmail.com>

This patch adresses diff.c:2721 and proposes the fix using a new function.

Signed-off-by: Md Isfarul Haque <isfarul.876@gmail.com>
---
 diff.c | 18 ++++++++++++++++--
 diff.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index a89a6a6128a..e3223b8ce5b 100644
--- a/diff.c
+++ b/diff.c
@@ -2300,6 +2300,20 @@ const char *diff_line_prefix(struct diff_options *opt)
 	return msgbuf->buf;
 }
 
+const struct strbuf *diff_line_prefix_buf(struct diff_options *opt)
+{
+	struct strbuf *msgbuf = (struct strbuf *)malloc(sizeof(*msgbuf));
+	if (!opt->output_prefix){
+		msgbuf->buf = "";
+		msgbuf->len = 0;
+		msgbuf->alloc = 1;
+	}
+	else {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+	}
+	return msgbuf;
+}
+
 static unsigned long sane_truncate_line(char *line, unsigned long len)
 {
 	const char *cp;
@@ -2635,7 +2649,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
 	const char *reset, *add_c, *del_c;
 	int extra_shown = 0;
-	const char *line_prefix = diff_line_prefix(options);
+	const struct strbuf *line_prefix = diff_line_prefix_buf(options);
 	struct strbuf out = STRBUF_INIT;
 
 	if (data->nr == 0)
@@ -2718,7 +2732,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * used to correctly count the display width instead of strlen().
 	 */
 	if (options->stat_width == -1)
-		width = term_columns() - strlen(line_prefix);
+		width = term_columns() - utf8_strnwidth(line_prefix->buf, line_prefix->len, 1);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
diff --git a/diff.h b/diff.h
index 66bd8aeb293..6eb8dc9a97e 100644
--- a/diff.h
+++ b/diff.h
@@ -460,6 +460,7 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix);
 
 const char *diff_line_prefix(struct diff_options *);
 
+const struct strbuf *diff_line_prefix_buf(struct diff_options *);
 
 extern const char mime_boundary_leader[];
 
-- 
gitgitgadget

