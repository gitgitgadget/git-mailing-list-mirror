Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA743C9ECF
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226726; cv=none; b=AsIa9FtD2rY+7oip6yz0WLMSYmfM+JT4SNgm/XbGU4iz4xsn1qPxZXpbHEWJKd0U+ibULe4c+VSeWxKfbsNG7ZBO8rhRAxljJEESvb0mjHCpDbwujuI6jYxi6uJUEYhNLvPxzbRwBbqbte4BB2Ro75IF95A2CHL3P4FC5banMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226726; c=relaxed/simple;
	bh=+ZvTDlDJOqIVGXcU4F2j60uFT0cpErB6sTDMND1un60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gB23zDSBxuWG1fuqa5IB6eA/ps+cFOZ4ufKyH0g0Nu43eDRAwwKp2iJk62onpOMKL9GmZNdKmleem4uOLEEQ/ocOtBnY95B8rUrBtY+Yqfz0gosBHJnWFgfoyJooA9RGOeen/YONzIQdT9IjDjFmMOQYZFOC8YUiiT9yKA7AklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdJCewy/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdJCewy/"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8297c035d28so2482860b3a.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 03:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773226725; x=1773831525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYhnS9fFUOzTcOkDHJkn1S75gOu213EgqVGrFt9MyT0=;
        b=SdJCewy/ukMjaFogXvvZO70GH4z8KsJQkUkXxx5l3XGu+RRGau7vI1Feh7GJu1iIxF
         7i/fx2/SsOYvHnZhxdHOJRe9GDFKIonggcYcScMsFpV9Ju6va8vDeN/SYE6PgpEY8XkQ
         ggX/NBn1YtbA2f4kGL91wFHgIXwNGDrpCaFzLicSqc3unpK03tyVBQrhdM1Vc7L2zLiv
         ddu30/pnUaDP6S0Q8x73Apj9aU4pyhpovs5O8BMQMiMkQCbwMArvGLoq+MGCo5byRY09
         TBmefKTrywUj+CM03lEA4RHd4OjhlySv1mbX7xumInZqnYOhdG+WrIOCXLdTPwQSFltm
         b6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226725; x=1773831525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYhnS9fFUOzTcOkDHJkn1S75gOu213EgqVGrFt9MyT0=;
        b=o3mr11FJGEkzoG69L+IAXPbwAygJAsS199CEJJSq62RUrpdPUrecr5ODZsWriE1W2p
         eNRaLIP0bamK0X6xKOk5fdqDpXU3JCDb0ef2k69l56U+85MeHI3pus95EK44MkNclbiX
         PQeyUAZlfi9pSLivq61JkupJVZpYpgX4bRzg7A0laxZRL0Z0/JnKqWvE/IZsp+o1Qe/4
         lO44KA1UKpLfZdQFAp+Tp6hcdcXQvT9NsJoZPvXyXauT8VRMrhusvyDur1pC447a8NHd
         JgRWW/scIOZfz0zoqvgWz23zPwg/e5R/CxQU14wappN4lBpzcEp+2WtuTI70etf7F9Eb
         ZaaA==
X-Gm-Message-State: AOJu0YzdbotyhNWixNHu84n9xLnxQTzk5VE8C3yVwgCJOFZSJoyIQzNK
	0rp5hSR5PD66Do7eZKwec2IbdEJKSye/BXpkGzAFW72Eicz/2XDH31IDn/wgvaU4STY=
X-Gm-Gg: ATEYQzz6Ds0bqutxhHmnN4yKCzH8b+KYG54Kk04LSH5NTX1Xxyfp046+sJKhJfKfmWC
	Spx2Z6ssKAkWh8y5+yyAGmP1ACB2lhYJjO7HvcGVzWxMArzAQUGjBTgjOxJcNyL7XwgylQP0CBO
	nlLmDDjqaOyzVpQzmw7UMeKqFAClrl7vqhwnd7qrJMD1AaC01s28+qHO6ocIn8kYQSq0gUJ4Sxp
	fCjPhjklgHKH1s8SSS9au6z/s7dgfBUvSOxsqEPlRqz/mZSTWpKcbJhokSybk7hSmN3edfgdeJ0
	3s+jXL+ZlAFP3WG9Qt6B6zcN/l6uUnYLmZjzX0eUJlDMzLUhUfTfNkVQFXWDvKqwEdED1eStTd3
	k37K3oTEadEVhcPbb12vhyq4vJlfAWksflkFLmsbPA/YvBzsP7OHqPy5HKdX1ZlEwVIn50S8wvY
	w9HnhOII07hEV4VvwS4Gls92Wq6AXFdRij+i6V8Jl4e4RFubxdZ+DBHobHYhH3
X-Received: by 2002:a05:6a00:3385:b0:827:3e27:161f with SMTP id d2e1a72fcca58-829f6e7b82bmr1986418b3a.2.1773226724870;
        Wed, 11 Mar 2026 03:58:44 -0700 (PDT)
Received: from localhost.localdomain ([14.139.107.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f703a865sm2057998b3a.64.2026.03.11.03.58.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 03:58:44 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH] t3200: replace hardcoded null OID with $ZERO_OID
Date: Wed, 11 Mar 2026 16:28:10 +0530
Message-ID: <20260311105829.60508-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taking into consideration the SHA-256 transition, the test suite must
be updated to support the length of the underlying hash algorithm.
Tests that rely on hardcoded 40-character strings to represent the
null object ID will fail when run in a SHA-256 environment, which
expects a 64-character hash.

Replace the hardcoded 40-zero string in the 'git branch --merged' test
with the '$ZERO_OID' variable which is provided by the test framework.
This ensures the test dynamically adapts to the correct null OID
length and functions correctly regardless of the active hash
algorithm.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c58e505c43..ed317a75f5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1494,7 +1494,7 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
 '
 
 test_expect_success '--merged catches invalid object names' '
-	test_must_fail git branch --merged 0000000000000000000000000000000000000000
+	test_must_fail git branch --merged $ZERO_OID
 '
 
 test_expect_success '--list during rebase' '
-- 
2.51.2

