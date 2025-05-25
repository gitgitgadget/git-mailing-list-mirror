Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4825D21B
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748198518; cv=none; b=LJKRFScFYvVsSBDNECRRitV9xNLg+G71qppkLSU0w/cpSItXQYId9dODGHY/kvtvb3YpJS7pxIf5l5Uge8WTPQTgzSDjIU8k6Jhf2TkOqdqi4HQsnavMbLgS1WGDPnijt4e2OgRPQ6/c8u1D+Yb/KwhXLLSJm6Kzjoi0qeSSEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748198518; c=relaxed/simple;
	bh=ognoE6fV89ya7+DeELSVUvFH9pYxOJqpTvavT18SRdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4yEqkqG5Pau8YB+NQ5NH/OUDDm4GU1lwPmQmdfgwjolfkgadEQVm0d0uLUZwOuWFlmgRHM+mEzVVHQAiKjNlSXdHnltgtUaO5pEtzh59iuNCwjJevDHR2avsLQHwjaA3mf4b9IrJRRNpOcp8uHMHmaWibThYi7wR/s6/fV8KeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oc36oI7P; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oc36oI7P"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8d663fa22so22783976d6.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748198516; x=1748803316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NksZ8ftKzjSXE7nIll2GsfOOetNX3fFzDiFHTqSllIA=;
        b=oc36oI7P+5rV9/AKZkan93TQUVSV7ZFs+otvSWYJRgILx8/S839xlxcPrsSVNHf1oG
         BkLOmBD+BPfJHM+4XSE8JFfwmnD0tWMoRiNRqFQ+caeXsY7+DtuH4djsWjeuT1gKUu8y
         EDLqyKdmxyBVwCUeA1v41WYfBD4zMmP61mkN8BNWXGy5m134y01atLgRIBypeapfh/k3
         Es4uc5ZXY9z06pCTFXAPsOSx/lYtvB6GP3u2jfnDUMAPqR04tosZ+NYKh2grJuyCBOVV
         y37UNwmHI6OLQfF/CIC/ZWWnUHBlkidtBFzl4vwgn+0VvJXgoHl1P/AkhzDUDuN/OyIe
         /T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748198516; x=1748803316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NksZ8ftKzjSXE7nIll2GsfOOetNX3fFzDiFHTqSllIA=;
        b=Ru8VLwfVqNRAidI+JtkkaoaCD5HfDDomTXUOAmWHt3w9bf3yo89hQ1lEb9QvyI91cv
         LCwzDqHYQ5AMoYLkUbEfEGdCDz843GizabuugKohhFl31WgRUNZr8+ud7b409RqKdoKk
         4FPmZG3P7CbUrHs/gd5R5UGOgZ0wgqUa3ylhDS9gJG1NMLZDEd7o+TDRaruLHG1HaSzK
         lrCoZP1yvL9HeRRZDkOcnG2KfJ9glzAieZ3PC7ut3wqbEualXFQRhJT2YFjJSQ/egGCi
         pTRij6lMiK3MfJjcjnRZrf8S5uvZeF+utNSwFZQMgsQBf0Uq9gRMMePUXKuDHf/Y6SEc
         tBLQ==
X-Gm-Message-State: AOJu0YyNEanrJ9etqQcu9Fgc/9yGFJLoG8WTDHNIfHDKRrxaXZ/jxQvB
	9q+cem1NOYz4gQ1TPdqDleO7fFBchmohTt+0X/GYD/C3zi+YE3pBL5ah0r5JrUMxFNfTdZo0yBe
	Iqqok
X-Gm-Gg: ASbGncsXU8JePjrspEaCmI6y3iIde8WOkGBlP681lzXj5WDCjE6gGQAyUqV0i0zH+k0
	BwNMGSqCKoKew9M8zkHwJs7BxL5CbWPAYK2bqD8vMLS0NPPjPIiUFgBtd+hSbsD/3u1lMyzxRRe
	9wDKAtq1yV62l5dlPXP1tWO9fZmSjsfNQIWmWOnfCxFUONO3ZTCrmy9Sy9n26UN6jmabsMtpaDO
	KzUSdfVDTaemew9lhsSOb/UNt2lnop4TAAEyxk6bX2Mq2mFUWROvpPR+sc4jiLTqPxe3CrUD4/l
	DHJR5TO0eieFNlX+uvt6NEGhF2af8peU/GXiWdGnFxOtCBaHOqr0uY8l3ZMrNm4ieRure8gkri7
	vT4O6pn5xs4jQUoCFbXZ+6HT6E95tnIPUEw==
