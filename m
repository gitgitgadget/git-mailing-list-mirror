Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304042;
	b=Ba1znmgU1vPYHFfwpfRVeTeeMLet+syKHZrMh8N4Bxv1111PhoR5yJxRlRCqcesR8OKa
	 JQyu6hMe3uV23kNv1Ux2bGlhwRbi7lv3GAgrKIXrhjUl+OOA1qUsEKFq9ebzUcI8Jn5rx
	 0UATs1O3xA4/cId5bjvlTodFvhOxXiDwddQAMiUIQJydJP+HeqMVv9dgn2Rm1P8shkg40
	 sq+KlWVxFNhCltcYOnYB05dt6vWl0cgm1XfhQhVck7AdVffTn8NKibqi5/3QZdNWS6wvH
	 OFZqAWSodn1w44tC/v7RKqxKfsYGWjMSNpMtpemRcg9yqMj4Q939z1rgbLSqFgjVvUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qgS724d9ghz7TtZ9GEDapgP+NmTrl4G9+JNl5Hj0qd0=;
	b=RpgnY8ns47Zj+IAOLbH80JWN8lvUkFFmvKRg8KpSOg3urLOkJ4IS6U6koAxsRq9EETS3
	 2EDtHmr5wNVwpWAF9SOqi1MfUzuam+7JR2QHV8XIhv4aIZUbu3xhlb5Ve5czUlHexiodC
	 FPfGgPNXGsBux6LXz+6S1WuyMoSOkq6ofT/d9tmSiIEIsWnULI6nnOV8/QBAj7+0Ylift
	 rYn9DIA7D1PRESU1PsPcE7iJbWanRWV8bxwkirKeQ5H4XQnu1jOwrrCDgY+7uQKWRgsBn
	 yefXFyZrwmx+TzjDicVQ6jbnG+MRssHp7MzE2u2IbWLPY5sqPC3qNjzrnQ72Y8fk47Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOe0T3t8;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00402606A31D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00402606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOe0T3t8
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-188406bb948so2289966c88.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793304041; x=1793908841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qgS724d9ghz7TtZ9GEDapgP+NmTrl4G9+JNl5Hj0qd0=;
        b=OOe0T3t8f8h9pDxUkeQ/6YjI8xhMUnRnkvRYXnhRJJqmOoNuOWxkpOq69yyXepDbl6
         yan3qTwz7p2gkK/aaAAHtVcx1ErB6bXZJEV5SUw6d8a410fJlxuD1Abn3tYjHhpEHLU+
         voNmmxogEme5Sp63XSydWuFexDTjOjoSUgIEFyhaCj5vKAwdAhH2naKmwfypyENlSKgA
         yghfiVWbtmWJ5De9BwB9ouBcIcaaIgmtWBDhjUw3EDq+OthDso1zh2940Mv04CrbA50i
         6IyYDQ1fED17n+6EjuHhdNfZbhT5CPF6tuu/CGYPG8SLnFVCKP911j41PSk0rGiN2HLl
         /JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304041; x=1793908841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgS724d9ghz7TtZ9GEDapgP+NmTrl4G9+JNl5Hj0qd0=;
        b=PB2YIqKMA8wXtRC1AGCBxFDxCwqynkhdK2xIXWK2qM31yoaQ77XmX2KFFg4t91vEIr
         Cfz6OWsU3urvnalaf/PYxWJSCmcrwgNVCv9V+OtraKalEwwfF+lYsCFDhw9dPwTiXA5d
         nE0V0pJFYhoOTS62PF6aBrTt/0bdCilGG98UB8EddC9bgyoWsgWlAOj6yKySZe1gH1Tg
         p8Oo/FGeDZW5hmywwDhc4Nd3tWJCNwWZDBmuErQY5im4QCdUzTkMjvH6F+I6PDEvMp8u
         8g9gPyE2pBCJj11A7S0iZTZeSRMYsbXFVUNto9r+FiXeZ+c7YOhu4WADcjaFAXrnoFn5
         kK4Q==
