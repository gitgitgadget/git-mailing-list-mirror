Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1825393E
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782082983; cv=none; b=U6bwWa7A27sLMQFZc96re1ccKUo+/NRm+X1OjuEc1BwtLhS+A+V0IT9Dtt7qUC+gsoGIxnWGA5jA0gs/A4YYBgIB+rzv4PMZImO8akcjwE8ZcZI4EMxnmT1x7h0cBNUVWtCaQJHhTRX9ukasb1L2mjHmxG9LsZhX8FXobYKxflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782082983; c=relaxed/simple;
	bh=rmL16Df/IAa/L/Wpic0Oix8If9NP8dsGySqFDdXr2Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDwZVlqBKgCiB5MqOrsaaeHX15IrNe6RpOnbihql5HD/nJuXSf3BJxdr94SKeBLMJxEwm9fhFequPyATchR12GhW4xbb83FFgt2ZTecB08IKdxNNKk6GRvVTMQvuEEtTuAtD60WC2EqYBS/F+murH2XoNBd8i6m0iQj8l1RK648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GwbXETR3; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GwbXETR3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7fd5346b5e2so39332637b3.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782082982; x=1782687782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkko5pioQPuaxW7oJCf7W7amowV65tiRXrbMjRYhMhA=;
        b=GwbXETR3HS1mX3CdWk17PL5pf61w+9f5IHfE/Lc/TI2j8Jc6LBWmt90lqUfU/0cywz
         Vzt4z2aAmczTjuCFiXsZsaj72nyZ0DKx6SOvbrUJnjMlAgPVyfpjADxuuQeEnHiZnYV6
         9PneFC9uAQV27oNk4qGe1AdAdOAFfwPYHhNhqwepFTwsbOO0L5AhSyMDbw2WjqxWrSis
         m6O93gD6DEwhsOf4JqCPS8wvIVnSY14So9k8m4wRDKYp3KUqXTwIMzekRORnzErQRBaq
         4cLKzf1pGjktlbj4Aq+XBkcId+KycstB1wcIHhlBCFTcEjhMz5tcXdUPsbbuIaiulwwL
         hfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782082982; x=1782687782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xkko5pioQPuaxW7oJCf7W7amowV65tiRXrbMjRYhMhA=;
        b=cCy4VfHbef8Sc4cG1QoKuBXAn6Bi8oLfGvfMYBJGOZKL64iQ1GEWC6c6gKH7GJoVLm
         g5ZuDr9LtXiQGZT//aXLJvHxRrr7+eQd17BBiwFX5LqUknVVA8raOjNhhD40JoZ3lzlz
         CgDKXGkC0OP9epaU0Sj6s6zBoGfERvrV12BkA3ExOXsAHyYcPB4u41cAEgNUEcMOnQjK
         gRy3M8B49L17v4XJJL6ld4wMyTlUksp4WIZFGxsVoVLqfhY+w+LIs3tJkpNbMRSlBGqh
         b/uJKhMdQT46kl/9oMV5EPW+tPSMZoIAk+blNpY0jd0boXSkRDrsNFSwBcugiVaSbWch
         /X7A==
X-Gm-Message-State: AOJu0YxKQWI+l171uiCaQzTsDRjEeaxlu+AIzsibgoOGgVrb2Lw6fZQf
	1PHIXX8t28btzR9gwKxFpYgrT0TXeTfgttrx3ux6gYm2B4DabG7XC61EvL5xpOYcXyz8Js3Muc6
	JJXyZ8azfrw==
