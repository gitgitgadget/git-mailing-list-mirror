Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181134D91C
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836307; cv=none; b=qlZwWkwofxh9J4KDpESix1ykGm9E8t2bhLHVSIyJNgQrUMrqk9NsTuV/8+3MUS3YeZoh8v8cVvn0FZYI8sztYyTb0F5gj1Pg/hWPU0ETWXKRVAeR5P7reksCITRVxd4XPig1Q8CWtGfUu/w449NJQbWJaS8KCMEV6AjQNa+UrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836307; c=relaxed/simple;
	bh=Cd1trX037lv1DFXMFWYDdR/1yXJUU7Sv2L1/i9XBjxE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=oFVzf98JpgxO6zcqVD5k1A1UoJfLVXbqT2NDxzNsxwkytyFLKahVFYlcgPMsQ0bljPFUfN+xw5jJNUgsa1NtYbinpoT0VkTN/XJ4O/oceG3dOd2WQYYgb9ry4AISY/7rH9nKDX6NgkslRlHOPn0vEW7Wb8EZjLKfwcKGeCfRrfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL+/fWZC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL+/fWZC"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506a7bbe9d0so34224401cf.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836303; x=1772441103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H+FJ0ba2V39VCziLYWAS/6lAbzoXYMnDQ4LGwLSFAFU=;
        b=aL+/fWZCoYrzyDx2uvloqhl8/YVEabMBs9mPCGzYyDd2iU41VNj7+j+k0XHeEwSQ4m
         w04PbC6J6hPP97ynBy05Q+a1Jc2ko1d0c5yHbISS6Pn7FT9QbHTrW9+wf6IVn8m5Z+uR
         niQNAzg9tMx8+A4xW1yRvGwcEU53T906tAP0nYoWOkDHEm1oMNiVVSNLnFg4aV7HS+jk
         BNK/BQw4LV7UBIM1m0QiD+sDnFDa0e5IWFSfhaQGS+HheiYHc0f1v/lqZtdWRH7hG2WW
         nyENGTGClcGz09wzzHaOHQzv9271dVEbTXVFO84/PZBwxX6s8ZjmOQEkSoFzatLUkNV+
         BfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836303; x=1772441103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+FJ0ba2V39VCziLYWAS/6lAbzoXYMnDQ4LGwLSFAFU=;
        b=cydTjzhziHSAdRNYLTAfNJRjiyeT1/5Cg1pJxe5ERCY3h0ow/wFBnICgMY4yTotu4W
         u26GiYHRMv7n5ws4Pvaj+NbqZdEius4K7jbyIVmrTjmK6x5AlxRlckQMXvEVTdFNH5uf
         MtFtiqcgkO/UjTJWjq67LvZsqvGK4/ssFPJ2rtTlG1bGQSBxjKWM32yYxXN0+mEWHF1s
         I7pfkX4rQ9A9fiAz2Hn7B2mb1O5bLL31WrcaDICophyvg28nCu/vBn/m5CgQZx0m2BKj
         MFE0YBjzD/ipSqZd1xek/D7QC8bEGbMfMXyTJBBbD32dTQODw3Q2h4HmFSS/2nHw3IWE
         Dbwg==
X-Gm-Message-State: AOJu0YxU691EZqmdf5SVz/dP2JQIGuSD9aYJ6/nPnjP7yUt0q1hLOzBq
	WhyiFgYFXocALG0KgmhV+t3wa1UBZU4W3NMYlQJkfCsS/WHIAWDd8V8QhdZweA==
X-Gm-Gg: AZuq6aIpKz+VekYetQh8gT5csd0CXBZnrbi7/2+O+cnrGHa5qyNyFhkyne/Wi3XNwmX
	2WdI8z6gRWnMxwUqKSO3ON0q+ni1UBvm2UsceAEdU1Hx4/zKG3TkEIzPrWgg9QlBM7VYpzFfJab
	lPWQuF58//MQejB9ZeBcXwGevJkoTCnGlhKR3p/ePF1LuDDgjshxQCoMKyEefmhfy4+nP/6SIzQ
	ytDMuxwENYFlJaEmEmve+wvY7AJVdT+GWFkp/P7kDALJHy+Ls0Vy1+BMUm6mGI4c+GAmfypBZ/t
	/oDV0w++rIYAhOx61ZGovuwpBjNclYfT0TVjDVEA6yFhNCeL1l7Ug0+Q7/uuj4P6Sqy/7FMpkUk
	oCU2xCyARGuxz3k+sc9lTEHtuyouSTulAloaUmgIk9ReYy33nohczkciLSYdE6QUzQ8HqPpax2G
	qBSU1nbimkCl88mGHSu2PHN9QkkRyRiaqOD8aq
