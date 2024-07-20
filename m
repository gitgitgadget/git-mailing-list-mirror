Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099BFBFD
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721447040; cv=none; b=bF+RB8E6a6dmE1W+OjhXC44ydiZWTRu+rnX4o5RPbikUW/XfIuff60ERs62m6TbofUW3tue+zOyFuHiDj3C6bi2mW+mF/Y8L3fKGWw4O5E9vxOCbcv22T/TzMtZrXnD/pp1JvweQdnsaLN+6T6nv9Y3gGcYvXUXZirhELyImhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721447040; c=relaxed/simple;
	bh=5CbIiOg08o6CSaEHGHpwptNW5+wXvDUAOC9uSxrrws4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wips2368ZTf4QJf72WH1h43i0Wg9QLIHKzL3Ziw3bNf85YT7VHL/9Fjk9kI7yuLqZ74LWqJbKwIDUOuMYxStSCRblOHcyuEF61iGevyvbu8z/gf8sa3JN+AVmixf39LSGBgME1rhxccF48NAGAs6TuZ/dyWAZRLIDIZLA4+PK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvBaG78d; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvBaG78d"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79ef72bb8c8so101298385a.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721447038; x=1722051838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wTinyu1GxajV0q7z55o9Gpr/Z8n0zsvzWOBu7mf1aQ=;
        b=lvBaG78dOf1/fQXjfjLYpzRbfHQMQTbSOtO4SJ4H6gsjSJkZa48w/ocU2PMGvmXcZQ
         CUL9II3P8kTkLoSqzosuUCS1vnaDepBm2I+afbUXJuQ6paaqWuo0ONZtSda9UQnLFzbz
         8yBtLOMsdTHUrVwL3qwN/+DnbNk1AfwmFgyfKoWbnmTQ1sTa3zu1KK2638pJvXrQUNQs
         UWhwrNFnXq5sFEnoedUcir88gYEi4cZ3U+fSvCl1AewcUSc7Qd7vLIkiLdPGlzM5au12
         /wOsZ7wyQ9kFZf3po0pulHMtZXwFfzlaMoc00CPr/Zh9rz90mW5cBsijaH1wmOLw1Jsu
         mMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721447038; x=1722051838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wTinyu1GxajV0q7z55o9Gpr/Z8n0zsvzWOBu7mf1aQ=;
        b=c8YhLoNPYLnpvnAiUNRq5WxM3l/0bpUWgb2oJq04niSfpjakYvRGvzvQ0LqwibD/wX
         /z9q1+pkCAbIIGP9Ri/Fv6dw4VReb7AYcl/aCC1ymJmRrmAgAINn0F+w5x7hjCi8sE5C
         46hfGRlIjYlYLXGsUgjLyac87E3jYzG8F/bG6Sl2qXUgndwXEje1r/zkjOQ6n5qNOpDM
         1P9sO0vNke1W4wFCDM0LclkZ/1dXH00PvLBE4WN9X4dXkELlTyw/EFwgmMnbdgP+Qyxk
         QgBAKO5tPruv/h1WE4I7Lgum+U9SDV/hBFSG9xabbxOHG/tcMbWzCFND8lMaIGuvJi8X
         lU5A==
X-Gm-Message-State: AOJu0YwMJFjJpYRdYNJAQXUHIe78MGtVNwIPpb9LGdRkJKFa7Qmwa3Zz
	Xe7bsHTCisD7qc5SVNhF7u3Syh/WzN4627Xe/E0gnsRy/E6ON93W/8Ijal0EN5U=
X-Google-Smtp-Source: AGHT+IEuOJmIEuAovgeunbhYe1s0176wdnqzuJ9+bibdVjn0ZSQnpckPULHFiaVkJPn8SrA0Lciw9Q==
X-Received: by 2002:a05:620a:4442:b0:79e:ff79:c2bf with SMTP id af79cd13be357-7a1a13a754amr237466985a.50.1721447037686;
        Fri, 19 Jul 2024 20:43:57 -0700 (PDT)
Received: from localhost.localdomain (bras-base-unvlon5586w-grc-14-76-71-94-205.dsl.bell.ca. [76.71.94.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199073b49sm150487385a.100.2024.07.19.20.43.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 20:43:57 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v2 5/6] cat-file: add declaration of variable i inside its for loop
Date: Fri, 19 Jul 2024 23:43:36 -0400
Message-ID: <20240720034337.57125-6-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240720034337.57125-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some code declares variable i and only uses it
in a for loop, not in any other logic outside the loop.

Change the declaration of i to be inside the for loop for readability.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
---
 builtin/cat-file.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 18fe58d6b8..a5724667b1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -673,12 +673,10 @@ static void dispatch_calls(struct batch_options *opt,
 		struct queued_cmd *cmd,
 		int nr)
 {
-	int i;
-
 	if (!opt->buffer_output)
 		die(_("flush is only for --buffer mode"));
 
-	for (i = 0; i < nr; i++)
+	for (size_t i = 0; i < nr; i++)
 		cmd[i].fn(opt, cmd[i].line, output, data);
 
 	fflush(stdout);
@@ -686,9 +684,7 @@ static void dispatch_calls(struct batch_options *opt,
 
 static void free_cmds(struct queued_cmd *cmd, size_t *nr)
 {
-	size_t i;
-
-	for (i = 0; i < *nr; i++)
+	for (size_t i = 0; i < *nr; i++)
 		FREE_AND_NULL(cmd[i].line);
 
 	*nr = 0;
@@ -714,7 +710,6 @@ static void batch_objects_command(struct batch_options *opt,
 	size_t alloc = 0, nr = 0;
 
 	while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim) != EOF) {
-		int i;
 		const struct parse_cmd *cmd = NULL;
 		const char *p = NULL, *cmd_end;
 		struct queued_cmd call = {0};
@@ -724,7 +719,7 @@ static void batch_objects_command(struct batch_options *opt,
 		if (isspace(*input.buf))
 			die(_("whitespace before command: '%s'"), input.buf);
 
-		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
 				continue;
 
-- 
2.45.2

