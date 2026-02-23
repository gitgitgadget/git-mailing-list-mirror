Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175D366057
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849637; cv=none; b=Hotz6oXPvm6tjoscv3YC0l4CXHGEjaqoC1+rMaWa0Kdj1p36lZkhx6C4mr7VwTnLNg8IWFgAZo/Pukof+Y9DOBNZRMbaRala7rVCkctF+tkTX0QWdbcgH6rFp16jtk0QhFF31qVRHhREqh+SMJQlB4hD54Xd1q15se5iU09pfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849637; c=relaxed/simple;
	bh=7s/bI01MvJDT8Rgt4Ufbdj59mcCed6l700YVgFHETOw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QCkJGztCQZMf2GHJeCM15gyqH9VHXC49npSGH0ObVYABjC7ISghcxK1LyxGssOb0iBOoTu2AIjCg0ZS2gjgfPZTLgnO8Le4yOgqKMcz3DusNt+19n0P3mGoWc6LFt40d5e5tdDBKVMCxk4R/eDLKhax8YQxu+gn3OVLWJ6VXEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXyV27ca; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXyV27ca"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-46390d4ac7bso2574303b6e.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849634; x=1772454434; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3ZYz7wA0AlXcc7O5DOVSDjJUV7Ng5+TOCjKDlZkWWM=;
        b=lXyV27casT5S8fDRZlbMSxQ1DkQlBGwoDdXhEYYgBww91zPnzdJWjeQxaI2eonklL9
         DEPIyIbVLCwp8ZQaKiAFc/nWdRMd3RmEqm8ZZWA5QJnpZB5xqcY5I9oAkHhLrtqK5PnY
         Zjv+vk9zuxMtFKuoo0pFEkVlUg1r8QBn9Pk/T79dMsOyCOS98fnpfzCHRFR58T9srYL/
         v8ClZ0+QXF47eHBSHj5Sw5UFd5oGX9s42E4/Lwo7dL5XklN3rl2rzeaYVfGLxtoJRVxQ
         QMCTEOEJTp2eZ9N3dile9/5NtCD75XvNTQbF/GM/WvAARIr3CEEp03diL6h4zx7B6tCI
         iTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849634; x=1772454434;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3ZYz7wA0AlXcc7O5DOVSDjJUV7Ng5+TOCjKDlZkWWM=;
        b=DB+5n+BmeJ/XEor3Fi8e0a9Ah4BziiivlmL2TPpcwHj9HVRUL1CB0KtvDPxkDVZkDj
         XN1tIdEX8UHHRIUjiRjnve2hsz5Uv7MlcsEDOhrBgL0cTa/MtvROsa1Zz6psYVSP+MP3
         fFAZJQoDNzDzl8zwa6ms9PCMd1p4Emc6l1ZQAQ2GdKbewHzq3yNY52+NOYB752OjmsJW
         ghDdH9++i76Rop/ZVE1JIqDZ744cbYn7yp5BqarwxS2UaiDBHRpupQvTolkPq/Nv/Kba
         n02MnN27ZLCp8X35GvNmeaPaVGE8QslaNYvsdCkeRSdLZLo7d9eXwYdd9+XNJZx03EY9
         A8Tw==
X-Gm-Message-State: AOJu0YzNl4T58/Ixm7QN0+Cgh+YMjEuqjoQIE+7r97r56AhKxsEuMdu1
	0RJjruhAR8BC7v99zVoDWfYfosUvvcaql1bEPx644xAKq1/L8x9OzSpQVPZQBA==
X-Gm-Gg: AZuq6aIUHwKPwA0cgMYM3VhMca6a9ad1jFfZQqftwChz+CQXCxdCsJBBJWAgxxRySEc
	zTkF1aZIzcnxRMVNIOQq5SkA1VqP2q/1OkkOwduymo9ByH05pjTGivWReitiRBhif5qe0hm0hu5
	W7kBFYT+WoxtnOpe9xc9OfgobxeGh11Gg9ST2fMP5nRd7/40puVDyKbDv2tM6KWScQCPfM1F4FZ
	oAL4MtLDbROlEp/NYC3FpJqIJxLgIhXAdUzXiI3owR41viYrZtzShISIi1ODruhrdehSdPOeWo5
	A71C68WExeYht70+Lwy0fkwDWHV5QV6jUwqLsdba9l18OMgeKsb5eVme+Igyt6Jh37pm67PQQEP
	Xf4KBRojjrsUCKA2zAMkdHZ+d7JpcZWRVmffDVxbqO4n24KSAnqFx+crxxe0vJR/yn9QvZkY/Pr
	KEIRHZfnOFOuC9JCVh94zY633tXA==
