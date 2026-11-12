Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504862;
	b=ImvBBfrR//p9yWG1j4AArLkLJPFW8jxwkOtqyb10LY9r0qdkwaCiZuHHlLLZ0StbdZ/r
	 tsHEJntrzjYRUaJTsBxETMPBRsVUhKuv3K8ls7QqiitD6VqnoXycX+qHprOhUySbNbXvW
	 CTWny25959bYWnWhjj8XWmbg8bWGIfCgbU9J4hzn2/qB4ccUdWghdTKYCHkCd4tH1p5Nm
	 eCyO9yIN7n1JHXcZbEERYYyPre1jm5X0fCZQ2DFLdO/xGlnMeq/kuiIBLNICeHZq2WPoD
	 ApxMjZJtDMDdvf4jV0Nj5HSmMKLaWWRaDO84f6GKORaHfry2yUgQeztA3vN6uio3iKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+pNCgSkQEaGGmT+hx0e8v+5sAAru6q5tFQrbLhquVG4=;
	b=EfR1eNfnzAhc5m1DrLSJX8JSfUYkADSbgC9rfBxee4mRP31lIzFWLrvCfbylvwqvzKnJ
	 aJfDcxwYDlHWGDKVghb8uabV5CKeZaXAw8tBsfifaWGdz4Twik6HMlq/5JF4yI0C0MHqM
	 2GSGAnRSxA0wyxr4qC19Yh7T/HxnSe8+SMAb+bh+pSu+6zWo40qQfYDj0zft4bZHJfKwf
	 ZHuaFJd1aLOObXbSNYM4rm6jVEomnbkmRtkLF4LpP/rOuGlHq8V76i8bEAsDVlaUffktn
	 Z7J5yPTwaiXP/gPKw3oApIiPS6Beoj7and9+9SJI+dmum7S/fb7Eei108nykU38jWPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WqCJShr5;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD0606A23A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40CD0606A23A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WqCJShr5
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-498f5fa5103so2406f8f.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504861; x=1795109661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+pNCgSkQEaGGmT+hx0e8v+5sAAru6q5tFQrbLhquVG4=;
        b=WqCJShr5YZmgoSLdm4EIpTaMbx0AsLMMlyuv4HV39ICghzP/byi4tvMvc/I6KKgLo4
         OjNU6Ty2HypMzp9Z0hFQeHjGnCIgEtovYsTRGEbXRAaSUzSRd49eMn3r7aj5rTVwRNVt
         jrkGr88ip13Xp1Pf5MjmbOJL2GjTE8eX7RYHbEyfEnXmsoukhPTOdF8VY4AczUboW/vJ
         w3IqEzpPEH5eMwn4ywjCgB9vkXKxft5C33ltWSuGnIhJiUlwyAdAcB7qgxZYeogRvy2t
         FSEuJhNjb8bMhI6nTbu9oZisCwrDXYkIbaSXwfC1t8GyY6+ttZBBKiE8BE3G7zVWskXg
         sROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504861; x=1795109661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+pNCgSkQEaGGmT+hx0e8v+5sAAru6q5tFQrbLhquVG4=;
        b=SI77xocEF/k9GQMAvjOT/NCCxI/1vrrrjAo/aeTeiooU9K0xV00mVKidcXGa7S6MD4
         AK/OKD1X83swF4LA1Z71Ku+O36M72q8QUK2rwMCQhru7AZJ1iqOtOffs4mlrGqCEdP6u
         5/iIuvCKJ+loPx/JYhhluXuO7Y/mclT/C2uhIB5CdrRVPMF87WkybUr+/OEtkNkhfmb8
         x9F+UFS6UUpu7uCYpyUn2QyUkOtbVzWBJhZ9mFDKJPb7BmcKxYqqj+4vv9DtSWDK5ZQ1
         jvNnOqDEqhaf4wPxvWHeqWDlkBCEy8a7kubxxUq9N4yqIPv2uZulOhxt9H18fjQS8ERV
         y6Sg==
