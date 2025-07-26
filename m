Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40DC285CBD
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753548850; cv=none; b=NcaWfVNB0BioMWo/AUbKmkYUPiUhy5cgLWAMbYWHCSEq2jpOQfPEctKDNpyCOA4VniByJGwrwvi6blhYDMNyJ/9OlDwK2K4DZqfoNQjg49i1e6eZbRCZX6AuXhXC0+1zRkKiz74bvzVt0S9//iotedmIhwN77ya0YRI1oEc+Bxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753548850; c=relaxed/simple;
	bh=lv2iHd9lcQmeb+5hc9Hp8zVMGHHZL1et9OlEbcSaf5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2+qX507sQwktLWct+tR79h72VtbaQjDY8DH0sWPKv5sJiDqIyrGUw4vSAQ8y5xusW5jfVHem9lGoG9qrpLogGtIvnrFsok58YEpmqAErVYjG2+ilGuZSM+G1m/B7uEKSeP9o86h00MiJQGvnaNoVudII2A/Hmr8Xiq4/a+NnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKJRocnk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKJRocnk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71967cd1072so30721167b3.3
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753548848; x=1754153648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+daLiMi8qZvN00kjackOeAVIYQTwuRxc6icuJJnd7wI=;
        b=PKJRocnkIMQpdINEv7YEFpLNTrmqkr06Hxu0EGD56UBQJpZCR19hvho/AFkiMTAXkU
         JxrQzLL5xr+sDRSSy6il+YfILDCPfY+5/OIxa+oNXBVHSTe+9MyYRGcuMZ5GPWKAr/SC
         KdZ7vNahGW5Hpq54+JlQFxUwq9iqn/N8zSvgE4EIGUnLbQhRDFHjyxXgLYwPL2KAmzRu
         f3vbeDYLywNLQPWX4vfl5iHZ9s++w8z8RCyq7X+AtOKY82ov6nP34ODBd7VDnEJSJwS9
         I/pn85+tH0DkKqqdjWThoz3G3CHapUMEnuPrACBxXs+uM6AFL3UCHxQUPfxyhgQuqSxw
         PQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753548848; x=1754153648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+daLiMi8qZvN00kjackOeAVIYQTwuRxc6icuJJnd7wI=;
        b=ei1zn88t5M5DsLP1zgIrcEh11z7RSfvVzq3sEn5vj72eJ9aJlODHX9tPF5kMfihByk
         07a7zEtEvovfkgWoePInsZs8O51oNLy82PqOSZ+VrS5Rzmq2oteV//3IIRIOb8otod56
         sp3MfZaiz2zez91vDlIex8V+59l69bhyeYaapO8nZujJlGBcpJGmc9OKneih/C4/nyRK
         gWWaEhhUDj91MrhAdq1k7YPA6Pc+u9MZsJVuauVtSAqv/AvO0Zi5rLMfBSjjwxSg9L0m
         UnbmipyiX0fR84Fge6GdH3qLprMoqzmwXhr+v5LrHl9f7bZt8iZ6ec71DGx7FpvgvD7M
         6ovw==
X-Gm-Message-State: AOJu0YzULrmRB22zWbKHUuAz3os5Od17KwjayIrDGH6x9P0PWy2vJg1J
	oK13PgyxEn7ci9Tz0iYQ+I47+o/PzedK56j+6XYP5+OfUdWo3cOmlCAPAjWrx7/T
X-Gm-Gg: ASbGncvweaMy5DIKavYjMBGT1LkFshQZamerC31u4Oz5EmbKhaIlNAZYC+Q81tTyQfx
	gyTftUvgok4YZpTmy3LlwMfR5MLjPswrf9nFQY37i9RcfgVb1V4VpFQG2Q+YS4RAwlMvuzbSD9q
	Mckb/8M5F8gyE6fOSrBwG31i6lSOnFSobvFx6iyifSk6Ob2h2cbyq6hRvXd67j4UYUI45cmxlQQ
	mIaDKF4ogdR8hWdEpkqK/CdNXzYumFvfiaQKdFey4Pz+plNOVfWorOLjluLKqFJk0calrRj+YmZ
	4DAC+VmvXodG5alX6zF/vQK2UNXBb6Oh3nQCrv3EJ7WxkrIR+5tIUa1TwcGdDKkvmdJWtitf0Mw
	rlaVHK1SK9JmJ6zC1jgDgXFAqPS2fmk+dLZX0sOShR2lixFdh05hc+PcQFzu4Ck6QPrHDLqtP
