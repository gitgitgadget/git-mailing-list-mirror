Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7512472BA
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772520; cv=none; b=X5Mpgpni3GhxbZpE/TFmDzGz211w5EVIduHAvLlirWV9ExtbAjMkbmTqosvBnUSVYpejlu8tYPHZRh+yMZhztiV2BMi0COCYHcvsyi5Fyqz1pJwHIHwm+rUMjRBYnL0LnIR8YnrUA5YBXyZSnItlyMJ/JagmwOQRBxe/VlssK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772520; c=relaxed/simple;
	bh=45ofwvnwk50907+wETcfc/2hp1z+eGxo+PTfas79YCE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kDoVy/w1ud0+CrpSe2/Xqs81pEZ+SELoSsn85N8xOej9o5+W9772nRY4AyyMRqqfQ8bHLTCS97CX5PRl5I6ONRVuF1s/u2I76MMVngvyl40+n7ty/YsD2l+Mb3epOIntDs+kd84oS6AJeKgeM8i0qqlJfONvsoyvB2WkJt7uR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ste9QS72; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ste9QS72"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so34804395e9.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772516; x=1754377316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8qZUliQvrnRYGAbhBuwZFPVoqKM0b635OK05jn3sYM=;
        b=Ste9QS72x+L6AAfGFgtcXpyZG4GGpPnJEcGMrY3G+q87onKKC3I9npoPbxR/7/dZkB
         yxpOO+ajbNAi8XioP9qMt+UErWNlqhmiV6UhwtB8KfgdMRUz6Qeh4x2m8F9IUb1osmza
         vC4EtjGq1MhmmxF0FwRF8RbC5F2Wri42q9o31ehkp0SMAAES1cw8y6tHntOgsxg9yJmQ
         e3hzxOf9TSA/By76DPf5qA2524Y0O201XNtzTO6SbSuQbmv7W1eebg4eBxmkyHQi4j0s
         IkeQdiGd/8A0y741dG7YFxeUaK0iW7eWPwGPVTNtVTm9NP+I1fE3EZgyBkg3ozONhTNB
         TmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772516; x=1754377316;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8qZUliQvrnRYGAbhBuwZFPVoqKM0b635OK05jn3sYM=;
        b=JXa7x+o/4d4rR9za7zRE1DvliazT13P8tYxh9kwbjzoJ+/gxcF8h5RCxMQbNxwtUIb
         as82Y7iTbQvkACldNzVG1XVGkec9x/l9gudbukVwYWs1qmMjsuH7CjgcwcLN7OCpIrGk
         C0hnLNVuqRrpIfSFBjjUeSeCUtCwEAIBm/ykIn0jxMARhAuSnJgj4WPpDbp0pm5JjN+C
         YKsUGxXSbsl+sDdBSHnhRhyqCjnBE2w+yGrsNT3LI2xWEpgHdGzo3oJYSSgEOoKZ92OU
         SE0jFK5cbpneBAVFZ1kzd/bAJF7B217iDNJ/s/KYvxgTH3EqV+RxvwdmIhCtgq2Bac4q
         p0LQ==
X-Gm-Message-State: AOJu0YyCsOtyuSI1mwgY6FtIX8nJqcyJeUNByjWvoZCuCWIWUfTHOkp/
	DbsVtdFkG+gdAGbNdvi8YISaRG9j8ZStBCcI/c39ismIiWoA5Jw41zs09yIRbw==
X-Gm-Gg: ASbGncv5oB8fKGJp0mxdh12+9SiVCGvzrqyuzMYH9JPYfaZzk95uEZAEeuxtkUqixWv
	dgCOLhk6SBwGU3azfqKUFzbzX2l/4F6kLdxNciI0LjzRsYp2r2lZUR2kUA97ievoR53r0+DlMqg
	68U5g33V11wbAsfY2tR9mFnZ9XfYtwlyZ5VfuqufgIC0KcpY1wcJ1WKfjuTctTLpZ51QdxQjZJs
	7mVYyMrt6C+qtD5Pn0dwYBBMDnzLeNPe/8nSJn5ar8YfMMBuCLuqxYSIaf8M8D8dZtDWO6Rj4JA
	pZL88gykfGBqaCkiQo9kBr9PRDWLdrEQcMCvg6QjJ9qyTuBWkbxZjgB4HkKgEMM9XohcLs/ZWmI
	DUF44kSSQliSWeyw9LkN75cs=