X-Received: by 2002:a05:6808:169f:b0:441:8f74:fcc with SMTP id 5614622812f47-46446426277mr4698895b6e.57.1771849634397;
        Mon, 23 Feb 2026 04:27:14 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cfa6624sm8150567fac.8.2026.02.23.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:13 -0800 (PST)
Message-Id: <76fc7670fcd2ec6e4d236f415e887a6ac66c9fcd.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:54 +0000
Subject: [PATCH v3 12/13] config: restructure format_config()
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

The recent changes have replaced the bodies of most if/else-if cases
with simple helper method calls. This makes it easy to adapt the
structure into a clearer switch statement, leaving a simple if/else in
the default case.

Make things a little simpler to read by reducing the nesting depth via a
new goto statement when we want to skip values.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 64 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 45304076dc..2e8bc6590c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -124,6 +124,7 @@ struct config_display_options {
 	.key_delim = ' ', \
 }
 
+#define TYPE_NONE		0
 #define TYPE_BOOL		1
 #define TYPE_INT		2
 #define TYPE_BOOL_OR_INT	3
@@ -390,32 +391,57 @@ static int format_config(const struct config_display_options *opts,
 		show_config_origin(opts, kvi, buf);
 	if (opts->show_keys)
 		strbuf_addstr(buf, key_);
-	if (!opts->omit_values) {
-		if (opts->show_keys)
-			strbuf_addch(buf, opts->key_delim);
-
-		if (opts->type == TYPE_INT)
-			res = format_config_int64(buf, key_, value_, kvi, gently);
-		else if (opts->type == TYPE_BOOL)
-			res = format_config_bool(buf, key_, value_, gently);
-		else if (opts->type == TYPE_BOOL_OR_INT)
-			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
-		else if (opts->type == TYPE_BOOL_OR_STR)
-			res = format_config_bool_or_str(buf, value_);
-		else if (opts->type == TYPE_PATH)
-			res = format_config_path(buf, key_, value_, gently);
-		else if (opts->type == TYPE_EXPIRY_DATE)
-			res = format_config_expiry_date(buf, key_, value_, gently);
-		else if (opts->type == TYPE_COLOR)
-			res = format_config_color(buf, key_, value_, gently);
-		else if (value_) {
+
+	if (opts->omit_values)
+		goto terminator;
+
+	if (opts->show_keys)
+		strbuf_addch(buf, opts->key_delim);
+
+	switch (opts->type) {
+	case TYPE_INT:
+		res = format_config_int64(buf, key_, value_, kvi, gently);
+		break;
+
+	case TYPE_BOOL:
+		res = format_config_bool(buf, key_, value_, gently);
+		break;
+
+	case TYPE_BOOL_OR_INT:
+		res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
+		break;
+
+	case TYPE_BOOL_OR_STR:
+		res = format_config_bool_or_str(buf, value_);
+		break;
+
+	case TYPE_PATH:
+		res = format_config_path(buf, key_, value_, gently);
+		break;
+
+	case TYPE_EXPIRY_DATE:
+		res = format_config_expiry_date(buf, key_, value_, gently);
+		break;
+
+	case TYPE_COLOR:
+		res = format_config_color(buf, key_, value_, gently);
+		break;
+
+	case TYPE_NONE:
+		if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
 			/* Just show the key name; back out delimiter */
 			if (opts->show_keys)
 				strbuf_setlen(buf, buf->len - 1);
 		}
+		break;
+
+	default:
+		BUG("undefined type %d", opts->type);
 	}
+
+terminator:
 	strbuf_addch(buf, opts->term);
 	return res;
 }
-- 
gitgitgadget

