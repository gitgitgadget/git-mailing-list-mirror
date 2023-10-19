Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D13C68A
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meoi0li6"
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DE111B
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:48 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b2e330033fso67553b6e.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697744388; x=1698349188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4wO8x1fM/JwN4oD+3FoqZoKDlwF6cRU4SS8EVE8m/Y=;
        b=meoi0li6valAZfTnb6evd/Wx/avMhcakY7fPDu7nE+5+poHNyOoyaqmEGBOId+Ndaq
         3JqTiDPrioYynXk6ekhZWG2pYAPDEZSgC8XuBvvXSH6r54D6vf+yCyhDZme1qisK+3OQ
         gjV8F/zXtW89l3qwopSjnIcEnJGUHqw108xVbspSCeh2+bV2QmUP9AEjKLemBj32YT09
         vZCHbaIyUwdpLrf4wWshFUaXDfkJKmBAOAoJtkIorkIQzIPUYwM20x4BLWDwGdN6XaBL
         WL+jKx5wxVzk1f4AOcVYY8zuQSpT9TlBnu3JiOipjI16OiOsOvNFeuOULN8DVh5/BkaB
         /zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744388; x=1698349188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4wO8x1fM/JwN4oD+3FoqZoKDlwF6cRU4SS8EVE8m/Y=;
        b=EyohG7FdwFmxZEAl77j4guBjrYMzSBoW09NmUwR9aQfeSJ3bpg4JTA6lscKl45qPWN
         6T3zevl0gODP6eFdmrly+L4bcsPH5gNyulk9ZDsKq1b4dww/trz3agtFckyPF9lVBzIY
         Bq8nlxMJWAqoGbfDg/yPP4G11XH4ORw7+tawjuYz4CK55fq5LS3u90ygOwO7OsoCI1ot
         5ANMBGquYFldlAUcOCMV5iZ5UdGDmEsY9Kd/rFlgmp6ckUvdI3fto/kEghSDnTiWTd1I
         mOMX8hG6tAkshlFOo7St4mjuRvREkqD6v3NADFHZqy7ubP7NTs8Fw2nXlkUHqYtWldAe
         l4eA==
X-Gm-Message-State: AOJu0Yw1xc2nETVQtmAlsB2qE1j5EM6yJvcK04IDRXDH3YeHNaAqiCWW
	ZBqNlK3Bw9TOcUezMwkP46HHyBGd60c=
X-Google-Smtp-Source: AGHT+IHSK3HhKBJ7ZhSEC/Yk6cuiIDRsNaPhkGxTvZ19QH1w/kNEzUgOLPhNlAaLOMSnJzJs4UtSwg==
X-Received: by 2002:a54:4018:0:b0:3ac:a4ec:e136 with SMTP id x24-20020a544018000000b003aca4ece136mr3107967oie.51.1697744388022;
        Thu, 19 Oct 2023 12:39:48 -0700 (PDT)
Received: from u.ad.analog.com (cpc99472-lich12-2-0-cust1752.3-2.cable.virginm.net. [80.2.214.217])
        by smtp.gmail.com with ESMTPSA id ph5-20020a0562144a4500b0066d0ab215b5sm99940qvb.13.2023.10.19.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:39:47 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 3/7] log: add color.decorate.symbol config option
Date: Thu, 19 Oct 2023 20:39:07 +0100
Message-ID: <20231019193911.1669705-4-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231003205442.22963-1-andy.koppe@gmail.com>
References: <20231003205442.22963-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new 'color.decorate.symbol' config option for determining the color
of the prefix, suffix, separator and arrow symbols used in --decorate
output and related log format placeholders, to allow them to be colored
differently from commit hashes.

For backward compatibility, fall back to the commit hash color that can
be specified with the 'color.diff.commit' option if the new option is
not provided.

Add the setting to the color.decorate.<slot> documentation.

Amend t4207-log-decoration-colors.sh to test it. Put ${c_reset} elements
in the expected output at the end of lines for consistency.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt   |  2 ++
 commit.h                         |  1 +
 log-tree.c                       | 15 ++++++---
 t/t4207-log-decoration-colors.sh | 58 +++++++++++++++++---------------
 4 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index b0e2eccad95..ba9f56885e3 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -92,6 +92,8 @@ color.decorate.<slot>::
 	the stash ref
 `grafted`;;
 	grafted commits (used to implement shallow clones)
