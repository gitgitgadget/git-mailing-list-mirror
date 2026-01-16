Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB512749DF
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602385; cv=none; b=kAfe5CEc/nocMjO9rBEEp1z0HajlBztw4xvlBdIXChBsIKKxxrH6qsZlOQvn1M7cw8KGi4CR6Uppx/xgNqK0+VCPLNRPt62ip7po8ZCQpSWptncRHlt+uATld4uMJDIB1ky6xX6/9LETW8Ectn8GbKK9qLE+zgaBtiTyUIOy0kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602385; c=relaxed/simple;
	bh=cwAozM4b4FeKZheCFSlQYZ6vuom+Vgg3FYFlOieiC6M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oHXDMuQYqmwa+rpwsbLMLjN3O9M1GQE4u5PQcg3yHWj64718MZdRPf6q7otoXu6L/JSwgDnVTp/iRVTseVwSLRduD2CnvqaVUnObTkKo0E/hDxD11EahGorATkgltMaoCfDTGlQqJWIlTT9YT8UZx5OIVMcnfPIRS84s+0CQEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9LbOjxz; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9LbOjxz"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c52c67f64cso271233785a.0
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 14:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602383; x=1769207183; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WkiApmvYVgCm+VYAr/X3L5eEOhhwfAB8x/ukA5oP7g=;
        b=K9LbOjxzCOkrQ2X1WeVRPPfCKmjWWpVfb5pPYVX51m665pObkfdPsqxtYE5I45USON
         jJSBeNLeEBksdCX8laYm3YihrGjBbJVB2143kqL6H5qaUGFkIj1BtAQfEwxSUUGpDEhp
         14URnjqM0yBjkFpT8+lHRI/oeP6S9ECgCKk6zWqAB17j6hh8Cy4+CjChCA5PNvTtytCI
         ZvjX6X0kFThhulpJRuuG82QolmmSsB45zMqfCes3ztKM5e7deU61HA0Bw9BXihCLWOkV
         tSeHGHwKOWsLdkF3/42CMtrJ6LRbS05c8dIvtwEssx1fUT9qcg6woX+3IUhNNGFYHsj3
         kwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602383; x=1769207183;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5WkiApmvYVgCm+VYAr/X3L5eEOhhwfAB8x/ukA5oP7g=;
        b=Ru12AkKKaAAO0xBPnIwjVosJgkw+++kYukhmsn03ntbB32ZV6qpgHGBRrsa4ysSOq8
         tm6Hum+ke6BPOoyesiy808/Q5VAVJUSSINVnOijYUsHpq1n8gIpQhGgtWsZYQdimhcKG
         7J5BcobWOTgfz14h1Wjsplb0jtwPpLIUE3rlPwydb0gHAJIAaL+4C45QhEckuVG47zIP
         w+8Vw3SNr1brPTcW4yiV9NM2BELrcn4jNpQld4JimqvCRAxjWprbMlabBg03R1p9Ish5
         LAdatS2o4LLO39UknWd08eC4V9B8Rfr8nW8sqegfKicYCUXnTpteI0K/Sb3i4xJuFVgx
         ISSQ==
X-Gm-Message-State: AOJu0Yzv9AkaYGpk0hrGoPH+VNTIvFjRjJhay20UwuANM4+EyjAO2NQA
	nikqmF4sj+PkZzx+LAlwmf7ZqxeRj+ahevrL0ATPFX9mNHIaOI/6r9OaWBtN9g==
X-Gm-Gg: AY/fxX7/1u9BNyEZ6NFYSovQP7xpN+hBgxXItCz3lZ6KvQcl7JD4bU8RgHZAypLq4i7
	+EtcbLcBrBkOoAMu0KF7yBXNHpvJQ3Bdtvf/J4jIVW68KcSricqomE99Qsuv7tWNQf3Lfgwj3m3
	5EHsgEq0k9eYxUARB2PLv9m3EUqVl5fOx8kMUTvU8lE6KcpOnf4WqUPiR1srYMb8e7sucY0CyNu
	zw6/8d0QGDKQdc3tb/AoJBr46qRu/+tX8BGZ3VAr/1qNONzx6FMU4MJ35cdhdoXqZ/xtbKqV1Ic
	iWTnq2YuJ56GZIZd+xBGL9VxHvgdazlUzmSZv4/n2MliIPem9vkwn+qFfyQ1dFKmS83/b+kim/1
	qIQvE5gaZiXmD7mREPZyfo41s5PwUAhdoBDzqAGeb5Dll5uve22m9CQznFWL0cJ7PEDavv0Sd32
	Fp1cTdgKHiIQJlqQ==
