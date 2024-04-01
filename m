Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60454BF7
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006209; cv=none; b=Od1mlA/d8dAHF+VZTjEH4hRk4ixgiS+wgLm0kx6UHtj00sQcDnqaNckNH/P46m0CaP7rSBMv3uYh3+BbiX3YsXo9Nb1FnF4Mbp0cmLP82cMr5DqNQhMJ42b+i8HhANqHUYfoAqEkcjBUJeEevX/+0cxXnzpgm/dGite4dqKyw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006209; c=relaxed/simple;
	bh=tsXqUT4Od414NUeh4egLw/rDXExBz50LrL0A8vM3ZAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgWIyWjqtmRp/5PThlomMC57hb0RZ64Xc0HT040egAwtvJNqjkpqPOWzcGxTWczcX1Yr2rkmwzdeV6tqk1uMguJy3paMttnArShMCqSnhBIEYyo7e3UXzZnwsbVyPMd3uSoudzWReRRTfR9vniM8tOqzBeg1mPXtviZv0AqBeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Rtupc7gz; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Rtupc7gz"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a52c5c96feso1638021eaf.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712006206; x=1712611006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqx8E+rnI+2lFpUJ5MY9BuZ8dh8SbM54x9Z3w+hv4LA=;
        b=Rtupc7gzUXZAfDJFkLJ/usIZgY4JCRoZqf5YldiTvtkmXzxBo+ny1nffLyIFaDGy/P
         ewoUcWTmy5WlAeR9THKKMSfBDIDf57Yz4KdZjzuRrk2kQ8zsSyNdT6fMgmPxSF5KbHBT
         aMaRxTiQzLzhu5QNo48lZFDbkZbuEThAqqr/7p8CcdpudsQfLgrb4/9EsGZhuGDQvHkS
         m3tscRz5tV948brslXeDtCJ8QxkZNTcndObWjhHyrY9xn0zGkG5ipVnoW6tQQ8r4v50r
         h0DCjElNZsoD6SA10dOFM/LWzJQzmhEe54300quEUniHMjeSWD1/gtTr923dErgIuInr
         vgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006206; x=1712611006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqx8E+rnI+2lFpUJ5MY9BuZ8dh8SbM54x9Z3w+hv4LA=;
        b=mF3tc3CMXND8KYMbwtfRji8oRkVIZtrnqRLR+xSdnmEKLvmoui/tNmOaaL5F+W73xu
         FPn33Dl/ntqwTmeftuNmi/7ASZmdqgtoldz6N9Pays7rdqQl91IQBiMd90r8lJESuhdu
         TiSiFcJ91TBUGwsRVYqHl0CciCNZBs9b+MNZkw/Pd6Nw0od3IJ6Fh2g6Tc0Ay15xwWVS
         Z7JfYc7DZVy/Wa89GlArvecNe09HsauLLVWlj2cPWsLSv5bmZb0htHVnuhnACSmMMJnG
         DotuIEd1f3QGZ/St6FccWuCdKjClA0xzXEiywy5CPbPcRtg25RZNzd1GdHUIp+i1j6NT
         4VCw==
X-Gm-Message-State: AOJu0Yw2TEoe7koM8NjqRqqXr3bJCicaZCQMLxoWr1/qgfUJgA3DQYuA
	CmX+zfMr9JMlDjNth6sbdwelMnvyOw3IFh4MOkobyesReBfkEooK9u6TSmwZcq/3ZoXUG+iWrBq
	IJEg=
X-Google-Smtp-Source: AGHT+IFTlzXM7h1BQmiFbaGhjrdjORR7RArtQcg355uR8ROvQHFkuY1TMTt7qdgj3Eqc+0UXP2QKKA==
X-Received: by 2002:a05:6871:a407:b0:221:3bb8:3e26 with SMTP id vz7-20020a056871a40700b002213bb83e26mr12207256oab.15.1712006206646;
        Mon, 01 Apr 2024 14:16:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ha13-20020a05622a2b0d00b00432b569506dsm4824068qtb.38.2024.04.01.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:16:46 -0700 (PDT)
Date: Mon, 1 Apr 2024 17:16:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 4/4] midx-write.c: use `--stdin-packs` when repacking
Message-ID: <b5d6ba5802aef6ddf1542f1b0efffe43c22436ba.1712006190.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
 <cover.1712006190.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1712006190.git.me@ttaylorr.com>

When constructing a new pack `git multi-pack-index repack` provides a
list of objects which is the union of objects in all MIDX'd packs which
were "included" in the repack.

Though correct, this typically yields a poorly structured pack, since
providing the objects list over stdin does not give pack-objects a
chance to discover the namehash values for each object, leading to
sub-optimal delta selection.

We can use `--stdin-packs` instead, which has a couple of benefits:

  - it does a supplemental walk over objects in the supplied list of
    packs to discover their namehash, leading to higher-quality delta
    selection

  - it requires us to list far less data over stdin; instead of listing
    each object in the resulting pack, we need only list the
    constituent packs from which those objects were selected in the MIDX

Of course, this comes at a slight cost: though we save time on listing
packs versus objects over stdin[^1] (around ~650 milliseconds), we add a
non-trivial amount of time walking over the given objects in order to
find better deltas.

In general, this is likely to more closely match the user's expectations
(i.e. that packs generated via `git multi-pack-index repack` are written
with high-quality deltas). But if not, we can always introduce a new
option in pack-objects to disable the supplemental object walk, which
would yield a pure CPU-time savings, at the cost of the on-disk size of
the resulting pack.

[^1]: In a patched version of Git that doesn't perform the supplemental
  object walk in `pack-objects --stdin-packs`, we save around ~650ms
  (from 5.968 to 5.325 seconds) when running `git multi-pack-index
  repack --batch-size=0` on git.git with all objects packed, and all
  packs in a MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 960cc46250..65e69d2de7 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1474,7 +1474,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
 	repo_config_get_bool(r, "repack.usedeltaislands", &use_delta_islands);
 
-	strvec_push(&cmd.args, "pack-objects");
+	strvec_pushl(&cmd.args, "pack-objects", "--stdin-packs", "--non-empty",
+		     NULL);
 
 	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);
 
@@ -1498,16 +1499,15 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	}
 
 	cmd_in = xfdopen(cmd.in, "w");
-
-	for (i = 0; i < m->num_objects; i++) {
-		struct object_id oid;
-		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
-
-		if (!include_pack[pack_int_id])
+	for (i = 0; i < m->num_packs; i++) {
+		struct packed_git *p = m->packs[i];
+		if (!p)
 			continue;
 
-		nth_midxed_object_oid(&oid, m, i);
-		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
+		if (include_pack[i])
+			fprintf(cmd_in, "%s\n", pack_basename(p));
+		else
+			fprintf(cmd_in, "^%s\n", pack_basename(p));
 	}
 	fclose(cmd_in);
 
-- 
2.44.0.330.g158d2a670b4
