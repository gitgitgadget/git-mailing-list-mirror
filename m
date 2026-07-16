Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BF38886F
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 05:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180167; cv=none; b=dAV/9v85gmh2ARO9zF6ALbfWD1usGv01YCZi3CBOljEuGqBj2kjW0+0lq/n/U1IYxlkjD5xmp9BhyqlQ9bXG1tWn9pmqm17nFVAjKKRKThrYycXRYmgY0K1gYUXsmPSNEnE0fh9pEQXqOQaNlkrbjUi31pPNZh9YE2JEUN/jed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180167; c=relaxed/simple;
	bh=wlTXlqdWWHdxTDxerfw35wA//DUa3HH+HbGl338nSBg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iT4fdQx8yjHcrZh+8u6ZM7qZeVYbSEsKrhAn3Z7ye2p2a8jeWSWa3SGhxmQTac1BiCrKyC8ORmpJ1z9s9YPICqS4A3vDT0Chak0+JR3K8mf38REmQ51DVTueTnotDTwxLo1LJcYHcWaGmV+x4vnVATJ/CN8o7Dukgt1sqqfOZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SStyiYih; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SStyiYih"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9305a2121a1so266037085a.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784180164; x=1784784964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C53GgDGJlkHtno0UpCIlRfx22LmfK0j+WIrZ/7IXECA=;
        b=SStyiYih3sb9TMqZAj9tR9e9MMQsshvVU9bipOI+7vbmWNEYidoI4df8kdGdJX7oGE
         uh7+buMYhkvRIHqCAxx2WZ5bBEBVnpyUELmXJeVLFgcMo2YfpyzHEuaUB5vWRYoZfIQ0
         5x2WhKUMxsgHLVAk0ulffUV92t/udGxAc6HS1o4EnCVl9CheLZyR8IxVhBbtfFAtq39B
         K9cu1Cc2HMUhenUH7qozZ3CY2fhEc5eDzDFMjOTwDp5AUGuRAuZbLYYoSJriZVCfLzHg
         vYq6ko160n/QcWovhHJXLK0iOqktGZ0JyPz1o4PMRSyK72NLwww+qvjq93Zmymv6EHhq
         JHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784180164; x=1784784964;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C53GgDGJlkHtno0UpCIlRfx22LmfK0j+WIrZ/7IXECA=;
        b=nZwIAEjdEK4kmKUjdj5pvb00AFlpRjTYBW7aXAiY3J8Wl1AvuEKxKDSVXEf0ozbboy
         skrOLTaq3RwnsSvZ1l257yw1tt9YtRVPu61i5EYxX5VkGmm2wKgyG3Sn6SzwwfjBESS4
         01WsI+TNNbONfkdjw+gaV2XliH/8fB6n6Yx2wyglPPuAB9wyjrL7PGbTAXcFediy7CY4
         FuKue4Yy9nsMl9UhF3U2Qo9aR/3MYSW2BA/f+75dHeB5IkYzpA7s1EQflicTXKJxn6PR
         PetA8EBnnHRRz9UGrY4kKUChFcxrpUnqMgXJT5tJdb2uS7dioTZXh3fDDJLC46Dr1uyq
         lTdw==
X-Gm-Message-State: AOJu0YxnUJ6Y6RrM/mawK2rK8pONxD76bFc+2EV9stblMzGgtRLNQZAg
	LyeIcTtSyYuPl1rFYcx1p+A3ozxhtrL6uHwbiiN6cm2NP94uWASTHloQRr/ICpKz
X-Gm-Gg: AfdE7cnEmyLCnCx8n2RCPR+GC4+ayb7LlGJPsrf8QK4EYb2FHjylnIG6VIJrcT3J/bE
	47Os/zVM4vixUsZBflWYOnL+MWBum4vCmQx/SDmoQr8D2YNY/Gt6V54IoxVJi0Czo5uh4WpnvJU
	GAcYh9m3/zsw8vpyr+6kL1Lo+CCgmWDvEi0eocJyx5X9QBnKLIUhoR4lsW6vnXhQP0KqriYR7Q5
	AUEZlqkWUxlKY4eYFjRCHERxExRpMLj6SyH6v9iXvazxLLC8YeFNKwCNboWDvon5TCvn/ReQ4uO
	K1EbQiMrHNCWbTN/7DePL9vtvtkNZqjkB+VTo4vXRNi0tLESJuwbMPHnQqy/YYMfj76rPn/1Xcv
	nnyHqPfDEGb4tnnu/RTPYHCxnx1e3+bq/OE73Vvs3wV5v/zloww25cuqO+Jrfme8f5INaccNs7l
	lJ1A==
X-Received: by 2002:a05:620a:4415:b0:915:efa6:d718 with SMTP id af79cd13be357-93096375ae0mr652377785a.47.1784180164308;
        Wed, 15 Jul 2026 22:36:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.199.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cacb8sm214911496d6.49.2026.07.15.22.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:36:03 -0700 (PDT)
Message-Id: <a9194b1d00b260a7a7852eccec54c872618b5fdf.1784180159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 05:35:59 +0000
Subject: [PATCH 3/3] bisect: add --auto-reset to leave when done
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a bisection finished, "git bisect" reported the first bad commit
but left the session active until "git bisect reset" was run by hand.

