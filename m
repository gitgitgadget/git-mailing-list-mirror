Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021F1FC7DB
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878780; cv=none; b=SLY30dCfR2U3fFiwSYisw7IGzSUKlKXEI0WnoWG0yp/C/ZPpdOc8zxmzqAMPH1v6jWuncaA9K2TEQbxZ9f0ywQKSgbJVociYteOOAi1xEde2mK0p6+pHhG5EjBWmv3i6k0d7N3ucxrnQHrsMr6gcfqyN5t3o5weHBLDjUJdmTjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878780; c=relaxed/simple;
	bh=ktZ+MsZJt0M8+qOwqt1nYfjcy5u+SiBPhBAikUMsNxE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ePIKiGrS4VwhWIERazoi6ZfPF+xeMEK/yGH5t/Qbzj94QeQkP0Lz1hlsu3ahxcyzow1F5Ipxw/Dkw9c8MiKkxiF8ZEA21fxz4Hnlh+DQmR58es3O5jKD9zwDhMXeL5GVCUlSjOehnat+YVOYSrgfN5hUplhCfmHM52RMlTvkfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOGa4KWp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOGa4KWp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43675b1155bso66413775e9.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736878776; x=1737483576; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBfLW8TpX2afxoFgo+MLxTKUFOHD3OTs4G69U9T1e68=;
        b=OOGa4KWp0TPhYtdAR2uIVnC6mtVN4snsVCDXSTUJOXLP+XEobkCO5l7MLKcQM+sFCD
         JgjwE+e91IBmronXWJCdiSeMnz39aHYrYH2yvWzEYfgINGD9V2k0tQhrm+abK33hJova
         uKMxHl87b3a9ZfR2gEFotZhGnhZPvxZFRwxY22Vn34oGxKqV9tYvO5iB64btQpLRS0Tp
         bp8U94MyhzvQDgviaWTpnJ/g5d5ikxyu087iHj5kX8G9Z9+WqRdqsZ/Ws6QJob8Dc6Vp
         5aCzh1qiJ065+f+bp8IuXzyV2gCyBXN16U6xICl9/D6ERXuRUzNot8YJVhdqDvvEKNkC
         vPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878776; x=1737483576;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBfLW8TpX2afxoFgo+MLxTKUFOHD3OTs4G69U9T1e68=;
        b=oITgMyWcIeZT9yWf1YPqdz94sjGC+J7iYaI0tDvZiKpWQW8Tpci3CFKH/Cdd83Kq0L
         Xx7vAbLEUvC17FzpwW1+XxtWBSpj4ARCqCAYob7VglqCcjMtzHaWXU6ptWORfv3rp+kK
         cT9w9pBE1Fsc+Z7pFa8BokhznCd4Qd4z2woDxo32sRb0Pfqrwz/ZOZzhcIOwmsqOC6zJ
         7hBXGayWcu9T48OYpyJCTqp2WL9NhxhemO+4xSicWUXflrQK1LvIGYy3GriTDesSf4ft
         CvmxzDtdC3RFVVMWxpjfiKjmufTP+8Rx3qFFB1qVSqJXUBmTDYSHvSs9QH0mYUhDv5/V
         Y5oQ==
X-Gm-Message-State: AOJu0YwO9mp9R1Zz0AiCp9I4UDh8t5Ek+WXk30z5L3Bno0DkIMhqaIsa
	y+SbGWb2QKwRc6LMPwyA4zJ/U1qgG0LuavMb2/XNhGIxYLZMhUWGmhOlpQ==
X-Gm-Gg: ASbGnctUhjQ+Rij7h5jJd1A6rvjqPtvB/uSdmtidMU0O38k5Cl9IUZQ5aKPlQomrej/
	PKvgsxedDux2jXQujqxiRBD1wNFm/PcJQ9vW02IFLaUV1gDKSWJ8NPiNo80XuY5NzAUKCj1oEmr
	1V3YA2imrk3/m+IG0JT50Vzb1HWS4jufOzTaEnmxyrr3c9dUjDC/qRy60xkFnCzc9D7bdw0ZXkU
	Sefac/YI4EAAtlTh47yoDkjF5nM3V5XMwdkXpUEDJRw6wXvScJl6cc20w==
X-Google-Smtp-Source: AGHT+IHsTF4ecwc6Q8deR1i1UxfpA6D/3952tTnrbRI8tYYY5J6hhrp4MoTEw0J8U5KBIS5Gzdb1Wg==
X-Received: by 2002:a05:600c:1d0c:b0:434:ff25:19a0 with SMTP id 5b1f17b1804b1-436e2706f7emr202431575e9.21.1736878775953;
        Tue, 14 Jan 2025 10:19:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92f7bsm219415225e9.38.2025.01.14.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:19:35 -0800 (PST)
Message-Id: <a26c4ed6cec6f0c63696234b0f91f28bab91c40f.1736878772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jan 2025 18:19:32 +0000
Subject: [PATCH 3/3] sideband: do allow ANSI color sequences by default
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The preceding two commits introduced special handling of the sideband
channel to neutralize ANSI escape sequences before sending the payload
to the terminal, and `sideband.allowControlCharacters` to override that
behavior.

