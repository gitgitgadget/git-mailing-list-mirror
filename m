Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED92641EA
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733261; cv=none; b=Ouc24OzGzKKtANWgI6vf+1phC9xbdb2AYp9mWRIRUOUe9VEduWUOrho06mQMf20xu3yE1d1FGVFXjkseLqdX73McVEj5b30PHAQi84BEHSAq43Hk4cCE88mVMaQ5UQVAr+KG36hx5cu5fCaw3mXFG0aAZYPV+uhJQn/Rt2gyWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733261; c=relaxed/simple;
	bh=0ay7jvGDPN3FAlsaH6FFE4bo7Bud715e3fOov0EoT9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmzJO46/CSmKPpo1aKR1H5wZ9fdLrhX3KBeqHY3HSkPcnHQkb6FqaCsLsRkVuEjiMfpM2/+gOy9at5EJBngLGcPtMzkFlon3oDxk7eNvhwS73Anzh8TZI8mI9x2aMgsvu6ypEtdzOBz0D0QC4SZAPco9jK/GqE/aFmHPkee+i+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1zPpfc9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1zPpfc9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so43067425e9.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747733257; x=1748338057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+4nMuBRHIBrIWvlanrmwkYN9W9UAKvbmj0KJb2uFwtw=;
        b=V1zPpfc9jzH25mW46WOWVeCJGtJDQd9KZ+wjX3gBiAKf0fwWpMx5hF2ES+InTSYf/W
         O5lSxXpmapZHWkWTOUvWlN1qkkro3MmNo+n4baMXczitLTs2tbnPrT65Or5CgR4RHpgM
         rx2ciJ3jj0sb4aUo7hMIsuo1nJWgCcj2bAJEDHyqRdBUE9lN+vwmkCDuzLN6+rIGCHhK
         2cimt+/XqUpa0ZxlQiQARSyz13wbCWSSHapGptzdHKGE2wXGVNizQAx9yiF2zkVmhr1+
         jI4XcZLTMLDVoy+FZUDV1TS71s6fN6sjZbNNYxwl8meZL2F0LCSloCMns3V18FhgIXqx
         RyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733257; x=1748338057;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+4nMuBRHIBrIWvlanrmwkYN9W9UAKvbmj0KJb2uFwtw=;
        b=wh/d6x8+++C1+Minmz3GYL/BvM7KVkwmfbz93ZM5edpENxHdA3iytZAn2g5eAlhrMs
         Y1B6/4O2a01uFrvBTLMP+P24bOXjoqV78ndTWd2DRiigatJjDvp2OWry0MyHbiqNvHGo
         AOzdg7nkYCmGHvfFNBKyzGQM+rAc8LTbZ7tdzz2Y0yTDR5QvT3TnLPfs2ZjAQRX0unGk
         R76Do6gH0hddzs/H8kbXw/rF4R9+Odo4mryJTfsrsPHQmUTwdDLpx5+cBPjcrhQZbLcR
         wq66e1zlheG9YliKgW2lMTNr9659KQ4x2tcT2piq9DM0e95w22R2iY6+fmk/je/FXw3t
         hA9Q==
X-Gm-Message-State: AOJu0YxIwMKa23XAgGw47Wz7xP2yEzN/xukrXX/54OJ7llDij7D/BPD2
	VMuVu+zo6oSHFEduf9l49lyoBZWNCnihQSeohyTQGJGw0sRY/6lk09UcyLi0Ww==
X-Gm-Gg: ASbGncs7URCe3+d8aU0c9+6D9etsRSUXaJg9k3f4jf3a6asvQwD/7xaAvTp8JJr6AcC
	rhxKx7ER7uYZPS1h78HvdD/d3F+kp3XYu7NTzagOjWTL/pA/wiV2mYr/IJKhoCR+hyvuVAhSgs8
	34SR74RtersTZuJUjRi/pbloTVTpQwwwg/912KjcnZrkc0apr82nmWkQweXt2U30jUUFZih6cV3
	Tjoso5vkpW8poLvrBVA5IgTta8jY0M1rbtaDmdOQaDpdvES28BPT13r6QBi00Lizxq0xefgcqTa
	+YLzC8QXRiYA9hLX0xCDyST04atOc2RDcfwpSv/EICNCTOAa5Tdt0kWGmMX+x7kpZss=
X-Google-Smtp-Source: AGHT+IEJBAtomPB7gy9YdPA1pypAxP/Dv/4eR6dn/tnLOpeC3C42eDaxYRSm3vQUin5vczCtz4qshg==
X-Received: by 2002:a05:600c:19c8:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-442ff000bf6mr115561625e9.18.1747733257271;
        Tue, 20 May 2025 02:27:37 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062c7sm23544255e9.14.2025.05.20.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:27:36 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/2] stash: allow "git stash [<options>] --patch <pathspec>" to assume push
Date: Tue, 20 May 2025 10:27:00 +0100
Message-ID: <98ad3de977090a793408b25ca880b65f058ea44e.1747733203.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747733203.git.phillip.wood@dunelm.org.uk>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk> <cover.1747733203.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The support for assuming "push" when "-p" is given introduced in
9e140909f61 (stash: allow pathspecs in the no verb form, 2017-02-28) is
very narrow, neither "git stash -m <message> -p <pathspec>" nor "git
stash --patch <pathspec>" imply "push" and die instead. Relax this by
passing PARSE_OPT_STOP_AT_NON_OPTION when push is being assumed and then
setting "force_assume" if "--patch" was present. This means "git stash
<pathspec> -p" still dies so that it does not assume the user meant
"push" if they mistype a subcommand name but "git stash -m <message> -p
<pathspec>" will now succeed. The test added in the last commit is
adjusted to check that push is still assumed when "--patch" comes after
other options on the command-line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c  | 10 +++++++---
 t/t3903-stash.sh |  4 ++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index bc2c34fa048..b12fd6c40f1 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1789,11 +1789,15 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	if (argc) {
-		force_assume = argc > 1 && !strcmp(argv[1], "-p");
+		int flags = PARSE_OPT_KEEP_DASHDASH;
+
+		if (push_assumed)
+			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
+
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
-				     git_stash_push_usage,
-				     PARSE_OPT_KEEP_DASHDASH);
+				     git_stash_push_usage, flags);
+		force_assume |= patch_mode;
 	}
 
 	if (argc) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index d24559a328d..295cb508a35 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1177,11 +1177,11 @@ test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	test_path_is_file bar
 '
 
-test_expect_success 'stash -p <pathspec> stash and restores the file' '
+test_expect_success 'stash --patch <pathspec> stash and restores the file' '
 	cat file >expect-file &&
 	echo changed-file >file &&
 	echo changed-other-file >other-file &&
-	echo a | git stash -p file &&
+	echo a | git stash -m "stash bar" --patch file &&
 	test_cmp expect-file file &&
 	echo changed-other-file >expect &&
 	test_cmp expect other-file &&
-- 
2.49.0.897.gfad3eb7d210

