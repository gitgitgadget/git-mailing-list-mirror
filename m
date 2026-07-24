Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DA3CAA25
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927163; cv=none; b=RekJN/pVw00GcVukIpVl7U/fCAz5a7qoeNI+A/SN36cC0sJqhxmgGFeblzZ8Ym5bhlrsTQi2M5Hxs4qWepuZE+9z8iu9zqOmu5i4ys/aj/4d2qlCaxJ5sU4WqQep13Xb6RRVjkyvKvW+GTFsOI10guZcyQVpEPmnsRXbrY9I330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927163; c=relaxed/simple;
	bh=kdBoxRJmtAY/SJIyPKnPDUlnclZHpBvFOKpoHn91xuQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTjWQaNPovhF8IWBPuWcjpmoElId9HXjZlGoUDmiOmWIfHssnjXHVHfOIQVRXjDjcsKR8nNh8JHyrmors+/4eu/Z3ju5EFmhMGMhNogJSD7mhyVe5s1iCrn0z+vv/Cagby8+Rt1ojXdHIkO7MAThJOqHuT/RNFJ1d17eErhBAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EF/AjYp9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EF/AjYp9"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ee6b2da98so8342057b3.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784927156; x=1785531956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVydai4jfZCbeB7xZEE0Qv+D1rBGoANnxeYBi3PTfGc=;
        b=EF/AjYp9KqAdX60elDGw9WFiHhHtqBAJ1cKIkCTjNfv3QNCHKvVs3SXteaup3AXFEc
         aAKdooMdOzowKLBpJTfksHpeaxRZ0oVV1CY6sS6ieXgYJUu4SgTU3D7D0DtBT0K6RgQV
         8t8cmkm9HS+ULL+Vp3Muuw4ks4vc7q+baHuSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927156; x=1785531956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVydai4jfZCbeB7xZEE0Qv+D1rBGoANnxeYBi3PTfGc=;
        b=o4KSH5xVMxXLBLMpq2+YelVXdiVLNX8LUAZz2K06j++oqRkZH69NNs6fu+Pzgf33uw
         aTpwqsHF/0Z1dlvkRxjyL5iF/fvSSUxAUv203iG7VMR1JEtBGgGl/rSLFlPbKIRANC9g
         EQoLw9OC/KLO05Te5mE9xBtVu3FTcMi/PQbQClxmLiJKW1I4YVBfnOF7E1WR6LtMhlA/
         RjrErS51h8KTeeYhiuP0UsMQrVaXimLNPfNWqOhiq1dF8FZtDCtM4kSKpTTHnH8mLvnw
         iN7r+umNiHWYkDekv0wjIDyDoCTN3fIRMTCvXSVIYsJXpwVS6O3ycF59XeAIuMwiPwRQ
         SlSQ==
X-Gm-Message-State: AOJu0YzWzkCTKF1WhXJEcZxSbqbzCV7UbtHxhznaeHIPdAV8nKi420kA
	nXIgbmDuymgimE2QS9fABVO511ZdwMsKWd3JHLS6qdi3fCgSaP0aw3+Mb0V1clX/jusv7y4YnPR
	4UYVOObk=
X-Gm-Gg: AR+sD131hMvtTRPx2n4tfemUf/5KTeT0ycwRTaceCbmHR0CACcaO4xkRYTbG3OI+rSY
	mbhzH27WlYYVBzLes6W0ANzSfD00PaTDH2zSpljjgPPQrZ+jY/EnN0MfIlbuyMPNc1/o16xsJQg
	bndvPAXW0ookcgHtBlj+GFPGm0VUgBgG65HTaLdxal3zsjcLkyF2ODQ2leyxUHK3hglpxwFlW2f
	MHEPZ6JmF6fEFJ37IpZu3taHKk97kSW5d/jplecodL3z4MCS1o1Pl7TFU94UR/KMpyLCnnI+/6U
	XyEWjRackkXxvBpXHVdF3riktQPPBqyTKJq41dnZZrBX2fkDgfKdkPGVt3xXVvnvj/nxLKEgP1e
	F6+GohmH4oph80ksdd1SNfx4KG1u1ytj314d80/RySZzrRgrZYdoT/y3ng8I2M5l0C4xZbxnH4q
	74OEDyW1gHk/siFXYwvUOFkbRtc0DeoUGJmlL3e8TWkDVmfvnX3tmcQUW+TPPmnaAmHoGb+/1rf
	HwK8hfzeTZ9y4UW/dXF3CxKD8B589iE7tdu1yCVBPhC
