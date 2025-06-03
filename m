Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D71798F
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748928741; cv=none; b=mSBqQaBpES/zcNS2Y7MeK8Ohk9H5TmmExWsepTRbS96tIsZdU26fkh6aCVMKUtWGETeIxy0oSOOEgxHF8Au6ZvoS02Ai1UZUHQPcbcpOvuDaKZ73J6TOssQpEeVya8biuqNx1Wx1dNqKgtFAooMI5msHh7KkUF+/rVSzlMtVAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748928741; c=relaxed/simple;
	bh=fcFPcsRVVM+APItoNwsklWGykFJN2i3VaxeSwdaH+JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ka4gNBdR6ec/p5srjHX9P1PU50569pCoIiKrVywDWBbkle5bQ+PPSVAFKcvMDtnP+NYSpSphy02wdAADgRqcIs8OxruYDqJ7dgpJeQIlxLC28olRQeVAcVhT2aDSW81lra4EygpkpcqwnXTNZBnzUe8HlGX1QAr1hf04uKD9MCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9vztKTj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9vztKTj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e16234307so42848435ad.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748928739; x=1749533539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qhqCQQ3ZOQHFxdNTwIh8IdBSFvfTZ0n4tr4VwB3DBQ=;
        b=k9vztKTjj1UjZudiM6VdNtNVIYGDQrvpvqn6Vy7TAt+HSzXT/30xe6O52LRsyrd3T+
         b3CbNWSZQt9CRYIB63mCSPGRyzJf2m8/M/XcalhTVsN/e3OoYxTzRAHJjsqe6tIaFD96
         5dSea/mWTxkOewxzmp1Bk0zhfO7R2ZulcRWw5Xyz1rKKNcEHw899kXixxR4TsS5mwHMm
         WGxLmwr1/W9k6QC0HlCFb8n55KOBd/2wH9SO8iv73oUttVnlhtNO03DRuhBQpipJPuDR
         Lkv/hs5VWiIbnUHCmrcB/rOZOdyxIljjALzkYWhFaJvVi0vCLbl8h19/Q9xkxvw+JJoi
         sQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748928739; x=1749533539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qhqCQQ3ZOQHFxdNTwIh8IdBSFvfTZ0n4tr4VwB3DBQ=;
        b=XCbRGaJ816x0hkqVFjhbpl2rsZ4h59c/mZOUG2/KVzKkgbO/z3xLd2GR3nG09JI58x
         IzXZzeHYqy3OIXgpLf3nvf0wBxRdEla0iV8aBf2OoGiRf6t2/LLViExYKCP15q9pu/SR
         QWQhsvWuoHpfDgQ+gAO8pz3+g9IEwkLRwiheuqhvdlnYE1qk2hNHfdj3AJ8qiG0fGStM
         3KhntzxVc1M778F++8ROZ8RjeyT+aiBTvVw9e+cjOwtSaG0imkQJFQCKSY7I+daF8JKt
         Wfep9oMFjo90Ypv4R98YqRbyH6gl8xrBdtCzrUFbKgoZoXdTKzWTzc4ePc7lM+SVT2C+
         8lyw==
X-Gm-Message-State: AOJu0YwTfCaHdwatq8mVe4OsPjncVNMWO/SFRgrHUCs76rQz6Ay0eaYq
	uevpals3D0IcyoL3pa6DVKpjW/w2DjJSrThAoIdo2vYxU8c4hD48+r5Da0voEA==
X-Gm-Gg: ASbGncsGaHBrueGzvqn1ceTsHpCeyBNOYByFt6oheUDpVfn4FiQBhuplOBJquZ5RINE
	RWlSsaHqXUJSp+jECIeBgMmEfQ3i2fUl3RYfxLI96B8FJeqyZXzqyznBnJXSH5LSsDH+w+VQlYv
	on4sDzaynIKOlIQ9VvfWwZcvG62XmHqlww5OS2M2pwQCb0KfuRlKBgZxIBqpscExVc+U2wOoztB
	Cf1R2P/VghcKfpsQ0OAhWEXsFNkwnkiJFg3GJ9AAc9mUbFw5FLH0/prI3ShdSUOed7+eXwTkCdn
	/rAUqC6gjZrQXqzHV2u5oPaOu399FsfRZB6XRzrtd8pLZ0X9zkIfn6X88b+ZdsM=
X-Google-Smtp-Source: AGHT+IFtLgisdLzJnQtN3xriG31/IFDSdyhTstbCaEYPDbdHW6etuKGBXA4sU/Fd74aO4NSuR8VZMg==
X-Received: by 2002:a17:902:e809:b0:231:fd73:f8e5 with SMTP id d9443c01a7336-235c9dcecebmr16926865ad.24.1748928738662;
        Mon, 02 Jun 2025 22:32:18 -0700 (PDT)
Received: from dwmfdoom ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdc5f2sm79630075ad.96.2025.06.02.22.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 22:32:18 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: git@vger.kernel.org
Cc: DerickWMFrias <derick.william.moraes@gmail.com>
Subject: [PATCH] t0200: replace 'test -d' with 'test_path_is_dir' and 'test -f' with 'test_path_is_file'
Date: Tue,  3 Jun 2025 02:20:28 -0300
Message-ID: <20250603053137.66249-1-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.49.0.634.g8613c2bb6c.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: DerickWMFrias <derick.william.moraes@gmail.com>

'test_path_is_file' and 'test_path_is_dir' are modern path checking
methods in Git's development.

This patch replaces old 'test -d' and 'test -f' methods with them.

Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
---
 t/t0200-gettext-basic.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8853d8afb9..89d0899a5b 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -31,12 +31,12 @@ test_expect_success 'xgettext sanity: Comment extraction with --add-comments sto
 '
 
 test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease' '
-    test -d "$TEXTDOMAINDIR" &&
+    test_path_is_dir "$TEXTDOMAINDIR" &&
     test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
 '
 
 test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
-    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+    test_path_is_file "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
 '
 
 # TODO: When we have more locales, generalize this to test them
-- 
2.49.0.634.g8613c2bb6c.dirty

