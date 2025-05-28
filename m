Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6873221FB5
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473147; cv=none; b=eoXDJaPGS8JGmLDH3IFIlUoc9+SxgIaxk5R/HM73v6NsZ1SfkwnvlJn0BiMj30Cd3h0fL8L5d/gxHvzzvseAVAnywEDJ+esRG1NF5q5NYAB2+H51ItDMDl94m0+aeRX1pTbZ4Yf4BsSV08dACaCF0bjrWT2CUvNCfYxBWrMdc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473147; c=relaxed/simple;
	bh=XGfruEAPxh2dUz7hWQ0yzN7yrFX0AXqOw4IfY9X8jAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR9VUwAQoD+Hfkh8kEBY0rls1xEhab+fMcxO39KZXSsGHTtGC+GXj6w2I2Kj+nQZ+UyLvkYEwbHPMqK/JrVJL7kO3tKfv7jQ6z2hZia4S494GVvTwf4CzmlMy/1wJ2CB++kPqnZSZu0R9XRFulHQmdeLzpgfz5WcmtBHG7tuAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xmdOgmk3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xmdOgmk3"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70df67e1b17so3892707b3.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748473144; x=1749077944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJFVos9EcF1KXE4mBy08pfij/bf6lS6FXp3Z9QfcygY=;
        b=xmdOgmk3dFWcV0dakXZqd6NMVQ/1SUAsLYi7jsLRS3qU1+ycEp6xwxnJYuQ+vgryJj
         f9E0kjhMPC29BA6HN7kq9z66Nqkp9XI/06KoLJSRZJoARIoSdkbWrOUu08YjrnDdfPe3
         1VW1LJ9cvKn/aJ3iEqesPlE6NB5NO6i4unRbqBtNmoNO0Dqffyzjx8LfTi71KlMfnCZu
         WjeR+QucCDhsCjX4el5rWy6OsEsXc8LVbeB4IEcGL6KIpsO2dz6cWRU0BHtutJTWu7l4
         2C9Yf9kJ76m28Mwr//mpMZhIlYxmAnLkFs3DiF/lIA/DjwtvdS23L7JP6aBu57DAu77r
         DoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473144; x=1749077944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJFVos9EcF1KXE4mBy08pfij/bf6lS6FXp3Z9QfcygY=;
        b=M6D6bdQ1nvwPctt0ief3N3n9xVqmegFJ7eHRidWMq+DCY4yqqVWWjL5yq1tDRhnU/K
         2NmyQSXk90R+mF6t3cI9wDoQfwDLcEs0nEOc/K9RxVx6t26Vo116KFg4aTQ4e/SsrnWj
         f9x/8qa0JFRWfXhs2A3Jfh178t5WChzRfjOXP/Qa5Pu5P3izrX38pSI6OFgV4P5IsyFO
         SbU01DgMvfmGkUHkr6FyY5vjNME6er3hOgivElVeQhxr0/98h/6p1kkickGf+JPrIww6
         IY+UP2SUk50zt+8qO+BQgiqfjCVuWR41Kn0mfcxwuTXrOgOmohDwTUslwkFJv2uTAzVM
         6CgQ==
X-Gm-Message-State: AOJu0YwT1g2BkarsS3tisUQ3oIOy/ef7rcAPcIjdzAuTorFK1wGIl4BM
	KVZ977shB1AokvsrSNI/CjzqeKCKBJw2jL3ZLtgkTJCw4j2hoHc9gSegjnNfCifiKZGZSOh2klz
	BuGc7
X-Gm-Gg: ASbGncsTF/JDJO0hZF2UTGLaNlhl5zu8piKVSnd7m5WtUqecq2O13EN98k6uX8zzWNB
	yTsDDDXfN3oFjFieQzf0HcJpe8BFwRABedMrY9qnCrwoKBo0+cSipiu+WqjJ+xGSKRQj1SMBZJt
	s8oZnIp8QFRPBGQrZiQ4JCkK9wS3W3i8ks7Mk4dUu+hNJGtmCz6ckuYNAVgkxWGYnHkDgSiotbm
	vrF+HmnVKK5hF7BjH+JdNzyof+hVyLU6sWNFKm1pmHUJ5TvqTiaEjeotOddGeV1KLp8/ej6wXXJ
	PjGrfal+y8AUkvhPv85Bo9BMUkOYCDqv3wduLCjGK5XcgZ0/ILUMuR6kzOPlpjiUf/ZZE/5082x
	hei8MXdSabNxOJKQ7BkuxQ3I=
X-Google-Smtp-Source: AGHT+IGgEcCCvUJ5zrtra/Ukcr6Q9+5jYXtfX2KXd+iEV3ni2/z7dQrDHyUGKVnt3iNJxZJufGddHA==
X-Received: by 2002:a05:690c:3349:b0:708:c18d:e6ac with SMTP id 00721157ae682-70e2d9f421bmr261627267b3.18.1748473144562;
        Wed, 28 May 2025 15:59:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8abecfbesm318557b3.30.2025.05.28.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:59:04 -0700 (PDT)
Date: Wed, 28 May 2025 18:59:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] midx-write.c: guard against incremental MIDXs in
 want_included_pack()
Message-ID: <cf3ab81a0808ace5a7d81aab6227730fa899350f.1748473122.git.me@ttaylorr.com>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473122.git.me@ttaylorr.com>

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

So want_included_pack() is OK because it will never encounter a
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
2.49.0.640.ga4de40e6a8

