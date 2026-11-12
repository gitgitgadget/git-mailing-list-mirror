Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504861;
	b=ajueJRHXj+Ico3w5erz+CRhzUrkIsvwX/sRLiRQPaeXQLBcMZn9zxbNmqbI3UGJ+qStt
	 4XHMQaXPFRa3IsD9OcqhFd5/tsoB04HYsChCGqS7CSq/ZPOpjcUmHfkTSq70mYofjAtUP
	 l0LQEyQO9LzojxcmOMjIePKfBSgemOYdnM1J3J+m/k2Z9oW/pAIE00hKHbc1BhwOvHO1T
	 lzznqy7xLOHcT0/YjUj68fnwMsD2v6DrC7XjvsvcMM8qx6cDXQ6XgM+QA43MRLvyR5Gqp
	 mVMwr/C4rKm36uHWP1UqYTzAJC/PCbofD0XVNUdu+LdmC3MJQtaSA1VRcrjA1Y1colQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=EXFXoNXvYPNbLv6eaveY+co2XvU2yTocUR7QU0d1J8s=;
	b=4mbjGLQIaQpa0t3HjCdnOQd8NQZCsj6RfgXPGb19AR1HNUsTtOVaQs3Zpr/PyRwUqbgG
	 8OLqJ0Y/VCQtIrhsuHXjeGzn0kGSdw0qdJloCMpwiPt9Lnl0Ez/fPnzvDVsdEVpXvbXEZ
	 8dUuIenX5+jug+bicz0HiNSGDs5AajSHGLc9xuFZDkHracTqd94jfPgxBSXMu5XmEM8y2
	 ojZSLgU/mehl2HnvqT5OrGzL25IWpmkDFGGlAaEsgAvqob+rAUin1taLalaSyImUjn9vd
	 lr/RJF8H62sbNtrGRUcaitJufVkZjZQEKNO3BmgFne6dD4ESU+gFGLi6nYZ28BOULbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Db7PfEbZ;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FDA606A222
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84FDA606A222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Db7PfEbZ
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-490a0e72588so1289f8f.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504859; x=1795109659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXFXoNXvYPNbLv6eaveY+co2XvU2yTocUR7QU0d1J8s=;
        b=Db7PfEbZ4JzhYFLC63SnFhbT+boDnOyfV4xWfW/dUsmOMU4f7ZmxjJypXkyycRv/8b
         ck7PSz3MdKuOLRhzEjgA3JFgoreEzCiXBjb/NDqe5Lh9yoK2mBkHSa0ZZQp3worFq2Rt
         T4iUC6Pi3QUUDbAPWIN0xOGKxG5LWg6sauMB24O3l5k6yg7CepmV6hB1HR6wGZafOoH+
         vpzjQdy2dMu1vYrKzj3BwlJZ0gj4jDK8sCQqGn/NQYTw1GAHptvjtPyHdPsNanmirq8x
         vm0jDSm/ebCGBakU45Tw+LMRaZOteBdovEz62WrCVdZqdLDyD7jWaq4QN8t+Rg4Rnev8
         pt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504859; x=1795109659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXFXoNXvYPNbLv6eaveY+co2XvU2yTocUR7QU0d1J8s=;
        b=wz7NgpHEqE7UcTVSsEqeJ8SzTNJL3D7N1+Nv7PDOD70O8q2zf9wmlwPcI7882wZ9Jy
         WywRGBj8hm6qL9B/WmEsQXSOZ2gtWU4gaMeOdP91aGRh8P0g8wTwvG+wz1FFXRMsVl26
         htAnWKQTgHtMQ1suwEBVsTPoIIKn6/7pulN+pCdZ6dX/z2bIkbKtMzkQ+jzupX7r9wzR
         cAB2OkXbcZZ1Ra0jtA7ywuMM75ajNhYh1nHn+rjQe5dzkClmJS8ulkWDGEuNjOFOA4iK
         YeR0qRb74y+oBtVd13t1fWDxVdpxcm4zIGzhYfw4X4lg2sJ1u7iuohy8/8/SbQog2fnw
         dgwA==
X-Gm-Message-State: APuU4Z99rn8uAoyNuu7KQAvEbofdxjz8fIxU5+foGajmuytlNL5xeqCJ
	atuh93ihFQNSS9l3TlWpHiVEtC+iojCjKSUezPEbPv5dfIYBO1Z96tMJOHOlEA==
