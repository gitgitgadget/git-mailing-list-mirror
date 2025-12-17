Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D733DECC
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981431; cv=none; b=mLVTnDwl2Rrlun9V+IXIGqsFMDGfujOHKhjqPkLhNOt6a0tu9RlADnSuOS/4hU61m1mfqbWv0mH+KwmGOeOGIVYRz4unUjvZwbDWk9TsZL+hkfEMKZOhm6g8IiDDENKes4d/9wHFOco48/ZcWa3nmt4ucAOoBgWnP+W+7Cqm1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981431; c=relaxed/simple;
	bh=FaW8PCD9tRdtA4IJbSKgAeUAXXDuLmw4qAL+/7EVza8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dAtpG0YTce6j8jn1UJvC7Cqqk/sFEGnzLiK45eeUhwFA3XJXwzjJ7tjjUyPC5nTr6g4rd8pX4mjcdzoa6GxpxsJs+qr17LixCjtNE5oZrvV9zOIFx1i/TJ/9HYWkg1R1jjhBUvdDntBhwzMQ26+Bn2Fw/lfeOT0Y7mxTiy6Lw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGPbUFYZ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGPbUFYZ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a35a00506so49003226d6.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981427; x=1766586227; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bB8rkTMIsF6zNfje7FXgy951zIkqpRSUeCZ7ElOADck=;
        b=NGPbUFYZnK6dOy8ue6NeKj/7T2d/BtBeIVdcPB/bmuino8CfV8EWsP9U7E+brTaXjY
         EYg73Gt1R7XjEzsv3+TySt1yfbdf+82AgdHMldauxrKAnm8SQLUSsLNO5+p200QSTN4p
         AXzXW27iu5eUqRtmtu8ym73iXhw/BMMRxOrr8jtkA/QT/29kp4gZkT50se6DcISDXWZx
         dsVp2vCYrbic2MHOYfwy+aU4tpj4qaF14oea1pEcNRmM9Oy/Szf+6CjJVMBp2W5pGy4R
         stlIJFC87+L0rLdK5GOc3D4yY9M5OjIvpBI1dA5U1W0wNNb+JlZzNJooJegFLQKGZuPg
         Yrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981427; x=1766586227;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bB8rkTMIsF6zNfje7FXgy951zIkqpRSUeCZ7ElOADck=;
        b=KClMxbleA8P+suoxFz5m6GIVHFtYpJiMJYpD1oMS5cBqusv9J9auRhJUqNSPmHlFX3
         NsLE56CQGLUcSHlS9aZwf6Q6e7DQmiO4X4c/G88dWiTDg7pqwX4Z7Puo480nlzQ+/Vvz
         6CznuFYhlfc26ZlUUgMMK306WtcLA3uWpQxUQ8LO/Sj7l+K6oRQqjcoUDJA8/O+ZkwLS
         TVlMMPjrtIQl/ofDUU88EwMIoFP9YmYyPm5cJIC+1ntTSKAyman1seLl9FlyysG8i0nH
         9De+RT55Uq3yTwjqZfcDW0/dHAB4Os7/TQ05ojnjBTB3nuHp0hUyxkqUhVEO7Nc4lH7A
         Utbw==
X-Gm-Message-State: AOJu0YyOFIEoBwmII71S9DIX6FYi6xE2I45gB+Jvf3yiAFsrrMpc7Vzi
	qrgar/UxRdmWCDITAiaAp5fHqV6u2sP52FS8bSBnP9l6YNmqiYgNunMI8wwMCiAMcxw=
X-Gm-Gg: AY/fxX7mB6P0z8HozJoJ8kt60Eaw7blEfIVjsvVoW8/Io+TJIuLqzQpp3NK3oTf14Wu
	QyJcsqYndQh/9TKYpK6ABzB5WLrFDdFjZtoXLiPu0y8ij/gV0OzXzUpKN5KjJYbTxSD5RwjaWdg
	+9N5kgH5YbvhhpoOLOZpSrsE5v8Ue8o0X5IFjIiA4RkuJbyBItBdsIvZr6ZHkf8nnWI2+ugeHbO
	l2HyZRArPMmShEpISUMKVRreFYIHCL4QFyt/w6ZRV7lsXYCTCH7qgYEGc7KFGWJYX2EwEfq8X2S
	BGCMvP1zqFe+XstR0mfUrN88MUuGOxcYp6i8VYq1fPO4dAsnQ9H/MAuukBqI0p3t/e3B5cYIwR3
	IWEI6zVzmnO46gi6xue2dm/kV4xhxjIXQo76znjxffWuT0ott4kwTBycP5DYPpSd68r1xsVkZ2o
	cbLK/3T4FoGA2hbQ==
