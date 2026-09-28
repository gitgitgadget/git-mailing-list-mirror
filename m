Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C937AA9C
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621702; cv=none; b=ibIKO7155pLmApwAcg67xJM27C+D/k5hsMfxNmoyAzr1jqdGEHh3fgwxBdY+8TeJP/j9pmxvc9876E6lSJ9A9QVihBkmzD2c+Wvj24dXGUMV5xKXo/3XKNmr+F/3nC7nlHX5zSAErB/XWOjxvyAy2EdQpOCCfTG1xP81IUbRHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621702; c=relaxed/simple;
	bh=5oSk74BrZ9tFXQudVU/cRHie2RSRcGSZ2IvH5E5Wk8Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dWFOAOz7nK+YkBHDMUN5T/MLYRuDo+whIv3W2zwOuhfnA/4e1rqn0b4Jd8NrnZC+blW5qUb9pMEsfZQilfSpzo6qDhNzk7KfvL3CdfiOYc49Vds6lwH+8YyCuhkCqDgCQrEpLA5cZ7kCpSWCBee31SAk5CqC3LH5p46wfUWSkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gulYU94d; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gulYU94d"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so42041491cf.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621696; x=1791226496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kHuKKJ5plCmQLj22kaLgJJ/TFqxIvDZbNJBOhfn5I+I=;
        b=gulYU94dae2YJydLrLstkAvGT/ssj7JF928YIJl98sNFrUT77XJEvsdsmnbhfprwj9
         2ON8IyjJyPc52oyguOBm8mHo1cQGm55LBMSHFXbjfN75WkSBT+WdTX/Zqko7dpdeIl+a
         5vjrJZhDj+4/rae0WOPuZXK+HA3Q25ZCDwsDPfJQvu8CGH/jwOMqi1W1i0K2R//taBjA
         LpVjuq7Dmlr7MML4MR8he6kZF0FfAw/rP7QEzuLmZUCQR+LZOT6nPCnFa39W6+AZS++t
         NqcnmJVh8kpQsHDNRjbZF+M3TQMN1K17SzneYnU9p6y4En/kRN3n04uYgkA6NrJeBnlg
         Ya6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621696; x=1791226496;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHuKKJ5plCmQLj22kaLgJJ/TFqxIvDZbNJBOhfn5I+I=;
        b=DcJ1+xRiADOJsueXt7taapNEUH12bgUzt7BI/CKeNIheN4Q8TCbVGDELgBbLmvdXZ4
         jHmUpudtz/Jwr+h+/NaqXh14zCHjvQjEKuBTDYO7R/LJ6OWZ1AA81DrmfMZcvTNvySMh
         lGDlf+E7RNL4Za7v0s9YwpiO1wcuW4MCS3n9tcF6G0ra0LX1lQmszoIbZTdwsnTcK9nC
         O5RgVDkTdP1eQOoYk3X0MCsCbRNlUqVmaxYLqDTOP9wwKe7Zatb/cZrmKamq4i9la+Wa
         3/XTc00jP+Zv9J2qF3eIBkGoz/wQkreEMzBT2xHLcZSyx4je4SZ6cNCrnY3SvVkdUPlM
         uT1Q==
X-Gm-Message-State: AFuF++k+T/O1lXkXPh9MYZBOvNYZZvuU6UsX2bJqtFuiLaU030kPzEYx
	HADtVLO2a63upGb7WV7Y+nEyL1wmXja0B3EifagWFxcYx5xhjsNeW0wO4TMC3Q==
