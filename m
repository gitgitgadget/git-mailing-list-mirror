Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582253;
	b=fRG6z6xH1BDNXSgWPGLf2UemlNRTSC6q21/Zuw5m2yevBI0mkBGZbTC4IMq3/fWG/V45
	 fcO1tHk6bWPIzaKPERqbKxs6S4qak3JikKYp3Jg77kzuBEfs6d717IJlNXx3pgDSx1MaF
	 lvZ5LsGZ4KNEnLN0FgEcvoFvBvkeViLvGDj0NdzrG4JDrnIrRg28ubltwKIAbJvPFR4Ic
	 rKe/9qFo4wct2O+XgSjRIQmTD7+COqQeuuuVl8LIskSoUuJQCYOY2sgzthI2LRsn1GLNN
	 WZ9Zkr66/uhhY1R4z4yDQO/lkk+uz71o6rVKAKLX2EOw+oZSeR2PXU7aEbdmtwjgQ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=bKQ3Wr1oc3awyaMSg3meH4YkgAkunbe/I5/msS13Ko0=;
	b=zS+KFJ9Yuy1CynwDupjMq5R40OWemY9YluThYxf8M5oaiGboR5L37sEtHTGzQjsWYip5
	 C7531kizf8tEcioOygVXswO/MLRBeECaA4ujyqTcFJ5i1BIVkJ3xes7Fc8b0bnxRBxQRu
	 HqbSUTcTXedhn5e5aV9HuvI3THy4oA+2VC4k9zs/ocT3hFRe4G6ASbs/ML9jsmprMplbi
	 SHFp3el4ZJv8gLRRMrMtqi9rzw7hUG6WjskLpLWElgCaM1pMeYB5ezpvLwhYb94CMijvX
	 Km8OcVD7TjrYckMSqFS1WKcN6rb9Tepc3Wl6jdzPdc/T3BUlvfEdSJ+yXQZvz/Dc7LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D49j7QwZ;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958ED606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 958ED606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D49j7QwZ
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-845f3fa7f38so374385a34.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792582251; x=1793187051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bKQ3Wr1oc3awyaMSg3meH4YkgAkunbe/I5/msS13Ko0=;
        b=D49j7QwZGnIbIh0yKTSOXNWKDwKR4mZZ6gG7c1WKAiOojzCMBYe8Yu7/tZpbIUgQwd
         Pc/pMjX8yEMaJoYYMlhod7rNufEQIhEY+iqpzj5GqpMHws/9uNGfi6+ebqmjrQG3Tgq4
         LZsZDLqs1aqSLKBJJMVCwuqxt8J3ZGyIc8Ya6sWlNGuqSoD0tgpEPnfAVNZ9XxJuAcRN
         5KadKpwgWebGnEyZkoNUIK0UrX8qz4uQMZORjJkyn+XaeCImvOVg2878s730yEPbZiNf
         qfQMlG9bkkP+bK0hht2t6cob5uIwufIUVXC53/1DQtlzvW3C+KBDoQ9xyIJaeDZxWzj6
         gadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792582251; x=1793187051;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bKQ3Wr1oc3awyaMSg3meH4YkgAkunbe/I5/msS13Ko0=;
        b=uRUcB/P4gi19KoAs72ZPfghemDLjYYiw2reh6YC+WLAm3JDdlv7OP9CqDP4ueYhen0
         uBV8Pu1/UkH2kZn/lga9KiunhGh14D+30VJxsx28lETQvdkThSEaHeCxpLZPb+yQIbfl
         ONi4zDJ7FGjwJG0hkmLACcr84+TZjFA6Hmaw73hiJoiJ2OJQm7A6vzPzyMo83yisMwju
         fFOHOBrWTkMOIEj1vf8PBIcqCE2HdDcuV7uBDdkjviR3VBGxTV/qocnW8HZ6IsRzEmOk
         kXEN49jo1iX+5mp4UXhITG+SWxmfkdWOhF3Fe9EZhDzpytSMfXhs3UhHACXexChPdWjJ
         wlDA==
X-Gm-Message-State: AFq9FYL9+lhr0nCghY1TixxCY/2iFV1FjtXyiZ/VIIjHT2B19DaxZa5W
	RhEONRiCu2pUF185kUBuW2kwmAR8TuJdjyrrVSDKRmLuH847ahBYGSNEqL1Mhg==
X-Gm-Gg: AYBFou2m0yROvBP4UjM5VHfapyAd+CzIR6z22x7Z0Kx5I0faetw66uSjvd9xdAyiVNp
	zQq1dO5X5Hpb3NIFkGkceTAWijmoaDVCkqKa9F8ZztYFv3jPuRwZ2k806snuu+MmX+oPxbGN6+8
	aHyAXJ/tAspkH8cHZkY++qXiF1Y865zxcSfVMJXNo4SMlBHt0mfr3mniVjP2AYkd6yteAl07sku
	hHnQiyJHljYGUpXaYbTWOAYaa+eWrYNMFq+CBWz/juWId9L17J/LEGB9HnekF9eftwrn3tcfuhK
	j2BDYJPVgZewcidd9ngdMTLTPIgd8xp9MfibWm1wualJqnqVWmATm+YDmToS1aSrEFYHNMxx7yj
	ewBXv6PUQ3ru8/RHBBdmD4wO2/jlLEYENjAWCm5bbNooCkRtezpKqa3X3DDFupcuHGtP6g++FyA
	1NS+5LVcuATEfH5ZyhU3CQJ3ZXMKGUfBLdqmc2Q5idcCP5URT0e14ZopU19kRkNRHRINnLpWt24
	cKAMREXFhxhPvEqhqrPZt1UgpcTAj+6msC0zw/EqQGojwy7w0CD2n84fQ==
X-Received: by 2002:a05:6830:2584:b0:822:527e:f653 with SMTP id 46e09a7af769-84d07e0fbe1mr1100319a34.13.1792582251307;
        Wed, 21 Oct 2026 04:30:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.11.66])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbc7d9c39sm2120401a34.4.2026.10.21.04.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:30:50 -0700 (PDT)
Message-Id: <pull.2274.git.1792582249420.gitgitgadget@gmail.com>
From: "Joy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 11:30:49 +0000
Subject: [PATCH] t3429: use test_path_is_file helper
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
Cc: "Usman Akinyemi>" <usmanakinyemi202@gmail.com>,
    "Christian Couder>" <christian.couder@gmail.com>,
    Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
    t3429: use test_path_is_file helper
    
    Replace test -e F with test_path_is_file F in t3429-rebase-edit-todo.sh
    to use Git's semantic test helper and provide better diagnostics on
    failure.
    
    Tested with:
    
    make NO_ICONV=YesPlease test T=t3429-rebase-edit-todo.sh
    
    All 7 tests passed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2274%2FJoiejoie1%2Foutreachy%2Ftest-path-helper-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2274/Joiejoie1/outreachy/test-path-helper-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2274

 t/t3429-rebase-edit-todo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 28e4bdd0d9..a421c35d8a 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup' '
 test_expect_success 'rebase exec modifies rebase-todo' '
 	todo=.git/rebase-merge/git-rebase-todo &&
 	git rebase HEAD~1 -x "echo exec touch F >>$todo" &&
-	test -e F
+	test_path_is_file F
 '
 
 test_expect_success 'rebase exec with an empty list does not exec anything' '

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
gitgitgadget
