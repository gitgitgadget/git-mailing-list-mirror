Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F203C8700
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776346; cv=none; b=OPSlbyUIr4sXaFRLA83PYBqWkQ36JsTuzJ/PQA9hEZkOssda54Lo51tP/6tq051xSqRdNhqIi7+2Ceaw25Yke6Z30YxK+PVaro0kgTO+AUdk7kKKkClV3B1SYBHneiZJ655iuntgcf37Fr6/vx8gScoNz13GkGg4JQqGPGiMtds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776346; c=relaxed/simple;
	bh=9/7ACeqKJCHLTsPkJ93Is1A6BKLdVu6JL5S5T3l4FUw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=CT4bpQbNzsHQcOXaawVwtc9s9ZfSNAel3Q4A0rOD8je/n7RH64gmUEPpjcP5VwQkpOpm+whIsIUq0gaJagVQ/wEZWeOuYFhBB21VtnU4DNJRYb5lUeHoDEoZG1tJyptwBNsxXcIKIJ6KvLll3z701mWtbXeGSAkwV6bheeFeTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=N34ZzmmK; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="N34ZzmmK"
Received: from [10.0.2.15] ([195.99.11.174])
	by smtp with ESMTPA
	id iXf4wETiq9RfhiXf5wyDbG; Sat, 11 Jul 2026 14:22:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1783776152; bh=zkkreX1R1r7RpAhEeWf4H8Qq2goecDVmM8lkuENEOm0=;
	h=Date:From:Subject:To:Cc;
	b=N34ZzmmKBCl3PX/Gh7lI88M9SdrPmfC6rPRI4uEKJsigHbPc0NiQ7EPPcOLTGVQnP
	 W6TfTA9gd4Q4gFYAo8NQJQ6QL4KIsCR2CAKt11qVM0NSQVtMDgYRCAE0c2LbnDIhAF
	 ye4HFD0iGi6MPZkF0y0m4uXeIUao6pXvVDRUs9gC0R4SG4hXCErR38IZUzXJeTQAr4
	 Mh5EQuupUFJFwMZ3l+WSl686R7PM0AQgTeHH/uUwakalKSlEqPXDt+T8Jhye8nBmJd
	 gErqS7VletTBFNE9EgVIifeCovTYy6CFxu9dHPgmsZDG0argUaj+DFUA0luBQYbonI
	 PEFTdD2AhBmCg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=S5R6w5sP c=1 sm=1 tr=0 ts=6a524398
 a=rWEfxJwGD0TuYe46u5FB7A==:117 a=rWEfxJwGD0TuYe46u5FB7A==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Rw49F_r-eCXP_VC7CmgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <387a34d5-fdf5-4513-9aaf-4e73d9304c1d@ramsayjones.plus.com>
Date: Sat, 11 Jul 2026 14:22:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fixup! fetch: add fetch.submoduleErrors to make submodule
 fetch errors non-fatal
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO2MY7NnmxAm1cXK5EcssX1WfuKT9PGwTSyem0IjQUrTw67uJW4r2H+NW0UqYbwiKmRvOCg3let0ewJBUKWVvkk7z2z879gqYoqG58C5PqbjLhiXNjoI
 t+DfKn8QYumm4OsM1PvSlViV9UMJHVl2MiMtppEyNq/iA0ttMFUlNmaTRsDgSx6824mxh90sjDks8aP3NRyGMs/ltp+OjWmntI4=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

You have probably already noticed, but just in case, I had to fixup commit df9481e6d6
("fetch: add fetch.submoduleErrors to make submodule fetch errors non-fatal", 2026-07-10)
in order to get a clean test-suite run on the 'seen' branch (@a77a48500d) this afternoon.

[this is part of the 'pz/fetch-submodule-errors-config' branch].

Thanks.

ATB,
Ramsay Jones


 t/t5526-fetch-submodules.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 7ccc80048b..4bb6d483be 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1312,7 +1312,7 @@ test_expect_success 'fetch --recurse-submodules fails when submodule commit is u
 	create_err_env env_default &&
 	push_unreachable_commit env_default &&
 	test_must_fail git -C env_default/clone fetch --recurse-submodules 2>err &&
