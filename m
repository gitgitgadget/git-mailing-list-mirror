Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504870;
	b=Ey6tUUi7H6TtxOY8XQs13tTOb+wgKkdklVvOUJkwGY/5mD01Lf0uLMU30grbXccXuv25
	 Fy0l+0YC/c5qajHBbFzj48iOhKuxD62EQpQK9uy/UkNJtRLkin+ULZn7QZz87H+1iZxLm
	 VMnxszTXlptgIw/XToC+Zdtz9dR1KGkwcZKPxAOQOneC+vfL/4bwFP0UBwCf6DBKjiSvb
	 2CobWnashT4e/X6wY60T/SUWSsrOGyIagA9vu1wqw14GH4ZLx+AdczeU3wnvoHxEkazCH
	 qmclGo3s+YCQm6lpcgfyzwOvbZLhJK0O0LrRkwMp1PCbtGzctCKQ+6bZJP3W2E7f0WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=PO71b3FA2+5hUjuV9GCkI2gbpV85nN9v9Gg9wg8vLSk=;
	b=XPvN+oVAdSv56vJxDmCOpyzR1ny8CLPE+/X0qOJnfVApIX1q37S97Ltmt+o2N5/IbUYC
	 Tn1kOTs3KV5NYaAxSYG5PsPIJ/6Qj3aY8TqaBorFvKkKLNlbWBqcI8LF/lWeJb75zpJsF
	 JqicgSjNWZGRTA5BI9s+vwV2odt4Lu8lYj0MxgQryjLqbd49KIGe+CcQPp+N995v2tqBA
	 JDQ5ZIGCn0pAjzJkZTemaEyGEh7BhKRc9YqGYzYvMWr2/U9YtLPlY69uAw/SntwTWVj6N
	 H5mB8ZXhAhSRQTvdt6dUTMsd2s1WRnhmSoRU3/istZTNpbKR/e1pyf6JVoDOjYSXEOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfRw07jz;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC5606CFE4
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AC5606CFE4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfRw07jz
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so20648f8f.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504869; x=1795109669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PO71b3FA2+5hUjuV9GCkI2gbpV85nN9v9Gg9wg8vLSk=;
        b=HfRw07jzpRhjdZEvcs2YG+3FF8urB6dr+MycTtf/s5tXb8QaLdzcMY6WT0bBvyW0eR
         jVmFZauQRT8uMeOSNUSOov9TVGY5bDC5WBkzu18A7lT+98GI3egohlYdjUZ83asPcUo0
         orZFHKScWcbQu4ZbhJgTF5zR0y+MozIEAqwIDwuF0YDX8IMEpyjJZwU6OZRd0oJCTtfl
         pfM8zXPnX1+FIik5qUXh7dmH+aoKHWY37mK4tbQ8TDavOCijzRVOj7ALLj0ca6So9Vr5
         EkvZl/O1yc79ELhFmWNDiaio5WIwSu10CzSYCzjdLZAK7FMZ02WhxH6n1zrUyPOS/0GW
         NT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504869; x=1795109669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PO71b3FA2+5hUjuV9GCkI2gbpV85nN9v9Gg9wg8vLSk=;
        b=C8x2aqqY/YxelzHQZifr+7hwzHFVCFjL8usD/GmutyPpmwJWw+IlKH4vjFZ8lLm9tT
         VSrS06JFGCVMoCaiRrgSTcX1lTQschl5hqi9nakXR8YzBcIszZX2FT8Cjt/3odF6TD07
         P+hMeDVIJ8IAdD6Xy7wU73TEpl6pX3G52tOS54KNxt1Ai5Vv1FJhS4fhFdc25hyXii0Z
         Wi5sM1kYpiG4RaUV02c6YaISJSEClWvaezex7slq08bBYc9CoHS78pTwFfXzjMcuA6pp
         lsOSfGYjv4y5OLyWsJelpqaG3Xdq+M6YrCc6foZInT9D3BqV3AahoIP1yZ/4UTQt2BvH
         vnnw==
