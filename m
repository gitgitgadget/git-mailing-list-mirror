Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4431F985
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438908; cv=none; b=cyzSVlA9OupOGKLH0ntbb+Npj3B4KNPXUoNq48jyMkWsd+K6o616peb/SIgrFMwIukYxvonBJftpQiW1ItC1NuLO0B6pMYfbLOKzL/dK/Ay/22gAf8le13xeQLoI+uAzOpxIntnaes9Uj1BN3yPlWS2xrJzNu1Vw+eavUg/Fr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438908; c=relaxed/simple;
	bh=ut15PhX545dPvsBwERiGHTIqBYq6uUaNrtb7pneyqd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngD1k/72r/Q/thoh81tx4IYIqeXodQb4+wUyYPVDNylctQ7/tQCux45ZpbEpbZEIOKdvHzCas6o61hCt68ZTNm0EkFgHzAjbFY7B+ALgkdu8ybBXDRhEA8iAUTlpesFKX7kEV5UWBn449B+qq/qTUBUwKfkRdfH8ECTetU1iKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=i7UME09K; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="i7UME09K"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7ded779a345so39797517b3.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 15:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1780438906; x=1781043706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+RSymkSou5w6oezE3HlBEnhDrLBfxWA2uiUG080tk8=;
        b=i7UME09KLfN9eo7DynCxPPqbxz7+c+z+tDDghmdj0AewmoDKagDpyo15MPSsalktoo
         JdietH7kR1ZN4zCSd+crR8zYzk3cs2EZQ2b4VyLXrjxJp7GhIuXO2jQ/QIjNIES6hvzJ
         Nmmk8lApnfak+Bhu8hnXCABdrZ03VjKxmoLssaLFccsN3i1wF75C6jAvn/HJxB03Vis/
         QyLBYb2KwfKkrbb7KW1xfpHndoqwVLcbxxrFhLgCypbCyybt1k694L95pqy3n4QG+eKn
         7Z4h55MuUdFmJ0H3IEu2cLfgcKK8lGsjYRJtXWqmBNHXlb+li47XDT8nMQu/YrJCB7bf
         7X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438906; x=1781043706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+RSymkSou5w6oezE3HlBEnhDrLBfxWA2uiUG080tk8=;
        b=OU1Mh/1k+1WK+fdZdmB830HRkehcS5ZCdV4QgHJQ3d+WwwBNxXQQbettt2Golisb5Z
         ufQMKd0dM0WmjXD3ljACbgXJPS+cqpR9GEav4/WWUt+kjbaHRhjV1KQuutmrGmwgS2w/
         7ASEbUbp9Ld7JrbF3VmVEip6f3n+sTLQGBB0Eyb61bxeSUA2Z5KoS1vGNgl4r/1ZN70M
         7HYYskZPyYyO2173a9deEI8B0JpwhM+d8Gf9hFCqOU87uEdAgTUB1RN9uIoFwJhyxWMC
         BYdGF81SVXY/SzOUL9XYmQaR0M807u5ytJU5+a4AO0KK9VUlhL0XfqaK7xxf+Ucoam/9
         NGzg==
X-Gm-Message-State: AOJu0Yw5h5KyId2s9lNpGGZhpTO/hhlAQYo1w31oZCEX31HksejTQODC
	64mpXNHGSRRkAkBXdaRh5VhYw5xVZF8LIdiu1YUFWNuEJS2mzK1lAf1MsMn/gNmN/zGmDGa2ewy
	ecTGkQjk=
X-Gm-Gg: Acq92OE2ihmaWPNlc200Uz6UT0hTer+L2nM1v8OcG6OlZR9FtYbdEildS4MQsJKapPj
	JEION3/z+VQRG1tW7Odo9Nng8YSLCQO2PFiek+Tuo0gvqZPN1SbvByCGfi6lzPfLL4Z0AFoP8OE
	+s7zkXxSc2Pme5UDY/XNjDesvEEaUpRXECIUKrCRYsVkahAVa/eo281Ml8CTa3YwiS9aVsEjVvx
	iyItUNx5aRuZ8whWT9m1OCsWy29/IOrSKh5ZPWnNe93ruOgFi0/5C+aYXMaK7b1n+gjQeFo7lWF
	jR68rN+E9Vg2RlS8sypj4a4pLEqOfgtzwX1WPgpnOdYKrGbJt9+dJJM7+EtQATKsG7xQn3NFNJk
	OS++5zKtONvVn1YIw8diePtsByGD7pYGPI+C34SpUXHMmNgKSvm/feL7ElSq6OonGlyECNoJaQN
	Oi6Ug0VXHOX4kI+Zswi7yc4LHikOyJ8DiKDao0Aq+MPfkeClypvNGixm4pILvGB47qN+Tmlngsa
	gnlrMsS3yI186ZzD22RCeK3tPmixydKo9ZvX8AOZZ8HqqxTb+qHDgQinEEQ3hLKbK/d+cS6FZgv
	Ohp33UfKbZnlR6XI74CcIEetNwyPP24Mwn/F4w==
X-Received: by 2002:a05:690c:2610:b0:7bf:107b:f85b with SMTP id 00721157ae682-7ea491a1c02mr8692117b3.13.1780438905986;
        Tue, 02 Jun 2026 15:21:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea21a621c3sm6321397b3.22.2026.06.02.15.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:21:45 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:21:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/4] t/perf: drop p5311's lookup-table permutation
Message-ID: <52d63e8910e4ca716405713d48cedeb26026a3b3.1780438896.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1780438896.git.me@ttaylorr.com>

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
2.54.0.23.gae57607b57f

