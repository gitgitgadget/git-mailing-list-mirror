Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337C38B990
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748925; cv=none; b=bf8CAc9nIXgv5b4NSKVKfkqT7+118/DrP1RkDOkfoUK6RMu1ZTSMVeP2p6Qbpjo6QljrKrWtGudfIuLHv8tdDjKCzHurEKx/wLmlyYOQvZxxCPJNgZEgRsDBpU8IHhusi47rXhFsXyJklXzhCLVearPRKxSNiEE3M3hbX61Zu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748925; c=relaxed/simple;
	bh=2I+bl2Tv1QpkavV5dOcIxtmI88E6Pb9jVjWzf8WkJhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFTzD3AK4kCGRDrRWZZ8chNhuzWv2G5K4sp7jY0ARpnEiZVCSVq1udA6MgYmnrYOLgKbGfVXigTZLdDbeCxSk+C7pbKQf8kRwlwbdBYHP/DQOfmN5Pez1Dund2k/5z6IwZhxdnWu64i3VfD6epCYlTTj1S88BuuhsctzZmWWgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRPWc0tJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRPWc0tJ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354a7b089bbso3570379a91.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770748924; x=1771353724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nwY8HpQ0ZOPmqaSDlD6xPIIhrz1y8zX1viZUMblevw=;
        b=mRPWc0tJ37RhV+XsiFSr8XtRyBGqvm2OEmz7A1f5kWzPmsBCBw8eS5vFpjvTPPkggJ
         jasl3Rk+HI8EheIi935dJRRjNsborUS1S1A9DdFLGQcNxwMWG9AUldpTBVuB4j/RKa8T
         7agz3WVi01zFcdslpOc6gHOPBKwwdPUmY6wy8sBcENzk+4y2ezmS22FvR9qlAO0rsMjM
         jFfPQK2gUu8aWoHAnuiSNxwpPj6G7z45zzuUuoaL1WrledFPt+uyH88L0/C090GZKPvS
         jBa1Bz1qzSO8DMH/cRUwwHiPfTtTc9iZP6NCyjFVpxEN4jKEH/GjV1trcO1i4IGOmgTj
         ixgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770748924; x=1771353724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nwY8HpQ0ZOPmqaSDlD6xPIIhrz1y8zX1viZUMblevw=;
        b=IqV9jNcSl+kxPfPxA01SaGxa8yvrBXKm4dclTnLi52iJC8PecAYFYJb/DVKeUdm7f8
         MCdA7FX+lJG5B5kFRnVh6bLrYcfPRQGZmMEoZqBqHfTla1nFKnklp8QTnJ+iWYJbIa/i
         v1q0WnoJC71t0nmiWHU46y7dza3mFNYaPdLBkPjWef/p8hgDa98CzuWhKZyDUdfPTvwz
         fFRrwz8LZyupzNF5zeF+1OUdK1Nj3e6xkWwqHx1qi+VZdPNo9LiWCvv2kmog8xWuHrZo
         bN+5st0JYfj8ymKZHHAU3pbPFs+JFTI+ETExzTYy9FLBnGYRxfLjPbw2OQQV3LkAKTSY
         HelQ==
X-Gm-Message-State: AOJu0Yw2oVTj9sGWuYeT3VZtU68wELNp5zeOv5OlTXdwnyoELxFl4pou
	up14zD8IUpf1UTTMv2AqgAL0TMLVSrreJsAoB8g6T/508be9Nt1zb0j2
X-Gm-Gg: AZuq6aJ5m8gSvY8ixXH92ZS0ggr7CbbdBkCuvngMQPAjipP61PCxS5+yEd19CKY20zY
	ppQKyEBELtRpXTeU1Zubr1t/KrhwAg+Le8USUnsw30CfKkLBKmgO/iK6Z3XECqgiKmYHUP1UXzt
	VxINHaItO+SLxNQSizXazySDwfNGrQVvRfCnADHrDCpEob7wr+lYoymG477CS0kY2CgWv7TSgti
	PTEHeX++Avx/OCvDvwbhEc+zz2HWsEvowJLHixJCJnOXuJb/F6tgFw51r2wkFkexsfFqTo0i0Ma
	6JYsO6McHY1tK0//Hq8HoCvLc99kUA+TvfjqhVmjZ+Ow4JFlQS01C5Geyy14zKkK+jeNSVd6RLA
	rhcRJPXNi4F/Vzel7lhuJYe9wfjPMnvc4RkaA3B/MDTBGZ1oBBP8KLgIR7+SWCMQQYjfbcq0LgW
	ZYL6/2JEKc1nThiHU1Ifxscsum5/CxBGI3TkkUPaECeVmKWeXRt66hDO5GlKjUyEnEKI1m8kKAk
	Fs13uNIPsXmSYCGR9LA4OaLHdwsk38eBhlbgSbEghZqE/rtS99ikF6MMlnXO/t9KwBUDhU3obO7
	TlifNGRAyNZchgUCPwI=
X-Received: by 2002:a17:90b:3505:b0:341:c964:126c with SMTP id 98e67ed59e1d1-354b3d086f9mr11573707a91.34.1770748924200;
        Tue, 10 Feb 2026 10:42:04 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:100c:822b:c98b:6ad:2fbf:bfff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e6cc17sm3629219a91.5.2026.02.10.10.42.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 10:42:03 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: valusoutrik@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [GSOC PATCH v2] t7003: modernize path existence checks using test helpers
Date: Wed, 11 Feb 2026 00:11:56 +0530
Message-ID: <20260210184156.50363-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210181445.49380-1-valusoutrik@gmail.com>
References: <20260210181445.49380-1-valusoutrik@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'test -f' and 'test -d' with Git's path
helpers. Strengthen the '! test -d dir' and
'! test -d diroh/dir' tests.

Checking the test setup before test 12 confirms
that there are no expected non directories named
'dir' or 'diroh/dir'

Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
---
v2:
Address feedback from Junio C Hamano 
Acknowledge that the rewritten tests are stricter
---
 t/t7003-filter-branch.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 5ab4d41ee7..c475769858 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -92,8 +92,8 @@ test_expect_success 'rewrite, renaming a specific file' '
 
 test_expect_success 'test that the file was renamed' '
 	test D = "$(git show HEAD:doh --)" &&
-	! test -f D.t &&
-	test -f doh &&
+	test_path_is_missing D.t &&
+	test_path_is_file doh &&
 	test D = "$(cat doh)"
 '
 
@@ -103,10 +103,10 @@ test_expect_success 'rewrite, renaming a specific directory' '
 
 test_expect_success 'test that the directory was renamed' '
 	test dir/D = "$(git show HEAD:diroh/D.t --)" &&
-	! test -d dir &&
-	test -d diroh &&
-	! test -d diroh/dir &&
-	test -f diroh/D.t &&
+	test_path_is_missing dir &&
+	test_path_is_dir diroh &&
+	test_path_is_missing diroh/dir &&
+	test_path_is_file diroh/D.t &&
 	test dir/D = "$(cat diroh/D.t)"
 '
 
-- 
2.52.0

