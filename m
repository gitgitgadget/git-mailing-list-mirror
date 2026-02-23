Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C43364E99
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849633; cv=none; b=TFddxn/oOnmj/l34H4C4ibVzPCuhZeb31vaUAJIzcNaTSNLQriMu4AgSMzGW43Is48E4dc9Uf81z+nbdnNJWeMAqS7wCoebK66f26nupMXogXr8//JuCKqprutTgBeZnyvoa4bdYd2/N0zCbiW4g5a5n6wUY+hNdJlpDJPFdILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849633; c=relaxed/simple;
	bh=ymzdugYXbVzkCRCUpo2nidPQwKgn5LGEM64EXcIxF9c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HR0kmHL8jxD5Oy/1WiD/E1C1Eo+VexkWYArw7QaadOnGcCD4EV42swAYlq8bffjLq9M50VjqVAj6vq+sGYbpxryoyN5SqseLghhoDXqbB8Zl5f75GZqkl+bC9VoZaOAg3B6S7X2SvRqttQRhA5DDxUdpMI+/DCRUlJCYB6SXXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzRozuQe; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzRozuQe"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4138136f02eso2614778fac.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849630; x=1772454430; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV6HWhG6ylRSturtbZv0MzSdKUDpJywXNJtLA3miE84=;
        b=RzRozuQeq+ZXeMeFZq0X7KiPkEWaLvTfbSWrBG4xIi0Hku1IrA1o+3izOf/5/yPbOx
         HDnXuyEdwxYwgW/UmGe8HcjV7zUKg/xFbQKPWkdfrLkd/z1OLsyI6tY/YCE2F+4IsaBU
         XIMNTtcJbG8vIyQbSm5NmLX0iVfLknpCiZpjdGER4ofLc3jopzyrXqLR8bjqT/LEDAnN
         8BOd41q7X41fpctQe78koMuTa9GK69CEanrcu2Ch00Z9OeLdgILjmwWWXIAGAB2N6z7M
         EqBOfuAMVGTyek99gI+VlRFC9RJlbyA9l6W40hpBe34TleyC4w25FzatpFr8okSjq2wD
         g8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849630; x=1772454430;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sV6HWhG6ylRSturtbZv0MzSdKUDpJywXNJtLA3miE84=;
        b=jYW0xPwH9pE5HSU7Ta6pnGzsQCOW+xvco50efY+J/weYuoq9TuFX9w/R4fgJZiIA79
         /4Z8E6NDb9BhqGYxD3P8LeW4hoAPkqCYnsu94lvhUrnMzs+uSYC+lpubMOD4zjUMJWtL
         xSm++9z17BiJPmHRyrF0hqOy0EpyKXlrwPLIanqWknyec5nCOMhgKFjRguDtNhGDzfrL
         vRHjFXRiE1IYZhHzpmSlm8Ewbe4f1pebLmH4Orlyk0OGZrveGJIG8MGTRLtZWRurYsIo
         8yMGv3Bak/N/7eLLp4FDS61wF/kRE+DcgOym8QYpdJVetnJZ5/4l0DrOYXbzYqP4dh3C
         0gIA==
X-Gm-Message-State: AOJu0Yxk/YDv1mUdunVIR4msOpNwI78D5RuMIp2ZUvLEs72UgpKSmj4S
	7hDaS+txOElzD8CXfyWX7dy2qBtNVVkZkzc4e/j181hsn7rnmNBEXWGL5ftrXQ==
X-Gm-Gg: ATEYQzyMhpoo1kyNHwutJkuqLKE3yubLg3M5SsEu07pQAUe3nujEazkPZAk6YfsPc7J
	vpYgOP+K4137HL2hYBNTzdzlS8yQufaiMjWzR83tiIGEg5ScdmgnwGTNCTfMiA/o/RkppURuuYH
	OxZnE9FdjhM+4XLPRXyXMrDt7EqTuacaSxWJOc3wSngSmZdzeTSWNcRMpY0dtDEUf3EimBGp8oV
	cywUuffGD+bEXgrlJ5U3O6G0iK46C4WgdhzLWhza1lQpuTorc/IgnSP/AUfjCZHZwnO7gZhfv/b
	4TKoJzalej7RO43xJRvmrtDOU7NEpmaLwuY8GfudYdYM1/8BqmX8a+M6Mqky6enghbFfzmEmmA8
	tgPy55W4tL/av07wBGKEdQ8orvS+ZVgkaT6besreFbIlIRwTnbYkUDwjBEvLaJZDJ3/3CGIXD4/
	iraN2IQ+mpKupzEjVAWtZtgq8cLQ==
