Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0273491C7
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981433; cv=none; b=All9i4GHIdnDTCkdqYOl5qxZO8J36YEAKjOWAdMCwPLG4hV9XFnoXERIgAGMIeEMQLP6wGnTVAyWNOrHaUGSqTX5cD3E+GvajS4N8crgcy+NQ5ZHz6l6PD0YtJO824MBzkr/pm1OPpqX4s1QnyghkcAkhivUx5GBgKhvPkcTpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981433; c=relaxed/simple;
	bh=RAssXpUKI2co1ZEbqZGPOLsRxlFCG5yQikDyRY1nrMA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HhHHwvsXkJ+uv97j2nFPZUd53bvzEvEAY9ntCjrwa5t9HetCS66dj2IormeMGERO2NuLZaw6gE+Gm5QfI9Pok+8f8sDtgV8Ug6kNeswOB4A6CWHppSRanL/AkvCmXvHd+LEdI81KHxMqWu1vXBZN7scOxUyuAokUbb8Q2C21zmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6oCJQeW; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6oCJQeW"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a2ad13c24so38403616d6.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981430; x=1766586230; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGjJslJSTsrzvm6pbTUZuO5wGbkP12DguinB01BFtAA=;
        b=j6oCJQeWJhECuBbuLONdWqo62DbV3Gv/oiECxXv2NFwgXDxkWspkN9sUf2NuNwkx3Z
         HqVaGgpinSGPX6mt0OS2fBo8iMiSi9dalGy0K+715eusZOyzv/GlI26u9reM5uCqB6QX
         xcmkDp+FoBgyJiq6W4MdcljUSx0ErsWgTIzVwl45sGM5fZSAvWYwnMQEVhP0yHdiN+XO
         KOCydVneGhSUMYAimJGqbQC11IpqKrBii2Rt8AmH/sPMjlbLCCKFBzgZAPkgX2fJjMdF
         FcSLu6FmmYpAxEEpl0/GhYrnEG8/0a/OynuUbKU9PnxtiIPAVJLKtUu8pBDD+J1lcVUh
         dEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981430; x=1766586230;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGjJslJSTsrzvm6pbTUZuO5wGbkP12DguinB01BFtAA=;
        b=pUgKWYPcfAtRrV285R0kfZAXUj7wU1y5rB4SQGUPJNXgvjnMMl7NCnSwvOQrmEDuTq
         9ZdVyj9eJpIi+VE62uQGgNgqOk/SAwHzaOIBmm8snQtVMjC/8QL8RmptW+EbFmrA66NE
         DtUtQKJlnpgF6tbWo0STnibfbp1PQEZgTmp7avQZ9qUiGVro96ghwjGhvrgftun4WtCa
         gJpU8H34zlRuSwEqy2+bUbJs89Nv6KFgcoXF8/EcTf/9u4kbH4/GTztiygzOLqHA3bFJ
         icHocLlr7k33maj7+9y45CR+IYA9S72jHbpCu0E6azIrzAwDspkwHNzZEckTDcd3O2oz
         QZDg==
X-Gm-Message-State: AOJu0YyXuPNFELZbtxzyIjxK7J4qAfDpg4NuDQGhc+e/eON9y1Ks05BR
	tBxFlVnSrQeC3uFGqaMBkdy/MtdINrYSFsITXWWHUsFb4HV8Q55I7o2n5ToNZfaYTUm+NA==
X-Gm-Gg: AY/fxX62N2S1+3CJ5ZZ3FMBKzEEJTDltp+nX7hQWadHPmFCmAiBY4EqhFMXUfJHjlyi
	2PPjAMqpOqUCdgN0bD0DbtwvKfPDsB7aMIGSMbQ96mTfvwcIJgXHcpMMsWAD1073Rcl0XmsneaG
	qbCKtqE2YhBZGs8OLdGZWGtUS2LbQmWfCE5zAt3E64eRefBp1qzslq6XU1Al46fVikSfW4mLf5G
	51FmljKl/odOcJ+9egTvjkfXra4xaliBHtDtddwuT9nsrZdL5TnEiTilLUJA14yQySfgA2XcXiI
	BGL8W/xk2rp+V5h/XrtoyFBs+zozUm2dYp8LsHKH49NILTE++OzcVjlXNCEqLwCAvYu+I60s61i
	e8iMLf2tcZjAU5NP6VHHKaWEEWNowxjlHOEwUC+m6w8bKB26B2C0n21IVElqWRqfjd+/gkODJBV
	ftlKsyHtUGtw03ew==
