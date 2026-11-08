Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165314;
	b=RzgIA0nziKNB+7nU9Y9gkSxGeZMaQ7dVybEa7bp1jJuUR7E+ZbThoUr/lUQvv0wUrL/p
	 4ei9PYXRHvFRYemUlJJkDWWW8pC688g++6J/aNqjFpj352ovx0QS5kCUAJyRpSpPaXirR
	 TJtO+CdokzEhpTUd5ShayTBGw4O/c9A9CD0Dq02bW3TInQVYSUppiEaD8izS8oCKRO9PG
	 dMjojIpJirhE+wZxyakSC/56tp/wbXTkCJIcJNVz2wDLJgcak/K4tGqSNk0HUKhajeJ95
	 8scYtyvcfCw+RDL+aOcKf127cYqemippp+vKqrB5jq+eWesowcS7oKfdNUp69ERaD2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=n4YW8k15AepOL06cTMKX8Vh966LN8+dPxPpxAfhdxOE=;
	b=xKaiPxVJCAAw2FQRLnj0KOsJZ/j1+wRsXMRrnB97GIzXUA6BMZUIcFzFVTYFJmcSdeJb
	 DbYBV4jiHvFDGhKbrnGsjgA4UwMR/Enw9ekXMWjQxWOh0UNUtLVl4hYQd9qDz+as05VYA
	 NAYhdGvu0Hj4t76JG70khUWYCxLC9RLwJa8i5f9iMJtYnEyz29FEvmiqwlQTImKOEdJHt
	 i1Tbejx2EczXd/m73ueEzKpQPHhedJNfBCSUC6fYVGpTMIn/C074MaSt+drI9Ywrbk1mQ
	 tBKHFD613XxaN1kML2bUQEjOkqQrKYeXp7STqxFeE/gPPlrHQrRd224q4/k4KFtPgag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHu1G3e7;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D022606A320
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D022606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHu1G3e7
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso131446a91.2
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794165313; x=1794770113; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n4YW8k15AepOL06cTMKX8Vh966LN8+dPxPpxAfhdxOE=;
        b=iHu1G3e7wFmzEfeOK8RrsAPCvqCsGhAwh9YgevdXm6ek97302G9n5jsWevjn3LChvy
         aMoxdV65a3hN/MER7wzan75ty/XQf4IPRL/q6hPEInqjmaDCaUPFrUhG2MlTlW8imJSB
         LEsQa6u9+xealVV7Hy9aGwWv1lIoe1id8N5wqZ+LyHenC8xk5OvjVfZ3lthkjfHWJmZk
         Nr6sMJNCv8sznYP2httlWKrdv/G+xu1rkAW9Qo4DMZZN9x1mfJdarnapchUh8N8hK3J8
         /SytjUgnsrpq5dcswMeEo76sz1Uap2ooco10z6o5ux8xMsP5SNkzbRN+moEpPPEJumNv
         08uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165313; x=1794770113;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4YW8k15AepOL06cTMKX8Vh966LN8+dPxPpxAfhdxOE=;
        b=pEZa1jit7X+1HKFBJ0uAyS5NwrVUh16i2RI3NjmeEk/XU/IECJj24wap3Jx0jhgjB+
         U5M0TvoJNX0vMMj9lzu8edEV0VimSYrhUUMnEs+OwE/uX3PsEWyOUmnoYnTgAOvt8V6Y
         NOTFfJZSMw0nbZrsY7xavcrvygcAgzICJt5V+/NJhazdReheFXmeuCTVhp/0LFqEGB9m
         33wxO4PMhqdghRTL9Ptw09JBzqkUIMTqk0K1f+tdKyUB0orQKyxv6y0LpD4fEOUUT2RY
         UEfx/T90YLKxuJwYxZ5qADAzxUf/KnflSA3VweqYB2JjYi9g8G6Gk3A6cU44PyInHnJb
         pbvQ==
