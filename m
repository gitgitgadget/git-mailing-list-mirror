Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311416;
	b=fRiODJJOUxhYOeIhI9tJVZ44ncw0SlHexxFF5zelA0vIW/WcZK6kdfpQm48/dhGNG/lP
	 1Isd3Fi80h/rVjFNY0ebYyJrrDkQSByvqM58u/MlLwm4ilZ/o7OR8WEqe9ZQkOT6IFg5F
	 hPneL28TTckJVL7x+GbEIux4LduiF3+ggqHdtVZaJ1AABqQgfXgrklKhJHZVFFDuXv3tS
	 xy15LfFBMf1LxqrK1Ssg5t7GHnu/X0GgIwN71iMjrzwpKQAtnLk6U5jMhLxav1S2Dt251
	 8WdODGNkJ966d53OD84UuQ9ubm4Ac1rQm4Srz0L4knctSUo4MPmpA1xqgj1IVTW2Oiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=cw/UR/vo/YOqM5/ZRqyNpw/tyLXM/SI89HEpxS4sXps=;
	b=olNDMI9Sormy8br8Tid8yGvLOX0njUSxcA289XakNoVm8HvdGgrIKp2DyI+4mDV3Ulab
	 9uVCC6K2i00zzrvQp9FA+WXhPD2sEOXgjKMuzmPjNds9srrKFitXkWOOFn2ngCV3bTA/7
	 dODmJsWSar6G5/oowIsmmjbNE9Mz//sHEvYpqPnfYUu94Sd0uOFFpSyySCnyONpjFxc9K
	 5kh4zYv44WjAefeePviOYBea7i6jOQEdaBKAq7MDuCJWiatkbG7Bs1jDnahzH/oMgWtJo
	 87pbhguzBocJzYHqLI8BGTz6+5d6wXinjlPQ6J3AKwYQVYcJkeCgZU/+7NaHn8kDJqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7teXIDb;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4792606B5B4
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4792606B5B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7teXIDb
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so16181005e9.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311414; x=1794916214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cw/UR/vo/YOqM5/ZRqyNpw/tyLXM/SI89HEpxS4sXps=;
        b=F7teXIDb6Bf2aR6Al0gUDcOmOHzLFIwnDK0wtcYedTK+n5aueC686aZn9aEtZ5AxvB
         iHOKVNgwe5NZfDBAwu2JAlqXue6BHiaaVrRjlgZcQCdIheoE+fz80cNn9DnfvxcWdllw
         /fOZ04BhtgOSbyd2VeJ3Ft66Aj0g99WRIw8B0mYmOWjVuw2BwhoYxdzP3buqkMMZwlGZ
         U0teKCp80jOSAf1U0stbtvbD5VL8mnD0T9htgBoFf9VMW85AMaGsSJqqmgAYUCsvLB4e
         5u9LsfWFqYo4oL+sovy5t33wl2Ue0dcadhneSgh92ilfNKewrUMPSAA7MRF+Kfuwy/gz
         O0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311414; x=1794916214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cw/UR/vo/YOqM5/ZRqyNpw/tyLXM/SI89HEpxS4sXps=;
        b=ObRYYglgLRINW+EtQWFFkbZ/vyQTsDjIi3r+I0d5mKi/1TSqyCU72Az8pAXQjP5Sc0
         0qOMcxx6IauNOAy8R8nqbsnwxGLU5v5D3DXS48COmSSGYjhYjoxH2zKlQ7aZg3obmDAf
         oUuLNMSmBXKCaq2DvzPngiH27CQhWlb4Fhh9eAh3RVi8Un06XEPgJ3MH1Kv6FQ5yHyKy
         Y2z4nefOO1wWwnh2G8JN90wEsN7dCnyQ+UYBZFPT5KaVCrSyBkze+TGCMjM0YXBn8b9s
         Q9rybiXXdnneRXxvWn3WvP4VySPNev0eco6ml8tLVJ/3diDKQO+FjeIB6OnJYa06su6S
         Ybzw==
