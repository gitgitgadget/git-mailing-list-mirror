Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859321F94D
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 00:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652508; cv=none; b=LMSDoJGUlX20U9HhZlVpbAYN9Qn6BtRG/gsJOgeIChNcJVnQpvvI9C/NEJ2y05GNf7CS0sKEQAdKbQwlwHVmzNPC7USmhDbIXZQxzABR6XqsKliV8/S5hvum9ZvI4MAFJ9D+3CJ8vkLPcdJtiUx0CLKz2hOFGBUnewUBpGqU0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652508; c=relaxed/simple;
	bh=E2BTh9J/3fLoe61TrDmsBaNBaPsgtAw0ivPxqSHKaV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evf6wjgEiK72AHvMvMdrJxv1Ue+ba81dP4i4LBaEex9fa6y76zCA4+43RagbGaaIkpAUswvi/plW98J6dcYbn+54PLkSAt2zEt0gD679D/I8YoEjQ0xC1H6Xpv0kq2RD3sUUJYzk1zkDw5lcHE8WXa8yW727W6bL6BDqW2Y+QnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VljFiNvH; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VljFiNvH"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6feafc707d3so44708007b3.1
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741652505; x=1742257305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aB6R3MdIjco38Q32KvdILS92+wJPJL0WX+D9nqzdEI=;
        b=VljFiNvHg5/olpo2aEvZ5CaCQdUw+RTzYKM6S0eFX9ONcabDsxwxa4c3u6XzphQv1U
         sYnDAKyrud8eLU+KiU+WfLpru43getVgYEJuLqQTeCE4fdeepV/qbaaBDDQP8JQHFBBm
         m9oopmtd802YWtjurAvkJ7qMyXebf6D8StXLaJweW3ng67ag8v46beAtOj57eZO6CHMo
         wXCIoMDeCi0g98ASi1ICFAlWiDgBQJ4MSskmoQn0HnYLJlTybKj06h9Y0sK63K2LWmAv
         dgtKF3e/nFNPQbxZVVNi2YsXZGeBU4PDY2Xh5aF9z6VlQK6+CnpF6Z4rX1Xqd2ormjqy
         WVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652505; x=1742257305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aB6R3MdIjco38Q32KvdILS92+wJPJL0WX+D9nqzdEI=;
        b=tyobyHiUW2n+7h3oiSiYaf8gBErqHSoir3yRRu+NpZw5H5UtOOPe/7ROzlPUbIGELC
         67DwsCEkMxTipP5JqoXfWSvvM9LRW8pcHAicZ0m2uoccNWTA3RXUsSRP2mYK/CM8LE0m
         rP8r2mrN2kUa7Z1YU2kkLwtHXhB+UUlePClOxXuva0heCF7rHUg3iSfINGoTOg3ZbTUw
         LO8lZdC67VZwd1KjZrtetEW1lDUQfvhnOfJWdXGJ0AF+WZqv7YHFE4eVCObP03/FffXh
         Yk/FC++t/RVUS0NWwFzOV965neLBNOl9FGmToYYeWX9I1FJS8ihn5/KYcGg4TYZDaIK/
         Hjkg==
X-Gm-Message-State: AOJu0YwAneR/daFeSNqxfgQ7KldxSkyXZVDadpHjVdZdyuKvlN1FjdBT
	nV/rEmAEqIQ7VYENIw65n5dZBmd2DGpUPosBTMTjezlKJyxG/iKeh8uKtywa/NJkcHHc5LCcgJU
	gztE=
