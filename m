Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504863;
	b=rCZCmBFFulmctEUvI4c5egDs8OzvjRFRN6TOVng0USRjBgbsr3pqKwMeaAofEJ5vC9BF
	 B6n9WMAeQoKV5irrtlK/JKtstm9BvIDvW+ZCyN/SPJvZuBK667mX8qQzcYU7unU+ZCmgb
	 bC1/ztdFgQTN3yO8NaVaIBup2j3JSEkrL+E95r9vKatykbDO1k7jf13LOYddOdsnbqDiE
	 bqhFkmxtUCX3jSCfpsb62LK3GydZ/nRzUyJES4I4pGHbAoArbTR5/Q0EGzgyyXdEdvSiP
	 QKgOR37n5zzrIIml8XKAmo+CUYQeXc7S/w4TibUxmfxYHd4aQkcUMJLl0JYFvTAERcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Y16WniyC22xW/tYDTl/avEIyOxlWTJTnGCP95lyJHpw=;
	b=v/qmc0eGd/QHx/G7TIodIB0loIe7fMnavBlJ3+i5mD058P0xiRc/MLlowZczZGZvtEQU
	 Vywrt9Hafi375en1hlVHU7Igz7Vd5No3P6I8PwPcQNjHmwfFeOcPs8WQuLyW6tzcZAn5v
	 g3B9ZqSHTO0RQexQyyTm1duQ6dAhYFxe+RQVC64y3uZ4L2IwoIZhkM1P9p4kcB/Tuoa9d
	 jXka/S6SWkXAu7sQIowZf/oNEBcozVNFkFiouCWqMh1GDzRfB82CL1v+/lcN2GDrBnFId
	 NPXFVSogPcIGPwBUflU7oExVP/ml0lXawfTSz9YyxSDMTIDyFZRxJFuow7ikcv6FqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2BUqiA7;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532460A381C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2532460A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2BUqiA7
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4922523d1afso11699f8f.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504861; x=1795109661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y16WniyC22xW/tYDTl/avEIyOxlWTJTnGCP95lyJHpw=;
        b=j2BUqiA7vkOWoihf6BGbOuhggSHrZ2mD54T56eV5hSK6IEcWs3mgFdFnPlhqbvwyBr
         /xGEKS4cEM8O5U2hfEJKh4U36vKPhCTc+K4nUNScasQqKszrT4gx9ciFE7aEqj9wG0PK
         4nbd6CGg9ZY4Fd+YiEBG7GNPXbyFCTCduohy0vAexYPvtaQGz4OQ2lLrwXLcQnf1RVOo
         ODufhB4lvGQRB2YOwaqr1+7UOKq3Oe3zkCSNL14BK2xpDgHE1EzcgakKvaBt68sCJyY4
         bdUJn9SdgL8+DxstCq2oj+kndBPdy/gJ6hC6q8T8ZEw2N0lIVo/J52MrspVc2sNmM9Wu
         XTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504861; x=1795109661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y16WniyC22xW/tYDTl/avEIyOxlWTJTnGCP95lyJHpw=;
        b=PHYx3CIgvuJs/cKOdqtFdSnTSahZlAW0Ue3w+JvUka29pbdLTVobGwyVCSmEoj9gXh
         DiTM89Yj/5ZjfdJwsiWrfWvQvW/PdmwecaROj3Ih3/d2OOAtuRE4gOV7hYuUskcH3U9Q
         9d+b6AefaTcg1ByatIlQ7Emgo/usdzVf+ehuAZogSKjWClzg0Evt2WO0U14rW/Ry5oFL
         FPqG6v1OFgsvwfdKmsXAtVnSqLEh4JCRirYbsD09UnsOKwtcGJ1FMZEhRHpvSXyCteGH
         bpxqaPxhn3zh9Dzvt4494i3MusF1ZN+cB42F2LPdiKfEscZHQVeNhmK8ErBA3RvO3mVc
         PNBg==
X-Gm-Message-State: APuU4Z9BwRLQExzaOiML8Arr3nubjeL7fvakDZ99D+aq9jywlTso0UJ7
	KmR6K9c7mQNAEuNggd2YTlGly1vkJNiE98beFMZ3vEe7DwPDwbBW0aKG1hgTtw==
X-Gm-Gg: AYBFou2T0c+XJ7p5FY6hwpowd9nG7sMeVDvMLVDu4U1ojcpeq7ViCZbvMm/4Nw9uzA4
	SgHAVL9T+0YaYaYJCMzk7xzTtsbyhMeZ+41zXxjesOxrUbH1QHzeM6tOR5PhyfxByd764ybibAx
	gwy8EYidT6mpMBHRU07w3CkKiOCuSKETbU5kRZAPSvVBBY++Oym5NYAgs0WWJMw7BzVGLEMUIJd
	w//V4M/LzGrT5hxwCFv/T4fdcHyzIkZcj+hqF1mWEnpkFsxzLA3pkQRHL2JY79TupSfbdGftkaD
	byO+z7L67YSn2lfMfaOpvUhV/xcW+wQMy/yV18sxvnmOgVapz4o2AXudcYtzDQ7+8qlnbZwxXUb
	jMXOvUDb5YjLHneGPiU+wf+61Lit2TCA22YXfK1fHgaziwoY8qIHEVESUTWl8ChUkMstXNJnNRf
	AYxc+kBI1agSyzZz33OxnebYmbIbhyqAsP9TG4FUBeipL8BThrR370Nm9D0HE+dGJ4fpBdWPbQe
	XS/kZHIyl54qVNkrbg4I3JwjhsWh/pQwBmA4Lm8B3tLDQrNW6rhNMXWg70bQvO+oDQ19ImrNJjr
	iAfpdyIZ/PIOxIBKl/b6KmSEAN4rvJyrDPl3DxZWPlTG7z4DdppGREp6ELX/ud4f2oCH
