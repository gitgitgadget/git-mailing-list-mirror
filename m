Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299D1BD9C9
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775313412; cv=none; b=Wf4XkO4nTi5NEddwu+8LdScltwgHrwWQaB0ntw1cu8Vr10PfjXspZ3iFpBb4q5pWdovaLDyAnjDlUreY28g2uTLN21xEShFVrH21MChwbNMC4sW/Q3Uaaw2K+WUy0J3qiIqmqStfJwOZwXTFJBkOPPu0d+JAqgWGJDlYmqWN3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775313412; c=relaxed/simple;
	bh=l+Yn6sc9Aw4eLAYOJq7oQ+OOUAziEuRW6tAngRugm58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfsgblr/UNPqAx/O4AkAMRojasnEVs7uNOOeAg4p3hsRLt0msbTH4F4oZZ3uvc1dt4/Bh3p4Gn1oMbwwCQ/CzTgdIwjyrzfNL5tgGR7//fzLtECWp8IDLZV1EYQ+S25HSE7reUDEH2YathlOZEfeVjvQBhTEV2bv3G4XK9s2Z0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoKMOt3B; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoKMOt3B"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70c112cb61so1546728a12.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775313410; x=1775918210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfMrgdiqroI7cnneFzpOvGijNTSTfX02lnuh/g3QiDk=;
        b=JoKMOt3BiSsKPVbsft620eqDbVOsDLfLMdhHvseXytTD+VUoQbP9ePePxL4p7JSqDI
         zZ1El4lvUQ1uBhuMHeCEFxwzQLkf5EwWEt2dgflPf0BNgUKa/legM270vBvasfZICPvC
         FevjX+jXqJviWk8pooeOeXynFuhuwJQtmDt+8zXFBJ8lEr7JGwMnvNZoasaAB82AZiPf
         j4oE+o5g8NzV20ibidAz9/WIXLm6FatAx6jn5/hqHWrvHM5w3eWggj4v7+AXFoSUBB/M
         3W8Vec5Vl4K8bm8qmxurjmDG+eokjVkHT3JvTB6LhaDtiCXxuys6IzJMfPpqnV5yOb4e
         5pMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775313410; x=1775918210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfMrgdiqroI7cnneFzpOvGijNTSTfX02lnuh/g3QiDk=;
        b=GR8gHyTclouaip+9aqmdhdfV2EeP3OMzrmnIXh866Wx0Wd6YjXH8dgQDzL082X6jex
         yPosEGwipYf3AjjKYZCJbZQpGo/Axwrfk0odFEmlvbZPaXHhi9R+WLFzyKOQgG/hMaH2
         FkHx3dt1+D/me68WQ/fOQPLJNX4msYkzreMnVJPzkDeSoPxKk81QJLXMT942avmonFPC
         ScKVmcdbi9i/fe9H6SyR3Tws2SA4CfMsy5k0JS/GYbNBipghSwojLmCmj8IQTWtbCIlO
         Cruri2FPJyBJcpg8d16BI8Kd+ivjTljUgln8NrEQK3jhGapymxW4VtQHlVYHkjmy2l3Y
         75Iw==
X-Gm-Message-State: AOJu0YwLy69dmW8Z5ylWYDIq+fiT7oxICBUkj8hK+LzinG7RfjghRwsr
	ahSaUOLth6TmX0gOcuaiMyrxsY5pXuwqJWLIKAZLVycNWY5zRijLdlCw+Wkr9A==
X-Gm-Gg: AeBDiesmkJKoq1kIi6kA2cza2Rf6t/VCofyL7DC1CHdi27XbFoZ1kZOEFEJ6DnwqoXj
	CnB+hepGN6hODwtEgYOG8fwL4xL50Ta7hybCkPZCiIxI90KdrIOGc/iDc/Nz8ZLYW0DCcXVSsVQ
	a7zSb47Eondys0Y1DOVUE/VEqDxuL3ou5EofV6wBY4HrihILCFO312Otak5HwXoe9ZoBjp5BZPi
	oL+nuiH/ZLvyEHI+JX6kAy/CVPAiY1MfQwz3n/WK4stB5FCCwyvroEr5gih71DE+viodZX3+IRM
	jGNluaFlCo38d9vArrxojLzvslRjUIWs/vhGtgg6OkvMrg4+D8YctBx0e1Pw4KTeB7qBowoOkux
	XSeoN9GYkp8NBO0+mMaBn8xPi7djcT1T12sHMK8mS2SHdIEXvz41izj/ID+eSHql8Zy47osX6Db
	rMDz/4M8MTc6YBnEdAcOftAlmvW8du0zoBvNOzOQHBaYVa
X-Received: by 2002:a05:6a20:6a24:b0:39c:a78e:dba9 with SMTP id adf61e73a8af0-39f2f0b2d10mr6726242637.40.1775313409828;
        Sat, 04 Apr 2026 07:36:49 -0700 (PDT)
Received: from d ([106.202.55.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm7620422a12.24.2026.04.04.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 07:36:49 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	mroik@delayed.space,
	quentin.bernet@bluewin.ch,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH] stash: infer "push" when push-specific options are given
Date: Sat,  4 Apr 2026 14:36:40 +0000
Message-ID: <20260404143640.6679-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
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
unambiguously a "push" option, and the user's intent is clear.  The
same applies to other push-specific options like "--staged",
"--keep-index", "--include-untracked", and "--pathspec-from-file".

Expand the set of options that force the "push" assumption to
include all push-specific options, so that pathspec arguments are
accepted without requiring "--" or the explicit "push" subcommand
when the command line already contains a push-only option.

This was marked as #leftoverbits in [1].

[1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 builtin/stash.c  |  4 +++-
 t/t3903-stash.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..197814241c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1877,7 +1877,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage, flags);
-		force_assume |= patch_mode;
+		force_assume |= patch_mode || stash_msg ||
+			keep_index != -1 || only_staged ||
+			include_untracked || pathspec_from_file;
 	}
 
 	if (argc) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..9812b64989 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -414,6 +414,27 @@ test_expect_success 'dont assume push with non-option args' '
 	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
 '
 
+test_expect_success 'assume push when options imply push' '
+	git reset --hard &&
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
+'
+
 test_expect_success 'stash --invalid-option' '
 	echo bar5 >file &&
 	echo bar6 >file2 &&

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
2.52.0.230.gd8af7cadaa

