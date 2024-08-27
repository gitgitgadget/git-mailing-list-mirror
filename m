Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7601D3641
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793211; cv=none; b=oxlwh4reB3CS4YhD9MVoNaspVunqALJ8cexaOjOYMJw+zoPml9K8Upgk9SENqZJWNjpYC/oJFEpGf348qvhk4o0Y53W+eNkPJR1dJLesQNdgc8edM2gjXrlUYg31uhec+Nlq2x/3Q9dw2ACVixaVkXz5paPepVHHYSvSvYKHYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793211; c=relaxed/simple;
	bh=flSxG/gbArynA6JpeoSxMWkUTQP5nR6xhtN/dED9zuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJoU/uaYyhbVbSMk5l/Ax+3BGAq9aQmuY99//Pu8d8a2iESnGf2Kb0GtszmJq4bmXGCf51KUDjb7XhKW0pFcevXSLt9aDKUiHia0cXOCTR6wlR8nbHGSjPuWg9+rGtDrLr9b6n7N3HjNk3u5GcSNHkNYq8/5wqiF9guHmOp9W7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jTNdiiyI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jTNdiiyI"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b747f2e2b7so56544227b3.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2024 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724793209; x=1725398009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddxFxfoFLu74Xb00ygbS2gRRSaKj6rDX8EPPnHccbUQ=;
        b=jTNdiiyIglNT65/VLrouHALto/flW5ve4c2+6cDchz9XDEOz+frIda0vHF/CSaKw4F
         VoO3y0dPdFGyJhvEQYWipwRBBNxiJL7mhN0pgfCnIAk+OJX8iRU779x+rPtHq+LUSLI5
         LvJhBCXgarWG0bD1l+04Jbq8FU31FwJDz59zJA5MQqIta/gbxcrFqvVFowmJqO2f5/6g
         Fj65As6lU1xrLRDoQ7O1I5U0qiTnYn0v+oDedMQAvvlsRixWXh5L99TFzDzrMRqS1x4A
         68zxKzEHQ/3NSTbq4vDYfAdIHHeVjJWUvzPWnDGy5ux5ywnbCZtFkJ904hapyAqp+zWV
         XWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724793209; x=1725398009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddxFxfoFLu74Xb00ygbS2gRRSaKj6rDX8EPPnHccbUQ=;
        b=FSMjbi2rylwxjYoX4Tgz0eeRboTDoy/uzGVbWOF4t4SmjqqQr5XDMO5pP1ktsYS++/
         XxxpIlWQGKXfI9Gkenngm0W7Fr/jB22MmWM2O/f80znJJP3hSTSpB+Y4pFWEt9NDOxpr
         NUBVfcAjDotUE8Rd94WBxljvjO+zrv3H8hjRfJF9zmadVcaxBDKXqXIKuphH6qyLMlfK
         5Md8ko4vgePitLP+Hqy/CCWSC1e3LQ6bzL7Y1oFF+WfINScUntscZztfF05NLbW7o0K9
         H/ZGwVXJ5R5ZiXIKTqYvHnSPoXpETvUlPoz4GhHSkxaKKznMdhbAmZDJF/qqFQaBSdAn
         WB4A==
X-Gm-Message-State: AOJu0Ywsq3qfr8428QaUd9rxjYxwFdlvi8xlkxXeby52f+wn/hGJEtGv
	CH1yQI5mzY2dqXeRKivdAa9T0ZgZL4MiiT1Y9DdevGhkEVAt9GEf+hEEYWkpjh2q1RtSIWV1GqO
	x
X-Google-Smtp-Source: AGHT+IF2Xtzwtt6zZqeb2B5224p3lgGdz33ANf5waCmlnsrpx9vqW4bL8ejf/lFShR/D/Zla+UPclg==
X-Received: by 2002:a05:690c:56c3:b0:6ae:6c9b:378d with SMTP id 00721157ae682-6c6286bd776mr158443717b3.31.1724793208957;
        Tue, 27 Aug 2024 14:13:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b007449sm20753037b3.68.2024.08.27.14.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:13:28 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:13:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t/t5332-multi-pack-reuse.sh: verify pack generation with
 --strict
Message-ID: <160673231c55f51c22171a8c2fbb105f7a501083.1724793201.git.me@ttaylorr.com>
References: <cover.1724793201.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1724793201.git.me@ttaylorr.com>

In our tests for multi-pack reuse, we have two helper functions:

  - test_pack_objects_reused_all(), and
  - test_pack_objects_reused()

which invoke pack-objects (either with `--all`, or the supplied tips via
stdin, respectively) and ensure that (a) the number of reused objects,
and (b) the number of packs which those objects were reused from both
match the expected values.

Both functions discard the output of pack-objects and assert only on the
contents of the trace2 stream.

However, if we store the pack and attempt to index it with `--strict`,
we find that a number of our tests are broken, indicating a bug within
multi-pack reuse.

That bug will be addressed in a subsequent commit. But let's first
harden these tests by trying to index the resulting pack, marking the
tests which fail appropriately.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5332-multi-pack-reuse.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 941e73d354..ba888a83d5 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -31,20 +31,24 @@ test_pack_objects_reused_all () {
 	: >trace2.txt &&
 	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
 		git pack-objects --stdout --revs --all --delta-base-offset \
-		>/dev/null &&
+		>got.pack &&
 
 	test_pack_reused "$1" <trace2.txt &&
-	test_packs_reused "$2" <trace2.txt
+	test_packs_reused "$2" <trace2.txt &&
+
+	git index-pack --strict -o got.idx got.pack
 }
 
 # test_pack_objects_reused <pack-reused> <packs-reused>
 test_pack_objects_reused () {
 	: >trace2.txt &&
 	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs >/dev/null &&
+		git pack-objects --stdout --revs >got.pack &&
 
 	test_pack_reused "$1" <trace2.txt &&
-	test_packs_reused "$2" <trace2.txt
+	test_packs_reused "$2" <trace2.txt &&
+
+	git index-pack --strict -o got.idx got.pack
 }
 
 test_expect_success 'preferred pack is reused for single-pack reuse' '
@@ -65,7 +69,7 @@ test_expect_success 'multi-pack reuse is disabled by default' '
 	test_pack_objects_reused_all 3 1
 '
 
-test_expect_success 'feature.experimental implies multi-pack reuse' '
+test_expect_failure 'feature.experimental implies multi-pack reuse' '
 	test_config feature.experimental true &&
 
 	test_pack_objects_reused_all 6 2
@@ -82,7 +86,7 @@ test_expect_success 'enable multi-pack reuse' '
 	git config pack.allowPackReuse multi
 '
 
-test_expect_success 'reuse all objects from subset of bitmapped packs' '
+test_expect_failure 'reuse all objects from subset of bitmapped packs' '
 	test_commit C &&
 	git repack -d &&
 
@@ -96,7 +100,7 @@ test_expect_success 'reuse all objects from subset of bitmapped packs' '
 	test_pack_objects_reused 6 2 <in
 '
 
-test_expect_success 'reuse all objects from all packs' '
+test_expect_failure 'reuse all objects from all packs' '
 	test_pack_objects_reused_all 9 3
 '
 
@@ -190,7 +194,7 @@ test_expect_success 'omit delta with uninteresting base (same pack)' '
 	test_pack_objects_reused 3 1 <in
 '
 
-test_expect_success 'omit delta from uninteresting base (cross pack)' '
+test_expect_failure 'omit delta from uninteresting base (cross pack)' '
 	cat >in <<-EOF &&
 	$(git rev-parse $base)
 	^$(git rev-parse $delta)
-- 
2.46.0.426.g82754d92509