X-Received: by 2002:a05:622a:446:b0:4f1:c66d:4c98 with SMTP id d75a77b69052e-5070bbaec81mr93228251cf.24.1771836303128;
        Mon, 23 Feb 2026 00:45:03 -0800 (PST)
Received: from [127.0.0.1] ([135.119.237.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6c9de8sm62013871cf.26.2026.02.23.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:45:02 -0800 (PST)
Message-Id: <pull.2052.git.1771836302101.gitgitgadget@gmail.com>
From: "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 08:45:02 +0000
Subject: [PATCH] cat-file: fix error and warning message formatting
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
Cc: Md Ferdous Alam <mdferdousalam1989@yahoo.com>,
    mdferdousalam <mdferdousalam1989@yahoo.com>

From: mdferdousalam <mdferdousalam1989@yahoo.com>

The CodingGuidelines state that error messages should not begin
with a capital letter and should not end with a full stop.  Fix
the die(), error() and warning() messages in builtin/cat-file.c
that violate these rules, and update the corresponding test
expectations in t1006 and t8007.

Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>
---
    cat-file: fix error and warning message formatting

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2052%2Fmdferdousalam%2Ffix-error-messages-cat-file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2052/mdferdousalam/fix-error-messages-cat-file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2052

 builtin/cat-file.c           | 8 ++++----
 t/t1006-cat-file.sh          | 6 +++---
 t/t8007-cat-file-textconv.sh | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index df8e87a81f..a8d564dd6a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -121,7 +121,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 
 	if (get_oid_with_context(the_repository, obj_name, get_oid_flags, &oid,
 				 &obj_context))
-		die("Not a valid object name %s", obj_name);
+		die("not a valid object name %s", obj_name);
 
 	if (!path)
 		path = obj_context.path;
@@ -182,7 +182,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	case 'p':
 		type = odb_read_object_info(the_repository->objects, &oid, NULL);
 		if (type < 0)
-			die("Not a valid object name %s", obj_name);
+			die("not a valid object name %s", obj_name);
 
 		/* custom pretty-print here */
 		if (type == OBJ_TREE) {
@@ -200,7 +200,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		buf = odb_read_object(the_repository->objects, &oid,
 				      &type, &size);
 		if (!buf)
-			die("Cannot read object %s", obj_name);
+			die("cannot read object %s", obj_name);
 
 		if (use_mailmap) {
 			size_t s = size;
@@ -910,7 +910,7 @@ static int batch_objects(struct batch_options *opt)
 			data.skip_object_info = 1;
 
 		if (repo_has_promisor_remote(the_repository))
-			warning("This repository uses promisor remotes. Some objects may not be loaded.");
+			warning("this repository uses promisor remotes; some objects may not be loaded");
 
 		disable_replace_refs();
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 0eee3bb878..0283c7400d 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -705,7 +705,7 @@ do
 		then
 			cat >expect <<-EOF
 			error: header for $bogus_long_oid too long, exceeds 32 bytes
-			fatal: Not a valid object name $bogus_long_oid
+			fatal: not a valid object name $bogus_long_oid
 			EOF
 		else
 			cat >expect <<-EOF
@@ -721,7 +721,7 @@ do
 
 	test_expect_success "cat-file $arg1 error on missing short OID" '
 		cat >expect.err <<-EOF &&
-		fatal: Not a valid object name $(test_oid deadbeef_short)
+		fatal: not a valid object name $(test_oid deadbeef_short)
 		EOF
 		test_must_fail git cat-file $arg1 $(test_oid deadbeef_short) >out 2>err.actual &&
 		test_must_be_empty out &&
@@ -732,7 +732,7 @@ do
 		if test "$arg1" = "-p"
 		then
 			cat >expect.err <<-EOF
-			fatal: Not a valid object name $(test_oid deadbeef)
+			fatal: not a valid object name $(test_oid deadbeef)
 			EOF
 		else
 			cat >expect.err <<-\EOF
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index c3735fb50d..3a69b03794 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup ' '
 
 test_expect_success 'usage: <bad rev>' '
 	cat >expect <<-\EOF &&
-	fatal: Not a valid object name HEAD2
+	fatal: not a valid object name HEAD2
 	EOF
 	test_must_fail git cat-file --textconv HEAD2 2>actual &&
 	test_cmp expect actual

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
