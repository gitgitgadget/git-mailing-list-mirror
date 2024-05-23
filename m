Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0781B7FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482287; cv=none; b=UVQJUE0GSkcZFvnvnIhNWLysEDdgGvWFTugr0echIYow7hkVyOloAtrz25+z5MXEgrtaj9Kq2haab+Y+CKRVuR2ow8C6m3AWVzYMa2uRr0382ctW4sVXXSQJUBRggv6277yVIYFyk7C57dgHJqCq1Vxjk+32iwrzCTzSW9Nz7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482287; c=relaxed/simple;
	bh=HwtvqW7EpQf3K92TDX76FgVY+/5E30HaN6cm5OHlsl0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uooouXWW+lMbA7fGxjEUESypbBI78XsiM5NxezR+FRhX/SI1UKmLhnFWDOa7s3kKf1gS7Du+4OvOe9C6jBfz9trBTfMCPbyFFfXgLbgNo6oCE4SIXd6iM2C8hNlrzOIW6/ZX0Xwf1pS9QF2S5Ip5XFTOqMoTUD43g9idm36B5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Doos42h8; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Doos42h8"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c39cedc7bso2263761fac.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482285; x=1717087085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGLvESH22iwQ49ZcJDUaie53EKwSWaDoLHaSGMma2Sk=;
        b=Doos42h8pispxT43FSEPRe/uwvRUSoJL1TljGOS39aa2oDWJtx8uDKZykO0zB/b7+R
         /IaBBzfyX1gkTdOMt9ko5KErlIU63cxuxkcgkyJW0o3acCXff7ydaiXArU+RmSmmSZNB
         SXIvfWZeZiHdCqmAz0Jy7kdrArkPa0wjlEPwmuK511Mj4ommMOnJATtgElFk381Zm68k
         0/EHp0RN9IJQQNN80u/pXzg5+nXYxK5Vq8T9INpgtIBpYkYXr6XvikDW4ZcLZiyZgNkt
         HaxebHK3nhRkyue9RMjncmQRV2smb3DzrtDGIbNE99zEeV4+8PMndXHVStF6Qhgh5Atc
         1UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482285; x=1717087085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGLvESH22iwQ49ZcJDUaie53EKwSWaDoLHaSGMma2Sk=;
        b=dZQ9mSmRrZoRkhEcz9HwKvPV9Wmd3oiw+WGdWqjadJL0eWyLLUy/2srcOwIYgym7J1
         rvUkeyDedDru2fxfn3bbS5IvP+V/RtOzvyDTRlVyUwDSnRLlgDaiTFkxDB/Cbc1bEbf7
         oRJ7gObWgAAgJly+bSqHzuORoQ4t+sDbVCdxVQR5wFG8gGA4gNYrUnk+uInAoW2C0iJ0
         MJWM580vepkhLF3k562gtt1CEN9q0SPAY8g6oP3GMBCsqa4Wf7DFAGmMd468NEYg8qan
         TR9Tw88z0WzgzpS2M8tiiPWXl62agrFMg5WPkM3APP0oIf3oyZFSmgF1IFNATLMxg3Lq
         JxjQ==
X-Gm-Message-State: AOJu0Yznl2FQa51R6vUZ0y+d1ndQqAJd18xxi541WO4Dh73b0nb9JSaF
	OFaIpnIG8uX5lpMHd2RZPSjBFpDvDc+724kJNWtsdN8JAnUw+WblrRL9q5jC4eN2b/e1zMU9U6n
	x
X-Google-Smtp-Source: AGHT+IHc5ZPMY07sT4HU8lXtTsUUkBnNHMN43xNmvBRZbnYlT3q6i9StH5Rl/LvOhVBunIW6h/EayA==
X-Received: by 2002:a05:6870:a507:b0:245:40dd:8292 with SMTP id 586e51a60fabf-24c68bc9036mr5949438fac.33.1716482284868;
        Thu, 23 May 2024 09:38:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e137a737asm149301961cf.4.2024.05.23.09.38.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:04 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 1/8] midx-write.c: tolerate `--preferred-pack` without bitmaps
