Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D91A2547
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393039; cv=none; b=u2GRHSkBo3wGdS64nljSAMIB+BN9Wvwgh1qoh9hq/L0LlZ1+52ELyvXlEnhUKh3SmPtkaR6VnNcWq0XOLqA4eU/h+TXZ2ZOcfKiS5QB33uAdsLoqFHwewGuZ6N47KQFKn7MqSEPh1mo1ngz+dM0mKnEVG6rXaBd3Pk0UoGmYPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393039; c=relaxed/simple;
	bh=I4jXcrN75TlD2TzcUGUBo7/+KIGQQTrC9t2izNb3uz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqh4uLzAJWRI8xVpkn/syX4XS7bCYWNuyc6CrHh9C5HGrqcf4GpTKkvl7umCZXpXjL5e/nNmJCqhrit7TDAS95F5scaGt9E9y8V+fezeEMxkp+ICkEr4GkdENKdyXJ63EuESxXg3b1Cwu16ORX820tp0c6722Zbx3ahgJDsCoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eVrw/a/E; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eVrw/a/E"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a2424ed00so31678717b3.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718393037; x=1718997837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJLn94MkNXaZgZ61DARlqmKKQ1UD6hKSlMDRmx/xQqM=;
        b=eVrw/a/EgMwhrc/emssU3QvQtZRwG7XKBVilobROyXzEtCQpgRmSPg9GesxdSRJVO5
         SEfNGREGCbHTd+zwIqusCedPA7q1McHu074qB/jxH1gGtBTcxjgrR4CBkOX9sTtfdyD6
         HOxBYJQZ1KYsA74mLvKg0RAeOZRTyrkCcWDJN2EvH+niy1kty8N+AGTMovTwVvgdbW0Y
         aBM4QQIhN+DMBPIRoYQZ1Seq1kgDiLQwZ6wzyYz4tZdp8jai5Mmy6lFsPEGs3OUXm9s/
         io5XoVQ3I/Fx8Bb3M3/rOvswYdxUG9kqV26Y5hgLWKDCQnmrEFMbVgPZbfOaFsMG57Q6
         vvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393037; x=1718997837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJLn94MkNXaZgZ61DARlqmKKQ1UD6hKSlMDRmx/xQqM=;
        b=rBsraBgstUR4In1HAQxuw45Jn/T7XU2+a74hjv46rctT94D9LZOz0pWXggKQZak51p
         1RN3VJE3uyoXGSA6cEPjtdjdiFWQ/biC2bH8HmC1u0IunoWd2ZGTBsgo51oYtZ+Ru3LA
         WNPJQWog+wXPzALSkO7Se68JNhkAlme4zQq8s2zGTyd06GKqmvsiFxywKKpV1tPSWpF6
         DtKDc2T+HO9ai0zz/soIifXfefOfMhfXDq3vEnPVQbEdM5lW7Plr262pXJYhXmHFsOcC
         Tz2SHbslI79IcT91NmiILK5679NtMu8cla25RRSbEVqcAOe6vmf5Ks75oMfBgQ4qzFU9
         BZqg==
X-Gm-Message-State: AOJu0YwcU4Z5Al6R3mlIhjhaq44e55xR5F5XsVexszbesOxnK73FpYLu
	4BLLtQeDZE1KH4mLQ/AXMNJQYKJDZc6+LgD2+153qU3M88Z8//vuzYzxYBv5EyoHOVthDoaPLLF
	5q2o=
X-Google-Smtp-Source: AGHT+IHMbLIHp1uDghVuB/FhOqRNsJ3p2oIQBZ0i/agvbLxbTMR+Y7O5WAueH3eumIcg4fdkcWKiUA==
X-Received: by 2002:a81:8d0f:0:b0:631:3718:584a with SMTP id 00721157ae682-63224fe8edemr32568547b3.50.1718393036863;
        Fri, 14 Jun 2024 12:23:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf2a91sm21575956d6.10.2024.06.14.12.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 12:23:56 -0700 (PDT)
Date: Fri, 14 Jun 2024 15:23:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] Documentation/technical/bitmap-format.txt: add
 missing position table
Message-ID: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1718392943.git.me@ttaylorr.com>
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
 <cover.1718392943.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718392943.git.me@ttaylorr.com>

While investigating a benign Coverity warning on the new pseudo-merge
implementation, I was struggling to understand the (paraphrased) below:

    ofs = index_end - 24 - (index->pseudo_merges.nr * sizeof(uint64_t));
    for (i = 0; i < index->pseudo_merges.nr; i++) {
            index->pseudo_merges.v[i].at = get_be64(ofs);
            ofs += sizeof(uint64_t);
    }

, in pack-bitmap.c::load_bitmap_header(). Looking at the documentation,
the diagram describing the on-disk format (prior to this patch)
suggested that the optional extended lookup table immediately preceded
the trailing metadata portion.

If that were the case, that would make the above code from
load_bitmap_header() incorrect, as we'd be blindly reading into the
extended offset table.

But later on in the documentation there is a description of the
pseudo-merge position table as immediately preceding the trailing
metadata portion of the extension. And indeed, we do write the position
table in pack-bitmap-write.c:

    /* write positions for all pseudo merges */
    for (i = 0; i < writer->pseudo_merges_nr; i++)
            hashwrite_be64(f, pseudo_merge_ofs[i]);

    hashwrite_be32(f, writer->pseudo_merges_nr);
    hashwrite_be32(f, kh_size(writer->pseudo_merge_commits));
    hashwrite_be64(f, table_start - start);
    hashwrite_be64(f, hashfile_total(f) - start + sizeof(uint64_t));

So this is purely a case of the diagram being out of sync with the
textual description and actual implementation of the format
specification.

Add the missing component back to the format diagram to avoid further
confusion in this area.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/bitmap-format.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index ee7775a258..bfb0ec7beb 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -312,6 +312,15 @@ the end of a `.bitmap` file. The format is as follows:
 |                                           |
 +-------------------------------------------+
 |                                           |
+|  Pseudo-merge position table              |
+|  +----+----------+----------+----------+  |
+|  | N  | Offset 1 |   ....   | Offset N |  |
+|  +----+----------+----------+----------+  |
+|  |    |  8 bytes |   ....   |  8 bytes |  |
+|  +----+----------+----------+----------+  |
+|                                           |
++-------------------------------------------+
+|                                           |
 |  Pseudo-merge Metadata                    |
 |  +-----------------------------------+    |
 |  | # pseudo-merges (4 bytes)         |    |
-- 
2.45.0.33.g0a16399d14.dirty

