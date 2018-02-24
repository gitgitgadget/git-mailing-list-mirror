Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBD41F404
	for <e@80x24.org>; Sat, 24 Feb 2018 14:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeBXOKN (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 09:10:13 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32770 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeBXOKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 09:10:12 -0500
Received: by mail-pg0-f65.google.com with SMTP id g12so4478210pgs.0
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 06:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwucstnSToveaUTClLu+R4fNNAA31s5Ym2JGxniXSJA=;
        b=eBmhFfD6nCN/1vaHw8+yA8r5/nnw58tJyx/KIkbSoB6i7xLhr9q9DT4WBWq9REgcvF
         WXEzxyuL+GeRk2iEJGFMMxaMbF+xaQ5tvtqfhrudNK51YivCESzgO+klM6ntAOLufYYc
         9uQILjmyL1ByYUmXEXdn2cbiPw1I0z+JUtUvWTL2qJU0tuUx8IXeE94kf8QYJ2MvSBYB
         U9b28wMIuXOlLZCGGH/sUhSdFXYy9hMAssLw/JHb2+Cb7xtiGS3f6qH4k9ucQfIxv0Pv
         ogCz41ie928wM+orlMyDND8aQhwdP1ZbATUwdAUYVw97JcgewMmRCFlzdg2A458sodOt
         FynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwucstnSToveaUTClLu+R4fNNAA31s5Ym2JGxniXSJA=;
        b=NrG4KwN50ml2YrCWch0SyQW8E8Lzls3JFENscIwY6lv+jwZ2CRIWjCczxbuuH9a3Jx
         JqQBL26bYKC936cNnSZ6mw7RwEW/MOuIB6fAz6RBKeacBhMicSpc2sotAeTbmOcArebH
         nXPL5NaLSxVTSFHguKAiqNE9c8ZjKGKjAeaHtpWV6+HaAZIlyVdlOkzyCEsARftTmmNm
         63BYEWtQ4p4hgGC29NvxukRBhO/i8nJb11mr9fHbKqYKmuS0ZgvAHxoAtasTdoxbdiTz
         XoH9S379q/M/I/r0K7Mnkxv540UcV1oi/wopvJv3QOWI5DDt1/tx8pk6yBgggBXpKsJG
         FBkg==
X-Gm-Message-State: APf1xPAWcWhKQeVvdN6WGWSI82+UbUBOa7VzmY21qvz0f5A3IKXXNU7d
        zi0E2biPfN0eT1MLDkd5AWk4CA==
X-Google-Smtp-Source: AH8x226AKCXWnvUxDe4VsRd5ld28Nvvte3GagYFK9tDbseHxc7c7EouLH0/4uHWeiOxNJH6IEzWw/w==
X-Received: by 10.99.111.196 with SMTP id k187mr4001416pgc.360.1519481411547;
        Sat, 24 Feb 2018 06:10:11 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id z125sm9575419pfz.27.2018.02.24.06.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2018 06:10:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Feb 2018 21:10:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 1/2] diff.c: refactor pprint_rename() to use strbuf
Date:   Sat, 24 Feb 2018 21:09:58 +0700
Message-Id: <20180224140959.25402-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224140959.25402-1-pclouds@gmail.com>
References: <20180224140509.25061-1-pclouds@gmail.com>
 <20180224140959.25402-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of passing char* around, let function handle strbuf
directly. All callers already use strbuf internally.

This helps kill the "not free" exception in free_diffstat_info(). I
don't think this code is so critical that we need to avoid some free()
calls.

The other benefit comes in the next patch, where we append something
in pname before returning from fill_print_name(). With strbuf, it's
very simple. With "char *" we may have to resort to explicit
reallocation and stuff.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 59 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index 21c3838b25..e3f72de27d 100644
--- a/diff.c
+++ b/diff.c
@@ -2045,11 +2045,10 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 }
 
-static char *pprint_rename(const char *a, const char *b)
+static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old = a;
 	const char *new = b;
-	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
 	int pfx_adjust_for_slash;
 	int len_a = strlen(a);