However, some `pre-receive` hooks that are actively used in practice
want to color their messages and therefore rely on the fact that Git
passes them through to the terminal.

In contrast to other ANSI escape sequences, it is highly unlikely that
coloring sequences can be essential tools in attack vectors that mislead
Git users e.g. by hiding crucial information.

Therefore we can have both: Continue to allow ANSI coloring sequences to
be passed to the terminal, and neutralize all other ANSI escape
sequences.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/sideband.txt   | 17 ++++++--
 sideband.c                          | 61 ++++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh | 16 +++++++-
 3 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
index 3fb5045cd79..f347fd6b330 100644
--- a/Documentation/config/sideband.txt
+++ b/Documentation/config/sideband.txt
@@ -1,5 +1,16 @@
 sideband.allowControlCharacters::
 	By default, control characters that are delivered via the sideband
-	are masked, to prevent potentially unwanted ANSI escape sequences
-	from being sent to the terminal. Use this config setting to override
-	this behavior.
+	are masked, except ANSI color sequences. This prevents potentially
+	unwanted ANSI escape sequences from being sent to the terminal. Use
+	this config setting to override this behavior:
++
+--
+	color::
+		Allow ANSI color sequences, line feeds and horizontal tabs,
+		but mask all other control characters. This is the default.
+	false::
+		Mask all control characters other than line feeds and
+		horizontal tabs.
+	true::
+		Allow all control characters to be sent to the terminal.
+--
diff --git a/sideband.c b/sideband.c
index b38a869c7b5..9763dea0531 100644
--- a/sideband.c
+++ b/sideband.c
@@ -25,7 +25,11 @@ static struct keyword_entry keywords[] = {
 	{ "error",	GIT_COLOR_BOLD_RED },
 };
 
-static int allow_control_characters;
+static enum {
+	ALLOW_NO_CONTROL_CHARACTERS = 0,
+	ALLOW_ALL_CONTROL_CHARACTERS = 1,
+	ALLOW_ANSI_COLOR_SEQUENCES = 2
+} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
@@ -40,8 +44,24 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
-	git_config_get_bool("sideband.allowcontrolcharacters",
-			    &allow_control_characters);
+	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)) {
+	case 0: /* Boolean value */
+		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
+			ALLOW_NO_CONTROL_CHARACTERS;
+		break;
+	case -1: /* non-Boolean value */
+		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
+					      &value))
+			; /* huh? `get_maybe_bool()` returned -1 */
+		else if (!strcmp(value, "color"))
+			allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
+		else
+			warning(_("unrecognized value for `sideband."
+				  "allowControlCharacters`: '%s'"), value);
+		break;
+	default:
+		break; /* not configured */
+	}
 
 	if (!git_config_get_string_tmp(key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
@@ -70,9 +90,37 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
 
+static int handle_ansi_color_sequence(struct strbuf *dest, const char *src, int n)
+{
+	int i;
+
+	/*
+	 * Valid ANSI color sequences are of the form
+	 *
+	 * ESC [ [<n> [; <n>]*] m
+	 */
+
+	if (allow_control_characters != ALLOW_ANSI_COLOR_SEQUENCES ||
+	    n < 3 || src[0] != '\x1b' || src[1] != '[')
+		return 0;
+
+	for (i = 2; i < n; i++) {
+		if (src[i] == 'm') {
+			strbuf_add(dest, src, i + 1);
+			return i;
+		}
+		if (!isdigit(src[i]) && src[i] != ';')
+			break;
+	}
+
+	return 0;
+}
+
 static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 {
-	if (allow_control_characters) {
+	int i;
+
+	if (allow_control_characters == ALLOW_ALL_CONTROL_CHARACTERS) {
 		strbuf_add(dest, src, n);
 		return;
 	}
@@ -81,7 +129,10 @@ static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
 			strbuf_addch(dest, *src);
-		else {
+		else if ((i = handle_ansi_color_sequence(dest, src, n))) {
+			src += i;
+			n -= i;
+		} else {
 			strbuf_addch(dest, '^');
 			strbuf_addch(dest, 0x40 + *src);
 		}
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 5806e5a67b3..98c575e2e7f 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -101,7 +101,7 @@ test_expect_success 'fallback to color.ui' '
 
 test_expect_success 'disallow (color) control sequences in sideband' '
 	write_script .git/color-me-surprised <<-\EOF &&
-	printf "error: Have you \\033[31mread\\033[m this?\\n" >&2
+	printf "error: Have you \\033[31mread\\033[m this?\\a\\n" >&2
 	exec "$@"
 	EOF
 	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
@@ -109,12 +109,24 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 
 	git clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
+	test_grep RED decoded &&
+	test_grep "\\^G" stderr &&
+	tr -dc "\\007" <stderr >actual &&
+	test_must_be_empty actual &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters=false \
+		clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
 	test_grep ! RED decoded &&
+	test_grep "\\^G" stderr &&
 
 	rm -rf throw-away &&
 	git -c sideband.allowControlCharacters clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
-	test_grep RED decoded
+	test_grep RED decoded &&
+	tr -dc "\\007" <stderr >actual &&
+	test_file_not_empty actual
 '
 
 test_done
-- 
gitgitgadget
