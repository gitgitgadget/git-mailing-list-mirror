Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563144;
	b=yA9wKZZ+go1arUnDpgebDW9rjuLwnLJmxqH6a7IiNBZO+A9DgdisOxIrY/PjVbDbHz/M
	 F/D6POp6K8ltBu2jdNlUwQo3Rotmw9dvFR/AzQxzLQsvVDhaAujn8xdobqGdFQUS7WIZb
	 1FcVTVskKfjUk2G2wM5JWE8WpisVJkr7ILNPbTDelbABHL+/zfGiqVQ0h/FCugbsFx5ma
	 xltf1p826o3YrJOv++iGiPickkY8FnW3oqEsLdl56vSCsuVEmJvnTlWgX1DbROWlh0q9n
	 WtrMBdLRbyVYJ2kz/EovNKcAaBSLcz7azZlqT+4DXn6Xbj6CMpnnF+cRDMWG7goUJvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tlpKCCkg1hSuZOotwcBu4HcfrMNB6Bnr1vibuJh3ijQ=;
	b=afVU/rxaxjZgMVbSoqNeHLLwI/tHiAt+yc7qp0mQbeXKViMoFShw03zUjSvGi9yL5jpp
	 updz14ItfuMtG3s5ayNx2cHWpvrAc5oFfbspLRk2O6QE0FCsBc3b8IeVEFnuJ0AomAmpH
	 kQxP+SVJHGncMZUh8AA/7W8n7L31Q+tEhntRHGQeeNkoX/eUG7Hq8z31RC7FULTNiut6G
	 gCBuJKW3FuYgSKYYZwq3/zckGFE8TEuMEY9XuiPD/lefnasFJo48jJ241TjdmZfxufg7/
	 ERV0ztywpcUndEr6+Xm8jzNRtpM0u8dj7vr/xOe/YFGOdLMaY5ZKyiBbHmmgUVQ4YhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cervined.in;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wch52qxU;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572A606A32A
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5572A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wch52qxU
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c31cdbeec9so889803e87.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795563142; x=1796167942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlpKCCkg1hSuZOotwcBu4HcfrMNB6Bnr1vibuJh3ijQ=;
        b=Wch52qxUY2JxOlTVA2vJmcyDGvQoGkacs87n+0iXwCHqtP3HO4zQeVSPoJ3gnXp/Ig
         SQv/MMWkNzDqcyFcjibzS4S6cnNujW0TsOSlSzoIMjm0ogQ0fX+SiXmHHpRCcqu6Ex4Z
         Uzg3Ak6ZOFFBxNoG7Euh/hhjumF62NvTJ1kAzDpw/cqMs29l5snelyEfKidoAZVpaTOy
         Ox7cZy6R7rrenBaEa6ZXu8YtHwqI3xVQ2Zg9xGaiwpcr+kOUR/ULyCugNLr+GqdlP7EN
         d1taPAzJrL4XEklFjnKZma6wNdt56c0seax83NsswrO+tvclOk4digJDXvyIJnEV6wN2
         cZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563142; x=1796167942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tlpKCCkg1hSuZOotwcBu4HcfrMNB6Bnr1vibuJh3ijQ=;
        b=cQwQh5FbsICxd235uZ9SgROPJ54Z2oMSYnrsHdHO5RvPBs2W8ValWKm04KC2tXodLJ
         O+QTApsnKM5S6jpKknQPe2Sg8rlgdGkh1iu66ujoBcyahWG/RzvJj5ZNVMZv4WNWpXDB
         MEkRbrhWfUcyw7ybHPwDsM+nK4LktEYrCvff8bYFO8eUrV/bgfnyCrcJr2UGSidMhs59
         4Fx12wTE1YOgtxy3h1+9dnNllqqsRruUElpdG6olfcWrJL7FaYZTDHSF9JgWFXMeeHrh
         73TaLXSJ1ObIpwxsCrZ/VdRGuePTJj0x4nnJelxw2ROnCxWoLjcP9C8Agq76rZc8/VZi
         SBpA==
X-Gm-Message-State: APuU4Z8G4Ko3Sv6rTzu5NG2O0V/Zmv8gTb2r3hCycm38vUZOkRCq+S7R
	CV8PMi1Pg+CC+ag0KaYNyv6enLAcrcc/MawlvZm6m01iwTKX6Ik41I/YjSSwlA==
