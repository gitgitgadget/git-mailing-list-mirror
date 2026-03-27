Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541338E13B
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642007; cv=none; b=RceYrkB/paY3YIvr4TmseTYf9ereSO0GL537emDdW6MxGSfmIY/KB06YNjD1s6dOxjHiEfjA1CDplzbBlGjx/i9wSEhc2/N3Ab9JdWZD3F9/NshaZVMBNYeyS6hC4OmmyWDsZB0Gaa3BdsSRj2jnuqjNNqoDVvjZiWzQcpMiuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642007; c=relaxed/simple;
	bh=LTjF+1NsuywYMYUe/fIX93/YqqTqvcXtrKeYDIVwbJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh+6vAoZ0uXA8V7eLaCK2KOfCwZDBaFfxNPKpKhxA7bpPa9jXX7sU5CpODmxJ3OT2eXBTknBqaTTpH549R6YDCxIhZDGF4LCCVUDAFskYUapaJkU6Ya0t2VhwxaM+j/JR3a8ZdYSFzkoKocdH5uo/dLoqSRrYWLV4+AVA7jUZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hmFovGTV; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hmFovGTV"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64edb56b70cso2309011d50.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774642005; x=1775246805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2aHFE0jUuyw+SuHEKiSB6jetV+JZcBgqAVdI9o/vI8=;
        b=hmFovGTVrwXV8HVSW+/cP6Yymj9SiXs49Pol/TglU9gw3Yy6XEncC0JtEpYvEb1H82
         03E53V7GGFwJx5dIDN/jAtoLElreMpbROb10q7HVS2WDlO/GzXL3WKT6sUkXEHuMptQ/
         Aqok+l5L2llm3WyHSbCX5KvNmXPjZXU3xUOU+ZLW7w01+wWvBBVF92th4+mNpUtGy8ox
         VPWe5PMhu34VaMcpQTwbC8JRN6QX8/BpOFGsGulN/lua5uQB3stmSaaPmtBhinzKXp6L
         Ry8h19WiO/96K+UXgPbfV9stJ7mUE38aW/0Ehdy2Q3z/1r8UBISaTJ7jGkXu2DrHTeoa
         s3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642005; x=1775246805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2aHFE0jUuyw+SuHEKiSB6jetV+JZcBgqAVdI9o/vI8=;
        b=h9WRgkfWupZBM4aTDN8r+mZBk4muo1mB/C7ypBzHx+12gcJu4t8N9N4KmjJXdm3gxA
         sTacpLDhWPnM/HHyCyhpKWgAePz3KXHmliGg71LWZZnyZ86RbIuo/8EQfr1B4Dv5CVAc
         K63gx9xJRsLBZVo0dXKry0qz+1fowHLNcKOXAp0e4CIXCJ2XQYCEVyiHAITxJfyvGyik
         078Nha2ouqnDy53i7A8YxmpWhhtyAuHryUjcgpF5OSnLEgVFeu+jBhvJepJujMQjCCI7
         WRj5JOq8gV8dAF5q3lwx+qMNoiiM6PQ3j7XEpYTDMlmp2EwYU32GWctkGsgSNnIgIaYr
         Qu2g==
X-Gm-Message-State: AOJu0Yydond0LwgglJ1YLpnzc+aznCM2YQxtgth3HUNXz6P24ILSI6Rz
	vnVJ6/9/WfW3WpDGC28qF3xkEvMu6f/oeRik3HjF7+IkSnCxVcEaU+D4dk0/kmZQV+7TarqtEqo
	7s2LgLdJBoQ==
X-Gm-Gg: ATEYQzzWAliso1tm1q56OQ1frJY/yc3Rmm3orPeHW8rJ3X0L1OBBVPVpDoSW/bz+fy1
	sCxhe7TqS+GTiX0GpTJNrfMzMG+LrCg6gH5MCkBty+P/ON3b88DQtVSM57mEqKPTCkCipp0mBR8
	RKEm6DTQ5MRU77JvvXyyag5kXRa9WQj5B0ShB2rrgyg9ay6NosnUV9mIri3F2NN2Rir/Yq3Ps5v
	M8toAph093U8mMLXd1fuHRrfgfs7yIzUcGPBLFQzUFobI/SjD5PJQdBA2eAlGxxwA43clEX7yra
	KXo5MLAoLgSIkGlrq73ticCPaTsUOTn4I9mc9Qt+4DmHi8s5F60Nu3xUjF/ikMX2wfis6fkDiVb
	bfLPwHhrYn+sr9s/zaKDVZIFzHg3E27rMvkHaR02AmOHrFU46K5L7ms2evIObjx15OHLf8ZdCQ3
	gvzXTZxZaYkDDz4ik14vwVMWY0tkPUdJKzYOYQesaqUfSM4jkiDqLs07L8eYR7uuKpHUr7j4RfU
	f/i1hXXcyoa5/kJI6mcTse7D0yrRw==
X-Received: by 2002:a05:690e:484f:b0:64e:86c5:8da9 with SMTP id 956f58d0204a3-64ff71aea1cmr3113925d50.6.1774642004709;
        Fri, 27 Mar 2026 13:06:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ef6bdd449sm3292858d50.11.2026.03.27.13.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:06:44 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:06:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 1/5] pack-objects: plug leak in `read_stdin_packs()`
Message-ID: <d6ff4e801ab71732e45a645436ccd2cae2fa4d2d.1774641999.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774641999.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774641999.git.me@ttaylorr.com>

The `read_stdin_packs()` function added originally via 339bce27f4f
(builtin/pack-objects.c: add '--stdin-packs' option, 2021-02-22)
declares a `rev_info` struct but neglects to call `release_revisions()`
on it before returning, creating the potential for a leak.

The related change in 97ec43247c0 (pack-objects: declare 'rev_info' for
'--stdin-packs' earlier, 2025-06-23) carried forward this oversight and
did not address it.

Ensure that we call `release_revisions()` appropriately to prevent a
potential leak from this function. Note that in practice our `rev_info`
here does not have a present leak, hence t5331 passes cleanly before
this commit, even when built with SANITIZE=leak.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index da1087930cb..f640e556823 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3983,6 +3983,8 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 			     show_object_pack_hint,
 			     &mode);
 
+	release_revisions(&revs);
+
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
 			   stdin_packs_found_nr);
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
-- 
2.53.0.724.gb20b077944a

