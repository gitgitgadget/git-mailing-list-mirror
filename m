Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F4223339
	for <git@vger.kernel.org>; Sat, 10 May 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884799; cv=none; b=dymUqzrpwCPKoC+5EBqpRexQqHz4h9aXjhrGZX9wfLueBIcaVCZyJVFuMDCOBQzznA8XTe66VVSgpoHzRSS0NbWWDaVqhTG7UjTzGEuZNinAkqGGIa0jfogiIjSiJ1SR6nnn/ad5C5TSXJL3TgLyF4ZeIUqY1DVVJfB711e+mYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884799; c=relaxed/simple;
	bh=MgHLBseR3if0rtjUIA0pXfaa+dS7NRx+1eCpZKMBL0A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nW+pxkIeakcSVwaG3kOrVMLiIGLl+j18VW8puYsDIqjFPgqFFJC1+R+aEoXgWvSpt3YeymGacXteengmF6qDafJj+5MTqiSooBv99JHY/fNs+O5STeZmPk/B3RGXVOUgJYfHGUv96uXsMe277CTfVzquJXgdlj3KWzyi6OIO7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3h56bfg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3h56bfg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so1005732f8f.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746884795; x=1747489595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHbwzUUPICjUwigDRXUHQNd66k5JZTc+FtEvtwYYAzI=;
        b=B3h56bfgt3kNIpIQ291Sk7seJz/V4DxyKGUSvwnU7yMIOTNDmRKMuy5akvzWhVkX1O
         cDc1Bume1s6w8dAsn3mad0bwRhWZO2K3edvgl7SghLXe/OXN03FdF74/vOh2Xkbyj8n4
         Mdl6QiQbwmCK1pOnC1iliECW2Iw0eVujvQvsiVR341oSA/Zwq7P67ZP/YkI/RpyDjvxW
         M8f5W8FyK1EE0lAE2CwU6nRaLUrkUCdYHg9b/7UwmlLQnttUWFi9v2TDk4tso4uJpTAG
         +OFYaG4d8Vr8IFLvYBI2t7eUMUOHGCWpbdLDNV0EF3CQu7U5YCf+kYVBn6G4UXobYkyY
         qvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746884795; x=1747489595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHbwzUUPICjUwigDRXUHQNd66k5JZTc+FtEvtwYYAzI=;
        b=RHTGNzpnM8GobMnja9RfSMOHF+wdAMeqo3HR6WnlwIDnvqfyV7QtotMcScC3nK0n3n
         QaoWYBbnGuz4wWyv5h24vf8Fm80gy4gPhX9mFHcmWv6HUMzoNqX1nmq2otJ1QhEn90O2
         5u4uaWosXtEqIHQ2fzg34uhKy07sg+3xfM2xuvfnEddW8qDyI1C0PJ1lbqHL56dCgKTT
         g52Dj968FAVWI1X8YJWbiw8+WNl3BVoZ9d8UugS/vucOX5KLr41BfEq+Vv/8V/I3ERLs
         8hPyLMACc+tAB3SP5XaSZaN05nYKLd4XhoEu0ZUaRABB7xJZRtBOwL3mmmZoKZaZDT5g
         dCuw==
X-Gm-Message-State: AOJu0YzXvZtsLifxAoasgxOTOYOWoFAHUYyVCfyn/OiZGAflmHrrqM8h
	Ws3Ff/KhF6OvBPiNAIwCtO431qoumuq2EFbBJHapCpvaruTbn5QSvoXGag==
X-Gm-Gg: ASbGncsQ7alyeZsufE5Quappsj2X0buypbp0e/HZifhKJNjMtpLFlfrJ2scSbSvEDEd
	/ozykBe4NBrywO80lmx5yISq1NN+iRlE/R8CPfbCpB3hQYUnj79RhJ7IOh6p64lRU7hetwOp0ES
	zj6smKTppSx4WILIkOUwQpW3jRxHmnLpYS9Q8uwnqb0gB2W+Fw/kcJs0ZIQqM6T/sDMjnDIT+MU
	TkSyDrkj/gbJ8Ed3ArkGb1DIxHGJdwm6U5w2oB3qCvA+sazeBMPWL/iF8bbNxRRWR+JlXxyc/aE
	dR+Pk2VtYWFm1h/x4jC4gKjQcm8eLjdfsKhlodyHL/hh11cMJiyKpyeatUf5xIU=