X-Gm-Message-State: APuU4Z/ZuDwyAky1HYwpGjRwKjB6g53rYYmN6T6prSohGzeeUzbr4k4h
	aw3hedQnF0Wm4Jn/+i3WXVZ/v4IVHtk+63SqY9BOQ7Ks58ZrSk6O69sAVNjBqg==
X-Gm-Gg: AYBFou03xAkhyuhN2+DsnH0MpxZn+392Kw5zh/NH6q4EdPHRmUVl0DwHcyTmFMlPJTu
	VmATdqAxg69b3QGnBwh+8w/SREKEXp77Br+QIkn3eDBOeM/IwKxC/gjWs4GbjVxfUPFYxBXGMtq
	I6zryeEMGTTi4R3YT0V022+tXXTiQ8rozAFTsbxwwWsJURcGfk5PMJa4hDp32vi+DxEqf1WApCY
	BmsGl4EDSkM7Y/NnPFcAYCPxbfQoGGQU4FTmgkZ1YwsU+Q1FcAOGxkNXSbCdXZYHte158UhcIfh
	pOQuEMNsLLgH5hNZl3h4KeVK2G6rbiks00sZlCxSOr+M1jT1UU45La1BF+otMcgR9dq8V7/vG18
	1ahpQ9d3boxFPlowWfJHrZR7FcbFgeD1eesQB26NXFa9TH+rqguXAisVo9H5HFVoMUAvtkm1t13
	zn0yEo5WM0Yq5/TRXS2ORLoRN5wnwv7FwJDqqC8AZMLnx/Sllz4bugcAllNPITW5vP2htI88+Ka
	Rx+wb8hO+2Dg6W6sE+JOMkXYZnozn4LiqaRUZ26Ty+nSV/qrcdCKeC7cYmQ0AkjhHKNBt4cuEdv
	6D6cjcjg5+W/fCsWgluw53BG5K/hGpT2CD8SoAuY1bze126PaIHYVu31AFxrj/y8bjzh6vl35i6
	YC+Lw+0W21Lxo
X-Received: by 2002:a05:600c:34c7:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4ba0233a41emr33849345e9.8.1794311413855;
        Tue, 10 Nov 2026 03:50:13 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:13 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:58 +0100
Subject: [PATCH 13/20] t9300: make the marks tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-13-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15584;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=u0w2BnP32f8OAyec2kkkkWM5P+LxfMacI74T+1V70L8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOgvyllzdKGid3EbZR6a+RmFKNPAJ0dCE
 KiAk4e8xov4Z4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wToAAoJED7VnySO
 Rox/k7oMAIUDIHgdIDcmvviq7xSQvpkMnrKo1TRl2Y60XxMTqaHsAygcZbkqWfCJrInpJx7Vmrb
 at+Y2LWERihkvYnEC/7958KzEyyggMkv77jEL5+5vivmNQWCIquoohMAfb6mMpBSat75Km9g4dJ
 p7EXK2oxKdY2zp8QXZ/0AmhlgknYVLw8Wzg42x+BX6DUNBKbF6pgSPq86V3vtuqX7Eg0yfvvj+A
 2Defoofuro1/1wdPbUuW4+m5Aq9W3hfe729vGdjPmHf12Rfvzm1xypDioVc3miwAYkO+q2VvXZu
 IFK/celNWx6/hMghW9psang86eTIfnYNQvimqtttHeOjOMZEtx42jms0em6h7H/jE2bh41YFFnK
 qfuNscqSJV67MpsImo7jSiJ24TS6Dxt2cwLQ3fzlmFJ03p8yvRF5+raLGvHZ3Y2o8aOqIthJ5E5
 vW27Ur3B0T9S8Y3NaSkEeQOnrv5KlF5ur6XqjbD9Z8GLVqu6b4UUQ2k+CKNK7sl/aFQnGwnHFP8
 G0=
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
index f55604bb87..82348c65cc 100755
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
@@ -2652,196 +2658,316 @@ test_expect_success 'R: export-marks feature forbidden by default' '
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
@@ -3187,18 +3313,24 @@ test_expect_success 'R: ignore non-git options' '
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