X-Google-Smtp-Source: AGHT+IE5GG2UAFxv09+YRGughdKAKa1RWfcAeyRg1fiLyZ6dL4Y5f3ZnG9TehqqDjkqyDZW9SzFaxA==
X-Received: by 2002:a05:690c:6901:b0:6fb:b8a1:d3bb with SMTP id 00721157ae682-719e32cfab6mr85127617b3.17.1753548847670;
        Sat, 26 Jul 2025 09:54:07 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:2412:fdcb:5dca:324c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f2152de0sm4964067b3.2.2025.07.26.09.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:54:07 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Lessley Dennington <lessleydennington@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] builtins: show help on "-h"/"--help-all" with more than 2 arguments left
Date: Sat, 26 Jul 2025 12:53:14 -0400
Message-ID: <20250726165320.4039-5-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726165320.4039-1-ben.knoble+github@gmail.com>
References: <20250726165320.4039-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When asking for short help on a previous command, the user may use their
shell history to recall a command like

    git rebase new-base

Then inserting "-h" after "rebase" doesn't yield the help; make it so.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes:
    I reviewed the following results
    
        git grep '[^[:alpha:]-]-h' 'Documentation/**adoc' ':(exclude)Documentation/RelNotes'
    
    The 2 commands that accept "-h" to mean other things are git-grep(1) and
    git-ls-remote(1).
    
    - "git grep -h 123" gives results sans filenames, while a lone "-h"
      gives help. Behavior is unchanged from 2.48.1 (my local install).
    - "git ls-remote -h" gives help; "git ls-remote -h origin" lists heads.
      Behavior is unchanged from 2.48.1.
    
    But I'd welcome a more thorough check to make sure I didn't overlook
    things. This is probably the most controversial patch, and if it's
    dropped, that would be alright (though it is helpful for me to reduce
    typing).

 builtin/merge-recursive.c | 2 +-
 git.c                     | 2 +-
 parse-options.c           | 2 +-
 usage.c                   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 17aa4db37a..c433d26bdf 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -38,7 +38,7 @@ int cmd_merge_recursive(int argc,
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
-	if (argc == 2 && (!strcmp(argv[1], "-h") ||
+	if (argc >= 2 && (!strcmp(argv[1], "-h") ||
 			  !strcmp(argv[1], "--help-all"))) {
 		struct strbuf msg = STRBUF_INIT;
 		strbuf_addf(&msg, builtin_merge_recursive_usage, argv[0]);
diff --git a/git.c b/git.c
index 40d3df1b76..7fe4e15e2d 100644
--- a/git.c
+++ b/git.c
@@ -445,7 +445,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	const char *prefix;
 	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
 
-	help = argc == 2 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help-all"));
+	help = argc >= 2 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help-all"));
 	if (help && (run_setup & RUN_SETUP))
 		/* demote to GENTLY to allow 'git cmd -h' outside repo */
 		run_setup = RUN_SETUP_GENTLY;
diff --git a/parse-options.c b/parse-options.c
index e3ed42f709..b9a31c261c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1464,7 +1464,7 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 				      const char * const *usagestr,
 				      const struct option *opts)
 {
-	if (ac == 2) {
+	if (ac >= 2) {
 		if (!strcmp(av[1], "-h")) {
 			usage_with_options_internal(NULL, usagestr, opts, style_normal, to_out);
 			exit(129);
diff --git a/usage.c b/usage.c
index 4c245ba0cb..244e8d37ed 100644
--- a/usage.c
+++ b/usage.c
@@ -192,7 +192,7 @@ static void show_usage_if_asked_helper(const char *err, ...)
 
 void show_usage_if_asked(int ac, const char **av, const char *err)
 {
-	if (ac == 2 && (!strcmp(av[1], "-h") ||
+	if (ac >= 2 && (!strcmp(av[1], "-h") ||
 			!strcmp(av[1], "--help-all")))
 		show_usage_if_asked_helper(err);
 }
-- 
2.48.1