Add an "--auto-reset" option, accepted by both "git bisect start" and
"git bisect run", that resets as soon as the first bad commit is found,
returning to the commit checked out before "git bisect start". The flag
is persisted in a BISECT_AUTO_RESET state file and the restoring
checkout is done quietly.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-bisect.adoc | 12 ++++++++++--
 bisect.c                      |  2 ++
 builtin/bisect.c              | 19 +++++++++++++++++--
 t/t6030-bisect-porcelain.sh   | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index d2115b2990..1b03dbba7a 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
+		 [--no-checkout] [--first-parent] [--auto-reset] [<bad> [<good>...]] [--] [<pathspec>...]
 git bisect (bad|new|<term-new>) [<rev>]
 git bisect (good|old|<term-old>) [<rev>...]
 git bisect terms [--term-(good|old) | --term-(bad|new)]
@@ -20,7 +20,7 @@ git bisect reset [<commit>]
 git bisect (visualize|view)
 git bisect replay <logfile>
 git bisect log
-git bisect run <cmd> [<arg>...]
+git bisect run [--auto-reset] <cmd> [<arg>...]
 git bisect help
 
 DESCRIPTION
@@ -385,6 +385,14 @@ ignored.
 This option is particularly useful in avoiding false positives when a merged
 branch contained broken or non-buildable commits, but the merge itself was OK.
 
+`--auto-reset`::
+	Once the first bad commit is found, clean up the bisection state and
+	return to the commit that was checked out before `git bisect start`,
+	as if `git bisect reset` had been run. The first bad commit is still
+	reported before resetting.
++
+This option may be given to `git bisect start` or to `git bisect run`.
+
 EXAMPLES
 --------
 
diff --git a/bisect.c b/bisect.c
index 94c7028d2a..a34309dd35 100644
--- a/bisect.c
+++ b/bisect.c
@@ -488,6 +488,7 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_auto_reset, "BISECT_AUTO_RESET")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1211,6 +1212,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
+	unlink_or_warn(git_path_bisect_auto_reset());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 27d30b549e..b80eccb635 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -24,11 +24,12 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_auto_reset, "BISECT_AUTO_RESET")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
 	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
-	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
+	   "                 [--no-checkout] [--first-parent] [--auto-reset] [<bad> [<good>...]] [--] [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_BAD_USAGE \
 	N_("git bisect (bad|new|<term-new>) [<rev>]")
 #define BUILTIN_GIT_BISECT_GOOD_USAGE \
@@ -48,7 +49,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
-	N_("git bisect run <cmd> [<arg>...]")
+	N_("git bisect run [--auto-reset] <cmd> [<arg>...]")
 #define BUILTIN_GIT_BISECT_HELP_USAGE \
 	"git bisect help"
 
@@ -688,6 +689,8 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 
 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 		res = bisect_successful(terms);
+		if (!res && !is_empty_or_missing_file(git_path_bisect_auto_reset()))
+			res = bisect_reset(NULL, 1);
 		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
 	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
 		res = bisect_skipped_commits(terms);
@@ -711,6 +714,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
+	int auto_reset = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
 	int flags, pathspec_pos;
 	enum bisect_error res = BISECT_OK;
@@ -743,6 +747,8 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--first-parent")) {
 			first_parent_only = 1;
+		} else if (!strcmp(arg, "--auto-reset")) {
+			auto_reset = 1;
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -857,6 +863,9 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	if (first_parent_only)
 		write_file(git_path_bisect_first_parent(), "\n");
 
+	if (auto_reset)
+		write_file(git_path_bisect_auto_reset(), "\n");
+
 	if (no_checkout) {
 		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
@@ -1242,6 +1251,12 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
+	if (argc && !strcmp(argv[0], "--auto-reset")) {
+		write_file(git_path_bisect_auto_reset(), "\n");
+		argc--;
+		argv++;
+	}
+
 	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 081116220a..5389ba388c 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -453,6 +453,40 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+test_expect_success '"git bisect start --auto-reset" leaves the bisection' '
+	test_when_finished "git bisect reset" &&
+	git bisect start --auto-reset $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_path_is_missing "$(git rev-parse --git-path BISECT_START)"
+'
+
+test_expect_success '"git bisect run --auto-reset" leaves the bisection' '
+	test_when_finished "git bisect reset" &&
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH2 &&
+	git bisect run --auto-reset ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH3 is the first .bad. commit" my_bisect_log.txt &&
+	test_path_is_missing "$(git rev-parse --git-path BISECT_START)"
+'
+
+test_expect_success 'without --auto-reset the bisection state is kept' '
+	test_when_finished "git bisect reset" &&
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_path_is_file "$(git rev-parse --git-path BISECT_START)"
+'
+
+test_expect_success '--auto-reset does not leak into a later bisection' '
+	test_when_finished "git bisect reset" &&
+	git bisect start --auto-reset $HASH4 $HASH2 &&
+	git bisect bad &&
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_path_is_file "$(git rev-parse --git-path BISECT_START)"
+'
+
 # We want to automatically find the commit that
 # added "Ciao" into hello.
 test_expect_success '"git bisect run" with more complex "git bisect start"' '
-- 
gitgitgadget
