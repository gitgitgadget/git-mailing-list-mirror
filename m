Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5E27280B
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759095020; cv=none; b=qDmZDyoFCeI0hJen+/jpoXWMmQl4txmCQ0Hhy8V1J2GvmiMSQk54+7/qMtE1sFBsSR4XSMvyBk8SsyMc5L0GQCheI+6DI/qUrCNnwGHwvUh7MDaYwYl9wn3aIRe+9KDrfVMaNQhmjqigh8+/om0TS+zhQ+zWk5Wb/eRg7EK2hJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759095020; c=relaxed/simple;
	bh=gpvb66p+D8+pqNkkR+7UGdP9PL3bSCG3bkL4pwtOtQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZDPVWHUs7Nbz3GOVnXVV+XFLIm7NiEb0Ps/B1bEMUP/gnf/DjP8W50TUEJ+6c1yv9dhONeLXimxjwViS2WqqJHGulJjCSR0PkHIQzARMiPOyk+Y0A/ANj7LXEu2qFg89CUI4PiQ8L1kHQTrq+hLWg9uRJnl7tzJG8p69FvL8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8LjWcU6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8LjWcU6"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d605c6501so39559257b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759095016; x=1759699816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOD3EzTAY6fae6vEfIvPOeQy93Ojgv+6M0DJgE6Vkj0=;
        b=Z8LjWcU6l70m1Uc/c9znXe+Yg0FVQPgTJ3i3pREBc68Pqh+JuMlybu9WmnP5tIRF8v
         7g+utR8CojFQbrvw+lnaqeLw5dK01pwFj/YgAmn7TIUqGhUq8Jk63vXhGKbHCYzbHWL0
         UsRTmC6nkdGPUd+tLzU8fm6gJcH+Wts2HwobhhWjDhHf1Xozl2fhya+3Rkudto/7xRqo
         NTCKABI9idHUI+APJ+sHXPRZjCuP9oBFJLarG36PdhH0wigdcJy1w9YbL319CiBXQcRL
         1x9HTJv92xTCTqDXRUmd59xtCU+HhE20aT/nHN7E/zBcFNt/fDlr/502IOKuKNKd00gj
         9tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759095016; x=1759699816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOD3EzTAY6fae6vEfIvPOeQy93Ojgv+6M0DJgE6Vkj0=;
        b=CBeRBrxWohipSFQ5lwBubfaKq20VWBB/QOaR8G4yoLNEGRPuKuXpwrlurE8y5yTNT7
         jU0Ws/soEymW4xO7Vinf2O19QpI6w45K2yWkD2sGpkOlfYrm35+HPHHt0hSOeiLDM8OM
         wZJE9kJ0MHLcDPHJHEJhcOOEPYc0cX9XURb63YEuGcmAHuiaB0fvfaNyWFdrGb4a+Lou
         NLcTWm9R9HsIICJVO4gXnSdCl0ojg5C7Rr5mKwwspKXU/JvV37YXgw6DRwTr1/DEbHu3
         QIDQd0Bz0DStPf42RNs58wUB3VZ3VFSwI45K2qVd55Vvi2DCZ9XCegFRX5wyUPTZfaso
         auzQ==
X-Gm-Message-State: AOJu0YydhkHLssQkMgQPKHtg1v2EpQyOa2upde8zqI8BWwEmgmPSYo2Y
	Xwf3r3t7uMP/mYJ9CEbRtRP9E4qHD84WW9WYh7u6HAkB8FOu27ZpXEkNU9AJALnb
X-Gm-Gg: ASbGncvOGI35uUGWcCN0t8n7dZ3zH9pGVu90H9ce/qWQ5XExykAw3bnJh7+UehCotnm
	unUwHQ35bf653dsLUmwsNYoPsLGo7hEh6Qflfsq75x8j9DV1aQWI9If1EAoeDlh09q8I6rsgx+0
	/pc8sGhxVAoElKCd2KMDoz9LqAPCu+yo3Vt8u7PSyxGCYbXj5NufKLCNowcUkgbPNepw/pcpmqX
	9OBDS4rszOQJXZNjRpgld244iWGFgRKLtBMo2vWN2AgKoAZds68ysoYvIff4hIhXlA0au8iNPgH
	+EWL9NLZsV0RPPlQyJ0g/5re/inL+zrlic/yxCdAYYDEGsfuRldMy8GnLMM7507b760PEqZ+GJg
	aNH3VBtSIlXQOW/qcE/HD9sX3EgKk1VjFFRqGBwHjCnBRwdUKHgr7NzMeew5UHlVFfGSBPHLVX6
	4yquiJog==