-	grep "Errors during submodule fetch" err
+	test_grep "Errors during submodule fetch" err
 '
 
 test_expect_success 'fetch.submoduleErrors=warn: unreachable submodule commit is non-fatal' '
@@ -1321,7 +1321,7 @@ test_expect_success 'fetch.submoduleErrors=warn: unreachable submodule commit is
 	push_unreachable_commit env_warn_cfg &&
 	git -C env_warn_cfg/clone -c fetch.submoduleErrors=warn \
 		fetch --recurse-submodules 2>err &&
-	grep "Errors during submodule fetch" err
+	test_grep "Errors during submodule fetch" err
 '
 
 test_expect_success '--submodule-errors=warn: unreachable submodule commit is non-fatal' '
@@ -1330,7 +1330,7 @@ test_expect_success '--submodule-errors=warn: unreachable submodule commit is no
 	push_unreachable_commit env_warn_cli &&
 	git -C env_warn_cli/clone fetch --recurse-submodules \
 		--submodule-errors=warn 2>err &&
-	grep "Errors during submodule fetch" err
+	test_grep "Errors during submodule fetch" err
 '
 
 test_expect_success '--submodule-errors=fail: unreachable submodule commit is fatal' '
@@ -1339,7 +1339,7 @@ test_expect_success '--submodule-errors=fail: unreachable submodule commit is fa
 	push_unreachable_commit env_fail_cli &&
 	test_must_fail git -C env_fail_cli/clone fetch --recurse-submodules \
 		--submodule-errors=fail 2>err &&
-	grep "Errors during submodule fetch" err
+	test_grep "Errors during submodule fetch" err
 '
 
 test_expect_success 'fetch.submoduleErrors=warn does not suppress successful fetch' '
@@ -1355,7 +1355,7 @@ test_expect_success 'fetch.submoduleErrors=warn does not suppress successful fet
 	git -C env_ok/super_work push &&
 	git -C env_ok/clone -c fetch.submoduleErrors=warn \
 		fetch --recurse-submodules 2>err &&
-	! grep "Errors during submodule fetch" err
+	test_grep ! "Errors during submodule fetch" err
 '
 
 test_expect_success 'failed submodule fetch is fatal even when its commits are present locally' '
@@ -1382,7 +1382,7 @@ test_expect_success 'failed submodule fetch is fatal even when its commits are p
 	git -C env_phase1/super_work push &&
 	git -C env_phase1/clone/sub remote set-url origin "$pwd/env_phase1/missing" &&
 	test_must_fail git -C env_phase1/clone fetch --recurse-submodules 2>err &&
-	grep "Errors during submodule fetch" err
+	test_grep "Errors during submodule fetch" err
 '
 
 test_expect_success '--submodule-errors=warn is honored by fetch --all' '
@@ -1395,7 +1395,7 @@ test_expect_success '--submodule-errors=warn is honored by fetch --all' '
 	git -C env_all/clone remote add second "$pwd/env_all/super_bare" &&
 	git -C env_all/clone fetch --all --recurse-submodules \
 		--submodule-errors=warn 2>err &&
-	grep "Errors during submodule fetch" err
+	test_grep "Errors during submodule fetch" err
 '
 
 test_expect_success 'fetch.submoduleErrors=warn: inaccessible submodule is non-fatal' '
@@ -1405,9 +1405,9 @@ test_expect_success 'fetch.submoduleErrors=warn: inaccessible submodule is non-f
 	rm -r env_access/clone/.git/modules/sub &&
 	git -C env_access/clone -c fetch.submoduleErrors=warn \
 		fetch --recurse-submodules 2>err &&
-	grep "Could not access submodule" err &&
+	test_grep "Could not access submodule" err &&
 	test_must_fail git -C env_access/clone fetch --recurse-submodules 2>err &&
-	grep "Could not access submodule" err
+	test_grep "Could not access submodule" err
 '
 
 test_done
-- 
2.55.0
