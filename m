Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794766533;
	b=CoBjt3KXxhRF9iSHi2Nf+hD2Xqof3CBLAzO84FXFSVNnZ3NUaeH6BjLNATrKggH3vZhv
	 cca6pUCQtUL/JP6YmsEMGIluYNzQIHABVu7PoX/7+aGo50OJMOi0LuJZN8j/PKsJCjvfE
	 e3DpRFSobGB84MQNH+5tcMUaeOd/i6gaDLU3ZP5fkYUu2AalNpg8MXBpDtzix1IdJE1yB
	 3TEo/INsh6Vuc0NB6MaIWar998UDUOHEi+t7DJlmlGUoomn/M8HUQZzaWdju3xiHZAq1Q
	 3AvXLajzIPR3ua5VpNl5SdHSfqTRE0vuwxNehbRBzZepEsnbsaPQDbzw03ZkjkM/teg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794766533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FAsqitxvm6itTHZa5d0fWqSfFWhW8LIgez0jrQvYXd4=;
	b=cCxIxoxHlVJ/4igORGCg5fSNeWYewMiCVt9aYW2qP+rqjFzz9S0ORbb5J4zF1XUcyytf
	 qYot21GuIeyneaW3dekm2GW8Uz2r9WsqXB9XLggamorrJzGvxY5G4FLlyUzRgGdDCHpXb
	 TXLivyXogc9Dfzzhnu0xY96dQuKfutKW8VJr4XseyPjGFONFFA5/KnaoOzxaEpBTaDhID
	 FNyzk71Ssc4/2FL0dtODYPbLbSFhFF/Cmk0TLDcHQdbeiFRtLVdn8QmPdlne99Gsyr0v+
	 4xhDaCrM5MayDMeeNIrkdTqN5ZGjBBW8zIsYJwunvNQB33iNTtmHv2hu/MeZH3wR95g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwNXyIKq;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA115606A31A
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 18:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA115606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwNXyIKq
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-37f14feca60so370742eec.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794766532; x=1795371332; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FAsqitxvm6itTHZa5d0fWqSfFWhW8LIgez0jrQvYXd4=;
        b=CwNXyIKq6WShncGE8DicnRFbJwA7dAJZ+b2fWnJ177iKeGTYhtiIrrz71uBJ1vD/aO
         Nq9mRrqjtTsI41LVcevr6D2kdJHxFaJAuQfpeBcc7QCmM77dRwmstDRLVmyO1UQgw5jE
         vvySnNZouvC8t/6SybjWdVH5KGl/wYEOxQ135c49xWNFfqObl+lDIPEd2Xnnxx8fJyoo
         8CyWi+NHNkbS+2LjDL4RzMyz3apDzyXhi+kSnz9kp3GobWbkcFc9L2P7oA6UzQgoy6VN
         bektpYLTwvdo5kYCOHqr6KHTJjpaccJp67qjMfvCp7Usfxv0VyVmc3GfvkCkdgIsjPq0
         96mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794766532; x=1795371332;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FAsqitxvm6itTHZa5d0fWqSfFWhW8LIgez0jrQvYXd4=;
        b=NVDztqm6/bD3Ambx7OefiZp376/r//jNOtPUE0tLP7BctdU4qwtYZR2lJ/JKBVYePx
         aNRAk5n4vgylrKVG4DJAqdzbX6eXDeov4drdY3Gtr+Jtl+YsOekLZAq/fdk3lfBIydxx
         lpZtmNWxmlUKMcpwqx/dOObWeXcHw34cZ4AVuA5xL61vRSrwDLiGkMUXe30aKxZxj71P
         t8CppCFve/CNQl+ecx5ta9KPf8I/RuSLCmrvJDZ9Kl4aeOo7nzebEC2ptnS65ZQZlTRT
         Cb0bx1/T+zMRXAMgpb7YjG9IMV4KFpstmZO2IBFa8/1G54lpeEEES5ynHGa5i15TO2L1
         1RMA==
X-Gm-Message-State: APuU4Z8c8b04JhB7Y6RdZXYo9gJLJu94BZ2QJ45Wtqrt+o9TmOfacrII
	TGMHmtGU3KLHSKlKveB3hYVW9TDm9kVMB+k1+Z9dcdRG9XwrOwQoTfnmSnWFogo3
X-Gm-Gg: AYBFou1KjxnVcQfkGDU5xcfy2P5lH+CTFro0E5huC7kMs8U+uciRiYVhAp+l+pmYiy5
	KYdtN3TB3QJ+asw+EIN+O+k3u3czn/20LzGjwCSwq5gh1CXtfEkI1XDYG+ewMf4CyXbcf6iWdTL
	2DAt9oWAK5rHkWPAO0c4f3DtCg5F4Fc9sJcxnAR3W6tL9OnxepjRAWHFEEgURhYyErLUmsYPrZL
	iyYXZz14iBulzAIMrZjkSFM4+jF8FGLJRgfpSK7r+wH7AQOHjFFAqUTKFGqlUJvtOTeJQxHGh9Q
	XbMoZCJJeqcp+JfPPKM0UUgFxfzxd8fvYH/m1zjdN7G2KIgm4bQc3KGy9YGPXr43alV9S3nt7Fx
	CZCQbZ409i8llv+87xrjiJIWSH9Ur+VRnBOFr+KbC6BB3EPjHqkl/pINjHinU2xf/KvM/v1YAxR
	il7nhB31MjiwtnnbGu5k45lXRsHYzddO5dTPihWx+KvFPSjbJpDwrqGvS4ux6KITRs2rkOFkjql
	ar1CbNPyoqjNvp7c2/e7dRkjnJh7JMev8CChn2D6HQkzqUp645PPEE9aMZmr7t0mKt2xcx+LFLX
	D80Fhoh+9yjfeNm17bcNf+Fd4PzwjIsI