X-Gm-Message-State: APuU4Z9Bdu0iDhBInd6awYnzbWxBvx/PNgUqXjSRgIyTaZqoblR7PA5x
	sAwLJAP3X41d/rbqPnuiMYK06tqfStqkMZRLZ1cFtSAh+9+go7xewXQSKcAVlQ==
X-Gm-Gg: AYBFou0kLpyHykJRiWqHycJtJE3d2BJN6cUGIyeUMVO8lCEJZ3U936/F7uhYOOUMxB6
	2l3c4nKFrgsNHup0rD3TRy7dGc+rW252ySKqid+hMiURMFDzJP7+gtZRCCRhyFOch/J2e1dRSpQ
	kSvYhYdYTF4Tyh7fA+ml12MVeEvDz3/L1rPb1w95TlhCIkIJq56oZnwP/rONZ/ZGGLs3/Rm/e6W
	hHy/GKwg+8du2rwEDXtmoooxc+tGKT4KVxV5RILvS73P0CQwMlNBVOPz727gBRuXyaRA/2O5YMI
	K69sUsme+N+FIYaEkMOaJJzL6dKSZqeqyddNIMTrQ2f3EpkEjwvTcMqQYjHwHX7bk48a3iGj5Y/
	jKcgo2T9bQxv4T/Q6IopeHa6m5wndAY/YlTnWNn1GkazxuNzESLT4MSNst6B30stQfYWBtkR3Fv
	oociR5xXqsLPMVo4ZlaBotOzcxCzT6+5Vm8VvgqxAtlpNf9Efw3t/ToTAYCIoVVErcdsQH70U+Y
	HIDDz/Va19cS+VqjYWmx6IBujcOlN9ENCJqqD9eXtD1H72MfRzXS0GRBBpC9D74mS26z7ftIneU
	OBLxYLIbyrztrUQ5TOGyfG0KQns68INlJDsqaVZgloC2Mts4rgk35AUPcs8/mFmL7QyF
X-Received: by 2002:a05:6000:4022:b0:491:971a:c568 with SMTP id ffacd0b85a97d-49c712ac9b2mr142951f8f.10.1794504860776;
        Thu, 12 Nov 2026 09:34:20 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:20 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:08 +0100
Subject: [PATCH v2 08/20] t9300: make the series O tests self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-8-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9397; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=atIs7rIDRCjo+Ee5qQV9ysscfl8ez0JGBZUoSyDVA2Y=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JESpGllbrMAAqTh8LhlR3f4jKj7GXZhi
 z91GIp7eteu3IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiRAAoJED7VnySO
 Rox/bWoL/2IAN7EqEo4UhVJNSUK1Y5LSza4hSuotB3GPJ6Va3+LjzFsgFgKCmMBJ15zEtgkr4fK
 u9kUUmUG+uUBsrWK8A6OAflDUeLEPmwS0epoN3OUIlbzn/jyACXP1gLLDStBl+atvTtiS3ep/bD
 KDyyVnCI7guKsUHVGZnNqLiB1C/rfDzcY4tK/5ZoFfhpMPLPYrSRUihDnE+Laun7yUalhYzZerB
 cYBewSxxihfo1Uhb8chDAf494auEk1ePOuVwGcuvwGXrWbM3pY/G9pj2SOLXt0u6S98ivkNN7yo
 EW6lfDTKsUh3PkBbs1xE940k6YMGobZfeBrqpm5t0HGt96SC9EPKdbgDi6h5shlQAoTxqL1Yaw/
 0XYcocnzPlFQkVHiIQNcAP3vT0M8rDqauLlQZRNfBszDLKKrZpFPvyNm1UY/79eNgqHgtPCssQl
 Le/gEcjkyHOGc+FKkUWsoyhtT1uw9jMnwGqsxnEte9XmbpL2edrbX2tIrV0wdd707n0tfcWXbT7
 EU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series O' to make
them independent of state from previous tests.