X-Received: by 2002:a05:620a:2699:b0:8c6:b315:1448 with SMTP id af79cd13be357-8c6b315182fmr25727085a.19.1768602382475;
        Fri, 16 Jan 2026 14:26:22 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724ec34sm314208085a.27.2026.01.16.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:26:22 -0800 (PST)
Message-Id: <f2eb0a758ce44a6025c9d7c06b563876c776e7da.1768602373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
References: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 22:26:13 +0000
Subject: [PATCH v3 5/5] sideband: offer to configure sanitizing on a per-URL
 basis
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
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The main objection against sanitizing the sideband that was raised
during the review of the sideband sanitizing patches, first on the
git-security mailing list, then on the public mailing list, was that
there are some setups where server-side `pre-receive` hooks want to
error out, giving colorful messages to the users on the client side (if
they are not redirecting the output into a file, that is).

To avoid breaking such setups, the default chosen by the sideband
sanitizing patches is to pass through ANSI color sequences.

Still, there might be some use case out there where that is not enough.
Therefore the `sideband.allowControlCharacters` config setting allows
for configuring  levels of sanitizing.

As Junio Hamano pointed out, to keep users safe by default, we need to
be able to scope this to some servers because while a user may trust
their company's Git server, the same might not apply to other Git
servers.

To allow for this, let's imitate the way `http.<url>.*` offers
to scope config settings to certain URLs, by letting users
override the `sideband.allowControlCharacters` setting via
`sideband.<url>.allowControlCharacters`.

Suggested-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/sideband.txt   |  4 ++
 sideband.c                          | 81 ++++++++++++++++++++---------
 sideband.h                          | 14 +++++
 t/t5409-colorize-remote-messages.sh | 24 +++++++++
 transport.c                         |  3 ++
 5 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
index 2bf0426284..32088bbf2f 100644
--- a/Documentation/config/sideband.txt
+++ b/Documentation/config/sideband.txt
@@ -22,3 +22,7 @@ sideband.allowControlCharacters::
 	`true`::
 		Allow all control characters to be sent to the terminal.
 --
+
+sideband.<url>.*::
+	Apply the `sideband.*` option selectively to specific URLs. The
+	same URL matching logic applies as for `http.<url>.*` settings.
diff --git a/sideband.c b/sideband.c
index a8568b8b64..a8cd142cd7 100644
--- a/sideband.c
+++ b/sideband.c
@@ -9,6 +9,7 @@
 #include "help.h"
 #include "pkt-line.h"
 #include "write-or-die.h"
