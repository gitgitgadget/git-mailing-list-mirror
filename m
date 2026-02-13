Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8F33D6F5
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026943; cv=none; b=VPeDlr0jLzWG9FYEkV31UEye7UKVXHDe6ie3Z2vRX8Kt8LlSbj89US3wQBAX7JbOUzlW1TDvls7NIc967kVof0s3GJBOtT5HHNNuQdV9XY2pcTrVuI9CRt0G12eDoIde1yZgcW1QmhdekHOO70NaZJtHdtQeB9Mjb8X1fkG743g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026943; c=relaxed/simple;
	bh=sTwV4JOtzsFQv+T90qIEmHH1VMWeSN+Fmi0/QacO1qQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i3ej5KfnKZqrWCG3cMIuuS5XpM5S7kmAjnTg1k4Bm5h7CaDi6GVt0ApP5C0UqB1lPMJyy+SZyOCsSn02Y6j2kL0q+yd6RnHbs72HtuIoHniz+TdPbCCKZ4xIorI28F82vy5Aao2idp79bJJcBzXIzrSkE/qqhxqazA4lYyh/8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKpIUsuo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKpIUsuo"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8947ddce09fso15870786d6.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026941; x=1771631741; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uZiBmLxMHGe/XXEDW73rPI1pcOqGMORh7ry7M04Phk=;
        b=iKpIUsuoIAp1nMG4lU0m+sQk2KRAqYVVLvttdZK0feuKNwISD1xXT0HtZRW0vQ+7LU
         gqHjWXu6fdPCpLW5qex15reL8iN0vF5m5R6+MubvSMiOf8UW4HZvFMRqubMxJJlug0ah
         EngmounMfFXOFSQoi9lQaFxxYvAW7U6WRjEh4VBnrKd/uftMF8hN4X7g+hQgN4hVsIwT
         NQU/VYKeN64Pzjt7scMSaYLS+aAmypNzXOw5XzeUk0VULw2Tj2SpumyLDRYaBB5bc7yF
         6jLa7u4GvmM5KsMEjoLmrLrdjeDrID9C3627TK6XV/XjFBx+8En7T0Xo2Dp1/O2K53HS
         e1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026941; x=1771631741;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uZiBmLxMHGe/XXEDW73rPI1pcOqGMORh7ry7M04Phk=;
        b=UlgffVCK5jcprf0P87SHnhr5QLOrV9Z9rYAcblh6DSxgPKvQiRtj9oMXaKG8Ecbll4
         60v0WSrdGmXVE6MvVMawrn3dGuos5X43IUJ0MCJ/z3L2IrbOUF3CYNRPXe+mNEsGqzs2
         12ENgAeGp2KbBaAmRuguvcZEl4eX8d/rpDlneMOxToI6hxECgfqHMwsWriGCEubjsr/h
         WPq2099T8xFyuXaX8cWWu7ieSUjC97JZXW8Lln51kEC4Eu4OIHI3LHaVPWe4ty5yzWwN
         8ojAtXDWvbqcfzjxlnG+H/rlH16m8QndWpLFCZY/3ywTm6iGyDH/l/yXPNZJWo1NnRqn
         UkcQ==
X-Gm-Message-State: AOJu0YyIogGpu9UBQtyz4JJvugNQ8/UHvJORc1yFw/D6sULQPQbZ9WKc
	SbZW4pBm0XDvnzB2ESS0zmC92bOslnsan8vKhJmkzCPaRFwG/drMKtAVUbV8nc6v
X-Gm-Gg: AZuq6aJNT3/qAtJhO+YDcLHmlJ6dMW0fYWT/265w9pxFpNW13RNxClDRqOnXwPbcVrK
	3NZCKMAmpvWYNuFokehGZxen60S5olGzmsnD7OKm1zEFk4+fXhTc9jGJfLBCoYHYxZJtsDevPvx
	bxNaev7Sib43ZIIZR+wcaTlR2a2MJSc/7Fmtzs0auNS8cTLjQ9OfunnbDVQHDasr57BMf4inauY
	5DyurqU/zGho1wyuZ20xGxTfD1bvN1ksk0O4h8Hz2PPwZBTYDXZ62Tanj9x3c7y01/H5YPscCII
	Wx/cqUPL9s7pdGXO171lgXpNGhU9MHvCX39P2sEJ8R9lgBagk9DvXLb13TEf8I6lPcjO0IVqyZF
	FWLMtGPPqsWusbO4GWzP8ObsoFQyodbkLVfAw2g9qqEFYgOG2w4B4pny5hCAARq9il+AYvtIhzA
	AjQ6J83sMKBcIWPknB8gnHOODW
X-Received: by 2002:a05:6214:1c8c:b0:895:3344:b1b0 with SMTP id 6a1803df08f44-8973610d6a0mr46842546d6.27.1771026941044;
        Fri, 13 Feb 2026 15:55:41 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc91eccsm73171156d6.13.2026.02.13.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:40 -0800 (PST)
Message-Id: <9221ca2352d65f3cbdec00f7577089c734799919.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:15 +0000
Subject: [PATCH v2 10/13] config: format expiry dates gently
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting expiry date config values into a helper
method and use gentle parsing when needed.

There is an unfortunate asymmetry in these two parsing methods, but we
need to treat a positive response from parse_expiry_date() as an error
or we will get incorrect values.

This updates the behavior of 'git config list --type=expiry-date' to be
quiet when attempting parsing on non-date values.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 27 +++++++++++++++++++++------
 t/t1300-config.sh |  9 +--------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4664651dd2..71b685d943 100644
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
@@ -336,6 +337,23 @@ static int format_config_path(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_expiry_date(struct strbuf *buf,
+				     const char *key_,
+				     const char *value_,
+				     int gently)
+{
+	timestamp_t t;
+	if (gently) {
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
@@ -371,12 +389,9 @@ static int format_config(const struct config_display_options *opts,
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
index 59a82b9aef..c134d85d8a 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2536,13 +2536,6 @@ test_expect_success 'list --type=path shows only canonicalizable path values' '
 '
 
 test_expect_success 'list --type=expiry-date shows only canonicalizable dates' '
-	cat >expecterr <<-EOF &&
-	error: '\''True'\'' for '\''section.foo'\'' is not a valid timestamp
-	error: '\''~/dir'\'' for '\''section.path'\'' is not a valid timestamp
-	error: '\''red'\'' for '\''section.red'\'' is not a valid timestamp
-	error: '\''Blue'\'' for '\''section.blue'\'' is not a valid timestamp
-	EOF
-
 	git config ${mode_prefix}list --type=expiry-date >actual 2>err &&
 
 	# section.number and section.big parse as relative dates that could
@@ -2550,7 +2543,7 @@ test_expect_success 'list --type=expiry-date shows only canonicalizable dates' '
 	test_grep section.big actual &&
 	test_grep section.number actual &&
 	test_grep "section.date=$(git config --type=expiry-date section.$key)" actual &&
-	test_cmp expecterr err
+	test_must_be_empty err
 '
 
 test_expect_success 'list --type=color shows only canonicalizable color values' '
-- 
gitgitgadget