X-Gm-Gg: AZFdTZcoJdwj4Yku66vGFWkwxOl6U+fODyKEuFpQyAiH6plPv9AonjU1L+dlWspgRsO
	tUUKgidqEBv1RJbIXfKZ6lfVuEAE9n9eidLwxvp0ywJSZ3SX/AKFbL4bpGt5EiBLctZhAeAbJ3o
	yKf+mi80z4Vs1l7k0dP5AIYoDAGv22TlOQFr5dZ6ENYRzsJkx6JFFnqNh+9wx97Vay7BN3mW/d5
	USquyPavFZ1H8woDpi6bAo0IM7Rr9q7TbI4omD+ibTUBg2Z4Ll6skUpBJa9TS7NSgDm1VRCYDTj
	4gmXNktX2kuoXMseMgMe9k+FTInVg/eSac2CdJ4f5gw1MeIDEQfkpN8DkcSwNkwzZy9sou7H+Xc
	K5b6G3p2CmVbEqMFRX2EIth6qwq5k5qn/KVv8/zIcQt6urxmPGDsF784DXOD6sCtfpqEQ2altfN
	pEs5J1mEydbWEEy24oNUVhoCkCx7NnTEW3Oei59+6cqkj+ZnWdDcNrraHXBkgLnrPqgDtqQZAmi
	kxHesxrMAabpcvR77o3SwLyc9qlPg1ECEylbiy5sOPtJfb0V/lZFoPrAHwWerknjsBqrro595V7
	7rQ6QPav7ZQOIpzmKYxEHqIFixXSsdTxTp8biREuJYyCuRtTPW0px4QNVh+DQD+41lvL112wyAS
	U4zobVNAoB/0YUaryIoEvScgdevmOavgSd5iEclY1RTvvqQ==
X-Received: by 2002:a05:6512:b9d:b0:5c1:5975:a6d0 with SMTP id 2adb3069b0e04-5c1bc813d73mr4620897e87.49.1795563141993;
        Tue, 24 Nov 2026 15:32:21 -0800 (PST)
