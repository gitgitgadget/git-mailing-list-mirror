Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6833F5BA
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521848; cv=none; b=UJJ+sOQSmiNjmRWin33qlk74f2Azx7VGfRuSdAP4tVRGUS6IYQ3FspftnufEA/5++q7oZ0tlSCSFx0bgJSYFuVqVnYdRrE6MYBWiH10UDRMn1BeJj/YPylCWFh/QHhzwA1qmJrscY0S0jj7AlioMIbpF4OZOHMcB9jPTT3u+IDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521848; c=relaxed/simple;
	bh=BxgWunq8dThtcDEd7X99bglFRzUELzom007B61gAdik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+/5xPlx4GEQdhYVPa4boF43Zp/OIIALde4ApM1vxS2KbPllN8WdMB44UjgTdiAWIGDLl3GcyBKrmatzBpPq/q9YvPSYgJvEhWYQWp0YA69t/p3Y4676oHunLMfvMwraVHNMmFfdAXsPGih2GEAkbTbLnZpheS9QxJ1ix/JqdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyAQJWxM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyAQJWxM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso20411705e9.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521845; x=1777126645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuSR/r6BjDSXKe2Bd6XW9n6McwLcfsjfbQe4zVCOC+g=;
        b=LyAQJWxMIyqNdn0lpeKfx4JS3wwRWlsUqvTg+kXXHcO/vGYxJrnhYHm6z6UKqTAqlU
         TdVryZvb0BYoaqB48DyxO57C4owO9irBdXM+N0P8ai6QgKcWUvN8hDtzBMsXOcMIAxL/
         uVaYDPuQVKqdxkDB73iGa60qPUlyRj/hXrTCP9UVTeW9MTzEXh1Ahp3C14vFcHX5fNy9
         QxCcOF4CT8ug5aKpX9ULoUTBHe3PTQAAi8667VpWXIM4t4zoexfGrU4JkOXkk541oaCs
         nEtFboKG4sonGhSEL2X5Vk05Cz8HkBNCrY4ISj9JWUGEC9pbafp7fRHk0lGJGh+OLfAm
         eULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521845; x=1777126645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuSR/r6BjDSXKe2Bd6XW9n6McwLcfsjfbQe4zVCOC+g=;
        b=nzRtXJ7ewI7ObZy7A7gLUQFDGn9bydZd7szQsHobHrcMUbmBP1iVwzypIwHJt/WENi
         S/iOE786c1sw1rT9WGrbFeDT2sG9cYDgpJ9HaYkioKfcfnjy+kPVuNeEM8CiPjZv8xyI
         hOARjmxAH5U7BvJ+sph3NfIGJJ9Rr+1iw/z3c+dVJXFJyYXO1dP81zmGkYkpUjv53/uM
         jvBzNxKxPYpKaWc5rvzNo66PFcqkl0UdzFrdhVN6LVHRFF2IKnLcZQ0BrhptyA2zK3zV
         7Dehf+2BomwO3KDn9KYVP3tI12vt5pjWACFROO/U3z1ePTyOCnk0GMkHQFQeYpD0A+0k
         4/hw==
X-Gm-Message-State: AOJu0Yxj6RiCCgZwcco+htlk+JjAXjf1z/P7AZnzbh/sZAKJtOCC+vS0
	8g3n1qy8fudgGuQhuZuQQ6J5q46Z5LuU8xnysyf6/LzY8iL3H6Ta+uhRkxb5XQ==
X-Gm-Gg: AeBDietZa9BgGk+/u85L0KXRrvUK7/Qg+i3cH9pPHOZvszJSuw/OPkucuu+M/p0BKD7
	FU+ro2K48Bhm/AuPI4C2eMnAAczcTtHZpMjzp6dJ2vf2T5uf7vl+NQf5+VCCq+GB9aVs9SPfNLa
	Vqy8EInCTEKGKLyxlDHiexFiEMLLvyFdPhlnP6rIlkx7GykR+r0YqhOb5x04jd0NGLulf4MupmL
	fLarQxEM+9qn4tiikxZBNlsXX43ClmSoyLEkCwNsNZ9uyRZVF6kl4W6lzOBRLeSXGUxvH5XJcSo
	T2/Gp028p0aB8AXusgjTgED5bTZOdIG1Hko5t9QVBC7h/B2VL8d9z4MXGAFZSb1nMrSBK+cMqNv
	+vsZxMDbuqOMn6gyekcLR6Xgl/spw+9sOQZab3gk93NW6MGBn7KvbzbSkuCTpQWgdxC8Zu4x2Or
	dQLAHocRgprPypUH0scuCoQpqdXe+wu5IKW+KcK3QCNgFZfHjsGnGaauqxrPZ7MmqF7guED2t7p
	+/b6AEIsiODG5f6yMg=
X-Received: by 2002:a05:600c:a107:b0:489:d1c:d468 with SMTP id 5b1f17b1804b1-4890d1cdaedmr523225e9.31.1776521845357;
        Sat, 18 Apr 2026 07:17:25 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm136005185e9.12.2026.04.18.07.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:17:24 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:17:23 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v6 5/6] t7703: test for promisor file content after
 geometric repack
Message-ID: <e3d717283859c3123893882c40bda2395420d2a4.1776384902.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>

Add test that checks if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a geometric `repack`.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7703-repack-geometric.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 04d5d8fc33..316247a3b9 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -541,4 +541,37 @@ test_expect_success 'geometric repack works with promisor packs' '
 	)
 '
 
+test_expect_success 'check .promisor file content after geometric repack' '
+	test_when_finished rm -rf prom_test &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		# Create 2 packs with 3 objs each, and manually create .promisor files
+		test_commit_bulk -C prom_test --start=1 1 &&  # 3 objects
+		prom1=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/") &&
+		oid1=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid1 ref1" >"$prom1" &&
+		test_commit_bulk -C prom_test --start=2 1 &&  # 3 objects
+		prom2=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/; \|$prom1|d") &&
+		oid2=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid2 ref2" >"$prom2" &&
+
+		# Create 1 pack with 12 objs, and manually create .promisor file
+		test_commit_bulk -C prom_test --start=3 4 &&  # 12 objects
+		prom3=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/; \|$prom1|d; \|$prom2|d") &&
+		oid3=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid3 ref3" >"$prom3" &&
+
+		# Geometric repack, and check if correct
+		git -C prom_test repack --geometric 2 -d &&
+		prom=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/; \|$prom3|d") &&
+		# $prom should have repacked only the first 2 small packs, so it should only
+		# contain the following: "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
+		test_grep "$oid1 ref1 " "$prom" &&
+		test_grep "$oid2 ref2 " "$prom" &&
+		test_grep ! "$oid3 ref3" "$prom"
+	)
+'
+
 test_done
-- 
2.53.0.584.g6b87e8e9dd