Message-ID: <c753bc379b005ecaf131f8f1ae9c5b80b2712759.1716482279.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716482279.git.me@ttaylorr.com>

When passing a preferred pack to the MIDX write machinery, we ensure
that the given preferred pack is non-empty since 5d3cd09a808 (midx:
reject empty `--preferred-pack`'s, 2021-08-31).

However packs are only loaded (via `write_midx_internal()`, though a
subsequent patch will refactor this code out to its own function) when
the `MIDX_WRITE_REV_INDEX` flag is set.

So if a caller runs:

    $ git multi-pack-index write --preferred-pack=...

with both (a) an existing MIDX, and (b) specifies a pack from that MIDX
as the preferred one, without passing `--bitmap`, then the check added
in 5d3cd09a808 will result in a segfault.

Note that packs loaded from disk which don't appear in an existing MIDX
do not trigger this issue, as those packs are loaded unconditionally. We
conditionally load packs from a MIDX since we tolerate MIDXs whose
packs do not resolve (i.e., via the MIDX write after removing
unreferenced packs via 'git multi-pack-index expire').

In practice, this isn't possible to trigger when running `git
multi-pack-index write` from via `git repack`, as the latter always
passes `--stdin-packs`, which prevents us from loading an existing MIDX,
as it forces all packs to be read from disk.

But a future commit in this series will change that behavior to
unconditionally load an existing MIDX, even with `--stdin-packs`, making
this behavior trigger-able from 'repack' much more easily.

Prevent this from being an issue by removing the segfault altogether by
calling `prepare_midx_pack()` on packs loaded from an existing MIDX when
either the `MIDX_WRITE_REV_INDEX` flag is set *or* we specified a
`--preferred-pack`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                |  8 +++++++-
 t/t5319-multi-pack-index.sh | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 9d096d5a28..03e95ae821 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -930,11 +930,17 @@ static int write_midx_internal(const char *object_dir,
 		for (i = 0; i < ctx.m->num_packs; i++) {
 			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
 
-			if (flags & MIDX_WRITE_REV_INDEX) {
+			if (flags & MIDX_WRITE_REV_INDEX ||
+			    preferred_pack_name) {
 				/*
 				 * If generating a reverse index, need to have
 				 * packed_git's loaded to compare their
 				 * mtimes and object count.
+				 *
+				 * If a preferred pack is specified,
+				 * need to have packed_git's loaded to
+				 * ensure the chosen preferred pack has
+				 * a non-zero object count.
 				 */
 				if (prepare_midx_pack(the_repository, ctx.m, i)) {
 					error(_("could not load pack"));
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index dd09134db0..10d2a6bf92 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -350,6 +350,29 @@ test_expect_success 'preferred packs must be non-empty' '
 	)
 '
 
+test_expect_success 'preferred pack from existing MIDX without bitmaps' '
+	git init preferred-without-bitmaps &&
+	(
+		cd preferred-without-bitmaps &&
+
+		test_commit one &&
+		pack="$(git pack-objects --all $objdir/pack/pack </dev/null)" &&
+
+		git multi-pack-index write &&
+
+		# make another pack so that the subsequent MIDX write
+		# has something to do
+		test_commit two &&
+		git repack -d &&
+
+		# write a new MIDX without bitmaps reusing the singular
+		# pack from the existing MIDX as the preferred pack in
+		# the new MIDX
+		git multi-pack-index write --preferred-pack=pack-$pack.pack
+	)
+
+'
+
 test_expect_success 'verify multi-pack-index success' '
 	git multi-pack-index verify --object-dir=$objdir
 '
-- 
2.45.1.217.g9bb58e2bf5a.dirty

