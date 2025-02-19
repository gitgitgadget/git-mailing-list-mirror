Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B01B0F33
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997263; cv=none; b=AG3AsKIBO9bJFvSfbRd5PwcWtl+Z5EyfMX4dS0TRvjpDzCpRzGGAYEblTpVxHzrQ7j7m7qCvArguWKhMZVaAHBsRWdVP8mhlQvEZEiyKIImEGIV4pzxbdgxxZqv98iEyPU6cEtbSPvsrNR3jMzurN/ZpMa+p5vUuZFdpLeZhaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997263; c=relaxed/simple;
	bh=Kl9+JlM83/Y+MKfhmGWpxD0SORHwQIvvp0xORW7zAd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK8AEIn3P4F9A+Qis7vXRVwhmPN0apAjJx5hNu16l78xtye+m6EPQYDZPYxpBEwC6mqhaCg1AXf4Hnn8OFpzc9EZEF/xgMIHUusSaMlnV8I6RFLxqAs42628CrvB7Dgga0aMETKhppg3PEznbR0HZ1z7qoQnMqGiI90YhxNPWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh+xUUoa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh+xUUoa"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22100006bc8so2997825ad.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997262; x=1740602062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLTlhuIq2yKCmU6R/jacEdYsxNWO4n5ZmA9gOb0FCAk=;
        b=Fh+xUUoak856aZwZmtF9g3ed5EESd/JgZmQCf7DuRZXQj30YaihCRNFB7cGUxxNUvb
         6lKTiUOX8MlhWbnGDj8xec3FFVPmZRpNMV+oS4Z7fUMmcD7V2sqkkPAdGkS2ksAGMDj0
         G9liAH9hUqmyIu9aEXzxzXuXkGRvuEZTt3QrdAU1igZ06aIxEO3MTl2Lq3rosKN7oeFB
         q5LLWY7PRRipg3jraEo94uCLolcaRjvccabDZvK8q4ULB3P1M1Jtw1zqhFjemrIES/ts
         SNNOjbzEpj3EdG9J+AZh4YmbI0CCA+p+jes7+AkHZv0QLQcP3oaz1mAJ9zj+qgWqPEYZ
         6edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997262; x=1740602062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLTlhuIq2yKCmU6R/jacEdYsxNWO4n5ZmA9gOb0FCAk=;
        b=vZaaAkGhsGjEOFkbOAz0kzeQX3FPP/ZWBkjW9pzrSDQ707gxYTIF0M1J/mLesl2nAn
         bTFd6kCWZQrwFgm1gvoOZgsJsE35X7n7pUER6+3cb7uz7n3ffad4oaqzR7kB/WnxdKvx
         wuJDBuUYfyy9Ullf0vVvzjzgsIQE5fS3O9Aqfyd2l6yBrc+Jeb5icKsWgyGXjI1gKMjl
         br2cBK9gSANpL6897A18yqQTDVINdsY8pXW7N/wuW71tO7zRqJCFXDVF5W5Ii+gaJxEb
         QW2/djp0ThUg8auKuuv6IROon6vQsD3e0anUbCl6zv10hFISsV1xbfB7q87Dr6lfV0M2
         pw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsKxkeY348S7VSqdM2EChZdA5xWn7tvAsVPkfrVFXVZ+AIXqf4nDgdnUcJkZll+RRi0Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+S6kHgwePdlOjCcJAQNSCKSCUVnrugpynpol568Aye7hB5LD
	l1ozWnlZN49E3jdLfxp4toh/6QGKIv8ppb2vZlPenxkXeH5eXq2S
X-Gm-Gg: ASbGncsJJ7J0Z31zESKFCRs5pDiXqq6s8hhSm5Yc5+JBZ6BuGG5pC3GnpQOL69boe9R
	HGmILOCrPol37nrxilOH4fDX6c/KsXVmSrkN85/fR2hV9U9pfcZWpCglmMN0yeL2KlQjyeMQWpZ
	gX5d4AAzs6upTfEt+sxV5CU1tYHhbLwNFGQj71ckxD/yk9BC04gWXen7Zf+BuOxBGajC92crIi0
	jJqq4N2gmeq2XlzHJXRBaVyUwQPKpp0M/xsLUaDa2KHU8wLCwI1d3m81vV2yVwncd7icCCC0SwQ
	SxlwyulWh9J3UcNAZdXWZN7mD/o7GMFKXYPt+H0x
X-Google-Smtp-Source: AGHT+IFTr1EK5YOKbRtU4h963h9N50pdQm3kDstyuJecg5IgfEaKygtTZHdZSBxb/2L25I1+652AbQ==
X-Received: by 2002:a17:902:d58b:b0:21f:f02:4176 with SMTP id d9443c01a7336-221040b136emr331403935ad.33.1739997261660;
        Wed, 19 Feb 2025 12:34:21 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:21 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 08/12] builtin/pack-refs: stop using `the_repository`
Date: Thu, 20 Feb 2025 02:02:56 +0530
Message-ID: <20250219203349.787173-9-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
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
the options help and exit, without having to consult much of the
configuration file.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/pack-refs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index bd09366738..200a5516b1 100644
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
@@ -43,7 +41,7 @@ int cmd_pack_refs(int argc,
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
 
@@ -53,7 +51,7 @@ int cmd_pack_refs(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
+	ret = refs_pack_refs(get_main_ref_store(repo), &pack_refs_opts);
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
-- 
2.48.1

