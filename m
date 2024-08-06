Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F21799B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958645; cv=none; b=SLCXkqeabLp+ET9nyiPEJl+X/kzcUqly37NfUoYOux/Yomgz6BXDcvL+uk21/fS9uGN1HMCQBK9TS6cFISzgXlRo0d9xKx73Y+SiZfxDfnUIcRMuIgJ2g1y1AMHBdS7nbCUBwY+V4zfm45LplV+UUyI9gWo9KRYU/6dx7xS3yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958645; c=relaxed/simple;
	bh=5h2V6oQr4RtflglTo8kZZr5xy3UJTt9j6m7rESDDBio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+Virjqq92HMWE9YX+04EdytZ/yXwdM5TfFAVdFjmsZ806hZUGAZxw2rVMcWynVUIDBAVRiaeqN93sUE2QbdAKDG4ox2TqWAVInjWlO3tXbrJljNofCTfI4RW3yqdZfxiZx5oHgiZ3OL09gR4+JVGmoUDdPf+/mQ2mbgfgtaCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=sKJ6KtAu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sKJ6KtAu"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-66108213e88so7225327b3.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958643; x=1723563443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3J/MlDsCQ3mjy9gHP2REiPbO5oTcjMjayOcVr3EoWfY=;
        b=sKJ6KtAusAijF9fDDniEf3OqiOFxoFglBh9Uciz6MSuK/eudZQbluw8ICkvMA+Gs8+
         XbeQJjlbow9Ia/dvrdWo/f35B1i1Q5eqadBb8XUJ7v1EIPUctzkiJVRoDaSXwD1JcT4S
         jVsfec1Y0PrIHlSmaRUyNCCSRsuCBGreu7g0BpQwlJEkpDOUBGA+WKfKOh1XfmoMHABe
         cfJ5rRKEzT8MHmi1wFj6MKp4HpFFOSXEL/8oG3lPISvi3p5zsdvfGrwJprRQchubZrOT
         XhanTpsmJ25FaMB2wNa7ql3GJnml0uvRxyhRon6gGUkwdpHRLEUQYnLC/JZ7BmW7PhOW
         EnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958643; x=1723563443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J/MlDsCQ3mjy9gHP2REiPbO5oTcjMjayOcVr3EoWfY=;
        b=J13zaYN41zqmmexT4p7ZlqwPf5mO/lLa2pcy7nphoB9pQao+vjdC/MvetBnB003i/J
         CNpUJ1eqH5JmYI5GH+CAwpFVFoHB0EaS8gCwxPYL6V3XXGroIIz2Ra+QgWUAf1eM3S8R
         crzODi+X4kf6rLigNAWpfOQBuAU7FxAFlxesJ8HBA2FXhC7ey+72So9agMNGI2b4nzOs
         1TasZKNV/Am7RlwQDRBMZCQTGoa8FnPdj6S+YQpcu2c+imGvBwlHqws40POXRGUnm23D
         +rqPSrtPSU/vAzQKOiab0H1r73HxitShZnavkBlUi9+a8LEVcAe2Hhqbg5QSc4o6zx/6
         Tnqg==
X-Gm-Message-State: AOJu0YyV3n9wK+0Yvo+wPpJcOWZ+ovCO5qa/D+A8p/iM5OT2qsKdzgf7
	4PHuqQ2lBbqNufkuJUx9UnkB/Fm07ckZkckU7yYCblxweicUCj5BQ1jJ4w/wEAKaNrVwx7Ljp7v
	a
X-Google-Smtp-Source: AGHT+IFvdHIjp/lekRl0vW2m6YA7zanP9ZvqUSxnwweAHw4mSAXLZP9wewmInE4SvkJDs5FCHn/1bg==
X-Received: by 2002:a05:690c:b1a:b0:664:c24f:c248 with SMTP id 00721157ae682-696c48ea44amr30809357b3.32.1722958643141;
        Tue, 06 Aug 2024 08:37:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68d2a3e037esm11532217b3.4.2024.08.06.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:22 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/19] midx: teach `prepare_midx_pack()` about incremental
 MIDXs
Message-ID: <372104c73ded1dd7035b16f5aa48827560c4e064.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

The function `prepare_midx_pack()` is part of the midx.h API and
loads the pack identified by the MIDX-local 'pack_int_id'. This patch
prepares that function to be aware of an incremental MIDX world.

To do this, introduce the second of the two general purpose helpers
mentioned in the previous commit. This commit introduces
`midx_for_pack()`, which is the pack-specific analog of
`midx_for_object()`, and works in the same fashion.

Like `midx_for_object()`, this function chases down the '->base_midx'
field until it finds the MIDX layer within the chain that contains the
given pack.

Use this function within `prepare_midx_pack()` so that the `pack_int_id`
it expects is now relative to the entire MIDX chain, and that it
prepares the given pack in the appropriate MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index 39d358da20..07b3981a7a 100644
--- a/midx.c
+++ b/midx.c
@@ -259,14 +259,32 @@ static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t pos)
 	return pos - m->num_objects_in_base;
 }
 
-int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id)
+static uint32_t midx_for_pack(struct multi_pack_index **_m,
+			      uint32_t pack_int_id)
 {
-	struct strbuf pack_name = STRBUF_INIT;
-	struct packed_git *p;
+	struct multi_pack_index *m = *_m;
+	while (m && pack_int_id < m->num_packs_in_base)
+		m = m->base_midx;
 
-	if (pack_int_id >= m->num_packs)
+	if (!m)
+		BUG("NULL multi-pack-index for pack ID: %"PRIu32, pack_int_id);
+
+	if (pack_int_id >= m->num_packs + m->num_packs_in_base)
 		die(_("bad pack-int-id: %u (%u total packs)"),
-		    pack_int_id, m->num_packs);
+		    pack_int_id, m->num_packs + m->num_packs_in_base);
+
+	*_m = m;
+
+	return pack_int_id - m->num_packs_in_base;
+}
+
+int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
+		      uint32_t pack_int_id)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+	struct packed_git *p;
+
+	pack_int_id = midx_for_pack(&m, pack_int_id);
 
 	if (m->packs[pack_int_id])
 		return 0;
-- 
2.46.0.46.g406f326d27.dirty

