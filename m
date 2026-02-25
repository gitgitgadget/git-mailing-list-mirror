Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B02BAF7
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978851; cv=none; b=excPnlaxzlEIb6xXhpy4SK/WxH2cAAlVKH0Lbu3m6bni//z+Vtu3r5cQuEfSWdwaoL1wdLQpJXh1Q7ROQ7AnzUcRjUTj0Ri2Q5CJaMjXTgo3WO3arjEU+2NziTJgRxSw0k2HY38lj5AgWQ9gVlcsNoYam2fhwAP4dd5MNKmN2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978851; c=relaxed/simple;
	bh=uRiaTdjrfnSAxesQJ1K3P2DjzQ90dMi25DigcQwOKrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4bziFMM2SfgCvE1K6qi+mLiubzqiF3jMGZPZ82fA8tcjhsMUqhaim3jMh23tcPaZGIb3oCTEBHVtGRZZxh0esPmr9xHS1XkVFs7Ia+1FVPLgEaJRMDjoPzXZL99Eq18ywsrjm/16TIVbE4gZ+QzRbQngQngHiHMGtk1Em8qHjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=KByebwm1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="KByebwm1"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899a917a4feso17771196d6.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978849; x=1772583649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uib9vKsIiwp/sfDN0kkoJHfJRexmVWd4InGX0A4D/3s=;
        b=KByebwm1tWDeV7t2IQoxWBf8qJbzmOenRb0OB7XZvnJCCp40HYeEPdFsy9IgGg89LC
         K7S0BRWBAC4sMnYK3+68Zzd4yB4BDfn4rrmlisjxlqR0dA0F6f6AKl+qlE/gosYkcL+0
         groz1KPk1UD6FxTKefaJigAeaKqIgko/Z90zytHPiCm9qphJQcIsgHu744uF8ad7iTij
         ZXDS2rpjfHXHb+PO7ZthIRmv4RRlkNAKf4GU0nsZC6qsWKJgzQZvBKyF7M8bdB6Z6lyq
         jj9DVGPHS0xVsV66w2wyyLPI8ikbxzgPspkYod73p6eut+kjLQa57X4ZyK8mKoGKuyIa
         oeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978849; x=1772583649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uib9vKsIiwp/sfDN0kkoJHfJRexmVWd4InGX0A4D/3s=;
        b=SddmXLU0goznQ8OhR7MftDYYPRivlUfx3iUR12zWFzS8/Ltb41OBoKH5nF+S+mLULb
         Z2aWe30V1eKPaOawKXr8626bE6710WJBf6j277LIcaImegjAiLNiZdqRCDhtriDgNaVM
         kJPm2NY2f5rsfuXEOvdicQ8DAfhFCRqXk8YgpOqm3N0jY7DuROXbxdzrx5LSDZ5xOAc+
         bks7Dm/8Af1nveRvepcrlZ4xTTcC2a7GuchKCYKEimmuqg/PdZq93VkdQV1H8XnnEDv/
         Izt1JtuF11VvONCGDUfXMMwoAb5jYOvdHYm0SDecEV373XZcO/w/ic299f8yhWhUV7vc
         OzLg==
X-Gm-Message-State: AOJu0YwfT1eOb+NriK87PfuhItUXC6vpHnqLQxBIt1QA0je55Aw9Cy5Q
	/vjCyuQLHSCWa24pCDs9g5rtAe5cYVbL5BiOhe7W5fyZLqdCxv5LsDsMG30DhZFLbupqvZWdlI4
	V7wa2IyQWwQ==
X-Gm-Gg: ATEYQzw/KxmcnLfqqVkZ5/Ock+ftf5zFTL1ECteP4l4PsgT6gGjBSnv+Vg/j9R6mrpk
	Soc5e6BpdfKpU46MGWPeUQolh1FYf+Yjpte03DeWkiCgNkLKNCK0jJFLufzI9nsOOZ4MxLJdOzB
	UfjyfRrVsg3CmterlrqLSj9husfj+8RzEqqmfMQ63uofJ4XWrRAl6iWqbqaGCvkNRnyCgFKLKoz
	Sl2CeTqAsmyswplz4vrIhfD1jyGFV9yULJVsMUhy9WH32Mrj1VSWQ5jnuCXg95BvTaRzacZcSSR
	oh4wQesKrqaBXTXlIuCbahe62r0qie/6whuanDmWG4SKlQqKmEQ0U2Z9dN1RAuIH2s7aJoKzMJk
	48tG3+/2VaK2npCXVQq5vN3g0tQECzVoLQP4KLUvrIB8W9g0Lx3DtgoYVQgPDyWKLZ5kfhtfkgi
	d+0wgA1tnvUHwxgxleaq1sV0HL5vsRX3/GKk8tEVpC8PC4c7CvDLViLNX2JTRGAa+6rhPvRCCp9
	3jZEx58EXEkiiFIUEBEV2GwQmlWjA==
X-Received: by 2002:a05:6214:5095:b0:894:7405:d36d with SMTP id 6a1803df08f44-899b8c2c484mr6183446d6.51.1771978848682;
        Tue, 24 Feb 2026 16:20:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c8b52bdsm110401696d6.22.2026.02.24.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:20:48 -0800 (PST)
Date: Tue, 24 Feb 2026 19:20:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 06/14] repack: track the ODB source via existing_packs
Message-ID: <df37959d2933d84ec61b9ba570c87f9e5213c735.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

Store the ODB source in the `existing_packs` struct and use that in
place of the raw `repo->objects->sources` access within `cmd_repack()`.

The source used is still assigned from the first source in the list, so
there are no functional changes in this commit. The changes instead
serve two purposes (one immediate, one not):

 - The incremental MIDX-based repacking machinery will need to know what
   source is being used to read the existing MIDX/chain from that source
   (should one exist).

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
2.53.0.185.g29bc4dff628

