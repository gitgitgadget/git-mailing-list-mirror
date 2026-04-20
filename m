Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090443876BE
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716044; cv=none; b=XZ0tPIM89q+6iQ4zYFmRcKJUnb4UeY0NY1b+r9SvFUywZi3NFceCxqOiHda/wJvhIbb7v1zll6wdg4bj5RqTlzEK/pItRyk7Q3y5aAyMLhW9x7jFw3i3rCBz3g6VtDMRaT7sGfRTZ1W6cyw9Zt/NWmTwk9R6CjjzspuFJSQ3W7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716044; c=relaxed/simple;
	bh=Gsidv0L1GTPBoyUQ/LbkBFT9NOZADoOoqhi/5gIYgHs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=t7KAWMCAEKS17mygVAYUCgAKD4fkuLE0v+dyeSqZFPXLlCX7FhzC7jtts72Mh44U92xKVmg0qGb5+c8E1OG5de9sOg+Hxu0eu6XRgXD6AeEuYmvLlJ0L2KzNvn4rtmU62FPhYDYbuS6dY2zO8zzg/AOyGSBWyx/02w1G/K+72wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiWo+Qh1; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiWo+Qh1"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c726f46baso4163788c88.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776716041; x=1777320841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh+EtqkYF6RVUF+DjQVQL2e0wtWgjc1CPEdpFLcQISY=;
        b=KiWo+Qh1BMTXGawvp4Nrxghb2gyvlvGU/wHvG1uqt8r+TZqHJZlGWV0HYfEEBWCVP9
         0XMR8s7XuKSfvqsbPwkW1kv1e8FnaEpSOAIEK5v7TLfsfk+7xoQoqgCuRDBUdbTYZss2
         etwFZvDUNOrsLUq7GDRR5RP7iyX+NHr2xpSgDJ0By6qoxnASVjsdVyLAtIh3PaofVi+c
         /a8JDeGocaWK47k8oTro4R6c+4fFlD+MHCAPfIO+hDN6tlkUM2Fqv1x/H/+NLIoqGcrx
         dc8g8ETWLERiKipsOvVqZpnbDUVKQ3oMRdPh3Lmilh53tvUsOI3st2aHcD1yj/QlBSga
         aHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716041; x=1777320841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh+EtqkYF6RVUF+DjQVQL2e0wtWgjc1CPEdpFLcQISY=;
        b=ftcTIv4aAcLrN8wNrqpifVyQRU5/s30Ri/D0fcT85mFMaUQ/s2JoKb41VTdFSh8ZJY
         P1WmUkHmahsc0LtKT4eBxjsmimnSyW87JPa+Ukm6Gy7CLrkpSWJi2clSnDKGsCXa3PQJ
         Huzt456vLizuADoJos2F1uYKK+fau/h17UROqvGijKVR9zDp3xS3w+piVtwRRDkXzeph
         UKJp3xGYJh29aNm14AVc8WWZI81W6TRhAntbLs5tMCBlBInftItlypOmx3/B68OK2Dk4
         WUtOSmbVkFGMUJUSdp+8lg9Y9NMIxzO8EHGJHbEG7OTW0cznZcJPMUROLMAuq3l8yMtD
         OuLQ==
X-Gm-Message-State: AOJu0Yzuof7mr4dXLonP8RkORlgb4pLq50i92L5Pe41H1damO4qoIkq7
	7DNbbWBOtxVCp17vNnwUrl7P9cHuLtMRjVJM9vWK0YACt/Roy7y/MfqKTbhAFVrM
X-Gm-Gg: AeBDietznXEqKJJ5PeWoXc0XnhJYOOBGnO+QHABRuozr8cwY3LT8XGlWlIn1NAK6Z/1
	wPDBr4b/Rs6NeLU0un0IcJx37zJ//qOAMf+SgtchkvdCQsZGAkGatKlWl6xttwkb9w2rfIvZ5fc
	9zLEkuS1MZA7WCMM67wfgBTKxPop7oyynFIHLAbXtEJjRzav1g5fLOscdkRxA4IgV5ivtGWY32T
	VceucmyVmE9Lm2HOk8tdZkQN1zROT7SC+qvS3yzJNpI/D5PBrq+UzVyrXtQgXhAyyiUTAVoVFUU
	p0KRyWWk1h3pd95z0BFPubSAB18QY2O2hHkrtq2gpjNwD9XdR/AIv12WCo6c6Qm5sILxpzAbW1u
	GPGc9YjXpd67nbeIAyKR18idtDLZPIdpDobeprMYNDZCkQUaEOTTp2/eeS6/ExfrL0p69WdsooM
	zA9BNjjeFMKoWwLPGz5PA6mGadA4r+YSPBVA==