X-Google-Smtp-Source: AGHT+IFK+NdqIFd1Q38p5e/57ojdIU/71ZxynYqpOeCe2YSe3smJdtOYCy7wFrLF4MLrMtZqacWa4A==
X-Received: by 2002:a05:6214:3d8d:b0:88a:589b:5dad with SMTP id 6a1803df08f44-88a589b769cmr16132236d6.27.1765981430018;
        Wed, 17 Dec 2025 06:23:50 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85efeb1sm96801226d6.48.2025.12.17.06.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:23:49 -0800 (PST)
Message-Id: <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:23:42 +0000
Subject: [PATCH v2 4/4] sideband: add options to allow more control sequences
 to be passed through
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Even though control sequences that erase characters are quite juicy for
attack scenarios, where attackers are eager to hide traces of suspicious
activities, during the review of the side band sanitizing patch series
concerns were raised that there might be some legimitate scenarios where
Git server's `pre-receive` hooks use those sequences in a benign way.

Control sequences to move the cursor can likewise be used to hide tracks
by overwriting characters, and have been equally pointed out as having
legitimate users.

Let's add options to let users opt into passing through those ANSI
Escape sequences: `sideband.allowControlCharacters` now supports also
`cursor` and `erase`, and it parses the value as a comma-separated list.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/sideband.txt   |  9 ++-
 sideband.c                          | 91 ++++++++++++++++++++++++-----
 t/t5409-colorize-remote-messages.sh | 38 ++++++++++++
 3 files changed, 123 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
index e5b7383c7a..8eb7656cdd 100644
--- a/Documentation/config/sideband.txt
+++ b/Documentation/config/sideband.txt
@@ -2,13 +2,20 @@ sideband.allowControlCharacters::
 	By default, control characters that are delivered via the sideband
 	are masked, except ANSI color sequences. This prevents potentially
 	unwanted ANSI escape sequences from being sent to the terminal. Use
-	this config setting to override this behavior:
+	this config setting to override this behavior (the value can be
+	a comma-separated list of the following keywords):
 +
 --
 	default::
 	color::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
+	cursor::
+		Allow control sequences that move the cursor. This is
+		disabled by default.
+	erase::
+		Allow control sequences that erase charactrs. This is
+		disabled by default.
 	false::
 		Mask all control characters other than line feeds and
 		horizontal tabs.
diff --git a/sideband.c b/sideband.c
index fb43008ab7..725e24db0d 100644
--- a/sideband.c
+++ b/sideband.c
@@ -28,9 +28,43 @@ static struct keyword_entry keywords[] = {
 static enum {
 	ALLOW_NO_CONTROL_CHARACTERS = 0,
 	ALLOW_ANSI_COLOR_SEQUENCES = 1<<0,
+	ALLOW_ANSI_CURSOR_MOVEMENTS = 1<<1,
+	ALLOW_ANSI_ERASE = 1<<2,
 	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
-	ALLOW_ALL_CONTROL_CHARACTERS = 1<<1,
-} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
+	ALLOW_ALL_CONTROL_CHARACTERS = 1<<3,
+} allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
+
+static inline int skip_prefix_in_csv(const char *value, const char *prefix,
+				     const char **out)
+{
+	if (!skip_prefix(value, prefix, &value) ||
+	    (*value && *value != ','))
+		return 0;
+	*out = value + !!*value;
+	return 1;
+}
+
+static void parse_allow_control_characters(const char *value)
+{
+	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
+	while (*value) {
+		if (skip_prefix_in_csv(value, "default", &value))
+			allow_control_characters |= ALLOW_DEFAULT_ANSI_SEQUENCES;
+		else if (skip_prefix_in_csv(value, "color", &value))
+			allow_control_characters |= ALLOW_ANSI_COLOR_SEQUENCES;
+		else if (skip_prefix_in_csv(value, "cursor", &value))
+			allow_control_characters |= ALLOW_ANSI_CURSOR_MOVEMENTS;
+		else if (skip_prefix_in_csv(value, "erase", &value))
+			allow_control_characters |= ALLOW_ANSI_ERASE;
+		else if (skip_prefix_in_csv(value, "true", &value))
+			allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
+		else if (skip_prefix_in_csv(value, "false", &value))
+			allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
+		else
+			warning(_("unrecognized value for `sideband."
+				  "allowControlCharacters`: '%s'"), value);
+	}
+}
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
@@ -54,13 +88,8 @@ static int use_sideband_colors(void)
 		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
 					      &value))
 			; /* huh? `get_maybe_bool()` returned -1 */
-		else if (!strcmp(value, "default"))
-			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
-		else if (!strcmp(value, "color"))
-			allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
 		else
-			warning(_("unrecognized value for `sideband."
-				  "allowControlCharacters`: '%s'"), value);
+			parse_allow_control_characters(value);
 		break;
 	default:
 		break; /* not configured */
