Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7886ACB
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972369; cv=none; b=qrBS/asMlzlQC5PskaGqwKTST2QQOChEBMyn6xwWFRi8I+56hKL4aAwA0s6Fi8TWnNy1G0+mR7ZmQSIv9URtkdqN2X1dsA1UAe0Z4tm61S55X9fzp7796y47ov6S+xNCFsW2SRdgyuII4ywdjIM2OcRrWjCCxLnF7ci9eul6jL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972369; c=relaxed/simple;
	bh=LGleJ04VBkbJ+Fq/xlePpFto67qJhFbp6tnpUS83uGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYPBcRFUAzw5IHd3xbzL0Ip1bRGXsDmViUgno6WEhUlhV1aRL4n3HD2ORKms2AiEakQisPdcq0jRFrT3jevyIH4AqGSu0GvMtwLLurrkhnHIVOvDjN+gHJMvhH2fjtnS1PohsR5Ga4daZAuUxz4XpOgS/ILRFnfRCyoYOxiRdzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kaTR6GoQ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kaTR6GoQ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6098b9ed2a3so3024117b3.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972363; x=1711577163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCBQv+XpRYcllzMZNKRb2EC+SYSpIpqhGBHmgnGM/XE=;
        b=kaTR6GoQoMzGYueGNccvfLE6QhJkeKGmuYjmBP4lYKgIeswzrxh8ARNhS41ztoi14d
         AO7upKiwndwfil1MA4aHOibBGRINB5AIe8BUeZwhzpCujPXSZ4oN3xbScyTCyazoKJJl
         99iNAqynhUhT6ld6C6R9JM+DLSwRUVs2DMqnqBvqwJe14TYwE3Deb8R1OnH8I0Qjfo5m
         qIj8mvtnbgqDEHH7D2HOcoUzG6nR1c6tHeIlKG+0ccp171WJpMDeNb7/kIBWzdksOPm4
         k3nPQvQiBYQ078ZfLTLQUt2+bCkoIHwuvWR0Gf+ullwXDQ29r/UPo2Yhv+tQg+BNktHe
         t0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972363; x=1711577163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCBQv+XpRYcllzMZNKRb2EC+SYSpIpqhGBHmgnGM/XE=;
        b=NDWNZbW6cEjepUviAO5u9TD64DOJAEpVv/Hh+yV69OylVL/AtfrPvPlYQufexR7S/6
         MTVhG5RUJO9r+VjzhU9Zw2vjyK1i7+Fj5EpG6xYK2ou4cin2npA3ekTk/f06lmSrXHLk
         wHv8aX4ar6yhJSqGGV4xdEPJZAPOYGXtRUQQWqhEW8N/odR0IOTQM0x53/wrr+MNhStj
         a+EZScSMCgbW1XxTfg2CHlHU0BSg3RzlUeN4VQg+kozHFlcIC1srrHdHGlYflhJZIUFQ
         ptibiO9oDQUjIwh6VTBIdp9C+G6NXBPxa9UX5ZLc3E+XJ1a9K+vUWzIyd7QtAQcN3+u/
         8IPg==
X-Gm-Message-State: AOJu0YyaeDcp8kGaJNK2Sm/NTxmWogWsiGaaFvfn7/NfwCbYvrgTELdh
	pdqnOf1CKX2kD1WVAoL6+DB3y7K2joL0yG+zvn/kx6lqKndE2vnmaVuWFLWbF08bkqTkrDuiccs
	FpNc=
X-Google-Smtp-Source: AGHT+IFCpqPOUE/sXLqczrKQkObkL3QnvdDiuIHZfoqGDrbJFyO/nmDhnRqdZe2MfDI+A/gLdsvh9Q==
X-Received: by 2002:a81:81c1:0:b0:611:48d:5274 with SMTP id r184-20020a8181c1000000b00611048d5274mr949320ywf.15.1710972363010;
        Wed, 20 Mar 2024 15:06:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cq7-20020a05622a424700b0042f3e288807sm4615350qtb.95.2024.03.20.15.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:06:02 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:06:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 21/24] pack-bitmap: extra trace2 information
Message-ID: <d38ebeba41993f014dc66664196d7d19537c0eb1.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Add some extra trace2 lines to capture the number of bitmap lookups that
are hits versus misses, as well as the number of reachability roots that
have bitmap coverage (versus those that do not).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index a7c36a977bd..be65f637cf5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -116,6 +116,10 @@ struct bitmap_index {
 
 static int pseudo_merges_satisfied_nr;
 static int pseudo_merges_cascades_nr;
+static int existing_bitmaps_hits_nr;
+static int existing_bitmaps_misses_nr;
+static int roots_with_bitmaps_nr;
+static int roots_without_bitmaps_nr;
 
 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 {
@@ -1040,10 +1044,14 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 
 	partial = bitmap_for_commit(bitmap_git, commit);
 	if (partial) {
+		existing_bitmaps_hits_nr++;
+
 		bitmap_or_ewah(data->base, partial);
 		return 0;
 	}
 
+	existing_bitmaps_misses_nr++;
+
 	bitmap_set(data->base, bitmap_pos);
 	if (apply_pseudo_merges_for_commit_1(bitmap_git, data->base, commit,
 					     bitmap_pos))
@@ -1099,8 +1107,12 @@ static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
 {
 	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
 
-	if (!or_with)
+	if (!or_with) {
+		existing_bitmaps_misses_nr++;
 		return 0;
+	}
+
+	existing_bitmaps_hits_nr++;
 
 	if (!*base)
 		*base = ewah_to_bitmap(or_with);
@@ -1407,8 +1419,12 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 			object->flags &= ~UNINTERESTING;
 			add_pending_object(revs, object, "");
 			needs_walk = 1;
+
+			roots_without_bitmaps_nr++;
 		} else {
 			object->flags |= SEEN;
+
+			roots_with_bitmaps_nr++;
 		}
 	}
 
@@ -1975,6 +1991,14 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 			   pseudo_merges_satisfied_nr);
 	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_cascades",
 			   pseudo_merges_cascades_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/hits",
+			   existing_bitmaps_hits_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/misses",
+			   existing_bitmaps_misses_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_with_bitmap",
+			   roots_with_bitmaps_nr);
+	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_without_bitmap",
+			   roots_without_bitmaps_nr);
 
 	return bitmap_git;
 
-- 
2.44.0.303.g1dc5e5b124c

