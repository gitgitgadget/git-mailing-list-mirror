Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311415;
	b=4tkVQSw2/ylMn/JYV0jlYw/EKEsSGTgF9w+xca/buQ2HLzJfEKlShP/eXkFfW82EDl19
	 ULbfv6v+J7zTEXl8fDqBGI9bQXzrkqXwk+KvaMdsPLCvpp+HkwfdQc8Zp8IHqxA6eJqmg
	 u94K2ZbONJ1USY2bYiZMTnwxf3C4eJVWSd/o/nz8OcGZ/JVIS9lfqaZV2+UxC3B6B+E6U
	 l1pripONhcPREGM2eMicWh7S7Imeo+BzaE/Zlde/2lCOq7N/bzPjP/hoonYwIGaTZo+R1
	 cY2uEvkcbyUNN2siP7uEd9ohn82Xp/0zD+NA8i/R5gwtruIGRxre4GG914pqAAHCf5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=UhaUHYo5ebJhBcKyeeWPoV/X4jJhyhmlTSUc1qZmksM=;
	b=0ISJhox/xjAfqTBMrWrwddhfNiJ2l+YkTtgl9z3iqNfL8byEW/FrURosCUsIUnqnx+Ii
	 fOmy5TQB7iyd3z5sd0fgw8qhj4g5fokwJbC4vpe4nIbuF1CRCAbexYZYCghEequMa3MD/
	 PNLT2LfkBlzFUGlU4BUZt7rNwckndO+HJ3vmODG4uuc1XilmiWdJW+IG+5EbsYserEEW9
	 Tz7ZIyokJ9QpHeECVMWvg5XKUZKsb8zeOSQXV9Gt7Ab1I4Cuu2JBy8YNWfBGwUAxFk2zr
	 1kBSM2g8GVsVfdHIXtFnYBspl4Tt5ej3xRW19OkumZZW/FgMuOqiGZE8ZlTd5tSw0bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bR3WeD3C;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E4606B59C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D15E4606B59C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bR3WeD3C
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1265559f8f.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311413; x=1794916213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhaUHYo5ebJhBcKyeeWPoV/X4jJhyhmlTSUc1qZmksM=;
        b=bR3WeD3CYmdy6uigDOT9ZYL0Oxc1sOjUe7dWlBLdCnrEoGJvJ7Qnts0pQCHSURZZbR
         jF44PBPj9gXLG0JpLZ6YPZ0sY3Qt3zv5pIfG+TbRvKw9wTM4cQ64HNQF0TDCQEy/Ivqp
         IzC9Fba6zIdnAUZejNXWoyX+iOF7FLR4w3fzqD26LZIGX7dpCI8T4aRCys8/gGm5EjKt
         RqJ7C1mgQQ0XnHR6vlrk61O9oENY5mR1rmTwR2gb7jmcUWcRwROHugEdXEzndi72QkLj
         8N16IntdKxO8hf8Yrj0LpdeszqeOROqhcEV9xGrgFOcfwACZTNXugXIsts9kJjuUd6yf
         j3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311413; x=1794916213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhaUHYo5ebJhBcKyeeWPoV/X4jJhyhmlTSUc1qZmksM=;
        b=DlEbjEmOrUXBIzODcRVdajOevocuaUlfqIWyaEYw/4i06FwB424jv4uNOf0WWR794A
         le4aZXbvQeTYMncOBc6vBml1d3NBekMcnlsVl+PSdcxcIpOkgcbSsfz6rw/MkkmZB/eB
         yZQyVpFFvkmKpEcDGtmPcozDhg+JnTPytCQYeJnlSlwkyl+dgJAKhC/P3BxID/f+Z2Bn
         txguysUnq8Jq0qo9770fgin9yAfZCVK7WxjkmR5rkp3dUq9m4O8WMoULm1/pJAqRomcZ
         X08RTyrdcAhsyIOoGJtvh/mo4tugTTu2uudJ5krQTsX/Of7ZYwROCTXUWTVzvqE1eV31
         7gVw==
X-Gm-Message-State: APuU4Z/KDjwN/q+JLs76NDSyUOBVbJBl6bG25DhDjYLmgOoG5d8TWEW+
	4F2P2m8Zv1pN+qQ07HoHxpOIGgQ4EWP2GTJuABqfAgPTA+UENdFRwbbYgv5lAA==
