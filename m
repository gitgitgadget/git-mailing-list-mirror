Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648D188713
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271804; cv=none; b=IERCbI27ytdjRcvVQwUccvzCqbXPceoiRv0KOA6vxxvLVpCxR3rMZTAQDWdIZXI81jjxI7UEAWIhjUcSLfSwshvOnjslKqtHCVWMrGCEQ6Tagic5rdk3GkfwmFMiOyebHVC7PWluxwVqBZWh1ODyd+h6NkW/Aw2TOTUF5FlSmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271804; c=relaxed/simple;
	bh=JAJbSWuFJgB3UDNULyyBg5saO01KET8wLRD6PmDumWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcFxU928IEi8xO/DzsotNYZWEXOY8uG7iLbjprY8Cjqirp3+Fq+S4pSVOl4zF1QYx6VGdZ8SJVenE4rFvgbvVqINxxkXEosIVJtg/XUOrbEjYeGX+0OqMsLk7jrW5IEDCcS37hFnyq58PuVk6DXaBKDAEDI9ODHgt6idMO1E2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUt/QQsZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUt/QQsZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1200275a91.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271802; x=1741876602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS369oUw4eRuRr2YFC8W8hxX9W24rD8Bi7rbrICFRVs=;
        b=PUt/QQsZyIHuSYDiin7Iinv1AOJJ8rlcU+vDrdWB2PFZY1yg4p8oTIURHLJLY0/o9w
         Ad1wzS81F9rDC+mytAEYFXjOlloODxoYg3ppQ9XE2zKr41/t1ttTTzcy9djyOwVi64+T
         QSJC3nEJGMSh5YPznWb7QmA7pn/JID87+NVAmQBWYe6TP8vqiNNVrBtkOtVYpbJcFzpF
         +4ep6+7SPaQssHoUrqGdxG8gWjBcW7uw40JF7qTARhEjY7igi/IdMpxBNkQDfN8VfYXd
         HFeHBV4m8dSV4z4rYOgty6uoHjwp/rlAb5ZkLTwgU9xzdnX3OxfDREGeaVNkYx5CQJq5
         uxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271802; x=1741876602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS369oUw4eRuRr2YFC8W8hxX9W24rD8Bi7rbrICFRVs=;
        b=Pwuazv7nPikDEdEikukJp0PTc6MjMbE+TPw+gPBU3BL92OpCqRuJ8aNSvmx8LM/91h
         kJ+g/QaCln+AxUwYvPTp8BIuDbTdJe6BSOJvp3DeoD2epK8UTXjkWa6azedT044m7ys8
         9KBYXBcsHJGiBlYBNg88zczAeafK7Y6MRR3fQ5iKYaoHvZPNAS0IVWc6l8k/j2HnheiZ
         aA2Xfa2PxnIxLt4T/JyZyXia3NT0qcHpcOpaFX93BNy0/vK4Q8tYItO5LT4O2cSJtfoT
         H4ITFtC4v/mIqM6YOBT7/bwJjORT9e4bsddAUZ79qirMYuo1lEHbhVg/7BwVCXSkphhs
         4fOg==
X-Gm-Message-State: AOJu0Yxb8aUs1VH2Fo0udqv1pMjz/cop5NrPzUYNV1ZgXnizx5w/P7qh
	bqKJoJ8Y/UCI0FfdmD5pON8TOpTCuyOoweLney0XRVad5hDmQGFHYG24FXma
X-Gm-Gg: ASbGncvqKps1dAy8zk2EAOhCqhEwOcqEDX1Oq4RlPzMzNJfPEGmF/ddFmYd6v2xVO5+
	sWBS2olHu397uJA7zIfU5qXYAb6VRbQQjCl6T5Cq9B0H3668X9M9dEwQIxMXDoFC3vdfHb6w+IL
	kH+mkIl8Q04NKXxDQxScSiNJ2g3JuI2PfEoH8Wxp/IbNylB7qDQcTsC97q4/NDHiEWY/pWJPn8s
	CLbCHE1QTcWG6+hMj8/RmX3KVikr9QQVrPfIrdOiB3BqDHMeJ1W84TbuBV/Vc2J7/FuiIGQlsuZ
	tghBbAFNZSoxqDbP4iOIHgxkpLBpac4y7MbIPWpz3ICvmnWhg1UhVPMkTrMl3moWFevU9Q==
X-Google-Smtp-Source: AGHT+IEKyIl5AEDk12ZQ3fGUY30IuNDwxeeVWjA2+9skiv1crgIcnxC5MsI+nruCUIagZ+PpjVO7ig==
X-Received: by 2002:a17:90b:270d:b0:2fe:9e6c:add9 with SMTP id 98e67ed59e1d1-2ff4975343amr13214303a91.18.1741271801585;
        Thu, 06 Mar 2025 06:36:41 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:41 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/8] builtin/verify-tag: stop using `the_repository`
Date: Thu,  6 Mar 2025 20:05:46 +0530
Message-ID: <20250306143629.1267358-3-usmanakinyemi202@gmail.com>
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
argument that gets passed in "builtin/verify-tag.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/verify-tag.c  | 7 +++----
 t/t7030-verify-tag.sh | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index f6b97048a5..ed1c40338f 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag.sh
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -23,7 +22,7 @@ static const char * const verify_tag_usage[] = {
 int cmd_verify_tag(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
@@ -35,7 +34,7 @@ int cmd_verify_tag(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
@@ -56,7 +55,7 @@ int cmd_verify_tag(int argc,
 		struct object_id oid;
 		const char *name = argv[i++];
 
-		if (repo_get_oid(the_repository, name, &oid)) {
+		if (repo_get_oid(repo, name, &oid)) {
 			had_error = !!error("tag '%s' not found.", name);
 			continue;
 		}
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 6f526c37c2..2c147072c1 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -7,6 +7,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
+test_expect_success GPG 'verify-tag does not crash with -h' '
+	test_expect_code 129 git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage &&
+	test_expect_code 129 nongit git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage
+'
+
 test_expect_success GPG 'create signed tags' '
 	echo 1 >file && git add file &&
 	test_tick && git commit -m initial &&
-- 
2.48.1

