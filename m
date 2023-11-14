Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97066405D9
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g76iAcPa"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABD3E6
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:21 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7788ebea620so399002485a.3
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991660; x=1700596460; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHwgU1XJha+CAGvc+iVk56oHIF3XvEoRrTBB5JP6uCA=;
        b=g76iAcPaCwZZvaUrxQkPft6ZK1mevMFuTZtEf5H0pC8MC73QYSShJj1+p+jTtcVEIs
         97oSfGP18rZYJpqicTmB4GrMbCD+OzCRFezMxxMuEPGzVM8BC4NufUiBF/Yx+Y1SpzBK
         wObuDTiMuJNW5tv87T68ywcgl0b8jLBGXEkr5BZUNKdImwfbQTeHzy9Jz1Q1JWXxY92A
         eHX91KoEP8Z/JhvC+ckuVRCTS5sptJgJMNlkIk2shol4xA79froxowRP4QAWDg+2N13q
         uUzgHogHS26k+UAy8n66H4WTr+p26ZljS2gYfmvpKWalqSuujs46QeO/a6HtVutasEyO
         EqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991660; x=1700596460;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHwgU1XJha+CAGvc+iVk56oHIF3XvEoRrTBB5JP6uCA=;
        b=kfBfVzyVrWl0VpQD2TuklQg8DLSx+DnKxuVwoNzh+n0qH3zDoE52xKknHt4AFdxsUS
         JGRq0I2uFtavj39nZSjdkM3ZKTe6t9Jjn3aczpKwr93p/a+BkC8SruoFRXrHN5zGXpCE
         LBGZPRn1qfutx5YubkGoFHMSs5npr/v0TYPyXVLBAq9SoEczZlY0aAaf+b/f3GUOlmLP
         Cj0rWQDe7iywRAajqLzEnOdg76XYvg2WobIl90WD68q3PGOVDWIcNH4fSuXskZRDFk6p
         ozMt7nGQFUy9D8h/1wsWYQpMxRnZKdk+AXBrRq3XxN5l/qU18o6DZxJK6qo3v+RwzdR6
         C5sw==
X-Gm-Message-State: AOJu0YxKUNOydwC3yuWy4gUClBDJjQubIjg0krEdsgkuQSQUYuOHYzMq
	3VMGCgnsNaakz+hirD/wfSF9KD6nokc=
X-Google-Smtp-Source: AGHT+IF4FsxFqa73peR1IJ5nD5iL6yVeakckA/Y/h8mZRbcMoyD9ciEzyWMXL0/Px1Iaodis8XIS1w==
X-Received: by 2002:a05:620a:56a:b0:774:13e:71cd with SMTP id p10-20020a05620a056a00b00774013e71cdmr2577207qkp.56.1699991659946;
        Tue, 14 Nov 2023 11:54:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qq3-20020a05620a38c300b0076d08d5f93asm2898042qkn.60.2023.11.14.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:19 -0800 (PST)
Message-ID: <d51d073aa4aad22750edcc0214caf0dedd46df79.1699991639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:58 +0000
Subject: [PATCH v2 10/10] t/perf: add perf tests for for-each-ref
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add performance tests for 'for-each-ref'. The tests exercise different
combinations of filters/formats/options, as well as the overall performance
of 'git for-each-ref | git cat-file --batch-check' to demonstrate the
performance difference vs. 'git for-each-ref' with "%(*fieldname)" format
specifiers.

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
index 00000000000..fa7289c7522
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
+	test_for_each_ref "$1, --count=1" --count=1
+	test_for_each_ref "$1, --count=1, no sort" --no-sort --count=1
+	test_for_each_ref "$1, tags" refs/tags/
+	test_for_each_ref "$1, tags, no sort" --no-sort refs/tags/
+	test_for_each_ref "$1, tags, dereferenced" '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
+	test_for_each_ref "$1, tags, dereferenced, no sort" --no-sort '--format="%(refname) %(objectname) %(*objectname)"' refs/tags/
+
+	test_perf "for-each-ref ($1, tags) + cat-file --batch-check (dereferenced)" "
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