X-Gm-Gg: AYBFou2OFwwEdw2wD7cUTa7v4sNOEg6fhJPfFszARcAMrjvXRVTGa5xxPxF4hcXqA0c
	esYqliu7ibNk9xXIhlN72fpFP5YaGTQf/BWjTSZpjhnPWFI5TtQU0aKYsgPtLXsOPZTRXA2XcI4
	XUXrE4Sy1Sezpaad04VzxuWkfaxRT7jCzj3MG6b1brK/tHS0M8feVtMhGCXfYioH+nun4+/veJp
	WGmga3pQppmOffpYFBmq8aruhWGIZniMGzuXPl6RzHGbfxD4gkKaRsEqcsjK4vwvD+MuNnR5bt9
	jLDW2uXR4EGYeVk4cjK8YSEGEQj3MTF8Zv5cKSp/jrPR4vEh6PmDRGaWtF7s2DkY242tTGe3z5h
	b+BT4g7XZ3+SwreMEeM1tutet6afSrPNRoYEMxRxiVuVe/R3jpz/iMrvp3EvK2dX9SZF31df9dT
	15RnEoex9IutYse+MA26cr66fh5r8/KJPLCrnYa618DViEhFuO0qNCaaFBFPPfoPEh7izHPiEsQ
	F8xC5FWt3T2QFkvvDht+fXpYptEpi2MhrzR2xS7Z6XLOeDMfxERIUIUx3757l0/atP7rVJsMWtf
	RBspUlzdtyqq64bkVRCfZwQHHakPrh/WK18JlwDaMXuIIJ1jf2Wy6QVLIrPeFvqqFzdn4S4dnKd
	NsJB64avhZc21
X-Received: by 2002:a05:600c:4f86:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4ba022c8baemr39045125e9.0.1794311413135;
        Tue, 10 Nov 2026 03:50:13 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:12 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:57 +0100
Subject: [PATCH 12/20] t9300: make the pack edges test self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-12-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=AlrjK8RCjTNy7L6xfFnqcsh8X+RDwM7llLp8viLiYh0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOgFQ4ihqVCwdxviFbxwERS6/5er9/vVA
 gQ8r9SRKSaN5YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wToAAoJED7VnySO
 Rox/vu4L/jZpkcZMnfW+Hq7+T6HyQmAorImzE4gHQ/4H2FLR3RvJ6uOjCR/9ROD+Ckese4O3q87
 uRvBB4Ri8RC3oi7ZcniPhFsyx9R6MpvhXUr+Of9lJLz/j0M5mTaNUk1iWMn2s9MrTf3AbZ6NoFF
 BQQqrVZaG7v7sKKKVQ7wZCMBQdHbAjfnQq6gwvlRlT7LLDJJHayDtvPpIasRGZclthVIrUo0Zqb
 NYgtmmc/I1MuJhuajoyZXwT9Kl0GIhTvrLOmeSwp462wNV/mZBEtBWEVU/KhDP8rLZJXpMv7BSl
 Q1uCjvbm8r2aLrHFpKoneWbyWgbLje9znR9n9rhAJd58i2ku1ci9m6m5/4OYNX/yL/RrU1zGdX9
 9WvKcAGElOCcWvR8UfeZp4iI22zdfccPbEnvE/gy30rTeN7We18i8BcrBA5lzLfYg4y92Pr6pIA
 iEaTn4EbOwWJll8eXlgxMdmCGemE5O9v1dXVNWlRal4LrtgibrinTRe8C7maueq80BpdVsPLDS8
 eg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the pack-edges tests to make
them independent of state from previous tests.

Fold 'I: verify edge list' into the test creating the edge list, as it
can't run on its own. Pack edges are only recorded for packs which are
kept, so set 'fastimport.unpackLimit' to 0 for the import.

Create the repository with 'git init -b main', as the import builds on
'main' and t9302, where this test ends up, doesn't set
'GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5b0101700d..f55604bb87 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1030,25 +1030,32 @@ test_expect_success 'H: verify file' '
 ###
 
 test_expect_success 'I: export-pack-edges' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/export-boundary
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	we have a border.  its only 40 characters wide.
-	COMMIT
+	test_when_finished "rm -rf repo" &&
+	git init -b main repo &&
+	(
+		cd repo &&
+		test_commit one &&
 
-	from refs/heads/branch
+		cat >input <<-INPUT_END &&
+		commit refs/heads/export-boundary
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		we have a border.  its only 40 characters wide.
+		COMMIT
 
-	INPUT_END
-	git fast-import --export-pack-edges=edges.list <input
-'
+		from refs/heads/main
 
-test_expect_success 'I: verify edge list' '
-	cat >expect <<-EOF &&
-	.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
-	EOF
-	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	test_cmp expect actual
+		INPUT_END
+		git -c fastimport.unpackLimit=0 fast-import \
+			--export-pack-edges=edges.list <input &&
+
+		# verify edge list
+		cat >expect <<-EOF &&
+		.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
+		EOF
+		sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
+		test_cmp expect actual
+	)
 '
 
 ###

-- 
2.56.GIT

