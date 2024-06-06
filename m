Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2A535C8
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715080; cv=none; b=um9HEJi56kbO2GOKIvq1tjuW3AGQOfTcS9U+/YJGjvjyUgAFPkV7qtqx7CV+kccWGDqEW6kq/S3ZCm9Nk5iUWNboIHy/iO3oy6Z7wNp7PZxG8bUMjlZwONAOUfn0mD1EvxXh8oP0oLXDM214zVlhJGmIX9oP0QyZwakmS68Bebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715080; c=relaxed/simple;
	bh=RTtUHAXSC8mQ4jyGxASvFVIMVDdYfXnvRpldziGkEyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umqUXrl3EnEV9yh46ST6mQu5ONza9x87DnX0AcGJlNE+edDttCHMvnFRdoZw0yCHxxUoWx4rAFWZiI9rQTOEs45nOWFDUhl6hR2cL+7XI2P8+7PEbJHJ+OYcJf3WuK7WnFG+O2TvnksrvSsC1y+AadsIT6/WFES6xjQfiWTm688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TVvNlCuh; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TVvNlCuh"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ae1059a62fso9007936d6.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715077; x=1718319877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jM7q6LAkUvM6xIF32lQYIHwQPR8+fYtMEGh/2AUB5Vg=;
        b=TVvNlCuhB+zimLfuQblgdl8ZnJD9CYFzphDGmskNi6HH6HGCnk/6edv7OXfM53g/eO
         vuPaNqXPVv+NLq6IC+sW+KDbROtLnqnNr6pPCXeqd/bi5zXoUNAurERi94tS+KtGZo3i
         XfwPTO7NZ5DvLgBLm+XLqhH8CDadzqhUFVbMInBF2Ml9yc150zrm31fSMCZhJiNxfXB2
         4ApVY0PQ/AEOxC5b96ehkYu/LjH7bMfRlxM50qAT+uC62A2rNOvVIFPO+3UrBkANM+IW
         E+sbjDBaKFL/dTLtktujbmk8dMe4ZwK4W00xB4tpcpe0AjlQv4lykuEhJyq5kbLdzXEz
         PHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715077; x=1718319877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM7q6LAkUvM6xIF32lQYIHwQPR8+fYtMEGh/2AUB5Vg=;
        b=L3aWY0nIlQnlPGZjmtDAMvzBI3BxlSaBdc4r2/bzxBgyBcXVct79765s344lSftuu7
         ph09YaoF/Q7r6jued9btRP5eCO1JxauQcEXMPcfLJxY0FFgBgjf7PGXSaGrlXljSJiVI
         Hs5nCoKfiqgKoqBt9Uqrv+T7vBrpRibU2c9SGugitYu0tBLrca2H+42Yr2MaPMf6pxMK
         M39LBDq+5eiEPMO6qDS1gnxyE2tgJm3kEIXfh1R9sRuzqUaD8cgPT0FiaO+eX3QhT5iC
         o6niUuE2KY7WiFqA91BxmnYcRB3FwvGnzJamNzP2rAZklXDkDyXO2a3SO14tfl0kU/sB
         GBLA==
X-Gm-Message-State: AOJu0YwRXb/rONaxoTU+SYzXJ/UslSKl3mmMEs5PX/HGnp5/JmUtxFMK
	fCnlju4KD0aX/aFJ5QtfgJGvfxzY8GE+sSDUR+KlfscDzcA5ruEeF6VcChpBuJLIEoJvKSNMCIt
	4v0o=
X-Google-Smtp-Source: AGHT+IEVvRN2jbFqLqg76rpn9ak97gAA7g/GHcSXhoEh9jq+G+p2f8vbaHe5FCDpPFwdBFobru618A==
X-Received: by 2002:a05:6214:5984:b0:6af:bffd:d1d9 with SMTP id 6a1803df08f44-6b059b3e4d0mr11811356d6.3.1717715077079;
        Thu, 06 Jun 2024 16:04:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f98499fsm10533556d6.80.2024.06.06.16.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:36 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/19] midx: teach `prepare_midx_pack()` about incremental
 MIDXs
Message-ID: <97661bb0de966354cc19d37c70d18f324d82f693.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

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
 midx.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index d5828b48fd..7fa3a1a7f8 100644
--- a/midx.c
+++ b/midx.c
@@ -257,20 +257,37 @@ static uint32_t midx_for_object(struct multi_pack_index **_m, uint32_t pos)
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
 
-	if (m->packs[pack_int_id])
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
+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+
+	if (m->packs[local_pack_int_id])
 		return 0;
 
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
-		    m->pack_names[pack_int_id]);
+		    m->pack_names[local_pack_int_id]);
 
 	p = add_packed_git(pack_name.buf, pack_name.len, m->local);
 	strbuf_release(&pack_name);
@@ -279,7 +296,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t
 		return 1;
 
 	p->multi_pack_index = 1;
-	m->packs[pack_int_id] = p;
+	m->packs[local_pack_int_id] = p;
 	install_packed_git(r, p);
 	list_add_tail(&p->mru, &r->objects->packed_git_mru);
 
-- 
2.45.2.437.gecb9450a0e