X-Received: by 2002:a05:690c:450c:b0:81e:bd02:b02c with SMTP id 00721157ae682-81f69c8808cmr447967b3.1.1784927156493;
        Fri, 24 Jul 2026 14:05:56 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65770c91sm5897407b3.2.2026.07.24.14.05.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:05:56 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:05:50 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [PATCH 1/5] t5308: test reverse indexes with duplicate objects
Message-ID: <4aa08dc13f640da4036e4e50b8be7246dc9961e6.1784927134.git.ttaylorr@openai.com>
References: <cover.1784927134.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1784927134.git.ttaylorr@openai.com>

A non-strict .idx has one entry for each object in the pack, even when
multiple entries have the same object ID. Thus a pack ordered A, B, A,
C has two .idx entries for A at distinct offsets. The corresponding
per-pack reverse index must represent both entries and map them back to
physical pack order.

Existing reverse-index tests do not cover packs with duplicate objects.
Add one and check that %(objectsize:disk) for B stops at the second A,
rather than extending through it to C. Exercise both the on-disk and
in-memory reverse-index implementations.

As part of validating Git's handling of packs containing duplicate
objects, cover their per-pack reverse indexes.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 t/t5308-pack-detect-duplicates.sh | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 0f84137867..4ff8f5b449 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -27,6 +27,11 @@ HI_SHA1=$EMPTY_BLOB
 # duplicate runs).
 MISSING_SHA1=$(test_oid missing_oid)
 
+# Three distinct objects for tests where physical pack order matters.
+A=$(test_oid packlib_7_0)
+B=$LO_SHA1
+C=$HI_SHA1
+
 # git will never intentionally create packfiles with
 # duplicate objects, so we have to construct them by hand.
 #
@@ -72,6 +77,40 @@ test_expect_success 'lookup in duplicated pack' '
 	test_cmp expect actual
 '
 
+test_expect_success 'duplicate entries remain in pack reverse index' '
+	clear_packs &&
+	{
+		pack_header 4 &&
+		pack_obj $A &&
+		pack_obj $B &&
+		pack_obj $A &&
+		pack_obj $C
+	} >physical-order.pack &&
+	pack_trailer physical-order.pack &&
+
+	test_must_fail git index-pack --rev-index --stdin --strict \
+		<physical-order.pack 2>err &&
+	test_grep "appears twice in the pack" err &&
+
+	git index-pack --rev-index --stdin <physical-order.pack &&
+	git show-index <"$(ls .git/objects/pack/pack-*.idx)" >offsets.raw &&
+
+	sort -n offsets.raw | grep -A1 "$B" | cut -d" " -f1 >adjacent &&
+	echo $(($(tail -n1 adjacent) - $(head -n1 adjacent))) >expect &&
+	echo "$B" >in &&
+
+	GIT_TEST_REV_INDEX_DIE_IN_MEMORY=1 \
+		git cat-file --batch-check="%(objectsize:disk)" \
+		<in >actual.disk &&
+	GIT_TEST_REV_INDEX_DIE_ON_DISK=1 \
+		git -c pack.readReverseIndex=false \
+		cat-file --batch-check="%(objectsize:disk)" \
+		<in >actual.mem  &&
+
+	test_cmp expect actual.disk &&
+	test_cmp expect actual.mem
+'
+
 test_expect_success 'index-pack can reject packs with duplicates' '
 	clear_packs &&
 	create_pack dups.pack 2 &&
-- 
2.55.0.383.gde07827a19