X-Gm-Message-State: APuU4Z8qsbyOu0JbMROKQb3kpEadShLUnfcu/WHvkIZRPqHD9ulV17K6
	hytPBJBAe+K5DHTznzfwpNO6aXJKkhpreyeGgMHFvsKZi0C7VvHy8HfVN0EbwQ==
X-Gm-Gg: AYBFou1x7NLklIcjiw16PgTT1nY4L720x88eL1fqoJ/Tv0b4Yanh9vopDaKGm8ObCAA
	UvIp/k9/TIibo9/Jc4ewjbLLLbDLXqUqKSBcyvTDNNEbVTVYlJuTJmpYb8yORtj6JKZ/w72SJLP
	IdlOqHstoqEqzgB1Ao48qDGuWPRtChFHURANBwzzt7UWhMsMv4kxr2oktha59cGMGfXApoOghWe
	MNKxWO0glODA2k5PFA2825/pn2cEDfVw93/08RjdZKpBjmo+nEOqKu8LTlF5NqPJfwg/S+TiKJP
	4RIzwGP0faluL6cenIBJ6jmHAtN27+D/KC9o5aqr+TLNGB0r/hW8HlJtvGmq3sA4PeA4HiWLNGQ
	T427qnJeT/zKsatzhN2DwpEzjr8kVghmnGihULYV+4fNTP6/an+pqlz2oRqf2TscLZOUhbptdOo
	k/n5xj6KCP8ncU8UMoHKDGag/RSpurjfw78EgVdb0R/ghJeJn/u7Zlo82+xKnNf+p9Caho4qrRv
	13P8hf7U78CrZrm5GhrSJg6XOg2D0wv+Jr20tEvL+hEgHqCfbfSLtW4BuyhJ8mE7nVv4iHuUxXJ
	ZzFdJ+oRg10Pg8UKmWIzVGMNg0Z6iaQpDukiLaLOkcOQaCM6ZB8KqIseQAOhB1eOLoiO
X-Received: by 2002:a05:6000:470b:b0:492:cd78:7137 with SMTP id ffacd0b85a97d-49c6d4538f0mr287382f8f.8.1794504868549;
        Thu, 12 Nov 2026 09:34:28 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:13 +0100
Subject: [PATCH v2 13/20] t9300: make the marks tests self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-13-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15759;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=kaY6C+AXrRhyvnTFvQDxXEva6oKHoH9RrhQQJQjXgYU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JK6NuEVu5JwO1NOA6s64CZG2BVyCGg5W
 rcGaUggr1VTQokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiSAAoJED7VnySO
 Rox/XPIL/jSRDa876aCzvtHoa198x5bKPTGZjXd2kSKVudXWSz9SXSFP0pCoSA1ZT26bM50Lmv+
 SeVDS11xOS/i1wkO7FYF6c2mLIcQZkPWtplbI1Ggpe3X3RRICTwZxkem63v81pL5LKdTuAtSd3w
 LGK1AlE2yHdvOV/FWcO+faamIDpHE/TNxzdhMc43NlQpWl2SKE10InejS8vaVoISQpiL7fMzUOj
 IJHa7MZFh5EBrcGQbKFwzQ+PKNCxpArFYWq7Lv6t1wKdfWuRDf7UCWmNN5R2hvYksuvvijeOACm
 9gF4wmqpiYZrMcWbJatvimjwW0I7ggdbctsQU6AKn1/BCQszit+iEB40rguZAjeYBxKxZA1Ea9H
 GLXw49+FYOahbXdkIgbTKSeTE93Pm2VuzhdIm6my4hg/9tU5oEw/BZrwPCF+xbRzbI1XJ40Ox1S
 vTKKRE8sIK7vAD9oxPZp0ImGfkQurIqwRPxqjWXsZW92NDBp5eN5hfZ8ED56X+4hBmEkq1RZZH4
 WI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the marks tests to make them
independent of state from previous tests.

Several tests import the marks file written by an earlier test. Add a
'create_marks_file()' function which writes one, with marks for commits
and tags too, so each test can invoke it in its own repository.