X-Gm-Gg: AYBFou0QgFC84iguDJR5xv90RqDfvsR+2xaoj/Fr8pMVEQ92k4DUuFGqwmz9DuvTcup
	bLEhtBVU71FZTqTG8LIhQG7kqB9NGy3RpYTy4cib0INnP5bYzWitivLsWiS2B/aJr6orXKe1Mih
	obpY68/+4NZ8U3X4/lQBTYfrTHc7AlikzSoXR9tcUa2RwpGv9ONl37NZlJgDjkrIlf7f0d1Cas0
	NiYpSxD4FmG+zYk8kkGyFaUEzBZvXOD9B94UgI5joiLzh9bd6DNkjGzl7235KApgeVIjab+nbhU
	8svCvWZyFRsZiW/D0Zf/WyYWJHFz1eevDRddMFB6wS8yprvb062MAYY06i4kN+fqT7F91sAoGnu
	0iGy80/OrWAgeIubUmqP8c2j+XXornW8sjL+4paGlsjjJJT8IESN+mSSVEiPZUE8kxMZFVliThu
	hKDFlr0AnnGTbPXQWyN84mxuHdHtqoVE/Uj7uB2MllGEJroDLzLcLSg3eU/h8G4fiTYZJYYEWh8
	5ApJzW4uke8Tzr8TRjLfUvwsOqaXduBjkzKdjfPmb7WVHLzoPpvF1XQk5kgmkgLVVx+QX1O2OGa
	YkU7fGB6yLlrE45Q3/ckV92HT7/HbrN7QzbJuSgJ2sc2Xahx5Ma6gHSvSHCrqNl0pYwy
X-Received: by 2002:a5d:5f46:0:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-49c72306b88mr106534f8f.34.1794504858701;
        Thu, 12 Nov 2026 09:34:18 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:18 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:06 +0100
Subject: [PATCH v2 06/20] t9300: make the series Q tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-6-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12988;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=1mjH9iRT/K6T+vsbaDAdjP6q5i5fnAnkiRN41k/H7dI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JEbTT3ZeWte9yqQv5rYuhTQYyH2Qk40e
 RqI9zILt7G0TokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiRAAoJED7VnySO
 Rox/MEkL/3tEo/+QhKZhnj5q7Mb471NcwwlPgwdQYYl8mEu7r3QI0Ws6tk71xI1mLF4IYLYUjkG
 lfTZd5OiJzXK5cFfG0kyiJdoS/0BHWkiTAKVxqdDnDP53XVCqrItnLBQmY08V2xb4ozqjmgFumY
 icPUvvY+0h5TZrYMxyY+MV33oOBUnwTUwOiMkHQ7+LFt20raGV8LB7vB+YRGD3evCoQu7RrQ8L+
 8AOdRAw7f4LMhJHutI6AJWJGGK8xL9o9UrKH9U0HHvneldYsjTRZRQsS6Dd/x+O2zE8JNTyeLzR
 wMnaiuPl9v0uZHAo6QdlqZZVksHVFPORsyDwpaC3uHQ0/4Ju2SZq03XrutDbtFcN0Wz+ZVzY1oI
 vhJCkxBiL0YF/NRpmzjFqYSZZNd8nY/8CjXS2G0jrHjWKI/iaTeyNAOoqDYlx71Vfh6y598ph2P
 R3dVRDn+//MBMGwPEwOo+uggZiMrnvU77LwYRVC7VKFnCelH3dM3KOT68/Oayuz8c7Mf/9hHbJ7
 hA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series Q' to make
them independent of state from previous tests.

The 'Q: verify' tests inspect the commits and notes written by 'Q:
commit notes', and use shell variables set by the preceding tests.
Replace 'Q: commit notes' with a 'setup_notes_repo()' function, which
creates a new repository, runs the import and sets those variables, so
each test can invoke it.

Drop 'Q: verify pack', as other tests already verify the packs written
by fast-import.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 339 +++++++++++++++++++++++++++++++------------------
 1 file changed, 212 insertions(+), 127 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 809a5a59c5..a85e3e0757 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2048,7 +2048,17 @@ test_expect_success 'P: fail on blob mark in gitlink' '
 ### series Q (notes)
 ###
 
-test_expect_success 'Q: commit notes' '
+setup_notes_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	file2_data="file2
+second line of EOF" &&
+	file4_data=abcd &&
+	file4_len=4 &&
+	file5_data="an inline file.
+  we should see it later." &&
+	file6_data="#!/bin/sh
+echo \"\$@\"" &&
 	note1_data="The first note for the first commit" &&
 	note2_data="The first note for the second commit" &&
 	note3_data="The first note for the third commit" &&
@@ -2057,7 +2067,7 @@ test_expect_success 'Q: commit notes' '
 	note2b_data="The second note for the second commit" &&
 
 	test_tick &&
-	cat >input <<-INPUT_END &&
+	cat >repo/input <<-INPUT_END &&
 	blob
 	mark :2
 	data <<EOF
@@ -2168,199 +2178,274 @@ test_expect_success 'Q: commit notes' '
 
 	INPUT_END
 
