Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E6253F07
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128498; cv=none; b=pqkJgys2Hog/2xY7CsExse3BqeL3ejU5/b2UEJQ1rgMCtFISoUr52a0h/HbWkOoHO5cE4XrfMPrr9/qcJBMC2sDcwH3BRWHXVRcTEHgKy0TbaOWkdXMszg8/WZ5rTIHWxWgj14xD4+EmhLZ/cYFu9O3CrIikNIjCwbSKUS61YxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128498; c=relaxed/simple;
	bh=iFq43rx9Ex5z9ofEsndbtxKBb0WehknUsp870SLF1pk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nxfzP7ovNxNtqQBc7x3NuGg8F4seUrs0HIXmHM7z0uLwcoHikaOXGzDWXtDnzUESFrOj58GPr9nbtfxGXda1P5aSpJUD4EH12d1N3tJVsivoyjtklsPDlxuQnxifFhMgBjycvCaYSFkliQfHUfJmuUEqWYY5cKlQp20OUd0lYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGFBryqA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGFBryqA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so16938565e9.2
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751128492; x=1751733292; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr/nywi8rfTpXSdmP0Jk0MiNw+Qmy0fQ56YYM5hcPO4=;
        b=eGFBryqAVwPlL3SGj5QA518zm4IkPkJdPlm/zCGkP6hUfMLWwu0YneyfguVPgLGISZ
         6TA06x/vNNor58m4k9VBtsXbuxHVzJMpGObSptCWQDPebSV9ANwrYWJd6N54Je0pOP99
         /QvZptc0FO0HvCl1A9qPE5f/gayKfDEcL+WZ9l3gZ8OYkdFGBjwwLBrOGf6nTp3GcBXA
         3PMob5XV5UlB8tPlTHMtreJ1i1HTkJYQn9sFz3mTFlNAeB5l46WRMdLudcOJApgSGNlM
         E6kHiQvQ1Y5ZMdNKSf7tppWnfb/sTfTNh05nn96FdyFHyOd6ID5HH0EyGBQpQCWsgrP/
         9Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751128492; x=1751733292;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr/nywi8rfTpXSdmP0Jk0MiNw+Qmy0fQ56YYM5hcPO4=;
        b=Z252jALRtX+Jw6rtaevJnPUyb3CvX6iHkHjfGTZ1yOOnT/M2tOjdlzPSYd3FC+IJ7q
         cHtSL40wUo/LHcQ1GWwO3puk4TFlisAO35E3d7+rflT1bv0uuQMuTEYNKhz78taIWIJG
         R2nTbz+8kWYqcqKp5iuvAp+E7DdXiwjOTCVNXgZemRzvXv+ok2CtwmCwfAH+Vy1FNT9n
         11VRLgqbREoRmRtfu6LeKEgo1aNYsV2JSlCQkoHtDvMK4i31eAc5VHA1oFBtykdK+OhM
         /Ch1sI5oLuS3ns53gRknrKEBG+imAX9H1BCDhKUwoHA+Gw0q3ASnvggP1nvSzx4WyaEx
         NYBg==
X-Gm-Message-State: AOJu0YxZ3HgeRMH/1ZWBU77EEe3nwrMJPVB4FjbBdM8GI21V2gsFIMiq
	J76ndpqSNTeW7sr1AGoD6Cy4P7UapqjBABoj44zWHjuO20t1j6Kt8jwcjbDIeA==
X-Gm-Gg: ASbGncswrN8Dmc1xTik6NMuEJ87L0DoGML+FpIyQaj5kbN/aiOcLTTrOBH97fvxhjtj
	BjvCYTz2Q50feIYnb3ibTrDcUoe+Azo6QV8hZf5TZ2e5V+Abae8/JUG7lGvJaZgzAsNtaQvou+7
	tuEF4RuAffo4+Y84os9n7YVocWn2FP/AxCPmbphLbzcUAFuDZUp0JdHSTEz+xlucEAgXRsiMiGg
	FDj8vGWamBzj7TgwYdMgaTDNr92SnZAm9dIR6XhTcL541cyWWESnTpK5wCsFa3pYHpLUeeM8ndR
	RZIw63dpFwQEMaRYkr8c8IykDiaETt5iU+HGe1EINAQruIw80PCKjXbrT61QovE=
X-Google-Smtp-Source: AGHT+IGoQsfjBgQ4ArksVOH8lMW+c5H0R7jDPH/boMi9Qjz3AjPpD7awLvoV1Mhfh30E8bTHy7nb9g==
X-Received: by 2002:a05:600c:530d:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-4538ef33a85mr67435425e9.1.1751128491776;
        Sat, 28 Jun 2025 09:34:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ba553sm111352515e9.31.2025.06.28.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:34:51 -0700 (PDT)
Message-Id: <1ec8a1384862765795f17e2d0fcb7b601ef2b25f.1751128487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Jun 2025 16:34:45 +0000
Subject: [PATCH v3 3/4] add-patch: respect diff.context configuration
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
This patch fixes this inconsistency.

This is because the plumbing commands used by "git add -p" to generate
the diff do not read those config settings. Fix this by reading the
config before generating the patch and passing it along to the diff
command with the "-U" and "--inter-hunk-context" command-line options.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 add-interactive.c          | 17 +++++++++++++++++
 add-interactive.h          |  1 +
 add-patch.c                |  6 ++++++
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 97ff35b6f12a..e0aafb8dd02a 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -39,8 +39,12 @@ static void init_color(struct repository *r, struct add_i_state *s,
 void init_add_i_state(struct add_i_state *s, struct repository *r)
 {
 	const char *value;
+	int context;
+	int interhunkcontext;
 
 	s->r = r;
+	s->context = -1;
+	s->interhunkcontext = -1;
 
 	if (repo_config_get_value(r, "color.interactive", &value))
 		s->use_color = -1;
@@ -78,6 +82,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	repo_config_get_string(r, "diff.algorithm",
 			       &s->interactive_diff_algorithm);
 
+	if (!repo_config_get_int(r, "diff.context", &context)) {
+		if (context < 0)
+			die(_("%s cannot be negative"), "diff.context");
+		else
+			s->context = context;
+	}
+	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
+		if (interhunkcontext < 0)
+			die(_("%s cannot be negative"), "diff.interHunkContext");
+		else
+			s->interhunkcontext = interhunkcontext;
+	}
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
index 95c67d8c80c4..b43ca1600738 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -415,6 +415,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct strvec args = STRVEC_INIT;
 	const char *diff_algorithm = s->s.interactive_diff_algorithm;
+	int diff_context = s->s.context;
+	int diff_interhunkcontext = s->s.interhunkcontext;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -424,6 +426,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	strvec_pushv(&args, s->mode->diff_cmd);
+	if (diff_context != -1)
+		strvec_pushf(&args, "--unified=%i", diff_context);
+	if (diff_interhunkcontext != -1)
+		strvec_pushf(&args, "--inter-hunk-context=%i", diff_interhunkcontext);
 	if (diff_algorithm)
 		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
 	if (s->revision) {
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