X-Received: by 2002:a05:7301:c017:b0:36a:31b2:8643 with SMTP id 5a478bee46e88-37967dd4caamr8536210eec.38.1794766531578;
        Sun, 15 Nov 2026 10:15:31 -0800 (PST)
Received: from [10.25.222.240] ([117.213.200.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm24166024eec.4.2026.11.15.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 10:15:31 -0800 (PST)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Sun, 15 Nov 2026 23:45:21 +0530
Subject: [PATCH] t: use test_must_fail instead of NOT operator
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
Message-Id: <20261115-t-tmf-refactor-v1-1-d7a95cdeaedd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAf0X23ELaC/qV6GC61h7KUIlA/Pek4
 zDMZIgUmCLMIkOghyP7q4JsBJhDXzsh28qgWjVKKQdMmE6HgZw2yQe0ppt6ZRTpbYIa3dXw+w+
 XtZQPkoKCGWAAAAA=
X-Change-ID: 20261115-t-tmf-refactor-dc3742c2eab7
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794766529; l=4102;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=5/lJg7O2LT+NYYtpyOj2ky/eYxvsqp4Z5uAiJ3leCi0=;
 b=1TYZAWym9GCnfahns7YsYOZ+wW5nNbKNiQR2RTkDOv1BAYGAtWtdaBchzezzBRWtVI2c79A+z
 5tINM/kDBwoDbm+zPA7VoV4hDzIJ+mWV4PudJZh1atMqCz2zutqGw5w
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

Replace `!` operator with `test_must_fail` for multiple unit tests where
a git command is expected to fail.

`test_must_fail` handles edge cases like a command killed by a signal
or a crash because of a segfault, by actually failing the test unlike
the `!` operator which would result in the test being passed as the
crash is accepted as a failure (the test is expected to fail).

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 t/t5564-http-proxy.sh       | 4 ++--
 t/t6030-bisect-porcelain.sh | 4 ++--
 t/t7400-submodule-basic.sh  | 4 ++--
 t/t9001-send-email.sh       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 866e2b4e93..429604d528 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -89,14 +89,14 @@ test_expect_success SOCKS_PROXY 'clone via Unix socket' '
 '
 
 test_expect_success 'Unix socket requires socks*:' - <<\EOT
-	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
+	test_must_fail git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
 		test_grep -Fx "fatal: Invalid proxy URL 'localhost/path': only SOCKS proxies support paths" err ||
 		old_libcurl_error err
 	}
 EOT
 
 test_expect_success 'Unix socket requires localhost' - <<\EOT
-	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
+	test_must_fail git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
 		test_grep -Fx "fatal: Invalid proxy URL 'socks4://127.0.0.1/path': host must be localhost if a path is present" err ||
 		old_libcurl_error err
 	}
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a7588222a8..d5e7987f56 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -437,7 +437,7 @@ test_expect_success 'git bisect run: negative exit code' "
 	git bisect start &&
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
-	! git bisect run ./fail.sh 2>err &&
+	test_must_fail git bisect run ./fail.sh 2>err &&
 	sed -E -n 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
 	test_cmp expect actual
 "
@@ -460,7 +460,7 @@ test_expect_success 'git bisect run: unable to verify on good' "
 	git bisect start &&
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
-	! git bisect run ./fail.sh 2>err &&
+	test_must_fail git bisect run ./fail.sh 2>err &&
 	sed -n 's/.*\(unable to verify.*\)/\1/p' err >actual &&
 	test_cmp expect actual
 "
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 36ff5b9546..345c257829 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -237,7 +237,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		echo "*" > .gitignore &&
 		git add --force .gitignore &&
 		git commit -m"Ignore everything" &&
-		! git submodule add "$submodurl" submod >actual 2>&1 &&
+		test_must_fail git submodule add "$submodurl" submod >actual 2>&1 &&
 		test_cmp expect actual
 	)
 '
@@ -280,7 +280,7 @@ test_expect_success 'submodule add relays add --dry-run stderr' '
 	(
 		cd addtest &&
 		: >.git/index.lock &&
-		! git submodule add "$submodurl" sub-while-locked 2>output.err &&
+		test_must_fail git submodule add "$submodurl" sub-while-locked 2>output.err &&
 		test_grep "^fatal: .*index\.lock" output.err &&
 		test_path_is_missing sub-while-locked
 	)
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d1393ef197..ef612acaeb 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -476,7 +476,7 @@ test_expect_success $PREREQ 'malform output reported on blank lines in command o
 
 SomeOtherField: someone-else@example.com"
 	EOF
-	! git send-email \
+	test_must_fail git send-email \
 		--from="Example <nobody@example.com>" \
 		--to=nobody@example.com \
 		--header-cmd=./headercmd-malformed-output \

---
base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
change-id: 20261115-t-tmf-refactor-dc3742c2eab7

