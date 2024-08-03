Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B85E54C
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722695236; cv=none; b=nVjzuUPJzuwf0l85SaP022L/eJrwMA1VFAyVfV1eAGXkjSDrzTNohm8x6RbwFi7HPNe9gg5dpDEoDEQNixNeFrkmOQUGOPecaGA76tNC/0KoGiQ2lNi/oK8zh6wiJdjcA1mx5t6e7iByUzGS6UcgrntVcnE4i2YItBk49hrvTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722695236; c=relaxed/simple;
	bh=W4oUXpgZDr+kcuIgnOWlf3wKNp7F7rok897NLJ9Q31I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JL6sEv5LfFV+FfaI3JYMeOizTQ12NviqfKdBYcjBJTd6yHaR0+ZmyABL7lB5KoYoDNHGkV4SVBY9pyDeojmlE2RMkB5z3VlhE6AmhGTPyRbZPhs080C52IljQqwY6611588M/awwDzyS/t1ty8fKQTBWdAhq0fk4Qlzn1fluDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPBQjttC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPBQjttC"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280c55e488so24528185e9.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2024 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722695232; x=1723300032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biElDwp4TFuLZvMHwXkUK+uL2r7lhqxtJzDew2Lpgco=;
        b=KPBQjttCqxEUBo0mnOhuZd8g7XxL5lU1U77nSjNkIWmpBiz5g5Gh4qVsPU3hDX3oNa
         +X++cu0ZKtS7CpiZZ4rh9qs/butGOs0iVfN/GY1M5n/3dijDZYllwlAGhtSMcPcoj2mH
         QxorqswhxpYKGNm6oehCXTt0KVFY9sm293m3yfICCsE1EuNZ40FquLA0zrSz9t3qgT1J
         fKbwtINalwDpbjSfj6ZE02MNJz4o6HHYkJpOabaIWOCPix1DVpuck2F1KQRE3y7hW2Xh
         JmF2GWkPLj/E/QvYd0J3syQZkkDXnrQJOWSDPnGrh78KvijyGJMS8ZYCah9CZ93hPDF5
         mXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722695232; x=1723300032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biElDwp4TFuLZvMHwXkUK+uL2r7lhqxtJzDew2Lpgco=;
        b=KkG+x70JYQL5Xc0UtMsPgPQkM4wdKGcK4LajKiikX/eN5hqe9mq3opnmaoYo9FkKUv
         IMIHo/cPHea5x0ZjLA1NrrXRN2Wzm8fGREZS6J1NaPBP9uLsi2EVe4vNjlmHEA6N3A/I
         AKrO0wBnZ8Kcuz5qeZ/1GleKxe27yVuQZxsDVbMdtbwN1vmxqKmYer/IVkK746Q31YkE
         i90QHnNu153DraMF9KAl1uhG92Y7l91Z+X8RhNDMMh8gV7VBVoyvMNTjkj8gaRITE3ix
         O0FwkJa6wwvsr6wbuWVd4/XcI/cK6fPVMzG3oDSLXkC1lE3xlohPMvMze9gjfoZWFaOW
         M6GQ==
X-Gm-Message-State: AOJu0YwcfbmMhRe2WjCo3XtpAnFpSduJAEG1ulfHvsXJiX/K3diIA1e+
	2edTkZdDdywYgTXuWHlFcRdITix8xkjB14SEEUP6uCY7AOrUzzGtu1l5Borjw9A=
X-Google-Smtp-Source: AGHT+IGOSoMJa4pyEInFxSBxeGnG3AcJuYOBaD9+U6FHkxU2rEJtZLiyWLF4FNuF8J2aW/xHINvI9w==
X-Received: by 2002:a05:600c:1909:b0:426:5b19:d2b3 with SMTP id 5b1f17b1804b1-428e479144dmr66908785e9.14.1722695231977;
        Sat, 03 Aug 2024 07:27:11 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adaadsm131011015e9.12.2024.08.03.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 07:27:11 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v2][Newcomer] t7004-tag: modernize the test script
Date: Sat,  3 Aug 2024 17:26:46 +0300
Message-ID: <20240803142646.52341-1-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- remove whitespace after the redirect operators.

- move number of expect files prepared outside of
  test_expect_success to be inside the tests that use it.

- split some lines that have two commands into two lines
  one command each.

- turn some "<<\EOF" into "<<-\EOF" and indent their body.

- avoid using pipes in the output from "test-tool ref-store"
  and write the output to a file.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 304 +++++++++++++++++++++++++++----------------------
 1 file changed, 165 insertions(+), 139 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index fa6336edf9..c60167d6fd 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -97,7 +97,8 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	test_when_finished "git tag -d tag_with_reflog1" &&
 	git tag --create-reflog tag_with_reflog1 &&
 	git reflog exists refs/tags/tag_with_reflog1 &&
