Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9327EFEE
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936226; cv=none; b=adl4CuC+v2DO2HgXRfckGYb86bpm+OLTtlETuNWnq5KC4bdHEnKMqTssT43UmQ18GiQ41fMy7wXEVIAienO3H3v+FeOS5f1GGyG1GumnOClw1Q1Sea7yYASJIYeLjQnleAx+CMfYE8M3/xxFRJ/uFJRQjJExUj6j6/ZgqgVXpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936226; c=relaxed/simple;
	bh=wDlfjBiD+WLzeCVgR7Kq2XBFkFWVW/uSYkyHTynTa1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWVpUs0pbVxfN0isF/TuOP/+AVpnZR2Q0ulZVBVAxYacmW4wUx77Bl7sqT7FFwNd5lPkGug7frjrpPRE8VbdgSJAjiRC3ZYgIGrgFN6tdnIGLSNP3d1DUtHP+ThgkfTny2uK494Bm7/Mqq/sX8Y1Vp4qEv0puYp2c5HGK4ZWvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPT5Nfok; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPT5Nfok"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b49819938so596765f8f.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773936223; x=1774541023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F81intB9d0hqyJ0+5nRSDe6zmTFbaBHACejR093+QL8=;
        b=VPT5NfokrXUgjNC3Ociy0ZJyZIaA6QxIySmINllIoTCt983cHobmTnwH1qUEvq5Qlo
         cUGYWQKKQ597to9foBJq5Xl3kp87EH44OJ+syvJ3togSHFDVFJ8BHkJX7JAPRXc617qf
         IsC9S9E1DREK8Q3gE0iIa+enTsBCkPHdJyXFVLbEpRImwKbdQuVuTIywa5A4iDNiGtU+
         xzwQl3pWXxl8CGpKIjB3skwDFy4m5nVgOy7JAr/7hDS+8zXjHHAnMCkn8i3TObBDTUc0
         xJRkq+8u9tiq61ZrIkH0AahewDDrwZe97fdAICfk0jU9JcsRSttYLy8F307pVkq7Md39
         P9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936223; x=1774541023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F81intB9d0hqyJ0+5nRSDe6zmTFbaBHACejR093+QL8=;
        b=nt2EonmI4gIBM+pRVmSI09QVIQnb3d06e6cIDs6gLv7Ce0TRjMhlZG3ZNVngOh4cE9
         4C3pQ9WThy7HHNVNiVYRowS+m/yGTcBbPI4nIYwvR3jenaszXFIuBR5i2LD//qq9voFq
         99Wq5I25MCtubAtLsAE6eF3fvfTwYRg8ibF3BcEoWRrDka407KVyQDViT3TGcnt6tH8u
         Q57+dG9cKZba8icXXxIHI7harQG5yYdPRMmOZhq3UOMWqv6DI+Cea0j3QL1WH8qgYkBe
         bOG5oDf7zx/bYjlm9xnaCKRZlOzOmE1seVpDFEb4Gj0YwbBc4qYEDXN1+SD+2oIZ7vo2
         KSCA==
X-Gm-Message-State: AOJu0YwcBpag7rL+0YHC+bZPBBlZC/SrudeqvRzkBWJRyxOCECgfBfTA
	B6mb/mRDSycWKgejr9VlrYRkzQEgvLTEq66/N50lq5BscBdMcNk9gbZALEi+IUJvpN+Zsg==
X-Gm-Gg: ATEYQzyzgxRmsZGzGF4snw/25l2jRmvi6TRr1UoxL4ZqaGXPn6/G+XUEmp7OT17eTQS
	FsnCzA4KTpHH8h0RrzJ/qz0GqnPekAOlGVBnCkLLJY//VU5hRFE9/1ljyPjFzFtYePMR4R0yr4q
	pRRlVCuIzIaMihMTRsDpy0hi2vHrrbulabd9vL9cgx4UatTCeie8Ddg7YSWTCXFhKA2EISMNDIC
	RFBBhXNFVF8RAhfHTVCI0kIreC0kKhGOals2He4HbZnElOZQpfhGZlGd9DBWOl26l1FS3Yhkflc
	N1hiJw8+8dNycy5soPb707Tf7l0j4O0fZLNfYWR+QNMflMhfwvq2ExdMKDrYcrhKKFraAgVP52S
	2v4yf40O+hZ7iiOCGGHqTMIQw9l4CYVGJXcvtbZ1ehAfhoNqTpEEdyTPH2n2I5HCnuF+lQuOZ0w
	f+7IeGr4B/x0h5TBqiWcKIzoB51/zNXMG67CdRvQ==
X-Received: by 2002:a05:600c:a312:b0:486:fbf6:abd4 with SMTP id 5b1f17b1804b1-486fbf6af04mr32051605e9.9.1773936222633;
        Thu, 19 Mar 2026 09:03:42 -0700 (PDT)
Received: from pluton.example.com ([105.72.248.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a2cd3sm15107456f8f.32.2026.03.19.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:03:42 -0700 (PDT)
From: Bilal El Khatabi <elkhatabibilal@gmail.com>
To: git@vger.kernel.org
Cc: bilalobe <elkhatabibilal@gmail.com>
Subject: [PATCH] t5315: use test_path_is_file for loose-object check
Date: Thu, 19 Mar 2026 16:02:49 +0000
Message-ID: <20260319160301.98039-1-elkhatabibilal@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bilalobe <elkhatabibilal@gmail.com>

Replace an assertion-style `test -f` check with `test_path_is_file`
in `t/t5315-pack-objects-compression.sh`.

This aligns the test with the path-checking helpers used in Git's test
suite.

Found with:
  git grep "test -[efd]" t/

Signed-off-by: bilalobe <elkhatabibilal@gmail.com>
---
 t/t5315-pack-objects-compression.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index 8bacd96275..d0feab17b4 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -10,7 +10,7 @@ test_expect_success setup '
 	# make sure it resulted in a loose object
 	ob=$(sed -e "s/\(..\).*/\1/" object-name) &&
 	ject=$(sed -e "s/..\(.*\)/\1/" object-name) &&
-	test -f .git/objects/$ob/$ject
+	test_path_is_file .git/objects/$ob/$ject
 '
 
 while read expect config
-- 
2.53.0