X-Gm-Gg: AYBFou21cSt/99c6vDfKY+8Cu6OfGuWAc/ULJWVQeSVCXku3ZZyPL4hn5/dT6z+zJ9L
	7fhJKfKM5oVNAV8/v6iymUAtFZC0/ImHLlWxIc5nUq71JjOV5aNA5Z93142RD3NP4ZeBs0M25Jl
	LvG47+kcgstOBJpNagKyfGZ8J6TUYy73Gh7zqSS47A8qXT2jontxFxd3pbONQ65INYNgOE91TP9
	neDYp58BHvQU2+ZVjyDJhEh7TJzXfAN/zsauKOGwlzSQwm+krgJR8B67/l55IZlLt4AuJcGTetI
	FhcBtoVY2bllypZWM+8pN+S7/sgzVNMqLboitDSvgeB1c2uevRbkUX5WWjqDiMKNP80oe8UHFJJ
	qaPikKDy4V4O6irIhcUh2wTlnVSklMNKG7h6/GUdLhUFQJqkc6+OOfUqWvGp+tHUEBen48Ya/LR
	mfAIlVvWeDPQXxfxeHer2FC3smwK23QCX17POBh8dy++3mJ/PYvIAMWLlrAcGe4orStPoxmUFfq
	jk=
X-Received: by 2002:ac8:610d:0:b0:530:b2e4:4e26 with SMTP id d75a77b69052e-5330b6ba2edmr248691241cf.51.1790621696497;
        Mon, 28 Sep 2026 11:54:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.213.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322388d06sm68974241cf.16.2026.09.28.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:54:56 -0700 (PDT)
Message-Id: <bffa8fb0309b3698bebaa9b4d4763acdea52a7a2.1790621693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 18:54:53 +0000
Subject: [PATCH v2 2/2] ci: point test failures and fixed known breakages at
 their file and line
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A test failure or a fixed known breakage gets an annotation that names
the test but carries no file or line, so there is nothing to click
through to from the GitHub UI.

Find the line a test is defined on by searching the script for its
description as a fixed string, using the first match. A description
can contain characters like `[` or `*` that a regex search would
misread, so match it literally. Fall back to line 1 when the
description is not found verbatim, which happens when a test builds
its description at runtime instead of writing it out literally.

A GitHub annotation is a single line, and a test description is always
one line too, so only a `%` or a stray carriage return in it needs
percent-encoding to keep the annotation intact. Escape `%` first, or a
carriage return's own encoding would be mangled by a `%` substitution
that ran after it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/test-lib-github-workflow-markup.sh | 41 ++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 0d54496358..67c5c3461c 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -31,6 +31,21 @@ start_test_output () {
 	github_markup_script_name=${0##*/}
 }
 
+github_escape_message_ () {
+	# A test description is always one line, so only % and CR need
+	# escaping here. Escape % first, or CR's own %-encoding gets mangled.
+	sed -e 's/%/%25/g' -e 's/\r/%0D/g'
+}
+
+find_test_case_line_ () {
+	# A description can contain characters like [ or * that would
+	# corrupt a regex search, so match it literally and take the first
+	# hit; -- keeps a description starting with "-" from being read as
+	# an option.
+	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
+	head -n 1 | cut -d: -f1
+}
+
 github_annotation_ () {
 	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
 }
@@ -40,21 +55,31 @@ github_annotation_ () {
 finalize_test_case_output () {
 	test_case_result=$1
 	shift
+
+	case "$test_case_result" in
+	ok|broken)
+		# Exit without printing the "ok" or "broken" tests
+		return
+		;;
+	esac
+
+	test_case_line=$(find_test_case_line_ "$1")
+	test_case_description=$(printf '%s' "$1" | github_escape_message_)
+
 	case "$test_case_result" in
 	failure)
-		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"failed: $this_test.$test_count $test_case_description"
 		;;
 	fixed)
-		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
-		;;
-	ok|broken)
-		# Exit without printing the "ok" or ""broken" tests
-		return
+		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"fixed: $this_test.$test_count $test_case_description"
 		;;
 	esac
+
 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
-	test-tool >>$github_markup_output path-utils skip-n-bytes \
-		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+	test-tool path-utils skip-n-bytes \
+		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET >>$github_markup_output
 	echo >>$github_markup_output "::endgroup::"
 }
 
-- 
gitgitgadget
