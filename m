Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311412;
	b=hOfr8QU3itf9HSRUSlULLWmpCcD41a7Ri52DGaGWu2MIx9lTfkhKHmOSRo59h3dqTEt5
	 srRLkpodBgESIsY7nupj9Am7/ORwBWXbK/hKIqk6Uqa4pLg/2Qm547bAO9FaqlKurfYVh
	 yivrYTYnqXUM6ifIu9vLKZWk0uzeWm+oM0fuBWTi59bo3y7Zl/8Qond3nPftufiwXyzfk
	 aigdOKMqv2DHK7yIypBV5L3v5HKh40mo/VNTyzojgAcxA6hMvLmedk+e1w5H5FPaX1BuP
	 vyyU/YErzZETpfRfR0Js459jb3ntJooHobfpgEHBIORSVQm/Q2ZIwkPnbOkvf9EgBNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=GCF783yfPeCPkK6X55MQ2/QZeNHVBDFVp2y1EV1Qvjw=;
	b=F1D8gVF3TM46Vm0kIXPUhzmg3c/51LR0VrH/g4GK3pwb3GxlGbHPeldrEHH4Bfei8WQF
	 oBasGCm4IFMJbbZef9W2LJmCddVEfJ4qT7zWK7lp5iYPRN5cn4id9xn0i2SduFltFFK5X
	 faSzI131Y+YLQfn/XeiqEam2fGI+5XlqOIs1NmrRBgC3v+Pv6+CToF+T/E83Qfc3PVWef
	 sMnKCGde8VHE/yPczfItO2NvclTWxLBPUyyHOCZoHvezB3lveCsC5aUbexB1NrwhJE6DF
	 +tFnlpJlQCbRFOVWLgR8Y5l+l3WRbvy54rEz3WR+ahF6hf/KuKR5K8W6M0KOzNSqv7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ea4oy3CP;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F55606A992
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F55606A992
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ea4oy3CP
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a208d93758so19982885e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311410; x=1794916210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCF783yfPeCPkK6X55MQ2/QZeNHVBDFVp2y1EV1Qvjw=;
        b=Ea4oy3CP3ATgTfll4U/kwFVVTCtHOstyaggWpiBVhm0pXJIOUcWx8Z73p7fUgqELiW
         nSBmcWRHXD46QL+Gbb0hhbGyDfaHkTrSchqGl1nw0hA8gQZ6NoJ9Jg8uxfM56IbLTmAy
         iCmRoei+qlJvh3l8zHkhjjjHdHIJpSN5Eo15JUZmQ//KXDVb0VVbpfac9SRZScRpVLdw
         V1EUmtp/WGSCprXDkgs5nReRgsSdEXgarlOZlcLgaZGKi20t7KWFZ4sqrhMqOu0sssqY
         T6KpX7fOwREsqRoTG/OBuVio1q0v2CtnMK43soQeknnlrD0kIZFSSQAhsLyaCBD+IYYl
         i5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311410; x=1794916210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCF783yfPeCPkK6X55MQ2/QZeNHVBDFVp2y1EV1Qvjw=;
        b=uDTTgKUadXx6n41dEhj8OhPk6JgIW+0Z4FKVrTyE9Axjn4gUVlIgLZN/rkj7/Z8nkm
         F1pim8SpgSF7j0NqCZL5y5X6yJ47ZoKGmmm1V0zjNUgwinPYbVsYU8DM3eMwuybqfGDy
         g6iHgDUIla3IG3CJ1UBdA4VrBd8GsQ1LQja2cavcQkLOrqJ2AX4vqCipCBJub4M4qXBs
         UGUYDtxf1A546nblyxu4lXTwTLpTzqu3tGjwTzwTDgRiJ03YR2oh46plqG8RpZDvHDKW
         Pv0sJ16xudt1JJetGOmcrcsEpYnq/28F3UC/3hgMdG3ogg74toG26JpWZwOVvLUg750w
         HwnQ==