+#include "urlmatch.h"
 
 struct keyword_entry {
 	/*
@@ -26,13 +27,14 @@ static struct keyword_entry keywords[] = {
 };
 
 static enum {
-	ALLOW_NO_CONTROL_CHARACTERS  = 0,
-	ALLOW_ANSI_COLOR_SEQUENCES   = 1<<0,
-	ALLOW_ANSI_CURSOR_MOVEMENTS  = 1<<1,
-	ALLOW_ANSI_ERASE             = 1<<2,
-	ALLOW_DEFAULT_ANSI_SEQUENCES = ALLOW_ANSI_COLOR_SEQUENCES,
-	ALLOW_ALL_CONTROL_CHARACTERS = 1<<3,
-} allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
+	ALLOW_CONTROL_SEQUENCES_UNSET = -1,
+	ALLOW_NO_CONTROL_CHARACTERS   = 0,
+	ALLOW_ANSI_COLOR_SEQUENCES    = 1<<0,
+	ALLOW_ANSI_CURSOR_MOVEMENTS   = 1<<1,
+	ALLOW_ANSI_ERASE              = 1<<2,
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES,
+	ALLOW_ALL_CONTROL_CHARACTERS  = 1<<3,
+} allow_control_characters = ALLOW_CONTROL_SEQUENCES_UNSET;
 
 static inline int skip_prefix_in_csv(const char *value, const char *prefix,
 				     const char **out)
@@ -44,8 +46,19 @@ static inline int skip_prefix_in_csv(const char *value, const char *prefix,
 	return 1;
 }
 
-static void parse_allow_control_characters(const char *value)
+int sideband_allow_control_characters_config(const char *var, const char *value)
 {
+	switch (git_parse_maybe_bool(value)) {
+	case 0:
+		allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
+		return 0;
+	case 1:
+		allow_control_characters = ALLOW_ALL_CONTROL_CHARACTERS;
+		return 0;
+	default:
+		break;
+	}
+
 	allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 	while (*value) {
 		if (skip_prefix_in_csv(value, "default", &value))
@@ -61,9 +74,37 @@ static void parse_allow_control_characters(const char *value)
 		else if (skip_prefix_in_csv(value, "false", &value))
 			allow_control_characters = ALLOW_NO_CONTROL_CHARACTERS;
 		else
-			warning(_("unrecognized value for `sideband."
-				  "allowControlCharacters`: '%s'"), value);
+			warning(_("unrecognized value for '%s': '%s'"), var, value);
 	}
+	return 0;
+}
+
+static int sideband_config_callback(const char *var, const char *value,
+				    const struct config_context *ctx UNUSED,
+				    void *data UNUSED)
+{
+	if (!strcmp(var, "sideband.allowcontrolcharacters"))
+		return sideband_allow_control_characters_config(var, value);
+
+	return 0;
+}
+
+void sideband_apply_url_config(const char *url)
+{
+	struct urlmatch_config config = URLMATCH_CONFIG_INIT;
+	char *normalized_url;
+
+	if (!url)
+		BUG("must not call sideband_apply_url_config(NULL)");
+
+	config.section = "sideband";
+	config.collect_fn = sideband_config_callback;
+
+	normalized_url = url_normalize(url, &config.url);
+	git_config(urlmatch_config_entry, &config);
+	free(normalized_url);
+	string_list_clear(&config.vars, 1);
+	urlmatch_config_release(&config);
 }
 
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
@@ -79,20 +120,12 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
-	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)) {
-	case 0: /* Boolean value */
-		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
-			ALLOW_NO_CONTROL_CHARACTERS;
-		break;
-	case -1: /* non-Boolean value */
-		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
-					      &value))
-			; /* huh? `get_maybe_bool()` returned -1 */
-		else
-			parse_allow_control_characters(value);
-		break;
-	default:
-		break; /* not configured */
+	if (allow_control_characters == ALLOW_CONTROL_SEQUENCES_UNSET) {
+		if (!git_config_get_value("sideband.allowcontrolcharacters", &value))
+			sideband_allow_control_characters_config("sideband.allowcontrolcharacters", value);
+
+		if (allow_control_characters == ALLOW_CONTROL_SEQUENCES_UNSET)
+			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
 	}
 
 	if (!git_config_get_string_tmp(key, &value))
diff --git a/sideband.h b/sideband.h
index 5a25331be5..d15fa4015f 100644
--- a/sideband.h
+++ b/sideband.h
@@ -30,4 +30,18 @@ int demultiplex_sideband(const char *me, int status,
 
 void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
+/*
+ * Apply sideband configuration for the given URL. This should be called
+ * when a transport is created to allow URL-specific configuration of
+ * sideband behavior (e.g., sideband.<url>.allowControlCharacters).
+ */
+void sideband_apply_url_config(const char *url);
+
+/*
+ * Parse and set the sideband allow control characters configuration.
+ * The var parameter should be the key name (without section prefix).
+ * Returns 0 if the variable was recognized and handled, non-zero otherwise.
+ */
+int sideband_allow_control_characters_config(const char *var, const char *value);
+
 #endif
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index c3e4e14362..1d039cbdaf 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -167,4 +167,28 @@ test_expect_success 'control sequences in sideband allowed by default' '
 	test_grep ! "\\^\\[\\[G" decoded
 '
 
+test_expect_success 'allow all control sequences for a specific URL' '
+	write_script .git/eraser <<-\EOF &&
+	printf "error: Ohai!\\r\\033[K" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./eraser &&
+	test_commit one-more-please &&
+
+	rm -rf throw-away &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep ! "CSI \\[K" decoded &&
+	test_grep "\\^\\[\\[K" decoded &&
+
+	rm -rf throw-away &&
+	git -c "sideband.file://.allowControlCharacters=true" \
+		clone --no-local "file://$PWD" throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep ! "\\^\\[\\[K" decoded
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 1098bbd60e..e19536c9c6 100644
--- a/transport.c
+++ b/transport.c
@@ -28,6 +28,7 @@
 #include "object-name.h"
 #include "color.h"
 #include "bundle-uri.h"
+#include "sideband.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -1210,6 +1211,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	ret->hash_algo = &hash_algos[GIT_HASH_SHA1];
 
+	sideband_apply_url_config(ret->url);
+
 	return ret;
 }
 
-- 
gitgitgadget
