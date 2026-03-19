Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB83ACA79
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959060; cv=none; b=iFx6FmkYXtigUJAVikll/7kSaQMvY7hL4te5W2bTFnttsLln5UInCZZo351SnHHWVZRpF9DzN6KdUjPqjs46y21nhVBAdA40LEvhx66sjaWpzshSyqMHsjQfKnz4SgbgKjV4RpX2u0ylrAHkzy8LpfZpul30OHMobNQFsVph+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959060; c=relaxed/simple;
	bh=ivrXu0qOqqorcpiTVmE9Ltkdz917BDUN+VKfUbQd3K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJ1nkF7rlh/XXXu4Ac0Y9eevEP+nhBLtU2B8DAvlHnezmMSipSHyOQjyHZ6AS4mdg+/u0hHMgVoo4eLfTyrMd5J5TowEur0b5+KA2hm8wlvDGjOIAoNc0MWE/Vjrk7sr6xtelhCVlf3uYYU5u70cXCFoJzkL5xlvqr3VLQ2b+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Ll4tysMX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Ll4tysMX"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79860421382so10771367b3.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773959057; x=1774563857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsFchZqzRmkfWd0CZ35dHnmkBsD5/DfX4k19T+yHAFE=;
        b=Ll4tysMXiJHcKhmnxdrCEpReZqF3/IwxNX/+7hY9XXARdWfxGQQaky++VOU2MqG3E5
         2LbOzh2SnGKXN5dwiCsV1NrpnwvL+zjH97sX/ruTfoTrm3n0mG1uy6LeC0OrXnKZGGnC
         OIs6dnJyCBF+61QmXPuIufp8vD0d3Q15k6/3I0maJCOr1ar7XDl3PRjaI59NXihEYqRr
         4NB+Xgsq03M2hUEbtfQ28JEPm+JK9e63Op9rjXFskhlvG9WqD8OT+7lGlpL8vGlaruSB
         RotS7S7KCV1B3cuYWJc9c4UXvuj6CQQ51w0ySkdzz0TTtGYPNnGfI4/HhfMYBFXm2/Vq
         4vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773959057; x=1774563857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsFchZqzRmkfWd0CZ35dHnmkBsD5/DfX4k19T+yHAFE=;
        b=ZdnaOtdzJAIypdaFXFUo23pVEgjPrfRTHNDla5V7XlArVG4dno2CAYH3Zz/OYuf9qc
         2ELYNihMVDaDt/VK12GZlSBL5wdWhQE1GhDML0KhDOkdn0B9bWkDTjLoXWBTe7oGTOKj
         kA7donRyigs40DSDssnb7x4nuGlGAq4U713Gyhg/utT5tF5PXYHz2HTmoJ5UKLp8e8Au
         LO2JOP+jOY7akzhn8b7A7maEdSH8aQamp62+icvfTM/3Y9cTGnV9cbCubX9Liqps10l6
         q5jUDLk88fiQ98dY4qhCLIBJuC76YllmIoo0Rk/rBFW8SbqtH2J39UspLMRTcRQ62DlL
         SgtA==
X-Gm-Message-State: AOJu0YzOR6f5+Xu+a0ZaWJuKgP3vLoZNF9+SAdOGEAVne6gP0jk1Ny1Q
	Dq7Yy/88kC4RhMIyRaaciAlSealUOB/ANlqrWxYl/GZw9N5rFALLz3LQr2B+fg2Xe4D47y5f+eQ
	cnluI+6o9Xw==
X-Gm-Gg: ATEYQzwjF1nvqS3MeVsTe3XDr6+4OTQCdX+dLxm+00foysVTd7VYTuGyZwiiBfXSrPF
	37TrjRzAQNdc3VJBsNY7ARfRbg1VRCwZX4V/JrFCM0zJngnSGOQO7tMOzRrTFuV1LN1VKE9brLW
	gHTi4GktJmVF6tNcouRPUncpJk3DhEuys7gYhJH7bZAj6o5bLO7DIZyz/umcQRO521REmxF//mr
	WcydGsANwbC6HacGMbDx6pqLkw396sCjZuHEvfklUoNieWpSi4Pwg66cxZUBevjqyJIt7hZc8lV
	GAWmJUQ89R9A+uwR2VoMu60HYyhepCzBwCY9uzLX+sl/k8Tc0l6+2pajYfEXDAtN2O/vUiyw00g
	H3dwLS4/FAFNFSFJ00pbWPdjaTcON3lCy6Ky3Xfb55GVVqXihjWJKFxCDoEB+GAQU7YDapQ0JJR
	bklRflE5n+/NvsEpdZhxxyIWeLmwAprlzWU01PFhc8SMvs0/jDbe4VblxMoJTUam0Sk9/gMGeiw
	M23mJ/OTJV+yxHp1dVaUt5ViUksuw==
X-Received: by 2002:a05:690c:9204:b0:79a:52d8:fe5a with SMTP id 00721157ae682-79a90beff50mr7042127b3.42.1773959056619;
        Thu, 19 Mar 2026 15:24:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a90554a03sm5176737b3.23.2026.03.19.15.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:24:16 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:24:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/5] pack-objects: plug leak in `read_stdin_packs()`
Message-ID: <1dac74f1e4a370097117754a6b1fbb6fa2b382a6.1773959041.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1773959041.git.me@ttaylorr.com>

The `read_stdin_packs()` function added originally via 339bce27f4f
(builtin/pack-objects.c: add '--stdin-packs' option, 2021-02-22)
declares a `rev_info` struct but neglects to call `release_revisions()`
on it before returning, creating a leak.

The related change in 97ec43247c0 (pack-objects: declare 'rev_info' for
'--stdin-packs' earlier, 2025-06-23) carried forward this oversight and
did not address it.

Ensure that we call `release_revisions()` appropriately to prevent a
leak from this function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cd013c0b68a..9a89bc5c4c9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3968,6 +3968,8 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 			     show_object_pack_hint,
 			     &mode);
 
+	release_revisions(&revs);
+
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
 			   stdin_packs_found_nr);
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
-- 
2.53.0.614.gc4fd52e751a

