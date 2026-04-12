Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00BB31715B
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776023535; cv=none; b=ssSC10tOxHSJqq9HjhS/ZZDYILfOy+lKjjdK4+HMx1hKmosDHbVoGC6lRNOi5naj12HyW4rZ/0QVz7ULXoARwIDHsxxCY8LW2+XwjbuHLNTdELMcc7Cbd1S+u5cemAdXjl/F9k4K0wem7KHun/LqDTb0YfMppX5p44DqDonUeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776023535; c=relaxed/simple;
	bh=xF/jP/+Zu6EsK36ll2ucn3MfmC9ajPlijxvKj6aaNHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVTigsVAMaB9nj4V4zsGouDSB39Pck1OQGlXY1/OMuwBsSH26VM1B+F/OQgY2NwDIbC3LOV+LXL+J/yIvnxPbxgBysUtUjmVin8EuG/caFTrsSNn/B7Bg/k7J1az4QL/NVUqFFbKnnnWNikHL8a0H0fUTTG5DL7JcRmtfwqYiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqEzxgBb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqEzxgBb"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b24fede2acso20439355ad.3
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776023533; x=1776628333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi7zym9X+1fkJs6JEjNZKqCzSkYyWUtuJ4HiLnj+OWI=;
        b=SqEzxgBbBPh1ZFaiEYuzpYQTa3PzEuU/Qhy0xwSCJbHDwdk1gfoze2szaTgaCHOhUW
         pB6qH1pLvZIk611u9WLw/3KFqAJBb/hULgyBaaKK4lROfFF4Mk5Z2NbXHPy2w7RR6oD9
         ZKgD2eUIBJf2fPjdUdmzkDOsAKBycctgYQlgEmN35hkGjoy7SMTL2bhXoxHb89wol6Q7
         Lhu7RtfETDpX0wvRRoLIUzJKwAdVuAt/fpOBatFK1zIzaCaotXHKxdbtCxG+q/Rc3Y4B
         y8m40MeU+mHt50Q+/zpaiwiuhyrIqdlbgvc9AVbF2MveN3GiQ/qIGSPnQ8rtkeV4S7Cz
         x7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776023533; x=1776628333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gi7zym9X+1fkJs6JEjNZKqCzSkYyWUtuJ4HiLnj+OWI=;
        b=Ba9Dt/WFDdITBmAdoXoJI0UKGGqNIinwZtWXeXfbP0MJ4Ma7d8AEvF7m+fHXA04nqn
         dnHTfLobPRxjonxaogbsGJ43uocI9w4RuieJBOELOnhdwAuR/xlnKeKnSaF6P0oFYKcl
         53Skcs00BKAxuzvrzzBybxm7H/u2NY0Tq3Ol+sPBTlDu10ebEaAk9kz11xbbhJ9NITNc
         SoRzHx9h8oEfMhrYRD/dhkAOsfVlbYk2RnHhBwlwC6wBO2MC96rtm9iPyliNsPLwSll9
         8sfmA8rJRfjwHl6n7v5dW9v5HsL+N7XvPGaPNolciTfsAzMtMv44021lkfzJkf9SR+/N
         uffA==
X-Gm-Message-State: AOJu0YxDXaJ1oBmLQsz/09NnOdx0LbA+EVEEKFoKrqNtiUBTF4Tf9hfI
	iecsCg9jSAbOOC89RPlknmIFSUDmn/VWCCO2IpqNe4DANqVAu19xbVBT1bDpHQ==
X-Gm-Gg: AeBDietxl3FppN6weWqRAmpAOptDTM8SBXI2e/7DceWvIRskJNLOPBObW7D0i7XLFhD
	g4yPKL53Sj3H+WNr8vYb9BGZVAV7bN30augTm5JDHcu7CVDKMYwhi0aW+zM29JmhzUWVnP8WuK9
	1vWM1FT0gn9wD7VVso5qFpkxSnMGOuXMV/nso8XLVnrkwOkovj7qWtprNnJ9qYyQUQwneUEY5HI
	azTsc0VHTDVE//P9jbk250djvQkQq7db9xwMIzT7ZUj4+1+8X5OZUzG70CnC9p0qIBp3sJsfi1i
	dpZdkwL/kwtsaTiLNm3xBjyPQD1h0Yt4yv/yXxgZBhUP4ivFiVZmWixvTaR7cfLsxi7302dYUD/
	UXwzMSixId+sUfC6kDzjw6wbRri90FBVahIN0lDU1J5vh29x1Qe2V/0YTYezZCab7Fu1OboC+pC
	Jjeh50RZHusalJa7k5/geGDu1LGqp18UwTBevmeOXzF5ma71cycgJxDKicUfjZlXbAsgI=
