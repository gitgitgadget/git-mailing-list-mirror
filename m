Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D163A7
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JENN9iY6"
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF9D71
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:14 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-407da05f05aso35771925e9.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320373; x=1699925173; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkfIof6FvEuCg2hKTgdnBW1DQ48Qas6AKWIbclb4Frc=;
        b=JENN9iY6+7ftCsyXiWTlTho6ujihX/V2Y4veZ50zyWE6lpf88P8TS6LfMH/q3BEVGB
         SWlw9v75rfNRHPqivsFm3BRf0oKx8vJPQG/3kBRh88mlxIXfCTKJbrKQmOjECUvs9GE4
         1BYVH81XTSmcFiNqRHJcOMwxeg6Gd7Csx4ZB+OR7oFEXRHYYzLAzvdn0VBX6pWF0oBZ2
         vxVVkrjGaomHDo/m8WSUgjjN/N/CyBOLFMdd26QjoiHLKOt9yKF+WOXth9Wxk728Gbrl
         HHlUJP4fMggbHZlYrwqCI1sc5N79C9L5S8LGX03FAHtZhIafugL+URVL7lEPZdsZgth1
         qVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320373; x=1699925173;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkfIof6FvEuCg2hKTgdnBW1DQ48Qas6AKWIbclb4Frc=;
        b=WbqNPXXYMqf1e8IEoJhjl1CLhUOQ6fOQyIMGu+9IBRd50FwdEvMR9kOQVc+OO5HVmL
         5bow4nZeMlYeQXhJvig6ESY/qL41WtTdfz/PVNNRgzwqvJFbhPQ9bae0qkVDGrefuCnV
         XVXrcax3RrXgJcYa0JVc+ULDOPEjwAkPGGYWxQH3ncOfC2QDpr7bwOniVJb4EpbQPheS
         cpGZaMBhGyuoXinZealHQvcX7g+LM3mzpviYE0JYuXjcI1OD+qqwLcRJCtRoZWOOWyjh
         i23PuGW4YsgnzhEFXfhtN8c05uX5D7+1QnLcRVwC/8n+86AbyEa/R3PiKnB333apxvU4
         qyjQ==
X-Gm-Message-State: AOJu0YyAToW6KnM7gS+WP4nASELg2r9WPkAi+leCQPskapBUxlKjWtgj
	ykkqO6RGkWEqfRtB6X+VylqwSnqLEoc=
X-Google-Smtp-Source: AGHT+IESNDPXSim0LlexRRmsJDIoAxAqkft3B/+aEg51KEP8v4MaTvsIwCg2cnvwfNDP7sUFTIMpxA==
X-Received: by 2002:a05:600c:3b91:b0:406:84cb:b014 with SMTP id n17-20020a05600c3b9100b0040684cbb014mr1045917wms.22.1699320372750;
        Mon, 06 Nov 2023 17:26:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b0040644e699a0sm13897591wmb.45.2023.11.06.17.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:11 -0800 (PST)
Message-ID: <a409d77305766b7e4d391837f393cc22f9adaeca.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:26:01 +0000
Subject: [PATCH 9/9] t/perf: add perf tests for for-each-ref
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add performance tests for 'for-each-ref'. The tests exercise different
combinations of filters/formats/options, as well as the overall performance
of 'git for-each-ref | git cat-file --batch-check' to demonstrate the
performance difference vs. 'git for-each-ref --full-deref'.

All tests are run against a repository with 40k loose refs - 10k commits,
each having a unique:

- branch
- custom ref (refs/custom/special_*)
- annotated tag pointing at the commit
- annotated tag pointing at the other annotated tag (i.e., a nested tag)

After those tests are finished, the refs are packed with 'pack-refs --all'
and the same tests are rerun.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p6300-for-each-ref.sh | 87 ++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 t/perf/p6300-for-each-ref.sh

diff --git a/t/perf/p6300-for-each-ref.sh b/t/perf/p6300-for-each-ref.sh
new file mode 100755
index 00000000000..172fd68a4e9
--- /dev/null
+++ b/t/perf/p6300-for-each-ref.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='performance of for-each-ref'
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+ref_count_per_type=10000
+test_iteration_count=10
+
+test_expect_success "setup" '
+	test_commit_bulk $(( 1 + $ref_count_per_type )) &&
+
+	# Create refs
+	test_seq $ref_count_per_type |
+		sed "s,.*,update refs/heads/branch_& HEAD~&\nupdate refs/custom/special_& HEAD~&," |
+		git update-ref --stdin &&
+
+	# Create annotated tags
+	for i in $(test_seq $ref_count_per_type)
+	do
+		# Base tags
+		echo "tag tag_$i" &&
+		echo "mark :$i" &&
+		echo "from HEAD~$i" &&
+		printf "tagger %s <%s> %s\n" \
+			"$GIT_COMMITTER_NAME" \
+			"$GIT_COMMITTER_EMAIL" \
+			"$GIT_COMMITTER_DATE" &&
+		echo "data <<EOF" &&
+		echo "tag $i" &&
+		echo "EOF" &&
+
+		# Nested tags
+		echo "tag nested_$i" &&
+		echo "from :$i" &&
+		printf "tagger %s <%s> %s\n" \
+			"$GIT_COMMITTER_NAME" \
+			"$GIT_COMMITTER_EMAIL" \
+			"$GIT_COMMITTER_DATE" &&
+		echo "data <<EOF" &&
+		echo "nested tag $i" &&
+		echo "EOF" || return 1
+	done | git fast-import
+'
+
+test_for_each_ref () {
+	title="for-each-ref"
+	if test $# -gt 0; then
+		title="$title ($1)"
+		shift
+	fi
+	args="$@"
+
+	test_perf "$title" "
+		for i in \$(test_seq $test_iteration_count); do
+			git for-each-ref $args >/dev/null
+		done
+	"
+}
+
+run_tests () {
+	test_for_each_ref "$1"
+	test_for_each_ref "$1, no sort" --no-sort
+	test_for_each_ref "$1, tags" refs/tags/
+	test_for_each_ref "$1, tags, no sort" --no-sort refs/tags/
+	test_for_each_ref "$1, tags, shallow deref" '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
+	test_for_each_ref "$1, tags, shallow deref, no sort" --no-sort '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
+	test_for_each_ref "$1, tags, full deref" --full-deref '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
+	test_for_each_ref "$1, tags, full deref, no sort" --no-sort --full-deref '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
+
+	test_perf "for-each-ref ($1, tags) + cat-file --batch-check (full deref)" "
+		for i in \$(test_seq $test_iteration_count); do
+			git for-each-ref --format='%(objectname)^{} %(refname) %(objectname)' refs/tags/ | \
+				git cat-file --batch-check='%(objectname) %(rest)' >/dev/null
+		done
+	"
+}
+
+run_tests "loose"
+
+test_expect_success 'pack refs' '
+	git pack-refs --all
+'
+run_tests "packed"
+
+test_done
-- 
gitgitgadget
