Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385BE47A53
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699266; cv=none; b=PPI6Nc4d/85v4YKniaeM66KKlNjgJKU//qcQ96xOrkckvOhlIdkVXr+UDJ3SZQ+l9aWA3w0wUI1jvJ3PvDHFAiJj8wu+agwWLjr01l70aWl2hjgejxy2lKIt4T2oMj5PEJXqiH5fqzd0joPcaWcdUhHqAC84PWEugblS9v+w3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699266; c=relaxed/simple;
	bh=Vc+EKRmmGYIVg+C0TrorUx33a8i63l/mg9RNWJqXTQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLTvjwdFaw8mwG6voDP19gELBeXL9tpMjVG635jKIV/vmbBAFakGIAZLL06wtvqNpuN29NhVErYm0co1uw/k/gFWdgsa1QtsT/bRg7b+h0mM6rvOGGMOnKR86VThtGTAGaACbKJX1VwB4TSbgqjf17WvXNF8rBwKZQ+UnxX86Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=c6Ga8FG7; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="c6Ga8FG7"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d20f97463aso223223b6e.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717699263; x=1718304063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hjENXSJm+1v3r/8IQdJmUOsdwUkpa/ZpTjR0I5jEks=;
        b=c6Ga8FG7yoBx+blk4GBHH5HeLVqXrTOGUcLT6HcENDqyuCU3o23MXoD+hSx8q5uGWp
         EYSg2SmIB7BLUKR0pdsP2S1CBzrgeRkDK1adWoZXhMNxuUuRX/Ap/fc2nd8VD6NsLNzx
         9/BVFLTvPvxy4ttJRZY3zsKhNWMmGARRQ2nR4wUWz7oNHznIW8D3nUyLHQuF2S8xo8RJ
         d5Mqrrg+3UlzpBtGZ/w+9UUOEoAeWLkr+HXht8HgEZjbQ/VlkCRcX3HWFKvcaiKxdnGn
         4xJWr0a9ih4LAKMhnl4qk/68rOHY9V3BMKe4/c8zZ1+0FXUVBu0wnxhZp4J5FVPvuczk
         I9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699263; x=1718304063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hjENXSJm+1v3r/8IQdJmUOsdwUkpa/ZpTjR0I5jEks=;
        b=YXIRH3M9nGKTsqVxD5nVrcWJOhBECzGdiv4RcPDkNWLocjObQYt3lnJctxgx87qMK4
         3qU+JLzuU2V1pHf5L2d05Mpzz5isHQRPcbhqalDbiMC63t+xRqSLeyVGbxjhhVoF6FRU
         rqMhtYEE2sQHutWPPx16SF4GUCUrBGFmiQUepnyf03ZoAIcXtR+SBsf9yE9ceRXZOs1J
         nGcLfaanXPuKCgfuvaF32OeWj5DLXua0UUOG1qGHaiGeHwkoHuCducR9cLRv1VPOdZ3C
         sPt0za0RiwCfLmsgYGv9ZzteJAfGLIayTZ/6pL6MnO+gzv6iSensKJ1o69FhHdBDgfcs
         dIXg==
X-Gm-Message-State: AOJu0YxjAN3q0LUDo00v0tcWj/EMCphVq/2hXcjnWj4HJEp09RbXlTC/
	cL146DZRr4Yvq6F595BMVlrTccNsZawTMAy+G4rPXzZNz9HaHf2Py4ZevjSV7GgRx3sHEFTLSlI
	dpZQ=
X-Google-Smtp-Source: AGHT+IGnBCU0x4aD7AtOP1kDdW0FhSbQm39nZWUXiVYVAMojdrcENy6XMhxVcs1clCHYpfEBYcJ3Qw==
X-Received: by 2002:a05:6808:60f:b0:3d2:395:b84 with SMTP id 5614622812f47-3d210f7e201mr233410b6e.59.1717699262224;
        Thu, 06 Jun 2024 11:41:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6c3a68sm8741296d6.52.2024.06.06.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:41:01 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:41:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] pack-bitmap.c: ensure pseudo-merge offset reads are
 bounded
Message-ID: <0a16399d14afd527f4db63f2a4a3b0a3cbf112f1.1717699237.git.me@ttaylorr.com>
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>

After reading the pseudo-merge extension's metadata table, we allocate
an array to store information about each pseudo-merge, including its
byte offset within the .bitmap file itself.

This is done like so:

    pseudo_merge_ofs = index_end - 24 -
            (index->pseudo_merges.nr * sizeof(uint64_t));
    for (i = 0; i < index->pseudo_merges.nr; i++) {
            index->pseudo_merges.v[i].at = get_be64(pseudo_merge_ofs);
            pseudo_merge_ofs += sizeof(uint64_t);
    }

But if the pseudo-merge table is corrupt, we'll keep calling get_be64()
past the end of the pseudo-merge extension, potentially reading off the
end of the mmap'd region.

Prevent this by ensuring that we have at least `table_size - 24` many
bytes available to read (subtracting 24 as the length of the metadata
component).

This is sufficient to prevent us from reading off the end of the
pseudo-merge extension, and ensures that all of the get_be64() calls
below are in bounds.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 70230e2647..ad2635c025 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -238,6 +238,9 @@ static int load_bitmap_header(struct bitmap_index *index)
 				index->pseudo_merges.commits_nr = get_be32(index_end - 20);
 				index->pseudo_merges.nr = get_be32(index_end - 24);
 
+				if (st_mult(index->pseudo_merges.nr, sizeof(uint64_t)) > table_size - 24)
+					return error(_("corrupted bitmap index file, pseudo-merge table too short"));
+
 				CALLOC_ARRAY(index->pseudo_merges.v,
 					     index->pseudo_merges.nr);
 
-- 
2.45.0.32.ga71ec05e5dc.dirty