X-Gm-Message-State: APuU4Z++xl2JbTKlFK7jqUM/wqKun8y5oxpoMmSvGKgUno3SayNNYAt7
	Y2p1BHjMp0nog7kA/lORm1oJhlqVVVXDQpD3R26hUC9ohWWDkXSzSXw2YO0KeOQx
X-Gm-Gg: AYBFou1ld9iDXWpKj8wsCbebGx8M5cD5QUfS8idhvw+AYCjg8JB9gMHe6YXvIE7LJcU
	pFd/J21tIjPr3df4Gvv1jT5uaTy13Eaei4cwyUclVhGYye79mqO7v0iW01kzo4+RUnMbG0T9AVZ
	XhH7yE1tZRiGFcnSzbAggFsHDN+2U51YtOztTQmM9EIqjMEc6nO8fJojZp+mJzDSSq5yLYwZ1Om
	op/kulOuajVH0wOXo9jfWyBQCZKalKeh2HteDoa2KwWiWrCcA6OKpLOcps1LJffnUTfzdx7o/Ou
	zT+jd89USnA/dXFF6wJKw3yOkzZhlRIi21WgE3KWv3YqoQyedy//pLV3+VtQGB6EMu3rzCgBsow
	AOYxTpDsD+55Ui5oZ9Et94hlUGl1Rf0hqU6dpTbatQc63Yl9mC9x4g6OyKu9OMApqL6W7a5rjwS
	4/yCWmfe3LuXRumgTKsfyHiTRlNXSXfOepvm5HXqk3iFHk2bfBrdA3V9V1aJsNa2cx8gnRMZvAj
	5oNIozhvJJacRk2kJokG2q4QEIK6YE1Kf80OrBOtKCVBZqD7jFOiCbnJu/ZWy0S8GPqJQudr43Z
	WXfJM3EQ6u2b9AouFjNsrYOuDs4SJg==
X-Received: by 2002:a17:90b:2652:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3b12d0f968cmr1877113a91.1.1794165313200;
        Sun, 08 Nov 2026 11:15:13 -0800 (PST)