X-Gm-Gg: ASbGnctgrSbZDNy2PA7erXiTXgN30zxOO70HOCXH7j5FLRCMsDvmwj+ca7om98H4IA8
	VgO2GojY3boMVyrzWLgf30KAbjwO6h8PcTHlPhShirP3nsH+nDfkWJsuo4d24uqYpZS0kvUusfp
	dajIZK1NpfVzNfWB+mQS4cA/L44U7laRKte30xmqFbFK2SkI8zoiKR1JUGH0YA+ZC+yWgUYXmr3
	nplC3phDd0+68W54PbXjmgJeHbyQDgz15DuUogN/1SVMbMVOEIc059lxYuZvDIPBwpwdOCyHXTV
	hmqEoRIKjPzWaAoOVe8/77tfHfCCyXQuYwRcG6AkmNVXv5VHckdsJU7aY2pBHHSgQM8kEj1hxLH
	Mrp9hX4hxlGK5RLQXUipN8Kz8Dwk=
X-Google-Smtp-Source: AGHT+IF8aZ/rBp79O0LMe1H+1Hj+GaOiq/Dqygk20ycQAMHAy19iv9yAj18/xh4YG5nZp89xshCUIA==
X-Received: by 2002:a05:690c:6f87:b0:6fb:b8a1:d3bb with SMTP id 00721157ae682-6ff091ecd50mr30524677b3.17.1741652505272;
        Mon, 10 Mar 2025 17:21:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c64b57sm24150967b3.119.2025.03.10.17.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:21:45 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:21:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/6] t/lib-cruft.sh: extract some cruft-related helpers
Message-ID: <aa7588f8176b7e699005680697746ba5dcf75005.1741648467.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741648467.git.me@ttaylorr.com>

The test script in t7704-repack-cruft.sh uses a handful of helpers to
generate and pack random blobs, but a forthcoming test in t5329 will
want to make use of generate_random_blob().

Instead of rewriting that function, move it (and the related helpers) to
its own reusable library to avoid duplicating the function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/lib-cruft.sh          | 23 +++++++++++++++++++++++
 t/t7704-repack-cruft.sh | 22 +---------------------
 2 files changed, 24 insertions(+), 21 deletions(-)
 create mode 100644 t/lib-cruft.sh

diff --git a/t/lib-cruft.sh b/t/lib-cruft.sh
new file mode 100644
index 0000000000..9fdc0b01b0
--- /dev/null
+++ b/t/lib-cruft.sh
@@ -0,0 +1,23 @@
+# generate_random_blob <seed-string> [<size>]
+generate_random_blob () {
+	test-tool genrandom "$@" >blob &&
+	git hash-object -w -t blob blob &&
+	rm blob
+}
+
+# pack_random_blob <seed-string> [<size>]
+pack_random_blob () {
+	generate_random_blob "$@" &&
+	git repack -d -q >/dev/null
+}
+
+# generate_cruft_pack <seed-string> [<size>]
+generate_cruft_pack () {
+	pack_random_blob "$@" >/dev/null &&
+
+	ls $packdir/pack-*.pack | xargs -n 1 basename >in &&
+	pack="$(git pack-objects --cruft $packdir/pack <in)" &&
+	git prune-packed &&
+
+	echo "$packdir/pack-$pack.mtimes"
+}
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 5ce2648a29..88c6ce2913 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -3,6 +3,7 @@
 test_description='git repack works correctly'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-cruft.sh
 
 objdir=.git/objects
 packdir=$objdir/pack
@@ -128,27 +129,6 @@ test_expect_success '--expire-to stores pruned objects (5.minutes.ago)' '
 	)
 '
 
-generate_random_blob() {
-	test-tool genrandom "$@" >blob &&
-	git hash-object -w -t blob blob &&
-	rm blob
-}
-
-pack_random_blob () {
-	generate_random_blob "$@" &&
-	git repack -d -q >/dev/null
-}
-
-generate_cruft_pack () {
-	pack_random_blob "$@" >/dev/null &&
-
-	ls $packdir/pack-*.pack | xargs -n 1 basename >in &&
-	pack="$(git pack-objects --cruft $packdir/pack <in)" &&
-	git prune-packed &&
-
-	echo "$packdir/pack-$pack.mtimes"
-}
-
 test_expect_success '--max-cruft-size creates new packs when above threshold' '
 	git init max-cruft-size-large &&
 	(
-- 
2.49.0.rc2.6.g9a1eecd400

