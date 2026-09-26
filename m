Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065CD3E275F
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425064; cv=none; b=TR4YiJUd0bMGeqpazV4qRQG1bE/eiSjJF65ga9XK9EV/oquMcaC24Rld48fGBpsRq0xonPHcdi/KV0feIxrU6tHztlXJSnzTBNd6nu0+yEmBpnLRplrvu3rnMXod8MalcndsdYhmwjbpc4rF6bwIRZLLk3ufJn4RYXP9YWkPYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425064; c=relaxed/simple;
	bh=7gXIlFdWyDxTeB5q+7GFGBY/O5/UvS7RDeakT+zXsis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaWFLLUX54GRu4Uwfn75Zzh5qj0+kNEGwdkwI2mhvn6qhMLSQzNu+abkkT9A7ixcfrV322OPjZtJ/1EGQ4j8VKTjWWxueJ7Gb8iutuCZTlrlcbQdKaNE3XBF4yellS9KXMTif6JBr+4u4oqHnilX0j6WCPfaErtKyxI+GuuV3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM6nUMjq; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM6nUMjq"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6740dd8b4b0so1429559d50.2
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790425062; x=1791029862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+LFi0EbgCqU5xsO+bfGWQL5SWn/nRkNfC4FPy3j1aKc=;
        b=FM6nUMjqvoBt+vr2EjlJ9ksQDI8HBs1kaiqlqiQXm7+0Z+szQmVUBW2CMc89DjU5om
         PrOlP1PKtXwg8v+Cf5ck9Sl/3rW1gizpaVpD2Csh0mEaDGxEyNxTqcN3drTRu9zT+8hE
         ISh1oho+dKxoiEIetY1+UGqJNHON42jFO2px2uATxXzG4lUVOC69DNSjTDmjzFGpRCk5
         ylr7XEnyEG31JJ8ZoeyMQULiM5efhEnFhhjx6J74t3oL/V8LukugMoivFfRwX7OiEeIT
         8WoWb8P7be55IeI8zw2G0fcyvV/tqLdoLscCEbrv3JQ+D/Lx5sYAX6ijvVnDCXrcMuuk
         iupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790425062; x=1791029862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+LFi0EbgCqU5xsO+bfGWQL5SWn/nRkNfC4FPy3j1aKc=;
        b=g8ETTGrmuqzoINkRiJWgtPpyxtOTnOxQvfqleMHnipcOLga4g6P/ZayIlm9poWSTow
         PC5Dq4yfhCxMSCnv3GVplUAqtcK/nfPbZjpMKfFtqVyU7VKtEzR5sv5FdGudPTzQHcVf
         E8sJrfeF5Plpf/o2miHG7aJA7Q3GYotynsm5RRaski2g6ynT70bSbFeycDXK4w9lwpL5
         MZr7OVXHnMYcy7HwKfQrCEoeD0RZz1vTJQW7kVjFljafKmPB77lARfKZ/dLjuKrpi20U
         y9ahhWDEzSklo/WLLb5bOCpd1ctTFwgLLrfijQKBUYyyR90D4ZDrb7RtqzgrayR6MavB
         aZlA==
X-Gm-Message-State: AFq9FYKaP87x3loXmGMU14iPkq8h+0UHWmNPRWU16A4GEN+iGzFoscr+
	UsPqCI8dFnimkneBFce3B54Y6FIQoP7krFyvK6ymtuQC0wrCAkieS7IUAiJKfVWO
X-Gm-Gg: AYBFou0Y7qlVgPDZEiUFP/IAWLWpe2RGdw876muUnkmde6XlDGULyHJCXFrOTlJf1IQ
	kqHZW9eGYHGN4oUbHmVWojz0sSQJQnTavlVgzJNfu/Ts1irAXA7FJVMPm9oCZ51DB/j3OLXUV3g
	/eVjupMxIfzUDk3/KGuXRa5RVW5yt08qgD1mSzDeTTRP8nZlaOqqCPaOLyqZZ+SPLbdrSkZpyMg
	FPKcvdErkJo2Cl9V8T1b09EZ9RH1elQZgdxTtj3YoxAd4ISdVT+kFh48JWwWUfxmjTdswWj3b6A
	EiAUN2jB/GdjRoqfDLS3/5s+Pt/og/4aKdK8Y+1G+iDXr6VfNei0DHXwsbW+uveoIKkJhIbzpdK
	UYu2ni8Ml0GUYzuZkJrsEQ+zoM5o9TQuprPMrYdntCZHQwn1JVyRfW91k/9L1qngk4W36AYe/12
	oqXiGc0IMDmCchj2QmcCpQWYdCqF8iuF2CIY0Uk1D89xhLYcUcgwrZ53R2QVDYzBFuXINDHcGDr
	w5OHu2y0JmzJd+OWrc8TLnbLwffg/i8UXvIVVg0CsbWWQjMJ7qlIHZ4aPOgzv13awhoJ1o6+zhk
	A/hq7nnhwO9Il9R8Gx1Atg==
X-Received: by 2002:a05:690e:1207:b0:66e:65b1:696a with SMTP id 956f58d0204a3-672ed01e99dmr3809401d50.11.1790425061966;
        Sat, 26 Sep 2026 05:17:41 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee9d17csm2179151d50.5.2026.09.26.05.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:17:41 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/5] t3903: test failed "stash apply --index"
Date: Sat, 26 Sep 2026 08:16:47 -0400
Message-ID: <d39e16905da69ee8f00aef939b56708b90ba0c02.1790425008.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790425008.git.ben.knoble@gmail.com>
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will refactor index handling for applied stashes, so
let's make sure we cover conflicted index merging, too.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 t/t3903-stash.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9bc99fa252..11942d875b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -395,6 +395,27 @@ setup_stash() {
 	test_cmp expect file
 '
 
+test_expect_success 'stash apply --index leaves everything untouched on failure' '
+	git reset --hard &&
+	echo test >other-file &&
+	git add other-file &&
+	git stash &&
+	echo unrelated >file &&
+	echo unrelated >another-file &&
+	git add another-file &&
+	echo conflict >other-file &&
+	git add other-file &&
+	git diff-files -p >expect &&
+	git diff-index --cached HEAD >expect-index &&
+
+	test_must_fail git stash apply --index 2>err &&
+	test_grep "conflicts in index. Try without --index" err &&
+	git diff-files -p >actual &&
+	test_cmp expect actual &&
+	git diff-index --cached HEAD >actual-index &&
+	test_cmp expect-index actual-index
+'
+
 test_expect_success 'stash -k' '
 	echo bar3 >file &&
 	echo bar4 >file2 &&
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