@@ -2059,10 +2058,10 @@ static char *pprint_rename(const char *a, const char *b)
 	int qlen_b = quote_c_style(b, NULL, NULL, 0);
 
 	if (qlen_a || qlen_b) {
-		quote_c_style(a, &name, NULL, 0);
-		strbuf_addstr(&name, " => ");
-		quote_c_style(b, &name, NULL, 0);
-		return strbuf_detach(&name, NULL);
+		quote_c_style(a, name, NULL, 0);
+		strbuf_addstr(name, " => ");
+		quote_c_style(b, name, NULL, 0);
+		return;
 	}
 
 	/* Find common prefix */
@@ -2109,19 +2108,18 @@ static char *pprint_rename(const char *a, const char *b)
 	if (b_midlen < 0)
 		b_midlen = 0;
 
-	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
+	strbuf_grow(name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
 	if (pfx_length + sfx_length) {
-		strbuf_add(&name, a, pfx_length);
-		strbuf_addch(&name, '{');
+		strbuf_add(name, a, pfx_length);
+		strbuf_addch(name, '{');
 	}
-	strbuf_add(&name, a + pfx_length, a_midlen);
-	strbuf_addstr(&name, " => ");
-	strbuf_add(&name, b + pfx_length, b_midlen);
+	strbuf_add(name, a + pfx_length, a_midlen);
+	strbuf_addstr(name, " => ");
+	strbuf_add(name, b + pfx_length, b_midlen);
 	if (pfx_length + sfx_length) {
-		strbuf_addch(&name, '}');
-		strbuf_add(&name, a + len_a - sfx_length, sfx_length);
+		strbuf_addch(name, '}');
+		strbuf_add(name, a + len_a - sfx_length, sfx_length);
 	}
-	return strbuf_detach(&name, NULL);
 }
 
 struct diffstat_t {
@@ -2197,23 +2195,17 @@ static void show_graph(struct strbuf *out, char ch, int cnt,
 
 static void fill_print_name(struct diffstat_file *file)
 {
-	char *pname;
+	struct strbuf pname = STRBUF_INIT;
 
 	if (file->print_name)
 		return;
 
-	if (!file->is_renamed) {
-		struct strbuf buf = STRBUF_INIT;
-		if (quote_c_style(file->name, &buf, NULL, 0)) {
-			pname = strbuf_detach(&buf, NULL);
-		} else {
-			pname = file->name;
-			strbuf_release(&buf);
-		}
-	} else {
-		pname = pprint_rename(file->from_name, file->name);
-	}
-	file->print_name = pname;
+	if (file->is_renamed)
+		pprint_rename(&pname, file->from_name, file->name);
+	else
+		quote_c_style(file->name, &pname, NULL, 0);
+
+	file->print_name = strbuf_detach(&pname, NULL);
 }
 
 static void print_stat_summary_inserts_deletes(struct diff_options *options,
@@ -2797,8 +2789,7 @@ static void free_diffstat_info(struct diffstat_t *diffstat)
 	int i;
 	for (i = 0; i < diffstat->nr; i++) {
 		struct diffstat_file *f = diffstat->files[i];
-		if (f->name != f->print_name)
-			free(f->print_name);
+		free(f->print_name);
 		free(f->name);
 		free(f->from_name);
 		free(f);
@@ -5241,10 +5232,12 @@ static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
 		struct diff_filepair *p)
 {
 	struct strbuf sb = STRBUF_INIT;
-	char *names = pprint_rename(p->one->path, p->two->path);
+	struct strbuf names = STRBUF_INIT;
+
+	pprint_rename(&names, p->one->path, p->two->path);
 	strbuf_addf(&sb, " %s %s (%d%%)\n",
-			renamecopy, names, similarity_index(p));
-	free(names);
+		    renamecopy, names.buf, similarity_index(p));
+	strbuf_release(&names);
 	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
 				 sb.buf, sb.len, 0);
 	show_mode_change(opt, p, 0);
-- 
2.16.1.435.g8f24da2e1a