-	git fast-import <input &&
-	git log --raw notes-test
-'
-
-test_expect_success 'Q: verify pack' '
-	verify_packs
-'
+	git -C repo fast-import <repo/input &&
+	commit1=$(git -C repo rev-parse notes-test~2) &&
+	commit2=$(git -C repo rev-parse notes-test^) &&
+	commit3=$(git -C repo rev-parse notes-test)
+}
 
 test_expect_success 'Q: verify first commit' '
-	commit1=$(git rev-parse notes-test~2) &&
-	commit2=$(git rev-parse notes-test^) &&
-	commit3=$(git rev-parse notes-test) &&
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	cat >expect <<-EOF &&
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-	first (:3)
-	EOF
-	git cat-file commit notes-test~2 | sed 1d >actual &&
-	test_cmp expect actual
+		first (:3)
+		EOF
+		git cat-file commit notes-test~2 | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second commit' '
-	cat >expect <<-EOF &&
-	parent $commit1
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $commit1
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	second (:5)
-	EOF
-	git cat-file commit notes-test^ | sed 1d >actual &&
-	test_cmp expect actual
+		second (:5)
+		EOF
+		git cat-file commit notes-test^ | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third commit' '
-	cat >expect <<-EOF &&
-	parent $commit2
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $commit2
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	third (:6)
-	EOF
-	git cat-file commit notes-test | sed 1d >actual &&
-	test_cmp expect actual
+		third (:6)
+		EOF
+		git cat-file commit notes-test | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first notes commit' '
-	cat >expect <<-EOF &&
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:9)
-	EOF
-	git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:9)
+		EOF
+		git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit1
-	100644 blob $commit2
-	100644 blob $commit3
-	EOF
-	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit1
+		100644 blob $commit2
+		100644 blob $commit3
+		EOF
+		git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for first commit' '
-	echo "$note1_data" >expect &&
-	git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note1_data" >expect &&
+		git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for second commit' '
-	echo "$note2_data" >expect &&
-	git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note2_data" >expect &&
+		git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for third commit' '
-	echo "$note3_data" >expect &&
-	git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note3_data" >expect &&
+		git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second notes commit' '
-	cat >expect <<-EOF &&
-	parent $(git rev-parse --verify refs/notes/foobar~2)
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $(git rev-parse --verify refs/notes/foobar~2)
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:10)
-	EOF
-	git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:10)
+		EOF
+		git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit1
-	100644 blob $commit2
-	100644 blob $commit3
-	EOF
-	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit1
+		100644 blob $commit2
+		100644 blob $commit3
+		EOF
+		git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second note for first commit' '
-	echo "$note1b_data" >expect &&
-	git cat-file blob refs/notes/foobar^:$commit1 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note1b_data" >expect &&
+		git cat-file blob refs/notes/foobar^:$commit1 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for second commit' '
-	echo "$note2_data" >expect &&
-	git cat-file blob refs/notes/foobar^:$commit2 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note2_data" >expect &&
+		git cat-file blob refs/notes/foobar^:$commit2 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for third commit' '
-	echo "$note3_data" >expect &&
-	git cat-file blob refs/notes/foobar^:$commit3 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note3_data" >expect &&
+		git cat-file blob refs/notes/foobar^:$commit3 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third notes commit' '
-	cat >expect <<-EOF &&
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:11)
-	EOF
-	git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:11)
+		EOF
+		git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit1
-	EOF
-	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit1
+		EOF
+		git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third note for first commit' '
-	echo "$note1c_data" >expect &&
-	git cat-file blob refs/notes/foobar2:$commit1 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note1c_data" >expect &&
+		git cat-file blob refs/notes/foobar2:$commit1 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify fourth notes commit' '
-	cat >expect <<-EOF &&
-	parent $(git rev-parse --verify refs/notes/foobar^)
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $(git rev-parse --verify refs/notes/foobar^)
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:12)
-	EOF
-	git cat-file commit refs/notes/foobar | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:12)
+		EOF
+		git cat-file commit refs/notes/foobar | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify fourth notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit2
-	EOF
-	git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit2
+		EOF
+		git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second note for second commit' '
-	echo "$note2b_data" >expect &&
-	git cat-file blob refs/notes/foobar:$commit2 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note2b_data" >expect &&
+		git cat-file blob refs/notes/foobar:$commit2 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: deny note on empty branch' '
-	cat >input <<-EOF &&
-	reset refs/heads/Q0
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >input <<-EOF &&
+		reset refs/heads/Q0
 
-	commit refs/heads/note-Q0
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Note for an empty branch.
-	COMMIT
+		commit refs/heads/note-Q0
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Note for an empty branch.
+		COMMIT
 
-	N inline refs/heads/Q0
-	data <<NOTE
-	some note
-	NOTE
-	EOF
-	test_must_fail git fast-import <input
+		N inline refs/heads/Q0
+		data <<NOTE
+		some note
+		NOTE
+		EOF
+		test_must_fail git fast-import <input
+	)
 '
 
 ###

-- 
2.56.GIT

