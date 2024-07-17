Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087281850A0
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250762; cv=none; b=piO2c8D4R3H23PTxMXIqc5e1Pf2G3nPSQaH+EkEi+ErPy9ysd0s6AJ129YoaSCysNZF0HGMKVOlSlWqMnHT1e1k87rtp/IyLLUVoosmoIbyM9orLI1NClx899BIkpADMbE42OmFpmakKqr2xwAk2S60Cb0Md/vUS2rgNhJYyN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250762; c=relaxed/simple;
	bh=hk+muef5xEL7uvfylUoJxyYDu+naAELbOYZJY1cPx+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqQsnrfe0ixsxhu6m7E5ZGEBpWP/X9nZgKLgwBKK8BMMzNHOvpdPqe2OyUI5fvKr3ZqucI+oAE+Fq1TcAa5NA0ANdBdXfkxLsPynHWZPbvhCjrRmEyAMC3ecqmqk3jC9coKlxZaaInVZDPSdvMu6dSD9bxD18DM6egrF7ODJE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=q+0qnDlS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="q+0qnDlS"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6510c0c8e29so903327b3.0
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250760; x=1721855560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAakTSQquisNdf+ftCvXBOJ4qymHPREWzr12EPqTS48=;
        b=q+0qnDlS+Ritx1V1wkrsHuea5ZUw9S40/tVOUShfW1iegqQ1SRTDY9APfxLr+8TsTW
         m2LRMuTCnUJn0W+1u9Gn1NRkgxFFxmC+2OWyz5esA7Y3X0MP3YL4EckJm6Co9X8miogr
         BS6svuVvclRLzDFp5aZA1POcqgJ2W0VCSZn+jiYpCvmtnD0i1/YY6az+PxtxWaf9m1a8
         /QVsRuMp/cvacKBZ8FXluZFmowZVbCag4TR6TXnad8B2VwRDk6+r8WO5QvGWgbEkuJt3
         lcGKy/m9kXLYleVkRp1xUW55wNBcI3RsJ7vYslUzcf5Fu7uRVlF6moEkEEPuEJxz7Ce9
         L1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250760; x=1721855560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAakTSQquisNdf+ftCvXBOJ4qymHPREWzr12EPqTS48=;
        b=mFjCw8ECtLU5vu+cx+2YKt1DNx/4QzgobPwIaw9nqoiIBJxnkXgJybja9JWPy4nmJ3
         M19fXBIghCmm15E21wIhOWvntUw3KfX+Qxvv+Lb1Ja39Jpsc0RVCX4daK5et5Nn+Puc6
         GFCPV/dEWGtwwZC8Vk6sCeN+3LxgfFa4IaPTtqhT7suxBlOJUVCwfq6sHxUuOCFgSPYP
         I0Pdr3dd+/3H+Eaq8bvXJn0b+ENpNztKgEqvbyB+rxBZ9iU/GJLgAZw+8HR6TR18UTi1
         aay3Gqqbaa12tA4kZzIUkR7wNejQ+3Fv6uUsL+MfcN+8xd/m8ZamSrdZCAEFHb31oOWt
         RWhQ==
X-Gm-Message-State: AOJu0YxPuSNSiF+eEAO3ToxpfkZIzq+0Ea9UaAtK9thJy7iaXVQTPUb2
	2ZLOHmC5DwqJSlInwkbAV5gcA1nqj+PLKhh3gvuYPY1CMEIwfFURg+IhPGRAfrCkVwgEvcCa0Cy
	v
X-Google-Smtp-Source: AGHT+IHknfbJAOEqVCpPkr9lgoaRwVzJqGO2kwKeqVObvpqF7uo3GW9kjn7VaotnN04h2Hba9i4Wcg==
X-Received: by 2002:a81:87c2:0:b0:664:5957:f7a with SMTP id 00721157ae682-664fe93537emr33740297b3.15.1721250759922;
        Wed, 17 Jul 2024 14:12:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6660249148fsm766727b3.61.2024.07.17.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:39 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/19] midx: teach `midx_fanout_add_midx_fanout()` about
 incremental MIDXs
Message-ID: <594386da10bc3f3d6364916201438bf453b70098.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

The function `midx_fanout_add_midx_fanout()` is used to help construct
the fanout table when generating a MIDX by reusing data from an existing
MIDX.

Prepare this function to work with incremental MIDXs by making a few
changes:

  - The bounds checks need to be adjusted to start object lookups taking
    into account the number of objects in the previous MIDX layer (i.e.,
    by starting the lookups at position `m->num_objects_in_base` instead
    of position 0).

  - Likewise, the bounds checks need to end at `m->num_objects_in_base`
    objects after `m->num_objects`.

  - Finally, `midx_fanout_add_midx_fanout()` needs to recur on earlier
    MIDX layers when dealing with an incremental MIDX chain by calling
    itself when given a MIDX with a non-NULL `base_midx`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 478b42e720..d5275d719b 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -196,7 +196,7 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
 				      struct pack_midx_entry *e,
 				      uint32_t pos)
 {
-	if (pos >= m->num_objects)
+	if (pos >= m->num_objects + m->num_objects_in_base)
 		return 1;
 
 	nth_midxed_object_oid(&e->oid, m, pos);
@@ -247,12 +247,16 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					uint32_t cur_fanout,
 					int preferred_pack)
 {
-	uint32_t start = 0, end;
+	uint32_t start = m->num_objects_in_base, end;
 	uint32_t cur_object;
 
+	if (m->base_midx)
+		midx_fanout_add_midx_fanout(fanout, m->base_midx, cur_fanout,
+					    preferred_pack);
+
 	if (cur_fanout)
-		start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
-	end = ntohl(m->chunk_oid_fanout[cur_fanout]);
+		start += ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
+	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
 		if ((preferred_pack > -1) &&
-- 
2.46.0.rc0.94.g9b2aff57b3

