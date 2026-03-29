Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368A314B63
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820472; cv=none; b=Q/5AlGQg+xad22mv1k33aue7clc88WXW1DOfGUGJKf6t63pexSojv4cnM2WavMg3P6WnjQXoikD9JDuxNORnRxCH0V3/KCuSzs8Gg88Qhea3IdLSPoaGS8FEcbMHlZRv1wZ+ajBJskI5NrW1AuN8huaOMkcJWa640tIzvy1tzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820472; c=relaxed/simple;
	bh=XNtHu5FIXnYCDL4sPd+GCih496RtnywHCfsoVBolMwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hToz05qNEmc36xtINRiOyAwuNs0TUcKBt1PBWOvrGC1AUZKhPXOTV2Oc8mgdVqpe3WBg4SoDnA+cE4sgTEjjWAgnMGUrCnppI3ePs+5/U995c9JHLklpK5Xq3sv/xfeKKFuCjnCRox2KbHY1RZakzt8A6lWUfvmWUFVlDqiAqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LYB9gRcL; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LYB9gRcL"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64fc6b21789so3229825d50.3
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820469; x=1775425269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKwAVnhf7WiJql7HrpOcMhHEBNwOnVOeWi3hgqn8Gbw=;
        b=LYB9gRcLgQelAl+3G7focAhCR62mfupWHzMpRGcLKRI5KRt0sX4q+1MMr0oJjbaSES
         77dGLeHuEtAv48B4DSvCBhDt2/geawHlWsfccQDjt1dA+m2xR6ec5vS30gJZbEfSLUXW
         FdwoGAh6zanKI7LPal0w5M9r+1ILcbrPU9RFJWZ+jOSODIN/FkB8X7pU2Qumw1zSeBNM
         cDSm7dSQP4AlkJHgHPlRDTGUQR3u5iLCHLadQLsakmwH9Fz+xlm/B7zKjos8UZ4YZIXD
         S3f6wRRh0lLVKjAz6rRl83A0lB6L9vYztXnPHvdROIxMfE+RSVGdq2vwX3hJxkhbP4fx
         bUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820469; x=1775425269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKwAVnhf7WiJql7HrpOcMhHEBNwOnVOeWi3hgqn8Gbw=;
        b=BeM6x9x8rlA2jzftk+XogCmiKf+UHZA1HiQb2z3ui+xGhtB9kqadMHs03luz/R+ii1
         wQgF8ute16SNqCVg555lQkOcWksjg8et7KNX+YRVmBXvmrc1n7f8gcC7DChFzu5NxIO2
         QjgsU0eg3Nud3p8SQYi8W4ruS/oYdDg6A/2msMN9gfV+kk9TuK9iXYA1ZCSaTuGTwc3F
         U1fxu2wCYz0CB7Cd8iv9uih8ZY3y/vpN4Pugo4S44rm0+WK7anyCa7/FscR7LSpDD44f
         Dxe6ppFFCOgZy8YSNlbBxTVtmVP9Bs/uaMB2oJBZ3npDsKCZRINWqWPTdI37vUSmEOgN
         QDKw==
X-Gm-Message-State: AOJu0YyI26cTDfzT60dYMGVSieBTJNlQjQ/FafUqdQw6W1ZJksHwXK9i
	L7YYx5ghO33uCEE64WWdqZXEo226z1TABtlVwn3R4XwhKToUvNfT1Pf5Vi0QfWtLkD2rOQmoUVh
	BR4Ch0Fm7bg==
X-Gm-Gg: ATEYQzxYiZaiVBnrOcnJcteeWHqUBRL4PfgxextF7ElBwysBkTKDogcM6cSGlTVDVb1
	Yg3aHEddnAUhdX2UteLsijEtuGruFP2d6aTD7c9+uFVpxxxl/QDIGyfgxDQSxKlJXEBEE6u6f4D
	xoF3Gbe2TvYYtbKvCNPmGMsJVzF4fn9UUIjxSU9D92sQT6BA01dTGxjP0mfoiZ44mwJ6gfbwapo
	aVcIVa4XRJ5CLZLWGATRV+/Un6fVkWJgIZcmjugLwc7jQQ4LYMJW8N3hkstSrFEBihjVTLKc7TG
	0j5RRlaXIccsmeOOud0KrgnVf9bzga5XVDywgY/s0ruyP1W6cp8YiTOiyvAf7jLBaScXNzD72wM
	TpmXkWvIHeJV1QdUFQpedYAyy3w1Um59biT5h8HIXJ7NYZ2ANayI+E4GL1wOlRKVKJFGmMgHDDj
	hvmW5tvQhpDQTT0K/AF0xJclU708dUKcQF/RR4tlALuAtBAJU1OOXH+zx82eRy+oRuBb71URjkV
	3Gxmw3uUVaIgWBu1jcvbvafpyRXLQ==
X-Received: by 2002:a05:690c:c364:b0:79a:8a38:d13b with SMTP id 00721157ae682-79bde029a80mr85405287b3.40.1774820469451;
        Sun, 29 Mar 2026 14:41:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8daf5sm27041207b3.25.2026.03.29.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:09 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 07/16] repack: track the ODB source via existing_packs
Message-ID: <2d377f534071ad9def3fb4860b2581197d02726b.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

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
index f6bb04bef72..44a95b56f23 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -402,7 +402,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(repo->objects->sources))
+		if (!get_multi_pack_index(existing.source))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -549,8 +549,7 @@ int cmd_repack(int argc,
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
2.53.0.729.g817728289e1.dirty