Received: from localhost ([2001:2043:be0a:d700:bd32:e7e3:cfbd:5b51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0417f4sm4128538e87.54.2026.11.24.15.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 15:32:21 -0800 (PST)
Sender: Erik <erik88@gmail.com>
From: Erik Cervin-Edin <erik@cervined.in>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v4 2/3] commit: allow -m/-F for all --fixup variants
Date: Wed, 25 Nov 2026 00:32:10 +0100
Message-ID: <051b659965fb31ee7c074d0cd31719fdf2027701.1795562078.git.erik@cervined.in>
X-Mailer: git-send-email 2.56.1.978.gcc9bcf3eaa
In-Reply-To: <cover.1795562078.git.erik@cervined.in>
References: <cover.1790082176.git.erik@cervined.in> <cover.1795562078.git.erik@cervined.in>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ability to provide a commit message for git commit --fixup and its
variants is limited:

  * Plain --fixup accepts -m but not -F

  * The amend/reword variants accept a message only through an editor
    (or a GIT_EDITOR script standing in for one)

This makes the amend/reword variants poorly suited for non-interactive
workflows -- notably when using AI coding agents.

When --fixup learned to take -m [1], it was noted that other options
(-c/-C/-F) could also be supported, but were left out for lack of a
clear use case.  Later, when the amend suboption was introduced in [2],
-m was initially supported for amend fixups too, but was dropped for the
same reason [3].

The rejections of these options hark back to when --fixup was introduced
in [4], but as [1] noted, nothing inherently prevents supporting them.

The current patchwork of which options work with which --fixup variants
has no strong logic to it, and allowing all of them simplifies the
interface.

Allow -m and -F to supply the message body for all --fixup variants,
mirroring the flow of a regular commit.  With --fixup=amend/reword the
given message replaces the one that would otherwise be copied from the
target commit.  Options -c and -C are handled in the next commit.

1. 30884c9afc (commit: add support for --fixup <commit> -m"<extra
   message>", 2017-12-22)

2. 494d314a05 (commit: add amend suboption to --fixup to create amend!
   commit, 2021-03-15)

3. https://lore.kernel.org/git/xmqqft1o80pe.fsf@gitster.g/

4. d71b8ba7c9 (commit: --fixup option for use with rebase --autosquash,
   2010-11-02)

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 Documentation/git-commit.adoc             | 19 ++++----
 builtin/commit.c                          |  5 +-
 t/t7500-commit-template-squash-signoff.sh | 56 +++++++++++++++++------
 3 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..61efd29e66 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -103,20 +103,21 @@ include::diff-context-options.adoc[]
 The commit created by plain `--fixup=<commit>` has a title
 composed of "fixup!" followed by the title of _<commit>_,
 and is recognized specially by `git rebase --autosquash`. The `-m`
-option may be used to supplement the log message of the created
-commit, but the additional commentary will be thrown away once the
-"fixup!" commit is squashed into _<commit>_ by
+or `-F` option may be used to supplement the log message
+of the created commit, but the additional commentary will be thrown
+away once the "fixup!" commit is squashed into _<commit>_ by
 `git rebase --autosquash`.
 +
 The commit created by `--fixup=amend:<commit>` is similar but its
 title is instead prefixed with "amend!". The log message of
 _<commit>_ is copied into the log message of the "amend!" commit and
-opened in an editor so it can be refined. When `git rebase
---autosquash` squashes the "amend!" commit into _<commit>_, the
-log message of _<commit>_ is replaced by the refined log message
-from the "amend!" commit. It is an error for the "amend!" commit's
-log message to be empty unless `--allow-empty-message` is
-specified.
+opened in an editor so it can be refined. The replacement message may
+also be supplied directly using `-m` or `-F`, bypassing the
+need to open an editor. When `git rebase
+--autosquash` squashes the "amend!" commit into _<commit>_, the log
+message of _<commit>_ is replaced by the refined log message from the
+"amend!" commit. It is an error for the "amend!" commit's log message
+to be empty unless `--allow-empty-message` is specified.
 +
 `--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
  --only`. It creates an "amend!" commit with only a log message
diff --git a/builtin/commit.c b/builtin/commit.c
index 698823d4fa..e0fac284bc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -793,8 +793,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		repo_format_commit_message(the_repository, c, fmt, &sb,
 					   &ctx);
 		free(fmt);
-		if (have_option_m && !strcmp(fixup_prefix, "amend"))
-			die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
 	} else if (squash_message) {
 		/*
 		 * Insert the proper subject line before other commit
@@ -1331,9 +1329,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
-	die_for_incompatible_opt4(!!use_message, "-C",
+	die_for_incompatible_opt3(!!use_message, "-C",
 				  !!edit_message, "-c",
-				  !!logfile, "-F",
 				  !!fixup_message, "--fixup");
 	die_for_incompatible_opt4(have_option_m, "-m",
 				  !!edit_message, "-c",
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 5e782ad8d7..9b2ecb1356 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -384,18 +384,24 @@ test_expect_success '--fixup=reword: ignores staged changes' '
 	test_cmp foo actual
 '
 
-test_expect_success '--fixup=reword: error out with -m option' '
+test_expect_success 'commit --fixup=reword: works with -m' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: options '\''-m'\'' and '\''--fixup:reword'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
-	test_cmp expect actual
+	git commit --fixup=reword:HEAD~ -m "reword commit message" &&
+	test_commit_message HEAD <<-EOF
+	amend! $(git log -1 --format=%s HEAD~2)
+
+	reword commit message
+	EOF
 '
 
-test_expect_success '--fixup=amend: error out with -m option' '
+test_expect_success 'commit --fixup=amend: works with -m' '
 	commit_for_rebase_autosquash_setup &&
-	echo "fatal: options '\''-m'\'' and '\''--fixup:amend'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
-	test_cmp expect actual
+	git commit --fixup=amend:HEAD~ -m "amend commit message" &&
+	test_commit_message HEAD <<-EOF
+	amend! $(git log -1 --format=%s HEAD~2)
+
+	amend commit message
+	EOF
 '
 
 test_expect_success 'consecutive amend! commits remove amend! line from commit msg body' '
@@ -432,6 +438,13 @@ test_expect_success 'deny to create amend! commit if its commit msg body is empt
 	test_cmp expected actual
 '
 
+test_expect_success 'deny to create amend! commit if -m is empty' '
+	commit_for_rebase_autosquash_setup &&
+	echo "Aborting commit due to empty commit message body." >expect &&
+	test_must_fail git commit --fixup=amend:HEAD~ -m "" 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
 	commit_for_rebase_autosquash_setup &&
 	cat >expected <<-EOF &&
@@ -468,10 +481,26 @@ test_expect_success '--fixup=reword: give error with pathsec' '
 	test_cmp expect actual
 '
 
-test_expect_success '--fixup=reword: -F give error message' '
-	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
-	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
-	test_cmp expect actual
+test_expect_success 'commit --fixup works with -F' '
+	commit_for_rebase_autosquash_setup &&
+	echo "message" >msgfile &&
+	git commit --fixup HEAD~ -F msgfile &&
+	test_commit_message HEAD <<-EOF
+	fixup! $(git log -1 --format=%s HEAD~2)
+
+	message
+	EOF
+'
+
+test_expect_success 'commit --fixup=reword: works with -F' '
+	commit_for_rebase_autosquash_setup &&
+	echo "message from file" >msgfile &&
+	git commit --fixup=reword:HEAD~ -F msgfile &&
+	test_commit_message HEAD <<-EOF
+	amend! $(git log -1 --format=%s HEAD~2)
+
+	$(cat msgfile)
+	EOF
 '
 
 test_expect_success 'commit --squash works with -F' '
@@ -526,8 +555,7 @@ test_expect_success 'invalid message options when using --fixup' '
 	git add foo &&
 	test_must_fail git commit --fixup HEAD~1 --squash HEAD~2 &&
 	test_must_fail git commit --fixup HEAD~1 -C HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -c HEAD~2 &&
-	test_must_fail git commit --fixup HEAD~1 -F log
+	test_must_fail git commit --fixup HEAD~1 -c HEAD~2
 '
 
 cat >expected-template <<EOF
-- 
2.56.1.978.gcc9bcf3eaa