X-Google-Smtp-Source: AGHT+IGfRUz5qaTR0ppBT3j4mL0F2Ngr0Dk3vtnIcjOfFWR/iQkLQojDD5w58phjc4QnTioSz8YNVw==
X-Received: by 2002:ad4:5fc7:0:b0:882:4632:cf7e with SMTP id 6a1803df08f44-8887dfe38c2mr264416636d6.12.1765981427494;
        Wed, 17 Dec 2025 06:23:47 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85efeb1sm96800436d6.48.2025.12.17.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:23:46 -0800 (PST)
Message-Id: <2615abd8c5d5c55486cf5885c47e09e52fad61b8.1765981422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:23:40 +0000
Subject: [PATCH v2 2/4] sideband: introduce an "escape hatch" to allow control
 characters
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

The preceding commit fixed the vulnerability whereas sideband messages
(that are under the control of the remote server) could contain ANSI
escape sequences that would be sent to the terminal verbatim.

However, this fix may not be desirable under all circumstances, e.g.
when remote servers deliberately add coloring to their messages to
increase their urgency.

To help with those use cases, give users a way to opt-out of the
protections: `sideband.allowControlCharacters`.

Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt            |  2 ++
 Documentation/config/sideband.txt   |  5 +++++
 sideband.c                          | 10 ++++++++++
 t/t5409-colorize-remote-messages.sh |  8 +++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sideband.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8c0b3ed807..48870bb588 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -522,6 +522,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sideband.txt[]
+
 include::config/sparse.txt[]
 
 include::config/splitindex.txt[]
diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
new file mode 100644
index 0000000000..3fb5045cd7
--- /dev/null
+++ b/Documentation/config/sideband.txt
@@ -0,0 +1,5 @@
+sideband.allowControlCharacters::
+	By default, control characters that are delivered via the sideband
+	are masked, to prevent potentially unwanted ANSI escape sequences
+	from being sent to the terminal. Use this config setting to override
+	this behavior.
diff --git a/sideband.c b/sideband.c
index fc1805dcf8..997430f2ea 100644
--- a/sideband.c
+++ b/sideband.c
@@ -25,6 +25,8 @@ static struct keyword_entry keywords[] = {
 	{ "error",	GIT_COLOR_BOLD_RED },
 };
 
+static int allow_control_characters;
+
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
 {
@@ -38,6 +40,9 @@ static int use_sideband_colors(void)
 	if (use_sideband_colors_cached >= 0)
 		return use_sideband_colors_cached;
 
+	git_config_get_bool("sideband.allowcontrolcharacters",
+			    &allow_control_characters);
+
 	if (!git_config_get_string_tmp(key, &value))
 		use_sideband_colors_cached = git_config_colorbool(key, value);
 	else if (!git_config_get_string_tmp("color.ui", &value))
@@ -67,6 +72,11 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
 
 static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 {
+	if (allow_control_characters) {
+		strbuf_add(dest, src, n);
+		return;
+	}
+
 	strbuf_grow(dest, n);
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src == '\t' || *src == '\n')
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index f4712f4161..e8067df591 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -106,9 +106,15 @@ test_expect_success 'disallow (color) control sequences in sideband' '
 	EOF
 	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
 	test_commit need-at-least-one-commit &&
+
 	git clone --no-local . throw-away 2>stderr &&
 	test_decode_color <stderr >decoded &&
-	test_grep ! RED decoded
+	test_grep ! RED decoded &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >decoded &&
+	test_grep RED decoded
 '
 
 test_done
-- 
gitgitgadget

