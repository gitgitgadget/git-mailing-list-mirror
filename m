Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51186221F16
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424775; cv=none; b=cJmok9pVGV/KDUQw+lMZkzXB2SlC4afQabLTqdTuY4cd9m7cm7ijnNG1ELXoK6t7FGM6YDyEuriHO9Phjis7hRb2mNa2uURpu8Mc4P2MPqdKh0HhmOp6BUuc24ZI0TZTCRZ3HuvJBUNNH3OAT5vd1KabfuNjOZhmg2ggN71EPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424775; c=relaxed/simple;
	bh=0nCxrL/G8M/O+WhyBIKBTCT8LyXBtBEchykTSXy5Ueg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ+XKcGxliXm5DZOi9W9c1SQvmEuPjgmqtnyVLWwLBZSb818oveUvt09vmlw/QhR7mH+A8cFI1taFim6WDghpSCsqTcSkdy1EmDAaebxFhzPOgn6F37HTa2mMYbxSZTM67IhXLukw7z5KQSy+pxV0t/EV0L/nwWYXeMz4fq9O6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jl1iiw1L; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jl1iiw1L"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476af5479feso1969221cf.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742424773; x=1743029573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIMKyCSylCTCD/pYdQEqf/gszAmYw6lsJBhriIG2fAE=;
        b=jl1iiw1LVAHHS/J6zYmZ3hMsSojRog7hxygo/i9QCsWHWvrryvua9yYtZfcux+DtlJ
         8MBhISCoENEv+R9mR1jPkSNgghcuqGhaIrnMEtgOUg3G8BmA4zYmHFv2LjBu+M5Kex12
         Nr1NcXbaGJ9mhhf5dD+mCX2w7PPOvmaWALFaUzXJ6ZeKldX92Qh75zgI9bo0YQ5Jx5oT
         xshR/zNSe0VwqPoucItXRC9FgC2xuKMgeCJCrbUr6NFNt6LrymEzXttThZAQcvRKWNUa
         GNdPOmyR36JO6FVlqYPPsJHhfnNWWclh0GPDgX059a9R3w0gZM1/AnduJ5QtvgHRYobv
         OAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424773; x=1743029573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIMKyCSylCTCD/pYdQEqf/gszAmYw6lsJBhriIG2fAE=;
        b=Z6pIfwjioVgEchKCoTvfXl43Fmr5qhcWBCnghKFnjz5bwkGELPIvYKWy/rB50a0BLO
         ZpVQPcyJx2eVpP20tWrz79m1ADlfNnd5lZ97Zrt6mTQnbVR2UrBRXk0PwNPF7r9Fo54Q
         m5Ovvg7SYv8EykI+e5eaQFzpCzEDvD+l/6jYfP7iqltEHSPGEMpxifM1ArBAzj7pl0ZT
         caRhlMeY8pgjzLghAjc/gkvGeFqweJ/bHgLUopm5VpmMvZ7YxtPHtPbHEYIClN9gqAhZ
         meOKKs8X0rVA4oBXuo2KgduD4ER8YrSksQCz8i/o9+T/+behr+kv8mKNlLYGeR3xzSS5
         2NDA==
X-Gm-Message-State: AOJu0Yx28fqJnGFKjRCkKvqcNAp5aWiznwbcu+BrSQi1m2VAETD8Pxwr
	zrMaj1qwKnTUfgQKCXZgfpwrypfh1VuUXGTJH7EY5GREvSJL9sQFHJsrEN6TIUeExkHmjlea9BU
	aEFE=
X-Gm-Gg: ASbGncvycSbQYW+5W+zAxEh+ZrBTRcHWoATSi1ExHuMHifJMO2B8DJb+AqjF1BnchSt
	lNBuNXI7yXh77YMgLvrYdL8IsyrpkQ2zIyFxN/xJis4GEhN2uDESgucAU+sZkPm/iwzQ7Wff7KF
	NiRoioCvfcUbgk0yLyymyiJgKa32uj398TM/AtGAqgKYUV02vW1EeYp9NGRb1OY+1HRGTrFcb1N
	6TUHIZUb5tFt9umNJ5CtvzRqQZtqqJPeh8wHXL8n2nu2diYSTugvetlaLoCCVla3Bawwrt99QJO
	vkZvHReG3kPAeD/QHFVzSyMEv747h4XJQqEWcyWzvD6dK0Qw9ZxvwDr/aHslwBnI8hExAfpg9lR
	zSc/9U/CsnhLa6mek
X-Google-Smtp-Source: AGHT+IFrbkypvKRsYsL3n9R6B55J1KB7q8NGMcBJPbDh6X2MmO/l2+uNekCqGl2giJNjI/gjL2Ht/A==
X-Received: by 2002:a05:622a:1c0c:b0:476:9cf2:d907 with SMTP id d75a77b69052e-4770841aba3mr80664051cf.52.1742424773096;
        Wed, 19 Mar 2025 15:52:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb60aac8sm84612541cf.15.2025.03.19.15.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:52:52 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:52:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/5] t/t7704-repack-cruft.sh: consolidate `write_blob()`
Message-ID: <b075ad86015131e4a83bd7bcd707ff2273b375b4.1742424671.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
 <cover.1742424671.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742424671.git.me@ttaylorr.com>

A previous commit moved a handful of tests from a different script into
t7704, including one that relies on generating random blobs.

Incidentally, the original home of this test defined its own helper
"write_blob" for doing so, which is identical in function to our
"generate_random_blob" (and is slightly inferior to the latter, which
cleans up after itself).

Rewrite the test that uses "write_blob" to no longer do so and then
remove the function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index e6e4c2fad8..3fd5aa6089 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -618,11 +618,6 @@ test_expect_success 'cruft repack with no reachable objects' '
 	)
 '
 
-write_blob () {
-	test-tool genrandom "$@" >in &&
-	git hash-object -w -t blob in
-}
-
 find_pack () {
 	for idx in $(ls $packdir/pack-*.idx)
 	do
@@ -641,8 +636,8 @@ test_expect_success 'cruft repack with --max-pack-size' '
 		test_commit base &&
 
 		# two cruft objects which exceed the maximum pack size
-		foo=$(write_blob foo 1048576) &&
-		bar=$(write_blob bar 1048576) &&
+		foo=$(generate_random_blob foo 1048576) &&
+		bar=$(generate_random_blob bar 1048576) &&
 		test-tool chmtime --get -1000 \
 			"$objdir/$(test_oid_to_path $foo)" >foo.mtime &&
 		test-tool chmtime --get -2000 \
-- 
2.49.0.4.ge59cf92f8d

