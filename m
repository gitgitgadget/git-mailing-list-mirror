Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD62158DD9
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271807; cv=none; b=Wrgeiv14IF8x93UPkKUZGzPJpg+WkflIZtq/XxwUpq2+wGCKmmE+qK3laGOzeeqA/nBpjCEgaRMnBGggRXfzO/4VLTOtyTiT9b5NGfHGEXc1dojlqZUJqj9Cea3JfUG9DwlTEkUk3dHnIp7pwMMHE/IJULeEwaoylQpfbZLjtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271807; c=relaxed/simple;
	bh=U6cmTbxV4tCdvBmncexg+swheF19OVuQ+W1ra8DB9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu+mpSOD0kl8sSThg/l5pWbMcJJUI0HrEUesnl0ogWdFFokcHXLxasgEB4LIEyI4EQnNbPMCQUPoKlaH4APnhIn2af03VpM2cPfqujK/w1XxO4jRTgzzCynQMOFNclPU7iLics2xNhuqAV+vKRn0uB67Xfk0fI9s1H5psvDLKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUackK6z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUackK6z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso87431a91.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271805; x=1741876605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzH0GxcUvPZP2/UeP0dJFg2sRLWgXweOioqvjIfY+08=;
        b=BUackK6zuX+1eDVOLb/zmY4k+lNZRj7oTwNWa2VM8Of391R5SRJI/9aCVNyh4M1d4H
         gIJ10yrdCvpfbUGDUe5N/Uk+FlCDWp8lT78Z2qfaUADzjo1WyU1BLTClhlUEiNmjNjpe
         O2r2hBMZsifsnIpVIRb/lLiiPMlaMPDPz2tF1XZ7XRmc1fMirUiBY66KSlKtbzdi1u5I
         HbHY/46J+/MU6JGevkv2L/dWHHcixMq5gzL8JQprXCSqmTTxI0Xo42yQvpje/9l4C290
         1RltRrUIJY9lC0MTOXYKvaira8QvQlPXaNwzzBrrOJV5W9plfvBuPB4pYtQxV1U8HOUy
         F9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271805; x=1741876605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzH0GxcUvPZP2/UeP0dJFg2sRLWgXweOioqvjIfY+08=;
        b=CzDH5lpeVJ0v/R/xb9AGZNSH9OZRaP0HeANCCkjql5lcZWKnyc8qs69UHqiY4dKFVR
         zAnAwyGoca0rUgyKTBScsDDP7ZV6coAwwyrCdorvO6MPKMiYgN+NC2Q3ikpWaUE4cW9D
         8ZZTrPtZNPi7kGTABLh4R8Yshh1yRmkDPzqyRZJUnApgDAlIqb3n+SyLgmUBtzhhEvnk
         yJcfa6QOtX3aidL1MxRQ/GULO5t1rZhuxMxIkc92VrnsBU5dD6YGKbcbmg/sxOykpn8S
         GoRWJ2Psxf57k6R665dHAFYNu6PkBkno6rzUPQiDSgRMHvJRw76bknfLKcnitxk8JDgP
         3R4w==
X-Gm-Message-State: AOJu0Yx/rwVeYDFAos62Kw3lLflavn8AWHErefhQVkYCQuJq1fZqzWAC
	o34vtXWxN4AjENAQJfTQyXETfi3sUhW3VXsk12Z8yWjQxoQICMH+k4aFgRT/
X-Gm-Gg: ASbGnct7wXpUqPvBazB93ed3ONt/fNPJ8f27AFB3BELHWjudmr6E74d2MgjnVyxGRKK
	hlu/2JOPc7dy9eUNnp7mH+RASql4BvixMgUCAC0HyCqOPHOgRedNEXaGDTe0YPlFSj6WAmuCwz+
	3RcQtwvfzAUo8j/zDIzWr4aLDFNapZZ8o9wnHdIap1Kqa19dHjFRNkoNGJ8hP10zfcFP/IhILJa
	jGTbRwzsej7EMv3ULUBpZZKyq9/97Nidn/62317PQ7oKaNKlv9eBwqUvhabSoTHPHT8SYht+XiS
	bjSGzFWqBycDl7IAHUTVARILfluy5CqPICa5ALCkEUB5RF2y9AbcNyHsEYITo7jzgn2oGg==
X-Google-Smtp-Source: AGHT+IFgXlRR14MQAXps8Amim8qQ43onlzYUFwZMgaZ1w3f73rq3ufPn8TLGvnDXdcUlFIK6E3unnA==
X-Received: by 2002:a17:90b:52c3:b0:2ff:69d4:6fe2 with SMTP id 98e67ed59e1d1-2ff69d470c9mr3951262a91.16.1741271804933;
        Thu, 06 Mar 2025 06:36:44 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:44 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/8] builtin/verify-commit: stop using `the_repository`
Date: Thu,  6 Mar 2025 20:05:47 +0530
Message-ID: <20250306143629.1267358-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/verify-commit.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_commit()` function with `repo`
set to NULL and then early in the function, `parse_options()` call will
give the options help and exit.

Pass the repository available in the calling context to `verify_commit()`
to remove it's dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-commit.c  | 13 ++++++-------
 t/t7510-signed-commit.sh |  7 +++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 779b7988ca..5f749a30da 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -33,15 +32,15 @@ static int run_gpg_verify(struct commit *commit, unsigned flags)
 	return ret;
 }
 
-static int verify_commit(const char *name, unsigned flags)
+static int verify_commit(struct repository *repo, const char *name, unsigned flags)
 {
 	struct object_id oid;
 	struct object *obj;
 
-	if (repo_get_oid(the_repository, name, &oid))
+	if (repo_get_oid(repo, name, &oid))
 		return error("commit '%s' not found.", name);
 
-	obj = parse_object(the_repository, &oid);
+	obj = parse_object(repo, &oid);
 	if (!obj)
 		return error("%s: unable to read file.", name);
 	if (obj->type != OBJ_COMMIT)
@@ -54,7 +53,7 @@ static int verify_commit(const char *name, unsigned flags)
 int cmd_verify_commit(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -64,7 +63,7 @@ int cmd_verify_commit(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
@@ -78,7 +77,7 @@ int cmd_verify_commit(int argc,
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
 	while (i < argc)
-		if (verify_commit(argv[i++], flags))
+		if (verify_commit(repo, argv[i++], flags))
 			had_error = 1;
 	return had_error;
 }
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 0d2dd29fe6..39677e859a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -8,6 +8,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
+test_expect_success GPG 'verify-commit does not crash with -h' '
+	test_expect_code 129 git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage &&
+	test_expect_code 129 nongit git verify-commit -h >usage &&
+	test_grep "[Uu]sage: git verify-commit " usage
+'
+
 test_expect_success GPG 'create signed commits' '
 	test_oid_cache <<-\EOF &&
 	header sha1:gpgsig
-- 
2.48.1