'R: feature import-marks-if-exists' writes a marks file pointing to a
blob it never stores, relying on an earlier test having written it.
Write the blob in the test itself. Also run 'A: export marks with large
values' in its own repository.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 512 +++++++++++++++++++++++++++++++------------------
 1 file changed, 322 insertions(+), 190 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5b8550584e..1022299b7d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -298,59 +298,65 @@ test_expect_success 'A: verify diff' '
 '
 
 test_expect_success 'A: export marks with large values' '
-	test_tick &&
-	mt=$(git hash-object --stdin < /dev/null) &&
-	>input.blob &&
-	>marks.exp &&
-	>tree.exp &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	cat >input.commit <<-EOF &&
-	commit refs/heads/verify--dump-marks
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	test the sparse array dumping routines with exponentially growing marks
-	COMMIT
-	EOF
+		test_tick &&
+		mt=$(git hash-object --stdin < /dev/null) &&
+		>input.blob &&
+		>marks.exp &&
+		>tree.exp &&
 
-	i=0 l=4 m=6 n=7 &&
-	while test "$i" -lt 27
-	do
-		cat >>input.blob <<-EOF &&
-		blob
-		mark :$l
-		data 0
-		blob
-		mark :$m
-		data 0
-		blob
-		mark :$n
-		data 0
+		cat >input.commit <<-EOF &&
+		commit refs/heads/verify--dump-marks
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		test the sparse array dumping routines with exponentially growing marks
+		COMMIT
 		EOF
-		echo "M 100644 :$l l$i" >>input.commit &&
-		echo "M 100644 :$m m$i" >>input.commit &&
-		echo "M 100644 :$n n$i" >>input.commit &&
 
-		echo ":$l $mt" >>marks.exp &&
-		echo ":$m $mt" >>marks.exp &&
-		echo ":$n $mt" >>marks.exp &&
+		i=0 l=4 m=6 n=7 &&
+		while test "$i" -lt 27
+		do
+			cat >>input.blob <<-EOF &&
+			blob
+			mark :$l
+			data 0
+			blob
+			mark :$m
+			data 0
+			blob
+			mark :$n
+			data 0
+			EOF
+			echo "M 100644 :$l l$i" >>input.commit &&
+			echo "M 100644 :$m m$i" >>input.commit &&
+			echo "M 100644 :$n n$i" >>input.commit &&
 
-		printf "100644 blob $mt\tl$i\n" >>tree.exp &&
-		printf "100644 blob $mt\tm$i\n" >>tree.exp &&
-		printf "100644 blob $mt\tn$i\n" >>tree.exp &&
+			echo ":$l $mt" >>marks.exp &&
+			echo ":$m $mt" >>marks.exp &&
+			echo ":$n $mt" >>marks.exp &&
 
-		l=$(($l + $l)) &&
-		m=$(($m + $m)) &&
-		n=$(($l + $n)) &&
+			printf "100644 blob $mt\tl$i\n" >>tree.exp &&
+			printf "100644 blob $mt\tm$i\n" >>tree.exp &&
+			printf "100644 blob $mt\tn$i\n" >>tree.exp &&
 
-		i=$((1 + $i)) || return 1
-	done &&
+			l=$(($l + $l)) &&
+			m=$(($m + $m)) &&
+			n=$(($l + $n)) &&
 
-	sort tree.exp > tree.exp_s &&
+			i=$((1 + $i)) || return 1
+		done &&
 
-	cat input.blob input.commit | git fast-import --export-marks=marks.large &&
-	git ls-tree refs/heads/verify--dump-marks >tree.out &&
-	test_cmp tree.exp_s tree.out &&
-	test_cmp marks.exp marks.large
+		sort tree.exp > tree.exp_s &&
+
+		cat input.blob input.commit | git fast-import --export-marks=marks.large &&
+		git ls-tree refs/heads/verify--dump-marks >tree.out &&
+		test_cmp tree.exp_s tree.out &&
+		test_cmp marks.exp marks.large
+	)
 '
 
 ###
@@ -2681,32 +2687,44 @@ test_expect_success 'R: export-marks feature forbidden by default' '
 '
 
 test_expect_success 'R: export-marks feature results in a marks file being created' '
