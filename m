Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B110155732
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760957; cv=none; b=FOkMgLBV9DnpWMHgJHp23YYjtHrH/5Uu7pFPvvfgp3bs8qv0gGq9E9vaUWhR5amOJ8KLICvCRKf3/H1c2xuQaN1zYP7Ow6vN/4V4/mhRohef3WPZKXMyaPj0IfoO0KdGpjPMeiQwH+I5/sVY6erY5xEZK21DHCM0xjguXYPXNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760957; c=relaxed/simple;
	bh=aVJTg+WQTBfnWbKVhrLnlAbnIXS5sQnM+pLBvDomHKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqOiybAJhu3uxuyxwZgkng7QuGlc2Hgqug+MAOfROvxcy3uBCGUJnTgpwMKH0rL5NVX9Y+ioCHypIj3JM1IGiBr4pmsF1P4mToUdm5BCd2WBkM127gJhKOte8m4RVyCQkPm1bFP8tk3crZwshWSw4J2d8LCVCsKhTOQxJBDVmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Fzt1Xdrj; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Fzt1Xdrj"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-690af536546so14415727b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760955; x=1724365755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJJjjljJmJjzh5CXSIPmQlY53lAKEdTONAOuWTAY+d0=;
        b=Fzt1Xdrj4NmgvrMh1aK9qLtZNNsVXCQoudRH0Jte3J5aYhWPf3UWMzB+6+BqTlvRQA
         7tmDcIOPkEp3AR/++OM6ZyVQlHvLvAGMEVfPAkl0Bhj8DGVsUXIZtjOLgdislksjBuIf
         vuai2UG/vzvJ5cgO3yBS9yKaPKbGYnNS65oxC0291jeKhabQCEIWOe/q2MmQG4iRlUCs
         9c3/rSTID2vV/sjtlx1FEIrpPCdudtK2PxrE8Wz22WVjYuLExnh1PP62Q9nxN7squ9u0
         9ThJFe0ndR3Xy6NN+7U27FndZGigPdLJkAzi9tMcBZeAPD5dLiUIGtkurjuCBwus7TcJ
         4evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760955; x=1724365755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJJjjljJmJjzh5CXSIPmQlY53lAKEdTONAOuWTAY+d0=;
        b=m1SAD2vgOih3gzbsFUaIYzk3K4wZi+jSw9qLQMNXUirGyOs7+J5b9ERe98L3ZtLFTg
         VXN06IFk2tMEft4+sIgE6WpC9eLimvy2ztjXh7iuPiZPNCP1U3+emkT6c31UxyGqQ0hH
         X+UgMZdUf1odd0FZCVOzswOFRmWidRhuCz+3Z5JPmrMS9CcZqHsaAb79nDSEiMqqHs0O
         TZssTs9f3NtQg0cb29FaA9/n4EOPJqUk/FfHhOjZfr+aJFr7rXeuGb/KS9arwd9Fiduq
         47snXWcm2oSaugMhl6lNbqUOxsqK+m21SmIxbTl/BbUU5OVC7N+Y6mEaUCksEr3LlDnz
         20Jw==
X-Gm-Message-State: AOJu0Yz6nVWJkQqpsIqc8MBuU6SSO3/qRQCjW4oSLd2Ef+TV/C2uqzSe
	sWMNwV2yHdFz+4SVbXta/JBUwk9ZaQPAhGytrMiABsGWtHXfsfxNIYSKuv2nnHA9mF8XTPFMAGZ
	m
X-Google-Smtp-Source: AGHT+IHkChuESEKuudymzHso7qMOOfILEkP99krNxwNuaCq6mWEH5hEYuoMyJrGmY4qS1+MfJ7E0tg==
X-Received: by 2002:a05:690c:f94:b0:63b:f919:2e89 with SMTP id 00721157ae682-6b1b7a6ac54mr12629467b3.2.1723760954711;
        Thu, 15 Aug 2024 15:29:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7aab2sm4148017b3.77.2024.08.15.15.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:14 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/13] pack-bitmap.c: compute disk-usage with incremental
 MIDXs
Message-ID: <5c909df38ad86eb09ca92eda609cd8cda81edca9.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

In a similar fashion as previous commits, use nth_midxed_pack() instead
of accessing the MIDX's ->packs array directly to support incremental
MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5fea2714c1..d3bb78237e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1774,7 +1774,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
 			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
 
-			pack = bitmap_git->midx->packs[pack_id];
+			pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
 		} else {
 			pack = bitmap_git->pack;
@@ -3020,7 +3020,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
 
 				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
-				struct packed_git *pack = bitmap_git->midx->packs[pack_id];
+				struct packed_git *pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 
 				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
 					struct object_id oid;
-- 
2.46.0.86.ge766d390f0.dirty

