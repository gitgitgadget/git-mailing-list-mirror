Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347301494A8
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318192; cv=none; b=ew5KXVeUID3A9DZ8FSU8KvgqNYaV8tKSZtPZHQxAE2aNhUgYCmMHPcLSB/4rnO3woSnaPE0Tuz7eBYYcMWFt++vPUSOvO/gksrnOoZAalnCcihFHEKrES2SsnF8gXLoe7ax3uYq/fCQCSZao5VpFXuch+t3/oIWaLyJ1JFnU7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318192; c=relaxed/simple;
	bh=mEi7eF8WlJT6PpcmCVxstk7i6MgWCA1cLd2rI7kGJ1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beoG460mto2BdnwA4BnKme0IAELHlhpxhJhfoCNnius7VEYi1zpyg3QN3cTqBs6knrRCc59ePRUdUGiWoYNr+KJlJ6rKE5hAwmdz83Z/MSdrXYRQSZcSKrSNKXPS3GQ01sxyNSOW/2106ysTWHEwb22rnQStP1+tEOxl9lCtEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FhimWOAE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FhimWOAE"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8d989e8so12481485a.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318189; x=1716922989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtCxJ99lL4q5myAzy5XypnKvMZZzYm7fExC2YIFRo0Q=;
        b=FhimWOAEP72bzpM9+HoTm0isuzw94nmpoLcSkmmmxVMikcYIvoUm6tync6F8H4PGMn
         HbhdIeleTv5P42FJ3dz0p4lbElwP1bwhmiiNgY5s9IjvPKoTaMPUgPbmNATSjaJB+Dii
         NkuvcuuyLAk8xQEjnuydI7MOlMRhwjmWvj/McpZDhSBD1TLqW4cITr1UVdLMyo+uIWxm
         8dxIdYQGq7FtH5MuNN+ciO1LgtL9ujNasNZlBh0VN6p706gg9tnAHl+aAY5UajfBldcl
         lKf16YItERnOhNuxJMR3qiaWsJzkzyY9Bn4migRcyCMLfatwTEqlGjZ8n7GZ7exQIjg2
         k+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318189; x=1716922989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtCxJ99lL4q5myAzy5XypnKvMZZzYm7fExC2YIFRo0Q=;
        b=XizJNtZLOfS/MF3vkiArsMSyhYFmlF2dS+tl+GMixURFRwqSl+qyO4tSLY2GjAXEsk
         a1FNnRQMeoYqvl0KNLuR11QvHOOcV6e8DnUGEluSxCk8aYdqgBTHHFxdxMETEUJURRJk
         WmzmRsixsLTRMC2NsD6YSbbM7nATot7Vo2NbvbrWKjtVom+BIH//c63v28SuGRF20A45
         OJIE9uJcUYwTKVdg+TlDbQa8RAnazTNPEvBlntm+KbaXLlmYSUImAC+TeESKwXVYI9lY
         hLBaAuu9YKeWEeQsFsn+s6BaXjyOKg3GbtB7lO6Pxa+eeqoLI46uTGU8IggsZZX+/BH5
         TqCQ==
X-Gm-Message-State: AOJu0YwqZu1aNbTKdw4OKT4SfHp6hDiNaJpA4yhZcsNYq4b01ndx3hrJ
	Kvi+/cRTZvbQC0eJG/gGxIJTz/tJ5QSTott/C9kvOFDpjcz6QEvkIz9QVShwmtwdsj2SnXN2NeN
	s
X-Google-Smtp-Source: AGHT+IFWfSYW9RZ620LqztV/RcglViLT/rnr5qT2mnS/g3Eh9RI9AIPT5cOcRgeiDHk9xwBImwf0Mw==
X-Received: by 2002:a05:620a:458c:b0:790:a960:28f4 with SMTP id af79cd13be357-79470f0c0e7mr1802004985a.25.1716318188938;
        Tue, 21 May 2024 12:03:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d922esm162191431cf.22.2024.05.21.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:03:08 -0700 (PDT)
Date: Tue, 21 May 2024 15:03:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 27/30] pack-bitmap: extra trace2 information
Message-ID: <a34a60c3ef87cbe707ce165adb87a769e6e25296.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Add some extra trace2 lines to capture the number of bitmap lookups that
are hits versus misses, as well as the number of reachability roots that
have bitmap coverage (versus those that do not).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e61058dada6..1966b3b95f1 100644
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
2.45.1.175.gbea44add9db