-	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 | sed -e "s/^.*	//" >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog1 >actual.body &&
+	sed -e "s/^.*	//" actual.body >actual &&
 	test_cmp expected actual
 '
 
@@ -108,7 +109,8 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	test_when_finished "git tag -d tag_with_reflog2" &&
 	git tag -m "annotated tag" --create-reflog tag_with_reflog2 &&
 	git reflog exists refs/tags/tag_with_reflog2 &&
-	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 | sed -e "s/^.*	//" >actual &&
+	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 >actual.body &&
+	sed -e "s/^.*	//" actual.body >actual &&
 	test_cmp expected actual
 '
 
@@ -129,10 +131,10 @@ test_expect_success 'listing all tags if one exists should succeed' '
 	git tag
 '
 
-cat >expect <<EOF
-mytag
-EOF
 test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
+	cat >expect <<-\EOF &&
+	mytag
+	EOF
 	git tag -l -l >actual &&
 	test_cmp expect actual &&
 	git tag --list --list >actual &&
@@ -207,15 +209,17 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 	test_must_fail git tag -d unknown-tag
 '
 
-cat >expect <<EOF
-myhead
-mytag
-EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l > actual && test_cmp expect actual &&
+	cat >expect <<-\EOF &&
+	myhead
+	mytag
+	EOF
+	git tag -l >actual &&
+	test_cmp expect actual &&
 	git tag -d &&
-	git tag -l > actual && test_cmp expect actual
+	git tag -l >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success \
@@ -248,18 +252,18 @@ test_expect_success 'trying to delete an already deleted tag should fail' \
 
 # listing various tags with pattern matching:
 
-cat >expect <<EOF
-a1
-aa1
-cba
-t210
-t211
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
 test_expect_success 'listing all tags should print them ordered' '
+	cat >expect <<-\EOF &&
+	a1
+	aa1
+	cba
+	t210
+	t211
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag v1.0.1 &&
 	git tag t211 &&
 	git tag aa1 &&
@@ -269,91 +273,97 @@ test_expect_success 'listing all tags should print them ordered' '
 	git tag a1 &&
 	git tag v1.0 &&
 	git tag t210 &&
-	git tag -l > actual &&
+	git tag -l >actual &&
 	test_cmp expect actual &&
-	git tag > actual &&
+	git tag >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-a1
-aa1
-cba
-EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
+	cat >expect <<-\EOF &&
+	a1
+	aa1
+	cba
+	EOF
 	rm *a* &&
-	git tag -l "*a*" > current &&
+	git tag -l "*a*" >current &&
 	test_cmp expect current
 '
 
-cat >expect <<EOF
-v0.2.1
-v1.0.1
-EOF
 test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
-	git tag -l "*.1" > actual &&
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0.1
+	EOF
+	git tag -l "*.1" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-t210
-t211
-EOF
 test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
-	git tag -l "t21*" > actual &&
+	cat >expect <<-\EOF &&
+	t210
+	t211
+	EOF
+	git tag -l "t21*" >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-a1
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l a1 > actual &&
+	cat >expect <<-\EOF &&
+	a1
+	EOF
+	git tag -l a1 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-v1.0
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l v1.0 > actual &&
+	cat >expect <<-\EOF &&
+	v1.0
+	EOF
+	git tag -l v1.0 >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-v1.0.1
-v1.1.3
-EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
-	git tag -l "v1.?.?" > actual &&
+	cat >expect <<-\EOF &&
+	v1.0.1
+	v1.1.3
+	EOF
+	git tag -l "v1.?.?" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
-	git tag -l "v.*" > actual &&
+	git tag -l "v.*" >actual &&
 	test_must_be_empty actual
 '
 
-cat >expect <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
 test_expect_success \
 	'listing tags using v* should print only those having v' '
-	git tag -l "v*" > actual &&
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
+	git tag -l "v*" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'tag -l can accept multiple patterns' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1*" "v0*" >actual &&
 	test_cmp expect actual
 '
@@ -367,16 +377,22 @@ test_expect_success 'tag -l can accept multiple patterns' '
 # out if we're going to break this long-documented form of taking
 # multiple patterns.
 test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documentation previously suggested' '
+	cat >expect <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l "v1*" -l "v0*" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'listing tags in column' '
 	COLUMNS=41 git tag -l --column=row >actual &&
-	cat >expected <<\EOF &&
-a1      aa1     cba     t210    t211
-v0.2.1  v1.0    v1.0.1  v1.1.3
-EOF
+	cat >expected <<-\EOF &&
+	a1      aa1     cba     t210    t211
+	v0.2.1  v1.0    v1.0.1  v1.1.3
+	EOF
 	test_cmp expected actual
 '
 
@@ -384,10 +400,10 @@ test_expect_success 'listing tags in column with column.*' '
 	test_config column.tag row &&
 	test_config column.ui dense &&
 	COLUMNS=40 git tag -l >actual &&