-	cat >input <<-EOF &&
-	feature export-marks=git.marks
-	blob
-	mark :1
-	data 3
-	hi
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
+		cat >input <<-EOF &&
+		feature export-marks=git.marks
+		blob
+		mark :1
+		data 3
+		hi
 
-	git fast-import --allow-unsafe-features <input &&
-	test_grep :1 git.marks
+		EOF
+
+		git fast-import --allow-unsafe-features <input &&
+		test_grep :1 git.marks
+	)
 '
 
 test_expect_success 'R: export-marks options can be overridden by commandline options' '
-	cat >input <<-\EOF &&
-	feature export-marks=feature-sub/git.marks
-	blob
-	mark :1
-	data 3
-	hi
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --allow-unsafe-features \
-			--export-marks=cmdline-sub/other.marks <input &&
-	test_grep :1 cmdline-sub/other.marks &&
-	test_path_is_missing feature-sub
+		cat >input <<-\EOF &&
+		feature export-marks=feature-sub/git.marks
+		blob
+		mark :1
+		data 3
+		hi
+
+		EOF
+		git fast-import --allow-unsafe-features \
+				--export-marks=cmdline-sub/other.marks <input &&
+		test_grep :1 cmdline-sub/other.marks &&
+		test_path_is_missing feature-sub
+	)
 '
 
 test_expect_success 'R: --allow-unsafe-features found after a value' '
@@ -2746,167 +2764,275 @@ test_expect_success 'R: --allow-unsafe-features after a non-option' '
 '
 
 test_expect_success 'R: catch typo in marks file name' '
-	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
-	echo "feature import-marks=nonexistent.marks" |
-	test_must_fail git fast-import --allow-unsafe-features
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
+		echo "feature import-marks=nonexistent.marks" |
+		test_must_fail git fast-import --allow-unsafe-features
+	)
 '
 
 test_expect_success 'R: import and output marks can be the same file' '
-	rm -f io.marks &&
-	blob=$(echo hi | git hash-object --stdin) &&
-	cat >expect <<-EOF &&
-	:1 $blob
-	:2 $blob
-	EOF
-	git fast-import --export-marks=io.marks <<-\EOF &&
-	blob
-	mark :1
-	data 3
-	hi
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF &&
-	blob
-	mark :2
-	data 3
-	hi
+		rm -f io.marks &&
+		blob=$(echo hi | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		:1 $blob
+		:2 $blob
+		EOF
+		git fast-import --export-marks=io.marks <<-\EOF &&
+		blob
+		mark :1
+		data 3
+		hi
 
-	EOF
-	test_cmp expect io.marks
+		EOF
+		git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF &&
+		blob
+		mark :2
+		data 3
+		hi
+
+		EOF
+		test_cmp expect io.marks
+	)
 '
 
 test_expect_success 'R: --import-marks=foo --output-marks=foo to create foo fails' '
-	rm -f io.marks &&
-	test_must_fail git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF
-	blob
-	mark :1
-	data 3
-	hi
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
+		rm -f io.marks &&
+		test_must_fail git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF
+		blob
+		mark :1
+		data 3
+		hi
+
+		EOF
+	)
 '
 
 test_expect_success 'R: --import-marks-if-exists' '
-	rm -f io.marks &&
-	blob=$(echo hi | git hash-object --stdin) &&
-	echo ":1 $blob" >expect &&
-	git fast-import --import-marks-if-exists=io.marks --export-marks=io.marks <<-\EOF &&
-	blob
-	mark :1
-	data 3
-	hi
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	test_cmp expect io.marks
+		rm -f io.marks &&
+		blob=$(echo hi | git hash-object --stdin) &&
+		echo ":1 $blob" >expect &&
+		git fast-import --import-marks-if-exists=io.marks --export-marks=io.marks <<-\EOF &&
+		blob
+		mark :1
+		data 3
+		hi
+
+		EOF
+		test_cmp expect io.marks
+	)
 '
 
 test_expect_success 'R: feature import-marks-if-exists' '
