Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D78207E12
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299177; cv=none; b=ujhA8OjD01yvJEdZkbet0v1xNbXk750sRm9w8sAoTtU4O1r/qnM+1Hyo+fmS/uYoHbkwHPJx6eCxbBJc9J2y4UUv+478SYXUahkntTENQ6JpZzzUQ4G2z8F9R1m9HOnJych8IzVPkoPbUEXeEGbSRsxe1Hce1Yw5pii3iwySy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299177; c=relaxed/simple;
	bh=XTJrwl6lGzYH/UD6p2YmKN1G1LrAG9X5uWXZIigQmz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUsM/96yEMA5UZOrVpqFpwslyX10aWmCKmnwtoicR1EizcwGzkWnR6u6GVhAYkdFhPhBrNYdbvEsfxaE2s1p1UoOIH9BNLrrXCgrvc0H7JN6AyryQjEpOd8N0L5YvIAnfgESBuYHszS6T/knxUjZRLcqMPZX5ztsUA1/nRNhjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpooIJYf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpooIJYf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2235189adaeso93478355ad.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299174; x=1742903974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odxIt6J5cAejMWvEFPdbwTynWI7WHeWNfI/TInK4QPk=;
        b=TpooIJYfNFuQ6Jgsx88chL65rQ09bQzXYlV7M7/icSVfQscJRQoYtgBGwtREdlDhEl
         w6oQdy8obrbc82LL6pBnjyhZ2Z86CR5JfnBiGBxD5cm7dkWS46Y4pVNCNjwXzUq9jyT1
         Xpo4NVsVZFNXwVLthKQ4aSym+PRoeF8eEF5WlrM5zQFHa00mNJBnsIvOl6naF5GxemRk
         FDFKZX1dXPioYpiy1mHmssCdMSLzv4Qrna67+wZs3d1Y3nHVr9XLFe3QgCeYS5VQm4S9
         sEU6eknG76g4rI9Wf+JqrvFmT+VXrMSVz6zkscVPgHtzFxWOWOPQmJU4Y9sCJLbhPVIb
         Zrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299174; x=1742903974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odxIt6J5cAejMWvEFPdbwTynWI7WHeWNfI/TInK4QPk=;
        b=fXLHgRNOeYSIWVcy4E7zKYH1hArnPjFHDaVP6yMUNYlha6klyZHZXquAx8/0HadV/e
         HbvwqnNvCkC1pBjqcRHyMF9KgrUHn5CetANeGjFrLaTWUXZLHLnV22uaXBAta7LkZxlo
         ikVchJt32No7TYLLjm//YIW9XuAFvvUJT9pvLoN3npfNaYwx6LBH8srfSr7t24ui5pLJ
         R7MBRAmDMVSvS57lD1+pKbAwmduD3kIU+iFQStY6ar4c7zPlCQMyU47zlDtDLI4R37Q8
         ui+poDOsCVMl98hOyGhstUUrxiZSh+AA97ohVsuAy3F3C7mxdYsik0G5Lf0WYkrAkv4J
         jS6Q==
X-Gm-Message-State: AOJu0YxnANAral689mVOGWATA92beGI+hLOW0d8s7NYa/JoCbQPh2AR4
	UJLNNhnvco9oJsuGAd+VWfXPPYHzB95N7izNbreh6M7LhSCCkaNkp/fXGh/0
X-Gm-Gg: ASbGncuPrgcaH5Hm4du1VZh0uefysvsXye7rGuR2IgAZzh8zQChYGtSCT84STdduk7x
	4xxSIAFMPX3eKL06BT8vOU73xiauVDYjFwKCeELKtFt17Y4MF5teBPSQb+SQZXNOviUafezWx4Q
	ICId+BUQ7oRyoT+Ry6QQOIU6B0hemNWorYgJT2LhUijWn7qyx6r/C5/WINrVaRjD7uVB4b5wrI0
	TJ6X7buDQxOy0KWhYjESMP1CbamQnatQao54dfx3PBSdqDWmk82eaH5Ce19STJBeQ5l4vydjAQ/
	gaq159neZN0yb0THj8R1gmp0FNNPaHp1Zlx3gooyswDgzO4R4X98JGuvzAaUyOmPMKK3ZA==
X-Google-Smtp-Source: AGHT+IHujTAFKwPWxP8dKT4PXBWsMTN61/3CTLOtkg7ppFiXiWnfrWtRNQDHrlOTVRFiGlHolujZPw==
X-Received: by 2002:a17:902:c950:b0:223:fb95:b019 with SMTP id d9443c01a7336-2262cc4a926mr41601675ad.24.1742299174595;
        Tue, 18 Mar 2025 04:59:34 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bc012bsm92101605ad.205.2025.03.18.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:59:34 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/9] builtin/pack-refs: stop using `the_repository`
Date: Tue, 18 Mar 2025 17:28:57 +0530
Message-ID: <20250318115912.2978992-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/pack-refs.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_pack_refs()` function with `repo` set
to NULL and then early in the function, `parse_options()` call will give
the options help and exit.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/pack-refs.c        | 8 +++-----
 t/t0610-reftable-basics.sh | 7 +++++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 4fdd68880e..e47bae1c80 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
@@ -15,7 +13,7 @@ static char const * const pack_refs_usage[] = {
 int cmd_pack_refs(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
 	struct string_list included_refs = STRING_LIST_INIT_NODUP;
@@ -39,7 +37,7 @@ int cmd_pack_refs(int argc,
 			N_("references to exclude")),
 		OPT_END(),
 	};
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 
@@ -52,7 +50,7 @@ int cmd_pack_refs(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
+	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 4618ffc108..002a75dee8 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -14,6 +14,13 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 INVALID_OID=$(test_oid 001)
 
+test_expect_success 'pack-refs does not crash with -h' '
+	test_expect_code 129 git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage &&
+	test_expect_code 129 nongit git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage
+'
+
 test_expect_success 'init: creates basic reftable structures' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.48.1