-	cat >expected <<\EOF &&
-a1      aa1   cba     t210    t211
-v0.2.1  v1.0  v1.0.1  v1.1.3
-EOF
+	cat >expected <<-\EOF &&
+	a1      aa1   cba     t210    t211
+	v0.2.1  v1.0  v1.0.1  v1.1.3
+	EOF
 	test_cmp expected actual
 '
 
@@ -398,17 +414,17 @@ test_expect_success 'listing tag with -n --column should fail' '
 test_expect_success 'listing tags -n in column with column.ui ignored' '
 	test_config column.ui "row dense" &&
 	COLUMNS=40 git tag -l -n >actual &&
-	cat >expected <<\EOF &&
-a1              Foo
-aa1             Foo
-cba             Foo
-t210            Foo
-t211            Foo
-v0.2.1          Foo
-v1.0            Foo
-v1.0.1          Foo
-v1.1.3          Foo
-EOF
+	cat >expected <<-\EOF &&
+	a1              Foo
+	aa1             Foo
+	cba             Foo
+	t210            Foo
+	t211            Foo
+	v0.2.1          Foo
+	v1.0            Foo
+	v1.0.1          Foo
+	v1.1.3          Foo
+	EOF
 	test_cmp expected actual
 '
 
@@ -1171,7 +1187,7 @@ test_expect_success GPG \
 	git tag -v emptyfile-signed-tag
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
+printf '\n\n  \n\t\nLeading blank lines\n' >sigblanksfile
 printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
 printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
 printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
@@ -1569,7 +1585,7 @@ test_expect_success \
 
 test_expect_success \
 	'message in editor has initial comment' '
-	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
+	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
 '
 
 test_expect_success 'message in editor has initial comment: first line' '
@@ -1587,7 +1603,7 @@ test_expect_success \
 '
 
 get_tag_header reuse $commit commit $time >expect
-echo "An annotation to be reused" >> expect
+echo "An annotation to be reused" >>expect
 test_expect_success \
 	'overwriting an annotated tag should use its previous body' '
 	git tag -a -m "An annotation to be reused" reuse &&
@@ -1639,7 +1655,7 @@ hash3=$(git rev-parse HEAD)
 
 # simple linear checks of --continue
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1679,23 +1695,21 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
-v2.0
-EOF
-
 test_expect_success 'checking that second commit only has one tag' "
+	cat >expected <<-\EOF &&
+	v2.0
+	EOF
 	git tag -l --contains $hash2 v* >actual &&
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
-
 test_expect_success 'inverse of the last test, with --no-contains' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	EOF
 	git tag -l --no-contains $hash2 v* >actual &&
 	test_cmp expected actual
 "
@@ -1705,15 +1719,14 @@ test_expect_success 'checking that third commit has no tags' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
-
 test_expect_success 'conversely --no-contains on the third commit lists all tags' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
@@ -1723,31 +1736,29 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
 test_expect_success 'creating simple branch' '
 	git branch stable v2.0 &&
         git checkout stable &&
-	echo foo-3.0 > foo &&
+	echo foo-3.0 >foo &&
 	git commit foo -m fourth &&
 	git tag v3.0
 '
 
 hash4=$(git rev-parse HEAD)
 
-cat > expected <<EOF
-v3.0
-EOF
-
 test_expect_success 'checking that branch head only has one tag' "
+	cat >expected <<-\EOF &&
+	v3.0
+	EOF
 	git tag -l --contains $hash4 v* >actual &&
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
-
 test_expect_success 'checking that branch head with --no-contains lists all but one tag' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	EOF
 	git tag -l --no-contains $hash4 v* >actual &&
 	test_cmp expected actual
 "
@@ -1757,50 +1768,65 @@ test_expect_success 'merging original branch into this branch' '
         git tag v4.0
 '
 
-cat > expected <<EOF
-v4.0
-EOF
-
 test_expect_success 'checking that original branch head has one tag now' "
+	cat >expected <<-\EOF &&
+	v4.0
+	EOF
 	git tag -l --contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-v3.0
-EOF
-
 test_expect_success 'checking that original branch head with --no-contains lists all but one tag now' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	EOF
 	git tag -l --no-contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-v3.0
-v4.0
-EOF
-
 test_expect_success 'checking that initial commit is in all tags' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
 "
 
 test_expect_success 'checking that --contains can be used in non-list mode' '
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag --contains $hash1 v* >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'checking that initial commit is in all tags with --no-contains' "
+	cat >expected <<-\EOF &&
+	v0.2.1
+	v1.0
+	v1.0.1
+	v1.1.3
+	v2.0
+	v3.0
+	v4.0
+	EOF
 	git tag -l --no-contains $hash1 v* >actual &&
 	test_must_be_empty actual
 "
-- 
2.43.0