X-Gm-Message-State: AFq9FYJV+fbs6f58JrNH2Q1pHnHOfJDNBxWHkd9N0UdacjEjpTiyDgR4
	DonkYqADRuUqbAi3Z2hq0qckSP6d5LTOnMDoccSBmiPR++RZJoHcog9Zf4LuoSmX
X-Gm-Gg: AYBFou04t9xqqR3KtoT8YpxDKoeFqhbv81jedOHCq3kcyM0qIeWnj7eih6IjdUhBvd6
	wGtaJAIUv1R9isWNOhodLuZg7PPvKUdMP4asiduGWY94SKepeuG4/rMfdGBusVXEDmUON6wdz1J
	VDyS5LY7ZgyA6WN5JY7025oYehL9xPXId1eC8XjKh75cLb5LZKFSXMY+WE60oMM5GyCl3lu0FC+
	m5/GmYYdek9TqVFQp6bdvmIvsgUtCiMmXgNQuRYVDTSs0jJ80loyEJfVrpaeB3moO2vjyGfT2ZI
	Q7dQlHA3nFkZhbNTF/9Efgju/TV7VuKbprplTVsaCyTCk0HC9Wye19ygAjzzA9+MtFllnd/F6sa
	Em5adk/UkKpgJqlCHeTORQxQSZVejs9q7QFe3xKtUuxN0QZTImTyubPaiavwO1+leIIZwY7vU9/
	Lfn6NjrvxsBY6MnlRh9o++tQLLphjt2BhlGOlB6p9FrQrWuiTCZ2FnprymTpywpOcubVE2XFca6
	1EICOdCNxnXPYt7GGVfWelH05atOgD/uQuJX4znH40CF66LCdb7aZrjllkffYN5ntooW4/b25vR
	yX+wtyYdzkiLnvvuRmt2tkNxmTprRpp2BKjDE/eb/JQLMJ0SAgN+BZEo7TaIq8IBxg1F
X-Received: by 2002:a05:7022:d8d:b0:14d:3c0c:79e8 with SMTP id a92af1059eb24-1ac5b027fdemr70099c88.10.1793304039704;
        Thu, 29 Oct 2026 13:00:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:3ea7:b20a:3d0d:24bc:820:2801])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm1063268c88.7.2026.10.29.13.00.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 13:00:35 -0700 (PDT)
From: Tilak Kumar <raaztilak07@gmail.com>
To: git@vger.kernel.org
Cc: Tilak Kumar <raaztilak07@gmail.com>
Subject: [GSoC PATCH] t5402: use test_path_* helpers instead of test -e and test -f
Date: Fri, 30 Oct 2026 01:30:24 +0530
Message-ID: <20261029200024.32206-1-raaztilak07@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Use test_path_exists and test_path_is_missing instead of "test -e"
and "! test -f" in the post-merge hook tests, so that a failure
reports which path was unexpectedly missing or present instead of
failing silently.

Signed-off-by: Tilak Kumar <raaztilak07@gmail.com>
---
 t/t5402-post-merge-hook.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index c77aa56421..1e222ac28f 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -37,12 +37,12 @@ test_expect_success 'setup clone hooks' '
 
 test_expect_success 'post-merge does not run for up-to-date ' '
 	GIT_DIR=clone1/.git git merge $commit0 &&
-	! test -f clone1/.git/post-merge.args
+	test_path_is_missing clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge runs as expected ' '
 	GIT_DIR=clone1/.git git merge $commit1 &&
-	test -e clone1/.git/post-merge.args
+	test_path_exists clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from normal merge receives the right argument ' '
@@ -51,7 +51,7 @@ test_expect_success 'post-merge from normal merge receives the right argument '
 
 test_expect_success 'post-merge from squash merge runs as expected ' '
 	GIT_DIR=clone2/.git git merge --squash $commit1 &&
-	test -e clone2/.git/post-merge.args
+	test_path_exists clone2/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from squash merge receives the right argument ' '
-- 
2.55.0

