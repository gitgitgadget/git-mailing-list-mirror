Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3909249E3
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173423; cv=none; b=BC9hKYJo0sQeH6LmGmGqfawpdJMjvbBRfQJKyTbNg9fTZhIWmS7QBRxuzMgae4XKRTo3lKg/rLUvZBKDXvGfguAc/+FbBESqIit/q5ZTDjjirvayN9E+Wes1e+jh98/Z034f6/3OkDZ7Vz5UDkN+P3OtA4U0m+ZxVKsRYa8UE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173423; c=relaxed/simple;
	bh=DM2kyQ9Ko6xEq6koqnpK8rjCQIcW68B96vSxNKBZlpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv8sh05g5w9/UaqdU95uavvABGjczYmMKL88/E2nJjsXhYoDZgVyNa+42khFSGM3/bF2xfXalIlLG8IVgAmSi0+VGdcJrzk2wFDelXSlZjqqX+pfoWiPuIFFTPDaYh46KGxM7wvnsn8adweSXj/rzEwc0pcLlpHzGnJwDtxrJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0Iol4PDz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0Iol4PDz"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42bfef4912aso19920901cf.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1707173420; x=1707778220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FI3LAOvYHzHyxDRC4iIIqq4s4gt0BbiavrkzdmQvii4=;
        b=0Iol4PDzsjuoAnB/MY/gRMqsZVtkJpJ37uuOAm7RfMsv1W75PXI7BclD/XG7kG7mEG
         Ntrc2NYgg2uehG1yXiRwynv9DnKKy0Jv5AGIk7wfshGTN06aseBXLwQKBsYiJTWpta5G
         GsDItR4V2TMTECCAdNB+UtI92QFIOp6qcpJ9ws6crn3Bi8l8xn95G90sff+r5/AyENbj
         v51aNmRY/btPqg9Id5upeNuZCxiVV6960uOcv3397MQEz54/+pZT36pannJaMV/5N7ed
         UVJ6JV9n3mULIo9w8QpfTnXddO6TSQ9h84nyfmzkore9tf7Mfs1Cj5ZcarUEBNrAZ0p6
         q6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173420; x=1707778220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI3LAOvYHzHyxDRC4iIIqq4s4gt0BbiavrkzdmQvii4=;
        b=aAYNHrowptXAwc16tbbuTR4JOSe40YqdJ3PXEGUwvNZIi8hNJ461OBk9tTrWZrVoc5
         jVBwnSeNPgMpEi+wumUqCOA/B5FG6kGuwEi3JyDEc9+aGlvhmoMREDLXOwzz6WAISqge
         4teM7BOQWvbJnvgTbpgo4Z0jCangkBPSxFMee5LhcvVzuKfkitEXE3uDV02aYQUJojwC
         GU3LqnGSIYHCRAcxO15+WpwB6A3h4aoRUbcYS62etS6HPMkdnvvAD5GjPPLJnlmyBHCe
         7KUT4Y06YpTZKabXvdZ3DNUDIyfoddAXEDLMPApU5mLG4n/a7sLz+o12olPCC6NNMSji
         cjzQ==
X-Gm-Message-State: AOJu0YwGl4TsQHLQVJGuVSSRMyNt9+pnre5V4Dnzq/AhkHAmM9TymqOS
	fQMnsvMAsuRx6gUywHor0Gx4BbWqTu9izPqDdYWLsV7phHiokijupr3Ha9ph40a/CPs2PSGDRFJ
	zcxY=
X-Google-Smtp-Source: AGHT+IFhtZNidfg94twT67z18VoCuCbo8vEVpbrIkV3Lt7bRJO6uG1CZOG2AjVE/CzMbEY0rLSusoA==
X-Received: by 2002:ac8:5791:0:b0:42c:1170:1cf0 with SMTP id v17-20020ac85791000000b0042c11701cf0mr1132623qta.2.1707173420467;
        Mon, 05 Feb 2024 14:50:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWaU5mY8wxxSiNdul/QyvOKuil+sHNQL3RqwnFr3ZKKnMyYXDuASQ2+XB4sZfln81RW6wHIAPa6wpdr2ZueZNUXC2d9NilDV+4vIsGd
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k9-20020ac80749000000b0042aaa547509sm361963qth.27.2024.02.05.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:50:20 -0800 (PST)
Date: Mon, 5 Feb 2024 17:50:19 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <pk@pks.im>
Subject: [PATCH v2 1/2] t5332-multi-pack-reuse.sh: extract pack-objects
 helper functions
Message-ID: <db3d67bfa38bf3141214619e766d39dc7f709812.1707173415.git.me@ttaylorr.com>
References: <cover.1705431816.git.me@ttaylorr.com>
 <cover.1707173415.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1707173415.git.me@ttaylorr.com>