X-Google-Smtp-Source: AGHT+IH+/Rfbof9dV73N663wlUwxqBUdMQqvjnUo2JoUkdIS8cZDjBbV0wvKUy+J+aIjPnmRyDd/xw==
X-Received: by 2002:a05:600c:1d1e:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-45876442799mr130544375e9.17.1753772516157;
        Tue, 29 Jul 2025 00:01:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb9c7dsm10978004f8f.21.2025.07.29.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 00:01:55 -0700 (PDT)
Message-Id: <994029d66029e0eb1b93a6675e4df9c5c6fb76f9.1753772511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
References: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
	<pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Jul 2025 07:01:50 +0000
Subject: [PATCH v5 3/4] add-patch: respect diff.context configuration
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

Various builtins that use add-patch infrastructure do not respect
the user's diff.context and diff.interHunkContext file configurations.

The user may be used to seeing their diffs with customized context size,
but not in the patches "git add -p" shows them to pick from.

Teach add-patch infrastructure to read these configuration variables and
pass their values when spawning the underlying plumbing commands as
their command line option.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 add-interactive.c          |  9 +++++++++
 add-interactive.h          |  1 +
 add-patch.c                |  9 ++++++---
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 97ff35b6f12a..eb3d0d3ada84 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -41,6 +41,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	const char *value;
 
 	s->r = r;
+	s->context = -1;
+	s->interhunkcontext = -1;
 
 	if (repo_config_get_value(r, "color.interactive", &value))
 		s->use_color = -1;
@@ -78,6 +80,13 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	repo_config_get_string(r, "diff.algorithm",
 			       &s->interactive_diff_algorithm);
 
+	if (!repo_config_get_int(r, "diff.context", &s->context))
+		if (s->context < 0)
+			die(_("%s cannot be negative"), "diff.context");
+	if (!repo_config_get_int(r, "diff.interHunkContext", &s->interhunkcontext))
+		if (s->interhunkcontext < 0)
+			die(_("%s cannot be negative"), "diff.interHunkContext");
+
 	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
 	if (s->use_single_key)
 		setbuf(stdin, NULL);
diff --git a/add-interactive.h b/add-interactive.h
index 693f125e8e4b..c63f35b14be8 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -18,6 +18,7 @@ struct add_i_state {
 
 	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
+	int context, interhunkcontext;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
diff --git a/add-patch.c b/add-patch.c
index 95c67d8c80c4..b0125b51ba45 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -414,7 +414,6 @@ static int normalize_marker(const char *p)
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
-	const char *diff_algorithm = s->s.interactive_diff_algorithm;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -424,8 +423,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	strvec_pushv(&args, s->mode->diff_cmd);
-	if (diff_algorithm)
-		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
+	if (s->s.context != -1)
+		strvec_pushf(&args, "--unified=%i", s->s.context);
+	if (s->s.interhunkcontext != -1)
+		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.interhunkcontext);
+	if (s->s.interactive_diff_algorithm)
+		strvec_pushf(&args, "--diff-algorithm=%s", s->s.interactive_diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		strvec_push(&args,
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b088ee141ff4..18dc329ea1f6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1230,4 +1230,26 @@ test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -p respects diff.context' '
+	test_write_lines a b c d e f g h i j k l m >file &&
+	git add file &&
+	test_write_lines a b c d e f G h i j k l m >file &&
+	echo y | git -c diff.context=5 add -p >actual &&
+	test_grep "@@ -2,11 +2,11 @@" actual
+'
+
+test_expect_success 'add -p respects diff.interHunkContext' '
+	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
+	git add file &&
+	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
+	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
+	test_grep "@@ -2,16 +2,16 @@" actual
+'
+
+test_expect_success 'add -p rejects negative diff.context' '
+	test_config diff.context -1 &&
+	test_must_fail git add -p 2>output &&
+	test_grep "diff.context cannot be negative" output
+'
+
 test_done
-- 
gitgitgadget