X-Gm-Gg: AfdE7clf8H63ce5NZ//oFNIFIKWZW6t7LRWt9QtJfhfnqm8izs1cIBrWKlOJrgfc4df
	GcvrksmU8FTMukKIwL2kAOeoTbdU5axcSxe0XUpKA/e+nYosUQv7LvLag4QRDVSm8SmTzdW8sru
	a2oJtZ7rDh6x53502m8n6EUP8moBTzt+u+9IHNMeUz0Jv+pKvedApuExUcFX+mr6CbnaEhh5ZnO
	dejKnhj0+v7M/5Gv/L25DH8pxuEXdSn07D3EVdpGa7AeeAH6+G98v7SAWrn4LA4MSZetIJaMeh8
	QWRxb7IJ3oCK0jNU1QRzT1ts/ZQFJRZEdXI5Q/GtAxkzMmOWEbPetIHK2pXOn7BJOF8qrxGLQAA
	T0hwyvV78qFMh2fYEsLqJBxu3c00kLE5k1sye4UdLMyGeyiP6/E7MjbfVt3euZx0eLJU5Za17un
	TIwoAnuEw6kYufe1nwHgHcfbGhcVGcbUjoI6FobNhcw3qQze/wwzxbUSuqlmPFo49vWg9UBmk6X
	xKXR6f4TqTIRjbKoLY9w0OIt3mHzR9tOsegLS4jiCwjgFb4n8m8MWEMRbvemHRQwrvvFkfmWsIq
	vJBDcA==
X-Received: by 2002:a05:690c:6608:b0:7dc:3d2b:2e94 with SMTP id 00721157ae682-80121629653mr96160717b3.13.1782082981645;
        Sun, 21 Jun 2026 16:03:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c96fdbesm24601747b3.8.2026.06.21.16.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 16:03:01 -0700 (PDT)
Date: Sun, 21 Jun 2026 19:02:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 1/4] t/perf: drop p5311's lookup-table permutation
Message-ID: <b1dbf30ddbe9ecc2c005dc3a33a161774638044e.1782082975.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1782082975.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782082975.git.me@ttaylorr.com>

p5311 measures the cost of serving a fetch from a bitmapped pack and
indexing the resulting pack on the client. Since 761416ef91d
(bitmap-lookup-table: add performance tests for lookup table,
2022-08-14), p5311 effectively runs itself twice: once with the bitmap's
lookup table extension enabled, and again with it disabled.

This comparison has served its useful purpose, as the lookup table is
almost four years old, and the de-facto default in server-side Git
deployments.

A following commit will want to test a different combination (repacking
with and without '--path-walk' instead of the lookup table). Instead of
multiplying the current test count by two again to produce four
variations of `test_fetch_bitmaps()`, drop the lookup table option to
reduce the number of perf tests we run. Retain `test_fetch_bitmaps()`
itself, since we will use this in the future for the new
parameterization.

(As an aside, a future commit outside of this series will adjust the
default value of 'pack.writeBitmapLookupTable' to "true", matching the
de-facto norm for deployments where the existence of bitmap lookup
tables is meaningful. Punt on that to a later series and instead make
the minimal change for now.)

Suggested-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5311-pack-bitmaps-fetch.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 047efb995d6..5bea5c64e7b 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -12,7 +12,6 @@ test_fetch_bitmaps () {
 
 	test_expect_success 'create bitmapped server repo' '
 		git config pack.writebitmaps true &&
-		git config pack.writeBitmapLookupTable '"$1"' &&
 		git repack -ad
 	'
 
@@ -32,7 +31,7 @@ test_fetch_bitmaps () {
 			} >revs
 		'
 
-		test_perf "server $title (lookup=$1)" '
+		test_perf "server $title" '
 			git pack-objects --stdout --revs \
 					--thin --delta-base-offset \
 					<revs >tmp.pack
@@ -42,13 +41,12 @@ test_fetch_bitmaps () {
 			test_file_size tmp.pack
 		'
 
-		test_perf "client $title (lookup=$1)" '
+		test_perf "client $title" '
 			git index-pack --stdin --fix-thin <tmp.pack
 		'
 	done
 }
 
-test_fetch_bitmaps true
-test_fetch_bitmaps false
+test_fetch_bitmaps
 
 test_done
-- 
2.54.0.23.g371fc4317ad

