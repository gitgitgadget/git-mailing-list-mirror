Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7D4CB37
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387488; cv=none; b=hWhi/ZoJsQfVFcnX6eU4Qv8aoyRXVsAEavVOfkyLkl0tF3Kmp58chwR84p5haTuP1CLeDn+8iqarhq1Ez40NocF9WXZZQc5iQclB238k/PMfOFzyIwDMDlt8iAH7JadugW+m7Qqe/Mcse40GFoIHkztn428eIaVMQTv5QVMy7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387488; c=relaxed/simple;
	bh=PMU5iJgBD7Yr6K5/+Me/Ylp9xR1hVgRjQc02+LFjTDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4n1QRG/8OV3Lmk5cAILXyN06rJ3L8WVn0qCY/O9AyzTBq+mxiPaahnIJd84BOUttf623ho/mVuEeTSpNWOufzGNPEmTPHb2C/6kd6yDogyid/zDCEZSOZXxN+2WrjnopMf7P3fNTDtnBs0iBUNTX8ctqmbX631m7Q7qYvSSzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MCq9aNTH; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MCq9aNTH"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6918781a913so39627016d6.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1711387486; x=1711992286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KemhrkDHYlcMEokb2iN8+B7Ei5uaoqtFQJBk96hTns=;
        b=MCq9aNTHIyQ9U0UH2B1uGwzzSleAKLBtXyg0OOlZ6Yddvi0q9mg86OP4iUQ8YCYMjM
         C+8ML9MWdyvyv2DvEzzAllELMXhpY6ahniIYt+plFJOX8EPRVZoYFovldwRdZctpatUV
         onj7kCaPX4BeEi+zfPu4rv7BvrifRb3Sf9fEWatmq3SilEBZOHVwqFpECadSWlgl/dqa
         de3Ax2GHKGldIeQhGqWgkFlwz+6CcUjoYQEbtu4Ul2KSCqUy7PQeAwv1deRrFMsgLHJJ
         9StxCgArYuJhGqLLulN4+MRd4QqOZRRpLr06Xpn7LV/68nhpc1xzl2Jd/VJ2V8V+FLzw
         NRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387486; x=1711992286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KemhrkDHYlcMEokb2iN8+B7Ei5uaoqtFQJBk96hTns=;
        b=ZrI4GoiL9p14Gz/hauy88M9ZV+7DuW0bUAsPT3twtPGQewuRru8ReOnJqkVTR0XpLu
         IfmKCzhWQA24FimC765j769dV/jktaul3N0FfHfn2Z2gQs8NBKFUsCxVqwB+fk93t7lh
         ffpqw819OskWtiyf6tnBwSQa4ksLkZtCflLomXNvkR+3R1CvDV+cYk3skRZWRv/yuTic
         N8pC+k3ArDdq6AeaLg1gvcs+CME6seGPE3/MQ4kqSrz0WvyDdBRFTpKVIytd8DEFbpAd
         58Ckv4u1n8RdiqOzKDVfNlM9FAda97RZDkKZE7pXXzxwljVlCNf/EFI6DXjHU+Va0lfN
         XtUw==
X-Gm-Message-State: AOJu0Yxu8FPjAcrbGEhWNi55Jt0aF/V8CTj+crCU+m1RAAmFB+SZklht
	IysRYpB/azk7sKkgMZQHDnd2tp3QbshR3TfxUKxBo5p87VuIunAemfWMBvl6GlWcZwjVKQlieJW
	9bdo=
X-Google-Smtp-Source: AGHT+IHWTPDkgNz74uNjCH1a36FZVJpyp+k4PQY+Sb6LFZrJ+YS8IX8CaOdI1NPtAw8x4wLnY3EvmA==
X-Received: by 2002:a05:6214:1cc2:b0:690:b9a7:b4fb with SMTP id g2-20020a0562141cc200b00690b9a7b4fbmr7297355qvd.60.1711387485868;
        Mon, 25 Mar 2024 10:24:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q7-20020ad45ca7000000b006961c9a2ed8sm4286551qvh.47.2024.03.25.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:24:45 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:24:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/11] midx-write.c: factor out common want_included_pack()
 routine
Message-ID: <5475b09a7afc4d55a8e1a1a72f20fa9109447cec.1711387439.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1711387439.git.me@ttaylorr.com>

When performing a 'git multi-pack-index repack', the MIDX machinery
tries to aggregate MIDX'd packs together either to (a) fill the given
`--batch-size` argument, or (b) combine all packs together.

In either case (using the `midx-write.c::fill_included_packs_batch()` or
`midx-write.c::fill_included_packs_all()` function, respectively), we
evaluate whether or not we want to repack each MIDX'd pack, according to
whether or it is loadable, kept, cruft, or non-empty.

Between the two `fill_included_packs_` callers, they both care about the
same conditions, except for `fill_included_packs_batch()` which also
cares that the pack is non-empty.

We could extract two functions (say, `want_included_pack()` and a
`_nonempty()` variant), but this is not necessary. For the case in
`fill_included_packs_all()` which does not check the pack size, we add
all of the pack's objects assuming that the pack meets all other
criteria. But if the pack is empty in the first place, we add all of its
zero objects, so whether or not we "accept" or "reject" it in the first
place is irrelevant.

This change improves the readability in both `fill_included_packs_`
functions.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 89e325d08e..2f0f5d133f 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1349,6 +1349,24 @@ static int compare_by_mtime(const void *a_, const void *b_)
 	return 0;
 }
 
+static int want_included_pack(struct repository *r,
+			      struct multi_pack_index *m,
+			      int pack_kept_objects,
+			      uint32_t pack_int_id)
+{
+	struct packed_git *p;
+	if (prepare_midx_pack(r, m, pack_int_id))
+		return 0;
+	p = m->packs[pack_int_id];
+	if (!pack_kept_objects && p->pack_keep)
+		return 0;
+	if (p->is_cruft)
+		return 0;
+	if (open_pack_index(p) || !p->num_objects)
+		return 0;
+	return 1;
+}
+
 static int fill_included_packs_all(struct repository *r,
 				   struct multi_pack_index *m,
 				   unsigned char *include_pack)
@@ -1359,11 +1377,7 @@ static int fill_included_packs_all(struct repository *r,
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
 	for (i = 0; i < m->num_packs; i++) {
-		if (prepare_midx_pack(r, m, i))
-			continue;
-		if (!pack_kept_objects && m->packs[i]->pack_keep)
-			continue;
-		if (m->packs[i]->is_cruft)
+		if (!want_included_pack(r, m, pack_kept_objects, i))
 			continue;
 
 		include_pack[i] = 1;
@@ -1410,13 +1424,7 @@ static int fill_included_packs_batch(struct repository *r,
 		struct packed_git *p = m->packs[pack_int_id];
 		size_t expected_size;
 
-		if (!p)
-			continue;
-		if (!pack_kept_objects && p->pack_keep)
-			continue;
-		if (p->is_cruft)
-			continue;
-		if (open_pack_index(p) || !p->num_objects)
+		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
 			continue;
 
 		expected_size = st_mult(p->pack_size,
-- 
2.44.0.290.g736be63234b

