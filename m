Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E821B9FD
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113899; cv=none; b=d7b2buYI0U86E8FYazoE85GjOAqpaBZHM16ZaN1+My/qCQTWIkglZf4hjfgh5u6fhHBtcNullTCYvxKrNSvR0Hb1AQEVfTiLCOMu82rnePG/nFrtCWlVfe8VBOKC2bA4LTn/4QbegdCGR89l2fP6znZM44r0kKH8jS0qK/8HJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113899; c=relaxed/simple;
	bh=i7DypXkusYJ/mIDVIb9htUBWhDbTohx/pn8DB70gaJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=arXyyr+cxDpGZwYjd8VmltFSg8Cdy2SmDT6I+qylmXMjgw9VwtFweU3rVntSFIVWErHDwEtlCilo+SS2W9pjQ6eoxsR/eMWE/qY9tJuhCn48PC3dMXFAbJ7kvpFr2p+P+JgtG46n2973FZYfiDYfYUziF7XcKxSQKtrWmUjdeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfFyV+m0; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfFyV+m0"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b74f839bdfso424068eec.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113896; x=1770718696; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKYAPYm9YMyqVe9lMMBT2g2xRMKT0mHTlOHspmscauE=;
        b=PfFyV+m0XOyB7FIQ5rs6MwD8bF0S0ZzTuYr+UtgiyjCzSwMe2idf0UKrifK6HNssQ7
         mQ7sWUdPOd/6nJM6PBn3QS4fzgjoQ6vyt6NYgHVA5tXyuXeNOlxzF2Dx1UCBbV9iRmDu
         equ9Oq8rlu/XL2szsRfSdxD3sTeE3tu2Rsa33CGpOvdCczjrWNGaDUcr3DgpDwVTWCoN
         HB641JZvqXHjmXMojWsSjQxzNc1385YaLxpRGZZi8qaR+yNfQjlWj+SLvzm1pVBveDOi
         qfHnL4kP2sj3SD3oOcsy2cagOR4i/AYq9gLv81SKUCAqwsOn3sbJGsVvRVPdO0BSifpo
         jz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113896; x=1770718696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKYAPYm9YMyqVe9lMMBT2g2xRMKT0mHTlOHspmscauE=;
        b=JaKJQJtyDWjcBVt8nA+QffCn/BUrS+Z3NVO/W8wfpCT9gZcd6lZkc9ibokk/BtSRq9
         swFyNLc0XOKVdFwB0bwkJj2FgGGIRnYwlMCicLXIj99YtpIkpLd5TWUP0lNEv7HRLknv
         L2G+JWv+8TDQh9+ZmO1YGq9qyBMIS0aCTsenzRYb4pyXQM3EX7JO+HG0UCeyKyHiczvN
         5vJ2gj1ALQjfcSJ/AWQgQUMLSQmtGw8o2sWrHHz2xppxz+BVpOi+bug0Pjz11NbreSD7
         THV82Bj6FVkvov5WMpFcTA5782nuqZpZkQmM35mZhfiDitlSetA3jR3EFdS5JswZJlRt
         Dj3w==
X-Gm-Message-State: AOJu0YxuyA8R3mb0ff3NTHksyTQcIF66GmiAoRu2mLk4B512hOvgYzj4
	EPA4b6LHJs34esy39wJdg1DeMp+QTQJAU8HIHcS6+fcdmd5e0gd+mP9GsGnca2lp
X-Gm-Gg: AZuq6aJiftnSlJqpMN1IyhlhxCOIVyXZQqXaPOhz0Q4UBDWoqaGsLRW9HDNBI6yB6Mv
	hYX2f4DdgiWzJ6wIFHTuvgyvg4N19CfbdWTP32pxDMJcUwVigeXaX3+o/zEWymKqsXxCEFYfD8r
	7OH6HkOmT/BQedFI7o6WJG0EQx11U7alBpSrsuy8embhM/GYz7dFj0d3O6GDSg6Cm1leURjm/wD
	/C3aqwphcu3teITag9r26DEYu7MkHjCTEVCOBhzhJ3F1OHqjaitdk/8XDLSfLL0L/YMNIJvBovb
	NzBBCAV9PuTmZbrF7HjFxJ6Hlekg44zCd4hCBslGlu7AiXFYDRtaGYySVqKNkKs8iqv9E0c78zK
	4++cQpQ5ZUU9ksvYF6O+/tnC2+DMZDPEczT1KPgD8Pq+6L4MxtiqASCmODOEU9HVoHuxowVe1Om
	4QplWzF6agBgEmDQ==
X-Received: by 2002:a05:7300:a90c:b0:2ad:a3d6:7446 with SMTP id 5a478bee46e88-2b820f26ab1mr873264eec.16.1770113896111;
        Tue, 03 Feb 2026 02:18:16 -0800 (PST)
Received: from [127.0.0.1] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de948esm21567968c88.9.2026.02.03.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:18:15 -0800 (PST)
Message-Id: <8b8244eca96762aa1eba463506a564dba9916cee.1770113882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 10:18:02 +0000
Subject: [PATCH v4 6/6] sideband: delay sanitizing by default to Git v3.0
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The sideband sanitization patches allow ANSI color sequences through
by default, preserving compatibility with pre-receive hooks that
provide colored output during `git push`.

