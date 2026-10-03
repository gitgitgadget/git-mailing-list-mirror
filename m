Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC421E9919
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791015126; cv=none; b=XWDur/fba5KfPaTxg9kwCuelVOuYob0KUtVnm7xT76b8LEIVPJa6aEOdte6CP9pAdnm2g9qEhcOlRY70RsDpJ3xKRq08GeUnZZMwp/rP+Y/vuPCs65uzm7GA/2H2unFHJh6RzGsE1OZ5ZbIL0P1NYO+ovHaSoC6YAH5Z1kgdwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791015126; c=relaxed/simple;
	bh=/k0RQODN+a7TRj2OIZCK2Xvt8Z5kXLaycIgLSAdaNZk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FJQSKYmJwD8wbO5vhxuk7G21QF2Xd8Qf4IBjV/z9LAw9Qc2VGI5RhUrVB3PNWskEmgLSiYL14cJIauexQUE7gZ+eRGpfhiJjJKzTFcxM+ChIbG5IP9ALloKwHgx4dS0si6r5TauHbfM0utCHEUITie7xVCnYRjwLUjuKXSdkql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCLwpLiJ; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCLwpLiJ"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so92170c88.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791015122; x=1791619922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OL3OJD8pGj6IcymzG4wkEWIL2aRo0qoxvJA1VOlKbR4=;
        b=rCLwpLiJFx/GdxQDrLv1dlLA/i7SW7K5p0zyM1BRxyOntdZWj3RXmK3DgH4GDqj9Mj
         wXq9WzgyutVJl2N20xMuX2DyPjKX3LhNm9A3GX+dBTt3dz1C8vti4PCtq8JmhXgH1Z5K
         4pNWRyd8L8YNGd4pEWvVggL6DI9AeT3eh66vfhaEzx+0jzaihyMfO5pTdU3NnyMGVeZR
         P2N6SeubBXkJLNtYTqZ5TXq789uKsGINSJtoYcqtoMZyCaBiPWucvzEmkvxRpadT/9NA
         eN2b4VBvDc61T2D3Qgj9oGDnBrZwd4XG/uu6SOitBiQMvEp0zwTqI0O1QXZ/0FAYQmT3
         R0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791015122; x=1791619922;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OL3OJD8pGj6IcymzG4wkEWIL2aRo0qoxvJA1VOlKbR4=;
        b=frtaFfPmk2aWkQcZPcqjZowpuVURezp4t+rZXpPntBeI7+DR0MSFW4sfCIc4531IzN
         lb9VrgzylSpk74/5xEoyCPvWBtEa5CH5EEGCJ+aQfppvEVIr90s7lI9OkdzNkPHBmOmI
         dviiVuK6gycK4CIsfTN51d5IxeC/uaETzmJ1uMcjE/JQtCAL8vtJ10Qrby+Z+BrMaqNd
         9OoH63BUBkzLKrudk6lPHCD4RNnJ6529L0NLdr4ccai0MdlCSWwFS0zqSc6Szb+BQ2kQ
         4HIPGOafdf3TQzTtiZWYzHvUCnyboOmXU7j/1K56oro04SFPrfHKde0o2iLC0u76yqgD
         S+iA==
X-Gm-Message-State: AFuF++mhArxx48Hn1d38T5I0VEqEdOclJhDSnSR7DbeJUmSsFLH/CXlv
	o0/dXPMm/9SMT2Yl6RvVm5mzzE1uSfoSaLzdlXIoJRQKI9Bf9yKTLFA9dxDQRQ==
X-Gm-Gg: AYBFou0Oh3bxBmUHnzHZY4kyBtdX9iQVe6Sil3yAe2fRifM+yUO7jJ6pk2MBSGVyM7s
	chb7rN8iUo5KM5NCgVh1KUUGHdfoEiEKIXvgZgCr6Mmrl9NccZWBTPq9e6C+hOTrfELZEEW7r7q
	lIAwTPKGwgKX82SfzvVkPYOKgQnYdENA4ZqyLrGozB11kaFiS5WrMe+28SA7FK/P32yG8ktWRuY
	U9v429tI/1QM74sdCd+0b6n1J5KsKLUUF4eFLPJlzeyOAvssYVrH4XMFTOL3D/dqxzxmnWhi3W1
	eI80i6ch9HPLdmbfj0dWDct2wdDuJUjkp6ChrELHY1JW8qd25omVXneGG7/j0dUVyaJvF5u+Wdo
	iHL880qi48tzZEtywww9ojl0G4HbXgUPS2ErdIwoQA/9hC7lXoeesVgWPK8jrPGGytAAGtfiDfa
	PyipOplFekESgbjAenMKk3okhKUsGpY2yzbYmV+OSHYOPfApXqmuMsdTuQOu3j63U0O5QnZ2NUH
	Bk=
X-Received: by 2002:a05:7022:130b:b0:14d:5a09:5cd0 with SMTP id a92af1059eb24-14f5cfbf92cmr6167357c88.42.1791015122313;
        Sat, 03 Oct 2026 01:12:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.187.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcd83fadsm4379932c88.11.2026.10.03.01.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 01:12:01 -0700 (PDT)
Message-Id: <46f93a9e16e27966391a1cedb02a156b26fbd77f.1791015117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Oct 2026 08:11:57 +0000
Subject: [PATCH v5 2/2] ci: point test failures and fixed known breakages at
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

When a test fails, GitHub shows an annotation naming it, for example:

    failed: t1060.17 partial clone of corrupted repository

but the location GitHub attaches to that annotation is the CI
workflow file itself, not the test script, so there is nothing
pointing at where the test actually lives.

Find the line a test is defined on by searching its script for the
test's own description as a fixed string, using the first match, and
attach that file and line to the annotation instead. Fall back to
line 1 when the description is not found verbatim, which happens when
a test builds its description at runtime instead of writing it out
literally.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/test-lib-github-workflow-markup.sh | 30 ++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 0d54496358..ac8c536231 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -31,6 +31,15 @@ start_test_output () {
 	github_markup_script_name=${0##*/}
 }
 
+find_test_case_line_ () {
+	# A description can contain characters like [ or * that would
+	# corrupt a regex search, so match it literally and take the first
+	# hit. The -- keeps a description starting with "-" from being read
+	# as an option.
+	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
+	head -n 1 | cut -d: -f1
+}
+
 github_annotation_ () {
 	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
 }
@@ -40,18 +49,27 @@ github_annotation_ () {
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
+
 	case "$test_case_result" in
 	failure)
-		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"failed: $this_test.$test_count $1"
 		;;
 	fixed)
-		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
-		;;
-	ok|broken)
-		# Exit without printing the "ok" or ""broken" tests
-		return
+		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"fixed: $this_test.$test_count $1"
 		;;
 	esac
+
 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
 	test-tool >>$github_markup_output path-utils skip-n-bytes \
 		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
-- 
gitgitgadget