@@ -93,7 +122,7 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
-static int handle_ansi_color_sequence(struct strbuf *dest, const char *src, int n)
+static int handle_ansi_sequence(struct strbuf *dest, const char *src, int n)
 {
 	int i;
 
@@ -105,14 +134,47 @@ static int handle_ansi_color_sequence(struct strbuf *dest, const char *src, int
 	 * These are part of the Select Graphic Rendition sequences which
 	 * contain more than just color sequences, for more details see
 	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
+	 *
+	 * The cursor movement sequences are:
+	 *
+	 * ESC [ n A - Cursor up n lines (CUU)
+	 * ESC [ n B - Cursor down n lines (CUD)
+	 * ESC [ n C - Cursor forward n columns (CUF)
+	 * ESC [ n D - Cursor back n columns (CUB)
+	 * ESC [ n E - Cursor next line, beginning (CNL)
+	 * ESC [ n F - Cursor previous line, beginning (CPL)
+	 * ESC [ n G - Cursor to column n (CHA)
+	 * ESC [ n ; m H - Cursor position (row n, col m) (CUP)
+	 * ESC [ n ; m f - Same as H (HVP)
+	 *
+	 * The sequences to erase characters are:
+	 *
+	 *
+	 * ESC [ 0 J - Clear from cursor to end of screen (ED)
+	 * ESC [ 1 J - Clear from cursor to beginning of screen (ED)
+	 * ESC [ 2 J - Clear entire screen (ED)
+	 * ESC [ 3 J - Clear entire screen + scrollback (ED) - xterm extension
+	 * ESC [ 0 K - Clear from cursor to end of line (EL)
+	 * ESC [ 1 K - Clear from cursor to beginning of line (EL)
+	 * ESC [ 2 K - Clear entire line (EL)
+	 * ESC [ n M - Delete n lines (DL)
+	 * ESC [ n P - Delete n characters (DCH)
+	 * ESC [ n X - Erase n characters (ECH)
+	 *
+	 * For a comprehensive list of common ANSI Escape sequences, see
+	 * https://www.xfree86.org/current/ctlseqs.html
 	 */
 
-	if (allow_control_characters != ALLOW_ANSI_COLOR_SEQUENCES ||
-	    n < 3 || src[0] != '\x1b' || src[1] != '[')
+	if (n < 3 || src[0] != '\x1b' || src[1] != '[')
 		return 0;
 
 	for (i = 2; i < n; i++) {
-		if (src[i] == 'm') {
+		if (((allow_control_characters & ALLOW_ANSI_COLOR_SEQUENCES) &&
+		     src[i] == 'm') ||
+		    ((allow_control_characters & ALLOW_ANSI_CURSOR_MOVEMENTS) &&
+		     strchr("ABCDEFGHf", src[i])) ||
+		    ((allow_control_characters & ALLOW_ANSI_ERASE) &&
+		     strchr("JKMPX", src[i]))) {
 			strbuf_add(dest, src, i + 1);
 			return i;
 		}
@@ -127,7 +189,7 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 {
 	int i;
 
-	if (allow_control_characters == ALLOW_ALL_CONTROL_CHARACTERS) {
+	if ((allow_control_characters & ALLOW_ALL_CONTROL_CHARACTERS)) {
 		strbuf_add(dest, src, n);
 		return;
 	}
@@ -136,7 +198,8 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
 			strbuf_addch(dest, *src);
-		else if ((i = handle_ansi_color_sequence(dest, src, n))) {
+		else if (allow_control_characters != ALLOW_NO_CONTROL_CHARACTERS &&
+			 (i = handle_ansi_sequence(dest, src, n))) {
 			src += i;
 			n -= i;
 		} else {
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index f34977b332..c3e4e14362 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -129,4 +129,42 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	test_file_not_empty actual
 '
 
+test_decode_csi() {
+	awk '{
+		while (match($0, /\033/) != 0) {
+			printf "%sCSI ", substr($0, 1, RSTART-1);
+			$0 = substr($0, RSTART + RLENGTH, length($0) - RSTART - RLENGTH + 1);
+		}
+		print
+	}'
+}
+
+test_expect_success 'control sequences in sideband allowed by default' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: \\033[31mcolor\\033[m\\033[Goverwrite\\033[Gerase\\033[K\\033?25l\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
+	test_commit need-at-least-one-commit-at-least &&
+
+	rm -rf throw-away &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep ! "CSI \\[K" decoded &&
+	test_grep ! "CSI \\[G" decoded &&
+	test_grep "\\^\\[?25l" decoded &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters=erase,cursor,color \
+		clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "RED" decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep "CSI \\[G" decoded &&
+	test_grep ! "\\^\\[\\[K" decoded &&
+	test_grep ! "\\^\\[\\[G" decoded
+'
+
 test_done
-- 
gitgitgadget