Even so, there is concern that changing any default behavior in a
minor release may have unforeseen consequences. To accommodate this,
defer the secure-by-default behavior to Git v3.0, where breaking
changes are expected.

This gives users and tooling time to prepare, while committing to
address CVE-2024-52005 in Git v3.0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/sideband.adoc  | 11 +++++++++++
 sideband.c                          |  6 +++++-
 t/t5409-colorize-remote-messages.sh | 18 +++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/sideband.adoc b/Documentation/config/sideband.adoc
index 32088bbf2f..800a10a1ef 100644
--- a/Documentation/config/sideband.adoc
+++ b/Documentation/config/sideband.adoc
@@ -1,12 +1,23 @@
 sideband.allowControlCharacters::
+ifdef::with-breaking-changes[]
 	By default, control characters that are delivered via the sideband
 	are masked, except ANSI color sequences. This prevents potentially
+endif::with-breaking-changes[]
+ifndef::with-breaking-changes[]
+	By default, no control characters delivered via the sideband
+	are masked. This is unsafe and will change in Git v3.* to only
+	allow ANSI color sequences by default, preventing potentially
+endif::with-breaking-changes[]
 	unwanted ANSI escape sequences from being sent to the terminal. Use
 	this config setting to override this behavior (the value can be
 	a comma-separated list of the following keywords):
 +
 --
 	`default`::
+ifndef::with-breaking-changes[]
+		Allow any control sequence. This default is unsafe and will
+		change to `color` in Git v3.*.
+endif::with-breaking-changes[]
 	`color`::
 		Allow ANSI color sequences, line feeds and horizontal tabs,
 		but mask all other control characters. This is the default.
diff --git a/sideband.c b/sideband.c
index a90db9e288..650d00b36e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -33,8 +33,12 @@ static enum {
 	ALLOW_ANSI_COLOR_SEQUENCES    = 1<<0,
 	ALLOW_ANSI_CURSOR_MOVEMENTS   = 1<<1,
 	ALLOW_ANSI_ERASE              = 1<<2,
-	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES,
 	ALLOW_ALL_CONTROL_CHARACTERS  = 1<<3,
+#ifdef WITH_BREAKING_CHANGES
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ANSI_COLOR_SEQUENCES,
+#else
+	ALLOW_DEFAULT_ANSI_SEQUENCES  = ALLOW_ALL_CONTROL_CHARACTERS,
+#endif
 } allow_control_characters = ALLOW_CONTROL_SEQUENCES_UNSET;
 
 static inline int skip_prefix_in_csv(const char *value, const char *prefix,
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 3010913bb1..07cbc62736 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -98,6 +98,13 @@ test_expect_success 'fallback to color.ui' '
 	grep "<BOLD;RED>error<RESET>: error" decoded
 '
 
+if test_have_prereq WITH_BREAKING_CHANGES
+then
+	TURN_ON_SANITIZING=already.turned=on
+else
+	TURN_ON_SANITIZING=sideband.allowControlCharacters=color
+fi
+
 test_expect_success 'disallow (color) control sequences in sideband' '
 	write_script .git/color-me-surprised <<-\EOF &&
 	printf "error: Have you \\033[31mread\\033[m this?\\a\\n" >&2
@@ -106,7 +113,7 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
 	test_commit need-at-least-one-commit &&
 
-	git clone --no-local . throw-away 2>stderr &&
+	git -c $TURN_ON_SANITIZING clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
 	test_grep RED decoded &&
 	test_grep "\\^G" stderr &&
@@ -138,7 +145,7 @@ test_decode_csi() {
 	}'
 }
 
-test_expect_success 'control sequences in sideband allowed by default' '
+test_expect_success 'control sequences in sideband allowed by default (in Git v3.8)' '
 	write_script .git/color-me-surprised <<-\EOF &&
 	printf "error: \\033[31mcolor\\033[m\\033[Goverwrite\\033[Gerase\\033[K\\033?25l\\n" >&2
 	exec "$@"
@@ -147,7 +154,7 @@ test_expect_success 'control sequences in sideband allowed by default' '
 	test_commit need-at-least-one-commit-at-least &&
 
 	rm -rf throw-away &&
-	git clone --no-local . throw-away 2>stderr &&
+	git -c $TURN_ON_SANITIZING clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
 	test_grep ! "CSI \\[K" decoded &&
@@ -175,14 +182,15 @@ test_expect_success 'allow all control sequences for a specific URL' '
 	test_commit one-more-please &&
 
 	rm -rf throw-away &&
-	git clone --no-local . throw-away 2>stderr &&
+	git -c $TURN_ON_SANITIZING clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
 	test_grep ! "CSI \\[K" decoded &&
 	test_grep "\\^\\[\\[K" decoded &&
 
 	rm -rf throw-away &&
-	git -c "sideband.file://.allowControlCharacters=true" \
+	git -c sideband.allowControlCharacters=false \
+		-c "sideband.file://.allowControlCharacters=true" \
 		clone --no-local "file://$PWD" throw-away 2>stderr &&
 	test_decode_color <stderr >color-decoded &&
 	test_decode_csi <color-decoded >decoded &&
-- 
gitgitgadget
