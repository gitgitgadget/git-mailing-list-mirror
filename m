Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3D2063DF
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983518; cv=none; b=BiszIJqOzdWLiSF8nLRFuYZLCJOcRXJHPNbKuVgqI9XlSjxSFlsgOHmdR/Y6tvCsNgAaAKg4wLM2JZiEKiBCON7lPCs2Mnn4tyQtLOlLDs+3SejleXhQfZrsrtNr+HAdqzeB9jbQPtIclkAKBcJBDutDPTYbQT1/Z1T2fZRee9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983518; c=relaxed/simple;
	bh=lIwvvQmVXJ0GbYL4ALqpDZLu/R97BKM8Z72m+yyE1Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaJhjM5elGBegG2mBpJLC+SUfbvD0RXrRPxjk5bEdyZ/j4eScUF8vs/9JF/S2zzBfBWOnY0QwQrXBe1W3cr/SZ1tN1BWaAIELZOgbw9a5Nu3ADWhcP9MItFkHnJhOlIT7n8rgquvz436iZc2Gr1ZUDC9aAleoLQ+YRRnSFGq1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NyH+CeSt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NyH+CeSt"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c24ae82de4so284518285a.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983516; x=1742588316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VEmdPrpEdUmpvGFdaIDqrXWYbn4QIFeQ0SZ8NgIwwg=;
        b=NyH+CeStX8/cZDsnaPJxP6CB9p/fwDz14/sjD5gCsXMyBo8jBdZanQLh/nuvad0X4p
         6wpq2AB7rbtuWWq09EHi1y75pqPn06M922ZEHGcPd//fFea8NG6uxY5A6EA3zh7YF5nw
         6Q/NazfWo6ne6S2AEyZt2yAVTubhXePqRiZcZjQ4nFLExNM6ApM4vLnkFMFhjHgHtHUO
         p6xOECfDRARbsj4QCozf73DLeitTk3weUBhTsy6o0GKp/ZwnQVPhzkYkuI1gNgNXw3sT
         qQDNqX4feBHSGGHpnqb+Na4lZRdHjCQnKtlnFTAwvHlIHL7kVq6bpNM3+4Pi65PxbLBB
         qHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983516; x=1742588316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VEmdPrpEdUmpvGFdaIDqrXWYbn4QIFeQ0SZ8NgIwwg=;
        b=kVhFF9rQDQgMNP2CBUdpr7QiP0BXUcI7HlUt9DyzSpgnfu3U86sAH6y+F1hL/hw9Ve
         89GFQnd2rKuryXJ1C3CjBOA2jgxXKivHvZu/GnOmAJuu2RB+XUwwRcu7WwfIhevPhIVi
         h+wQvUnLRjoFCYfrF9SmjU5NE+pWO++wCQcagtB8JLQAu18T6HcRxEJoWSsFXpm3qzbJ
         8Xpz8MJmlvQ/gSJ42PQDkwVfCY3ugPEEnquITw+nhxske7E7uTOfsiLsMPEtsoTx3+pC
         Ox8wyB37v6IG4R/GL1zoyW5cA3ALePdKPYbmXoH98OgSRPD6wkKfXjl1N3QO2s9wILc/
         oGjw==
X-Gm-Message-State: AOJu0YywVNow5Q+K87v64F/R6xhqcyaBF9mfrNKauf9DKXkw7sB51Oj1
	zdm1D2ApUZOKRpvRQ95KQo7R/x7pVJW8xc5si9gD/EhtvGuHUPU+cobzErLq9g4gclGE+HqRV8a
	lr9s=
X-Gm-Gg: ASbGnctpe4C682DQd7mjG6iYqYS3LDIQtaYNxQxiszbOAG1xn27jggu3/mL7OokYnRZ
	1DhDgyyRspgDs0pBUF3ZoHD3CuRhYF0eBbJdos8lvG50/LsRAHT2/8vvAXKLXXNuqFi31j+zvWb
	u/4gaF2s+U9+Q9JOc2M0x53IYrQbulgplUQTfMw0JYPuhYWIi/yE6uPru6SSdZe5A15TlUlhhsr
	luFXMIMFUvfJaanCCYLtO3KCc5UONKFp3q4QutMfQ9WPkzAedih3ez2m0L6vpoc0j79dlYzq8O9
	h9AxC3spKFc14QwgfWMGlm2EGg++/0ag0pqXHYWRXMf65Kper8QptAmENTEI4e3q5X7QkEDdkR/
	vAdz890WFIs7YrJrw
X-Google-Smtp-Source: AGHT+IHCAvJKhCBNn3T7rvvdBSJQDk6WKAXlLQ8JLB2LL97qazUA356CWjh6wGmJNSLx7+LK2g6lmQ==
X-Received: by 2002:a05:620a:450c:b0:7c5:4c44:db9a with SMTP id af79cd13be357-7c57c8f8c5bmr573720185a.37.1741983515930;
        Fri, 14 Mar 2025 13:18:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d6fcf4sm294387985a.75.2025.03.14.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:35 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 05/13] pack-bitmap.c: teach `show_objects_for_type()`
 about incremental MIDXs
Message-ID: <c7c9f8995628f0b1de6c802688be934319508103.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

Since we may ask for a pack_id that is in an earlier MIDX layer relative
to the one corresponding to our bitmap, use nth_midxed_pack() instead of
accessing the ->packs array directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 615d5de85e..1b4fec0033 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1635,7 +1635,7 @@ static void show_objects_for_type(
 				nth_midxed_object_oid(&oid, m, index_pos);
 
 				pack_id = nth_midxed_pack_int_id(m, index_pos);
-				pack = bitmap_git->midx->packs[pack_id];
+				pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			} else {
 				index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
 				ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
-- 
2.49.0.13.gd0d564685b