X-Received: by 2002:a17:903:fa7:b0:2b0:6e6a:8504 with SMTP id d9443c01a7336-2b2d5a3033amr103165375ad.27.1776023532768;
        Sun, 12 Apr 2026 12:52:12 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([103.199.188.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f26cf3sm97051175ad.60.2026.04.12.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:52:12 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	mroik@delayed.space,
	quentin.bernet@bluewin.ch,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v4] stash: infer "push" when command line starts with an option
Date: Sun, 12 Apr 2026 19:52:04 +0000
Message-ID: <20260412195204.4636-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260404143640.6679-1-deveshigurgaon@gmail.com>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git stash" is run without the "push" subcommand, the command
tries to assume "push" but rejects any non-option arguments (i.e.,
pathspecs without "--") to avoid treating a misspelled subcommand
name as a pathspec.  The only exception is "-p", which sets
force_assume and allows pathspecs to follow.

This means "git stash -m foo file" is rejected even though "-m" is
clearly an option and not a subcommand name, and the user's intent
is clear.  The same applies to any command line that begins with an
option.

A command line that begins with an option cannot be naming a "git
stash" subcommand, so unconditionally assume "push" in that case and
allow pathspec arguments to follow without requiring "--".  This is
simpler and more robust than checking a specific list of options,
and remains correct even if push or other subcommands gain new
options in the future.

Note that this does not check for negated options, so "git stash
--no-staged [<pathspec>]" is still rejected.  Handling negated
options would require teaching the inference logic about them
explicitly.

This was marked as #leftoverbits in [1].

[1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---

Changes since v3:
  - Rewrote the approach per Junio and Phillip's suggestion: instead of
    checking a specific list of push-only options, unconditionally
    assume "push" whenever the command line begins with any option.
    This is simpler and robust against future option additions, and
    sidesteps the fact that -m and --include-untracked are not unique
    to "push".
  - Updated the test to reflect the new rule and switched cleanup to
    test_when_finished per Junio's suggestion.
  - Updated documentation accordingly.

 Documentation/git-stash.adoc |  7 ++++---
 builtin/stash.c              |  6 ++++--
 t/t3903-stash.sh             | 26 ++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..135719611a 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -61,9 +61,10 @@ COMMANDS
 +
 For quickly making a snapshot, you can omit "push".  In this mode,
 non-option arguments are not allowed to prevent a misspelled
-subcommand from making an unwanted stash entry.  The two exceptions to this
-are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
-which are allowed after a double hyphen `--` for disambiguation.
+subcommand from making an unwanted stash entry.  Pathspec elements
+are allowed after a double hyphen `--` for disambiguation.  When
+the command line begins with an option, "push" is inferred and
+pathspec arguments are also accepted without `--`.
 
 `save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [-a | --all] [-q | --quiet] [<message>]`::
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..be96338d35 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1871,13 +1871,15 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	if (argc) {
 		int flags = PARSE_OPT_KEEP_DASHDASH;
 
-		if (push_assumed)
+		if (push_assumed) {
 			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
+			if (argc > 1 && argv[1][0] == '-')
+				force_assume = 1;
+		}
 
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage, flags);
-		force_assume |= patch_mode;
 	}
 
 	if (argc) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..88f2b3c86b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -410,8 +410,30 @@ test_expect_success 'stash --staged with binary file' '
 '
 
 test_expect_success 'dont assume push with non-option args' '
-	test_must_fail git stash -q drop 2>err &&
-	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
+	test_must_fail git stash someunknown 2>err &&
+	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''someunknown'\''" err
+'
+
+test_expect_success 'assume push when command line starts with option' '
+	test_when_finished "git reset --hard" &&
+	test_when_finished "rm -f untracked-file" &&
+	echo changed >file &&
+	git add file &&
+	git stash -m "implied push" file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --staged file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --keep-index file &&
+	git stash pop &&
+
+	echo untracked >untracked-file &&
+	git stash --include-untracked untracked-file &&
+	test_path_is_missing untracked-file &&
+	git stash pop
 '
 
 test_expect_success 'stash --invalid-option' '

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
2.52.0.230.gd8af7cadaa

