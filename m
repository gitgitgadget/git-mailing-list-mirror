Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4B18B484
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610080; cv=none; b=DhsOEwqWEKcBQJvS/7RV4dnc9b1UBuBmxCYbPRRo7UkDtsJD5KtOWqR6233UuVB+0U0q7HoDtbD+63jLjfMBIhwknaC3Br8i3ndZjHv+y2lLV7kArbhXAPhf1T/VQLbnFSenO383zl2pFnMCMsMqovZXRznq+ct+rY5WDbpi6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610080; c=relaxed/simple;
	bh=rwQJ2RxNOv/6OfCj2ZTJINgWn9AAMf8V5w7BAfVRsDU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=a401I/kTajdRZXxvh3uBfuc5R5o9vSwWOt79zQ3T+LTHwA7urJXH2ilUCeR+XM+JMTwhOXYOwDkWqqNQVQl1yegMvpoi5a9Ep40fkGTievxMW8LCszLFxniDPx6gQzobY380Ksf3m2z04RFIbVkzUfE4iPqWGvId3MNXKKsgleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVkF0ADX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVkF0ADX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso708364f8f.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731610076; x=1732214876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SPnnRwu94ou3RKwO2/BlRtoScw5VQMZjZLUishqOeAY=;
        b=iVkF0ADXRznDx5M8inH2FfKeAG1Uz+SaOjU4aKd0xWhn/B21OzJzrI+8DCrD3FNF5q
         bdyLqR+VFRARmZtm0q22A6tsoFvjpBO+1puRwMaTRilNK3pLRHsdqXgV4M7hQZQARA1d
         MbF2m4xRBW7UBuqmrgj6goq3S+VezSOeklrWmR9ezmaWE5/d/wsn1xVSsfsLdWopERsw
         FPAEtMSnq9Q1+VRKO4x6OulMRLNlkf31xK7ExBLAmq4961ObRD7Zqp8u7MNS2u9ipJt3
         +LGPGrV+Q1yr/S6TieZRi4lgoD+7NYOOnjzjTgz7Mnj8vU+5ZYbDZPm1cNZXFX8RLJdi
         5B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731610076; x=1732214876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPnnRwu94ou3RKwO2/BlRtoScw5VQMZjZLUishqOeAY=;
        b=lcu9M4CXU9KaF9lXpz5ZxGr+eIZSNXCo+m3oRhYgxFlQUJhotqoB6KO8diKg0SEeDE
         NGb9hhjCD1SaI2Mv+IFS0mI5L5T70XGh145d5NY9e1KHIhYKldROpz8C32wIE3TsHluQ
         induw+O1NN4RYQmapAEwgKioxR0orOpchBj/RneT878ninKumNhLipBcJxbhc67Af1t8
         sCVfuE18O9G77fkKeHBnQ6iUZaDYoPhs+k1qCd/zzuwS5m1Xf1DWsSSoNyr53bKeHAUq
         FW5uh54fxWRv1poO7e/6ib1TPqiwTVY0+eb3CiscHoDBsDl4kzzgxCv0LU8nT1//W4Wk
         q+sA==
X-Gm-Message-State: AOJu0YySq8hkJoIRqbKtpXmbt2Vke7c8XxotgO40VVSjI74W5xadFVwy
	cQwWeDcz8ok6XSbx/zUGGYHE8GMoJMuYBgLrlwHNTYWmjVdU0zgZNukMmw==
X-Google-Smtp-Source: AGHT+IHZW33uDV8/bEaWf9tUVrFRyWhCb9tdcWoDhqEiEgcogBVfxe7Ds1Rwzg4nirNh096rFbZaEg==
X-Received: by 2002:a05:6000:2588:b0:37d:492c:4f54 with SMTP id ffacd0b85a97d-381f186705cmr20456358f8f.3.1731610075986;
        Thu, 14 Nov 2024 10:47:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae3128bsm2130164f8f.102.2024.11.14.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:47:55 -0800 (PST)
