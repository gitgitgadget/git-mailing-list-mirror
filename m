Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A9365A05
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849628; cv=none; b=ad1SZBUyetqib2uDtJMEbuQISVBLXlfGJf+2dRx50JXB6IKDXHByX4nu5h983NPJmJ0kOTtVl2u1ZK6AKfNVydFMdDu/5UXJ6tLXzlYuOsauj443cAk2m2zl0B2UIAZUCGZILnv2SxrMZ6+wKeSo3GQWcVLlcQYk+2aq9sbkcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849628; c=relaxed/simple;
	bh=YDXPKy1Ymdc/RnzLrS0dqykSzSlH6XTUFdNSTIU1nEE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=npsZnAt2SHxwAoCq4yfRVumQEx1RqQTP3XSHd6UDcOL1HYjzPyia0/EQV5YltWMdVN/EZ7/GUxGLug5FwesdxR+j5tdXRkdqiXMYKvxWr0XymQznwDU+0dwACGXavfe7Z65XPGNaoUMYaszuDqqv8zGaDYB4nkYbW6qTYC2iobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3G61upu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3G61upu"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794fe16d032so34112867b3.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849626; x=1772454426; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg71TH5o5sJJ68FLKiunK6mxTlGTnawcUpSVoXg/rIE=;
        b=b3G61upu+9SYM+1damTKPqGcJ3o13pBO07tnvuBjfAmAOOwyslcF8Fnd3WH43fYVzq
         C6prpt41Lkb403rMpV7NSWrJq7FBocBf7YgYN53YeY/bkVNTldK0cPTTfJJ8UnneyMP5
         Jtpa0RWgXXIjcdYHiNIL50rgeAUe8HhFRtraZhA09zzyAh88elYAbZJERDzja4c4lrkb
         P9n1bKI/ZzC0QBpgkPU1g0ZoPxxGN725tDo7dbSs/LoqYHcalg+LwiEvchQez4U1B+BO
         0qt/8Co6D8y9Xz2K6MJ3FKdUCpW/u3hNLpVsdrEjFYYDLNQidlWuAVXLYAmb2HRtYoxn
         IELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849626; x=1772454426;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pg71TH5o5sJJ68FLKiunK6mxTlGTnawcUpSVoXg/rIE=;
        b=ddOhal0r4AK0Z+5C+rbGDWhXyeqUmjAi3u4l0t2jq3dxiHosD1a7Rb6T8kJ/m5SUkI
         M7sQQ6Zv1SM0bNu8EpZxVWx8OanI/uqq75Y/dsm5V+AG6Va0jvsOwBbrAlJ+QOnnIL3n
         Q9RE03HHrX3vbHXzsqL5kZFcVLnzj5eN6XDqBRGurrA3jX6qkeujym+uJODn6YIkJU+g
         IqySz/U8JW/nDid+jQMYq+86D/Fn9QzOZRgtHBDIDnc4suBS8Jh6A/QSrAASYSUj1lwJ
         wypVLBxVCSslM0/9xtrA7M2/zldHCvKOEXpUjaS9Q+2zlEQQmDgc1gZV9lPJSJ0EIQr6
         XeBA==
X-Gm-Message-State: AOJu0Ywj7jo6jP4wkNkNbSjtwK0mwMXEwNNCUK01hzAHDu0Pu5J3AiSc
	x4uPITbW3ys/HvpCIL9UDJ/vBU5Be5YuGMswfNyqC5slt+QGdq5IOOXQ+nnZ7g==
X-Gm-Gg: ATEYQzxngnqXLc87zNG11Xva1RGcfivvT+nrdcKh3wvMfIqe8ttDuqyaLGuAPshP9N5
	6dAuIWhyKRIHlNRWVumII/LGYi9wNI5D6ivuHKYcFAMnmoYV8eLbZLGoD+Wru5yyBSj+m1rt5CT
	YkF0VdCFltMOct2yAC+UzGocYSSV5ae3hALHUi/NZpP4fPb9AeHqalZkTQqPlWkzyCag2KvuC7c
	cIdBpbNeVqrsph/G/ksvUrr9N899Pusfd9sju8U0R3k27ae6j8o13cjGG7PSaC6d/6E4InFx268
	B7/Y+m5Nn6S+E2e5O2O8TcS7wBzviWfIOYrFpyzgbbi0XvCi4NZ5zFnq6tYTJO7Lyfq/SJHLAX1
	wTkwqQPWinWdJC+LjZz6C8Q/ESzsP66xJfzlH3AKZVNlOlac9SwPPNGIeEOvNrglMPzegNwAJYn
	Vd4QmxELJwFEtMvD5TEhcGF4DJmA==
X-Received: by 2002:a05:690c:dc9:b0:793:db81:f1dd with SMTP id 00721157ae682-79828ef10edmr72708167b3.4.1771849626182;
        Mon, 23 Feb 2026 04:27:06 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982ddc6b65sm31285267b3.39.2026.02.23.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:05 -0800 (PST)
Message-Id: <9f06db29b9e87f9d041003f38513015c41447dd8.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:49 +0000
Subject: [PATCH v3 07/13] config: format bools or strings in helper
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

Move the logic for formatting bool-or-string config values into a
helper. This parsing has always been gentle, so this is not unlocking
new behavior. This extraction is only to match the formatting of the
other cases that do need a behavior change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 491a880e56..79c139c5b0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -302,6 +302,18 @@ static int format_config_bool_or_int(struct strbuf *buf,
 	return 0;
 }
 
+/* This mode is always gentle. */
+static int format_config_bool_or_str(struct strbuf *buf,
+				     const char *value_)
+{
+	int v = git_parse_maybe_bool(value_);
+	if (v < 0)
+		strbuf_addstr(buf, value_);
+	else
+		strbuf_addstr(buf, v ? "true" : "false");
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -333,13 +345,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_bool(buf, key_, value_, gently);
 		else if (opts->type == TYPE_BOOL_OR_INT)
 			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
-		else if (opts->type == TYPE_BOOL_OR_STR) {
-			int v = git_parse_maybe_bool(value_);
-			if (v < 0)
-				strbuf_addstr(buf, value_);
-			else
-				strbuf_addstr(buf, v ? "true" : "false");
-		} else if (opts->type == TYPE_PATH) {
+		else if (opts->type == TYPE_BOOL_OR_STR)
+			res = format_config_bool_or_str(buf, value_);
+		else if (opts->type == TYPE_PATH) {
 			char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
-- 
gitgitgadget