X-Google-Smtp-Source: AGHT+IFBAkX49+S5KOBabNTGANXSR8O37qEXB1RxNOkRbfdYIMyy20KLjP7MBbSQP5YWqHqAcdWNjg==
X-Received: by 2002:a05:6214:4c48:b0:6fa:a0ac:8d46 with SMTP id 6a1803df08f44-6faa0ac8e10mr68145666d6.2.1748198515800;
        Sun, 25 May 2025 11:41:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6faa0a801fbsm19720986d6.80.2025.05.25.11.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:41:55 -0700 (PDT)
Date: Sun, 25 May 2025 14:41:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] midx-write.c: guard against incremental MIDXs in
 want_included_pack()
Message-ID: <d2f9645aa15b58824531fe5d981d2a73372b9482.1748198489.git.me@ttaylorr.com>
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

The function want_included_pack() is used to determine whether or not a
the packfile corresponding to some given pack_int_id should be included
in a 'git multi-pack-index repack' operation.

This spot looks like it would be broken, particularly in:

    struct packed_git *p;
    if (prepare_midx_pack(r, m, pack_int_id))
        return 0;
    p = m->packs[pack_int_id];

, when pack_int_id is greater than m->num_pack_in_base (supposing that
m->num_packs_in_base is non-zero, or equivalently that m->base_midx is
non-NULL).

Suppose we have two MIDXs in an incremental MIDX chain, each having two
packs:

  - M0 = {packs: [P0, P1], base_midx: NULL}
  - M1 = {packs: [P2, P3], base_midx: M0}

noting that each pack is identified by its global pack_int_id within the
chain.

So if you do something like:

    want_included_pack(the_repository, M1, pack_kept_objects, 2);

that function will call prepare_midx_pack(), which is smart enough to
realize that the pack of interest is in the current layer (M1), and
knows how to adjust its global pack_int_id into an index into the
current layer's 'packs' array.

But the following line:

    p = m->packs[pack_int_id]; /* m is M1, pack_int_id is 2 */

looks broken, since each layer of the MIDX only maintains an array of
the packs stored within that layer, and 'm' wasn't adjusted back to
point at M1->base_midx (M0).

The right thing to do would be:

    struct packed_git *p;
    if (prepare_midx_pack(r, m, pack_int_id))
        return 0;

    /* open-code midx.c::midx_for_pack(), which is private */
    while (m && pack_int_id < m->num_packs_in_base)
        m = m->base_midx;

    if (!m)
        BUG("broken midx?");
    if (pack_int_id >= m->num_packs + m->num_packs_in_base)
        BUG("broken pack_int_id?");

    p = m->packs[pack_int_id - m->num_packs_in_base];

But that would be overkill, since this function never deals with
incremental MIDXs having more than one layer! To see why, observe that
want_included_pack() has two callers:

  - midx-write.c::fill_included_packs_all()
  - midx-write.c::fill_included_packs_batch()

and those functions' sole caller is in midx-write.c::midx_repack(),
which dispatches a call to one or the other depending on whether or not
the batch_size is non-zero.

And at the very top of midx_repack(), we have a guard against
non-trivial incremental MIDX chains:

    if (m->base_midx)
        die(_("cannot repack an incremental multi-pack-index"));

So want_included_pack() is OK becuase it will never encounter a
situation where it has to chase backwards through the '->base_midx'
pointer. But that is not immediately clear from reading the code, and is
too fragile for my comfort. Make this more clear by adding an ASSERT()
to the above effect.

Apply the same treatment to each of the fill_included_packs-related
functions as well, since those are deceptively OK by the same reasoning.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/midx-write.c b/midx-write.c
index dd3b3070e5..e4a3830d45 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1636,6 +1636,9 @@ static int want_included_pack(struct repository *r,
 			      uint32_t pack_int_id)
 {
 	struct packed_git *p;
+
+	ASSERT(m && !m->base_midx);
+
 	if (prepare_midx_pack(r, m, pack_int_id))
 		return 0;
 	p = m->packs[pack_int_id];
@@ -1655,6 +1658,8 @@ static void fill_included_packs_all(struct repository *r,
 	uint32_t i;
 	int pack_kept_objects = 0;
 
+	ASSERT(m && !m->base_midx);
+
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
 	for (i = 0; i < m->num_packs; i++) {
@@ -1675,6 +1680,8 @@ static void fill_included_packs_batch(struct repository *r,
 	struct repack_info *pack_info;
 	int pack_kept_objects = 0;
 
+	ASSERT(m && !m->base_midx);
+
 	CALLOC_ARRAY(pack_info, m->num_packs);
 
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
-- 
2.49.0.641.gb9c9c4c3bd