The tests import on top of 'branch' and compare the result against the
'N3' commit from series N. Import on top of a commit created by the new
'setup_import_repo()' function instead, and compare the result against
the same commit imported from a stream without comments and with blank
lines, so that the whole commit is still checked and not just its tree.
The function sets 'fastimport.unpackLimit' to 0, which 'O: blank lines
not necessary after other commands' relies on.

Drop the 'O: repack before next test' test, and repack in the test
which relies on it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 291 +++++++++++++++++++++++++++++++------------------
 1 file changed, 182 insertions(+), 109 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 920fcd52b5..e0b9663452 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1748,143 +1748,216 @@ done
 ### series O
 ###
 
-test_expect_success 'O: comments are all skipped' '
-	cat >input <<-INPUT_END &&
-	#we will
-	commit refs/heads/O1
-	# -- ignore all of this text
+setup_import_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	git -C repo config fastimport.unpackLimit 0 &&
+	mkdir repo/file2 &&
+	echo abcd >repo/file2/file4 &&
+	git -C repo add file2/file4 &&
+	test_tick &&
+	git -C repo commit -m base
+}
+
+import_reference_commit () {
+	git fast-import <<-INPUT_END
+	commit refs/heads/$1
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
 	dirty directory copy
 	COMMIT
 
-	# do not forget the import blank line!
-	#
-	# yes, we started from our usual base of branch^0.
-	# i like branch^0.
-	from refs/heads/branch^0
-	# and we need to reuse file2/file5 from N3 above.
+	from refs/heads/main
 	M 644 inline file2/file5
-	# otherwise the tree will be different
 	data <<EOF
-	$file5_data
+	an inline file.
+	  we should see it later.
 	EOF
 
-	# do not forget to copy file2 to file3
 	C file2 file3
-	#
-	# or to delete file5 from file2.
 	D file2/file5
-	# are we done yet?
 
 	INPUT_END
+}
 
