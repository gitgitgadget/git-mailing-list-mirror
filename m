Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054633DDDB0
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803857; cv=none; b=goxZWgmP0QNjLGml2bEUqDEGCoR5nX50e10QtTOSKvpLnUknIsb12BI8ucerLPWZdBQNIae1vhpAULjajoFsYK2ekUqA8iRMp5TATFtg08RmOXzC1sGGo7j8LJqsV+JujOTzfoZ9DhglM78rxsfkeCNnnynnV83NY/gb7G9Euxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803857; c=relaxed/simple;
	bh=pYy/ZnEyDI9FlSE+8UM8XN4Rp0HtVUqHsNVp7LNq7Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1m5G3+ORaNFihgaYj6yO14rP0PSLR8Pk//nYm/UTukL4we2B0TSqXiemlegIdgfodccnVqsPipF+XRYNkvMw1nDQThn7JHylH3XFrtfWVS7c4f4ZYXBtutPVt+BPY+JuUyi56XJ9REcyia/kkBSMc32AXJcNyXC+0tqqRlyfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HNa0lx0s; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HNa0lx0s"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4648447e29bso1410718b6e.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803855; x=1777408655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7xxq7iYi9WGhdF0y+UzMYBD6vMlJoVHz0AVeVfDNiA=;
        b=HNa0lx0sUwuTCkBioyqr3oJ3b0gUR8+2PgqLGrlF8zcwrw3T90nFSRci9ewCjrSmz1
         aNVTTZazCVJcp1tCJpi3bVrPthOdACtChSJV4JEC6hhBvAEwd/s+4Ro1MCiDKEJPLm4R
         B1UaOPpiOS+7ngo41Xo01w6GSLq/qojhRvCwX38wt0t8b7Px637FKm+8GH7uobU6lfBK
         jg6HbSgnOxPLXZvhakxSEAPxr1zub4spdubEH6KGhmp1s832P0x6OvoeIHvchaoxqvlW
         pt4leRVa1OyrdFLWSpuPhVcvIb4kIPhZtGAPLjBaISbuuMzeDsAfFoOqHukPDAv2uixh
         Pmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803855; x=1777408655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7xxq7iYi9WGhdF0y+UzMYBD6vMlJoVHz0AVeVfDNiA=;
        b=p37u5cDDo6/a+0s1XycI+28L8lKGWJv4O3gKfxIF0EwVyWFJko7RThKrUPZEgMcQ98
         jIQPSdQrCaIjze+lV/6VuJNVAx6NrfHP8XI4kfovtcnpI+/aPzaIvA+3UlbjV1W86A6p
         c9BpF0UOt8P4ZHOVsikdk5xC2V2uRQIgvvhwO/ZjqtPayK+ovm/k4AH5TN9WlorslUg1
         AkAIdROJL+WL1CW9A+ka56kuI0Ez6vvwHsXRPTrJITXG22gobP8LkA6cQfkm3lqnY3xV
         tg+I3onKD85Oxoe2eY2eloINVg3hEqK5ciudjsQK1bV00a5D9cKJn+WVvxb959FecnFm
         KgCQ==
X-Gm-Message-State: AOJu0YzO6SYWlFNtkZkqbf9V5Sh/DqkRXDV4joLPD4RsY+81c0G48G3y
	8m6d0tDdfFQsVYNABvQR3ePAcs+942JSnnIonElsB0Sa0vA0eIUQahq5pLMrFCBJSQvX3/zwwa7
	dLZnohyE=
X-Gm-Gg: AeBDievdPlwhlGcq7sIqmNql/XZ1SYaBRSicYxSH33OJL5iXnfkS76kLcaErteEzu77
	Co1WRoWuqYiRnS7vCWqkhbSL2Kg9LwIvqiFi+DSYtmV+SA3xOwmSo9O3qmB8fjmVV4I4LJgCjhQ
	62ph2fWMXmkX7psri5C1gyy95RRhB4y3Ue6XU0icvqFoAdTB9HieZJAItQ31IJ6yQoEds9z6Mx7
	VPqD/bS5ufHUEt9Uz3XyhgUo7FlZ5N9CC2UKCnazBrxFEK4nKUfgTD4oM3IgWfqVRoF0fE1Q2Ro
	5KrJ9AoMRY8W73hlsyUToFVRnrATaHGeR8OgHNLnMvhQM+mm9Hkpd5kP+zFt3bnVAj+X3lmNQZs
	CcKQm+7/X/+srnj1IrRfu5D4oypEL4zHzxQjd0bKIYrssMfvpaU+1ovs6WFIn+A4T5aAb7NLEKp
	CR8O5ZvaIL02cto3AbSTT74l2DchceWNWyUHq+aIZ8q9JiLkc3ZNZil+U3xd9w1OpQzrja4Bf91
	x8jbPEr2LYcNdagFZNNhCmi5YWGN5MNO9CnRODdga1ybnoiBsSekKLImcTGLRw+gLM9xD5IwhuI
	9CwFUF/RjoLFLCkwXDipdyHk6SGvMscHTNojmA==
X-Received: by 2002:a05:6808:1305:b0:46e:df55:23fa with SMTP id 5614622812f47-4799c883e42mr10415399b6e.17.1776803854868;
        Tue, 21 Apr 2026 13:37:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479f4a284d8sm1387481b6e.15.2026.04.21.13.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:34 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 07/16] repack: track the ODB source via existing_packs
Message-ID: <92aba3d366f78fbc0f5a0928107ed8f5791fb58a.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

Store the ODB source in the `existing_packs` struct and use that in
place of the raw `repo->objects->sources` access within `cmd_repack()`.

The source used is still assigned from the first source in the list, so
there are no functional changes in this commit. The changes instead
serve two purposes (one immediate, one not):

 - The incremental MIDX-based repacking machinery will need to know what
   source is being used to read the existing MIDX/chain (should one
   exist).

 - In the future, if "git repack" is taught how to operate on other
   object sources, this field will serve as the authoritative value for
   that source.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 ++---
 repack.c         | 2 ++
 repack.h         | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4c5a82c2c8d..24be147d39a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -417,7 +417,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(repo->objects->sources))
+		if (!get_multi_pack_index(existing.source))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -564,8 +564,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(repo->objects->sources,
-				NULL, NULL, flags);
+		write_midx_file(existing.source, NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/repack.c b/repack.c
index 596841027af..2ee6b51420a 100644
--- a/repack.c
+++ b/repack.c
@@ -154,6 +154,8 @@ void existing_packs_collect(struct existing_packs *existing,
 			string_list_append(&existing->non_kept_packs, buf.buf);
 	}
 
+	existing->source = existing->repo->objects->sources;
+
 	string_list_sort(&existing->kept_packs);
 	string_list_sort(&existing->non_kept_packs);
 	string_list_sort(&existing->cruft_packs);
diff --git a/repack.h b/repack.h
index bc9f2e1a5de..c0e9f0ca647 100644
--- a/repack.h
+++ b/repack.h
@@ -56,6 +56,7 @@ struct packed_git;
 
 struct existing_packs {
 	struct repository *repo;
+	struct odb_source *source;
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
-- 
2.54.0.9.gb905fd5d0ae

