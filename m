Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A722E3E9
	for <git@vger.kernel.org>; Tue, 12 May 2026 00:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546830; cv=none; b=Lh4pYsbtod0vOzq+xIFQ6ZbcJSo4B3YQKCfoZFuGJyuGoy4vCwCk6fOBaUiz51nZHlAjQO01Y6WQs+OOXr8xh80iIaTSF2cspvQFzgEcwftuDojbfFcOSJjmOeJ9zgJTcgy2VH+8igr3XJLyLABcV60gx8wZycDLGqXJ+57fjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546830; c=relaxed/simple;
	bh=RMFMbTzUa7DnT0+UTJOnKO7uflD7V+mH78BKvvUSY6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PapWrOgPXTbTiz3duEK1IqLtH359dNad5ztZu9EdF9g7R/DvAQ9DSDBel6zu/adZADRbE166raBYGg4LqxqELsQaWQ7DC+PyA/u8xcEyOLSNzmeO1vjpHDGli5VJNrZmWgyeURswE9wJVfeePSmosMRlM5/2H2sK8lP2tbVZ0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mBS3Z/9i; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mBS3Z/9i"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bd87e5d8ffso64131197b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778546828; x=1779151628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z9Co7+uVXhD+tTdcaVzXRuYyu4s9rG7BiYtVLGNeSLk=;
        b=mBS3Z/9iW75SCx2V1UnrbokHHuLHX632n0l9GWDyoxYkIN8ZiPYxpLi5Nd5yTIp7hg
         ydNGr/5B8kIj/S/RpX0wvvbpvR0tpKExf/tdNKH85er9XOgMgVs8CHzXxGfUN8RnDx+9
         13Bf9blNd2OneGdyz+d8MJxPh5LXKrBYRo69z7cK/e7uHwOSNHw4h68F0ZhKtpSvVhPw
         OZLQdRLnORFrhupFD39a7OJ55ZWQq406IsKtQMTXtoqBIdekh5JQ3ROXajG6aE6Q42tZ
         9AsVdlsxXXqiSG+FHG7UU3E7y5BDNMm8XVBBDlgZ6qbfKF9YnR+TEUlvJ9snQ6WW8RWg
         XI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546828; x=1779151628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9Co7+uVXhD+tTdcaVzXRuYyu4s9rG7BiYtVLGNeSLk=;
        b=etKRuWRE0t1SM5h6J8rQTwgVLJ97cyu2DyDTEevNgU402PYJ8de0VewOsAviDe4QQV
         5Mt3nJRaVRT25k4r9AVX6KbmDMB3JrshVZ4N3HcTKk5fEx0Hr0rNLnJZb8k8OSJLbaFv
         qzTMYjsiVpGFrK268tiuyiNI9wJVEqiB1DuPH/F9ZeG9PDl66F9J2qaG0fgYleDnm97X
         GXsEdGxzIf2FXINntA47E57WbNVcfh2Qucc4kOYgjRFGUSgw0F4vdhD8ENR3Pe7m9xYE
         Ijds78iCx+zMYzWyOSDm24yAgdkHLv0kBXmL/1eLIZUObWAqi9UR5xAAGvt2uEd2a4AU
         zV1g==
X-Gm-Message-State: AOJu0YxGGGhXHRhf8iR1NCPdb0d7x1AJjsgjWWZv8+xcndS41131kAGr
	N+j5oUOqg/rHEd2C3h0yApUMnm8mG6riuJo7M0/lzSUPPUleEn47oEMLAfcTRQbOpGE8FJtFGbB
	NrZYxVZyj8g==
X-Gm-Gg: Acq92OFyYt+QSEiT5XV+1Qff0J+xaqMoTn4w+x0JR3MVm2TncXuzOfaTelr6ZjH52lH
	WGY5Fg6akxDRJvmDQuKVgZ1rdyKimJw9J480g+SyvsCi6nyS1LpKeOP7GW/cOLTMg26mCT4GaKI
	95UqxuVWK0W2YOXPmfjv2d30wDrdsFY5kE92KUPhbcRkqJCiI6b0J6YrjPMffVyJtFjN9G9aQ9Z
	E0NG6+6nJbb+4zVf0LinRb9FDUSZIgkkpVEXCXpIGLs3hcX6VJyYNvjLhU+ntAL0dRgvIfpFggV
	kUOzEYzV6HP7oj6a5MGeU7+LjrYYhxG9RRx4SsxiFsx6KNWdXzZLAfPaU23frXp5r0JzmRGsdoF
	4RBXTauHl9ohR3WshJfr3P8WAf7IkkJj376aJSP7hzWd6n4vpQJFTDbiCk8m+StflCXo8M6XqTD
	dpkUbEg2zpxU5m730TOOakPs+tOnwem2t2zDdl3S4rqxGZX1N6Hbxc2YA7lU9ksvv+FhMbdPlCB
	tfDiQ/azGN4F61RNf0YH91M1mYi+nlVu4aIniLhVffDVKsrqvvTUU+djGRm76qooogEDeJ0gxIR
	3r2oI3y5Kn9qaId+
