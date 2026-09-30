Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF383B3C19
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748590; cv=none; b=lh4Djrh54xbUfz9VRh8PyduIZahpoP6ZmtCcty/J25cr4jdSR2tN+oj6ym+RBhYm4PkM3Da6fkt1cCVV2Gnm0oVWQTYcOBdqvz3hOMEq+MPJ+spTv7tSmeFr4Yu8gw+ctKv2Yvbl6UOI/IqWl/A5nMduakqwrZARBxIPDlps+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748590; c=relaxed/simple;
	bh=p3n/f3GfxdYWpl5bPGWtmbx5UD0mVjPgumOVmH/4gP0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N1c51qm2X9RGRysjlog0Slg5x72uah9GOeahB3Y/rqAGOUrLmQsP59YiK/xDDNmTiD9Qybh2FLNs885Jbrg7PN4EIQ9MVx5EbMBOxy+InrJvXn+iKLIbPOvXAIUrPp8P/7iT2Br9b7+kRgujagt10Y+98Z7u/0Y0iPPIlw538TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCoOhduG; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCoOhduG"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34cde269e1bso158750eec.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 23:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790748588; x=1791353388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ThWQx691WHHNtQGf7exUbK+V4PS+zDjZYSmM6oxiobo=;
        b=KCoOhduGhROOMehgucw8Xo3dSzDdag6A8vb/lRXQZVXWA4HKSL0/9qmN8OwUAqr7ZG
         FXRd1yq5Px2nfUWqGtMeoArXRWHOCjqy0bFBlNgEWjpHS7Jh9JmjO4HDm/fTFzYBRAw2
         ts7ZPXCWOKyTlTyG+4m1dxuEhypkQTNDCuwEy8lMm+W7QG4MfJDUverL1Zgb+OxZewi1
         TVGv4xD/AH/dZV9Pi/BhPHsudgo3e7IVwYICp+o+9bPUFNxmUhJXrF+kSb4aLvbYdpZE
         LWsnv0gOauJerP0VSDupRMCwM3BEv83oAi9wkaStIIMCftKt1a6bbvx9brpnrrD0xKuD
         ky+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790748588; x=1791353388;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThWQx691WHHNtQGf7exUbK+V4PS+zDjZYSmM6oxiobo=;
        b=lbVDpYQj+SyeWrcylSfpsW5jEXkzH5MDJGu4oDsz6jcuY23g5TDjPS8J9ovY/bYgmW
         cFmW6mOG4sYm86Y8ZiQhArtz5dn+3y0qn/JRczdOaQ4HbwGhbP+j1gkWz6M7QhkPqLBE
         oiqnZQmBwf6emMgcUYboRVh2IE2cnNasieEJ5TZI28ssrgZtMm3rGkrpRjftA/yIlQD0
         llnYVeWEU9VM0zOapMwQHhKJ3wS3U+QeeWA6ur5Cf01dzwTgSnMvugHxNc71Qea0cnFX
         Ra03hFjIgZQhqL4jWNXfZwDujlGMHham7Kjsdv6i22gMcCsR7Br17oxJ6hXvThVsKBsB
         7Naw==
X-Gm-Message-State: AFq9FYL3qWNV3ikFXKGIl4KqIl6STeR6sB0UIxuY9GJaDIMdTm0QVBFz
	bV5j3gMzPqLZ+Muyjn+ndwUrbRw9NZICMkNOFkzzp9SiRpDOeLquuAlTDOdvqQ==
X-Gm-Gg: AYBFou0AThli9OfMV5ScIUl3Iq6dYlXSP44g1cHUHKq06bUE0xnPlnhhx6fkTCzCOjF
	LT6dik+D8VOn2msqtVESmC3KX8dnTSuZHDNTK4HVSL+DZGEcShfi1jsZiGVmPxXnT2IgUiFzEHd
	ruaGYxSuXKuzg0U4e8HrA93j3byvsijcKDvyy3gUaDBc4Gbt/JIAjzhORrZX/QCeDJBCqW8ISUg
	IXBJsRzHiTJTWtBVg9IxSYbkdkr7DsYZb6ioabuvpXucMAsNzw7cNS2ctzEVGH6ZDOHoN2hJSBQ
	WLwpU7P+YxR4kKaAvDM2JIQ9oP+Ec5694dI9s5w30eG+wj+Qq+WfYL0gPZYw4LfF9b91o9uirUb
	mqb/w5ZWPrLCUyRULbHoCnjQLW42t/sD7YV8467E963Fm0+mpDVwfjqxkq3dzhgb6NKivgbZT6i
	yXIX3Jz3fpHt0oUcjIKbcBCFDeuwtJVXTV9u6/XlvGMHUk23VSUJrB+w70ohSOwBLoVIaZGFcbq
	l4=
X-Received: by 2002:a05:7300:ac8a:b0:33b:ef1f:14b9 with SMTP id 5a478bee46e88-34cdc0cebb2mr807765eec.15.1790748588155;
        Tue, 29 Sep 2026 23:09:48 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf50553f8sm2201410eec.14.2026.09.29.23.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:09:47 -0700 (PDT)
Message-Id: <750c3605128c268f331b1b9477ca0489ced75543.1790748583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 06:09:43 +0000
Subject: [PATCH v3 2/2] ci: point test failures and fixed known breakages at
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
 t/test-lib-github-workflow-markup.sh | 38 +++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 0d54496358..66d2ccca18 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -31,6 +31,22 @@ start_test_output () {
 	github_markup_script_name=${0##*/}
 }
 
+github_escape_message_ () {
+	# A test description is always one line, so only % and CR need
+	# escaping here. Escape % first, or CR's own %-encoding gets mangled.
+	# \r is not a portable sed escape, so splice in the actual byte.
+	sed -e 's/%/%25/g' -e "s/$(printf '\r')/%0D/g"
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
@@ -40,18 +56,28 @@ github_annotation_ () {
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
 	test-tool >>$github_markup_output path-utils skip-n-bytes \
 		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
-- 
gitgitgadget