X-Received: by 2002:a05:7022:12b:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-12c73fa8d16mr8304118c88.34.1776716041028;
        Mon, 20 Apr 2026 13:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.1.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8bd2sm15650099eec.11.2026.04.20.13.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 13:13:59 -0700 (PDT)
Message-Id: <pull.2276.git.git.1776716038088.gitgitgadget@gmail.com>
From: "Kraktus via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Apr 2026 20:13:58 +0000
Subject: [PATCH] commit -v: add --word-diff opt to commit template
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
Cc: Kraktus <rinses-riotous8n@icloud.com>,
    kraktus <rinses-riotous8n@icloud.com>

From: kraktus <rinses-riotous8n@icloud.com>

`--word-diff` was available for the `diff` command, but not for
the `commit` one, whereas it is very useful when updating column-based
data-format like CSV for example.

Only support the PORCELAIN mode for now, but if deemed necessary can
add plain too, I don't think COLOR makes sense when outputting a file.

Signed-off-by: kraktus <rinses-riotous8n@icloud.com>
---
    commit -v: add --word-diff opt to commit template

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2276%2Fkraktus%2Fgdiff_word_commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2276/kraktus/gdiff_word_commit-v1
Pull-Request: https://github.com/git/git/pull/2276

 Documentation/git-commit.adoc |  4 ++++
 builtin/commit.c              |  4 ++++
 t/t7507-commit-verbose.sh     | 45 +++++++++++++++++++++++++++++++++++
 wt-status.c                   |  2 ++
 wt-status.h                   |  1 +
 5 files changed, 56 insertions(+)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..6cb5359b52 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -371,6 +371,10 @@ If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
 changes to tracked files.
 
+`--word-diff`::
+	Show a word diff instead of a line diff in the verbose commit
+	template (requires `-v`).
+
 `-q`::
 `--quiet`::
 	Suppress commit summary message.
diff --git a/builtin/commit.c b/builtin/commit.c
index a3e52ac9ca..b24f086fd2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -126,6 +126,7 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int commit_word_diff;
 static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static const char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
@@ -573,6 +574,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		s->reference = "HEAD^1";
 	}
 	s->verbose = verbose;
+	s->word_diff = commit_word_diff;
 	s->index_file = index_file;
 	s->fp = fp;
 	s->nowarn = nowarn;
@@ -1705,6 +1707,8 @@ int cmd_commit(int argc,
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
 		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
+		OPT_BOOL(0, "word-diff", &commit_word_diff,
+			N_("show word diff in verbose commit template")),
 
 		OPT_GROUP(N_("Commit message options")),
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index b53d71c086..98693d22f2 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -166,4 +166,49 @@ test_expect_success "status ignores commit.verbose=true" '
 	! grep "^diff --git actual"
 '
 
+write_script "check-for-word-diff" <<\EOF
+cp "$1" template_out
+exit 0
+EOF
+test_set_editor "$PWD/check-for-word-diff"
+
+test_expect_success 'setup for word-diff tests' '
+	echo "the quick brown fox" >wordfile &&
+	git add wordfile &&
+	git commit -F message &&
+	echo "the slow brown fox" >wordfile &&
+	git add wordfile &&
+	git commit -F message
+'
+
+test_expect_success '--word-diff with -v shows word diff' '
+	git commit --amend -v --word-diff &&
+	grep "^-quick$" template_out &&
+	grep "^+slow$" template_out
+'
+
+test_expect_success '--word-diff without -v is a no-op' '
+	git commit --amend --word-diff &&
+	! grep "^~$" template_out
+'
+
+test_expect_success '-v -v --word-diff shows word diff in both sections' '
+	echo "the fast brown fox" >wordfile &&
+	git commit --amend -v -v --word-diff &&
+	grep "^-quick$" template_out &&
+	grep "^+slow$" template_out &&
+	grep "^-slow$" template_out &&
+	grep "^+fast$" template_out
+'
+
+test_expect_success 'word-diff markers stripped from saved commit message' '
+	git commit --amend -v --word-diff &&
+	check_message message
+'
+
+test_expect_success 'no --word-diff produces line diff without markers' '
+	git commit --amend -v &&
+	! grep "^~$" template_out
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 479ccc3304..086275bae3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1177,6 +1177,8 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
+	if (s->word_diff)
+		rev.diffopt.word_diff = DIFF_WORDS_PORCELAIN;
 	rev.diffopt.file = s->fp;
 	rev.diffopt.close_file = 0;
 	/*
diff --git a/wt-status.h b/wt-status.h
index e9fe32e98c..90883d2c28 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -130,6 +130,7 @@ struct wt_status {
 	int detect_rename;
 	int rename_score;
 	int rename_limit;
+	int word_diff;
 	enum wt_status_format status_format;
 	unsigned char added_cut_line; /* boolean */
 	struct wt_status_state state;

base-commit: e8955061076952cc5eab0300424fc48b601fe12d
-- 
gitgitgadget
