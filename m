Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD93145340
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715108; cv=none; b=ldkn1dxGFTiQvPYhG9mzT+jevroQSs8Oh7MGiqfrSgKzPBFaEZanTUz6Cc2UpYZqfUQzI8qzWLd3IkNYRLwxjpBTb5mj5S5NjPW3U3ebbFJPR+LNJnt8MqXOlwFDOlxF87KsFdMUnMKGdsc0FPNlPIr+VqeBsWCyH45yEsQFU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715108; c=relaxed/simple;
	bh=d7yb1MkZ1pzoP33tv+pwTcQt5kBPD+zsloB2eZbZX3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oegw6fyLkBj5cghs8kTQuaN3mxD82qO4xp+hHvnvRs0qZe8IuSon59loWiWcbiwrtUD2czLtiIylErNhAGc6zdXpGpg6MCKgSzA4SGrjAI34rL4JH73phZozTbBQbr4P5L8W/UY0mUy/natZi9DLeuBG+q/IenrQk2XFwX2oxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1RHwaJAc; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1RHwaJAc"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-795004bd75dso92000385a.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715106; x=1718319906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXcxJyt9JgMl7vfM8SQYzGKD/c7BlhJ4KGIF9sFn1v0=;
        b=1RHwaJAcTKxfPveVuM0O91oLqSRHyEyg2hH5Slug7Q6NNR5s/NyPbiPkKCawtzaTsF
         P++/Wxr+GkrK/dtj1Fx86WM0N4JdJ5+8j3kG7UQ4PP5nrrpncMLRzCLhHBxPhCNcJODH
         UPf0gXHmSv/O7SL3PrTn01kjDMmo3tT/HWdPbbldig6KVZYB8R+lf++jL4W7MRHeHj20
         onJe8s9j01iH/pWCjUHplr/KDOWWUtFviKc+3JCTrT5c6HDkVLyqOfATdAdIffAX6bVW
         dCIUw9UjKeD3V9BpPRaxBSN2Jfuzynek+/PsqD4xVsVOiNpXfGjeqFpUJCTKMyLyh2rZ
         JDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715106; x=1718319906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXcxJyt9JgMl7vfM8SQYzGKD/c7BlhJ4KGIF9sFn1v0=;
        b=PHaMBh3aI1JYmAsbQaF40mCiafag5EIr2XFW/FL7/lmrpMP7EgT/EXku/0kEbKGzPO
         mWu6MG0Oa/FCkxJ+AEUC7h1/XP3FhBGteb81/BD8sr/lNJR31nVeaxnDfiJ95HKkZjTS
         M+BDN7k3oqNjUhRpAsXcTnHmpvPmqgVcH8UcpSz4H3k3WvpVVacCnUBc3R0cwNTy6u+D
         07sFY/Mme41wOghu7f4x6oIq3VnkdLtuXIJxZvm+IuAr5HwuYs/KcV69wM934Jod1cB9
         dQNw347gcVwVAfVT41PsVk+0nB+MV0FbVNFx1FiAwfXijcc3+AhhJLPFdYFxqFaK+ngZ
         7CoQ==
X-Gm-Message-State: AOJu0YwAMXMyKp1U0xKTr78WfFJ33npeOFoIVWUpjJhdokz2lXUGPSqW
	UWKT7BoJzdKpaU86j/wE+W24SF+0JRfaWMQvQSwLy/wXViUxqj4Gw449PwqNVBoDEa/cQo5ObO1
	LyxY=
X-Google-Smtp-Source: AGHT+IEIvruCNP2aweSWIkVPz6Kfw6eLPBPzn1yOpCaQBs2MxQZ3IgycMCMNNIpJ1ezL7rrdN0CyEw==
X-Received: by 2002:a05:620a:458a:b0:792:91bb:9ca3 with SMTP id af79cd13be357-7953c45fe7fmr118576785a.37.1717715105844;
        Thu, 06 Jun 2024 16:05:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79532813981sm103624185a.25.2024.06.06.16.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:05:05 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:05:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/19] midx: teach `midx_preferred_pack()` about incremental
 MIDXs
Message-ID: <53b71c6514dac9abe7472d95842b7be5675b8a4e.1717715060.git.me@ttaylorr.com>
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

The function `midx_preferred_pack()` is used to determine the identity
of the preferred pack, which is the identity of a unique pack within
the MIDX which is used as a tie-breaker when selecting from which pack
to represent an object that appears in multiple packs within the MIDX.

Historically we have said that the MIDX's preferred pack has the unique
property that all objects from that pack are represented in the MIDX.
But that isn't quite true: a more precise statement would be that all
objects from that pack *which appear in the MIDX* are selected from that
pack.

This helps us extend the concept of preferred packs across a MIDX chain,
where some object(s) in the preferred pack may appear in other packs
in an earlier MIDX layer, in which case those object(s) will not appear
in a subsequent MIDX layer from either the preferred pack or any other
pack.

Extend the concept of preferred packs by using the pack which represents
the object at the first position in MIDX pseudo-pack order belonging to
the current MIDX layer (i.e., at position 'm->num_objects_in_base').

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 564e922533..cb7b623b5d 100644
--- a/midx.c
+++ b/midx.c
@@ -497,13 +497,16 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
+		uint32_t midx_pos;
 		if (load_midx_revindex(m) < 0) {
 			m->preferred_pack_idx = -2;
 			return -1;
 		}
 
-		m->preferred_pack_idx =
-			nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
+		midx_pos = pack_pos_to_midx(m, m->num_objects_in_base);
+
+		m->preferred_pack_idx = nth_midxed_pack_int_id(m, midx_pos);
+
 	} else if (m->preferred_pack_idx == -2)
 		return -1; /* no revindex */
 
-- 
2.45.2.437.gecb9450a0e

