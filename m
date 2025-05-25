Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AC25DCE0
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748198521; cv=none; b=Wkqc5GDNHQjZzwryKrnFoE2obuNXBZtNBYCjJr8ud3wjPzO5KBFoDDvL8eEV3lpKjGE3kxxdp6eNxKBGWQ2ucWFUJZ+A8vtmnepN9nW8KBKvR0DBO2NBabuYvBlqL3UX3XhJww7qloFRhjLMUQcSARjixSbDT0hPEWmj23Mtyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748198521; c=relaxed/simple;
	bh=k1nrQCMTiomze3XVHEW1fZAjg+thVCcnv27tQKwbCpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4DDMHZyMRHTLygHnFcFA2B7XnwdJEkrbBiZQbe57CzQ65oD30uaOMtu7dhZRD1O+NIDBZu/Axvg6nGWJDHcdnxBzRENQfYGKg29o38SyEt7lkAzaUIHxWUwvkf4W5UkqDk7Dn8OrUeIpx4Nf4MxmjISV2QWKiVjesU11Z9IkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lw2J77OZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lw2J77OZ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso13005056d6.2
        for <git@vger.kernel.org>; Sun, 25 May 2025 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748198519; x=1748803319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1WkEN7jHMdrYdY8gqeooSQiVfgL7lpNsqPZTNtEsMo=;
        b=lw2J77OZKssMY1xjcEjqF489MQg70EcRYnVDFwOk03H0YCSzz36ParLGsJV9u+Q4E4
         31fbq0+uGlCa3tR47KuzcF3UjM4yAg9e0JxmByYEnGYOCH2MQL7gZjrnkZTEIgzXwqee
         3zqEuIf9Kg8fq9kGXyyk4uW/ZU0Nls4reYxh+rilPigLpQ61Fsj4E05h4OUsX4iWhaGi
         KnPCS7AT00sa2dcQCSa2xr+CaRKjjMMhcJY8Zp8JfDmNpzGFOQz1Ixqvr1fzliirW4e+
         4WG55CQBgPpXiIwxz+zLZQI9cpAV5I/Vv2nPhg5Y462Z6oURdb3dmuFCPHjEch+VepqB
         rutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748198519; x=1748803319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1WkEN7jHMdrYdY8gqeooSQiVfgL7lpNsqPZTNtEsMo=;
        b=fh+VzDtreMzBkb/i7maB39M46oEwjQ4bmEewEE2n3zSTIhjwTKgLheufDwWxiWmEVA
         69tCgNjAH3wRVgTMJwcdy+SPphd7uAyE6pmEFtfRMvfuNqa9W9el3IlUeVHLBcg/t5Kx
         8nZ+UMvC+0LoQzsU56SPyLueVE4F2Wg7QrTYNY4Mm+VqT12p+wERezHqdlZdK6N4T5Gq
         mzjyeAUEBZsPjBeB+wgX1rNGoj5rpGk0lMKlPKImhTkoZsa0TibJKWneSZUpT9SFl7JJ
         aN60/DBEG5KZ6J4WqOHT3IIwofMXA+kukz14mNTZLpvQ/a0x52VuwzjjkMQh7pDmt5L8
         GJKA==
X-Gm-Message-State: AOJu0Ywha0Dq6+/qZmbN/s8f0Ypon5Eah2rGo6Rjm7QJGueZH+OegaLJ
	HvXkCoxlgpz9SEv4v1F+UqEWc1SRKjJQlQmn94cFJrjqTv0z7JyDmo5aXNi1ooOxvE1Uf+6D6Hj
	5mNfG
X-Gm-Gg: ASbGnctw7LNSo9xSuEc3fmwg/BimB77ndHlX/OqHxO9/Amu51o8l4CdT95LKKKWLaGm
	LL+nxSjuEbaf5LRcbOiMEgnTAs1RhoSCGgV4cMPbvL16yLzTLW427AOW91hhtRxKoMiOtm9MArF
	r87Zv/Z/mpLEmMqTQxWNRcXEwDA127CBS2asoiBC2uHxJRtsy+O3fp0vzfSNpYpJ+Bi8qX8iHSE
	8WfvFuVO1gB7De8mSOQSZFOveKyijqSVEhHsc8+MdY5sHvlgmQ+b+SC1HqqhDDRlMJqT2TwUp/K
	4VDPDPPVU46GDwjpKn53ZvaO8eFzCV614huhW1rEtIQM6+Li6QtjtXN163doDaFQT94Uya6p9x+
	RdMulG9Q+kkmlRv3Ua9lhppQ=
X-Google-Smtp-Source: AGHT+IHpceul+9rDA2I8M0I3NI+gC1olFxD+BlOFfmzO7rtk9w4cg0EtgYHZk0oKxCYir7GiUzcDjA==
X-Received: by 2002:a05:6214:c6f:b0:6f5:4711:289b with SMTP id 6a1803df08f44-6fa9d2be0famr133934066d6.38.1748198518895;
        Sun, 25 May 2025 11:41:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fa9be9af56sm29986156d6.108.2025.05.25.11.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:41:58 -0700 (PDT)
Date: Sun, 25 May 2025 14:41:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] midx-write.c: simplify fill_packs_from_midx()
Message-ID: <5d97b706e17117217bf6e90e5cbca9e6e408c5b4.1748198489.git.me@ttaylorr.com>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748198489.git.me@ttaylorr.com>

When enumerating packs within fill_packs_from_midx(), we open the pack's
index iff we are either writing a reverse index, have a preferred pack
(by name) or both.

Let's simplify this into a single case by setting the
MIDX_WRITE_REV_INDEX flag bit when we have a preferred_pack_name. This
is a little bit of a shortcut to reduce the line length in the loop
below. But it sets us up nicely to extract the inner loop of this
function out into its own function, where we will no longer have to pass
the preferred_pack_name.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index e4a3830d45..7802a4b694 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -943,6 +943,19 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 {
 	struct multi_pack_index *m;
 
+	if (preferred_pack_name) {
+		/*
+		 * If a preferred pack is specified, need to have
+		 * packed_git's loaded to ensure the chosen preferred
+		 * pack has a non-zero object count.
+		 *
+		 * Trick ourselves into thinking that we're writing a
+		 * reverse index in this case in order to open up the
+		 * pack index file.
+		 */
+		flags |= MIDX_WRITE_REV_INDEX;
+	}
+
 	for (m = ctx->m; m; m = m->base_midx) {
 		uint32_t i;
 
@@ -953,13 +966,8 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 			 * If generating a reverse index, need to have
 			 * packed_git's loaded to compare their
 			 * mtimes and object count.
-			 *
-			 * If a preferred pack is specified, need to
-			 * have packed_git's loaded to ensure the chosen
-			 * preferred pack has a non-zero object count.
 			 */
-			if (flags & MIDX_WRITE_REV_INDEX ||
-			    preferred_pack_name) {
+			if (flags & MIDX_WRITE_REV_INDEX) {
 				if (prepare_midx_pack(ctx->repo, m,
 						      m->num_packs_in_base + i)) {
 					error(_("could not load pack"));
-- 
2.49.0.641.gb9c9c4c3bd