X-Google-Smtp-Source: AGHT+IHY5iwRITCtSTT4PgZ7k+o7GyJbFJDLrTsBLY5cKp03UA6teEVrBaIDNys9VVmFOMt+MZe7OA==
X-Received: by 2002:a05:6000:18a3:b0:38d:dd52:1b5d with SMTP id ffacd0b85a97d-3a1f6421d32mr5599908f8f.4.1746884794679;
        Sat, 10 May 2025 06:46:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de087sm6538275f8f.16.2025.05.10.06.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:46:34 -0700 (PDT)
Message-Id: <f16d3de86110ee61599459a25764248b52883b52.1746884789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 May 2025 13:46:28 +0000
Subject: [PATCH v2 3/4] add-patch: respect diff.context configuration
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

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 add-interactive.c       | 17 ++++++++++
 add-interactive.h       |  1 +
 add-patch.c             |  6 ++++
 t/t4055-diff-context.sh | 70 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 97ff35b6f12a..cac036441caf 100644
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
+	};
+	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
+		if (interhunkcontext < 0)
+			die(_("%s cannot be negative"), "diff.interHunkContext");
+		else
+			s->interhunkcontext = interhunkcontext;
+	};
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
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 1384a8195705..c4b861c360cc 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -52,6 +52,46 @@ test_expect_success 'diff.context honored by "log"' '
 	test_grep "^ firstline" output
 '
 
+test_expect_success 'diff.context honored by "add"' '
+	git add -p >output &&
+	test_grep ! firstline output &&
+	test_config diff.context 8 &&
+	git log -1 -p >output &&
+	test_grep "^ firstline" output
+'
+
+test_expect_success 'diff.context honored by "commit"' '
+	! git commit -p >output &&
+	test_grep ! firstline output &&
+	test_config diff.context 8 &&
+	! git commit -p >output &&
+	test_grep "^ firstline" output
+'
+
+test_expect_success 'diff.context honored by "checkout"' '
+	git checkout -p >output &&
+	test_grep ! firstline output &&
+	test_config diff.context 8 &&
+	git checkout -p >output &&
+	test_grep "^ firstline" output
+'
+
+test_expect_success 'diff.context honored by "stash"' '
+	! git stash -p >output &&
+	test_grep ! firstline output &&
+	test_config diff.context 8 &&
+	! git stash -p >output &&
+	test_grep "^ firstline" output
+'
+
+test_expect_success 'diff.context honored by "restore"' '
+	git restore -p >output &&
+	test_grep ! firstline output &&
+	test_config diff.context 8 &&
+	git restore -p >output &&
+	test_grep "^ firstline" output
+'
+
 test_expect_success 'The -U option overrides diff.context' '
 	test_config diff.context 8 &&
 	git log -U4 -1 >output &&
@@ -82,6 +122,36 @@ test_expect_success 'negative integer config parsing' '
 	test_grep "bad config variable" output
 '
 
+test_expect_success 'negative integer config parsing by "add"' '
+	test_config diff.context -1 &&
+	test_must_fail git add -p 2>output &&
+	test_grep "diff.context cannot be negative" output
+'
+
+test_expect_success 'negative integer config parsing by "commit"' '
+	test_config diff.context -1 &&
+	test_must_fail git commit -p 2>output &&
+	test_grep "bad config variable" output
+'
+
+test_expect_success 'negative integer config parsing by "checkout"' '
+	test_config diff.context -1 &&
+	test_must_fail git checkout -p 2>output &&
+	test_grep "diff.context cannot be negative" output
+'
+
+test_expect_success 'negative integer config parsing by "stash"' '
+	test_config diff.context -1 &&
+	test_must_fail git stash -p 2>output &&
+	test_grep "diff.context cannot be negative" output
+'
+
+test_expect_success 'negative integer config parsing by "restore"' '
+	test_config diff.context -1 &&
+	test_must_fail git restore -p 2>output &&
+	test_grep "diff.context cannot be negative" output
+'
+
 test_expect_success '-U0 is valid, so is diff.context=0' '
 	test_config diff.context 0 &&
 	git diff >output &&
-- 
gitgitgadget

