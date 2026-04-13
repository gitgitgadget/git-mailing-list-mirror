Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DF1C68F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124621; cv=none; b=eWRO5gSFKTGVJ2OEIQkQwjh540SgbUTeNGTfraU9lp3Z+T390z3e1V69GKsyfwS7EnxZhSCwhWvEtdpzZmAYJ2CLgYAn5E1/hFCuzxgA2E7lgShsJk+SMe6B5Jmlc4d2+1z1lKPqQW13JcFwfD9U72HABSkmEgt31HYEr4+r2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124621; c=relaxed/simple;
	bh=3uVlXVM3MhVrUn+6/tLcCbNLU0LnTJMPdZ7/DnIKOeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaucmnrxjNDm5H+Kwn1UmDLz5TRtt5PPOetQmwYb6FYBqplqiQp/xx5p28wnQJV+a3EFQcxEZHx4pWlghavkhpsOBQgj5Bhjeih2ToSMUb/9MoUJ2+CAoFUPDVWg4G1nWcns0paGbA5/DJamQXdLcENlJ6o89lHdAKem7X1k3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YSsM0g2L; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YSsM0g2L"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7982c3b7dfcso48731727b3.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776124619; x=1776729419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4pp7+PL50ZNkOV9qOOpJ1lilTpc9dzkJlGrV16kDYU=;
        b=YSsM0g2LX6XvovGk4i4RzdtgFYEZxnCEsmMtMD7MI3AVuPOMoQ1xb7oT/dPLV0niW8
         rPlzc7w8Kx1dbzNLICr2WyIJ6sIujsLqizA3XawJAGZ3ASlTdT6q6apJOe7BfFeN0D8L
         /SPqBKpAVi1gYE67wv277BfvkPWuWQUrCAYmSZKIDXIcONn3nwTfhNRn7G9hnAtIn10z
         iTcBtPQDfFbsYe5Mwq1S7ocp0a0dcXpy6yqgnskv88z2LLwiY3CRCiRf9JwFTeQ2lnUv
         pt74GKslK8mfGqj5L3Wi2ZSNFO6u2UIKj5b7D+2qXN/wX6xqW9o8WgS83zoyQ9q3gxch
         JOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776124619; x=1776729419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4pp7+PL50ZNkOV9qOOpJ1lilTpc9dzkJlGrV16kDYU=;
        b=fnx+7S5Y/tH/lalK/PLe2tW3t4pKX+bIC/sw7+8iL5gWNeG7BQTaXeGFwvNFH2IOo3
         4rzbSKcztfnfjIjUshjjorxBYfbRqwJiipKNHdGa/QxKXtqzl7IJho2hI/ewucSDYfbk
         T1a1C6gWuVntfe68JWcCODPe/hJXO2BWRfRvBKJYWudZkbeHfjcEl0wxv3DSgbZo37kz
         +mspvI8ApPeRmVLFg2UKqd1SAzbgfd9i1L1YE01jxBNll5uKjiwrDjZ853DnW2QytkY0
         vXRsFioqs40nUxwJ2Qv8FRwPjjEPVVMANRz6Yfaje2IxUsSCvQpHGaBntVtoFRB4Fgvh
         LFRQ==
X-Gm-Message-State: AOJu0Yz9e3NWHwp2MaTKf2hv7We1AC+dR1h4kY57I+GPKKxVJmefMf63
	5CRZPYf3pyXfSFz18/gqX1e5nI1EV7COyeTqsWCMSQkl5USZlN8QZiJeg9ecOZesmX37AHx23T9
	0aK2tXWs=
X-Gm-Gg: AeBDies9Re75BPdphG4fy8hOHgiY9JsIsRIkBPYzkaLpsMLO/SUOWOTgZY9leKM1LTp
	Y24JPJCTu7D+MtTxSSSVK8zQqs82Uxfq8NXTZ5Vwd9j9dWW9tu7yeyrh+rG0fgTemCY6RCgBbNr
	pfQl01PAyiCl/1lKAFB/cu+sOrRsKFBQwvl8SzcyisKgX7zdQluZfWD8hVRI/Bka/T/BI9zPilb
	vclN6ykcctJ1PfH7OYarc9+FpfizgrAjBM1BGsabeWysPdSkPT0JkdE9quHU6CH5D40UZrytT++
	F7l0GH9AjkcZEdlAitiLQY8rsqFepireHFPMJycVWljJXcRpaGieBOe5D7AqvjP32kIs9qm409b
	Axgnur5ruB4e8aYtz1lGKzwF4cI7Jj1rDcuwL6c5tfCa0MIkpcq4wS0UfwrRmFh2zLaBWFGvqwy
	DNl5RH2U4TD1jZiQuySyMAPomImvgLn2Sgh6dPrdWnCwiH5g+Srkzxe8DokvJyvqxgvvG87erGZ
	2/l8wlqi1NwGVrsT6nl8OX0mhpUAn/b4GAnW40q+vRxGhbQVDwvKgydcpoiQGOMLueaV1jizILa
	VEdDnjohdOgrndI3QheHBwv70XQe2SlHzQYumw==
X-Received: by 2002:a05:690c:60c1:b0:79a:b00d:c863 with SMTP id 00721157ae682-7af7213dd58mr173595847b3.47.1776124619441;
        Mon, 13 Apr 2026 16:56:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3d0c6967sm57959567b3.18.2026.04.13.16.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 16:56:59 -0700 (PDT)
Date: Mon, 13 Apr 2026 19:56:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 7/8] pack-bitmap: reject pseudo-merge "sampleRate" of 0
Message-ID: <1b0f7295c21bf6240bef975e5f3fb9da685f29d3.1776124589.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776124588.git.me@ttaylorr.com>

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
 pseudo-merge.c                  | 4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 63d2f64361d..46e8e6a8ea1 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -639,7 +639,7 @@ test_expect_success 'pseudo-merge commits are correctly classified by date' '
 	)
 '
 
-test_expect_failure 'sampleRate=0 does not cause division by zero' '
+test_expect_success 'sampleRate=0 does not cause division by zero' '
 	git init pseudo-merge-sample-rate-zero &&
 	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
 	(
-- 
2.54.0.rc1.73.g8f4e0170952