Most of the tests in t5332 perform some setup before repeating a common
refrain that looks like:

    : >trace2.txt &&
    GIT_TRACE2_EVENT="$PWD/trace2.txt" \
      git pack-objects --stdout --revs --all >/dev/null &&

    test_pack_reused $objects_nr <trace2.txt &&
    test_packs_reused $packs_nr <trace2.txt

The next commit will add more tests which repeat the above refrain.
Avoid duplicating this invocation even further and prepare for the
following commit by wrapping the above in a helper function called
`test_pack_objects_reused_all()`.

Introduce another similar function `test_pack_objects_reused`, which
expects to read a list of revisions over stdin for tests which need more
fine-grained control of the contents of the pack they generate.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5332-multi-pack-reuse.sh | 71 +++++++++++++++----------------------
 1 file changed, 29 insertions(+), 42 deletions(-)

diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 2ba788b042..d516062f84 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -23,6 +23,27 @@ pack_position () {
 	grep "$1" objects | cut -d" " -f1
 }
 
+# test_pack_objects_reused_all <pack-reused> <packs-reused>
+test_pack_objects_reused_all () {
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all --delta-base-offset \
+		>/dev/null &&
+
+	test_pack_reused "$1" <trace2.txt &&
+	test_packs_reused "$2" <trace2.txt
+}
+
+# test_pack_objects_reused <pack-reused> <packs-reused>
+test_pack_objects_reused () {
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs >/dev/null &&
+
+	test_pack_reused "$1" <trace2.txt &&
+	test_packs_reused "$2" <trace2.txt
+}
+
 test_expect_success 'preferred pack is reused for single-pack reuse' '
 	test_config pack.allowPackReuse single &&
 
@@ -34,14 +55,10 @@ test_expect_success 'preferred pack is reused for single-pack reuse' '
 
 	git multi-pack-index write --bitmap &&
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs --all >/dev/null &&
-
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused_all 3 1
 '
 
+
 test_expect_success 'enable multi-pack reuse' '
 	git config pack.allowPackReuse multi
 '
@@ -57,21 +74,11 @@ test_expect_success 'reuse all objects from subset of bitmapped packs' '
 	^$(git rev-parse A)
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs <in >/dev/null &&
-
-	test_pack_reused 6 <trace2.txt &&
-	test_packs_reused 2 <trace2.txt
+	test_pack_objects_reused 6 2 <in
 '
 
 test_expect_success 'reuse all objects from all packs' '
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs --all >/dev/null &&
-
-	test_pack_reused 9 <trace2.txt &&
-	test_packs_reused 3 <trace2.txt
+	test_pack_objects_reused_all 9 3
 '
 
 test_expect_success 'reuse objects from first pack with middle gap' '
@@ -104,12 +111,7 @@ test_expect_success 'reuse objects from first pack with middle gap' '
 	^$(git rev-parse D)
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
-
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused 3 1 <in
 '
 
 test_expect_success 'reuse objects from middle pack with middle gap' '
@@ -125,12 +127,7 @@ test_expect_success 'reuse objects from middle pack with middle gap' '
 	^$(git rev-parse D)
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
-
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused 3 1 <in
 '
 
 test_expect_success 'omit delta with uninteresting base (same pack)' '
@@ -160,10 +157,6 @@ test_expect_success 'omit delta with uninteresting base (same pack)' '
 	^$base
 	EOF
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
-
 	# We can only reuse the 3 objects corresponding to "other" from
 	# the latest pack.
 	#
@@ -175,8 +168,7 @@ test_expect_success 'omit delta with uninteresting base (same pack)' '
 	# The remaining objects from the other pack are similarly not
 	# reused because their objects are on the uninteresting side of
 	# the query.
-	test_pack_reused 3 <trace2.txt &&
-	test_packs_reused 1 <trace2.txt
+	test_pack_objects_reused 3 1 <in
 '
 
 test_expect_success 'omit delta from uninteresting base (cross pack)' '
@@ -189,15 +181,10 @@ test_expect_success 'omit delta from uninteresting base (cross pack)' '
 
 	git multi-pack-index write --bitmap --preferred-pack="pack-$P.idx" &&
 
-	: >trace2.txt &&
-	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --delta-base-offset --all >/dev/null &&
-
 	packs_nr="$(find $packdir -type f -name "pack-*.pack" | wc -l)" &&
 	objects_nr="$(git rev-list --count --all --objects)" &&
 
-	test_pack_reused $(($objects_nr - 1)) <trace2.txt &&
-	test_packs_reused $packs_nr <trace2.txt
+	test_pack_objects_reused_all $(($objects_nr - 1)) $packs_nr
 '
 
 test_done
-- 
2.43.0.524.g683ffd154e