X-Received: by 2002:a5d:588a:0:b0:48e:7508:bc12 with SMTP id ffacd0b85a97d-49c73259d85mr125130f8f.10.1794504861499;
        Thu, 12 Nov 2026 09:34:21 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:21 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:09 +0100
Subject: [PATCH v2 09/20] t9300: make the big blob tests self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-9-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3443; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=MKnbbGoEiLXb5Ehds8BfOyrTS5nVkML5d9tf2ADLMzU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JHeaRA9OLPweYeEQWgyZm+sAi8QNDW6e
 CUl8WALkvNEEokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiRAAoJED7VnySO
 Rox/IUQL/1e/MPeK0dUX8xl1jksgahgqwbwke5L5mUikQ6KfdKvm5OYFDpFkIsGXKfZ8lkwfNgM
 hBQjdoXtHnB3TAPlX0LaxjmQfqI6ehmsriMYTn/m+kUvDmL2/3BTGxFB0OH3sN3eEtPkue/bG+x
 s/upCEtA3YMXi4YTlrwcDVjUeCz2cBDLefa2ysFxK5R1h+Uu/kGD2FzWaDvDSxb9V1dQGcMnhYd
 UWzTTt5dc8fdB1dCG/SLc5DW5od2gbwgZuR5noUw7kF4TH8iT3JkvuVeWh4ZDMjD6Z12Bz2pVZX
 zkjlamUgzcydTNG8ZdKi4z35gOWhYvRSW2F4XrZG2S331Kvu5ZLEa9mPtRXXWI0mZjXB1Cmk3Kz
 A0oVB2HWZ7fFGxWsHYcCSXfjFxG6yaG2sEStR4ta4c6ay0ssteYDSWZCkCkZwMW/zzvjYmklemT
 H2UM320UgO2kvuj+Dfvd29GIRSWPaIAu6ZCaL3slfjhfEvcoZHQ7p2UhoQJFVKb6+RC7npRR0V7
 zQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the big blob tests in 'series R'
to make them independent of state from previous tests.

'R: blob bigger than threshold' imports the blobs, and the tests after
it inspect the result. Fold them into a single test, which does the
import and checks the pack, the blob contents and that the blob is
stored only once.

Set 'fastimport.unpackLimit' to 0 for the import so that a pack is
written, and verify it with an inline loop in place of 'verify_packs()',
which won't be available once the test is moved to another file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 79 ++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e0b9663452..2231e1bdab 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3198,51 +3198,48 @@ test_expect_success 'R: corrupt lines do not mess marks file' '
 ## R: very large blobs
 ##
 test_expect_success 'R: blob bigger than threshold' '
-	blobsize=$((2*1024*1024 + 53)) &&
-	test-tool genrandom bar $blobsize >expect &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/big-file
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	R - big file
-	COMMIT
-
-	M 644 inline big1
-	data $blobsize
-	INPUT_END
-	cat expect >>input &&
-	cat >>input <<-INPUT_END &&
-	M 644 inline big2
-	data $blobsize
-	INPUT_END
-	cat expect >>input &&
-	echo >>input &&
-
-	test_create_repo R &&
-	git --git-dir=R/.git config fastimport.unpackLimit 0 &&
-	git --git-dir=R/.git fast-import --big-file-threshold=1 <input
-'
-
-test_expect_success 'R: verify created pack' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		cd R &&
-		verify_packs -v > ../verify
+		cd repo &&
+
+		blobsize=$((2*1024*1024 + 53)) &&
+		test-tool genrandom bar $blobsize >expect &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/big-file
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		R - big file
+		COMMIT
+
+		M 644 inline big1
+		data $blobsize
+		INPUT_END
+		cat expect >>input &&
+		cat >>input <<-INPUT_END &&
+		M 644 inline big2
+		data $blobsize
+		INPUT_END
+		cat expect >>input &&
+		echo >>input &&
+
+		git -c fastimport.unpackLimit=0 fast-import --big-file-threshold=1 <input &&
+
+		for p in .git/objects/pack/*.pack
+		do
+			git verify-pack -v "$p" || return 1
+		done >verify &&
+
+		git cat-file blob big-file:big1 >actual &&
+		test_cmp_bin expect actual &&
+		a=$(git rev-parse big-file:big1) &&
+		b=$(git rev-parse big-file:big2) &&
+		test $a = $b &&
+		n=$(grep $a verify | wc -l) &&
+		test 1 = $n
 	)
 '
 
-test_expect_success 'R: verify written objects' '
-	git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-	test_cmp_bin expect actual &&
-	a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
-	b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
-	test $a = $b
-'
-
-test_expect_success 'R: blob appears only once' '
-	n=$(grep $a verify | wc -l) &&
-	test 1 = $n
-'
-
 test_expect_success 'R: --git-completion-helper does not read from stdin' '
 	find .git/objects/pack -name "tmp_pack_*" >before &&
 	echo garbage | git fast-import --git-completion-helper >out &&

-- 
2.56.GIT

