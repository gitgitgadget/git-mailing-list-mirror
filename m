Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580140;
	b=C0hEHP8ILEqNzPL0A27nvfCT2ElWFVE/9mUYCi8DvV/XVQSXUUgoeyPR7YxNbud07gc3
	 FofPsYZbryIdgSvY0fKJFZzwZU5DzK6nqCnEYHqxbLJza9+gXvPgH2/22POtZTeT83DP3
	 G9cUQ5swvar4Zv2QALc55TIdEN6n088kIKcNSiRgEWaeQ9kli3DMGXn0Agz3f7bFiFpDX
	 4KsFTPnZJEUgQvqVwX4RIMggh+HY6RRMLYEcoTdpGM2SESw5AWwqfME9Dc0AzrflznS8p
	 8GtPV3jdYq1RUhyxgp+s2SZFXYfOmFkA8oYnDILB0XANzRyFbGFA8C8LMdrfW1iMIkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z/DJOmhm2ZzMiU+QDF6O4bwo1ZzJihLPJ7zb84TmEuA=;
	b=NXHvS3LQ3iVpaOPZICivzpX1Dm9WzL077mexhfgqGRmsXHM6sDsuiMDS+VL6XQNzTHcv
	 ehrdfExcxYf5gk3pCozx7GY7VWNhOZ624/ffo8EZM6eMf3Mxc7LAYqVXFz48OiIKDgEa4
	 i535zec2/tEU4RVx7vG+it1FEf01Nrn46Xj3YNKVl1FfEBblDMs0tbc9w6UYL51HA/Vbx
	 8n1IGoWHBKKkU8+irT/DkHx3dt1JGiTHuSYn1huMr6ButApwfXQK3RzufHJFp7NPuPx/O
	 fT/RcxwWoQEeqAzIz+gKFIgmrBYdg+4ynCNTugN8tnjpbPO+620Mveyq16q+XrnHA0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TulDpUvR;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7E60A2610
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B7E60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TulDpUvR
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so6426855e9.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794580138; x=1795184938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/DJOmhm2ZzMiU+QDF6O4bwo1ZzJihLPJ7zb84TmEuA=;
        b=TulDpUvRkaXo11y+X2CG8KXlo4ZFs0/429ULKEkiix+9Tu2OXf0R8mspTBJ2lDr5p3
         xdxU5uNVsqWCybr79FN9eLvjaskuMiYtU8WPZuWr9hmIvfxtqS9ycCoogPQKDyZuU/dW
         CXsWwNMhSLnyFjSPLw3nECkb8Zv0mQkXBRSXZPJqGLghjQd53QP1qDBw0GzBPRiqymUf
         3ug0LEsJ8bhpvCUlXYJ9+PU0VX7HIgDAwuiN/Bmcd/CZdVvPVn6LSVGhetfQmSuOvGJO
         HdDjcdRlM4SLK1LKXmENF+w/TZkQ2jyk8OnjrHpe6XXhf0A2XqauSXK4gQn4V6lvMyIY
         iAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580138; x=1795184938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/DJOmhm2ZzMiU+QDF6O4bwo1ZzJihLPJ7zb84TmEuA=;
        b=p13BKB0JX7xeLmDC5EHsTlRu2nrM+V/ixzZUKYKGcKHjFqGUhe5CtHRjyVDm6IlJ+l
         kDKgUjfWVTx96nOQtBv+8omKwvqbcW+pIM/UDQZHPpJpeMRLK6vntLAI9uu4EDdij0f4
         1ifqL55wcqFC8Z1DwkZLk3nFtpcr4IEjepGbxqFKKIYroeFvr74Rv3FDiHAFOkdIpVgQ
         PfO6xZ6vjmEeV/KeBOzlIR7633kY7EccJo5K9pWN4Qh/v/y7BZB4PNq9nac55ZOI748o
         6VSwCV5UgocEKSJ+F7uMnuaNzmJXviLGdYEGstLD1iOiEXfmXhyrf+ch4lIlm7sMwLix
         LWqg==
X-Gm-Message-State: APuU4Z9A80qeM4YHxidJQPFwIaZABSU2O1hZ8dXZRlS0w4D1fayDm5NF
	ASsiLnR8xH60RDMrcvm/JINSvxtWij3CO+ywht+jM++h5m06LTgHMlLhYFro7qrW
