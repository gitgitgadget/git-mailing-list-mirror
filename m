Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED05145340
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715105; cv=none; b=AaboT0R6g9HRTmo2LzV9eLkNFdb/9+tS03LbK4yNQVN2/ijAmrAfYiYy7BGfO1EbrHlQnl1CLNp0Olv6Ma96NETk95cVb5Z7Cil4HaHBJKyi2NVhDJn247n3fdjd7gLsl9VQO5xNZ+TAWpYVKsBcdFun/YHEfkXa+L5adz7ZS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715105; c=relaxed/simple;
	bh=wZkMPJXgxN+jJ/mpkGELC6VTlJjyUb6fGqGFJZJh4N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaD7w6yCS4U2AOzNWfZpvA+EEiTr9VBsyp3Sy5/P7nZKmN+tZukBAoDiVjinDi9R9BB+ij/Avqls+EuasYN497WOYFJngwx+SX0StSVDKS3pPL7MJL+PHZq5kGo0ggBA8EXNigT7wFtxvksJFJnjIYWGVgCsA4J9wQ+ZrV/RmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=J5DV97pN; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="J5DV97pN"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44028fc3d22so5987671cf.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715103; x=1718319903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IsGWTT09U0jo7NzjPDH0aF6BbG115ADPoCDm5mLfg4=;
        b=J5DV97pN1zCLDdLSiA1VqshBt5T5kV8Dxlh+vltIXECDjrGqtl2ieH4wlcULcbxp7x
         AdnCvsoDD0nN2sIedINCUeCNYNUKIxq6IFrHC0uJ9Ma0GHjZPfcN5P/+Ji2CEQJ2PViX
         +jeO5h9UScSq2MMEjVYxGMMUJPsVlocxlH/WrRNijIdmze01Bjd03Nyc9ZuDK5wJXySu
         CGb1LHqMtaVLfOtqfZj6T5wt32RnS301wE2lAUpylb/bU2pyPimqvjlpCYkiLE0DW+wP
         Ga94p3pDq4wjZd0HAP+8AddjebWX0QSGFphY/0nigKmrkZmeaHkHyObDEBeX+1L0XExf
         J4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715103; x=1718319903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IsGWTT09U0jo7NzjPDH0aF6BbG115ADPoCDm5mLfg4=;
        b=sdzDG/yiYdLpAoXs8WJuD5OCeeWGLtNwbQexLFE9DEdTc0gbnoJJ+YSSq8v6WulhzA
         Cs5T0N9nOC+S4ziFgTzGR89UnIYQwT/U20gyo1PcxMc3bqwgJJbnCLUtw/HQY4NKWVDr
         JWtcAn/+LLk597U6XOtz7XrTRuJneUqF0OJv3FJzFaiL9O2VinuY8YtxVn/iEl+Uz08M
         jIqeoqCNvkvTNGSAyexpu+8Iz8peckE3rFfDH5wIMd7PSN6okWsNLPbnRBruCeVUubfW
         GhELbt7jFQWzMWyrCSxoJ9TIv+/rk/K0H6jD6dMP8YaHqQobkv49Y4JfC9E46quMIFKm
         OGoQ==
X-Gm-Message-State: AOJu0YzAbVhdl8ZDIfPVisYcB3IqsULOcMYVqaRLsMPfCj09h0nROQLZ
	vOWRY2dy7UPvqkMm1ADRFW+La7JqRtmK5p3TLjItHsmxFvkYzQC66pH/pbd0WZ3TD9gTU+UwFig
	UzUI=
X-Google-Smtp-Source: AGHT+IHnGvKgW8pDFjWJa3AmLYRtcdD20SiJ1k0vGcwQSX0sAiRSEfTMum+yxT4KD74Jo9Pq1zpOkA==
X-Received: by 2002:a05:622a:1a09:b0:43e:40bb:a0db with SMTP id d75a77b69052e-44041c12b17mr11429281cf.54.1717715102754;
        Thu, 06 Jun 2024 16:05:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038b5e617sm7543131cf.93.2024.06.06.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:05:02 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:05:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/19] midx: teach `midx_contains_pack()` about incremental
 MIDXs
Message-ID: <2288683674ba6858d1ea217dc7f84bff269024b1.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

Now that the `midx_contains_pack()` versus `midx_locate_pack()` debacle
has been cleaned up, teach the former about how to operate in an
incremental MIDX-aware world in a similar fashion as in previous
commits.

Instead of using either of the two `midx_for_object()` or
`midx_for_pack()` helpers, this function is split into two: one that
determines whether a pack is contained in a single MIDX, and another
which calls the former in a loop over all MIDXs.

This approach does not require that we change any of the implementation
in what is now `midx_contains_pack_1()` as it still operates over a
single MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 186d8344dc..564e922533 100644
--- a/midx.c
+++ b/midx.c
@@ -462,7 +462,8 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+static int midx_contains_pack_1(struct multi_pack_index *m,
+				const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -485,6 +486,14 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 	return 0;
 }
 
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+{
+	for (; m; m = m->base_midx)
+		if (midx_contains_pack_1(m, idx_or_pack_name))
+			return 1;
+	return 0;
+}
+
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
-- 
2.45.2.437.gecb9450a0e