X-Gm-Message-State: APuU4Z/TzzAHz3KkX7/cSM71SLvz13G7qFsdAukkxgm+2MaAkCmzo6CR
	N8JvV4ExGbbAUjTWRxu3FShOwodXKT/cOnQnP3xY9221JG/XSf4Gld1q+v4cdg==
X-Gm-Gg: AYBFou1a3CGRNs5qljj6gILkH2raEIHSvx+WzZuOY2QrbfXkBbGsZh8HWAIl+qDKxmj
	CUl5D2iEqepjMdi9oPc9ebOp9LUBGp0Wzq310qkmZCSYvUTiL/S5JjHs2KuraRuA/y4xmyDoaay
	a3k/iELLrqG8Vp5+FGR5KRO2RcJUyh6IUneM9W/6RzF/vgyIbRj+9xb675W3Ws8VHAPVqujk7/s
	v/8y9enHA5UNK2FSlKNnZSgc4lRmDLLwqAiz89ZTs12zgCnxjKml5cMz2Tk6Q+PHyhDv17slt0v
	/OmFWFg7+yTQeZHVJMyKwbPEmN+7qk77zPfsmG+lw5LitzMjRLKIqqbkHihpNsevp57KMof4/U3
	TOQ+pzyCbAUhr/t/iAXxld1Qxg/0tNeiYNIjXTVStVZIysZhu4mD4dTMfKPOurXoyLQXScHQDyV
	c61yF2fpWLkLkKX7msfPvHxJ++mVhK6mmaHj4WWWhz6jO582/jlSNdZDHhFJ3FtL/qZnp9bX0UT
	/UchV+xqbxbzMnafCGYFYHfFhkpuo8Fw2AzXorQKyoIVfxBmG6kAmkP9fmsKLDcRtAbpnAPusvg
	vAcIDXFqYE6cYQjf6dZAo/6G8zSFoFL+VkUOhpiDgZZ2MUlrtJhBTHZqziLg074LwPw=
X-Received: by 2002:a05:600c:6094:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4ba0234759bmr37938025e9.18.1794311410270;
        Tue, 10 Nov 2026 03:50:10 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:53 +0100
Subject: [PATCH 08/20] t9300: make the series O tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-8-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9397; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=X/AOz3ku02g6LnyUb9jtJpFMd+L+8/ZZO1tYMayrqo4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOZkVTr3AwD90282NdjUpaBClay2Ijnzs
 6ohlDpExXSivokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTmAAoJED7VnySO
 Rox/fsIMAI9YqSDwyDZ3Oqt7Z+czZiIBYMERBgReUpt53BYk4fst9zjtAKN1xrwzEAstopmixQO
 +pNFEYZDUFlVs8m592nwF5coCmRTVAzIQLpLvWMUYt9Nxufvl+/UjiA6REI/e+3Q3RuquyfJNGa
 C3lfvCnH6ncnZFJavkeqhpVupUfWkvN1acpYWJM6qD3lxkEVttPc58T+j6BlDH80l1Oh47FPt7M
 EdL0i8PCMeg5IWprqgvYM0SswcAB/TRqhFRPMaiftOL3Nhmirq6lpnAMxMvFkQwS3wlcpONugSV
 8CHeMqXij/8y2DSjLDK9aoG8wCm+1i44C0NsnKCBWGr1+QvNsMgMxj3wGDKzfQYT+20Aq5P8uTq
 YsibWGi3daq5v5GTv3b/FnQvF4/5xsVQvd0BthhvPfnY1ZY9aYiDTnxE5Op/ZBjG3g84NNR3y3Y
 HmbDlitjby7YeWPaeJ+t9cZMhKrzmCOM9GFHjDXwH2wCN8412TZuvxMG/RdhgIGhHDp0PDf00w5
 r8=
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
index 480ae2c47f..75c2de46ed 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1723,143 +1723,216 @@ done
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