X-Received: by 2002:a05:690c:39a:b0:7ba:f3a2:552e with SMTP id 00721157ae682-7c50e70febcmr18291897b3.10.1778546827888;
        Mon, 11 May 2026 17:47:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66558f35sm156143547b3.15.2026.05.11.17.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:47:07 -0700 (PDT)
Date: Mon, 11 May 2026 20:47:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 7/9] pack-bitmap: reject pseudo-merge "sampleRate" of 0
Message-ID: <4dbf6686718efba5a89e8c725fd91f6d418bf161.1778546804.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1778546804.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com>

The "bitmapPseudoMerge.*.sampleRate" configuration controls what
fraction of unstable commits are included in each pseudo-merge group.
The config validation accepts values in the range `[0, 1]`, but a value
of exactly 0 causes a division by zero in `select_pseudo_merges_1()`:

    if (j % (uint32_t)(1.0 / group->sample_rate))

When `sample_rate` is 0, `1.0 / 0.0` produces `+inf`, and casting
infinity to `uint32_t` is undefined behavior in C. On most platforms
this yields 0, making the subsequent modulo operation (`j % 0`) a
fatal arithmetic trap.

This path was not previously reachable because an earlier bug caused
all pseudo-merge candidates to be classified as "stable" (where the
sampling rate is not used), regardless of their actual commit date. Now
that the date classification is fixed, the unstable path is exercised
and the division by zero can fire.

Fix this by changing the validation to require a strict lower bound and
thus reject 0.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/bitmap-pseudo-merge.adoc | 4 ++--
 pseudo-merge.c                                | 4 ++--
 t/t5333-pseudo-merge-bitmaps.sh               | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/bitmap-pseudo-merge.adoc b/Documentation/config/bitmap-pseudo-merge.adoc
index 1f264eca99b..6bf52c80ba7 100644
--- a/Documentation/config/bitmap-pseudo-merge.adoc
+++ b/Documentation/config/bitmap-pseudo-merge.adoc
@@ -47,8 +47,8 @@ will be updated more often than a reference pointing at an old commit.
 bitmapPseudoMerge.<name>.sampleRate::
 	Determines the proportion of non-bitmapped commits (among
 	reference tips) which are selected for inclusion in an
-	unstable pseudo-merge bitmap. Must be between `0` and `1`
-	(inclusive). The default is `1`.
+	unstable pseudo-merge bitmap. Must be greater than `0` and
+	less than or equal to `1`. The default is `1`.
 
 bitmapPseudoMerge.<name>.threshold::
 	Determines the minimum age of non-bitmapped commits (among
diff --git a/pseudo-merge.c b/pseudo-merge.c
index d79e5fb649a..75bed043602 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -169,8 +169,8 @@ static int pseudo_merge_config(const char *var, const char *value,
 		}
 	} else if (!strcmp(key, "samplerate")) {
 		group->sample_rate = git_config_double(var, value, ctx->kvi);
-		if (!(0 <= group->sample_rate && group->sample_rate <= 1)) {
-			warning(_("%s must be between 0 and 1, using default"), var);
+		if (!(0 < group->sample_rate && group->sample_rate <= 1)) {
+			warning(_("%s must be between 0 (exclusive) and 1, using default"), var);
 			group->sample_rate = DEFAULT_PSEUDO_MERGE_SAMPLE_RATE;
 		}
 	} else if (!strcmp(key, "threshold")) {
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 0032a16606b..5bfbbd4214e 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -639,7 +639,7 @@ test_expect_success 'pseudo-merge commits are correctly classified by date' '
 	)
 '
 
-test_expect_failure 'sampleRate=0 does not cause division by zero' '
+test_expect_success 'sampleRate=0 does not cause division by zero' '
 	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
 	git init pseudo-merge-sample-rate-zero &&
 	(
-- 
2.54.0.76.g9b17dab2cf7