+`symbol`;;
+	punctuation surrounding the other elements
 --
 
 color.grep::
diff --git a/commit.h b/commit.h
index 28928833c54..cb13e4d5baa 100644
--- a/commit.h
+++ b/commit.h
@@ -56,6 +56,7 @@ enum decoration_type {
 	DECORATION_REF_STASH,
 	DECORATION_REF_HEAD,
 	DECORATION_GRAFTED,
+	DECORATION_SYMBOL,
 };
 
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
diff --git a/log-tree.c b/log-tree.c
index 8bdf889f022..890024f205b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -41,6 +41,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	[DECORATION_REF_STASH]	= GIT_COLOR_BOLD_MAGENTA,
 	[DECORATION_REF_HEAD]	= GIT_COLOR_BOLD_CYAN,
 	[DECORATION_GRAFTED]	= GIT_COLOR_BOLD_BLUE,
+	[DECORATION_SYMBOL]	= GIT_COLOR_NIL,
 };
 
 static const char *color_decorate_slots[] = {
@@ -50,6 +51,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_STASH]	= "stash",
 	[DECORATION_REF_HEAD]	= "HEAD",
 	[DECORATION_GRAFTED]	= "grafted",
+	[DECORATION_SYMBOL]	= "symbol",
 };
 
 static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
@@ -312,7 +314,7 @@ void format_decorations(struct strbuf *sb,
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
-	const char *color_commit, *color_reset;
+	const char *color_symbol, *color_reset;
 
 	const char *prefix = " (";
 	const char *suffix = ")";
@@ -337,7 +339,10 @@ void format_decorations(struct strbuf *sb,
 			tag = opts->tag;
 	}
 
-	color_commit = diff_get_color(use_color, DIFF_COMMIT);
+	color_symbol = decorate_get_color(use_color, DECORATION_SYMBOL);
+	if (color_is_nil(color_symbol))
+		color_symbol = diff_get_color(use_color, DIFF_COMMIT);
+
 	color_reset = decorate_get_color(use_color, DECORATION_NONE);
 
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
@@ -352,7 +357,7 @@ void format_decorations(struct strbuf *sb,
 				decorate_get_color(use_color, decoration->type);
 
 			if (*prefix) {
-				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, color_symbol);
 				strbuf_addstr(sb, prefix);
 				strbuf_addstr(sb, color_reset);
 			}
@@ -369,7 +374,7 @@ void format_decorations(struct strbuf *sb,
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, color_symbol);
 				strbuf_addstr(sb, pointer);
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
@@ -382,7 +387,7 @@ void format_decorations(struct strbuf *sb,
 		decoration = decoration->next;
 	}
 	if (*suffix) {
-		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, color_symbol);
 		strbuf_addstr(sb, suffix);
 		strbuf_addstr(sb, color_reset);
 	}
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 21986a866df..f4173b61141 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
 	git config color.decorate.grafted black &&
+	git config color.decorate.symbol white &&
 	git config color.decorate.HEAD cyan &&
 
 	c_reset="<RESET>" &&
@@ -29,6 +30,7 @@ test_expect_success setup '
 	c_stash="<MAGENTA>" &&
 	c_HEAD="<CYAN>" &&
 	c_grafted="<BLACK>" &&
+	c_symbol="<WHITE>" &&
 
 	test_commit A &&
 	git clone . other &&
@@ -53,17 +55,17 @@ cmp_filtered_decorations () {
 # to this test since it does not contain any decoration, hence --first-parent
 test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
-${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbol})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_symbol}, ${c_reset}\
+${c_remoteBranch}other/main${c_reset}${c_symbol})${c_reset} A1
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_stash}refs/stash${c_reset}${c_symbol})${c_reset} On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -78,14 +80,14 @@ test_expect_success 'test coloring with replace-objects' '
 	git replace HEAD~1 HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
-${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_symbol})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_symbol}, ${c_reset}\
+${c_grafted}replaced${c_reset}${c_symbol})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -104,15 +106,15 @@ test_expect_success 'test coloring with grafted commit' '
 	git replace --graft HEAD HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
-${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_symbol}, ${c_reset}\
+${c_grafted}replaced${c_reset}${c_symbol})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbol})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.42.GIT