-	rm -f io.marks &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	git fast-import --export-marks=io.marks \
-			--allow-unsafe-features <<-\EOF &&
-	feature import-marks-if-exists=not_io.marks
-	EOF
-	test_must_be_empty io.marks &&
+		rm -f io.marks &&
 
-	blob=$(echo hi | git hash-object --stdin) &&
+		git fast-import --export-marks=io.marks \
+				--allow-unsafe-features <<-\EOF &&
+		feature import-marks-if-exists=not_io.marks
+		EOF
+		test_must_be_empty io.marks &&
 
-	echo ":1 $blob" >io.marks &&
-	echo ":1 $blob" >expect &&
-	echo ":2 $blob" >>expect &&
+		blob=$(echo hi | git hash-object -w --stdin) &&
 
-	git fast-import --export-marks=io.marks \
-			--allow-unsafe-features <<-\EOF &&
-	feature import-marks-if-exists=io.marks
-	blob
-	mark :2
-	data 3
-	hi
+		echo ":1 $blob" >io.marks &&
+		echo ":1 $blob" >expect &&
+		echo ":2 $blob" >>expect &&
 
-	EOF
-	test_cmp expect io.marks &&
+		git fast-import --export-marks=io.marks \
+				--allow-unsafe-features <<-\EOF &&
+		feature import-marks-if-exists=io.marks
+		blob
+		mark :2
+		data 3
+		hi
 
-	echo ":3 $blob" >>expect &&
+		EOF
+		test_cmp expect io.marks &&
 
-	git fast-import --import-marks=io.marks \
-			--export-marks=io.marks \
-			--allow-unsafe-features <<-\EOF &&
-	feature import-marks-if-exists=not_io.marks
-	blob
-	mark :3
-	data 3
-	hi
+		echo ":3 $blob" >>expect &&
 
-	EOF
-	test_cmp expect io.marks &&
+		git fast-import --import-marks=io.marks \
+				--export-marks=io.marks \
+				--allow-unsafe-features <<-\EOF &&
+		feature import-marks-if-exists=not_io.marks
+		blob
+		mark :3
+		data 3
+		hi
 
-	git fast-import --import-marks-if-exists=not_io.marks \
-			--export-marks=io.marks \
-			--allow-unsafe-features <<-\EOF &&
-	feature import-marks-if-exists=io.marks
-	EOF
-	test_must_be_empty io.marks
+		EOF
+		test_cmp expect io.marks &&
+
+		git fast-import --import-marks-if-exists=not_io.marks \
+				--export-marks=io.marks \
+				--allow-unsafe-features <<-\EOF &&
+		feature import-marks-if-exists=io.marks
+		EOF
+		test_must_be_empty io.marks
+	)
 '
 
-test_expect_success 'R: import to output marks works without any content' '
-	cat >input <<-EOF &&
-	feature import-marks=marks.out
-	feature export-marks=marks.new
-	EOF
+create_marks_file () {
+	git fast-import --export-marks="$1" <<-EOF
+	blob
+	mark :1
+	data 4
+	one
 
-	git fast-import --allow-unsafe-features <input &&
-	test_cmp marks.out marks.new
+	blob
+	mark :2
+	data 4
+	two
+
+	blob
+	mark :3
+	data 6
+	three
+
+	blob
+	mark :4
+	data 5
+	four
+
+	commit refs/heads/marks
+	mark :5
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	commit with a mark
+	COMMIT
+	M 100644 :1 one
+
+	tag marks-tag
+	mark :6
+	from :5
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<TAG
+	tag with a mark
+	TAG
+
+	EOF
+}
+
+test_expect_success 'R: import to output marks works without any content' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		create_marks_file marks.out &&
+
+		cat >input <<-EOF &&
+		feature import-marks=marks.out
+		feature export-marks=marks.new
+		EOF
+
+		git fast-import --allow-unsafe-features <input &&
+		test_cmp marks.out marks.new
+	)
 '
 
 test_expect_success 'R: import marks prefers commandline marks file over the stream' '