Message-Id: <pull.1824.git.1731610074707.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Nov 2024 18:47:54 +0000
Subject: [PATCH] fast-import: avoid making replace refs point to themselves
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

If someone replaces a commit with a modified version, then builds on
that commit, and then later decides to rewrite history in a format like

    git fast-export --all | CMD_TO_TWEAK_THE_STREAM | git fast-import

and CMD_TO_TWEAK_THE_STREAM undoes the modifications that the
replacement did, then at the end you'd get a replace ref that points to
itself.  For example:

    $ git show-ref | grep replace
    fb92ebc654641b310e7d0360d0a5a49316fd7264 refs/replace/fb92ebc654641b310e7d0360d0a5a49316fd7264

Most git commands that you try to run in such a repository with a
self-pointing replace object will result in an error:

    $ git log
    fatal: replace depth too high for object fb92ebc654641b310e7d0360d0a5a49316fd7264

Avoid such problems by deleting replace refs that will simply end up
pointing to themselves at the end of our writing.  Warn the users when
we do so, unless they specify --quiet.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    fast-import: avoid making replace refs point to themselves

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1824%2Fnewren%2Ffast-import-self-pointing-replace-ref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1824/newren/fast-import-self-pointing-replace-ref-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1824

 builtin/fast-import.c  | 16 +++++++++++++++-
 t/t9300-fast-import.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f141..51c8228cb7b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -179,6 +179,7 @@ static unsigned long branch_load_count;
 static int failure;
 static FILE *pack_edges;
 static unsigned int show_stats = 1;
+static unsigned int quiet;
 static int global_argc;
 static const char **global_argv;
 static const char *global_prefix;
@@ -1602,7 +1603,19 @@ static int update_branch(struct branch *b)
 	struct ref_transaction *transaction;
 	struct object_id old_oid;
 	struct strbuf err = STRBUF_INIT;
-
+	static const char *replace_prefix = "refs/replace/";
+
+	if (starts_with(b->name, replace_prefix) &&
+	    !strcmp(b->name + strlen(replace_prefix),
+		    oid_to_hex(&b->oid))) {
+		if (!quiet)
+			warning("Dropping %s since it would point to "
+				"itself (i.e. to %s)",
+				b->name, oid_to_hex(&b->oid));
+		refs_delete_ref(get_main_ref_store(the_repository),
+				NULL, b->name, NULL, 0);
+		return 0;
+	}
 	if (is_null_oid(&b->oid)) {
 		if (b->delete)
 			refs_delete_ref(get_main_ref_store(the_repository),
@@ -3388,6 +3401,7 @@ static int parse_one_option(const char *option)
 		option_export_pack_edges(option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
+		quiet = 1;
 	} else if (!strcmp(option, "stats")) {
 		show_stats = 1;
 	} else if (!strcmp(option, "allow-unsafe-features")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6224f54d4d2..425a261c161 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3692,6 +3692,34 @@ test_expect_success ICONV 'X: handling encoding' '
 	git log -1 --format=%B encoding | grep $(printf "\317\200")
 '
 
+test_expect_success 'X: replace ref that becomes useless is removed' '
+	git init -qb main testrepo &&
+	cd testrepo &&
+	(
+		test_commit test &&
+
+		test_commit msg somename content &&
+
+		git mv somename othername &&
+		NEW_TREE=$(git write-tree) &&
+		MSG="$(git log -1 --format=%B HEAD)" &&
+		NEW_COMMIT=$(git commit-tree -p HEAD^1 -m "$MSG" $NEW_TREE) &&
+		git replace main $NEW_COMMIT &&
+
+		echo more >>othername &&
+		git add othername &&
+		git commit -qm more &&
+
+		git fast-export --all >tmp &&
+		sed -e s/othername/somename/ tmp >tmp2 &&
+		git fast-import --force <tmp2 2>msgs &&
+
+		grep "Dropping.*since it would point to itself" msgs &&
+		git show-ref >refs &&
+		! grep refs/replace refs
+	)
+'
+
 ###
 ### series Y (submodules and hash algorithms)
 ###

base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
-- 
gitgitgadget