-	git fast-import <input &&
-	test $(git rev-parse N3) = $(git rev-parse O1)
+test_expect_success 'O: comments are all skipped' '
+	setup_import_repo &&
+	(
+		cd repo &&
+
+		cat >input <<-INPUT_END &&
+		#we will
+		commit refs/heads/O1
+		# -- ignore all of this text
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		dirty directory copy
+		COMMIT
+
+		# do not forget the import blank line!
+		#
+		# yes, we started from our usual base of main.
+		# i like main.
+		from refs/heads/main
+		# and we need to add file2/file5 to file2.
+		M 644 inline file2/file5
+		# otherwise the tree will be different
+		data <<EOF
+		an inline file.
+		  we should see it later.
+		EOF
+
+		# do not forget to copy file2 to file3
+		C file2 file3
+		#
+		# or to delete file5 from file2.
+		D file2/file5
+		# are we done yet?
+
+		INPUT_END
+
+		git fast-import <input &&
+		blob4=$(echo abcd | git hash-object --stdin) &&
+		blob5=$(printf "an inline file.\n  we should see it later.\n" | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		100644 blob $blob4	file2/file4
+		100644 blob $blob4	file3/file4
+		100644 blob $blob5	file3/file5
+		EOF
+		git ls-tree -r O1 >actual &&
+		test_cmp expect actual &&
+
+		import_reference_commit O1-reference &&
+		test_cmp_rev O1-reference O1
+	)
 '
 
 test_expect_success 'O: blank lines not necessary after data commands' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/O2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	dirty directory copy
-	COMMIT
-	from refs/heads/branch^0
-	M 644 inline file2/file5
-	data <<EOF
-	$file5_data
-	EOF
-	C file2 file3
-	D file2/file5
+	setup_import_repo &&
+	(
+		cd repo &&
 
-	INPUT_END
+		cat >input <<-INPUT_END &&
+		commit refs/heads/O2
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		dirty directory copy
+		COMMIT
+		from refs/heads/main
+		M 644 inline file2/file5
+		data <<EOF
+		an inline file.
+		  we should see it later.
+		EOF
+		C file2 file3
+		D file2/file5
 
-	git fast-import <input &&
-	test $(git rev-parse N3) = $(git rev-parse O2)
-'
+		INPUT_END
 
-test_expect_success 'O: repack before next test' '
-	git repack -a -d
+		git fast-import <input &&
+		blob4=$(echo abcd | git hash-object --stdin) &&
+		blob5=$(printf "an inline file.\n  we should see it later.\n" | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		100644 blob $blob4	file2/file4
+		100644 blob $blob4	file3/file4
+		100644 blob $blob5	file3/file5
+		EOF
+		git ls-tree -r O2 >actual &&
+		test_cmp expect actual &&
+
+		import_reference_commit O2-reference &&
+		test_cmp_rev O2-reference O2
+	)
 '
 
 test_expect_success 'O: blank lines not necessary after other commands' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/O3
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zstring
-	COMMIT
-	commit refs/heads/O3
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zof
-	COMMIT
-	checkpoint
-	commit refs/heads/O3
-	mark :5
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zempty
-	COMMIT
-	checkpoint
-	commit refs/heads/O3
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zcommits
-	COMMIT
-	reset refs/tags/O3-2nd
-	from :5
-	reset refs/tags/O3-3rd
-	from :5
-	INPUT_END
+	setup_import_repo &&
+	(
+		cd repo &&
+		git repack -a -d &&
 
-	cat >expect <<-INPUT_END &&
-	string
-	of
-	empty
-	commits
-	INPUT_END
+		cat >input <<-INPUT_END &&
+		commit refs/heads/O3
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zstring
+		COMMIT
+		commit refs/heads/O3
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zof
+		COMMIT
+		checkpoint
+		commit refs/heads/O3
+		mark :5
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zempty
+		COMMIT
+		checkpoint
+		commit refs/heads/O3
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zcommits
+		COMMIT
+		reset refs/tags/O3-2nd
+		from :5
+		reset refs/tags/O3-3rd
+		from :5
+		INPUT_END
 
-	git fast-import <input &&
-	ls -la .git/objects/pack/pack-*.pack >packlist &&
-	ls -la .git/objects/pack/pack-*.pack >idxlist &&
-	test_line_count = 4 idxlist &&
-	test_line_count = 4 packlist &&
-	test $(git rev-parse refs/tags/O3-2nd) = $(git rev-parse O3^) &&
-	git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
-	test_cmp expect actual
+		cat >expect <<-INPUT_END &&
+		string
+		of
+		empty
+		commits
+		INPUT_END
+
+		git fast-import <input &&
+		ls -la .git/objects/pack/pack-*.pack >packlist &&
+		ls -la .git/objects/pack/pack-*.pack >idxlist &&
+		test_line_count = 4 idxlist &&
+		test_line_count = 4 packlist &&
+		test $(git rev-parse refs/tags/O3-2nd) = $(git rev-parse O3^) &&
+		git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'O: progress outputs as requested by input' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/O4
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zstring
-	COMMIT
-	commit refs/heads/O4
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zof
-	COMMIT
-	progress Two commits down, 2 to go!
-	commit refs/heads/O4
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zempty
-	COMMIT
-	progress Three commits down, 1 to go!
-	commit refs/heads/O4
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	zcommits
-	COMMIT
-	progress done!
-	INPUT_END
-	git fast-import <input >actual &&
-	grep "progress " <input >expect &&
-	test_cmp expect actual
+	setup_import_repo &&
+	(
+		cd repo &&
+
+		cat >input <<-INPUT_END &&
+		commit refs/heads/O4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zstring
+		COMMIT
+		commit refs/heads/O4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zof
+		COMMIT
+		progress Two commits down, 2 to go!
+		commit refs/heads/O4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zempty
+		COMMIT
+		progress Three commits down, 1 to go!
+		commit refs/heads/O4
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		zcommits
+		COMMIT
+		progress done!
+		INPUT_END
+		git fast-import <input >actual &&
+		grep "progress " <input >expect &&
+		test_cmp expect actual
+	)
 '
 
 ###

-- 
2.56.GIT