-	cat >input <<-EOF &&
-	feature import-marks=nonexistent.marks
-	feature export-marks=marks.new
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		create_marks_file marks.out &&
 
-	git fast-import --import-marks=marks.out --allow-unsafe-features <input &&
-	test_cmp marks.out marks.new
+		cat >input <<-EOF &&
+		feature import-marks=nonexistent.marks
+		feature export-marks=marks.new
+		EOF
+
+		git fast-import --import-marks=marks.out --allow-unsafe-features <input &&
+		test_cmp marks.out marks.new
+	)
 '
 
-
 test_expect_success 'R: multiple --import-marks= should be honoured' '
-	cat >input <<-EOF &&
-	feature import-marks=nonexistent.marks
-	feature export-marks=combined.marks
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		create_marks_file marks.out &&
 
-	head -n2 marks.out > one.marks &&
-	tail -n +3 marks.out > two.marks &&
-	git fast-import --import-marks=one.marks --import-marks=two.marks \
-		--allow-unsafe-features <input &&
-	test_cmp marks.out combined.marks
+		cat >input <<-EOF &&
+		feature import-marks=nonexistent.marks
+		feature export-marks=combined.marks
+		EOF
+
+		head -n2 marks.out >one.marks &&
+		tail -n +3 marks.out >two.marks &&
+		git fast-import --import-marks=one.marks --import-marks=two.marks \
+			--allow-unsafe-features <input &&
+		test_cmp marks.out combined.marks
+	)
 '
 
 test_expect_success 'R: feature relative-marks should be honoured' '
-	cat >input <<-EOF &&
-	feature relative-marks
-	feature import-marks=relative.in
-	feature export-marks=relative.out
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		create_marks_file marks.out &&
 
-	mkdir -p .git/info/fast-import/ &&
-	cp marks.new .git/info/fast-import/relative.in &&
-	git fast-import --allow-unsafe-features <input &&
-	test_cmp marks.new .git/info/fast-import/relative.out
+		cat >input <<-EOF &&
+		feature relative-marks
+		feature import-marks=relative.in
+		feature export-marks=relative.out
+		EOF
+
+		mkdir -p .git/info/fast-import/ &&
+		cp marks.out .git/info/fast-import/relative.in &&
+		git fast-import --allow-unsafe-features <input &&
+		test_cmp marks.out .git/info/fast-import/relative.out
+	)
 '
 
 test_expect_success 'R: feature no-relative-marks should be honoured' '
-	cat >input <<-EOF &&
-	feature relative-marks
-	feature import-marks=relative.in
-	feature no-relative-marks
-	feature export-marks=non-relative.out
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		create_marks_file marks.out &&
 
-	git fast-import --allow-unsafe-features <input &&
-	test_cmp marks.new non-relative.out
+		cat >input <<-EOF &&
+		feature relative-marks
+		feature import-marks=relative.in
+		feature no-relative-marks
+		feature export-marks=non-relative.out
+		EOF
+
+		mkdir -p .git/info/fast-import/ &&
+		cp marks.out .git/info/fast-import/relative.in &&
+		git fast-import --allow-unsafe-features <input &&
+		test_cmp marks.out non-relative.out
+	)
 '
 
+
 test_expect_success 'R: feature ls supported' '
 	echo "feature ls" |
 	git fast-import
@@ -3252,18 +3378,24 @@ test_expect_success 'R: ignore non-git options' '
 '
 
 test_expect_success 'R: corrupt lines do not mess marks file' '
-	rm -f io.marks &&
-	blob=$(echo hi | git hash-object --stdin) &&
-	cat >expect <<-EOF &&
-	:3 $ZERO_OID
-	:1 $blob
-	:2 $blob
-	EOF
-	cp expect io.marks &&
-	test_must_fail git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	test_cmp expect io.marks
+		rm -f io.marks &&
+		blob=$(echo hi | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		:3 $ZERO_OID
+		:1 $blob
+		:2 $blob
+		EOF
+		cp expect io.marks &&
+		test_must_fail git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF &&
+
+		EOF
+		test_cmp expect io.marks
+	)
 '
 
 ##

-- 
2.56.GIT