X-Google-Smtp-Source: AGHT+IFjovxmRGWFazCGgusXt9E16DK/gzG1UCE0TN0baqdjOmWI65KQRHUnMnh+Nsh1HjPfGo2HvQ==
X-Received: by 2002:a05:690c:6c0d:b0:765:37fb:6fc8 with SMTP id 00721157ae682-765381a0a2fmr167448807b3.26.1759095016399;
        Sun, 28 Sep 2025 14:30:16 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:488:b20c:c605:ba83])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63ad64e5d45sm51448d50.29.2025.09.28.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:30:16 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Noah Pendleton <noah.pendleton@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thranur Andul <thranur@gmail.com>,
	Michael Grosser <grosser.michael@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Calvin Wan <calvinwan@google.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 2/3] config: values of pathname type can be prefixed with :(optional)
Date: Sun, 28 Sep 2025 17:29:15 -0400
Message-ID: <5c97f580a9e77c464bc6bf4ed9ea8546711c6637.1759094936.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1759094936.git.ben.knoble+github@gmail.com>
References: <20250501214057.371711-1-gitster@pobox.com> <cover.1759094936.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Sometimes people want to specify additional configuration data
as "best effort" basis.  Maybe commit.template configuration file points
at somewhere in ~/template/ but on a particular system, the file may not
exist and the user may be OK without using the template in such a case.

When the value given to a configuration variable whose type is
pathname wants to signal such an optional file, it can be marked by
prepending ":(optional)" in front of it.  Such a setting that is
marked optional would avoid getting the command barf for a missing
file, as an optional configuration setting that names a missing
file is not even seen.

cf. <xmqq5ywehb69.fsf@gitster.g>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    The 2nd paragraph in this commit is wrapped strangely
    
    I've kept the strange wrapping length for now, but can reflow it if
    desired.

 Documentation/config.adoc                 |  4 +++-
 config.c                                  | 16 ++++++++++++++--
 t/t7500-commit-template-squash-signoff.sh |  9 +++++++++
 wrapper.c                                 | 13 +++++++++++++
 wrapper.h                                 |  4 +++-
 5 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index cc769251be..7301ced836 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -358,7 +358,9 @@ compiled without runtime prefix support, the compiled-in prefix will be
 substituted instead. In the unlikely event that a literal path needs to
 be specified that should _not_ be expanded, it needs to be prefixed by
 `./`, like so: `./%(prefix)/bin`.
-
++
+If prefixed with `:(optional)`, the configuration variable is treated
+as if it does not exist, if the named path does not exist.
 
 Variables
 ~~~~~~~~~
diff --git a/config.c b/config.c
index 97ffef4270..73fc74c8fa 100644
--- a/config.c
+++ b/config.c
@@ -1279,11 +1279,23 @@ int git_config_string(char **dest, const char *var, const char *value)
 
 int git_config_pathname(char **dest, const char *var, const char *value)
 {
+	int is_optional;
+	char *path;
+
 	if (!value)
 		return config_error_nonbool(var);
-	*dest = interpolate_path(value, 0);
-	if (!*dest)
+
+	is_optional = skip_prefix(value, ":(optional)", &value);
+	path = interpolate_path(value, 0);
+	if (!path)
 		die(_("failed to expand user dir in: '%s'"), value);
+
+	if (is_optional && is_missing_file(path)) {
+		free(path);
+		return 0;
+	}
+
+	*dest = path;
 	return 0;
 }
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 05cda50186..366f7f23b3 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -46,6 +46,15 @@ commit_msg_is ()
 	)
 '
 
+test_expect_success 'nonexistent optional template file in config' '
+	test_config commit.template ":(optional)$PWD"/notexist &&
+	(
+		GIT_EDITOR="echo hello >\"\$1\"" &&
+		export GIT_EDITOR &&
+		git commit --allow-empty
+	)
+'
+
 # From now on we'll use a template file that exists.
 TEMPLATE="$PWD"/template
 
diff --git a/wrapper.c b/wrapper.c
index 2f00d2ac87..3d507d4204 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -721,6 +721,19 @@ int xgethostname(char *buf, size_t len)
 	return ret;
 }
 
+int is_missing_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return 0;
+}
+
 int is_empty_or_missing_file(const char *filename)
 {
 	struct stat st;
diff --git a/wrapper.h b/wrapper.h
index 7df824e34a..44a8597ac3 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -66,7 +66,9 @@ void write_file_buf(const char *path, const char *buf, size_t len);
 __attribute__((format (printf, 2, 3)))
 void write_file(const char *path, const char *fmt, ...);
 
-/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+/* Return 1 if the file does not exist, 0 otherwise. */
+int is_missing_file(const char *filename);
+/* Return 1 if the file is empty or does not exist, 0 otherwise. */
 int is_empty_or_missing_file(const char *filename);
 
 enum fsync_action {
-- 
2.48.1