X-Gm-Gg: AYBFou3L17Bpvq0M8yjIKirFBDrFsiP5N50jonMBjEtuZYgIDU28QmHurzfcSqgVlhe
	H6f7OW1Y4zrQfTlRR+NR/XyW36XiWhkrfONeAC39rI456q3kA8vRcChJc4OZQzn/nFCRu6fTzPK
	ISLPcznXEpeFt29c0Sa3zK/EO7FNXOeXQM1CtVTmx5yTMEyTSmTix7OdiGepLmGjTJoN9PIjisU
	YEb5kWBgUAK5Jrf3jxYzBTGJXwZSGjt2b1MhDkCSC/J6T2AUocrkQ76imhooFAr09aKyo5GfeOi
	gzbgg8mjYBe8brxZ9O4UCuY9ERO2GMakLdRwglWMVWK/04H4axa08zFUtTAYLiRyoChxzeCStM1
	SEvuOdY6+D9tCWkfNL0Y+GFIx6Re5jb2ctdfUKHc/r2qoM8Nz/OtSEg9WNdtTz9uqfVTr6OJSZk
	r9+yT0LZavuyVALqB/Vr+voq/Yw2UifS2QfTlnLzFsW8tRcjkoFskr2WuTJGVJwnk3ewsF0evuA
	lX5m+qxo+znSj1bg8ZFWANY0bzYGHL/gESqZDT2zUfGwjaXH8J/OBOBkDVVduWkp68pZ3n3UfYr
	kkPlA4BSWEdjI8uHmkl69zN+obJKcxhw7NSfBPpqU2mjp7ydoxV052CqbFwk1nInZ+i7R2L+VfK
	OyXGS7zWZKzyCyI+P3lCiknkdz/DaAw==
X-Received: by 2002:a05:600c:3b2a:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4bb55aabdf9mr57868435e9.25.1794580138127;
        Fri, 13 Nov 2026 06:28:58 -0800 (PST)
Received: from KURSA (ipservice-092-208-105-158.092.208.pools.vodafone-ip.de. [92.208.105.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm60033285e9.4.2026.11.13.06.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:28:57 -0800 (PST)
From: Caspar Duregger <caspar.duregger@gmail.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Caspar Duregger <caspar.duregger@gmail.com>
Subject: [PATCH 4/4] cat-file: report out-of-range reflog entries as missing
Date: Fri, 13 Nov 2026 15:28:04 +0100
Message-ID: <20261113142804.7465-5-caspar.duregger@gmail.com>
X-Mailer: git-send-email 2.56.1.windows.1
In-Reply-To: <20260212040708.GA1894049@coredump.intra.peff.net>
References: <20260212040708.GA1894049@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The batch modes of "git cat-file" report a name that does not resolve
as "missing" and go on with the next line. A reflog selector past the
end of the reflog is an exception: get_oid_basic() dies, and takes
the batch process and any requests queued behind it down with it:

    $ printf 'HEAD@{999999}\nHEAD\n' | git cat-file --batch-check
    fatal: log for 'HEAD' only has 3 entries

Pass GET_OID_GENTLY so that these lookups fail like any other. The
previous commits make sure that this changes only lookups that would
have died: selectors at the boundary or by date still resolve, an
emptied reflog fails gently as well, and a peel suffix after the
selector cannot resurrect the name through the reflog date parser.

Not every die() on the way is covered. "HEAD@{999999}~1" still dies,
as get_parent() and get_nth_ancestor() do not pass the caller's flags
down, and so does "@{upstream}" on a detached HEAD.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Caspar Duregger <caspar.duregger@gmail.com>
---
 builtin/cat-file.c  |  1 +
 t/t1006-cat-file.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8870a210ec..56dea8eb80 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -627,6 +627,7 @@ static void batch_one_object(const char *obj_name,
 	struct object_context ctx = {0};
 	int flags =
 		GET_OID_HASH_ANY |
+		GET_OID_GENTLY |
 		(opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
 	enum get_oid_result result;
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index f2b24dd278..5fe2b4ad14 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -451,6 +451,41 @@ test_expect_success 'empty --batch-check notices missing object' '
 	test_cmp expect actual
 '
 
+test_expect_success '--batch-check reports reflog entries out of range as missing' '
+	test_when_finished "rm -rf reflog-range" &&
+	git init reflog-range &&
+	(
+		cd reflog-range &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		# keep a non-null "old" side in the oldest entry
+		git reflog delete HEAD@{2} &&
+		git branch empty &&
+		git reflog expire --expire=all refs/heads/empty &&
+		cat >in <<-\EOF &&
+		HEAD@{2}
+		HEAD@{1970-01-02}
+		HEAD@{3}
+		HEAD@{999999}^{tree}
+		HEAD@{999999}:one.t
+		empty@{1}
+		HEAD
+		EOF
+		cat >expect <<-EOF &&
+		$(git rev-parse one)
+		$(git rev-parse one)
+		HEAD@{3} missing
+		HEAD@{999999}^{tree} missing
+		HEAD@{999999}:one.t missing
+		empty@{1} missing
+		$(git rev-parse three)
+		EOF
+		git cat-file --batch-check="%(objectname)" <in >actual &&
+		test_cmp expect actual
+	)
+'
+
 batch_tests () {
     boid=$1
     loid=$2
-- 
2.56.1.windows.1