X-Received: by 2002:a05:6871:739c:b0:3d2:5ad4:4e7 with SMTP id 586e51a60fabf-4157b1c5753mr4113295fac.47.1771849630504;
        Mon, 23 Feb 2026 04:27:10 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a24bdsm7234680fac.18.2026.02.23.04.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:09 -0800 (PST)
Message-Id: <7568a0bc349e7cc454a50cc43a1549031ca0ab9b.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:51 +0000
Subject: [PATCH v3 09/13] config: format expiry dates quietly
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
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting expiry date config values into a helper
method and use quiet parsing when needed.

Note that git_config_expiry_date() will show an error on a bad parse and
not die() like most other git_config...() parsers. Thus, we use
'quietly' here instead of 'gently'.

There is an unfortunate asymmetry in these two parsing methods, but we
need to treat a positive response from parse_expiry_date() as an error
or we will get incorrect values.

This updates the behavior of 'git config list --type=expiry-date' to be
quiet when attempting parsing on non-date values.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 27 +++++++++++++++++++++------
 t/t1300-config.sh | 11 +----------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2828b6dcf1..ee77ddc87c 100644
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
@@ -333,6 +334,23 @@ static int format_config_path(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_expiry_date(struct strbuf *buf,
+				     const char *key_,
+				     const char *value_,
+				     int quietly)
+{
+	timestamp_t t;
+	if (quietly) {
+		if (parse_expiry_date(value_, &t))
+			return -1;
+	} else if (git_config_expiry_date(&t, key_, value_) < 0) {
+		return -1;
+	}
+
+	strbuf_addf(buf, "%"PRItime, t);
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -368,12 +386,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_bool_or_str(buf, value_);
 		else if (opts->type == TYPE_PATH)
 			res = format_config_path(buf, key_, value_, gently);
-		else if (opts->type == TYPE_EXPIRY_DATE) {
-			timestamp_t t;
-			if (git_config_expiry_date(&t, key_, value_) < 0)
-				return -1;
-			strbuf_addf(buf, "%"PRItime, t);
-		} else if (opts->type == TYPE_COLOR) {
+		else if (opts->type == TYPE_EXPIRY_DATE)
+			res = format_config_expiry_date(buf, key_, value_, gently);
+		else if (opts->type == TYPE_COLOR) {
 			char v[COLOR_MAXLEN];
 			if (git_config_color(v, key_, value_) < 0)
 				return -1;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 48d9c554d8..72bdd6ab03 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2562,15 +2562,6 @@ test_expect_success 'list --type=path shows only canonicalizable path values' '
 '
 
 test_expect_success 'list --type=expiry-date shows only canonicalizable dates' '
-	cat >expecterr <<-EOF &&
-	error: '\''True'\'' for '\''section.foo'\'' is not a valid timestamp
-	error: '\''~/dir'\'' for '\''section.path'\'' is not a valid timestamp
-	error: '\''red'\'' for '\''section.red'\'' is not a valid timestamp
-	error: '\''Blue'\'' for '\''section.blue'\'' is not a valid timestamp
-	error: '\'':(optional)no-such-path'\'' for '\''section.missing'\'' is not a valid timestamp
-	error: '\'':(optional)expect'\'' for '\''section.exists'\'' is not a valid timestamp
-	EOF
-
 	git config ${mode_prefix}list --type=expiry-date >actual 2>err &&
 
 	# section.number and section.big parse as relative dates that could
@@ -2578,7 +2569,7 @@ test_expect_success 'list --type=expiry-date shows only canonicalizable dates' '
 	test_grep section.big actual &&
 	test_grep section.number actual &&
 	test_grep "section.date=$(git config --type=expiry-date section.$key)" actual &&
-	test_cmp expecterr err
+	test_must_be_empty err
 '
 
 test_expect_success 'list --type=color shows only canonicalizable color values' '
-- 
gitgitgadget