Received: from [127.0.0.1] ([4.242.60.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127fad1d3sm3871797a91.11.2026.11.08.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:15:11 -0800 (PST)
Message-Id: <f49af0e33fcbc298e8ab66924fcea81bc47ded97.1794165304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Nov 2026 19:15:04 +0000
Subject: [PATCH v2 2/2] t: replace "test-tool genzeros" with "genbytes 00"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Sixt <j6t@kdbg.org>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Now that "genbytes" exists, "genzeros" is merely the special case of
it that writes NUL bytes.  Convert its remaining callers to
"genbytes 00" and remove it, so that there is a single command for
generating repeated bytes.

Only some of these callers depend on the data being NUL bytes, like
t1007, which compares against the object ID of 5GB of zeros, and
t5318, which zeroes out part of a commit-graph file.  The others only
care about the size, but keep generating NUL bytes there, too, so
that what they test does not change.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/helper/test-genbytes.c    | 10 ----------
 t/helper/test-tool.c        |  1 -
 t/helper/test-tool.h        |  1 -
 t/t1007-hash-object.sh      |  8 ++++----
 t/t1051-large-conversion.sh |  4 ++--
 t/t1450-fsck.sh             |  4 ++--
 t/t4141-apply-too-large.sh  |  2 +-
 t/t5318-commit-graph.sh     |  2 +-
 8 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/t/helper/test-genbytes.c b/t/helper/test-genbytes.c
index b760326b24..898d73c516 100644
--- a/t/helper/test-genbytes.c
+++ b/t/helper/test-genbytes.c
@@ -49,13 +49,3 @@ int cmd__genbytes(int argc, const char **argv)
 
 	return generate_bytes(hex2chr(argv[1]), parse_count(argc, argv, 2));
 }
-
-int cmd__genzeros(int argc, const char **argv)
-{
-	if (argc > 2) {
-		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
-		return 1;
-	}
-
-	return generate_bytes('\0', parse_count(argc, argv, 1));
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index af70e2bec7..16571fd702 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -35,7 +35,6 @@ static struct test_cmd cmds[] = {
 	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genbytes", cmd__genbytes },
 	{ "genrandom", cmd__genrandom },
-	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c35e7412af..1b45c8c37b 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -28,7 +28,6 @@ int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genbytes(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
-int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 463b38f990..9e28bcc4f0 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -263,7 +263,7 @@ test_expect_success '--stdin outside of repository (uses default hash)' '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash literally' '
-	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test-tool genbytes 00 $((5*1024*1024*1024)) >big &&
 	test_oid large5GB >expect &&
 	git hash-object --stdin --literally <big >actual &&
 	test_cmp expect actual
@@ -271,7 +271,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash correctly via --stdin' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test -f big || test-tool genbytes 00 $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	git hash-object --stdin <big >actual &&
 	test_cmp expect actual
@@ -279,7 +279,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash correctly' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test -f big || test-tool genbytes 00 $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	git hash-object -- big >actual &&
 	test_cmp expect actual
@@ -289,7 +289,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 # We ensure that cleaning doesn't mangle large files on 64-bit Windows.
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'hash filtered files over 4GB correctly' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test -f big || test-tool genbytes 00 $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	test_config filter.null-filter.clean "cat" &&
 	echo "big filter=null-filter" >.gitattributes &&
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 361afb679b..dd5902b3b3 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -91,7 +91,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 	test_commit test small "a small file" &&
 	small_size=$(test_file_size small) &&
 	test_config filter.makelarge.smudge \
-		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
+		"test-tool genbytes 00 $((5*1024*1024*1024)) && cat" &&
 	echo "small filter=makelarge" >.gitattributes &&
 	rm small &&
 	git checkout -- small &&
@@ -103,7 +103,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 # the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 		'files over 4GB convert on input' '
-	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test-tool genbytes 00 $((5*1024*1024*1024)) >big &&
 	test_config filter.checklarge.clean "wc -c >big.size" &&
 	echo "big filter=checklarge" >.gitattributes &&
 	git add big &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3e9eb251cb..ae21cb897f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1111,7 +1111,7 @@ test_expect_success 'fsck error on gitattributes with excessive line lengths' '
 '
 
 test_expect_success 'fsck error on gitattributes with excessive size' '
-	blob=$(test-tool genzeros $((100 * 1024 * 1024 + 1)) | git hash-object -w --stdin) &&
+	blob=$(test-tool genbytes 00 $((100 * 1024 * 1024 + 1)) | git hash-object -w --stdin) &&
 	test_when_finished "remove_object $blob" &&
 	tree=$(printf "100644 blob %s\t%s\n" $blob .gitattributes | git mktree) &&
 	test_when_finished "remove_object $tree" &&
@@ -1157,7 +1157,7 @@ test_expect_success 'fsck with blob size equal to core.bigFileThreshold' '
 	git init big-blob-fsck &&
 	(
 		cd big-blob-fsck &&
-		test-tool genzeros 1024 >blob &&
+		test-tool genbytes 00 1024 >blob &&
 		git add blob &&
 		git commit -m "blob equal to threshold" &&
 		git repack -ad &&
diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index 6bc1c7a663..52639a62b0 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -13,7 +13,7 @@ test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
 		+++ b/file
 		@@ -0,0 +1 @@
 		EOF
-		test-tool genzeros $((1024 * 1024 * 1023))
+		test-tool genbytes 00 $((1024 * 1024 * 1023))
 	} | test_must_fail git apply 2>err &&
 	test_grep "patch too large" err
 '
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6cecfbeaa1..37b903359c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -522,7 +522,7 @@ corrupt_graph_and_verify() {
 	zero_pos=${4:-${orig_size}} &&
 	printf "$data" | dd of="full/$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="full/$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
-	test-tool genzeros $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
+	test-tool genbytes 00 $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
 	corrupt_graph_verify "$grepstr"
 
 }
-- 
gitgitgadget
